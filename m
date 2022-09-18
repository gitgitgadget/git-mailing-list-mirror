Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0A5C6FA91
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 14:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiIROg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIROgr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 10:36:47 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9964201A4
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 07:36:45 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id c6so20165586qvn.6
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date;
        bh=I+cnDN5E/mLutSSECDMipsyh4vakG/fuLZ1JsuzqGaE=;
        b=S3MFICLqc/DBIuQYTSXls7w6nxZjEuFAddU2/Nc7am5D8wG53qFpw/tmRlqitMo9Wn
         403AM8uiYZHOoR+L/wf6mPmj8baUETC5+RF6G6WYbIv4yJfkUepJ3sIFQaLM7dKa39Zw
         N3xgTZvMUtxMcFoTbCMCGzlsX1bFhsdH9j0gv93JwVSouqOngOgbBQqgrYvyiE3GrxIz
         YUBBnyovsPzVR4TJSFQ6DL8zk9WA3mXburAXe8LBtBV2w2mIVa8aRFO6JArSGcHgPJwN
         e8DPZLiNqcQux4w3UxEmQ3Xca8Bu+jczTE1aRM4PVmXdcYkQRlfTk7xU2gPCmCNvohn1
         TDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=I+cnDN5E/mLutSSECDMipsyh4vakG/fuLZ1JsuzqGaE=;
        b=LMLNuSjTBQ8oIeDj+6V8WKLGPG78kDF70kpltL8aLIrn35X73M5CflO3h4WDY3z2Kp
         4xUaaFlzqz/cdnRQImraMOkeJ713R2fI6wDsgDUDQqwPWz6q0i5Cz0UmXJzMy43ow4oR
         NP+xiBEIL4H18tPhQTC1exJBK3ddRQmvoa73VKj7o9ehVNfF2h0iRUy9j0b/zzXOnI2N
         gCLgGEgX6gTwaqjSP2Bis8//MPX8XSxGFrOJTuDTDrC1BbBUWBlLbSWIDtEV1YysSaqr
         aOY7eGMQGkDMY54eaHJTKvV2XA3v1fy+p/5J5MXbsr3NtALqiSnG4oO5bwzObm6oxY/I
         0LmQ==
X-Gm-Message-State: ACrzQf3uVWEOH72XVAf08kUDR0tENqKbK/jMd+mrjJCtvlpZVMZhSOeJ
        RLmae3V/c+ktnYHxfezQthw=
X-Google-Smtp-Source: AMsMyM6uj7w94zKzeWsT1Dx6l8dgP9yF8TZVDydNsK2V7MnpHUSqrPRwUDER1LrXsXWnqHMKMCSZGg==
X-Received: by 2002:ad4:5b8b:0:b0:4ad:2b21:3390 with SMTP id 11-20020ad45b8b000000b004ad2b213390mr4215626qvp.20.1663511805083;
        Sun, 18 Sep 2022 07:36:45 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id r9-20020ac87949000000b0035a6f14b3cesm8510283qtt.27.2022.09.18.07.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 07:36:44 -0700 (PDT)
Subject: Re: Question related to submodule and different recurse config
 options
To:     Pieter-Jan Busschaert <pieterjan.busschaert@gmail.com>,
        git@vger.kernel.org
References: <CABxXVRS-9unw-8_N8w2bdj4E5Ch780tMetJyD+++ixdWsBv90A@mail.gmail.com>
Cc:     Glen Choo <chooglen@google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <36621ba8-ad8e-8758-3e17-ea7a83432b4c@gmail.com>
Date:   Sun, 18 Sep 2022 10:36:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABxXVRS-9unw-8_N8w2bdj4E5Ch780tMetJyD+++ixdWsBv90A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pieter-Jan,

Le 2022-09-08 à 11:01, Pieter-Jan Busschaert a écrit :
> Hello,
> 
> I'm trying to set my git config like this (fetch.recurseSubmodules =
> on-demand) and (submodule.recurse = true). The goal is to do fetch &
> submodule update if-and-only-if the pointed-to commit changes.
> 

That makes sense.

> However, it seems with this config a git pull will act as if
> fetch.recurseSubmodules was set to true (instead of on-demand) and do
> a fetch on all of the submodules. For me this does not correspond to
> the documentation (which says the value of submodule.recurse will only
> be used if fetch.recurseSubmodules is NOT set). I would have thought
> that this recent commit:
> https://github.com/git/git/commit/ed54e1b31ad1a9a35ef6c23024d325a2c4d85221
> describes this scenario and fixed it, but I still have that behaviour
> (git 2.37.3). Maybe that patch only covered true/false settings for
> fetch.recurseSubmodules and doesn't properly handle the on-demand
> setting?
> 
> Is what I see the intended behaviour?
> Is it possible in any way to configure git to only fetch & update
> submodules if the pointed-to commit changes?

I'm not sure if that's the bug you are hitting, but I remember noticing that
the actual order of the two configs in the config file mattered (whereas it should
not). With this:

    fetch.recurseSubmodules = on-demand
    submodule.recurse = true

the "submodule.recurse = true" is read last and then the "on-demand" setting for fetch
is effectively ignored.

With this order:

    submodule.recurse = true
    fetch.recurseSubmodules = on-demand

I think it would work correctly. But I might be misremembering (I did not try it).

Cheers,

Philippe.
