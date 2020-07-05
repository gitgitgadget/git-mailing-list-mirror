Return-Path: <SRS0=5lEM=AQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A41C433DF
	for <git@archiver.kernel.org>; Sun,  5 Jul 2020 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C502C206DF
	for <git@archiver.kernel.org>; Sun,  5 Jul 2020 17:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLPYe1o9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgGERfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jul 2020 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGERfH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jul 2020 13:35:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79844C061794
        for <git@vger.kernel.org>; Sun,  5 Jul 2020 10:35:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 72so3859373ple.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2020 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k3EBA3gD6AbRvnbp1UqWNAgJqNuBdKBz/4nYYHXl234=;
        b=aLPYe1o9qdrys4BK73/DD864Qzd+txO5OlaA2BNojizIlWu8Z2PPmQyub31Y+iCgFd
         jCupVOHj8lTjvGpoIJEIWGG7UeUi5arQLGWJdpmXwxLJM8WDis7V5z5OxOT8G/y9oR0u
         T03nIhbS73b1bDWWQDVxF3W9/mZV+KVxy9K6NnQ+71DVQdmFQ4UkPDdDcF2Ypf1bV2Sp
         sPqOXlCVNSNkRBtN7uefiRA5uIWrIze0Awqh3LXFVu0OJ/Yid1eQ5qxvrPUSwiq2HMaI
         KwnrfZsahANWZTun7PJjZlTdCJPzgZ9GDXtdK4JOI1NGryg6iq40T351NXgOPKzt7TNg
         0ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k3EBA3gD6AbRvnbp1UqWNAgJqNuBdKBz/4nYYHXl234=;
        b=PJFdrgt+eQDTHnM2P9sb81eyXHhCceMyXwtNc2zXSSz0ar+JoCIBbykVevuo9nTIky
         pujzYOlrkT4YBMjFTtx7Sej7XHf3eKiZGQO4OmSUvpufdCjU1t5j1WAMpN8IX9g54Pgn
         x0NV4boTHH8AtAuqnI+iYz4EFQmJyvW8e0ZtkSHxAaMnlk/hri7xzecJXtagQp58Q0Vb
         ocoq9LjBhLjRJgQ55gIJsl6Y7j260NhUj6S9oRCefzL76CpI6riJb/oVZtC4KFvmhwtJ
         doPm1fundDN7CFpJR5DiTioMqYx69OYpA21esnNV8B/xumW4ZNOLYE9A+R1Q05XLzJAO
         tQ6w==
X-Gm-Message-State: AOAM531SQWDPQApmMTw9KEHChHv0HEYDz8uLqGk61wgk9xhsDbj9kv1T
        nCEGqLEE9ZCvrsKg8nf9yr4=
X-Google-Smtp-Source: ABdhPJxoUZyRn+Mt+tdqBHUlL+zgz+Ym9SXV4R6oMJ/4lqE/z8LtrPhfTob71idpbXQ2WhKfIGjgXg==
X-Received: by 2002:a17:902:7d86:: with SMTP id a6mr2742539plm.215.1593970506496;
        Sun, 05 Jul 2020 10:35:06 -0700 (PDT)
Received: from konoha ([45.127.46.118])
        by smtp.gmail.com with ESMTPSA id 125sm16310724pff.130.2020.07.05.10.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 10:35:05 -0700 (PDT)
Date:   Sun, 5 Jul 2020 23:04:58 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com
Subject: Re: [PATCH 4/4] submodule: port submodule subcommand 'summary' from
 shell to C
Message-ID: <20200705173458.GA5204@konoha>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
 <20200702192409.21865-5-shouryashukla.oo@gmail.com>
 <nycvar.QRO.7.76.6.2007031712160.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2007031712160.50@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Dscho!

Before replying, one thing I want to clarify is that I ask various
things for double-checking since if I get even the slightest confusion I
start overthinking and destroying it all for myself. Please bear with me
and confirm/clarify stuff wherever possible. Would be of great help! :)

> Hi Shourya,
> 
> [exchanging Stefan Beller's dysfunct @google address for their private
> one; I encourage you to do the same in the next iteration, probably
> by editing the `Mentored-by:` line.]

I think you missed to mention it.

> On Fri, 3 Jul 2020, Shourya Shukla wrote:
> 
> > From: Prathamesh Chavan <pc44800@gmail.com>
> >
> > The submodule subcommand 'summary' is ported in the process of
> > making git-submodule a builtin. The function cmd_summary() from
> > git-submodule.sh is ported to functions module_summary(),
> > compute_summary_module_list(), prepare_submodule_summary() and
> > generate_submodule_summary(), print_submodule_summary().
> >
> > The first function module_summary() parses the options of submodule
> > subcommand and also acts as the front-end of this subcommand.
> > After parsing them, it calls the compute_summary_module_list()
> 
> Missing full-stop, and probably the sentence also wanted to say "function"
> at the end.

I will correct. Thanks for pointing out!

> > The functions compute_summary_module_list() runs the diff_cmd,
> > and generates the modules list, as required by the subcommand.
> > The generation of this module list is done by the using the
> 
> s/the using/using/

Will amend!

> > callback function submodule_summary_callback(), and stored in the
> > structure module_cb.
> 
> This explains nicely what the patch does. But the commit message should
> not really repeat what can be readily deduced from the patch; It should
> focus on the motivation and on interesting background information that is
> _not_ readily deduced from the patch.

I understand. I will follow your suggestions regarding my patch.

> For example, I see that `$diff_cmd` is called twice in the shell script
> version, once to "get modified modules cared by user" and then _again_,
> with that list of modified modules.
> 
> I would have liked to see a reasoning in the commit message that explains
> why this has to be so in the C version. I get why it is complicated in a
> shell script (which lacks proper objects, after all), but I would have
> expected the C version to be able to accumulate the information with a
> single pass.
> 
> (Before writing the following paragraph, I actually reviewed the patch
> from bottom to top, in the caller->callee direction.)
> 
> Ah. I see that this indeed is the case: there is only one pass in the C
> version. That's a useful piece of metadata for the commit message, I
> think, much more useful than describing the call tree of the functions.

Yup that it worth mentioning.

> Another thing worth mentioning in the commit message is that we use the
> combination of setting a child_process' working directory to the submodule
> path and then calling `prepare_submodule_repo_env()` which also sets
> `GIT_DIR` to `.git`, so that we can be certain that those spawned
> processes will not access the superproject's ODB by mistake.
> 
> When reading my suggestions, please keep in mind that I reviewed the
> functions in caller->callee order, i.e. I started at the end of the patch
> and then worked my way up.
> 
> All in all, I like the function structure, but I think there is still a
> bit room for improvement in a v2.

> > +static int verify_submodule_object_name(const char *sm_path,
> > +					  const char *sha1)
> > +{
> > +	struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> > + > > +	cp_rev_parse.git_cmd = 1;
> > +	cp_rev_parse.no_stdout = 1;
> > +	cp_rev_parse.dir = sm_path;
> 
> So here we specify `sm_path` as current working directory.
> 
> > +	prepare_submodule_repo_env(&cp_rev_parse.env_array);
> 
> And this implicitly sets `GIT_DIR=.git`. Good.
> 
> > +	argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
> > +			 "--verify", NULL);
> > +	argv_array_pushf(&cp_rev_parse.args, "%s^0", sha1);
> 
> After this, we should also append `--` to make sure that we're not parsing
> this as a file name.

Will do!

> Two comments about naming: `sha1` is pretty misleading here, as we do not
> require it to be a SHA-1 (especially in the future in which we switch to
> SHA-256). Besides, what we're really asking for (via that `^0` suffix) is
> a committish. Therefore, I would propose to use `committish` both in the
> parameter name as well as the function name.

I am not aware of this change. I will take this suggestion into account.

> > +
> > +	if (run_command(&cp_rev_parse))
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static void print_submodule_summary(struct summary_cb *info, int errmsg,
> > +				      int total_commits, int missing_src,
> > +				      int missing_dst, const char *displaypath,
> > +				      int is_sm_git_dir, struct module_cb *p)
> > +{
> > +	if (p->status == 'T') {
> > +		if (S_ISGITLINK(p->mod_dst))
> > +			printf(_("* %s %s(blob)->%s(submodule)"),
> > +				 displaypath, find_unique_abbrev(&p->oid_src, 7),
> 
> The shell script version does this:
> 
>                 sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src 2>/dev/null ||
>                         echo $sha1_src | cut -c1-7)
> 
> That is not quite the same, as it looks for the abbreviation _in the
> submodule_, not in the current project. So I think `find_unique_abbrev()`
> is not correct here.
> 
> The funny thing is that we _already_ will have called `git rev-parse
> --verify` for both `p->oid_src` and `p->oid_dst` in the submodule, in the
> caller of this function! And while we throw away the result, and while we
> do not pass `--short`, there is no reason why we shouldn't be able to do
> precisely that.

Okay so you are saying that there is no need of a 'find_unique_abbrev()'
since we would be easily able to obtain these values from the caller of
'print_submodule_summary()' right? Maybe we can pass 'oid_src' or
'oid_dst' as an argument?

> > +				 find_unique_abbrev(&p->oid_dst, 7));
> > +		else
> > +			printf(_("* %s %s(submodule)->%s(blob)"),
> > +				 displaypath, find_unique_abbrev(&p->oid_src, 7),
> > +				 find_unique_abbrev(&p->oid_dst, 7));
> > +	} else {
> > +		printf("* %s %s...%s",
> > +			displaypath, find_unique_abbrev(&p->oid_src, 7),
> > +			find_unique_abbrev(&p->oid_dst, 7));
> > +	}
> > +
> > +	if (total_commits < 0)
> > +		printf(":\n");
> > +	else
> > +		printf(" (%d):\n", total_commits);
> > +
> > +	if (errmsg) {
> > +		/*
> > +		 * Don't give error msg for modification whose dst is not
> > +		 * submodule, i.e. deleted or changed to blob
> > +		 */
> > +		if (S_ISGITLINK(p->mod_src)) {
> > +			if (missing_src && missing_dst) {
> > +				printf(_("  Warn: %s doesn't contain commits %s and %s\n"),
> > +				       displaypath, oid_to_hex(&p->oid_src),
> > +				       oid_to_hex(&p->oid_dst));
> > +			} else if (missing_src) {
> > +				printf(_("  Warn: %s doesn't contain commit %s\n"),
> > +				       displaypath, oid_to_hex(&p->oid_src));
> > +			} else {
> > +				printf(_("  Warn: %s doesn't contain commit %s\n"),
> > +				       displaypath, oid_to_hex(&p->oid_dst));
> > +			}
> > +		}
> > +	} else if (is_sm_git_dir) {
> > +		struct child_process cp_log = CHILD_PROCESS_INIT;
> > +
> > +		cp_log.git_cmd = 1;
> > +		cp_log.dir = p->sm_path;
> > +		prepare_submodule_repo_env(&cp_log.env_array);
> 
> Since the working directory is set to the top-level directory of the
> submodule, and since `prepare_submodule_repo_env()` sets `GIT_DIR` to
> `.git`, I think that the `is_sm_git_dir` condition is unnecessary. In
> fact, the entire `is_sm_git_dir` parameter (and local variable in the
> caller, see more on that below) can go away.

Because we already set the $GIT_DIR to .git/ so an extra check will not
be necessary right?

> > +		argv_array_pushl(&cp_log.args, "log", NULL);
> > +
> > +		if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst)) {
> > +			if (info->summary_limit > 0)
> > +				argv_array_pushf(&cp_log.args, "-%d",
> > +						 info->summary_limit);
> > +
> > +			argv_array_pushl(&cp_log.args, "--pretty=  %m %s",
> > +					 "--first-parent", NULL);
> > +			argv_array_pushf(&cp_log.args, "%s...%s",
> > +					 oid_to_hex(&p->oid_src),
> > +					 oid_to_hex(&p->oid_dst));
> > +		} else if (S_ISGITLINK(p->mod_dst)) {
> > +			argv_array_pushl(&cp_log.args, "--pretty=  > %s",
> > +					 "-1", oid_to_hex(&p->oid_dst), NULL);
> > +		} else {
> > +			argv_array_pushl(&cp_log.args, "--pretty=  < %s",
> > +					 "-1", oid_to_hex(&p->oid_src), NULL);
> > +		}
> > +		run_command(&cp_log);
> > +	}
> > +	printf("\n");
> > +}
> 
> It looks as if there is a whole lot of `oid_to_hex(&p->oid_src)` in that
> function. Together with the realization that we need the abbreviated
> version of that at least in one place, and the other realization that we
> already call `rev-parse --verify` for both `oid_src` and `oid_dst` in the
> caller of this function, it seems to suggest itself that we would actually
> want to pass the `--short` option, too, and to capture the output, and
> pass it down to `print_submodule_summary()` _instead of_ `missing_src` and
> `missing_dst` (e.g. as `src_abbrev` and `dst_abbrev`).

Oh you have mentioned it here too. This seems quite a good approach. I
will adopt this.

> > +
> > +static void generate_submodule_summary(struct summary_cb *info,
> > +				       struct module_cb *p)
> > +{
> > +	int missing_src = 0;
> > +	int missing_dst = 0;
> > +	char *displaypath;
> > +	int errmsg = 0;
> > +	int total_commits = -1;
> > +	int is_sm_git_dir = 0;
> > +	struct strbuf sm_git_dir_sb = STRBUF_INIT;
> > +
> > +	if (!info->cached && oideq(&p->oid_dst, &null_oid)) {
> > +		if (S_ISGITLINK(p->mod_dst)) {
> > +			/*
> > +			 * NEEDSWORK: avoid using separate process with
> > +			 * the help of the function head_ref_submodule()
> 
> I don't quite understand this comment. There is no `head_ref_submodule()`
> function.
> 
> > +			 */
> > +			struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> > +			struct strbuf sb_rev_parse = STRBUF_INIT;
> > +
> > +			cp_rev_parse.git_cmd = 1;
> > +			cp_rev_parse.no_stderr = 1;
> > +			cp_rev_parse.dir = p->sm_path;
> > +			prepare_submodule_repo_env(&cp_rev_parse.env_array);
> > +
> > +			argv_array_pushl(&cp_rev_parse.args, "rev-parse",
> > +					 "HEAD", NULL);
> > +			if (!capture_command(&cp_rev_parse, &sb_rev_parse, 0)) {
> > +				strbuf_strip_suffix(&sb_rev_parse, "\n");
> > +				get_oid_hex(sb_rev_parse.buf, &p->oid_dst);
> > +			}
> > +			strbuf_release(&sb_rev_parse);
> > +		} else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
> > +			struct child_process cp_hash_object = CHILD_PROCESS_INIT;
> > +			struct strbuf sb_hash_object = STRBUF_INIT;
> > +
> > +			cp_hash_object.git_cmd = 1;
> > +			argv_array_pushl(&cp_hash_object.args, "hash-object",
> > +					 p->sm_path, NULL);
> > +			if (!capture_command(&cp_hash_object,
> > +					     &sb_hash_object, 0)) {
> > +				strbuf_strip_suffix(&sb_hash_object, "\n");
> > +				get_oid_hex(sb_hash_object.buf, &p->oid_dst);
> > +			}
> > +			strbuf_release(&sb_hash_object);
> 
> It would probably be shorter, less error-prone, and quicker to use
> `index_fd()` directly.
>
> BTW I am not quite sure that this code does the correct thing in case of a
> symlink: it hashes the contents of the symlink target (if it is a file,
> otherwise it errors out). But that is hardly an issue introduced by the
> conversion, that's just copied from `git-submodule.sh`.
> 
> > +		} else {
> > +			if (p->mod_dst)
> > +				die(_("unexpected mode %d\n"), p->mod_dst);
> 
> Hmm. This does not match what the shell script version does:
> 
>                         *)
>                                 # unexpected type
>                                 eval_gettextln "unexpected mode \$mod_dst" >&2
>                                 continue ;;
> 
> I think we should also just write the message to `stderr` and continue,
> not `die()`.
> 
> In addition to that, I am missing the C code for this case:
> 
>                         000000)
>                                 ;; # removed
> 
> It is quite possible that our test suite does not cover this case (or did
> the test suite fail for you?). If that is indeed the case, it would be
> really good to add a test case as part of this patch series, to gain
> confidence in the correctness of the conversion.

The tests passed for me actually. Whether this is covered by the test
cases, I am not sure. I will have to check it.

> > +		}
> > +	}
> > +
> > +	strbuf_addstr(&sm_git_dir_sb, p->sm_path);
> 
> I have to admit that I am not loving the name `sm_git_dir_sb`. Why not
> `submodule_git_dir`? I guess you copied it from elsewhere in
> `submodule--helper.c`...
> 
> > +	if (is_nonbare_repository_dir(&sm_git_dir_sb))
> > +		is_sm_git_dir = 1;
> 
> So here, we verify whether there is a repository at `p->sm_path`. I don't
> see that in the shell script version:
> 
>                 missing_src=
>                 missing_dst=
> 
>                 test $mod_src = 160000 &&
>                 ! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_src^0 >/dev/null &&
>                 missing_src=t
> 
>                 test $mod_dst = 160000 &&
>                 ! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_dst^0 >/dev/null &&
>                 missing_dst=t
> 
> Let's read a bit further.
> 
> > +
> > +	if (is_sm_git_dir && S_ISGITLINK(p->mod_src))
> > +		missing_src = verify_submodule_object_name(p->sm_path,
> > +							   oid_to_hex(&p->oid_src));
> 
> Ah, and `verify_submodule_object_name()` uses `p->sm_path` as working
> directory. But that's not what the shell script version did: it specified
> the `GIT_DIR` explicitly.
> 
> And by using the `prepare_submodule_repo_env()` function in
> `verify_submodule_object_name()`, we specify `GIT_DIR` implicitly, as I
> pointed out in my comment on that function.

Oh so you're saying that it will be better to call
'prepare_submodule_repo_env()' on some variable since we explicitly want to
store the path to GIT_DIR?

It would be of much help if you could explain this part just a little
more (for my own sake).

> So I think that `is_sm_git_dir` might be

I think you missed something here...

> > +
> > +	if (is_sm_git_dir && S_ISGITLINK(p->mod_dst))
> > +		missing_dst = verify_submodule_object_name(p->sm_path,
> > +							   oid_to_hex(&p->oid_dst));
> > +
> > +	displaypath = get_submodule_displaypath(p->sm_path, info->prefix);
> > +
> > +	if (!missing_dst && !missing_src) {
> > +		if (is_sm_git_dir) {
> > +			struct child_process cp_rev_list = CHILD_PROCESS_INIT;
> > +			struct strbuf sb_rev_list = STRBUF_INIT;
> > +			char *range;
> > +
> > +			if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst))
> > +				range = xstrfmt("%s...%s", oid_to_hex(&p->oid_src),
> > +						oid_to_hex(&p->oid_dst));
> > +			else if (S_ISGITLINK(p->mod_src))
> > +				range = xstrdup(oid_to_hex(&p->oid_src));
> > +			else
> > +				range = xstrdup(oid_to_hex(&p->oid_dst));
> > +
> > +			cp_rev_list.git_cmd = 1;
> > +			cp_rev_list.dir = p->sm_path;
> > +			prepare_submodule_repo_env(&cp_rev_list.env_array);
> 
> Again, due to setting the working directory to `p->sm_path` and
> (implicitly, via `prepare_submodule_repo_env()`) `GIT_DIR` to `.git`, I do
> not think that we have to guard this block beind `is_sm_git_dir`.

> > +
> > +			argv_array_pushl(&cp_rev_list.args, "rev-list",
> > +					 "--first-parent", range, "--", NULL);
> 
> Since `argv_array_push()` duplicates the strings, anyway, we can totally
> avoid the need for the `range` variable:
> 
> 			if (IS_GITLINK(p->mod_src) && IS_GITLINK(p->mod_dst))
> 				argv_array_pushf(&cp_rev_list.args, "%s...%s",
> 						 oid_to_hex(&p->oid_src),
> 						 oid_to_hex(&p->oid_dst));
> 			else
> 				argv_array_push(&cp_rev_list.args, IS_GITLINK(p->mod_src) ?
> 						oid_to_hex(&p->oid_src) :
> 						oid_to_hex(&p->oid_dst));
> 
> > +			if (!capture_command(&cp_rev_list, &sb_rev_list, 0)) {
> > +				if (sb_rev_list.len)
> > +					total_commits = count_lines(sb_rev_list.buf,
> > +								    sb_rev_list.len);
> 
> That's actually not necessary. `git rev-list --count` will give you a nice
> number, no need to capture a potentially large amount of memory only to
> count the lines.
> 
> This may also make the patch obsolete that makes `count_lines()` public.

Therefore we eliminate count_lines() from here and instead do a 'git
rev-list --count'?

> > +				else
> > +					total_commits = 0;
> > +			}
> 
> > +
> > +			free(range);
> > +			strbuf_release(&sb_rev_list);
> > +		}
> > +	} else {
> > +		errmsg = 1;
> > +	}
> 
> I am missing the equivalent for these lines here:
> 
>                 t,)
>                         errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commit \$sha1_src")"
>                         ;;
>                 ,t)
>                         errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commit \$sha1_dst")"
>                         ;;
>                 t,t)
>                         errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commits \$sha1_src and \$ ha1_dst")"
>                         ;;

I will add them.

> I am not quite sure whether it is a good idea to leave it to the
> `print_submodule_summary()` function to generate the `errmsg`. I think I'd
> rather have it a `char *` than an `int`.

Would it be better to add these error messages in
'prepare_submodule_summary()'? If we have error messages as integers
then we will simply

> > +
> > +	print_submodule_summary(info, errmsg, total_commits,
> > +				missing_src, missing_dst,
> > +		      		displaypath, is_sm_git_dir, p);
> > +
> > +	free(displaypath);
> > +	strbuf_release(&sm_git_dir_sb);
> > +}
> > +
> > +static void prepare_submodule_summary(struct summary_cb *info,
> > +				      struct module_cb_list *list)
> > +{
> > +	int i;
> > +	for (i = 0; i < list->nr; i++) {
> > +		struct module_cb *p = list->entries[i];
> > +		struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> > +
> > +		if (p->status == 'D' || p->status == 'T') {
> > +			generate_submodule_summary(info, p);
> > +			continue;
> > +		}
> > +
> > +		if (info->for_status) {
> > +			char *config_key;
> 
> Since the `config_key` is only used within the `if()` block it would be
> better to declare it within that block.
> 
> > +			const char *ignore_config = "none";
> 
> Since the only value we ever care about is "all", how about turning this
> into an `int`, setting it to `0` here, and later assigning it to
> `!strcmp(value, "all")` and `!strcmp(sub->ignore, "all")`, respectively?

Alright will do!

> I mean, I get it. Unix shell scripts are all about passing around text.
> And it is much easier to just translate that to C faithfully. But that
> does not make it good C code. C has data types, and proper C code makes
> use of that.
> 
> > +			const char *value;
> 
> If you want to save on lines, you can cuddle this together with other
> declarations of the same type. Even so, it could be scoped more narrowly.
> 
> > +			const struct submodule *sub = submodule_from_path(the_repository,
> > +									  &null_oid,
> > +									  p->sm_path);
> > +
> > +			if (sub && p->status != 'A') {
> 
> Good. The shell script version _always_ retrieved the `.ignore` config
> value, even if the `status` is `A`. Your version is much better.
> 
> But why bother calling `submodule_from_path()` if the status is `A`?

What exactly does a status of 'A' or 'T' mean? I mean I know what we are
doing but what exactly do these translate into?

> I could actually see the `const struct submodule *sub;` declaration be
> pulled out of this scope, and combining the `if (info->for_status &&
> p->status != 'A'), and the moving the assignment of `sub` into the `else
> if ((sub = submodule_from_path(r, &null_oid, p->sm_path)) &&
> sub->ignore)`.
> 
> That would save us one entire indentation level.

That seems a good approach! I will try this out.

> > +				config_key = xstrfmt("submodule.%s.ignore",
> > +						     sub->name);
> > +				if (!git_config_get_string_const(config_key, &value))
> > +					ignore_config = value;
> > +				else if (sub->ignore)
> > +					ignore_config = sub->ignore;
> > +
> > +				free(config_key);
> > +				if (!strcmp(ignore_config, "all"))
> > +					continue;
> > +			}
> > +		}
> > +
> > +		/* Also show added or modified modules which are checked out */
> > +		cp_rev_parse.dir = p->sm_path;
> > +		cp_rev_parse.git_cmd = 1;
> > +		cp_rev_parse.no_stderr = 1;
> > +		cp_rev_parse.no_stdout = 1;
> > +
> > +		argv_array_pushl(&cp_rev_parse.args, "rev-parse",
> > +				 "--git-dir", NULL);
> > +
> > +		if (!run_command(&cp_rev_parse))
> 
> I wonder whether we really need to waste an entire spawned process on
> figuring out whether `p->sm_path` refers to an active repository. Wouldn't
> `is_submodule_active(r, p->sm_path)` fulfill the same purpose?

Yep! This is correct. I will change.

> > +			generate_submodule_summary(info, p);
> > +	}
> > +}
> > +
> > +static void submodule_summary_callback(struct diff_queue_struct *q,
> > +				       struct diff_options *options,
> > +				       void *data)
> > +{
> > +	int i;
> > +	struct module_cb_list *list = data;
> > +	for (i = 0; i < q->nr; i++) {
> > +		struct diff_filepair *p = q->queue[i];
> > +		struct module_cb *temp;
> > +
> > +		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
> > +			continue;
> > +		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
> > +		temp->mod_src = p->one->mode;
> > +		temp->mod_dst = p->two->mode;
> > +		temp->oid_src = p->one->oid;
> > +		temp->oid_dst = p->two->oid;
> > +		temp->status = p->status;
> > +		temp->sm_path = xstrdup(p->one->path);
> > +
> > +		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
> > +		list->entries[list->nr++] = temp;
> > +	}
> > +}
> > +
> > +static const char *get_diff_cmd(enum diff_cmd diff_cmd)
> > +{
> > +	switch (diff_cmd) {
> > +	case DIFF_INDEX: return "diff-index";
> > +	case DIFF_FILES: return "diff-files";
> > +	default: BUG("bad diff_cmd value %d", diff_cmd);
> > +	}
> > +}
> > +
> > +static int compute_summary_module_list(char *head,
> > +				         struct summary_cb *info,
> > +				         enum diff_cmd diff_cmd)
> > +{
> > +	struct argv_array diff_args = ARGV_ARRAY_INIT;
> > +	struct rev_info rev;
> > +	struct module_cb_list list = MODULE_CB_LIST_INIT;
> > +
> > +	argv_array_push(&diff_args, get_diff_cmd(diff_cmd));
> > +	if (info->cached)
> > +		argv_array_push(&diff_args, "--cached");
> > +	argv_array_pushl(&diff_args, "--ignore-submodules=dirty", "--raw",
> > +			 NULL);
> > +	if (head)
> > +		argv_array_push(&diff_args, head);
> > +	argv_array_push(&diff_args, "--");
> > +	if (info->argc)
> > +		argv_array_pushv(&diff_args, info->argv);
> > +
> > +	git_config(git_diff_basic_config, NULL);
> > +	init_revisions(&rev, info->prefix);
> > +	rev.abbrev = 0;
> > +	precompose_argv(diff_args.argc, diff_args.argv);
> > +
> > +	diff_args.argc = setup_revisions(diff_args.argc, diff_args.argv,
> > +					 &rev, NULL);
> > +	rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
> > +	rev.diffopt.format_callback = submodule_summary_callback;
> > +	rev.diffopt.format_callback_data = &list;
> > +
> > +	if (!info->cached) {
> > +		if (diff_cmd ==  DIFF_INDEX)
> 
> Please substitute the double-space by a single one.

Will do!

> > +			setup_work_tree();
> > +		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
> > +			perror("read_cache_preload");
> > +			return -1;
> > +		}
> > +	} else if (read_cache() < 0) {
> > +		perror("read_cache");
> > +		return -1;
> > +	}
> > +
> > +	if (diff_cmd == DIFF_INDEX)
> > +		run_diff_index(&rev, info->cached);
> > +	else
> > +		run_diff_files(&rev, 0);
> > +	prepare_submodule_summary(info, &list);
> > +	return 0;
> > +}
> > +
> > +static int module_summary(int argc, const char **argv, const char *prefix)
> > +{
> > +	struct summary_cb info = SUMMARY_CB_INIT;
> > +	int cached = 0;
> > +	int for_status = 0;
> > +	int quiet = 0;
> > +	int files = 0;
> > +	int summary_limit = -1;
> > +	struct child_process cp_rev = CHILD_PROCESS_INIT;
> > +	struct strbuf sb = STRBUF_INIT;
> > +	enum diff_cmd diff_cmd = DIFF_INDEX;
> > +	int ret;
> > +
> > +	struct option module_summary_options[] = {
> > +		OPT__QUIET(&quiet, N_("Suppress output of summarising submodules")),
> > +		OPT_BOOL(0, "cached", &cached,
> > +			 N_("Use the commit stored in the index instead of the submodule HEAD")),
> > +		OPT_BOOL(0, "files", &files,
> > +			 N_("To compare the commit in the index with that in the submodule HEAD")),
> > +		OPT_BOOL(0, "for-status", &for_status,
> > +			 N_("Skip submodules with 'ignore_config' value set to 'all'")),
> > +		OPT_INTEGER('n', "summary-limit", &summary_limit,
> > +			     N_("Limit the summary size")),
> > +		OPT_END()
> > +	};
> > +
> > +	const char *const git_submodule_helper_usage[] = {
> > +		N_("git submodule--helper summary [<options>] [commit] [--] [<path>]"),
> > +		NULL
> > +	};
> > +
> > +	argc = parse_options(argc, argv, prefix, module_summary_options,
> > +			     git_submodule_helper_usage, 0);
> > +
> > +	if (!summary_limit)
> > +		return 0;
> > +
> > +	cp_rev.git_cmd = 1;
> > +	argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
> > +			 argc ? argv[0] : "HEAD", NULL);
> 
> Oy. Why not simply call `get_oid()`? No need to spawn a new process.

Then everytime we need 'rev-parse', we simply call 'get_oid()'? That
will save us a ton of processes?

But I think we do need to capture the output of 'git rev-parse --verify
....' so I think it will backfire to use 'get_oid()' or am I just being
too dumb and not catching on something?

> > +
> > +	if (!capture_command(&cp_rev, &sb, 0)) {
> > +		strbuf_strip_suffix(&sb, "\n");
> > +		if (argc) {
> > +			argv++;
> > +			argc--;
> > +		}
> > +	} else if (!argc || !strcmp(argv[0], "HEAD")) {
> > +		/* before the first commit: compare with an empty tree */
> > +		struct stat st;
> > +		struct object_id oid;
> > +		if (fstat(0, &st) < 0 || index_fd(&the_index, &oid, 0, &st, 2,
> > +						  prefix, 3))
> > +			die("Unable to add %s to database", oid.hash);
> 
> Umm. The original reads:
> 
>                 # before the first commit: compare with an empty tree
>                 head=$(git hash-object -w -t tree --stdin </dev/null)
> 
> It does not actually read from `stdin`. It reads from `/dev/null`,
> redirected to the input. And what it _actually_ does is to generate the
> OID of the empty tree.
> 
> But we already _have_ the OID of the empty tree! It's
> `the_hash_algo->empty_tree`.

I did not know this 'the_hash_algo'. I will use it. Thanks! :)

> I hope that this is covered by the test suite. Please check that. The test
> would succeed with your version, but only because tests are run with
> `stdin` redirected from `/dev/null` by default.

I guess yes. My work passed because the tests are written this way.

> > +		strbuf_addstr(&sb, oid_to_hex(&oid));
> > +		if (argc) {
> > +			argv++;
> > +			argc--;
> > +		}
> > +	} else {
> > +		strbuf_addstr(&sb, "HEAD");
> > +	}
> 
> The conversion to C would make for a fine excuse to simplify the logic.

This was kind of like the 'shift' in shell. What equivalent do you
suggest?

> > +	if (files) {
> > +		if (cached)
> > +			die(_("--cached and --files are mutually exclusive"));
> > +		diff_cmd = DIFF_FILES;
> > +	}
> > +
> > +	info.argc = argc;
> > +	info.argv = argv;
> > +	info.prefix = prefix;
> > +	info.cached = !!cached;
> > +	info.for_status = !!for_status;
> > +	info.quiet = quiet;
> > +	info.files = files;
> > +	info.summary_limit = summary_limit;
> > +
> > +	ret = compute_summary_module_list((diff_cmd == DIFF_FILES) ? NULL : sb.buf,
> > +					   &info, diff_cmd);
> 
> It would be better to pass the OID as `struct object_id *`, not as string.

Will do!

> Other than that, this patch nicely follows previous conversions from Unix
> shell scripts to C.
> 
> Well done,
> Johannes

Thank you! It was a highly detailed review! I am still learning tons of
stuff about Git's code and such a review does help a lot! :)
