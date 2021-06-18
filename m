Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC9AC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A74610A7
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhFRQmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhFRQmS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 12:42:18 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B584FC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 09:40:08 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so10281308oti.2
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FqU0D2b+CcC+qnqv6UMOK7NYUxruYwV2U8i8PdstKNE=;
        b=GrL+c36MES83jMSBDfRDjQeb3FCJvWZ2nb0r0iX6tcg825UOZr3V2li1Wric4mMB5p
         xQF6CR7mUSMbhj91Npqx5AYLTliYCzjsPpNvzwhFXcHTt/Mh63XPEi/w1R0Vids6/Ty2
         hUODTJ//wFx+S5u0F2gEvBW/t+d6NodhTLVxQuuTi5j2fh/gpjEi+ZEqbKInsYOE5ueF
         s9Bu72ACX70OWa1nvnnzzrbw5GmE4jyPaRQdeKxvDmWgLssGPPukFOpGieh5lex+59Yr
         gOXHvLgTk/mVmYP5lrNDZlGzEyGIJ1c+BeXfkxyIxwYfCJq9QPMG/hiX6TLHr8E2vBiA
         eeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FqU0D2b+CcC+qnqv6UMOK7NYUxruYwV2U8i8PdstKNE=;
        b=g/Qny0HWblyljBdVNMOYNeGRzJfNAKv1fOSSzxOxL/OKfr4oAOxyCJWZMgNicpxg50
         f/rVSrIPKc4+xx2Zw2383TzJYdfD1cpnTDljWDMdVQhyamWNWany0sAQpmpKIorZG2Hv
         yatfxK5EzHCmHkwY4/UC9PuFHCx9DuAqTWRJzu1y4KWjtCO0sbpiyhXAM7Ak147QnUEv
         gS9YQp6Kv1NfynWbmqshCj4Hmr1GxI8b9iD1OUbxb/hmNm8apc1ZEwB+51dOM8wAjz9g
         v/Y19MO4FoRym5rdmABAdKjW7dowKYQdyxGp1nET9yZk5ZfUKqFXEek/tkLZhRQOvar5
         K8kQ==
X-Gm-Message-State: AOAM530+h2iDl4AUeeNS5ulARkGBzS2D0jPDI20Ae8b/VGYRZ+kfb9XZ
        Rgv7Yk8aCqaC5BuU8vKBSEI=
X-Google-Smtp-Source: ABdhPJx4d1q71ZPZyE7B/09Sl0ChsP0MFdUylvpzLZLu0sLXTAR28GLBZP5ja99+DV8zk3WS8HVBBw==
X-Received: by 2002:a05:6830:912:: with SMTP id v18mr10376029ott.241.1624034407977;
        Fri, 18 Jun 2021 09:40:07 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id e24sm1127084otq.32.2021.06.18.09.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 09:40:07 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:40:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jrnieder@gmail.com,
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
Message-ID: <60cccc666c70f_5eaa220820@natae.notmuch>
In-Reply-To: <87wnqr4n0i.fsf@evledraar.gmail.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com>
 <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
 <87bl85y15s.fsf@evledraar.gmail.com>
 <YMvuprVu1MnokHM5@camp.crustytoothpaste.net>
 <87wnqr4n0i.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The CodingGuidelines is what we're asking people to read when they've
> e.g. found some data-eating bug in git and are about to send us a patch=
,
> but before that we're asking them to go through a fuzzy checklist of
> items checklist. It's already 20 pages in my browser if I were to try t=
o
> print it.

Exactly.

Moreover, the point a guideline is on the name: guide. After reading it
developers should feel they are heading in the right direction, but they
won't know everything there is to know about git.git development, that
requires many years of practice, and mistakes.

More importantly than what it is, is what it's not: by-laws.

A developer that misses a point in the guidelines should not be
reprimended and sent to the brig. Instead she should merely be directed
to it.

Another thing it shouldn't be is a tool to win arguments. If two
developers argue about sentence spacing (one space vs. two spaces), even
if the whole community agrees two spaces is preferable--and thus one
developer "won" the argument--that still doesn't merit writing it down
to further rub it in.

Not everything belongs in the guideline; only the most salient tips that
guide newcomers in the right direction.

Cheers.

-- =

Felipe Contreras=
