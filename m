Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A711FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 17:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbdFVRHL (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 13:07:11 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35410 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753604AbdFVRHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 13:07:09 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so3196703pgc.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UCbUXfDA6xCLD0nDt1mLo2lBNWnVfBjkLno1RXHlYng=;
        b=Ql+EPcml+ZcRQnL72KIr4K3PQbiq+aN4jDyh5mDxVV1yLTS1DLiIehkpnov69iUtE/
         egCuCc0kI9PRJXGqKKQpsII+MAegdc2PDop5psBTRTLFoQHT7+yyBOyVx5bl8DdGPFp5
         R3F0BxbXuOrcamBbd1jLYcYVVbktM9pYAgatDru4O949KOw7Cm67Ncux9KGtvx1JG5C3
         oy1/YIPdIhb5aCqpGtAMagDIb5ZDKXinB6wKLMyrr766SiC0RhBPDuWMdnW0B1vfRIR7
         UBKfsc7wlSNOleK6FWU/Khp+IC9uciRm0yMg2hv1WNiF495ybEN7/CfXINrvW7/S5UGR
         w/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UCbUXfDA6xCLD0nDt1mLo2lBNWnVfBjkLno1RXHlYng=;
        b=RUGwCNcDk71j6S4OugLU6kxIKCZ4H0yn44g7XOt9nqCCAcUIg70zVt198gtH59ykEr
         6sipbT24Y0XB3AiIvMEJYGE8wVvfTfD+gcEIaDQpHDvdujmi+6FtKC1ylABVT0LOq0eA
         ttbUeWfUp+poCArsliXZ8YP+RO2cLpd+Rqk7bBNlbL+oK9JAhrS8OHVFiLKlIfJm74XZ
         2B8k2FFuA3uZrzFSvYFA5isdI+O6V9nfgow1fAxlHX4ppBzPrJnzG5/T8U1grse8opwS
         CN3yrUnHTr8t3CSwNna08LEnHK0r99LaYP5wau/eruGegJKZyhW3y+jZhBmpo4dBrckT
         gqTg==
X-Gm-Message-State: AKS2vOwlignxFzIX31m5yNCJZiJfJKXbV9FbpXokBGzGB7ek7j/uCnP2
        lAKfmI3JmrxtVQ==
X-Received: by 10.99.103.4 with SMTP id b4mr3571887pgc.221.1498151228468;
        Thu, 22 Jun 2017 10:07:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id r5sm5428159pfe.94.2017.06.22.10.07.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 10:07:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 5/5] stash: implement builtin stash
References: <20170608005535.13080-1-joel@teichroeb.net>
        <20170608005535.13080-6-joel@teichroeb.net>
Date:   Thu, 22 Jun 2017 10:07:03 -0700
In-Reply-To: <20170608005535.13080-6-joel@teichroeb.net> (Joel Teichroeb's
        message of "Wed, 7 Jun 2017 17:55:35 -0700")
Message-ID: <xmqqk244kl3c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> +static int patch_working_tree(struct stash_info *info, const char *prefix,
> +		const char **argv)
> +{
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	size_t unused;
> +	const char *index_file = get_index_file();
> +
> +	argv_array_pushl(&args, "read-tree", "HEAD", NULL);
> +	argv_array_pushf(&args, "--index-output=%s", stash_index_path);
> +	cmd_read_tree(args.argc, args.argv, prefix);

I do not think if cmd_read_tree() is prepared to be called like
this, and even if it happens to be OK, I do not think we should rely
on it.  

In general, cmd_foo() that implements subcommand "foo" expects only
to be called from main(), and expects that the calling main() will
exit with its return status.  This has implications that you, who
abuse a cmd_foo() function as if it is a reusable helper function,
need to watch out for.  For example, cmd_foo() may use static global
variables in builtin/foo.c that are initialized in a certain way
before it starts, so calling cmd_foo() twice may not work correctly
(the first invocation may change these variables and they won't be
reset when it returns).  cmd_foo() can and do leave resources
unreclaimed, because it expects the calling main() to exit
immediately, leaving descriptors it creates open or chunks of memory
it allocates unfreed.  cmd_foo() also can and do die() without
returning the control to the caller (this last item does not make
much difference to this particular codepath, as you'd end up dying
soon if this read-tree fails anyway, but in general you'd want to
give a more specific error message when it happens, i.e. instead of
an error message cmd_read_tree() internally gives, you want to say
"Cannot save the current worktree state").

> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "add--interactive", "--patch=stash", "--", NULL);
> +	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", stash_index_path);
> +	if (run_command(&cp))
> +		return 1;

Unlike the above direct call to cmd_read_tree(), the way this
invokes "git add--interactive" is kosher.  By returning non-zero (by
the way, the prevailing convention in this codebase is to return
negative for an error), you give a chance to the caller of this
helper function to say "Cannot save the current worktree state".

> +	discard_cache();
> +	read_cache_from(stash_index_path);
> +
> +	if (write_cache_as_tree(info->w_tree.hash, 0, NULL))
> +		return 1;

OK.

> +	child_process_init(&cp);
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "diff-tree", "-p", "HEAD", NULL);
> +	argv_array_push(&cp.args, sha1_to_hex(info->w_tree.hash));
> +	argv_array_push(&cp.args, "--");
> +	if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0) || out.len == 0)
> +		return 1;

This "diff-tree" call is also reasonable.  Instead of getting the
patch text into a temporary file (which is what the original did),
we slurp it into a strbuf "out", and pass it out to the caller by
storing in info->patch.  OK.

> +	info->patch = strbuf_detach(&out, &unused);

You can pass NULL instead of a throw-away variable &unused.

> +
> +	set_alternate_index_output(index_file);
> +	discard_cache();
> +	read_cache();
> +
> +	return 0;
> +}

So this looks fairly faithful rewrite to C of a half of the
create_stash shell function (we already reviewed the other half done
in your save_working_tree() function).

> +static int do_create_stash(struct stash_info *info, const char *prefix,
> +		const char *message, int include_untracked, int include_ignored,
> +		int patch, const char **argv)
> +{
> +	struct object_id curr_head;
> +	char *branch_path = NULL;
> +	const char *branch_name = NULL;
> +	struct commit_list *parents = NULL;
> +	struct strbuf out_message = STRBUF_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	struct pretty_print_context ctx = {0};
> +
> +	struct commit *c = NULL;
> +	const char *hash;
> +
> +	read_cache_preload(NULL);
> +	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
> +	if (check_no_changes(prefix, include_untracked, include_ignored, argv))
> +		return 1;

We find there is nothing to stash, so we tell the caller that fact
by returning 1.  The caller can tell that this is a "different kind
of success" and is not an error by checking the sign of the return
value.

> +	if (get_sha1_tree("HEAD", info->b_commit.hash))
> +		return error(_("You do not have the initial commit yet"));

And this is an error from the caller's point of view (error()
returns -1).

> +	branch_path = resolve_refdup("HEAD", 0, curr_head.hash, NULL);
> +
> +	if (branch_path == NULL || strcmp(branch_path, "HEAD") == 0)
> +		branch_name = "(no branch)";
> +	else
> +		skip_prefix(branch_path, "refs/heads/", &branch_name);
> +
> +	c = lookup_commit(&info->b_commit);
> +
> +	ctx.output_encoding = get_log_output_encoding();
> +	ctx.abbrev = 1;
> +	ctx.fmt = CMIT_FMT_ONELINE;
> +	hash = find_unique_abbrev(c->object.oid.hash, DEFAULT_ABBREV);
> +
> +	strbuf_addf(&out_message, "%s: %s ", branch_name, hash);
> +
> +	pretty_print_commit(&ctx, c, &out_message);
> +
> +	strbuf_addf(&out, "index on %s\n", out_message.buf);

OK, the above roughly correspond to "# state of the base commit"
part of the original.  This message is created with

	msg=$(printf '%s: %s' "$branch" "$head")

and your "branch_name" is computed to be the same as $branch, and
$head in the original is head=$(git rev-list --oneline -n 1 HEAD--)
which is your "hash" with the oneline.  The whole $msg corresponds
to your "out_message.buf".  Looks correct.

> +	commit_list_insert(lookup_commit(&info->b_commit), &parents);
> +
> +	if (write_cache_as_tree(info->i_tree.hash, 0, NULL))
> +		return error(_("git write-tree failed to write a tree"));

Shouldn't the user also see "Cannot save the current index state"
message in this case?  A failure by write-tree is an implementation
detail and the latter is what matters more to the end user.

> +	if (commit_tree(out.buf, out.len, info->i_tree.hash, parents, info->i_commit.hash, NULL, NULL))
> +		return error(_("Cannot save the current index state"));
> +
> +	strbuf_reset(&out);
> +
> +	if (include_untracked) {
> +		if (save_untracked(info, out_message.buf, include_untracked, include_ignored, argv))
> +			return error(_("Cannot save the untracked files"));
> +	}
> +
> +	if (patch) {
> +		if (patch_working_tree(info, prefix, argv))
> +			return error(_("Cannot save the current worktree state"));
> +	} else {
> +		if (save_working_tree(info, prefix, argv))
> +			return error(_("Cannot save the current worktree state"));
> +	}
> +	parents = NULL;

The elements on the parents list here are leaked here, by early
returns we see above and also at the end of this function.

> +	if (include_untracked)
> +		commit_list_insert(lookup_commit(&info->u_commit), &parents);
> +
> +	commit_list_insert(lookup_commit(&info->i_commit), &parents);
> +	commit_list_insert(lookup_commit(&info->b_commit), &parents);
> +
> +	if (message != NULL && strlen(message) != 0)
> +		strbuf_addf(&out, "On %s: %s\n", branch_name, message);
> +	else
> +		strbuf_addf(&out, "WIP on %s\n", out_message.buf);
> +
> +	if (commit_tree(out.buf, out.len, info->w_tree.hash, parents, info->w_commit.hash, NULL, NULL))
> +		return error(_("Cannot record working tree state"));
> +
> +	info->message = out.buf;
> +
> +	strbuf_release(&out_message);
> +	free(branch_path);
> +
> +	return 0;
> +}

> +static int create_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int include_untracked = 0;
> +	const char *message = NULL;
> +	struct stash_info info;
> +	int ret;
> +	struct strbuf out = STRBUF_INIT;
> +	struct option options[] = {
> +		OPT_BOOL('u', "include-untracked", &include_untracked,
> +			N_("stash untracked filed")),
> +		OPT_STRING('m', "message", &message, N_("message"),
> +			N_("stash commit message")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			git_stash_create_usage, 0);
> +
> +	if (argc != 0) {
> +		int i;
> +		for (i = 0; i < argc; ++i) {
> +			if (i != 0) {
> +				strbuf_addf(&out, " ");
> +			}

Style tips:
    Do not enclose a single statement inside a block.  
    We prefer "if (i)" over "if (i != 0)".
    We prefer "if (!i)" over "if (i == 0)".
    We prefer "i++" over "++i", UNLESS you use the value before increment.

> +			strbuf_addf(&out, "%s", argv[i]);
> +		}
> +		message = out.buf;
> +	}
> +
> +	ret = do_create_stash(&info, prefix, message, include_untracked, 0, 0, NULL);
> +
> +	strbuf_release(&out);

I do not see a need for "message" variable; you can just pass
out.buf to do_create_stash().

> +
> +	if (ret)
> +		return 0;
> +
> +	printf("%s\n", sha1_to_hex(info.w_commit.hash));
> +	return 0;
> +}

