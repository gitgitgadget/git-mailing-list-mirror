Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C16ECAAD3
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 02:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiIHCoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 22:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIHCoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 22:44:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B2F8E457
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 19:44:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so910559pji.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Z4BD6dz2wXz0WAAKDdql/irRX0/ZvAtSI+cPui9tu1o=;
        b=kvdVn+ZUDBIH91vjVz9uw1tWmh5y55GaxAM+osMPxgUNylqLzdaTCE/IFgrj0wOOkE
         jSRaMaw1OoMGMl8a4c8mg75pCv2/9C/AYhlrGDuEcvUTl8+sWqmB4ufaC+86cUduapJ0
         3W4w83RVO4qbJ70cFrOApsf0WO+TJuAzhm2Bf2tR9Xr9nlOAe8a76NupueYco20R3vgp
         AGtVyQuISCkZaZgqxDbFtdtyhIouQ/BcNH1b4k/ImHtonYzjutWnCZrG6xV685hCb5+r
         FPQv4gRfiwnX9JZTGtEQQIUo9vfyfVGkFV8S1kmi/zYkR6MUoFqaemJLFaUIN/lLSoLc
         WMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z4BD6dz2wXz0WAAKDdql/irRX0/ZvAtSI+cPui9tu1o=;
        b=PzNi2bVqy9DI5qg8i9kf1fy+0LJ3XDB/6Dar0AXHUlLFIfb0mXcIW2Y/LLd5Z6F8s6
         ddUtT/oXTuNoa+pD2pmBA+HjgPMGxcNXi73YfkVWqzz9eRKv0BK03H6GjnEaF9DOiobu
         DW9JoT2DkPnqsmEdWdrzJIrJHaUJ1khTQSVAB8c6Kh/NyMHeXWLxM2PhL9YZQlRImk88
         vGIo/3p7qwNgCLsz3/nai5J8nQkekRSQDwn4/AsQ42lo5adIlVn/RwskWTFn6MgdJe8D
         VDn9PsAIr/3Xts0kCPM2+EGhjcXLYLC2TNuUHkAi6RKcJ8Iirjy4r5O+VehGrTr/Ur4s
         Xbhg==
X-Gm-Message-State: ACgBeo3EVwN3lEcGQw5KKcs+F/w4jgWnWEnIEmlqzWiEcZae6TmBObGU
        DyJpB3RCABBgoVKMfw3XPdM=
X-Google-Smtp-Source: AA6agR6Zm4Djh1vP7yh7RRrc8YpK7G2InACsI2Ebw3EDm4JQWe15rqQcyWEDtqoP9gqiLannB+IPIA==
X-Received: by 2002:a17:90b:1c12:b0:200:b623:455d with SMTP id oc18-20020a17090b1c1200b00200b623455dmr1692358pjb.88.1662605048221;
        Wed, 07 Sep 2022 19:44:08 -0700 (PDT)
Received: from generichostname (136-25-1-99.cab.webpass.net. [136.25.1.99])
        by smtp.gmail.com with ESMTPSA id oa14-20020a17090b1bce00b0020255f4960bsm426561pjb.24.2022.09.07.19.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 19:44:07 -0700 (PDT)
Date:   Wed, 7 Sep 2022 19:44:04 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 7/7] rebase --keep-base: imply --no-fork-point
Message-ID: <YxlW9EGzMPZDOJPF@generichostname>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
 <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <6410b101d7f4ad97f87faec93703370a0493aa4a.1662561470.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6410b101d7f4ad97f87faec93703370a0493aa4a.1662561470.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Sorry I haven't been active in Git development lately. I've been busy
with other stuff. I was skimming my emails and this patch caught my eye.

On Wed, Sep 07, 2022 at 02:37:50PM +0000, Phillip Wood via GitGitGadget wrote:
> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> index 1d0b15380ed..70e81363569 100755
> --- a/t/t3431-rebase-fork-point.sh
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -50,7 +50,7 @@ test_rebase () {
>  
>  test_rebase 'G F E D B A'
>  test_rebase 'G F D B A' --onto D
> -test_rebase 'G F B A' --keep-base
> +test_rebase 'G F C B A' --keep-base

We should add a test here for explicit --fork-point just to ensure that
the behaviour stays the same in case anyone relies on it here.

>  test_rebase 'G F C E D B A' --no-fork-point
>  test_rebase 'G F C D B A' --no-fork-point --onto D
>  test_rebase 'G F C B A' --no-fork-point --keep-base
> -- 
> gitgitgadget
