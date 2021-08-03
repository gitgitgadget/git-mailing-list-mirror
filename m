Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16706C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 02:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F68600CD
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 02:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhHCC4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 22:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhHCC4W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 22:56:22 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A83C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 19:56:04 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t18so13091961qta.8
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 19:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JKfd5StAYd4HD1/J8mGsQq7qds3hZuPxEPf7v/6PadU=;
        b=tRDXmPIb4D0FRE7dDTkJgMlym4/KpTQI2MWMqLuUw4zOl5oo4Wi+eiwb7hUBAnPmJt
         h5IA8qPR+/4A0+k4pEnd+iOykYwc8mxQqMG8FBdNweUzwAipu4mV7lFcw0q0H/gMI4g8
         bQ0pEGnmCw5rXk6mt+2mFuUobMu/+4Q75DDKrFieUWiCN/r4f8xiKkGddLsVBaQUUG7+
         dYXBrP1en5BjjVVEDFonEm25imBNtKn0mww5YTQKE8qRADJY0g5vhXo2wGfs2kGNQ6xD
         l+eFITrmgggVrGG3Hwkqf8xoGPOR1bSmlJ5YrFf0oyRQmz/udEJG6FfeW83X8+3Eor5U
         5FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JKfd5StAYd4HD1/J8mGsQq7qds3hZuPxEPf7v/6PadU=;
        b=SjoZQcnJxxVaowqDCl9+9JwQmpDfHLFLBaExpE7O52JJqHvOwIznkR5oJBK6gHGZ5G
         hSNn4x4IftyTWN/hyuEcmRy1Pte9akQy0TPCtvpmpk/7UBtuQygkvUgZ6zjr29PijAkx
         uwe3yf/D7U3OeWHg1Ekw+Ex4PDxApK+EbyntQYjlkWsDeWa9i8vrzeeSXSVN2IzylO34
         1Lr3WpiMsYhWquuFy3pkVlv0qLQxCXJakSw1C0FXMv8vhgKbCLfH8n4AYCGveswI0HwN
         jUcjg4pguuWe4xog7THMyGPUFXKLBVRTt5HXEONAha/DSzRGH/YQk/K60tE5VvTyR0c2
         CE8Q==
X-Gm-Message-State: AOAM530W35qseA/yxQ931biqzKGDwh6y0LgD8JrsyJZlbk+V3t3v6Ros
        CJScXnrH1PNpmguNCrBMiww=
X-Google-Smtp-Source: ABdhPJw2EOTbjQPlPqoeR2MShFMU95A/mv9E/0G/acjxjO5nEu6BLxCdgJz3wQuL7X706WiYUFlRog==
X-Received: by 2002:ac8:76da:: with SMTP id q26mr16682596qtr.183.1627959364189;
        Mon, 02 Aug 2021 19:56:04 -0700 (PDT)
Received: from [192.168.89.76] ([198.168.101.205])
        by smtp.gmail.com with ESMTPSA id t6sm6837997qkg.75.2021.08.02.19.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 19:56:03 -0700 (PDT)
Subject: Re: [PATCH 1/2] Change default merge backend from recursive to ort
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
 <8f6af8d494e0924aef4ae6963b8dca2228dad9b1.1627776462.git.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <49b61447-06b7-9c43-fdd6-25adc45f2a88@gmail.com>
Date:   Mon, 2 Aug 2021 22:56:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8f6af8d494e0924aef4ae6963b8dca2228dad9b1.1627776462.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Le 2021-07-31 à 20:07, Elijah Newren via GitGitGadget a écrit :
> From: Elijah Newren <newren@gmail.com>
> 
> 
>    * `git diff AUTO_MERGE` -- ability to see what changes the user has
>      made to resolve conflicts so far (see commit 5291828df8 ("merge-ort:
>      write $GIT_DIR/AUTO_MERGE whenever we hit a conflict", 2021-03-20)
> 
>
> The last three have been implemented already (though only one has been
> submitted upstream so far; 

 From what I could find this indeed only refers to your 5291828df8 (merge-ort:
write $GIT_DIR/AUTO_MERGE whenever we hit a conflict, 2021-03-20).
This is a very nice improvement, but I noticed it is not mentioned in the doc.
Do you plan to update the 'git diff' doc to mention that special ref ?
(And maybe also gitrevisions(5), where most of the special refs are listed ?)

Do you plan to implement a new '--auto-merge' option to 'git diff' as a shortcut
to 'git diff AUTO_MERGE', in order to hide a bit the special ref from users ?

Thanks a lot for your work,

Philippe.
