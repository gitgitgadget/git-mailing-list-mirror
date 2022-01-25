Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733F2C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 19:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiAYTQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiAYTP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 14:15:59 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FA1C06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 11:15:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id h7so32846011ejf.1
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 11:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KCeqO9EOQ161fSCDrYF4LavKusZSgN8dyVrPUN61U+g=;
        b=jjt1koKP/fU+yqVKYgjzx4OOTmIHDW4WTKLf1op0Khh3O4oBlLXFTh27+xt2+x238O
         onmW9yLZeqg6RgJtPcXWEGLrF2d+Yyoz9AjGGIlDfLZ/8k6GBD+4UCqTl+csiXCweSCT
         yFiT3aN3ttsh6klQfYI7EW1T4ma4lNYSLTxt8v5DuBd4gI7fx4FUOEtN/9ReecNGyiHf
         tIjUktmBEsVqGgztUAy3G4AiQMC28387cuZy4ovqZoKFien9EXlveiXxuaCAYaqhC0Ou
         HI+jUqjDeYDBp6q2Ve6vjGRjoqES/mUVPvI9VKiL1Cepgo+jkBDV0QcKr7T35mSOtqmQ
         c0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KCeqO9EOQ161fSCDrYF4LavKusZSgN8dyVrPUN61U+g=;
        b=7K4SfrRKyd8lwrfP9T53RT3l378bJAROOQJ1sIGd5AjTlV7gwmcufeoHZnTRY8H/bd
         VGfsyfANarz8klIMVeKxBdzJ89uSHuLbq+cAS8u2zYtrbbTQANJwNH+iw+Wh8vOzzMof
         n8dTWP1jOUeL7qjeyL3UkiGDMPqORQj+PJn24ZI2XgnTSSlppXP7dsISdXsKcvRpaTCQ
         4f0xjQXnmUZLkPGc8kl4ecrzBNZC8hwQVo/wK8euNgyEWS1AnaQIVJn8oLs90aYXsQf6
         BH3P8S1QiJQgNQ0nOxdJsDGVWuWwgwkrMC/NCZ4R8mnJUCYpO1PooZToATtwDYA0HUpn
         H3Pw==
X-Gm-Message-State: AOAM532FaRd2Z8QKVebtVPE9WT3qoSkf8wu7a4ZUODQT8VpTu+hwKPtw
        UKRzEKrAMMLeQhUCzQWd65Q=
X-Google-Smtp-Source: ABdhPJy2icFjRExTXQpauq5Q+nuCkVizMUI4OVt+Oz7zy9VERRjUmsX+Id6p4bfwhyzLLGfCftZaDw==
X-Received: by 2002:a17:907:7215:: with SMTP id dr21mr17761463ejc.75.1643138157130;
        Tue, 25 Jan 2022 11:15:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gc12sm6609590ejb.23.2022.01.25.11.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:15:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCRIK-002xwu-0c;
        Tue, 25 Jan 2022 20:15:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
        David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v5] compat: auto-detect if zlib has uncompress2()
Date:   Tue, 25 Jan 2022 20:12:07 +0100
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
 <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
 <xmqqr190ekrh.fsf@gitster.g>
 <74d35354-20a6-9cc1-3452-573460c694bd@drbeat.li>
 <xmqqtudu9s7k.fsf@gitster.g> <xmqqh79t7sj4.fsf_-_@gitster.g>
 <xmqqr18x3s5s.fsf@gitster.g> <220124.86r18xgcv4.gmgdl@evledraar.gmail.com>
 <xmqqlez43mx1.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqlez43mx1.fsf@gitster.g>
Message-ID: <220125.86wninfwyc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Aside: I have not yet found such a compiler, does anyone know of one
>> that breaks? In any case doing this for good measure seems fine, just
>> wondering if we're cargo-culting a needless workaround or not.
>
> Before I started Git, I had to deal with quite a many variations of
> UNIX, all of which looked alike but behaved slightly differently,
> and I do recall seeing this exact breakage, so it is a real solution
> to a real problem, and I can see OpenSSL folks had seen the same one.
>
> If you find my experience is not Enough, I have no further words for
> you on this topic.

I wasn't alleging that this issue was a figment of someone's
imagination, but probing for whether it was a current issue or
not. I.e. it could have been something that only mattered in the GCC 2.x
era, and OpenSSL was still carrying.

But as Carlo notes downthread it's to do with ISO C strictness and
-Wempty-translation-unit. So we'd have caught it under DEVELOPER=3D1, but
due to the recent over-strictness of DEVELOPER I'd disabled it on the
test boxes involved, so I didn't spot that.

> If the question is "name a compiler that breaks and is *still* in
> active use", then the answer would be fuzzy (it depends on the
> definition of "in active use"), but is useful to find out.

But as to how to deal with it this is good enough for now, but perhaps
we'll consider something like this for a future compat/*.c addition:
=20=20=20=20
    $ file compat/blah.c
    compat/blah.c: empty
    $ diff --git a/Makefile b/Makefile
    index 5da099e8a16..62ec13c72fd 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -571 +571 @@ COMPAT_CFLAGS =3D
    -COMPAT_OBJS =3D
    +COMPAT_OBJS =3D compat/blah.o
    @@ -2604,0 +2605 @@ endif
    +compat/blah.o: EXTRA_CPPFLAGS +=3D -Wno-empty-translation-unit

That will compile cleanly on GCC and Clang with DEVELOPER=3D1, which of
course may leave some other strictly ISO C compiler unsatisfied.
