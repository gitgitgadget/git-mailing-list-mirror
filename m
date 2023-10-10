Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C150BCD80C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjJJMmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjJJMmj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:42:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3E491
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:42:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so931812366b.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941756; x=1697546556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ndzgib5sL05BO/zvnjaUfiR1V+k6R/Dgra0HgCBwFI=;
        b=Zjp+7P/lQmDpYnXocmpTUao4Zl+dERQXvTjQZ1mLAUUzY48fKNIYSeYYlQd+/vDVPN
         3CpBMgf0q7Lprya6sEbYlGwxjdQr8YRD/OMKv5F2iATe9CX4ZosJT+VL3kTpDj0KTPRw
         S4pbSbVn1SCj1hx6Oo3OpXPneBbbjF046tc0itMHbjvAPPtr7gYtj3vGmo4iBrStjUsH
         xEYZ0fXphMd6rEk+FKYWw93ivg1tY/8ypH6Yjs1V2zc+oNetpmAZe00r3c0qL9y6+IBQ
         fIyYDRGJyWzP9Ev+9kA0EsvxDyGGQ+vegRTQ0CYdHQTcvwfq3pFIp+9j5pdhGFA1jMGg
         m0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941756; x=1697546556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ndzgib5sL05BO/zvnjaUfiR1V+k6R/Dgra0HgCBwFI=;
        b=L78DWkKyCQiey9aCcAy92LMLvfEVQthbPESeFr/TvVHG3dUYoRngQxIxOIAC30C9xF
         PwzKEsvUKfUCmA0kK5afXCJJlPme1mpb4sWHF/TxJgj0FwXF/GuVn9FWVcghx/OoOMr+
         AkVaC/kURDU18Uk2qrdBvgyqU8UPJSjohVABvMN660ratn8BWUpsT1Edv4Gy7cETPAjF
         M2C7w5aP+xh8VcMuEOAlkpUcFC0REd/T6X780rzwOsyWXoXjSAVdYUngV49qa/vgm5cH
         ZltACAxS/tq3weAlBvgLQwuBH4UVmuElhICQwBMvwbDfCqiNSmRELggLDrsI97BNCRxG
         RKvw==
X-Gm-Message-State: AOJu0Yy/WXp8tD3HI+CuBPJ46uj8Xqh36n52dPWD8pg4bfXpWSdkDG2y
        DoRkxPApOjjaxk9eeLdREHaMevP83M4/98oGLcMp7TJZVQk=
X-Google-Smtp-Source: AGHT+IER5Ukr8KZ3lAnR72TmWuhkj1BD7a+5C5gZX/juGpI4SNFGNN9+mZBqyDUlXuJmQBdMxFoP6r4KV/+RrY5SwZI=
X-Received: by 2002:a17:907:7ea0:b0:9a5:9038:b1e7 with SMTP id
 qb32-20020a1709077ea000b009a59038b1e7mr20720403ejc.36.1696941755874; Tue, 10
 Oct 2023 05:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-3-christian.couder@gmail.com>
 <52277471-4ddd-b2e0-62ca-c2a5b59ae418@gmx.de>
In-Reply-To: <52277471-4ddd-b2e0-62ca-c2a5b59ae418@gmx.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Oct 2023 14:42:22 +0200
Message-ID: <CAP8UFD2USo_Lg14kVgqXpyt1iLfAhoW7w2EMpbqQRvvFkxudSQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/15] replay: introduce new builtin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Sep 7, 2023 at 1:01=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Christian & Elijah,
>
> On Thu, 7 Sep 2023, Christian Couder wrote:
>
> > diff --git a/command-list.txt b/command-list.txt
> > index 54b2a50f5f..d74836ab21 100644
> > --- a/command-list.txt
> > +++ b/command-list.txt
> > @@ -160,6 +160,7 @@ git-reflog                              ancillaryma=
nipulators           complete
> >  git-remote                              ancillarymanipulators         =
  complete
> >  git-repack                              ancillarymanipulators         =
  complete
> >  git-replace                             ancillarymanipulators         =
  complete
> > +git-replay                              mainporcelain           histor=
y
>
> I recall this having come up before, but in light of the still active
> discussion revolving around command-line parameter validation, I would
> strongly advise removing `git replay` from the main page and instead go
> for plumbingmanipulators.

Ok, I have done that in the version 5 I just sent.
