Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEACC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1AB6162A
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFOQdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhFOQdH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:33:07 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02129C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:31:03 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so14873029otu.6
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=PMDaZ7KSQ/Mt5d59qTASh8jt37hD4FvIH14+irqHyKM=;
        b=eLfoxG3eqXHLKIcHFrZkwD2L+dxieiuUvIZ4iWwtzj6oF9PaCXfiIUa1CQ5Xsx8w4n
         g/xzS1g/GzXYhLf84BEOk4Gbyz70iwFYyJmH8emGbLCx/I63UmmyPYpZml0bziwuZjIF
         2O/1tSIBPdqOsJz8u0YdC7mgbgiwjfAQAgJEWHA3vC1XfTtzchu+6boBvYwVQ7sSww8s
         iPncQ9ftBKAreo5LG5WUkwEL5qltoBBXOgQai+XDvv0BaaTn0khMNZPYcY4M6EpNxI54
         MswTM9vSFa1BZFnSjPNIQk7+8G8tBRpZwer35hmGDvE6Wimq7XckQseXXVDmkvQ4HbGc
         fX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=PMDaZ7KSQ/Mt5d59qTASh8jt37hD4FvIH14+irqHyKM=;
        b=mFhf97ONZEZDI1wOxBVsj9f0saN1XarPD//H45ld+utQ4kFZ27Jth0dAyy9Z4GQmTt
         v/YfcY2fn3zWqT/VKbmNPMTd7iA7abuCqUbY69E+UxCxR6bJXbZnuPKq7zN8xQyT8cbM
         rLSdwgD1hdSMq2Gx/yrq94MdrTnfM6g3z+KsTd7cfnvyp+yb6WKO5wjfSykK4KIIlEcA
         3g+zrXbjp2S32iKg0eUbR4uua0ZCWW94OijWHWUutkpccqaFP1J7v+RlCpya2FCv27bc
         kcRTy3W1AIOgroDBLxfxf3p4yNJWEDd8rXnwmVann9BBVSHj7Ulk9ZQnMI2C0t9o1s/r
         +dQw==
X-Gm-Message-State: AOAM531qL9Y1Ix+4OptxsrSlRETmXv54t2//hqs6hQdMq/7mRJg5BPAy
        6Nn1zilHRLZwCbTO+iKjTj8=
X-Google-Smtp-Source: ABdhPJzYkZ3eXafd+b96SLKt+IGAzaUawTFUkgzAivDqFPgpE5QbWo5LW5kVgqhAFmvWxqmK39JE4Q==
X-Received: by 2002:a9d:7414:: with SMTP id n20mr139589otk.194.1623774662413;
        Tue, 15 Jun 2021 09:31:02 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w200sm3784141oie.10.2021.06.15.09.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:31:01 -0700 (PDT)
Date:   Tue, 15 Jun 2021 11:30:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c8d5c39ef39_1296f20847@natae.notmuch>
In-Reply-To: <94848796-1a7f-e1d2-fcf7-5e6f5f361f2a@gmail.com>
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
 <20210611202819.47077-2-felipe.contreras@gmail.com>
 <94848796-1a7f-e1d2-fcf7-5e6f5f361f2a@gmail.com>
Subject: Re: [PATCH 1/2] doc: avoid using the gender of other people
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 6/11/2021 4:28 PM, Felipe Contreras wrote:
> > Some people have a problem with using a female reviewer or a female
> > developer as an example, and since this is an irrelevant detail, let's
> > say goodbye to our illustrative female colleagues.
> 
> I find this message to be snarky and underhanded instead of
> actually describing the goals at hand.

But it is accurate.

I have no problem when I read a text that uses a female reviwer as an
illustration. Apparently you do, and presumably others.

> Citing the reason as stated is _not_ the purpose of these
> gender-neutral recommendations.

I believe the purpose is to tailor the wording to you.

> Instead, a message such as this could apply:
> 
>   Using gendered pronouns for an anonymous person applies a
>   gender where none is known, and further excludes readers
>   who do not use gendered pronouns.

It doesn't exclude the readers who do not use genedered pronouns.

Anna--a Finnish reader--may not use gendered pronouns herself, that
doesn't mean she automatically would have a problem when reading "she"
or "he", nor that she would feel excluded.


This patch is not for Anna--who has no problem reading an illustration
in English which uses a female colleague as illustration--this patch is
for you.

Cheers.

-- 
Felipe Contreras
