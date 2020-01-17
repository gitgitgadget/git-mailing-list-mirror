Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A9C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964722073A
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUljyTGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAQNYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:24:25 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40163 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQNYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 08:24:25 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so10666121qvb.7
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 05:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b+XtjJAg2f5YpCM7aH9QuWWb5VEpVrcdbB/x7O/tVxc=;
        b=uUljyTGvoWKp8vxSxm01u7HtjK1ghaQDpknYAPvd6+kKMb9NtWMaSQNocW8LDRSdKE
         h+5XvBU1O4mwx4FC+TEim1gHq6aCX8dsDovwAFlQRbPfoXLMkVjY+Bi40raKtBlKrqhE
         OXzqwOw4flaqberKovRos1pzhTs9jWloE/YkVSWHMPBIhWJZ1V+lc5dBVP5g/sH+x+ms
         WkE7XJst1ulmEqdlKD841jP7FPkfFzT/mciw2LbBBVefonS0SJcx/ytmApQ6kyVcLWcC
         v3LNae2SMCCy8tuRYgQA9ttAsTTtgqcZAhNWH9n3W8hoIc+O9LDvfgo3cMRNSjhyYM5J
         LhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b+XtjJAg2f5YpCM7aH9QuWWb5VEpVrcdbB/x7O/tVxc=;
        b=glKIO1kqQ4eNEDLpuMlKY0aGSR3WP0HRQ0HoxYXXvWgBBoA+mMjYAJUkoRKXItLjDQ
         oV7GSwGKPmjNHsYq2ti/njEVKkwnyDYDrLIwx0s6lpM93y9BaAsU/hiQQHRxfAhnDShz
         IEgq0NAwRTGC7ki5pwWNN0e7ufcEMBJ1Ij938+8o8UdVj04ktGVLBRx45OtBm30u6CqG
         6FBUpJVDyRRYJe16Dzu3M2wCPMZEZ9nFeJMDWFRGNdAWKwj/bLGZwVVxNTCVs59LE3hw
         yDSlWqLaSXgWpC/mmr4eRyEY1PbxXdilNPVHOBi0XdsbhAhkXGBqdRNfA4577etPtNg0
         H6fw==
X-Gm-Message-State: APjAAAUG+N4oil1ixo+o8u5ksiP1Ae0Evz+ouqhRtvZGk2Gv/bK0j5le
        18/aH5i0muPvzP5nCDbi6EaeKHOpIbQ=
X-Google-Smtp-Source: APXvYqyhKxbO2aExXe9jsvHqONP/uATKynmytp+FvTSOI3Frekt24HaB/8+o0O99b/Z5Q6YxLAdUlw==
X-Received: by 2002:ad4:50d2:: with SMTP id e18mr7799689qvq.9.1579267464086;
        Fri, 17 Jan 2020 05:24:24 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:64d0:3701:c4c7:2368? ([2001:4898:a800:1012:1604:3701:c4c7:2368])
        by smtp.gmail.com with ESMTPSA id a185sm11795359qkg.68.2020.01.17.05.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 05:24:23 -0800 (PST)
Subject: Re: [PATCH 4/4] submodule.c: use get_git_dir() instead of
 get_git_common_dir()
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
 <72cdb2f95d8c03c7b0324e8132e04e3a10248432.1579263809.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b97f7dc2-9cc9-9665-e00e-1cbb8b0996e4@gmail.com>
Date:   Fri, 17 Jan 2020 08:24:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <72cdb2f95d8c03c7b0324e8132e04e3a10248432.1579263809.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/2020 7:23 AM, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> Ever since df56607dff (git-common-dir: make "modules/"
> per-working-directory directory, 2014-11-30), submodules in linked worktrees
> are cloned to $GIT_DIR/modules, i.e. $GIT_COMMON_DIR/worktrees/<name>/modules.
> 
> However, this convention was not followed when the worktree updater commands
> checkout, reset and read-tree learned to recurse into submodules. Specifically,
> submodule.c::submodule_move_head, introduced in 6e3c1595c6 (update submodules:
> add submodule_move_head, 2017-03-14) and submodule.c::submodule_unset_core_worktree,
> (re)introduced in 898c2e65b7 (submodule: unset core.worktree if no working tree
> is present, 2018-12-14) use get_git_common_dir() instead of get_git_dir()
> to get the path of the submodule repository.
> 
> This means that, for example, 'git checkout --recurse-submodules <branch>'
> in a linked worktree will correctly checkout <branch>, detach the submodule's HEAD
> at the commit recorded in <branch> and update the submodule working tree, but the
> submodule HEAD that will be moved is the one in $GIT_COMMON_DIR/modules/<name>/,
> i.e. the submodule repository of the main superproject working tree.
> It will also rewrite the gitfile in the submodule working tree of the linked worktree
> to point to $GIT_COMMON_DIR/modules/<name>/.
> This leads to an incorrect (and confusing!) state in the submodule working tree
> of the main superproject worktree.
> 
> Additionnally, if switching to a commit where the submodule is not present,

s/Additionnally/Additionally

> submodule_unset_core_worktree will be called and will incorrectly remove
> 'core.wortree' from the config file of the submodule in the main superproject worktree,
> $GIT_COMMON_DIR/modules/<name>/config.
>
> Fix this by constructing the path to the submodule repository using get_git_dir()
> in both submodule_move_head and submodule_unset_core_worktree.
> 
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  submodule.c                   |  6 +++---
>  t/t2405-worktree-submodule.sh | 22 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 9da7181321..5d19ec48a6 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1811,7 +1811,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>  void submodule_unset_core_worktree(const struct submodule *sub)
>  {
>  	char *config_path = xstrfmt("%s/modules/%s/config",
> -				    get_git_common_dir(), sub->name);
> +				    get_git_dir(), sub->name);
>  
>  	if (git_config_set_in_file_gently(config_path, "core.worktree", NULL))
>  		warning(_("Could not unset core.worktree setting in submodule '%s'"),
> @@ -1914,7 +1914,7 @@ int submodule_move_head(const char *path,
>  					ABSORB_GITDIR_RECURSE_SUBMODULES);
>  		} else {
>  			char *gitdir = xstrfmt("%s/modules/%s",
> -				    get_git_common_dir(), sub->name);
> +				    get_git_dir(), sub->name);
>  			connect_work_tree_and_git_dir(path, gitdir, 0);
>  			free(gitdir);
>  
> @@ -1924,7 +1924,7 @@ int submodule_move_head(const char *path,
>  
>  		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
>  			char *gitdir = xstrfmt("%s/modules/%s",
> -				    get_git_common_dir(), sub->name);
> +				    get_git_dir(), sub->name);
>  			connect_work_tree_and_git_dir(path, gitdir, 1);
>  			free(gitdir);
>  		}
> diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
> index f1952c70dd..eba17d9e35 100755
> --- a/t/t2405-worktree-submodule.sh
> +++ b/t/t2405-worktree-submodule.sh
> @@ -10,6 +10,7 @@ test_expect_success 'setup: create origin repos'  '
>  	git init origin/sub &&
>  	test_commit -C origin/sub file1 &&
>  	git init origin/main &&
> +	test_commit -C origin/main first &&
>  	git -C origin/main submodule add ../sub &&
>  	git -C origin/main commit -m "add sub" &&
>  	test_commit -C origin/sub "file1-updated" file1 file1updated &&
> @@ -54,4 +55,25 @@ test_expect_success 'submodule is checked out after manually adding submodule wo
>  	grep "file1-updated" out
>  '
>  
> +test_expect_success 'checkout --recurse-submodules uses $GIT_DIR for submodules in a linked worktree' '
> +	git -C main worktree add "$base_path/checkout-recurse" --detach  &&
> +	git -C checkout-recurse submodule update --init &&
> +	cat checkout-recurse/sub/.git > expect-gitfile &&

Here, and the rest of these tests, please drop the space between the ">" and
the output file: ">expect-gitfile".

> +	git -C main/sub rev-parse HEAD > expect-head-main &&
> +	git -C checkout-recurse checkout --recurse-submodules HEAD~1 &&
> +	cat checkout-recurse/sub/.git > actual-gitfile &&
> +	git -C main/sub rev-parse HEAD > actual-head-main &&
> +	test_cmp expect-gitfile actual-gitfile &&
> +	test_cmp expect-head-main actual-head-main
> +'
> +
> +test_expect_success 'core.worktree is removed in $GIT_DIR/modules/<name>/config, not in $GIT_COMMON_DIR/modules/<name>/config' '
> +	git -C main/sub config --get core.worktree > expect &&
> +	git -C checkout-recurse checkout --recurse-submodules first &&
> +	test_might_fail git -C main/.git/worktrees/checkout-recurse/modules/sub config --get core.worktree > linked-config &&

Why test_might_fail here, and below? Because the config may not exist, which
would return an error code? Should we _expect_ that failure with test_must_fail?

> +	test_must_be_empty linked-config &&
> +	test_might_fail git -C main/sub config --get core.worktree > actual &&
> +	test_cmp expect actual

This tests that core.wortkree didn't change throughout the process, but
could we instead confirm an exact value by echoing into "expect" and
comparing both config outputs against that value?

Perhaps it is worth checking the success of the command that was failing
in submodules that still had core.worktree=true before 898c2e6? For your
test, it would be:

	git -C main/.git/worktrees/checkout-recurse/modules/sub log

Thanks,
-Stolee
