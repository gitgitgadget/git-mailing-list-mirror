Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A5CC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925176023B
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbhI1J4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbhI1J4d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 05:56:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018AC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:54:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l8so33051179edw.2
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wP3t4fSt882yZ3wmf7O6rl3hi0KPzydWDpIc1dCTo5Y=;
        b=pO0rbeJkv5e/RA+5EQa1qlhKTZnP6ihLuIrsw4pL8yhIEsssyij583QTErBsjl/Ena
         FcJ0kaKiYNknRcsPU0R5HqG8CsN3E8aNPem68WndL3Hyp0esbhtOq68saCTnsJj74uP4
         7UMtSlzOHM8cpSx33eTKnOTA6r3xrGzdR2+mkgc/altioZOwLj6idDW4L/a0GNKXq2dM
         fQPVlmUWOca4avyohQyKcG4+3f0Y1vW4Jd4gOcYJBO0sqKf0/Gj5ywqtpsi35YDniEzi
         4yMx9OdEKUHqAaw7KX/juNgR5gd1ljwCGlGkz9LDsyS9JTcoMy7UeVE22dUM58UDMnbW
         QAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wP3t4fSt882yZ3wmf7O6rl3hi0KPzydWDpIc1dCTo5Y=;
        b=Jkwc0fHXUpKm/hxs3OYj1V3gNQutwSeKhoFn78a7jpYW1vtCSUqftnMEzX6nX49Csj
         0TCAmzEAz0BI00BG6TT2VU+xktN0wwQdl30D9f4cpJbKo2hBAFet7nhnTmEmhEy6a/Gd
         p4eYLSU/HxYA0fckDKVXS6iM0MUhYR0XT9HUhrTLhlUyerQORhziEiNJ3K5PB3Yw2hhS
         k6ijHMbEcdZEMS1xVBFDoPyZS3+alTfyioHGRTJxZ8loaDdQDW937w7AYRa6BLBruqj+
         dEayHIskHDnOmdZGQoeBesfLJy0eGpHIegkTjARPbaSRbR5fXbGmSwMfG5p7mcbHHIIB
         MwXw==
X-Gm-Message-State: AOAM532Zou+e8A0RCt0NQD9PkQRuFpW+G9I/g3T7VnW3hv/++Ffxml9W
        z/zKRwgp50b3BrNzhhavFbmPh2UF2UUeag==
X-Google-Smtp-Source: ABdhPJxWiWv0hh50XoNQHS01KV8w7/p5GAsF81lbCstbGUhxrVumXT/+s5YnTrii3mjqSykdi6LFBw==
X-Received: by 2002:a50:e044:: with SMTP id g4mr6330854edl.46.1632822884081;
        Tue, 28 Sep 2021 02:54:44 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ca4sm10110334ejb.1.2021.09.28.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 02:54:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mugdha Pattnaik via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        mugdha <mugdhapattnaik@gmail.com>
Subject: Re: [PATCH v4] submodule: absorb git dir instead of dying on deinit
Date:   Tue, 28 Sep 2021 11:53:45 +0200
References: <pull.1078.v3.git.git.1630087821429.gitgitgadget@gmail.com>
 <pull.1078.v4.git.git.1630090303445.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <pull.1078.v4.git.git.1630090303445.gitgitgadget@gmail.com>
Message-ID: <87sfxpvxcs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 27 2021, Mugdha Pattnaik via GitGitGadget wrote:

> From: mugdha <mugdhapattnaik@gmail.com>
>
> Currently, running 'git submodule deinit' on repos where the
> submodule's '.git' is a directory, aborts with a message that is not
> exactly user friendly. Let's change this to instead warn the user
> to rerun the command with '--force'.
>
> This internally calls 'absorb_git_dir_into_superproject()', which
> moves the git dir into the superproject and replaces it with
> a '.git' file. The rest of the deinit function can operate as it
> already does with new-style submodules.
>
> We also edit a test case such that it matches the new behaviour of
> deinit.
>
> Suggested-by: Atharva Raykar <raykar.ath@gmail.com>
> Signed-off-by: Mugdha Pattnaik <mugdhapattnaik@gmail.com>
> ---
>     submodule: absorb git dir instead of dying on deinit
>     
>     Changes since v3:
>     
>      * Replaced 1 instance of the word "folder" with "directory"
>      * Fixed tab spacing
>     
>     Thank you, Mugdha
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1078%2Fmugdhapattnaik%2Fsubmodule-deinit-absorbgitdirs-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1078/mugdhapattnaik/submodule-deinit-absorbgitdirs-v4
> Pull-Request: https://github.com/git/git/pull/1078
>
> Range-diff vs v3:
>
>  1:  1ac65b2458b ! 1:  7460fc0e12a submodule: absorb git dir instead of dying on deinit
>      @@ builtin/submodule--helper.c: static void deinit_submodule(const char *path, cons
>       +		if (is_directory(sub_git_dir)) {
>       +			if (!(flags & OPT_FORCE))
>       +				die(_("Submodule work tree '%s' contains a "
>      -+					  ".git directory.\nUse --force if you want "
>      -+					  "to move its contents to superproject's "
>      -+					  "module folder and convert .git to a file "
>      -+					  "and then proceed with deinit."),
>      -+					displaypath);
>      ++				      ".git directory.\nUse --force if you want "
>      ++				      "to move its contents to superproject's "
>      ++				      "module directory and convert .git to a file "
>      ++				      "and then proceed with deinit."),
>      ++				    displaypath);
>       +
>       +			if (!(flags & OPT_QUIET))
>       +				warning(_("Submodule work tree '%s' contains a .git "
>      -+						  "directory. This will be replaced with a "
>      -+						  ".git file by using absorbgitdirs."),
>      -+						displaypath);
>      ++					  "directory. This will be replaced with a "
>      ++					  ".git file by using absorbgitdirs."),
>      ++					displaypath);
>       +
>       +			absorb_git_dir_into_superproject(displaypath, flags);
>       +
>
>
>  builtin/submodule--helper.c | 28 ++++++++++++++++++----------
>  t/t7400-submodule-basic.sh  | 10 +++++-----
>  2 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ef2776a9e45..040b26f149d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1539,16 +1539,24 @@ static void deinit_submodule(const char *path, const char *prefix,
>  		struct strbuf sb_rm = STRBUF_INIT;
>  		const char *format;
>  
> -		/*
> -		 * protect submodules containing a .git directory
> -		 * NEEDSWORK: instead of dying, automatically call
> -		 * absorbgitdirs and (possibly) warn.
> -		 */
> -		if (is_directory(sub_git_dir))
> -			die(_("Submodule work tree '%s' contains a .git "
> -			      "directory (use 'rm -rf' if you really want "
> -			      "to remove it including all of its history)"),
> -			    displaypath);
> +		if (is_directory(sub_git_dir)) {
> +			if (!(flags & OPT_FORCE))
> +				die(_("Submodule work tree '%s' contains a "
> +				      ".git directory.\nUse --force if you want "
> +				      "to move its contents to superproject's "
> +				      "module directory and convert .git to a file "
> +				      "and then proceed with deinit."),
> +				    displaypath);
> +
> +			if (!(flags & OPT_QUIET))
> +				warning(_("Submodule work tree '%s' contains a .git "
> +					  "directory. This will be replaced with a "
> +					  ".git file by using absorbgitdirs."),
> +					displaypath);
> +
> +			absorb_git_dir_into_superproject(displaypath, flags);
> +
> +		}
>  
>  		if (!(flags & OPT_FORCE)) {
>  			struct child_process cp_rm = CHILD_PROCESS_INIT;
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index cb1b8e35dbf..3df71478d06 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1182,18 +1182,18 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
>  	rmdir init example2
>  '
>  
> -test_expect_success 'submodule deinit fails when submodule has a .git directory even when forced' '
> +test_expect_success 'submodule deinit fails when submodule has a .git directory unless forced' '
>  	git submodule update --init &&
>  	(
>  		cd init &&
>  		rm .git &&
> -		cp -R ../.git/modules/example .git &&
> +		mv ../.git/modules/example .git &&
>  		GIT_WORK_TREE=. git config --unset core.worktree
>  	) &&
>  	test_must_fail git submodule deinit init &&
> -	test_must_fail git submodule deinit -f init &&
> -	test -d init/.git &&
> -	test -n "$(git config --get-regexp "submodule\.example\.")"
> +	git submodule deinit -f init &&
> +	! test -d init/.git &&
> +	test -z "$(git config --get-regexp "submodule\.example\.")"

I see we don't have a "test_dir_is_missing" for the pre-image, but
shouldn't the post-image "! test -d" just be a test_path_is_missing?
I.e. should this pass if .git is a file? Probably not...
