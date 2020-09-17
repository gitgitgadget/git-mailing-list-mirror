Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CA6C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18904206DB
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh4VOOtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgIQOaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgIQO2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 10:28:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A7C06121D
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 07:05:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l71so1431778pge.4
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BOFmpFgDSjuZ0JwUZMdPUSKUd9O9AIshH5Y8u56XHpI=;
        b=jh4VOOtrqYsahbgqz/NFGuIfgKbU6c5BxpS75wNXsETtlNGgLH/eTkHc2O9nCZjSIe
         MYsJGTF2Bk4RdQspWDGiO0cWw8SRWBmRXtT470DDzkB0+cak5RYoM7WYixN5HGkaLbJk
         jXUmycdHDKw/wYQa0PiWx1nxqt2+a03472yJFyiUEm0HGUMPUpqWFLunoTK/+dwYASDN
         RVH5D9jR3rYoI+z/g4FJzKNArsjdio3vKDLk5X73639pTdS8I4IuXW5UeKHjXYwGOGAC
         afnWosVEpn+p60fzgYvQPFo1oi//nyqDkd7rHAOh3kLuc2zJ3fDdzvSXdCFzlUsdLr1B
         Ip5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BOFmpFgDSjuZ0JwUZMdPUSKUd9O9AIshH5Y8u56XHpI=;
        b=Pi0JwrXBIxrzBIOU372tjyiP1qzt+A74eakGqxx2fgXyd9u5pp59BMMnf//szPuMYt
         PqHhT0slA8+gm9P5/MI4k23uwNXU7vqh48jsGgXmXRQD4jlHdL/tfdjQU5/Z1G1xvMF0
         fHyUASIsS3IjJOmFjgitwn83qWDYeMzKW3tjo9J8LgOl01/Auk9eEBpJ0WbJcCMBPCtc
         1Lm/SlKHLKEoNX7H/1PpmiVtgVTWmSmypen73pDuB0bM6c29hJWrkP4c9gtSRjV8NOpt
         mF+TPr5VtaVP9x4403eWhn+MYsJV7iIFDpd1BTWk9so3tRxPwOXkRlcjEeVXXYG8CDm4
         onuQ==
X-Gm-Message-State: AOAM531KV6WcoVUqa00MObCn+TKs7812RUK25rrobRPhboMI5mRaXjJn
        OgCs+aEhooooqg/e81Tef6EbsXH525o=
X-Google-Smtp-Source: ABdhPJyrkKL3QfEm9YIaO8rARejc8LSIYhb57SJ5WgAqpeqagRv7p+c4c2L/UohA38CoO8+26oz1DA==
X-Received: by 2002:aa7:9e43:0:b029:142:2501:34e3 with SMTP id z3-20020aa79e430000b0290142250134e3mr10792297pfq.60.1600351546728;
        Thu, 17 Sep 2020 07:05:46 -0700 (PDT)
Received: from localhost ([2402:800:63a8:edfa:1ca8:8e9c:e6de:6bb2])
        by smtp.gmail.com with ESMTPSA id 194sm19484165pfy.44.2020.09.17.07.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 07:05:46 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:05:43 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 4/7] maintenance: add [un]register subcommands
Message-ID: <20200917140543.GC8664@danh.dev>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
 <1f49cda18ee8d6c585807506cf89c365de642ea7.1599846561.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f49cda18ee8d6c585807506cf89c365de642ea7.1599846561.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Stolee,

Sorry for reply this late.

On 2020-09-11 17:49:17+0000, Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> In preparation for launching background maintenance from the 'git
> maintenance' builtin, create register/unregister subcommands. These
> commands update the new 'maintenance.repos' config option in the global

And also not spot this earlier.

I think you meant 'maintenance.repo' (without s) here
since it's the one that was mentioned in the patch itself.

Other than that, this series looks sane to me.

Thanks
Danh

> config so the background maintenance job knows which repositories to
> maintain.
> 
> These commands allow users to add a repository to the background
> maintenance list without disrupting the actual maintenance mechanism.
> 
> For example, a user can run 'git maintenance register' when no
> background maintenance is running and it will not start the background
> maintenance. A later update to start running background maintenance will
> then pick up this repository automatically.
> 
> The opposite example is that a user can run 'git maintenance unregister'
> to remove the current repository from background maintenance without
> halting maintenance for other repositories.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-maintenance.txt | 14 ++++++++
>  builtin/gc.c                      | 55 ++++++++++++++++++++++++++++++-
>  t/t7900-maintenance.sh            | 17 +++++++++-
>  3 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 3af5907b01..78d0d8df91 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -29,6 +29,15 @@ Git repository.
>  SUBCOMMANDS
>  -----------
>  
> +register::
> +	Initialize Git config values so any scheduled maintenance will
> +	start running on this repository. This adds the repository to the
> +	`maintenance.repo` config variable in the current user's global
> +	config and enables some recommended configuration values for
> +	`maintenance.<task>.schedule`. The tasks that are enabled are safe
> +	for running in the background without disrupting foreground
> +	processes.
> +
>  run::
>  	Run one or more maintenance tasks. If one or more `--task` options
>  	are specified, then those tasks are run in that order. Otherwise,
> @@ -36,6 +45,11 @@ run::
>  	config options are true. By default, only `maintenance.gc.enabled`
>  	is true.
>  
> +unregister::
> +	Remove the current repository from background maintenance. This
> +	only removes the repository from the configured list. It does not
> +	stop the background maintenance processes from running.
> +
>  TASKS
>  -----
>  
> diff --git a/builtin/gc.c b/builtin/gc.c
> index e28561b6c5..0290b249c9 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1408,7 +1408,56 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
>  	return maintenance_run_tasks(&opts);
>  }
>  
> -static const char builtin_maintenance_usage[] = N_("git maintenance run [<options>]");
> +static int maintenance_register(void)
> +{
> +	struct child_process config_set = CHILD_PROCESS_INIT;
> +	struct child_process config_get = CHILD_PROCESS_INIT;
> +
> +	/* There is no current repository, so skip registering it */
> +	if (!the_repository || !the_repository->gitdir)
> +		return 0;
> +
> +	config_get.git_cmd = 1;
> +	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
> +		     the_repository->worktree ? the_repository->worktree
> +					      : the_repository->gitdir,
> +			 NULL);
> +	config_get.out = -1;
> +
> +	if (start_command(&config_get))
> +		return error(_("failed to run 'git config'"));
> +
> +	/* We already have this value in our config! */
> +	if (!finish_command(&config_get))
> +		return 0;
> +
> +	config_set.git_cmd = 1;
> +	strvec_pushl(&config_set.args, "config", "--add", "--global", "maintenance.repo",
> +		     the_repository->worktree ? the_repository->worktree
> +					      : the_repository->gitdir,
> +		     NULL);
> +
> +	return run_command(&config_set);
> +}
> +
> +static int maintenance_unregister(void)
> +{
> +	struct child_process config_unset = CHILD_PROCESS_INIT;
> +
> +	if (!the_repository || !the_repository->gitdir)
> +		return error(_("no current repository to unregister"));
> +
> +	config_unset.git_cmd = 1;
> +	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
> +		     "maintenance.repo",
> +		     the_repository->worktree ? the_repository->worktree
> +					      : the_repository->gitdir,
> +		     NULL);
> +
> +	return run_command(&config_unset);
> +}
> +
> +static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
>  
>  int cmd_maintenance(int argc, const char **argv, const char *prefix)
>  {
> @@ -1417,6 +1466,10 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
>  
>  	if (!strcmp(argv[1], "run"))
>  		return maintenance_run(argc - 1, argv + 1, prefix);
> +	if (!strcmp(argv[1], "register"))
> +		return maintenance_register();
> +	if (!strcmp(argv[1], "unregister"))
> +		return maintenance_unregister();
>  
>  	die(_("invalid subcommand: %s"), argv[1]);
>  }
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 328bbaa830..272d1605d2 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -9,7 +9,7 @@ GIT_TEST_MULTI_PACK_INDEX=0
>  
>  test_expect_success 'help text' '
>  	test_expect_code 129 git maintenance -h 2>err &&
> -	test_i18ngrep "usage: git maintenance run" err &&
> +	test_i18ngrep "usage: git maintenance <subcommand>" err &&
>  	test_expect_code 128 git maintenance barf 2>err &&
>  	test_i18ngrep "invalid subcommand: barf" err
>  '
> @@ -304,4 +304,19 @@ test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
>  	test_subcommand git multi-pack-index write --no-progress <weekly.txt
>  '
>  
> +test_expect_success 'register and unregister' '
> +	test_when_finished git config --global --unset-all maintenance.repo &&
> +	git config --global --add maintenance.repo /existing1 &&
> +	git config --global --add maintenance.repo /existing2 &&
> +	git config --global --get-all maintenance.repo >before &&
> +	git maintenance register &&
> +	git config --global --get-all maintenance.repo >actual &&
> +	cp before after &&
> +	pwd >>after &&
> +	test_cmp after actual &&
> +	git maintenance unregister &&
> +	git config --global --get-all maintenance.repo >actual &&
> +	test_cmp before actual
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 

-- 
Danh
