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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94F9C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 14:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80064610FF
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 14:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbhHFOui (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 10:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbhHFOtj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 10:49:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD78C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 07:49:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p21so13354007edi.9
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VdgAkjUN8sGevCZqS1HeSRLfE2pRo3Iu6u9wjuzGo6o=;
        b=N+xzd0oqstGFRwu3WsxvWt0voZAJYQRaOukT4QWuBdGp94q97AuscWCdXDqNS5uu0o
         IwoV/iRJTzkBfbf4r/XQsy2ZGrd4W7md3eY5O50KKwzdLtg8t8gSvY5g2ScSfT9aH1ZU
         UKtzMur+43mUohixqYOoO7b8ySyR6wVMUzh67smmsCO8lSDpcBIHy+sIF7OA5SdOI/a5
         RcXtfDjlpGU2ohXYBPHJzndOCgf5fAKn9lHBc7ZdH38Z31lki2wIYVpQxEJK5oHEwgMo
         a/RRG2FDfhRbR2OP1do3gNYUBt8cY+8zWAap1Al5weLTfPeZ4ChaeRbLYm9Ans5V50l5
         VHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VdgAkjUN8sGevCZqS1HeSRLfE2pRo3Iu6u9wjuzGo6o=;
        b=hYOEOYVWB59Vtwct+7WJlW2bUCD+f+tIIMEUcowSKWJaBucP2UB9IdWIymSyOpDBkX
         lQ1a6UsazFrW9J5+c04+5WP67M1+uhFqSLuUp69x4tSOuudP9wXN4GongqZp8nrIVmA3
         nZ7wImAu00YU0fwpng+2Ccl79fnnIoNg89VcSuHoKh/yrOVDjNxZV0fgxo5m/2TleIDI
         kex7029BDa4MVtNoJ4i32pH+Gzhfh7vrwU/3xYSl8MNuDsUea7qmXrPO2+uSfyv+PHlI
         iJQZmsGjF0/pnD2+gTvHMvM+Oc8WH2VNtTj6wmpV09/AKrzFWdmwXtT8ObPvPQeou17Z
         7YVA==
X-Gm-Message-State: AOAM533EZ3/XuV9i71/PdQuOQbqel1HwHmIDutKUeMUl+FhTT3d7/q7j
        bTpJRvnHFG0gdnEN6qlXSi4=
X-Google-Smtp-Source: ABdhPJyFJ0JI10Wm5McZ92uzQm7hMMgkGZnLn2jPfaHh4xWtfS8G8oSQSoew1YtyR1xOHjsf7xuvkw==
X-Received: by 2002:aa7:cd03:: with SMTP id b3mr14008271edw.54.1628261357351;
        Fri, 06 Aug 2021 07:49:17 -0700 (PDT)
Received: from szeder.dev (78-131-14-24.pool.digikabel.hu. [78.131.14.24])
        by smtp.gmail.com with ESMTPSA id j5sm3962117edv.10.2021.08.06.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 07:49:16 -0700 (PDT)
Date:   Fri, 6 Aug 2021 16:49:11 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>
Subject: Re: [PATCH] test: fix for COLUMNS and bash 5
Message-ID: <20210806144911.GA1388237@szeder.dev>
References: <20210805194825.1796765-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210805194825.1796765-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 05, 2021 at 02:48:25PM -0500, Felipe Contreras wrote:
> Since c49a177bec (test-lib.sh: set COLUMNS=80 for --verbose
> repeatability, 2021-06-29) multiple tests have been failing when using
> bash 5 because checkwinsize is enabled by default, therefore COLUMNS is
> reset using TIOCGWINSZ even for non-interactive shells.
> 
> It's debatable whether or not bash should even be doing that, but for
> now we can avoid this undesirable behavior by disabling this option.
> 
> Reported-by: Fabian Stelzer <fabian.stelzer@campoint.net>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/test-lib.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index db61081d6b..a2b7dfecee 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -419,6 +419,12 @@ COLUMNS=80

COLUMNS is set just before the start of the hunk context ...

>  export LANG LC_ALL PAGER TZ COLUMNS
>  EDITOR=:

... so these two "commands" above are executed while COLUMNS is
already set but checkwinsize is not yet disabled.  The reason I put
quotes around that commands is that while exporting and setting
variables are indeed commands as defined in the POSIX Shell Command
Language specs, Bash with checkwinsize enabled only "checks the window
size after each extern (non-builtin) command" (quoting 'man bash').

So even though it is safe to execute these variable setting and
exporting commands after setting COLUMNS but disabling checkwinsize, I
think it would be prudent to disable checkwinsize before initializing
COLUMNS.  (And perhaps adding "non-builtin" to the comment below.)

> +# Since bash 5.0, checkwinsize is enabled by default which does update the
> +# COLUMNS variable every time a command completes, even for non-interactive
> +# shells.
> +# Disable that since we are aiming for reproducibility.
> +test -n "$BASH_VERSION" && shopt -u checkwinsize 2>/dev/null
> +
>  # A call to "unset" with no arguments causes at least Solaris 10
>  # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
>  # deriving from the command substitution clustered with the other
> -- 
> 2.32.0.40.gb9b36f9b52
> 
