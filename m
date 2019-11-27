Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6BFC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCB920665
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0cJm1uV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfK0Png (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:43:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50695 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK0Png (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 10:43:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so7609716wmh.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 07:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EcFVq88FgTmUfjSELL3aebN+F/HCSEsWv/S2AkhNhbE=;
        b=F0cJm1uVGQ3UWPSc7OoduCLvSmOnTIfhzLMKVhmi2BJ1dJEtu+NrDn9jcG4qbuKcAL
         3T2Yz6tKz9jmi98cDnTDpxtIM8CN7tpM7fpajYSznX+nHmyM/LPGjc6mHaHx2I4ePdsM
         nLba48BlMTTdO8MQMBwQsBwPJWD5WY1Lf6HfKalaAYWGJhgCFvnmS5cGgBO2ZpM+KKUj
         OXauAomptAqT9mXCtChQWNChvS5YTNSP4XcDlY2BpnwbpteBnvpCXNXvfR6vspNfgkOg
         xyiupsj8y460OypyagFMrBn0xvyTVjwoWImRE2UeXQagJSkzsqqY/zUREDAcgXzNtKZD
         +Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EcFVq88FgTmUfjSELL3aebN+F/HCSEsWv/S2AkhNhbE=;
        b=hwASifhwus1gRT5shkOIWfe11F7IEi94uvbUI1lQwfazHvcqHPKSCIbXWJugEkPy1i
         C5cW6+YpIzByBzhj7O2PanE0eB7mOvC2ZP1XBoyBQAECzBxWaTc7uMP0ra5at2xJ7NAi
         0lju0kL7lM3Qk9k+ZvTX3HHjBbHMXd26j3zsXZW1CSOoBI683w1jPb2zOGh4kESAAYpk
         SkBJURGmhx53i0Rbj5y9WfU223EuY4HrM8+pUY+nuBWGFjAOyv/UjjkvfWarM+7stIFb
         Six9wuEYip2hk4TwDjK/svUvPYh+pJyL+skwaON9v5IljKQLFxAUrkobvo1fKnEYIrKU
         d+SQ==
X-Gm-Message-State: APjAAAUnlJVJgBVT291JiSKzCl6rB5jlTRbt36KfpwiIJnkoyShb3zu6
        JbIB3gRiAXAtIhFFYO/e59ukdfW4
X-Google-Smtp-Source: APXvYqyQz3lgJVD+6p+J2Q83qCeqdzlw9JoP9pA7IJcEuaX/f20w1SsYDl1jztGmO35Fa+fQhoY3LQ==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr5237908wmj.39.1574869412901;
        Wed, 27 Nov 2019 07:43:32 -0800 (PST)
Received: from evledraar (h53132.upc-h.chello.nl. [62.194.53.132])
        by smtp.gmail.com with ESMTPSA id k16sm6828652wru.0.2019.11.27.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 07:43:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 2/2] checkout: die() on ambiguous tracking branches
References: <pull.477.git.1574848137.gitgitgadget@gmail.com> <7dde1a3b4e4e76cd1a820b5277f694fdfad3a922.1574848137.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <7dde1a3b4e4e76cd1a820b5277f694fdfad3a922.1574848137.git.gitgitgadget@gmail.com>
Date:   Wed, 27 Nov 2019 16:43:31 +0100
Message-ID: <87v9r5nx3w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 27 2019, Alexandr Miloslavskiy via GitGitGadget wrote:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> Before this patch, when there were multiple DWIM candidates for remote
> branch, git decided to try the argument as pathspec instead. I believe
> that such behavior is a surprise: adding another remote suddenly causes
> git to discard file contents, because it was unsure which branch to
> pick. There was an incomplete attempt to prevent that in [3].
>
> I understand that this was never intended:
>
>   [1] introduces the unexpected behavior. Before, there was fallback
>   from not-a-ref to pathspec. This is reasonable DWIM. After, there is
>   another fallback from ambiguous-remote to pathspec. I understand that
>   it was kind of copy&paste oversight.
>
>   [2] noticed the unexpected behavior but chose to semi-document it
>   instead of forbidding, because the goal of the patch series was
>   focused on something else.
>
>   [3] adds `die()` when there is ambiguity between branch and file. The
>   case of multiple tracking branches is seemingly overlooked.
>
> Change to complain about ambiguity instead of doing unexpected things.
>
> [1] Commit 70c9ac2f ("DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"" 2009-10-18)
>     https://public-inbox.org/git/7vaazpxha4.fsf_-_@alter.siamese.dyndns.org/
> [2] Commit ad8d5104 ("checkout: add advice for ambiguous "checkout <branch>"", 2018-06-05)
>     https://public-inbox.org/git/20180502105452.17583-1-avarab@gmail.com/
> [3] Commit be4908f1 ("checkout: disambiguate dwim tracking branches and local files", 2018-11-13)
>     https://public-inbox.org/git/20181110120707.25846-1-pclouds@gmail.com/

I'll reserve judgement on whether we really should do this for now, my
current opinion on the matter is undefined as I haven't re-paged this
behavior of checkout into my brain.

But a giant red flag here for me is that you say "I understand that this
was never intended".

Just from a cursory look at this that's not true, for better or worse it
*is* intended behavior. Most of the code you're moving around here is
what I added in ad8d5104b4 ("checkout: add advice for ambiguous
"checkout <branch>"", 2018-06-05), and the very start of that commit
message refers to the checkout documentation we have that explicitly
documents this edge case.

Digging a bit further reveals that we've had this behavior (again,
intended, not emergent) since 70c9ac2f19 ("DWIM "git checkout frotz" to
"git checkout -b frotz origin/frotz"", 2009-10-18), and had it
documented since 00bb4378c7 ("Documentation/git-checkout.txt: document
70c9ac2 behavior", 2012-12-17).

So at the very least I'd say you need a v2 where you amend the relevant
docs & commit message to make a case to the effect of "we've had this
since 2009, but it was never really all that important etc.".

Such a change should also be changing the docs etc. added in 8d7b558bae
("checkout & worktree: introduce checkout.defaultRemote",
2018-06-05). With this series our docs don't make a lot of sense anymore
& don't describe the behavior with the patches applied.

> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> ---
>  builtin/checkout.c       | 56 ++++++++++++++++++----------------------
>  t/t2024-checkout-dwim.sh | 23 +++++++++++++++--
>  2 files changed, 46 insertions(+), 33 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e1b9df1543..6fb427990f 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1115,10 +1115,10 @@ static void setup_new_branch_info_and_source_tree(
>
>  static const char *parse_remote_branch(const char *arg,
>  				       struct object_id *rev,
> -				       int could_be_checkout_paths,
> -				       int *dwim_remotes_matched)
> +				       int could_be_checkout_paths)
>  {
> -	const char *remote = unique_tracking_name(arg, rev, dwim_remotes_matched);
> +	int num_matches = 0;
> +	const char *remote = unique_tracking_name(arg, rev, &num_matches);
>
>  	if (remote && could_be_checkout_paths) {
>  		die(_("'%s' could be both a local file and a tracking branch.\n"
> @@ -1126,6 +1126,22 @@ static const char *parse_remote_branch(const char *arg,
>  		    arg);
>  	}
>
> +	if (!remote && (num_matches > 1)) {
> +	    if (advice_checkout_ambiguous_remote_branch_name) {
> +		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
> +			     "you can do so by fully qualifying the name with the --track option:\n"
> +			     "\n"
> +			     "    git checkout --track origin/<name>\n"
> +			     "\n"
> +			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
> +			     "one remote, e.g. the 'origin' remote, consider setting\n"
> +			     "checkout.defaultRemote=origin in your config."));
> +	    }
> +
> +	    die(_("'%s' matched multiple (%d) remote tracking branches"),
> +		arg, num_matches);
> +	}
> +
>  	return remote;
>  }
>
> @@ -1133,8 +1149,7 @@ static int parse_branchname_arg(int argc, const char **argv,
>  				int dwim_new_local_branch_ok,
>  				struct branch_info *new_branch_info,
>  				struct checkout_opts *opts,
> -				struct object_id *rev,
> -				int *dwim_remotes_matched)
> +				struct object_id *rev)
>  {
>  	const char **new_branch = &opts->new_branch;
>  	int argcount = 0;
> @@ -1240,8 +1255,7 @@ static int parse_branchname_arg(int argc, const char **argv,
>
>  		if (recover_with_dwim) {
>  			const char *remote = parse_remote_branch(arg, rev,
> -								 could_be_checkout_paths,
> -								 dwim_remotes_matched);
> +								 could_be_checkout_paths);
>  			if (remote) {
>  				*new_branch = arg;
>  				arg = remote;
> @@ -1505,7 +1519,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  			 const char * const usagestr[])
>  {
>  	struct branch_info new_branch_info;
> -	int dwim_remotes_matched = 0;
>  	int parseopt_flags = 0;
>
>  	memset(&new_branch_info, 0, sizeof(new_branch_info));
> @@ -1613,8 +1626,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  			opts->track == BRANCH_TRACK_UNSPECIFIED &&
>  			!opts->new_branch;
>  		int n = parse_branchname_arg(argc, argv, dwim_ok,
> -					     &new_branch_info, opts, &rev,
> -					     &dwim_remotes_matched);
> +					     &new_branch_info, opts, &rev);
>  		argv += n;
>  		argc -= n;
>  	} else if (!opts->accept_ref && opts->from_treeish) {
> @@ -1672,28 +1684,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  	}
>
>  	UNLEAK(opts);
> -	if (opts->patch_mode || opts->pathspec.nr) {
> -		int ret = checkout_paths(opts, new_branch_info.name);
> -		if (ret && dwim_remotes_matched > 1 &&
> -		    advice_checkout_ambiguous_remote_branch_name)
> -			advise(_("'%s' matched more than one remote tracking branch.\n"
> -				 "We found %d remotes with a reference that matched. So we fell back\n"
> -				 "on trying to resolve the argument as a path, but failed there too!\n"
> -				 "\n"
> -				 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
> -				 "you can do so by fully qualifying the name with the --track option:\n"
> -				 "\n"
> -				 "    git checkout --track origin/<name>\n"
> -				 "\n"
> -				 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
> -				 "one remote, e.g. the 'origin' remote, consider setting\n"
> -				 "checkout.defaultRemote=origin in your config."),
> -			       argv[0],
> -			       dwim_remotes_matched);
> -		return ret;
> -	} else {
> +	if (opts->patch_mode || opts->pathspec.nr)
> +		return checkout_paths(opts, new_branch_info.name);
> +	else
>  		return checkout_branch(opts, &new_branch_info);
> -	}
>  }
>
>  int cmd_checkout(int argc, const char **argv, const char *prefix)
> diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
> index fa0718c730..707c88ceba 100755
> --- a/t/t2024-checkout-dwim.sh
> +++ b/t/t2024-checkout-dwim.sh
> @@ -37,7 +37,9 @@ test_expect_success 'setup' '
>  		git checkout -b foo &&
>  		test_commit a_foo &&
>  		git checkout -b bar &&
> -		test_commit a_bar
> +		test_commit a_bar &&
> +		git checkout -b ambiguous_branch_and_file &&
> +		test_commit a_ambiguous_branch_and_file
>  	) &&
>  	git init repo_b &&
>  	(
> @@ -46,7 +48,9 @@ test_expect_success 'setup' '
>  		git checkout -b foo &&
>  		test_commit b_foo &&
>  		git checkout -b baz &&
> -		test_commit b_baz
> +		test_commit b_baz &&
> +		git checkout -b ambiguous_branch_and_file &&
> +		test_commit b_ambiguous_branch_and_file
>  	) &&
>  	git remote add repo_a repo_a &&
>  	git remote add repo_b repo_b &&
> @@ -75,6 +79,21 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
>  	test_branch master
>  '
>
> +test_expect_success 'when arg matches multiple remotes, do not fallback to interpreting as pathspec' '
> +	git checkout -b t_ambiguous_branch_and_file &&
> +	>ambiguous_branch_and_file &&
> +	git add ambiguous_branch_and_file &&
> +	git commit -m "ambiguous_branch_and_file" &&
> +
> +	test_when_finished "git checkout -- ambiguous_branch_and_file" &&
> +	echo "file contents" >ambiguous_branch_and_file &&
> +	cp ambiguous_branch_and_file expect &&
> +
> +	test_must_fail git checkout ambiguous_branch_and_file &&
> +
> +	test_cmp expect ambiguous_branch_and_file
> +'
> +
>  test_expect_success 'checkout of branch from multiple remotes fails with advice' '
>  	git checkout -B master &&
>  	test_might_fail git branch -D foo &&
