Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F897C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9A261403
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFOR2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhFOR2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 13:28:42 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9F0C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:26:38 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso15038304otu.10
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=qPgRlirlVwk5WwM4DJbVbuFzFMET8//DBO6whKsIeXI=;
        b=oFUgD6YxclyGXW1YPNIuw0u923AiezI9C+TKvdj48vLgAbouh0TY080vX0k0nOCoDZ
         PNbXgZQoB6kLiaSKKNPNZX1xupix4sFZHKUm2an61gS5BP5UWAvEPpN77O/L2WzjxxJS
         49mRv4cHyiEhVjeqmXb0N+VoCPK4DnS1NIt9kahmhvhCEbJ1rdAidUIfElAziPwQj95M
         07IhVv3HI4OaCKGO9X40L5l52Iz5RhhakBRJ0bl/A+2Z/C3DZnaKd+jv6dO4ifDqqW2d
         wZQI6pvdPnQ0FWRwItAYF18j4kHhEhbgR8dSWudy874+R4AJpQ4slTK4BMpj3IxrihMo
         o0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=qPgRlirlVwk5WwM4DJbVbuFzFMET8//DBO6whKsIeXI=;
        b=SEMzBkm9ozhl6zbXLk6LvkrAeDSuUZWdOe0t4uO1yZnr/iYhJPOrhEiiBGkTOVwyR0
         L2ual0Rk3rx2Cq6Hq3oCUFgKbOLuaX1It1UzaVkKEm4SrnbVDzJ0jbbOKFV4TuzOKBhz
         LIa+KmHx/lJydZrAP5jyXzfLmiGCfzduKqwTKny7oUX0N1OtqjXXBEjdVN3in2Xyvi1w
         5zqzT2/+SVfFD5muttSGlQgKeAZ4/xEoUtv6WGEbDF4hN/IV1k2d8aCPWpK/esJHoyFb
         UzUEXjTaoFzRKjFaymxMQK79GZg1u68g0Zw7UcqDluUAORF+Ekd8UztDf4G3UvpBut9O
         Q0xA==
X-Gm-Message-State: AOAM5316qkTTLbXCr13E42domrEuo5o8NmbzmqpInOFlUrn+iMcWDATL
        2JBh33Xdk03tVzhbVLbv3O0=
X-Google-Smtp-Source: ABdhPJx973Oz+L9IHvLuO/r8iU+C8YhVd5NG2kluQDgT/pcnO3E/q35AU2NTR39i0VbxY0iH6NKOFA==
X-Received: by 2002:a9d:6a10:: with SMTP id g16mr281506otn.71.1623777997495;
        Tue, 15 Jun 2021 10:26:37 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c5sm2009186oiw.7.2021.06.15.10.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:26:36 -0700 (PDT)
Date:   Tue, 15 Jun 2021 12:26:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c8e2cb81e50_12c28208c2@natae.notmuch>
In-Reply-To: <87a6nryt51.fsf@evledraar.gmail.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Jun 15 2021, Derrick Stolee via GitGitGadget wrote:

> Anyway, I don't think I'll be participating in this topic any
> further. It seems you're not interested in pursuing alternate approache=
s
> that accomplish your goals, or in responding to specific point-by-point=

> feedback on your series from myself and others.
> =

> I do think it would be a much better and respectful use of everyone's
> time on this ML if you clearly stated your unwillingness to deviate fro=
m
> the narrow approach in the initial version of a series you're
> submitting.

For what it's worth I also feel that's the case. 95% of my suggestions
for improvement were completely ignored, and it's only when the
maintainer threatened to merge my competing series, that I started
receiving responses.

I don't believe critical feedback has been welcomed, I don't believe my
time as a reviewer was respected, and mostly it felt like talking
to a wall.

I find it ironic that a patch series that boasts of promoting inclusion
and diversity completely ignores the most important diversity the
project should care about:

Diversity of thought.

While claiming to be trying to avoid hypothetical people from feeling
excluded, it actively excluded the opinions of actual people.

-- =

Felipe Contreras=
