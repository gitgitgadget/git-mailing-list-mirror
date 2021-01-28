Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F160C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 15:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22D464DF3
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 15:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhA1P0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 10:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhA1P03 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 10:26:29 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEFBC061786
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 07:26:13 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id t14so4292608qto.8
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 07:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ho7imzmG7jM5MDiR/ymnvpg8p7tHyPjA81KZQWhs/YA=;
        b=YXCO0mU9IXPTqsiF/GzHT7ql7imX1cGGr3nGt/Frsnodsu/TdkBTnEhic9hLB0A2O/
         HxtCYpWDIeMx9W6fG6w8uV1XYqB71ma248TLRcY/xtjNrcSH+cFrugzgbwzhNsf7/sfz
         3XyPd7picu/GzKYxE0ixuPPbHnF7srRhwYRVpY6wF23UHqIb+9d+v1ooOMMUFtcjjXjz
         BUSQpXlsGbomSQcZKUheUezykBgnkaOHPtEuZek0ozQ/zsqwxhtyA0LQRqAheivERi7Z
         QT4gqvFA0JOv2z20U5eDQjd7rJII53bNgsRQKdY6iOhuQTixUT9taoePCw74d3xgP+Xs
         fGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ho7imzmG7jM5MDiR/ymnvpg8p7tHyPjA81KZQWhs/YA=;
        b=uaJ3LcyhJlGCutvceGosZZqb7JVxgXMOySEvwXJzDotN3SJZ2KS+D9o9WllU/GPE1z
         ePF5Rsk79yMfNJigM3NerOTia2eyO9jEZ9kO4tomk1bzzyWZbXAQzQJXq4/te4aK3G+b
         2gtrc1GXOJUrK3+E2B1bblrMhMhUp6I/JltskzvMPAHAxJV41TDzn10UzIkYUZ4qIi0f
         KaENmL3eEYfrl3P9vVs9YlgX2Mfw5jbUm46nQJdL69MW5Y1hogwASRWHM2+IH+51JY+L
         3VrSjnJyZHPQc9kZMRmjGBonL/y+BlIs7uHY3+OuBhs09/j9rt8ctYHbSZFGJbw9n0Mh
         D57Q==
X-Gm-Message-State: AOAM532ouWmhxaxJYmwl6lSE039XwLGLnAgIZOJqP8Hljq2X42jBmTY3
        dyLhdsOVEv4ycz0dV5lh5CY=
X-Google-Smtp-Source: ABdhPJxi4ChZRxv4ZXh3zhxxZVa8cgjBtnlKQhzQoqqqwPN9fIkc9NTbAYovvFOqIgjQabl77PehFA==
X-Received: by 2002:ac8:605a:: with SMTP id k26mr14663276qtm.29.1611847572572;
        Thu, 28 Jan 2021 07:26:12 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:916c:60df:445f:4f0a? ([2600:1700:e72:80a0:916c:60df:445f:4f0a])
        by smtp.gmail.com with UTF8SMTPSA id e19sm3701401qka.12.2021.01.28.07.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 07:26:11 -0800 (PST)
Subject: Re: [PATCH 14/27] sparse-checkout: toggle sparse index from builtin
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <54ca484b057b5caa9871cffe47a0a60617e0c5cf.1611596534.git.gitgitgadget@gmail.com>
 <CABPp-BE1=UnFef2=CciL=2Hm53-2qXsMQ2UdMhaBheexR1Oteg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <46c47396-d42d-da6b-b71a-28e18ad93313@gmail.com>
Date:   Thu, 28 Jan 2021 10:26:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE1=UnFef2=CciL=2Hm53-2qXsMQ2UdMhaBheexR1Oteg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2021 1:18 PM, Elijah Newren wrote:
> On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> 
> I need to take a break from reviewing again at this point and work on
> some other tasks.  I'll resume reviewing the series later, perhaps
> tomorrow afternoon.

I appreciate your efforts here! I'm delaying detailed responses until
enough time has passed for interested parties to comment. If it helps,
then focusing on the "big things" is most important for now. I'll be
more careful about typos and things when I submit patches for full
review.

For my part, I'm taking time to look around at other things that need
my attention after being heads-down on this prototype. The sparse
index will need proper care to implement and I'm not expecting it to
move very quickly.

Thanks,
-Stolee

