Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217731FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 16:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbdFPQP4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 12:15:56 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34325 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdFPQPz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 12:15:55 -0400
Received: by mail-pg0-f47.google.com with SMTP id v18so22349912pgb.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y8Rd4HOuywDmNmck4x4NxOUb+Nrs1QMUsfNhwDw+9Os=;
        b=YN09LmjIqbQEl2qSGsuc8aRyams6KHXQ8B6nZlV2wmpc//owcgSWXh5ZC0LB8jl3If
         KI2294hl8vr23aEVR9m4uGAEPl4YNiY035DS7TP9UiCWwjDzpIlw3RjEi5xikU8Q+adU
         Yze3JLQTO/Q9KF30HTZJmfkfu6ddA5VLTwbBrzwlC9nn3i/4sDNK7y5W2t8Bd1Nb6aBC
         RtII0Ml8XgeQA0WwFuzRsiztt0u3lJ/mPodG+w9qcP0TRi3iCUAT1sHjObdW9dX46Spq
         7qSQqnurnzRnB9Wc/QlpTB5Cd0XcTZHycTRVqWQECue/3lZ9GF9VuSvB9voq2R9T6YI5
         uRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y8Rd4HOuywDmNmck4x4NxOUb+Nrs1QMUsfNhwDw+9Os=;
        b=NgXxCVxhrSIhPO8uSTk8aA7xmj27uoNX9EbbPWCEqSzMlYFr1EGWuB9S2z0aRRgLmR
         sw+I4JQOdsGzIbb9Bc8vmpLfGSn359MY5nrsnWO6nuJA90YWWfbE+IMXhzU7XF0RTJE4
         k72Nt20Yk95gjEAbdjwNWG2J8Z037jiC9YmIshmV8S44mbtL8Boy/QcriVTO+odTRiik
         mrkRu0hJv6SFI1ZZLsPm2CSktnwY8afeTW25On6IGRFFSma+TjlFrlydMy1hzvfOWsG0
         Ke7Vjdud7MI8NOfNkk33eDVREKkF6WHEI5oyDAPRji8l49KlLgHtUdyuwpFv4p7xYIJf
         UfMQ==
X-Gm-Message-State: AKS2vOyOqP9Bfjhxya9qkzTEqzMiBT3/JIM1Z87LcwtfUlpdFnzl/HQH
        /4IIQY674xblIQ==
X-Received: by 10.99.155.1 with SMTP id r1mr12455433pgd.273.1497629753651;
        Fri, 16 Jun 2017 09:15:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id g78sm5317416pfb.122.2017.06.16.09.15.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 09:15:52 -0700 (PDT)
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
Date:   Fri, 16 Jun 2017 09:15:51 -0700
In-Reply-To: <20170608005535.13080-6-joel@teichroeb.net> (Joel Teichroeb's
        message of "Wed, 7 Jun 2017 17:55:35 -0700")
Message-ID: <xmqqbmpnyklk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> diff --git a/builtin/stash.c b/builtin/stash.c
> new file mode 100644
> index 0000000000..a9680f2909
> --- /dev/null
> +++ b/builtin/stash.c
> ...
> +static const char *ref_stash = "refs/stash";
> +static int quiet = 0;

Let BSS take care of zero-initialization, i.e. drop " = 0".

> +static int untracked_files(struct strbuf *out, int include_untracked,
> +		int include_ignored, const char **argv)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "ls-files", "-o", "-z", NULL);
> +	if (include_untracked && !include_ignored)
> +		argv_array_push(&cp.args, "--exclude-standard");
> +	argv_array_push(&cp.args, "--");
> +	if (argv)
> +		argv_array_pushv(&cp.args, argv);
> +	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
> +}

Seeing that include_untracked and include_ignored always come in a
pair throughout the program, I wondered if it may be better to use
a single "unsigned include" with two bits

    #define INCLUDE_UNTRACKED 01
    #define INCLUDE_IGNORED 02

to pass around.  As long as we envision that we will not gain other
kind of "do we include X?" in the future, what your patch does is
fine, I would say.

> +static int check_no_changes(const char *prefix, int include_untracked,
> +		int include_ignored, const char **argv)
> +{
> +	struct argv_array args1 = ARGV_ARRAY_INIT;
> +	struct argv_array args2 = ARGV_ARRAY_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	int ret;
> +
> +	argv_array_pushl(&args1, "diff-index", "--quiet", "--cached", "HEAD",
> +		"--ignore-submodules", "--", NULL);
> +	if (argv)
> +		argv_array_pushv(&args1, argv);
> +
> +	argv_array_pushl(&args2, "diff-files", "--quiet", "--ignore-submodules",
> +		"--", NULL);
> +	if (argv)
> +		argv_array_pushv(&args2, argv);
> +
> +	if (include_untracked)
> +		untracked_files(&out, include_untracked, include_ignored, argv);
> +
> +	ret = cmd_diff_index(args1.argc, args1.argv, prefix) == 0 &&
> +			cmd_diff_files(args2.argc, args2.argv, prefix) == 0 &&
> +			(!include_untracked || out.len == 0);

When diff_index() finds there are modified paths, you do not have to
call diff_files() or untracked_files() at all (and you do not even
have to set-up args2).  Doesn't the above leak args.argv[] when &&
short circuits?

    This is a tangent, but it is somewhat unusual to call cmd_foo()
    as a subroutine.  I think cmd_diff_*() are written reasonably
    well to allow them to be called in this way safely, and there
    are a few existing commands that already do so, so it may be OK.

> +	strbuf_release(&out);
> +	return ret;
> +}
> +
> +static int get_stash_info(struct stash_info *info, const char *commit)
> +{
> +	struct strbuf w_commit_rev = STRBUF_INIT;
> +	struct strbuf b_commit_rev = STRBUF_INIT;
> +	struct strbuf w_tree_rev = STRBUF_INIT;
> +	struct strbuf b_tree_rev = STRBUF_INIT;
> +	struct strbuf i_tree_rev = STRBUF_INIT;
> +	struct strbuf u_tree_rev = STRBUF_INIT;
> +	struct strbuf commit_buf = STRBUF_INIT;
> +	struct strbuf symbolic = STRBUF_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	int ret;
> +	const char *revision = commit;
> +	char *end_of_rev;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	info->is_stash_ref = 0;
> +
> +	if (commit == NULL) {
> +		strbuf_addf(&commit_buf, "%s@{0}", ref_stash);
> +		revision = commit_buf.buf;
> +	} else if (strlen(commit) < 3) {

This is a bit sloppy (the original is even sloppier but it is in
shell, so it is more excusable ;-).  This code thinks that anything
with @{<num>} must be longer than 3 because it has to have @{},
and that is where the strlen() comes from, I think, but the magic
number 3 appears without explanation here.

What the code actually needs to do is to see if the stash entry
specification came in "commit" (which by the way is a bit misnamed
parameter) is a bare number and use refs/stash@{<that number>} only
in that case, I think.  strspn() might be useful.

> +		strbuf_addf(&commit_buf, "%s@{%s}", ref_stash, commit);
> +		revision = commit_buf.buf;
> +	}
> +	info->revision = revision;
> +
> +	strbuf_addf(&w_commit_rev, "%s", revision);
> +	strbuf_addf(&b_commit_rev, "%s^1", revision);
> +	strbuf_addf(&w_tree_rev, "%s:", revision);
> +	strbuf_addf(&b_tree_rev, "%s^1:", revision);
> +	strbuf_addf(&i_tree_rev, "%s^2:", revision);
> +	strbuf_addf(&u_tree_rev, "%s^3:", revision);
> +
> +	ret = (get_sha1(w_commit_rev.buf, info->w_commit.hash) == 0 &&
> +		get_sha1(b_commit_rev.buf, info->b_commit.hash) == 0 &&
> +		get_sha1(w_tree_rev.buf, info->w_tree.hash) == 0 &&
> +		get_sha1(b_tree_rev.buf, info->b_tree.hash) == 0 &&
> +		get_sha1(i_tree_rev.buf, info->i_tree.hash) == 0);

It's more conventional to check for errors with !get_sha1(params),
not a long-hand comparision with 0.

> +	strbuf_release(&w_commit_rev);
> +	strbuf_release(&b_commit_rev);
> +	strbuf_release(&w_tree_rev);
> +	strbuf_release(&b_tree_rev);
> +	strbuf_release(&i_tree_rev);
> +
> +	if (!ret)
> +		return error(_("%s is not a valid reference"), revision);

We are leaking u_tree_rev.buf upon early return.

> +	info->has_u = get_sha1(u_tree_rev.buf, info->u_tree.hash) == 0;
> +
> +	strbuf_release(&u_tree_rev);
> +
> +	end_of_rev = strchrnul(revision, '@');
> +	strbuf_add(&symbolic, revision, end_of_rev - revision);
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "rev-parse", "--symbolic-full-name", NULL);
> +	argv_array_pushf(&cp.args, "%s", symbolic.buf);
> +	strbuf_release(&symbolic);
> +	pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
> +
> +	if (out.len-1 == strlen(ref_stash))
> +		info->is_stash_ref = strncmp(out.buf, ref_stash, out.len-1) == 0;

Favor !strncmp(params) over comparision with 0.

Style: Have SP around both sides of binary operator "-".

> +	strbuf_release(&out);
> +	return !ret;

Hmph, where did we last assign ret in this code?  Didn't we check
that value and returned error already, which means we know what !ret
is when the control reaches here?

> +}

I have to move to another building, so I'll stop here for now, but
will continue later.

Thanks.

