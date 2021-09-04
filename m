Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A68DC433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 17:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20CF60E76
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 17:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbhIDR26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 13:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbhIDR26 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 13:28:58 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACBC061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 10:27:54 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f22so2454065qkm.5
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1r1cuJzosgZNnik1gVQNq+7i1CavW0D1CJj4wS0YcVI=;
        b=vsUEvK1JDEVJqiywCDmpspjN84OLyNxEoX8Eb+cdEO/38yl1deBB0yCg73gTVJF+Zc
         wnRdZuwLJhGDhBU/qjLPsNbcexBi8vAfU+6dkn0hRZ5SJhAeAsYDkrwLUcWXf3fHtgaY
         u1ICZE5MiIUREhCX07xZam2jhxh87cGy02s3mrQHnDHzsF39m0NH9PvR2T/z42HygYLT
         XymTlXVX4q/1oQtusewikDp/iT4y+wM4HuMcFvZKxFLn/WlTQ9Oiv/3kO8+1W1cKq+MF
         AlCwRgd1wCO4J2YXqHhQW1M2qayxcSDqj1l+awuj/YSkTzE8X4NMjQGNCjmdIsJ+6X+8
         rJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1r1cuJzosgZNnik1gVQNq+7i1CavW0D1CJj4wS0YcVI=;
        b=bdAy3RhWDOV8+qB2WGtQxNnFtgYo4myXB0qlcITBmNMe2/3yXcMd9wIG1rQSPxwn8b
         3zfnYfy0Xb/xL/qugnE3LzTeXsGHkmmC307/bgW4HmPRN+nfzMyjrH4UsbNv5sxcInPX
         IxmydCZ3wGZL4iaSVOEKcEJwuZ5FzWVe1IRX0ABWiwB14CkaCTeU03wml7Ab+huS5Op3
         QZDwpsMXH/5VagGYTzpn0z3JBPctBWx9PG/K6b7Ane4PnYuQ9uNB9lpJWXe6FEubHFas
         SVYyDbFroRshx3/mWaS80TLBMUnJL6pK+Kgi1sDe/cEHEAYcRnizGYWWeEF32Xd7o1Ma
         sk5g==
X-Gm-Message-State: AOAM532kMMfsHyC9mBIi+2106fy7QbqA499M7NpI10pwVcqcYPe7gUxD
        Xap2x1V8YQeD4X8AY6pR4y/crQMFvMbZx3Ja
X-Google-Smtp-Source: ABdhPJwmGMaOpgUYjxtQDRhuR0LAOQuh8RFYEtJHRnmtqWNj0DTHcAsaU0RIqXIzW5xWUJbpog4MsA==
X-Received: by 2002:ae9:c119:: with SMTP id z25mr4042492qki.201.1630776473473;
        Sat, 04 Sep 2021 10:27:53 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id d20sm1916122qtw.53.2021.09.04.10.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 10:27:52 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] submodule: record superproject gitdir during absorbgitdirs
Date:   Sat,  4 Sep 2021 14:27:46 -0300
Message-Id: <20210904172746.3031-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210819200953.2105230-4-emilyshaffer@google.com>
References: <20210819200953.2105230-4-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> wrote:
>
> Already during 'git submodule add' we record a pointer to the
> superproject's gitdir. However, this doesn't help brand-new
> submodules created with 'git init' and later absorbed with 'git
> submodule absorbgitdir'. Let's start adding that pointer during 'git
> submodule absorbgitdir' too.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  submodule.c                        | 10 ++++++++++
>  t/t7412-submodule-absorbgitdirs.sh |  9 ++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 0b1d9c1dde..4b314bf09c 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2065,6 +2065,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)

This function has only one caller, `absorb_git_dir_into_superproject()`.
Perhaps it would be better to set submodule.superprojectGitdir in the caller,
right after the `else` block in which `relocate...()` is called. This way,
the config would also be set in the case of nested submodules where the inner
one already had its gitdir absorbed (which is the case handled by the code in
the `if` block).

>  	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
>  	char *new_git_dir;
>  	const struct submodule *sub;
> +	struct strbuf config_path = STRBUF_INIT, sb = STRBUF_INIT;
>  
>  	if (submodule_uses_worktrees(path))
>  		die(_("relocate_gitdir for submodule '%s' with "
> @@ -2096,6 +2097,15 @@ static void relocate_single_git_dir_into_superproject(const char *path)
>  
>  	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
>  
> +	/* cache pointer to superproject's gitdir */
> +	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */

s/experimental/extensions/

On the Review Club, I mentioned we might want to save
submodule.superprojectGitdir at the worktree config file. But Jonathan and Josh
gave a better suggestion, which is to cache the superproject gitdir relative to
the submodule's gitdir, instead of its working tree.

This way, the worktree config wouldn't be an issue. And more importantly, this
would prevent `git mv` from making the cached path stale, as Stolee pointed out
upthread.

> +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
> +	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
> +			       relative_path(get_super_prefix_or_empty(),
> +					     path, &sb));


In this code, `the_repository` corresponds to the superproject, right? I
think `get_super_prefix_or_empty()` should instead be
`absolute_path(get_git_dir())`, like you did on the previous patch.

And since the first argument to `relative_path()` will be an absolute path, I
believe we also need to convert the second one to an absolute path. Otherwise,
`relative_path()` would return the first argument as-is [1]. (I played around
with using `get_git_dir()` directly as the first argument, but it seems this
can sometimes already be absolute, in case of nested submodules.)

If we store the path as relative to the submodule's gitdir, it should be
simpler, as `real_new_git_dir` is already absolute:
	
	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
			       relative_path(absolute_path(get_git_dir())
					     real_new_git_dir, &sb));

[1]: I'm not sure if this is intended or if it's a bug. I was expecting that,
before comparing its two arguments, `relative_path()` would convert any
relative path given as argument to absolute, using the current working dir path.
But that's not the case.

> +	strbuf_release(&config_path);
> +	strbuf_release(&sb);
>  	free(old_git_dir);
>  	free(real_old_git_dir);
>  	free(real_new_git_dir);
> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index 1cfa150768..e2d78e01df 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -30,7 +30,14 @@ test_expect_success 'absorb the git dir' '
>  	git status >actual.1 &&
>  	git -C sub1 rev-parse HEAD >actual.2 &&
>  	test_cmp expect.1 actual.1 &&
> -	test_cmp expect.2 actual.2
> +	test_cmp expect.2 actual.2 &&
> +
> +	# make sure the submodule cached the superproject gitdir correctly
> +	test-tool path-utils real_path . >expect &&

This should be '.git' instead of '.', since the config caches the path to the
superproject's gitdir. But ...

> +	test-tool path-utils real_path \
> +		"$(git -C sub1 config submodule.superprojectGitDir)" >actual &&

... I think we could also avoid converting to an absolute path here, so that we
can test whether the setting is really caching a relative path. I.e., the test
could be:

	super_gitdir="$(git rev-parse --absolute-git-dir)" &&
	test-tool path-utils relative_path "$super_gitdir" "$PWD/sub1" >expect &&
	git -C sub1 config submodule.superprojectGitDir >actual &&
	test_cmp expect actual

> +
> +	test_cmp expect actual
>  '

It may also be interesting to test if the config is correctly set when
absorbing the gitdir of nested submodules:

diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index e2d78e01df..c2e5e7dd1c 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -70,3 +70,8 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	sub1_gitdir="$(git -C sub1 rev-parse --absolute-git-dir)" &&
+	test-tool path-utils relative_path "$sub1_gitdir" "$PWD/sub1/nested" >expect &&
+	git -C sub1/nested config submodule.superprojectGitDir >actual &&
+	test_cmp expect actual
 '
--- >8 ---
