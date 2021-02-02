Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D1BC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73BB64F7C
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhBBVZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 16:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhBBVZe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 16:25:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E07C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 13:24:54 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f14so7982848ejc.8
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 13:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bPQqFkSLF6KeIAGOTrHjD3+A0EYL5FDbQF1qeO9GBeE=;
        b=LgbFZCewlXy6V28BUQjfb7Cb9f1gFc2P2TwpRhOSeF1dWGE2XmCFt8SMGeXWDjrXuS
         SggS50PXxbwPH5qtbpTuHEApmvCuFygcr/Lc/Am79/3orWLMKwVBjs5ZvSwYvA7KSrd2
         a0Eo8CbJzwTy3LkISHT2YKwZKpDT3I4AqNHVKmL971SiKvz2FgeJ0zf2OhG+5Dhfay70
         8+v7IW0cJ78J/aqf67EG45ogTs8zea8Tca/Jsd3eTBWRp6urPP6/MMXuIq7RZUW8ht6t
         Ns7Iyf8kVO1/NZpxpxqQ99VCzQw6AucgTQBsWslY/rFr9vDuxX6yAFO8+RUbdg4fuAZR
         mVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bPQqFkSLF6KeIAGOTrHjD3+A0EYL5FDbQF1qeO9GBeE=;
        b=mUtwEJNmDVII4x/UX9HD/kkLhYXihxvnyQOrR5oQkEpoINSNri2WcrdImi6t+y33U8
         dPr6hl9fJm0QsLU8npu44Y3UAJNJYVbwunRdh5YFTii3tVtrW5vWAL9NjZ5MgJyq3+Wa
         uv/CAeN/pVTK93h2Ht0hwTBxTVgvrYSDdsD95buAj4UENRJTK1TKq5W6zGUpisouPGVL
         wV4EW2Fz/Gfe1IZfkZwhzKB8FCyx+i2VNrDsbQMxsUsm1UFOUi/o8xrz3Il7GzQXVRde
         1e8Ad0PiACn4IbB/s/u4eqTsBG8vrxu9Zhl13DK9z13kPDaHMTGMOdfrTsI+ZxnZecKy
         8AZw==
X-Gm-Message-State: AOAM531x0td7UhSFTew2NVi48HUoc7Hnog2cQLurunbcFAHRvPhcLOAt
        LvIsrt0jwNdPZ1CtVqZO/pYzifCGDqE=
X-Google-Smtp-Source: ABdhPJxwaJ3FkK2y4CXv8GiLejM2suYWYVjDLA6cai/eXHJZ6g9SYyqLH1D9pWriE7l93565bh4ToQ==
X-Received: by 2002:a17:906:8611:: with SMTP id o17mr24073777ejx.145.1612301093207;
        Tue, 02 Feb 2021 13:24:53 -0800 (PST)
Received: from szeder.dev (84-236-109-63.pool.digikabel.hu. [84.236.109.63])
        by smtp.gmail.com with ESMTPSA id u17sm10703556edr.0.2021.02.02.13.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 13:24:52 -0800 (PST)
Date:   Tue, 2 Feb 2021 22:24:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 4/4] init: provide useful advice about
 init.defaultBranch
Message-ID: <20210202212451.GC2091@szeder.dev>
References: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
 <pull.921.v5.git.git.1607686618.gitgitgadget@gmail.com>
 <ce26446b1a2e7bf14cdf814ca56c37b2e7d6b578.1607686618.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce26446b1a2e7bf14cdf814ca56c37b2e7d6b578.1607686618.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 11:36:57AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> To give ample warning for users wishing to override Git's the fall-back
> for an unconfigured `init.defaultBranch` (in case we decide to change it
> in a future Git version), let's introduce some advice that is shown upon
> `git init` when that value is not set.
> 
> Note: two test cases in Git's test suite want to verify that the
> `stderr` output of `git init` is empty. It is now necessary to suppress
> the advice, we now do that via the `init.defaultBranch` setting. While
> not strictly necessary, we also set this to `false` in
> `test_create_repo()`.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 59bbf75e832..9910102ae1f 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1202,7 +1202,9 @@ test_create_repo () {
>  	mkdir -p "$repo"
>  	(
>  		cd "$repo" || error "Cannot setup test environment"
> -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
> +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" -c \
> +			init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
> +			init \
>  			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||

This breaks GIT_TEST_INSTALLED when the given Git version doesn't yet
contain 8b1fa77867 (Allow passing of configuration parameters in the
command line, 2010-03-26):

  $ GIT_TEST_INSTALLED=.../v1.6.0/bin/ ./t9999-test.sh -x
  Unknown option: -c
  usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]
  error: cannot run git init -- have you built things yet?


>  		error "cannot run git init -- have you built things yet?"
>  		mv .git/hooks .git/hooks-disabled
> -- 
> gitgitgadget
