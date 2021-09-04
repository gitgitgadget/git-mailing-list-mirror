Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5753C433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7558E60F4C
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 14:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhIDOna (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 10:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbhIDOnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 10:43:25 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70747C061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 07:42:24 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id x21so1183611uan.6
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E3hs02KniVXRlFtp6yXyb3+4l7rCoJA59u1IidoBlk0=;
        b=prpZzgXK/qRi6vZqAB6c2bW3Lxj2O7NXlgn5Rd2/U01X0hHWpUoP31R1siHAUwVozV
         oFJjkVZ046opyObCEBuJnXYY5p+wWtLUO8FbohDkRdPHhW8j/s22mhGNLI1YPXVyq9nB
         0JBCiZUckNoOqz6IaGxel3NlUFmRVvKg3rnz0mqNCceVRsB2VbNF5Og62iuU5lQgfOMt
         PfsbDRVRT3mM8V/F4K67zaW2dTlSm9x1j6jGWVWoKOS79imBBmpgu4ar4u/5etYc/h11
         xvQ2f5FlbownET7j8VtqbklITDSDyka0RlFFtRaxOsGNXWaISs+s5Wwj4j6vN62ey9kf
         Ipfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E3hs02KniVXRlFtp6yXyb3+4l7rCoJA59u1IidoBlk0=;
        b=thY+oXc+IavZQ3z4tWOJytHTLDT1s5yw0NR7wJP8p2GydaGVCF2QiKTEwqdlIfGR8N
         B4BX1zASi7MLDy9xiqFPTTfhbBlI52nD2SnFTU4uGPI0lkvy6EY9JT7hB4QpGDt0qRsb
         sr3msB0KUmImTHJUTicZB6yGgoNFF9zejwCDJcR/DZMOh7T9Iv5cYDDAMnVkGEATUzkX
         zWttC/6oiZBav6FtVyGzk0DPuoZAOdtI9FRoDBqsOE+ZLGUKyxdEbR5cOmyMd9fKha+p
         sJJ79RxK8BQcvHYaOpWy/OmvfhCbfQf7uy7BfLLpNlRSlfu3GFtPnkkxezdoOlmjFuml
         NyFA==
X-Gm-Message-State: AOAM531bPSbx/f+m8eYAZP8Bh+utLtub89/+jIFNqrdfBm3obqhU3CS9
        a3PcDLEgvoNWaOHvVWY93xDInleCQpR5rXkI4N4=
X-Google-Smtp-Source: ABdhPJxLraR4tyfYOVX8kcKtRH3JN8G1xizBPWG3LOGG4LztUEf+XHXwxGMww1zAuq+z2STzzNVbdmSuTq0XC7UYepc=
X-Received: by 2002:ab0:3418:: with SMTP id z24mr1930995uap.96.1630766543494;
 Sat, 04 Sep 2021 07:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210901091941.34886-1-carenas@gmail.com> <20210903170232.57646-1-carenas@gmail.com>
 <20210903170232.57646-3-carenas@gmail.com> <bc4789a0-ae80-c1dd-35b1-86949a807490@web.de>
 <YTKBzi3z5AotirNO@carlos-mbp.lan> <e20dc0b7-8925-1ccf-3adf-c52a892cc3f0@web.de>
 <5983c238-e926-3b08-ed10-1de1343a8d00@web.de>
In-Reply-To: <5983c238-e926-3b08-ed10-1de1343a8d00@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 4 Sep 2021 07:42:12 -0700
Message-ID: <CAPUEspheuPPfbCv59ouNcq4Ac8-6LvOAwDO3V3F9UJGHm+Qwyg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        phillip.wood@dunelm.org.uk, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 4, 2021 at 2:37 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 03.09.21 um 22:38 schrieb Ren=C3=A9 Scharfe:
> > Am 03.09.21 um 22:13 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> >> On Fri, Sep 03, 2021 at 08:47:02PM +0200, Ren=C3=A9 Scharfe wrote:
> >>> Am 03.09.21 um 19:02 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> >>>> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmall=
oc.c
> >>>> index 1cc31c3502..edb438a777 100644
> >>>> --- a/compat/nedmalloc/nedmalloc.c
> >>>> +++ b/compat/nedmalloc/nedmalloc.c
> >>>> @@ -510,7 +510,7 @@ static void threadcache_free(nedpool *p, threadc=
ache *tc, int mymspace, void *me
> >>>>    assert(idx<=3DTHREADCACHEMAXBINS);
> >>>>    if(tck=3D=3D*binsptr)
> >>>>    {
> >>>> -          fprintf(stderr, "Attempt to free already freed memory blo=
ck %p - aborting!\n", tck);
> >>>> +          fprintf(stderr, "Attempt to free already freed memory blo=
ck %p - aborting!\n", (void *)tck);
> >>>
> >>> This change is not mentioned in the commit message.
> >>
> >> got me there, I was intentionally trying to ignore it since nedmalloc =
gives
> >> me PTSD and is obsoleted AFAIK[1], so just adding a casting to void (w=
hile
> >> ugly) was also less intrusive.
>
> Expected your [1] to stand for a footnote, and got confused when I found =
none.
> The last commit in https://github.com/ned14/nedmalloc is from seven years=
 ago
> and this repository is archived, with the author still being active on Gi=
tHub.

> Seems like nedmalloc reached its end of life.  Has there been an official
> announcement?

Apologies; this is the [1] I was referring to:

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.1908082213400.46@tvgsbejv=
a
qbjf.bet/

TLDR; nedmalloc works but is only stable in Windows, and indeed shows other
warnings in macOS that would have broken a DEVELOPER=3D1 build as well
which I am ignoring.

 compat/nedmalloc/nedmalloc.c:326:8: warning: address of array
'p->caches' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if(p->caches)
        ~~ ~~~^~~~~~
1 warning generated.

Carlo
