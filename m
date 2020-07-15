Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A195C433DF
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 14:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D689A205CB
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 14:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIEcqz7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgGOO1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgGOO1g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 10:27:36 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5164BC061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 07:27:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so3168529pgf.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mGiNT3Qs9w0bMGnUkVvGkILw7vqscHMywq7uSShZLJc=;
        b=lIEcqz7PE9z/gUKp4SwwD7Gx4ANMVkRDj4mwD58xoAaQwoZ6VFMwzg464u6Wi13UR7
         WZEb3PG/emnUUR19TTifNPBjXDE4W0h256KAYksJmK+zaRKW5MZB9jG9Ovr6chl18CeY
         n86mdglIC5UJpGvSxqpZ70bvdgV0GjGnbG+iSZR8fzKny7n5JPvO5Fwb8n7uJcWgiNRV
         kKPIgOyV+UrV3d+VBWz6msupgDWIxyGXLmYxtYipifr4EZpLzp1IWCd8uN1O2O/O0vRZ
         +kFOaP8rXGpoW8wBcObAwX+EYFpTKz4e5wMDCVh67sMcWsHSwY+0PlZabDoKG1ErLQwB
         ETiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mGiNT3Qs9w0bMGnUkVvGkILw7vqscHMywq7uSShZLJc=;
        b=iwC3u1Sfy3PYxyuvY7Ee2NOLwratpaTR7Lkt7iHBRNJAu5OzHNZuQM39X2QdKypfYO
         UKjCfDOM+cQ5aSf3evUndoJpwpe10vKWGay6MDu7GY4i5cu+5A9ifuwzijAEe9FxUXFe
         LXQujGr1L2r3s7ZFg4UXIOzzOBHuxCnAFM6xiCX3QsjVo9v4XP/aAN3gvCUptOPcVuKX
         RMVNCPuiQrVe4mUxEz2gA1v3QS9ZDNk71Yw7we+HVoJ0W/CizkRgAuCC93rGHThnSxD3
         D910inDp8nkjvKjpuqRVTDtD3RKd/5zyJNQKNdKto5diX2jMvHeu+b8E4wvcY6J/iHTS
         okGw==
X-Gm-Message-State: AOAM531OlszSM6Sy2JsR2ZHaymdA+hZCxA1cwgSeU5AhPSfmnhW3Zu+S
        4Rtny1yyYohwubP4mhgyOjA=
X-Google-Smtp-Source: ABdhPJwkzNwmWntQehmRGH8jJKNC3TvZPJicJPTcJPUIhutcad3+z1GSQLzWUG4owjZEK4xxWvpOVQ==
X-Received: by 2002:a62:88d4:: with SMTP id l203mr8784568pfd.205.1594823255742;
        Wed, 15 Jul 2020 07:27:35 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id m68sm2666888pje.24.2020.07.15.07.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:27:34 -0700 (PDT)
Date:   Wed, 15 Jul 2020 21:27:33 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] rebase -i: support --committer-date-is-author-date
Message-ID: <20200715142717.GA7803@danh.dev>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200713101045.27335-1-phillip.wood123@gmail.com>
 <20200713101045.27335-3-phillip.wood123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200713101045.27335-3-phillip.wood123@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Phillip,

On 2020-07-13 11:10:42+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index bd93e9742c..2579380729 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -88,6 +88,7 @@ struct rebase_options {
>  	int autosquash;
>  	char *gpg_sign_opt;
>  	int autostash;
> +	int committer_date_is_author_date;
>  	char *cmd;
>  	int allow_empty_message;
>  	int rebase_merges, rebase_cousins;
> @@ -124,6 +125,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>  	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
>  	replay.verbose = opts->flags & REBASE_VERBOSE;
>  	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
> +	replay.committer_date_is_author_date =
> +					opts->committer_date_is_author_date;
>  	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>  	replay.strategy = opts->strategy;
>  
> @@ -1497,9 +1500,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>  		OPT_BOOL(0, "signoff", &options.signoff,
>  			 N_("add a Signed-off-by: line to each commit")),
> -		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
> -				  &options.git_am_opts, NULL,
> -				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
> +		OPT_BOOL(0, "committer-date-is-author-date",
> +			 &options.committer_date_is_author_date,
> +			 N_("make committer date match author date")),
>  		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
>  				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>  		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
> @@ -1794,11 +1797,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	    options.autosquash) {
>  		allow_preemptive_ff = 0;
>  	}
> +	if (options.committer_date_is_author_date)
> +		options.flags |= REBASE_FORCE;
>  
>  	for (i = 0; i < options.git_am_opts.argc; i++) {
>  		const char *option = options.git_am_opts.argv[i], *p;
> -		if (!strcmp(option, "--committer-date-is-author-date") ||
> -		    !strcmp(option, "--ignore-date") ||
> +		if (!strcmp(option, "--ignore-date") ||
>  		    !strcmp(option, "--whitespace=fix") ||
>  		    !strcmp(option, "--whitespace=strip"))
>  			allow_preemptive_ff = 0;
> @@ -1855,6 +1859,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		if (ignore_whitespace)
>  			argv_array_push(&options.git_am_opts,
>  					"--ignore-whitespace");
> +		if (options.committer_date_is_author_date)
> +			argv_array_push(&options.git_am_opts,
> +					"--committer-date-is-author-date");
>  	} else {
>  		/* REBASE_MERGE and PRESERVE_MERGES */
>  		if (ignore_whitespace) {
> diff --git a/sequencer.c b/sequencer.c
> index 6fd2674632..368d397970 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -149,6 +149,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>   * command-line.
>   */
>  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
> +static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
>  static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>  static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
>  static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
> @@ -872,6 +873,22 @@ static char *get_author(const char *message)
>  	return NULL;
>  }
>  
> +static const char *author_date_from_env_array(const struct argv_array *env)
> +{
> +	int i;
> +	const char *date;
> +
> +	for (i = 0; i < env->argc; i++)
> +		if (skip_prefix(env->argv[i],
> +				"GIT_AUTHOR_DATE=", &date))
> +			return date;
> +	/*
> +	 * If GIT_AUTHOR_DATE is missing we should have already errored out when
> +	 * reading the script
> +	 */
> +	BUG("GIT_AUTHOR_DATE missing from author script");
> +}
> +
>  static const char staged_changes_advice[] =
>  N_("you have staged changes in your working tree\n"
>  "If these changes are meant to be squashed into the previous commit, run:\n"
> @@ -938,6 +955,10 @@ static int run_git_commit(struct repository *r,
>  			     gpg_opt, gpg_opt);
>  	}
>  
> +	if (opts->committer_date_is_author_date)
> +		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
> +				 author_date_from_env_array(&cmd.env_array));
> +
>  	argv_array_push(&cmd.args, "commit");
>  
>  	if (!(flags & VERIFY_MSG))
> @@ -1349,6 +1370,31 @@ static int try_to_commit(struct repository *r,
>  		commit_list_insert(current_head, &parents);
>  	}
>  
> +	if (opts->committer_date_is_author_date) {
> +		struct ident_split ident;
> +		struct strbuf date = STRBUF_INIT;
> +
> +		if (split_ident_line(&ident, author, (int)strlen(author)) < 0) {
> +			res = error(_("malformed ident line '%s'"), author);

I've checked with the translation for my native language (vi).
The translators seem to misread ident (as in identity) as
indent (as in indentation).

The translation in po/vi.po:25045 (of v2.28.0-rc0) reads:

	#~ msgid "malformed ident line"
	#~ msgstr "thụt đầu dòng dị hình"

Translating back to English, it reads: "malformed indentation".

Hence, I think it would read better if we write:

	res = error(_("malformed identity line '%s'"), author);

3 more characters is not that much :)

> +			goto out;
> +		}
> +		if (!ident.date_begin) {
> +			res = error(_("corrupted author without date information"));
> +			goto out;
> +		}
> +
> +		strbuf_addf(&date, "@%.*s %.*s",
> +			    (int)(ident.date_end - ident.date_begin),
> +			    ident.date_begin,
> +			    (int)(ident.tz_end - ident.tz_begin),
> +			    ident.tz_begin);
> +		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
> +		strbuf_release(&date);
> +
> +		if (res)
> +			goto out;
> +	}
> +
>  	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
>  		res = error(_("git write-tree failed to write a tree"));
>  		goto out;
> @@ -2532,6 +2578,11 @@ static int read_populate_opts(struct replay_opts *opts)
>  			opts->signoff = 1;
>  		}
>  
> +		if (file_exists(rebase_path_cdate_is_adate())) {
> +			opts->allow_ff = 0;
> +			opts->committer_date_is_author_date = 1;
> +		}
> +
>  		if (file_exists(rebase_path_reschedule_failed_exec()))
>  			opts->reschedule_failed_exec = 1;
>  
> @@ -2622,6 +2673,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>  		write_file(rebase_path_drop_redundant_commits(), "%s", "");
>  	if (opts->keep_redundant_commits)
>  		write_file(rebase_path_keep_redundant_commits(), "%s", "");
> +	if (opts->committer_date_is_author_date)
> +		write_file(rebase_path_cdate_is_adate(), "%s", "");
>  	if (opts->reschedule_failed_exec)
>  		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>  
> @@ -3542,6 +3595,10 @@ static int do_merge(struct repository *r,
>  			goto leave_merge;
>  		}
>  
> +		if (opts->committer_date_is_author_date)
> +			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
> +					 author_date_from_env_array(&cmd.env_array));
> +
>  		cmd.git_cmd = 1;
>  		argv_array_push(&cmd.args, "merge");
>  		argv_array_push(&cmd.args, "-s");
> @@ -3819,7 +3876,8 @@ static int pick_commits(struct repository *r,
>  	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>  	if (opts->allow_ff)
>  		assert(!(opts->signoff || opts->no_commit ||
> -				opts->record_origin || opts->edit));
> +				opts->record_origin || opts->edit ||
> +				opts->committer_date_is_author_date));
>  	if (read_and_refresh_cache(r, opts))
>  		return -1;
>  
> diff --git a/sequencer.h b/sequencer.h
> index 0bee85093e..4ab94119ae 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -45,6 +45,7 @@ struct replay_opts {
>  	int verbose;
>  	int quiet;
>  	int reschedule_failed_exec;
> +	int committer_date_is_author_date;
>  
>  	int mainline;
>  
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index 55ca46786d..c8234062c6 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>  }
>  
>  test_rebase_am_only --whitespace=fix
> -test_rebase_am_only --committer-date-is-author-date
>  test_rebase_am_only -C4
>  
>  test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
> index 4f8a6e51c9..50a63d8ebe 100755
> --- a/t/t3436-rebase-more-options.sh
> +++ b/t/t3436-rebase-more-options.sh
> @@ -9,6 +9,9 @@ test_description='tests to ensure compatibility between am and interactive backe
>  
>  . "$TEST_DIRECTORY"/lib-rebase.sh
>  
> +GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
> +export GIT_AUTHOR_DATE
> +
>  # This is a special case in which both am and interactive backends
>  # provide the same output. It was done intentionally because
>  # both the backends fall short of optimal behaviour.
> @@ -21,11 +24,20 @@ test_expect_success 'setup' '
>  	test_write_lines "line 1" "new line 2" "line 3" >file &&
>  	git commit -am "update file" &&
>  	git tag side &&
> +	test_commit commit1 foo foo1 &&
> +	test_commit commit2 foo foo2 &&
> +	test_commit commit3 foo foo3 &&
>  
>  	git checkout --orphan master &&
> +	rm foo &&
>  	test_write_lines "line 1" "        line 2" "line 3" >file &&
>  	git commit -am "add file" &&
> -	git tag main
> +	git tag main &&
> +
> +	mkdir test-bin &&
> +	write_script test-bin/git-merge-test <<-\EOF
> +	exec git-merge-recursive "$@"
> +	EOF
>  '
>  
>  test_expect_success '--ignore-whitespace works with apply backend' '
> @@ -52,6 +64,50 @@ test_expect_success '--ignore-whitespace is remembered when continuing' '
>  	git diff --exit-code side
>  '
>  
> +test_ctime_is_atime () {
> +	git log $1 --format=%ai >authortime &&
> +	git log $1 --format=%ci >committertime &&
> +	test_cmp authortime committertime
> +}
> +
> +test_expect_success '--committer-date-is-author-date works with apply backend' '
> +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
> +	git rebase --apply --committer-date-is-author-date HEAD^ &&
> +	test_ctime_is_atime -1
> +'
> +
> +test_expect_success '--committer-date-is-author-date works with merge backend' '
> +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
> +	git rebase -m --committer-date-is-author-date HEAD^ &&
> +	test_ctime_is_atime -1
> +'
> +
> +test_expect_success '--committer-date-is-author-date works with rebase -r' '
> +	git checkout side &&
> +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
> +	git rebase -r --root --committer-date-is-author-date &&
> +	test_ctime_is_atime
> +'
> +
> +test_expect_success '--committer-date-is-author-date works when forking merge' '
> +	git checkout side &&
> +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
> +	PATH="./test-bin:$PATH" git rebase -r --root --strategy=test \
> +					--committer-date-is-author-date &&
> +	test_ctime_is_atime
> +'
> +
> +test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
> +	git checkout commit2 &&
> +	GIT_AUTHOR_DATE="@1980 +0000" git commit --amend --only --reset-author &&
> +	test_must_fail git rebase -m --committer-date-is-author-date \
> +		--onto HEAD^^ HEAD^ &&
> +	echo resolved > foo &&

Nitpick: no space after ">" :D

-- 
Danh
