Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE3BC07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 13:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6599A613FA
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 13:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhFDNYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 09:24:52 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:36573 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhFDNYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 09:24:51 -0400
Received: by mail-ot1-f53.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so9058622otl.3
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VnODRFS/xGm5Un0NSkLMZOmMWbWWZEurX5SFM0GpHBA=;
        b=cSUpt+FlFM68f/Tb/4k4JlXU6IzAlXG3793TvS3MO+KSLFJ4Zp+AIWcMK53BRYLlf+
         K2fQSDsjGYfRqIOW0WJKR59Fwv2FVH2fTcfP8nJMHC7+3RX8Bmxku0Y984gb8cjK8fdq
         2+MZA38AsvxEuPv/CMrPC741f8gFENWUGVAoDJ4foXtzALXQBX4V1Wd6nXas/eHIBSs+
         awuka67w///kXSHEyBmxfb1CMmkBUrfwV5/SHxYnB5geMYI6RdC8yIJ4h4RCPV8RLmlM
         noTr6L4YJKaQWSs3yV0kpT61eReXFycLBVqfZKuy0Yze9bVpE+dd/iB996YAZZTdJe3A
         ErfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VnODRFS/xGm5Un0NSkLMZOmMWbWWZEurX5SFM0GpHBA=;
        b=ZVai0EbgE/fsgh/c9GndsgEccfRpIR9wTFb9io0JJXB4eKSdXf7lAAS2Fq7fm+gwpp
         rQKof+DuC5k8hcSboXKQTfGSMNfSYX+Squ2HqWJgv64dOur7mpfC+XD2ygl2k8ieUvvn
         4U+mV6cWkfDmGQoOhpN0pwUUMZ0529PXsX+laTGF2+KUlz0DeH9C6Afm1vlPdgr+cgIw
         fYYj+TpJlEQUgcqbRVezV9csKvOEQ2HCTeooTHV4Lypm+ITPsPqEhG+LtrIcPKe4vnGh
         4wjhdgAppOrDoh2wBi/ze8QuaK0pEOwCCRdT001RuqOzT5O/w/6U6hYFfcZUKjx2V2HM
         ll+Q==
X-Gm-Message-State: AOAM533DYQ7nndyac6pZJ75wg9h8fGIPebvNfBwkGL54+ImiSMEYTTUL
        iTTXzhp4oi//LaUqLDITKg6U1Jf9tFQ+xg==
X-Google-Smtp-Source: ABdhPJy8Y7FIW87w7d3/BT9jOeef03KG3b9G2eYnPS+TtT22ZNB0cd4vigUfUcAbPuSdIGa4UcMrcQ==
X-Received: by 2002:a9d:798c:: with SMTP id h12mr3687191otm.253.1622812911715;
        Fri, 04 Jun 2021 06:21:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:a8e5:75e1:b132:878d? ([2600:1700:e72:80a0:a8e5:75e1:b132:878d])
        by smtp.gmail.com with ESMTPSA id m66sm457870oia.28.2021.06.04.06.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 06:21:51 -0700 (PDT)
Subject: Re: Partial Clone, and a strange slow rev-list call on fetch
To:     Tao Klerks <tao@klerks.biz>
Cc:     git@vger.kernel.org
References: <CAPMMpogCz4o3ZGYHnux_6w+uFyxV-FR0R1hFNeg1COiv0qd_0g@mail.gmail.com>
 <71e60d80-44c1-225d-3cf4-26740de2ac6d@gmail.com>
 <CAPMMpogSepMk07HVtwO8qKaHx2SHmYVB+vnrnWwVWBNo8U5hAQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5ce5286c-9390-7cb5-a039-8e26be990b8d@gmail.com>
Date:   Fri, 4 Jun 2021 09:21:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPMMpogSepMk07HVtwO8qKaHx2SHmYVB+vnrnWwVWBNo8U5hAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/3/2021 5:10 PM, Tao Klerks wrote:
> On Wed, Jun 2, 2021 at 1:18 PM Derrick Stolee <stolee@gmail.com> wrote:
> 
>> could you re-run the scenario with GIT_TRACE2_PERF=1 which will
>> give the full Git process stack as we reach that rev-list call.
> 
> Sorry about the delay, I've been trying to reproduce... reproduceably :)
> 
> I now have a whole file of examples and observations, attached (I
> assume text attachments are allowed on this mailing list?), which
> should be reproducible for anyone as I was able to use the linux
> kernel repo to illustrate all cases.

I appreciate that you took so much time to investigate here. You
have convinced me that there are deeper things going on than just
the "unshallow, but with filters this time" situation.

I have created an internal issue for my team to investigate this
when we have capacity for it. I don't think it will happen this
month, so if anyone else has the time now then don't wait for us.

Thanks,
-Stolee
