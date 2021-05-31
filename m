Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E75C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 08:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A7660FEF
	for <git@archiver.kernel.org>; Mon, 31 May 2021 08:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhEaIFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 04:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhEaIFU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 04:05:20 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07801C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 01:03:39 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id x41-20020a05683040a9b02903b37841177eso865494ott.9
        for <git@vger.kernel.org>; Mon, 31 May 2021 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=IXhjngKih8W8K57gsK2f3WdyiVBTYPyMEKShT9K+mVU=;
        b=A4zInqjHfcVSiZZ4lNoA0xmcY3M7AtVI4tAVG49Rh3P+dOmvh4kTBGebzriu4h94Ia
         xsQecgqAiimI8+PU1Cmza9trBoopImmZOmdQgwcoAs1SFJ+/+c28b76zMjjtxKDSqWpV
         uRIXbTT9Dhv8xhw5qUOGaCV/CBlaTeBeNeow3tfDwP/LvI5y5ReypDfqrBgs+maGWtNg
         MEW5K7dUFphIrLwE6HhCTyeHCOGzW9bSeERhdW1ZBympSyVppX9Or1a0C8lqm3TRRbRL
         qaO2/1pSzknTXzSPOLhPlte2c6Utb/V4xeF8hApGgfVz1TP2MjbOpLQuTTwGiQJWJSmL
         o6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=IXhjngKih8W8K57gsK2f3WdyiVBTYPyMEKShT9K+mVU=;
        b=gnmsmRmMpow8JKEimJNytCWe6uJscF1gObGCRAPdIR4q3VrFzJG+fCHunv80VHg3GX
         gr46SRnuftSH2WE55h0SLuVfXlsSikmokalmm7dKKjdb1AZ1OCJlnxXTW4cPQk0csuLl
         /lfaVDuAE2HxA+Vizih12jHdp0SFCIf0teCLkl6aI7mnv54ouCasj+QwuIfUlaxfoOrE
         A0/wjA1MKuBPxash0XmCMoeJTkapm1xN6qXjRFyjJHwR5vnHp3zjfGKwcumG/zQped/B
         qQtFacOwWvILT3zWycGMgs0RXbYwR00+Lm2Lt10rcMLb/oqETCcbBDxuSegbFWjJlen3
         R9uw==
X-Gm-Message-State: AOAM533zfA2pI8U5MrNF9c/AWa6j+7AbQmGRgZLBjYoV+sJo0kdPKnpK
        v2hnlsIgbU6KaYn+ZYau0RI=
X-Google-Smtp-Source: ABdhPJwLC4ypkUkuzgBLZnYVfKd0okNGZ+Fqfe0Wf64z3Qey9JBjjMk5aWGgDrwAXSbWsRjdpoHKUg==
X-Received: by 2002:a05:6830:1196:: with SMTP id u22mr16008163otq.247.1622448219242;
        Mon, 31 May 2021 01:03:39 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id i2sm2947978oto.66.2021.05.31.01.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 01:03:38 -0700 (PDT)
Date:   Mon, 31 May 2021 03:03:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>
Message-ID: <60b498599fbde_24d28208d4@natae.notmuch>
In-Reply-To: <xmqqczt7xzm4.fsf@gitster.g>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-3-felipe.contreras@gmail.com>
 <xmqqczt7xzm4.fsf@gitster.g>
Subject: Re: [PATCH v2 2/6] push: move code to setup_push_simple()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > In order to avoid doing unnecessary things and simplify it in further
> > patches.
> >
> > The code is copied exactly as-is; no functional changes.
> 
> The title says "move" and I expected to see corresponding deletions,
> but it seems that this (possibly temporarily) duplicates what these
> two functions do, without removing them, which (possibly
> temporarily) risks the two to drift apart.

OK. Copy then.

> From a quick scanning of the remainder of the series, it seems that
> 3/6 and 4/6 improve the copied code without changing the behaviour,
> and at the end these two functions remain, so we have duplicated
> logic for these two functions and improvements only live in one of
> the copies (namely, in the setup_push_simple())?

Not quite: setup_push_upstream() was simplified too, in 5/6.

Maybe I can mention that part of the code of the `simple` mode lives in
setup_push_upstream() and by copying the code to the right function both
can be simplified.

-- 
Felipe Contreras
