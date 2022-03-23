Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A12C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbiCWU0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbiCWU0S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:26:18 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7786C43EF5
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:24:46 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id i186so2736004vsc.9
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pKZpuGBYyLd5aZWS1auIlpm4O7PvAkrz+dxcs6VGUng=;
        b=Hl8cmIXsVu/I7Andb2USVL1FHVpzNFt5IRpgF/ZXJAifxd2gCL+RELlcTxJ/QLM2yD
         3ehz8+hV9PZqApoB8m1fyiWRmA1kSzeKwexEszVA1wZpN1ZTUCsAjh/hO5mq5pJ+iUrp
         CQHlcQDNhLt10xQlxjxzK/mCm0/wEmJVKjLZyuebdGNbXxWW4s0ktDhZZUr/IBz8/J//
         BM8kXWV8+ire3pwx9wihjqm2jtWMJTR36BPekSG+kBPg6U38tAJmerqWr3ZrFHN7racw
         bh1beMenY8XGR3LYcku4ktmjTizKgtBsb5hqeWClZ94k+gxFy+OB0fMvJSLfax4Bs+/5
         g9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pKZpuGBYyLd5aZWS1auIlpm4O7PvAkrz+dxcs6VGUng=;
        b=6jtACVSpTmYAh2uA0PeCytwRCpNeTDsyoPQbxQKKUgftnC6m2kCvW7c5gMTuOdVfF5
         Pta69h4IgkyYKXt4cu9P/psinlzU1+5W9bHIVkoev21iDHBHXZVCv/j/p8tBRh/jsFhS
         L6n4bZfwFtyD55P5xT/OhxzK6FiDZttFIVQmGeuSFmgwMXlrOc1EQzYAsvlUmXcU07FH
         20I7xJ/67QTAmhmOuMe4kpw3UZlMLkd3m8EkV/vSKaD+wKQLio38mZKlHEQ5RmS0/rAF
         ZeH2CFpuSFJziyKyeldpvnfaO2Cg4EGbyv03jAO3h45wRqf+GGmzPq0BpcHSAmjGR3KY
         cZ2w==
X-Gm-Message-State: AOAM531jSCMPIy5VV/GUoR0BrKeySkLbdzcNRT/+TRbcGEy7RxTo9a3T
        IQk8aJlpANlKox9JsoJIAdY7OUtkLgtOTWmrnqM=
X-Google-Smtp-Source: ABdhPJxyMEDOdU+zcTyjg6xpX6NtrIZb3Ap2Jlbg0fPNZoA/4YoHxFkFA9tB77kmk9hgBU1XgqZmMi7c4GO+l8c3B3g=
X-Received: by 2002:a67:fe12:0:b0:31b:9356:40fe with SMTP id
 l18-20020a67fe12000000b0031b935640femr985222vsr.1.1648067085589; Wed, 23 Mar
 2022 13:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <bd751d5c-2f8b-4c52-72ec-f2b7268a30a8@cs.ucla.edu>
 <99b0adb6-26ba-293c-3a8f-679f59e7cb4d@web.de> <20220323010931.jzf7op7hdusdty33@carlos-mbp.lan>
 <1187feda-c14a-f75c-6e09-4df101f00056@web.de>
In-Reply-To: <1187feda-c14a-f75c-6e09-4df101f00056@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 23 Mar 2022 13:24:33 -0700
Message-ID: <CAPUEspjXy2dLF0B3c6aQ3tfUFV3q2SDdULnY7u4otGicicYk1Q@mail.gmail.com>
Subject: Re: improve performance of PCRE2 bug 2642 bug workaround
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Paul Eggert <eggert@cs.ucla.edu>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 11:37 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 23.03.22 um 02:09 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> > On Tue, Mar 22, 2022 at 09:26:10PM +0100, Ren=C3=A9 Scharfe wrote:
> >> Interesting.  So you say bug 2642 [3] requires the flag PCRE2_CASELESS
> >> (i.e. --ignore-case) to be triggered.  (That's probably documented in
> >> Bugzilla, but I'm not authorized to access it.)
> >
> > AFAIK the contents of the bugzilla are no longer accessible to anyone
> > (lost in the migration of PCRE2 to github), but the use of
> > PCRE2_CASELESS introduced in 95ca1f987e (grep/pcre2: better support
> > invalid UTF-8 haystacks, 2021-01-24) might have been a mistake all
> > along.
>
> Ah, OK.

It happens though that the original bug2642 did require PCRE2_CASELESS
and was fixed instead by PhilipHazel/pcre2@f8cbb1f5[7], so you were correct
when suggesting that the lazy coding of the condition was fixing more than =
one
bug and therefore it will be better left unchanged IMHO (except maybe from
an improved comment)

> The patch below adds a test that fails even with a PCRE2 configured with
> --disable-git.  Current main passes this test even with PCRE2 versions
> 10.34 and 10.35.
>
> "PCRE2_MATCH_INVALID_UTF && (options & PCRE2_UTF)" can be simplified to
> "options & PCRE2_MATCH_INVALID_UTF".

indeed, but will also need the PCRE2_CASELESS part that was required
from the original bug

thanks for adding a test for the infinite loop one, will definitely
help future readers.

Carlo
