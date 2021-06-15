Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC8CC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A23B61458
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhFOLHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhFOLHV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:07:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F890C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 04:05:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g6so12985255pfq.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 04:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6UtvfHfht08ft2d+/5xwzHJuOpmQIlttXemZoureYsU=;
        b=lG+2z7tkBBJzCrV3drHkpcpMe0t34tro/xBroiZAADmbZUKZqFnAYLpHabY00X7Sqp
         O5Bt/iTziYZeCCdYqfCYPrRxInCwpAftP9ITpNnZL0X4IO6p33acdSVjUZXD0fNdWv8f
         KalAcrIBAr1+YU6Vv3oc+AGG1a1B16h17SZN3/jSJUGrl/cOsGeRQDKgQH0ZT3OkJbrV
         3F+Z25Y7YNOHm6x1uxE2gdF9MJVRN1suqZBA3BxW6ncytKGRx+QJHysE0pcsi/iA4E+j
         XnF2Fgb1BEgpmSXDNH9SixdT0sItIWrVW0ZftmLjvGt/6ULe7Lw2iAveT4cOxYoz2eGL
         +icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6UtvfHfht08ft2d+/5xwzHJuOpmQIlttXemZoureYsU=;
        b=ARLz1TevakW6XRHydd0bpXGdOgMGKSy4hNWssNHmCbKCxJdYOUCXog352EqLGVY3CC
         95JmkIUixRggLoye8yUyzofsS9P1zxGWn76aS7QYWSBwPZxrrBKBNtRnMrAAwBYBJ/2G
         yBc19iKgVfhqy/FOw33JykYaAHPhGmOzfXn7I+QC9neDgKOqlASECv9JvmpSF5bxkmIz
         VATeOp2uncs7P2F75e1y52aUI1a9pKkiCwFnKSWfQjyttTpDfF1b5C3nCPzlgd3YSFKN
         ESLW/xmvOO6gkDtJSyoDiZlZE7SRL9/YEqfEnKEqP8CUCbgqkZAKEEyCuH+QYr6yHDqg
         hoIA==
X-Gm-Message-State: AOAM531Zb9aoWPHgaSlgOU9M6XtSAODRDFVG8c7rrCrPhrgKevCuy9aY
        Z0MJ56ma0ECY7WbM9+vrvc0=
X-Google-Smtp-Source: ABdhPJxEjUnHUMDUNe6ZdXGDG2IxuvjNzmXk+NyfEX9xGvIpbuC+KT4vGJWIXVad+cWq1UaNjz0tBA==
X-Received: by 2002:aa7:92c6:0:b029:2f1:3fbb:3171 with SMTP id k6-20020aa792c60000b02902f13fbb3171mr4100583pfa.0.1623755115570;
        Tue, 15 Jun 2021 04:05:15 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-38.three.co.id. [116.206.12.38])
        by smtp.gmail.com with ESMTPSA id q2sm2382462pje.50.2021.06.15.04.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 04:05:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] subtree: fix the GIT_EXEC_PATH sanity check to work
 on Windows
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Shumaker <lukeshu@lukeshu.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
 <a91ac6c18938116c4a74e19466da456b67376fa5.1623316412.git.gitgitgadget@gmail.com>
 <87bl8d6xoq.wl-lukeshu@lukeshu.com>
 <nycvar.QRO.7.76.6.2106111213050.57@tvgsbejvaqbjf.bet>
 <875yyk7c3j.wl-lukeshu@lukeshu.com>
 <nycvar.QRO.7.76.6.2106141330410.57@tvgsbejvaqbjf.bet>
 <xmqqtulzyhyh.fsf@gitster.g> <YMiHX6H/k1Z8C6Ws@coredump.intra.peff.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <0c409e32-423b-a4bb-22b9-a43cd1c802f2@gmail.com>
Date:   Tue, 15 Jun 2021 18:05:08 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMiHX6H/k1Z8C6Ws@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

> But having seen the earlier part of the thread, it looks like "are we on
> Windows" is predicated on "! type -p cygpath", which seems a bit loose.
> I also think "-p" is a bash-ism, so we'd want to avoid it before
> determining whether we're on Windows to avoid a chicken-and-egg on other
> platforms.
> 
> -Peff
> 

What is the POSIX equivalent then of?

-- 
An old man doll... just what I always wanted! - Clara
