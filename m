Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3967AC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 14:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B41613EF
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 14:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhDOOyf convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 15 Apr 2021 10:54:35 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:36689 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhDOOxI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 10:53:08 -0400
Received: by mail-ej1-f46.google.com with SMTP id r9so37290892ejj.3
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 07:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qmkludxUze/CUdmAQ3+go7dgV8DBMG/vrStwbXR3QMc=;
        b=tg341f34A7/6If6KNwBzepfZxG8s1kW56kt0G/EmdcvCP9n/cQzwWsTR1BxvMSKcGS
         DOT4TmqjZGc9v92cylPPoUnSEgj9nkfNnk6FmiN0foC/Gix6U1PKiYXOxYTf02PlQ/WU
         1Tk5pAU507ncduHsVujxIIuEj7zD5NyoCQV/aiwitdPqQDtYmS6G/roJk2DfWWyUwsxT
         H7pWtYnV9ZkwB8qZXQyjC1yKToiSLKsrfbUsmzcDWU9eOVOIz22vb9o2KqzzOFJZQaV/
         iJwZtICB7NHyjSKSl3IPpwkUcKkCyd5riSXp7/hYWASeJo5Bg8GRpTR7RUkSaE9iGexL
         66+Q==
X-Gm-Message-State: AOAM5315FfM3fVWY7ZYS8VC6MD+d9WI4aCK6gxigipPSNwM62rq2Qr5K
        FNnwErnnw31cuiJ43RUMRx51iU46uYaCJfvnRMc=
X-Google-Smtp-Source: ABdhPJz+II30oiGkfl950CSJXiC+D04Bz02/6KP5s5D4kdemEuXSbkiNbuBe2wJqHTHIzMV08/PGgaEMbLphH/btlhU=
X-Received: by 2002:a17:906:37d7:: with SMTP id o23mr3792836ejc.202.1618498364855;
 Thu, 15 Apr 2021 07:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-08.16-352eeff41c9-20210412T110456Z-avarab@gmail.com>
 <CAPig+cTTjX=keJJdXLfsP52tQJZULgzjqbvYm=QZLK2312qRmw@mail.gmail.com>
 <xmqqk0p7b3d5.fsf@gitster.g> <CAPig+cQSS8yp-K8Z5q9eG1t-7sFAyuPEvFDNvX_JaY07BKcMhQ@mail.gmail.com>
 <xmqqpmyzm71v.fsf@gitster.g> <878s5jvl3i.fsf@evledraar.gmail.com>
In-Reply-To: <878s5jvl3i.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Apr 2021 10:52:33 -0400
Message-ID: <CAPig+cRJ1j_FJcuf-T2xhPhJBWGH0_84SfbZ7V9NbSP+QdJpXQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] test-lib functions: add --printf option to test_commit
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 7:33 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Apr 13 2021, Junio C Hamano wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> >> I don't care for `--raw` either but couldn't think of anything better
> >> at the time. But perhaps a name such as `--allow-escapes` would be
> >> clearer, or perhaps not. `--c-style-escapes`?
> >
> > It's printf(1) style escapes ;-)
> >
> So, the conclusion of this thread is let's keep it as --printf?

It was bikeshedding on my part, so I don't feel strongly. As
mentioned, I only brought it up because my first thought was to wonder
how interpolation would work. One might suggest --printf-escapes or
--string-escapes but the audience for this is so narrow (Git
developers) that the short and concise --printf is probably
preferable.
