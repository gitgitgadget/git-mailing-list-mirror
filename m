Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEF7C47089
	for <git@archiver.kernel.org>; Sun, 30 May 2021 11:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A398610A0
	for <git@archiver.kernel.org>; Sun, 30 May 2021 11:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhE3Lev (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 07:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3Leu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 07:34:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40A7C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 04:33:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s6so10092910edu.10
        for <git@vger.kernel.org>; Sun, 30 May 2021 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lfKcxViRAiaBUjYFuyHnoWJ1BR1Tz/ElGbAzTYU2o+c=;
        b=U4tUi5Ngdja/pplUMjHeWBTvEz6/eJnu1zNONzRFfgnoDXAWLT4QkDtr3IS2i1Ymr/
         QZrg94yKFolFM9/mE3nqbHqAS3HLSmv07WbIjGXk6Q1b8Rk3Ujoj9H84XkpLs3jUiJcy
         0e2inLI1kqmw9rVum+Ayt20h7g9RdJ8sBQ2VHWHHbbWCFxmeA81yIBQgrTm3t2cPQphe
         V8f8SDRCkZSufefBSfM44XQSO62Jwe8jRtf6CizVA35qgl9lI4i6fhz5msZPCOmlg9kw
         trDIj/ktpE8JvNlLAz+OO5sw4dPWWz0PYDwxHMVVqhkwQgPTQbrUerKG8sUsz9kBUZae
         jGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lfKcxViRAiaBUjYFuyHnoWJ1BR1Tz/ElGbAzTYU2o+c=;
        b=mhr5nq4UkXhP3Uq4ARpgKU62WP4N92B7MSHbXLdL+3S1BBdZo39RhMN5XxjxebLF1l
         LYstq/wNm4n+K3O60u9wTyryB32u/Qp69jrVJqRtlMPWn69LJdlLEB6GPs6noN0MbMvX
         +rBVVggVci1036HF6olvRgPvfmTRRXN416Rj55/Pw28jJmQfcNiDSrgMQzVbc2cVa1/o
         am8/Dw3fjfj93kdx10v369XLR6XSWdNVZnZ7rd1J2y1f+gSMmuTXTJ7s9QgnBDGI7XfH
         VeoryqBTLw2ZL9f2sdAfJemiMJvjqCwCgSL34YpWdN4DiA8nwcBhcA7mz5UQNulDb7/v
         vJpA==
X-Gm-Message-State: AOAM530tr4BkDTfgAaOGOMNIHqdX5HYIGO5mC6X5XvJRzKc3KBR6j8zc
        vT14R22ULW4e4qulv8dgNBBSlCjFjy4=
X-Google-Smtp-Source: ABdhPJwGDJmuoBtbRhcDBgoxmMBLjUIhMT+1+L/BU2Xwwq3CG5sPydtvL3WDgc+AYbnPsxq1JbKM3w==
X-Received: by 2002:a05:6402:35cc:: with SMTP id z12mr19748122edc.154.1622374389076;
        Sun, 30 May 2021 04:33:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o20sm5377667eds.20.2021.05.30.04.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 04:33:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Unconvolutize push.default=simple
Date:   Sun, 30 May 2021 13:31:21 +0200
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210529071115.1908310-1-felipe.contreras@gmail.com>
Message-ID: <87a6oc318s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 29 2021, Felipe Contreras wrote:

> Tired of jumping through hoops trying to understand what the "simple"
> mode does, I decided to reorganize it up for good so it's crystal
> clear.

I'd find the end-state even more readable if this "triangular" wasn't
passed as a parameter but we just did the top-level dispatch based on
that, i.e. "simple" is really internally SIMPLE_SIMPLE and
SIMPLE_TRIANGULAR, why not dispatch on that? Our internal enum doesn't
need to 1=1 map to the config setting.

Part of that's that I prefer reading code in the current "master" which
is if -> die -> most of the rest of function, v.s. your end-state of if
-> stuff -> else -> most of the function being indented to that "else".
