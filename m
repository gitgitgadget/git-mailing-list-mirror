Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9705AC07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 08:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA2461245
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 08:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhGEIz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 04:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGEIz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 04:55:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B98C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 01:53:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n9so3773000wrs.13
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 01:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fYgFW9+t1UyvcBqXAwDHaZo/cksXVkHBAky1E/kHpF4=;
        b=TsSvS7MY3thuI5LJI5s0epbOpd1vvkAqeIvoLbUIEBLkl+//7muTO50Ai3DuPTXvAH
         TdJ2ToR92P0u0f1Y6/W3X/SSw1U4PAsuAkqtB5fT9JK1HzDz4FyBgGPskc/cO8iealq4
         0O98sJ0dAqQOQcY3x1XuwQhwx0D2DNuEVef0enXDbyFyFoNoXrMjTdXvKr6tkDeX6nfS
         3RzOfJ0uFxStU7UVIzPtAIjP8fqG/JNCWlgNzwCSrsC4/rCBN46UjT5Lq/gvQ7JR4qdv
         1gItjabx0qqMD0GqZjLwcCkkbRCvTF3Bk+CNXQYylpMFXHes3WGpJ/SgxtY/mGcsXPMo
         tOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYgFW9+t1UyvcBqXAwDHaZo/cksXVkHBAky1E/kHpF4=;
        b=jJZxDqBHO6T0hY3E55Ts7GQvMmfp6nj8MGv5quR5bP39pXEBvyH9HRfnIxnluqgt96
         VWy7RTVV36imSu8bGcV7mE/+WQJNTztvbefU5yPM514ihbs05GPljbiVug+fnAr9Zas9
         qqWOU6wMhj98zDZzrlLZkHH3EweLoibzAxNbQonGl4eryv8Mu2jakOkkyxb8RahhVlFw
         PwoRBel1mpo0QxkClrosAL1a3Mmyjg2qjwJghTbwugVFfPV06HFMc6xMuLUjRPxQLzXZ
         KvHcq6cYfmjEkSk71+ps9fmeqHtooUuiZiDuGYftxJ2W/KV7VMRtYrYgnMGEfqJAHyOe
         /vlQ==
X-Gm-Message-State: AOAM530hAO11A3T8sh7OxH9A+G520z7AqSiJVjVlLRU77Oc5U2LNzYcI
        QrCLPQNNao4VnK8tReFTNzhrQaveySE=
X-Google-Smtp-Source: ABdhPJwyUr4wBca/5csJC/jhtcrAWTWrO37BR214J1U95JLi+H0cXI3x/mUhQ7wpn24BaRTPJ4zcPg==
X-Received: by 2002:a5d:508e:: with SMTP id a14mr14750407wrt.92.1625475199710;
        Mon, 05 Jul 2021 01:53:19 -0700 (PDT)
Received: from [192.168.1.240] (118.22.198.146.dyn.plus.net. [146.198.22.118])
        by smtp.gmail.com with ESMTPSA id j37sm9084986wms.37.2021.07.05.01.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 01:53:19 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, newren@gmail.com
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <349748b4-3c48-7ca7-eb0f-e859a15cab0f@gmail.com>
Date:   Mon, 5 Jul 2021 09:53:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705044505.666977-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 05/07/2021 05:45, Alex Henrie wrote:
> The warning about pulling without specifying how to reconcile divergent
> branches says that after setting pull.rebase to true, --ff-only can
> still be passed on the command line to require a fast-forward. Make that
> actually work.

As I understand it the motivation for this change is to have 'git -c 
pull.rebase=true pull --ff-only' actually fast forward. Why cant we just 
change pull not to rebase in that case? I've left some comments about 
the rebase changes below

 > [...]
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 12f093121d..b88f0cbcca 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1345,12 +1349,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			 N_("ignore changes in whitespace")),
>   		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
>   				  N_("action"), N_("passed to 'git apply'"), 0),
> -		OPT_BIT('f', "force-rebase", &options.flags,
> -			N_("cherry-pick all commits, even if unchanged"),
> -			REBASE_FORCE),
> -		OPT_BIT(0, "no-ff", &options.flags,
> -			N_("cherry-pick all commits, even if unchanged"),
> -			REBASE_FORCE),
> +		OPT_SET_INT_F('f', "force-rebase", &options.fast_forward,
> +			      N_("cherry-pick all commits, even if unchanged"),
> +			      FF_NO, PARSE_OPT_NONEG),

Why does this change rebase to start rejecting --no-force-rebase? This 
is the sort of behavior change that deserves a mention in the commit 
message.

> +		OPT_SET_INT(0, "ff", &options.fast_forward, N_("allow fast-forward"),
> +			    FF_ALLOW),

The useful option when rebasing is '--no-ff', now that will no longer 
appear in the output of 'git rebase -h'

> +		OPT_SET_INT_F(0, "ff-only", &options.fast_forward,
> +			      N_("abort if fast-forward is not possible"),
> +			      FF_ONLY, PARSE_OPT_NONEG),

Is there a use for this outside of 'git pull --ff-only'? I'm far from 
convinced we want this new option but if we do end up adding it I think 
it should error out in combination with '-i' or '-x' as '-i' implies the 
user wants to change the existing commits and '-x' can end up changing 
them as well.

I think this patch addresses a valid problem but it seems to me that the 
approach taken pushes complexity into rebase to handle a case when pull 
does not need to invoke rebase in the first place.

Best Wishes

Phillip

>   		OPT_CMDMODE(0, "continue", &action, N_("continue"),
>   			    ACTION_CONTINUE),
>   		OPT_CMDMODE(0, "skip", &action,
> @@ -1635,7 +1641,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		allow_preemptive_ff = 0;
>   	}
>   	if (options.committer_date_is_author_date || options.ignore_date)
> -		options.flags |= REBASE_FORCE;
> +		options.fast_forward = FF_NO;
>   
>   	for (i = 0; i < options.git_am_opts.nr; i++) {
>   		const char *option = options.git_am_opts.v[i], *p;
> @@ -1809,7 +1815,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			die("cannot combine '--signoff' with "
>   			    "'--preserve-merges'");
>   		strvec_push(&options.git_am_opts, "--signoff");
> -		options.flags |= REBASE_FORCE;
> +		options.fast_forward = FF_NO;
>   	}
>   
>   	if (options.type == REBASE_PRESERVE_MERGES) {
> @@ -1952,6 +1958,24 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (repo_read_index(the_repository) < 0)
>   		die(_("could not read index"));
>   
> +	/*
> +	 * Check if we are already based on onto with linear history,
> +	 * in which case we could fast-forward without replacing the commits
> +	 * with new commits recreated by replaying their changes.
> +	 *
> +	 * Note that can_fast_forward() initializes merge_base, so we have to
> +	 * call it before checking allow_preemptive_ff.
> +	 */
> +	allow_preemptive_ff = can_fast_forward(options.onto, options.upstream,
> +					       options.restrict_revision,
> +					       &options.orig_head, &merge_base)
> +			      && allow_preemptive_ff;
> +
> +	if (!allow_preemptive_ff && options.fast_forward == FF_ONLY) {
> +		ret = error_ff_impossible();
> +		goto cleanup;
> +	}
> +
>   	if (options.autostash) {
>   		create_autostash(the_repository, state_dir_path("autostash", &options),
>   				 DEFAULT_REFLOG_ACTION);
> @@ -1968,20 +1992,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	 * everything leading up to orig_head) on top of onto.
>   	 */
>   
> -	/*
> -	 * Check if we are already based on onto with linear history,
> -	 * in which case we could fast-forward without replacing the commits
> -	 * with new commits recreated by replaying their changes.
> -	 *
> -	 * Note that can_fast_forward() initializes merge_base, so we have to
> -	 * call it before checking allow_preemptive_ff.
> -	 */
> -	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
> -		    &options.orig_head, &merge_base) &&
> -	    allow_preemptive_ff) {
> +	if (allow_preemptive_ff) {
>   		int flag;
>   
> -		if (!(options.flags & REBASE_FORCE)) {
> +		if (options.fast_forward != FF_NO) {
>   			/* Lazily switch to the target branch if needed... */
>   			if (options.switch_to) {
>   				strbuf_reset(&buf);
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 237f2f18d4..f9b61478a2 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -123,7 +123,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   	if (opts->action == REPLAY_PICK) {
>   		struct option cp_extra[] = {
>   			OPT_BOOL('x', NULL, &opts->record_origin, N_("append commit name")),
> -			OPT_BOOL(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
> +			OPT_SET_INT(0, "ff", &opts->fast_forward, N_("allow fast-forward"), FF_ALLOW),
>   			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
>   			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
>   			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
> @@ -166,7 +166,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   				"--strategy", opts->strategy ? 1 : 0,
>   				"--strategy-option", opts->xopts ? 1 : 0,
>   				"-x", opts->record_origin,
> -				"--ff", opts->allow_ff,
> +				"--ff", opts->fast_forward == FF_ALLOW,
>   				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
>   				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
>   				NULL);
> @@ -177,7 +177,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   		opts->default_strategy = NULL;
>   	}
>   
> -	if (opts->allow_ff)
> +	if (opts->fast_forward == FF_ALLOW)
>   		verify_opt_compatible(me, "--ff",
>   				"--signoff", opts->signoff,
>   				"--no-commit", opts->no_commit,
> diff --git a/sequencer.c b/sequencer.c
> index 0bec01cf38..84447937d2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2120,18 +2120,23 @@ static int do_pick_commit(struct repository *r,
>   		return error(_("cannot get commit message for %s"),
>   			oid_to_hex(&commit->object.oid));
>   
> -	if (opts->allow_ff && !is_fixup(command) &&
> -	    ((parent && oideq(&parent->object.oid, &head)) ||
> -	     (!parent && unborn))) {
> -		if (is_rebase_i(opts))
> -			write_author_script(msg.message);
> -		res = fast_forward_to(r, &commit->object.oid, &head, unborn,
> -			opts);
> -		if (res || command != TODO_REWORD)
> +	if (opts->fast_forward != FF_NO) {
> +		if (!is_fixup(command) &&
> +		    ((parent && oideq(&parent->object.oid, &head)) ||
> +		     (!parent && unborn))) {
> +			if (is_rebase_i(opts))
> +				write_author_script(msg.message);
> +			res = fast_forward_to(r, &commit->object.oid, &head, unborn,
> +				opts);
> +			if (res || command != TODO_REWORD)
> +				goto leave;
> +			reword = 1;
> +			msg_file = NULL;
> +			goto fast_forward_edit;
> +		} else if (opts->fast_forward == FF_ONLY) {
> +			res = error_ff_impossible();
>   			goto leave;
> -		reword = 1;
> -		msg_file = NULL;
> -		goto fast_forward_edit;
> +		}
>   	}
>   	if (parent && parse_commit(parent) < 0)
>   		/* TRANSLATORS: The first %s will be a "todo" command like
> @@ -2764,7 +2769,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>   	else if (!strcmp(key, "options.record-origin"))
>   		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
>   	else if (!strcmp(key, "options.allow-ff"))
> -		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
> +		opts->fast_forward = git_config_bool_or_int(key, value, &error_flag) ? FF_ALLOW : FF_NO;
>   	else if (!strcmp(key, "options.mainline"))
>   		opts->mainline = git_config_int(key, value);
>   	else if (!strcmp(key, "options.strategy"))
> @@ -2853,17 +2858,17 @@ static int read_populate_opts(struct replay_opts *opts)
>   			opts->quiet = 1;
>   
>   		if (file_exists(rebase_path_signoff())) {
> -			opts->allow_ff = 0;
> +			opts->fast_forward = FF_NO;
>   			opts->signoff = 1;
>   		}
>   
>   		if (file_exists(rebase_path_cdate_is_adate())) {
> -			opts->allow_ff = 0;
> +			opts->fast_forward = FF_NO;
>   			opts->committer_date_is_author_date = 1;
>   		}
>   
>   		if (file_exists(rebase_path_ignore_date())) {
> -			opts->allow_ff = 0;
> +			opts->fast_forward = FF_NO;
>   			opts->ignore_date = 1;
>   		}
>   
> @@ -3320,7 +3325,7 @@ static int save_opts(struct replay_opts *opts)
>   	if (opts->record_origin)
>   		res |= git_config_set_in_file_gently(opts_file,
>   					"options.record-origin", "true");
> -	if (opts->allow_ff)
> +	if (opts->fast_forward == FF_ALLOW)
>   		res |= git_config_set_in_file_gently(opts_file,
>   					"options.allow-ff", "true");
>   	if (opts->mainline) {
> @@ -3849,9 +3854,9 @@ static int do_merge(struct repository *r,
>   	 * If HEAD is not identical to the first parent of the original merge
>   	 * commit, we cannot fast-forward.
>   	 */
> -	can_fast_forward = opts->allow_ff && commit && commit->parents &&
> -		oideq(&commit->parents->item->object.oid,
> -		      &head_commit->object.oid);
> +	can_fast_forward = opts->fast_forward != FF_NO && commit &&
> +		commit->parents && oideq(&commit->parents->item->object.oid,
> +					 &head_commit->object.oid);
>   
>   	/*
>   	 * If any merge head is different from the original one, we cannot
> @@ -3885,6 +3890,11 @@ static int do_merge(struct repository *r,
>   		goto leave_merge;
>   	}
>   
> +	if (opts->fast_forward == FF_ONLY && !can_fast_forward) {
> +		ret = error_ff_impossible();
> +		goto leave_merge;
> +	}
> +
>   	if (strategy || to_merge->next) {
>   		/* Octopus merge */
>   		struct child_process cmd = CHILD_PROCESS_INIT;
> @@ -4276,7 +4286,7 @@ static int pick_commits(struct repository *r,
>   	/* Note that 0 for 3rd parameter of setenv means set only if not set */
>   	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>   	prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
> -	if (opts->allow_ff)
> +	if (opts->fast_forward != FF_NO)
>   		assert(!(opts->signoff || opts->no_commit ||
>   			 opts->record_origin || should_edit(opts) ||
>   			 opts->committer_date_is_author_date ||
> @@ -5646,7 +5656,8 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   		BUG("invalid todo list after expanding IDs:\n%s",
>   		    new_todo.buf.buf);
>   
> -	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
> +	if (opts->fast_forward != FF_NO
> +	    && skip_unnecessary_picks(r, &new_todo, &oid)) {
>   		todo_list_release(&new_todo);
>   		return error(_("could not skip unnecessary pick commands"));
>   	}
> diff --git a/sequencer.h b/sequencer.h
> index d57d8ea23d..e188dec312 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -28,6 +28,12 @@ enum commit_msg_cleanup_mode {
>   	COMMIT_MSG_CLEANUP_ALL
>   };
>   
> +enum ff_type {
> +	FF_NO,
> +	FF_ALLOW,
> +	FF_ONLY
> +};
> +
>   struct replay_opts {
>   	enum replay_action action;
>   
> @@ -38,7 +44,6 @@ struct replay_opts {
>   	int record_origin;
>   	int no_commit;
>   	int signoff;
> -	int allow_ff;
>   	int allow_rerere_auto;
>   	int allow_empty;
>   	int allow_empty_message;
> @@ -50,6 +55,8 @@ struct replay_opts {
>   	int committer_date_is_author_date;
>   	int ignore_date;
>   
> +	enum ff_type fast_forward;
> +
>   	int mainline;
>   
>   	char *gpg_sign;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 66bcbbf952..858e406725 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -895,6 +895,11 @@ test_expect_success 'always cherry-pick with --no-ff' '
>   	test_must_be_empty out
>   '
>   
> +test_expect_success 'interactive rebase prevents non-fast-forward with --ff-only' '
> +	git checkout primary &&
> +	test_must_fail git rebase -i --ff-only branch1
> +'
> +
>   test_expect_success 'set up commits with funny messages' '
>   	git checkout -b funny A &&
>   	echo >>file1 &&
> diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
> index ec8062a66a..e656b5bd28 100755
> --- a/t/t3409-rebase-preserve-merges.sh
> +++ b/t/t3409-rebase-preserve-merges.sh
> @@ -127,4 +127,8 @@ test_expect_success 'rebase -p ignores merge.log config' '
>   	)
>   '
>   
> +test_expect_success 'rebase -p prevents non-fast-forward with --ff-only' '
> +	test_must_fail git rebase -p --ff-only main
> +'
> +
>   test_done
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index 43fcb68f27..69a85cb645 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -246,6 +246,15 @@ test_expect_success "rebase: fast-forward rebase" '
>   	git checkout feature-branch
>   '
>   
> +test_expect_success "rebase: impossible fast-forward rebase" '
> +	test_config rebase.autostash true &&
> +	git reset --hard &&
> +	echo dirty >>file1 &&
> +	(git rebase --ff-only unrelated-onto-branch || true) &&
> +	grep dirty file1 &&
> +	git checkout feature-branch
> +'
> +
>   test_expect_success "rebase: noop rebase" '
>   	test_config rebase.autostash true &&
>   	git reset --hard &&
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index 52e8ccc933..af260b9faa 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -183,6 +183,16 @@ test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
>   	test_must_fail git pull . c3
>   '
>   
> +test_expect_success 'pull prevents non-fast-forward with --rebase --ff-only' '
> +	git reset --hard c1 &&
> +	test_must_fail git pull --rebase --ff-only . c3
> +'
> +
> +test_expect_success 'pull prevents non-fast-forward with --no-rebase --ff-only' '
> +	git reset --hard c1 &&
> +	test_must_fail git pull --no-rebase --ff-only . c3
> +'
> +
>   test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
>   	git reset --hard c1 &&
>   	git config pull.twohead ours &&
> 
