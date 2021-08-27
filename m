Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08770C4320E
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F8960F92
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244517AbhH0HvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244495AbhH0HvV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 03:51:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6A3C0613CF
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:50:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g135so3259252wme.5
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=PCwJxX6mMHE1jA9QYz9G/JPEX15/foxcUAm3H3keM+c=;
        b=JHHiXOXnvTki7SMYwCO65RjWq/pk+KC7fuD/+U7J2UpCY0paZxnXVN0qcfbVgpvpX7
         njlQvHyibEyBk/VqckpEmv3JDyXmNSPwmrFIPZv2Ox+cTtFsSQ0ATHMvTDAQcz4PMRtR
         kHT2MdyjAy6cn10HbPWueoOvw86JeB+HgLmudTo3iXg9PlkWJRhOXFINo1Db2Ex8DnHL
         rWD82IYzlKUXfGUCxQOTewIML3eaN5MBxqJqwMDPUMqzSdIZgHPdz5nsrs/d6sDgjK4H
         Y4Pn2ULG025BzoKLy/Dm01jTEJxpV/1Ox4HdONw7tFIo8d8HmTqhkSJtXo3wmggkjggH
         iotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=PCwJxX6mMHE1jA9QYz9G/JPEX15/foxcUAm3H3keM+c=;
        b=X8wwB8NF9U4GHLGdqg21tRnumTkXzVCwSkT5CjuSyUPYnZ2J3Vim8SG191nfAvzYOv
         tiRaAYJf4mUKYXl+vaYbJ4eEUPMkn4pD3UCTn77GN2VefrbXPFtqcCN1EVwXLJlYh9U4
         lN1szgEmr1SzVNcv0LVFB3BKV2D2vIZblWslBgl7ygE8AAwNFT+bPAhloWhRcTsgJuok
         QkViN4akYDX2qS3FLqMVCNG2LRFDGjhnSEAHoGS8zlf/J7GC5i/irxlGP6NCu/zAn/j3
         pw1N7yIEkGnm42FLCb/NZYu6nPtQd6s0oHHb+LxeA8jXEyIU3MVSKwhnP+SLH4gZV8uy
         tE3g==
X-Gm-Message-State: AOAM532X7HGgvdWD28youBysGPyFMqiwFxQUmkdKlqz9tFYPDN1KJ6JT
        FBHYwqGfy1f89UcnhMDRfXE=
X-Google-Smtp-Source: ABdhPJwHgdJGhRHevFe716MQmb4MOQnSdN811kHQqZcsLF76Vk8RI8p7GkUWvSM6p9nMi3Tt997rOg==
X-Received: by 2002:a1c:7316:: with SMTP id d22mr18416632wmb.171.1630050630801;
        Fri, 27 Aug 2021 00:50:30 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z2sm4838302wma.45.2021.08.27.00.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 00:50:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/4] test-tool: split up "read-cache" tool
Date:   Fri, 27 Aug 2021 09:24:12 +0200
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
        <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
        <YSVwioizjGKVSXQA@nand.local> <xmqq35qyl6ks.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq35qyl6ks.fsf@gitster.g>
Message-ID: <878s0nz5q2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 24 2021, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> If we're looking for things to clean up, I do like the conversion to the
>> parse-options API instead of reading argv ourselves, but probably
>> otherwise prefer the code as-is instead of split across many files.
>>
>> But I may be in the minority, and there may be others who do find the
>> split-up version easier to grok.
>
> FWIW, you're not alone.  I too like the use of parse_options, but I
> fail to be enthused by changes to churn the test helper binary.

I think it's an improvement as-is & would like you to pick it up, but I
understand if you disagree.

This series converts the code to parse_options(), but also changes the
perf test to not load config, and adds a --refresh option for a new perf
test.

I tried to make that readable all in one function, but I think it just
ends up being more of a confusing if/else jungle than the current
state.

I don't think I'm the right person to re-roll this in that way & argue
for it being an improvement when I don't think it would be.
