Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0D0C6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 18:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCBSCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 13:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCBSCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 13:02:32 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785FB5653E
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 10:02:30 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id i6-20020a170902c94600b0019d16e4ac0bso45964pla.5
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 10:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OZyciY6NZ/Pe6Is8wuNEmdwnEacAiLVPEVGm8hyJ5Co=;
        b=D7ZmKsZzU3NqRuW/3UKZtCVdIntso+0ZGSk49E5e04HW9kQs94cRYC3Mh4MFl7OYsb
         FCGhTp81C28L93KD/gQvuGGhZZ5gvFESHINOZVc8kKW/OCtOTklsrxDMnQCucHRrpsau
         cRkbwX5o/CgicWfKVo2Mkf0RBt7Is8luYdn7r+7SFmtpDnhRnc7GT2sq+I86nQbJTtgW
         mPA5n0YyEQ4LBJj4mQCL45Z9uDPPi0nKvBelrHNUXHeREicXsH8I2WX3aMx5doYOBSKx
         A8OmY0BjE5AxHP7eHR6zQB5qrTE7SQE0AMJeAsk9tT888HLQA+fJas+CkiFuXfJTP/Ly
         dCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZyciY6NZ/Pe6Is8wuNEmdwnEacAiLVPEVGm8hyJ5Co=;
        b=a/UsGl+t3dSBqRn6lf/OyF8RRKCVf0rFDUNDvf3Rl+L/cva7tuBZZ+414Gb+2HynWg
         FXCbAuVKXg0EgUK5w7e4rkvdyjbiHeDGLSc6YcmrIL5neyfmMtCom8NAmICsmT3PIjJr
         Nn+Mxl9pBjfWkfJpXgsYpueOtJALcIqFvY8iio5laa+fsRhWMHrcmbYW732+hrUtec3k
         B2Gagds3R/L2wwDb4Q5yxxAauPlDX1wKpFdvRFUefHl6FLrKdBgOYcVU/4BpqzEI7xr6
         F59cFR4zRTdXBkZ2JCmt4RcxeABVz6oEq06k6LgaMPrHZh6eprb8nxwDafSGOjazpz4Z
         +NSQ==
X-Gm-Message-State: AO0yUKWsex2yOMRndgImkmBkRUmEqagBZ9ljuQ02R+Z2pW8v/doAgBag
        UF76Y7HN8V3qphVoEnEC/xozgJvOKzBI0tM=
X-Google-Smtp-Source: AK7set9mbN/cdIULinNyt/cNCPwJdMkRe6mANH4LtpF0c08Ncjf5SwuZiD67kpg4Tu0mU+VKZX/MIf3nhvaLWYo=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:be1:b0:5a8:a475:918f with SMTP
 id x33-20020a056a000be100b005a8a475918fmr4386468pfu.4.1677780150073; Thu, 02
 Mar 2023 10:02:30 -0800 (PST)
Date:   Thu,  2 Mar 2023 18:02:26 +0000
In-Reply-To: <20230225180325.796624-4-alexhenrie24@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230302180226.2699247-1-calvinwan@google.com>
Subject: Re: [PATCH v5 3/3] rebase: add a config option for --rebase-merges
From:   Calvin Wan <calvinwan@google.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +
> +rebase.merges::
> +	Whether and how to set the `--rebase-merges` option by default. Can
> +	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
> +	true is equivalent to `--rebase-merges` without an argument, setting to
> +	`rebase-cousins` or `no-rebase-cousins` is equivalent to
> +	`--rebase-merges` with that value as its argument, and setting to false
> +	is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
> +	command line without an argument overrides a `rebase.merges=false`
> +	configuration but does not override other values of `rebase.merge`.

I originally believed that having the boolean values as an option here
created unnecessary complexity but I was convinced during Review Club
that the tradeoff for a user who just wants to turn this on is fine. I'm
just wondering whether this option will possibly have additional values
in the future. If so, what would a user expect from setting this config
to true?

Small typo at the end s/rebase.merge/rebase.merges

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index c98784a0d2..b02f9cbb8c 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -537,7 +537,8 @@ See also INCOMPATIBLE OPTIONS below.
>  	by recreating the merge commits. Any resolved merge conflicts or
>  	manual amendments in these merge commits will have to be
>  	resolved/re-applied manually. `--no-rebase-merges` can be used to
> -	countermand a previous `--rebase-merges`.
> +	countermand both the `rebase.merges` config option and a previous
> +	`--rebase-merges`.
>  +
>  By default, or when `no-rebase-cousins` was specified, commits which do not
>  have `<upstream>` as direct ancestor will keep their original branch point,
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index ccc13200b5..ac096f27e1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -123,6 +123,7 @@ struct rebase_options {
>  	int fork_point;
>  	int update_refs;
>  	int config_autosquash;
> +	int config_rebase_merges;
>  	int config_update_refs;
>  };
>  
> @@ -140,6 +141,8 @@ struct rebase_options {
>  		.allow_empty_message = 1,               \
>  		.autosquash = -1,                       \
>  		.config_autosquash = -1,                \
> +		.rebase_merges = -1,                    \
> +		.config_rebase_merges = -1,             \
>  		.update_refs = -1,                      \
>  		.config_update_refs = -1,               \
>  	}
> @@ -771,6 +774,16 @@ static int run_specific_rebase(struct rebase_options *opts)
>  	return status ? -1 : 0;
>  }
>  
> +static void parse_rebase_merges_value(struct rebase_options *options, const char *value)
> +{
> +	if (!strcmp("no-rebase-cousins", value))
> +		options->rebase_cousins = 0;
> +	else if (!strcmp("rebase-cousins", value))
> +		options->rebase_cousins = 1;
> +	else
> +		die(_("Unknown rebase-merges mode: %s"), value);
> +}
> +
>  static int rebase_config(const char *var, const char *value, void *data)
>  {
>  	struct rebase_options *opts = data;
> @@ -800,6 +813,15 @@ static int rebase_config(const char *var, const char *value, void *data)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "rebase.merges")) {
> +		opts->config_rebase_merges = git_parse_maybe_bool(value);
> +		if (opts->config_rebase_merges < 0) {
> +			opts->config_rebase_merges = 1;
> +			parse_rebase_merges_value(opts, value);
> +		}
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "rebase.updaterefs")) {
>  		opts->config_update_refs = git_config_bool(var, value);
>  		return 0;
> @@ -980,6 +1002,27 @@ static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> +static int parse_opt_rebase_merges(const struct option *opt, const char *arg, int unset)
> +{
> +	struct rebase_options *options = opt->value;
> +
> +	options->rebase_merges = !unset;
> +
> +	if (arg) {
> +		if (!*arg) {
> +			warning(_("--rebase-merges with an empty string "
> +				  "argument is deprecated and will stop "
> +				  "working in a future version of Git. Use "
> +				  "--rebase-merges=no-rebase-cousins "
> +				  "instead."));
> +			arg = "no-rebase-cousins";
> +		}
> +		parse_rebase_merges_value(options, arg);
> +	}
> +
> +	return 0;
> +}
> +
>  static void NORETURN error_on_missing_default_upstream(void)
>  {
>  	struct branch *current_branch = branch_get(NULL);
> @@ -1035,7 +1078,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	struct object_id branch_base;
>  	int ignore_whitespace = 0;
>  	const char *gpg_sign = NULL;
> -	const char *rebase_merges = NULL;
>  	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
>  	struct object_id squash_onto;
>  	char *squash_onto_name = NULL;
> @@ -1137,10 +1179,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			   &options.allow_empty_message,
>  			   N_("allow rebasing commits with empty messages"),
>  			   PARSE_OPT_HIDDEN),
> -		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
> -			N_("mode"),
> +		OPT_CALLBACK_F('r', "rebase-merges", &options, N_("mode"),
>  			N_("try to rebase merges instead of skipping them"),
> -			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
> +			PARSE_OPT_OPTARG, parse_opt_rebase_merges),
>  		OPT_BOOL(0, "fork-point", &options.fork_point,
>  			 N_("use 'merge-base --fork-point' to refine upstream")),
>  		OPT_STRING('s', "strategy", &options.strategy,
> @@ -1436,21 +1477,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	if (options.exec.nr)
>  		imply_merge(&options, "--exec");
>  
> -	if (rebase_merges) {
> -		if (!*rebase_merges)
> -			warning(_("--rebase-merges with an empty string "
> -				  "argument is deprecated and will stop "
> -				  "working in a future version of Git. Use "
> -				  "--rebase-merges=no-rebase-cousins "
> -				  "instead."));
> -		else if (!strcmp("rebase-cousins", rebase_merges))
> -			options.rebase_cousins = 1;
> -		else if (strcmp("no-rebase-cousins", rebase_merges))
> -			die(_("Unknown mode: %s"), rebase_merges);
> -		options.rebase_merges = 1;
> -		imply_merge(&options, "--rebase-merges");
> -	}
> -
>  	if (options.type == REBASE_APPLY) {
>  		if (ignore_whitespace)
>  			strvec_push(&options.git_am_opts,
> @@ -1513,13 +1539,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  				break;
>  
>  		if (i >= 0 || options.type == REBASE_APPLY) {
> -			if (is_merge(&options))
> -				die(_("apply options and merge options "
> -					  "cannot be used together"));
> -			else if (options.autosquash == -1 && options.config_autosquash == 1)
> +			if (options.autosquash == -1 && options.config_autosquash == 1)
>  				die(_("apply options are incompatible with rebase.autosquash.  Consider adding --no-autosquash"));
> +			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
> +				die(_("apply options are incompatible with rebase.merges.  Consider adding --no-rebase-merges"));
>  			else if (options.update_refs == -1 && options.config_update_refs == 1)
>  				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
> +			else if (is_merge(&options))
> +				die(_("apply options and merge options "
> +					  "cannot be used together"));
>  			else
>  				options.type = REBASE_APPLY;
>  		}
> @@ -1530,6 +1558,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	options.update_refs = (options.update_refs >= 0) ? options.update_refs :
>  			     ((options.config_update_refs >= 0) ? options.config_update_refs : 0);
>  
> +	if (options.rebase_merges == 1)
> +		imply_merge(&options, "--rebase-merges");
> +	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
> +				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
> +
>  	if (options.autosquash == 1)
>  		imply_merge(&options, "--autosquash");
>  	options.autosquash = (options.autosquash >= 0) ? options.autosquash :
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index 4711b37a28..af93f13849 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -101,6 +101,12 @@ test_rebase_am_only () {
>  		grep -e --no-autosquash err
>  	"
>  
> +	test_expect_success "$opt incompatible with rebase.merges" "
> +		git checkout B^0 &&
> +		test_must_fail git -c rebase.merges=true rebase $opt A 2>err &&
> +		grep -e --no-rebase-merges err
> +	"
> +

Missing an additional test here "$opt incompatible with --rebase-merges"
to match the test patterns from the other option/config combos.

>  	test_expect_success "$opt incompatible with rebase.updateRefs" "
>  		git checkout B^0 &&
>  		test_must_fail git -c rebase.updateRefs=true rebase $opt A 2>err &&
> @@ -113,6 +119,12 @@ test_rebase_am_only () {
>  		git -c rebase.autosquash=true rebase --no-autosquash $opt A
>  	"
>  
> +	test_expect_success "$opt okay with overridden rebase.merges" "
> +		test_when_finished \"git reset --hard B^0\" &&
> +		git checkout B^0 &&
> +		git -c rebase.merges=true rebase --no-rebase-merges $opt A
> +	"
> +
>  	test_expect_success "$opt okay with overridden rebase.updateRefs" "
>  		test_when_finished \"git reset --hard B^0\" &&
>  		git checkout B^0 &&
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index f50fbf1390..a825a77fb4 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -283,6 +283,69 @@ test_expect_success '--rebase-merges="" is deprecated' '
>  	grep deprecated actual
>  '
>  
> +test_expect_success 'rebase.merges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
> +	test_config rebase.merges rebase-cousins &&
> +	git checkout -b config-rebase-cousins main &&
> +	git rebase HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	|/
> +	o H
> +	EOF
> +'
> +
> +test_expect_success '--no-rebase-merges overrides rebase.merges=no-rebase-cousins' '
> +	test_config rebase.merges no-rebase-cousins &&
> +	git checkout -b override-config-no-rebase-cousins E &&
> +	git rebase --no-rebase-merges C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
> +test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.merges=rebase-cousins' '
> +	test_config rebase.merges rebase-cousins &&
> +	git checkout -b override-config-rebase-cousins main &&
> +	git rebase --rebase-merges=no-rebase-cousins HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	o | H
> +	|/
> +	o A
> +	EOF
> +'
> +
> +test_expect_success '--rebase-merges overrides rebase.merges=false' '
> +	test_config rebase.merges false &&
> +	git checkout -b override-config-merges-false E &&
> +	before="$(git rev-parse --verify HEAD)" &&
> +	test_tick &&
> +	git rebase --rebase-merges C &&
> +	test_cmp_rev HEAD $before
> +'
> +
> +test_expect_success '--rebase-merges does not override rebase.merges=rebase-cousins' '
> +	test_config rebase.merges rebase-cousins &&
> +	git checkout -b no-override-config-rebase-cousins main &&
> +	git rebase --rebase-merges HEAD^ &&
> +	test_cmp_graph HEAD^.. <<-\EOF
> +	*   Merge the topic branch '\''onebranch'\''
> +	|\
> +	| * D
> +	| * G
> +	|/
> +	o H
> +	EOF
> +'
> +
>  test_expect_success 'refs/rewritten/* is worktree-local' '
>  	git worktree add wt &&
>  	cat >wt/script-from-scratch <<-\EOF &&
> -- 
> 2.39.2
> 
> 
> 
