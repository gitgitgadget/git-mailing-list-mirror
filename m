Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDB6C433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B0E61059
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhIIOUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbhIIOUl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:20:41 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D366C028BE8
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 05:44:04 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id 2so1248074qtw.1
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ZZJeyphH6FGchBu702ziR6nIVjyrwYIXS8RJI8juz0=;
        b=JtfsaJGdPyVEXl4xkdcGLreYIf2J6E9/RNsQk4ptlncUaUC8h22pY5qkd9cnQtfNs9
         SRAM0BrfPAxHKCxnHp5GfMBbXbfxgc6LoBnvQDFuAZG9tJfUv/nrgQuuAJ6WJxOWJLeK
         bFbN8GRe6Lou+eS3DpAJ758ObQfFQTOsTcd2oF9/6HdiBbTSKTyqbnvZeJt05m/1Ou7f
         ZDIdCC9YBhVMb7V7AtsLLL5zzAOeQ0zgldEE7qhtpVFkLANiAQmNlprwaKtmGWHoFF2s
         mdcv5jYPaIM6I5pqfzPzH0kkcn3E2+022NsgXCvIpQkGSXhxjcBj1kk3XOFG5kJlycPJ
         xwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ZZJeyphH6FGchBu702ziR6nIVjyrwYIXS8RJI8juz0=;
        b=aY1HTHY+YFG+CxwJlNISkLVuhvPmPIWQd06L5IhRcx1gF/oeIg1IEEKZ+vgjAwoy4n
         lvGmLsaAlfmG5sC6Ye+zO6kVkFCamc5/8JoG6PWyOzBCrgDmmBQwXliOeaONdqor6AAK
         jLeTu8jnn+UHHp/QgERrB9/hTIw2pSrmjSEDmL++BA7/N83IcHS4ezZyTcR0KSB4FfuO
         Q5em6C5CQX3XjfizHRG5TbcMYqUw5NoL1ut0gd2LZHEWN4aH7eo8hhQSX/p7THEqcABo
         X2aDNcszvELBJESPau5Kql1/Xm2rMnUvRWsqC97YGpAnAsARmlZlK4kuvD8GZduZCLZp
         WY9g==
X-Gm-Message-State: AOAM533tifAsmj3RzwhkkcVSouWtQTPjBS5qk43p2cLLO2e5T10Xx4yI
        utvsyIuoNGnl4IV8VtHmXus=
X-Google-Smtp-Source: ABdhPJwuvZVoFdggeN6nLs5Hnym/4MJNylUHfKDa4opzSAFRU7VmKA5adXDrED368/4xHZahXF34BA==
X-Received: by 2002:ac8:6112:: with SMTP id a18mr2592268qtm.120.1631191443715;
        Thu, 09 Sep 2021 05:44:03 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id l126sm1212623qke.96.2021.09.09.05.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 05:44:03 -0700 (PDT)
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Emily Shaffer <emilyshaffer@google.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
 <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com>
 <nycvar.QRO.7.76.6.2109091250540.59@tvgsbejvaqbjf.bet>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <a4212a67-ba79-0976-db19-334812137e81@gmail.com>
Date:   Thu, 9 Sep 2021 08:44:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2109091250540.59@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2021-09-09 à 06:53, Johannes Schindelin a écrit :
> Hi Philippe,
> 
> On Wed, 8 Sep 2021, Philippe Blain wrote:
> 
>> Anyway, I'm not saying that we should not do what this patch is
>> proposing, but I think caveats such as that should be documented in the
>> commit message, and maybe an audit of other configs that might results
>> in behavioural differences should be done.
> 
> Since this is already a bug in the `apply` backend, it would be even
> better to follow-up with a fix, hint, hint, nudge, nudge ;-)
> 

I'm not sure I understand what you are saying. The fact that 'rebase'
does not pay attention to 'submodule.recurse' is not a bug in my opinion,
it's just a limitation of the current code... Or do you mean something else?

Thanks,
Philippe.
