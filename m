Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD41EB64DC
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 16:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjF2Qfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjF2Qfq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 12:35:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5283B30DF
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 09:35:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51db8a4dc60so8663a12.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688056541; x=1690648541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlRsQWeIcc7hc/ekPyKXpWBj4Rp6MFKEinNvknmPhXE=;
        b=VMJ4tzk4y9bxmCY4o78ZwP75aQyUmYn0+13Eu6fONriwihGwKRGIpRInNNoL+gIT/J
         VRDRcxKmN2uuUgsajUsHxDOycETt7+CTi8EVJd7k82JhmGN3MmRwFOAyH9t3fSNlKldb
         UeDXD0UmZ1CQY3Cg+cbNZjjKP+p3MAN7KmadifnQgsk7Tdm3F7JnT1DCDsQcgZFqsnh/
         SzG3ItUogkGtSmC22sfXPP04WqVLR4dkq+9YDhFsQqsC42kj1uwM8TVsZfmtdWlx38SN
         fONFPb/nRuxJ7RuQF8baYD9vL/SwEBKFi77+OVhOBd5Hv8rDIXY/6hE1C+OvAj1rk1VI
         nF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056541; x=1690648541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlRsQWeIcc7hc/ekPyKXpWBj4Rp6MFKEinNvknmPhXE=;
        b=GjvD7diQZ7dLPDLrqJ2qFUZb+M+Zhp/UvNc/dckzVZZvwvOn/tbOLin0XkCJRop3R5
         WM4yMOqdxrhCv09BWVLN6Lr1+YaobR1GCLxhBQzqTMpUPmZWMGCjG8zl80nPcd5wF3HW
         j0wIvi+iJ7hpGd2JNynKYAUSlImVrgktPLRASI33WO9AwQyoBsWrjP3ZnZkh6jMzB9GY
         AiVj1OXeMEEtkzvrkT5C4hsnUmuQ533nGqAEkSLz6Lu/0PlUPYPbslOQ3aS98brZnaf6
         9h++/uaqQgI4J7Zw9N1epqlH6ud5KD0yUNv8nMxwVAKjcixayMV/9m56lVpxECEWq2G6
         R/nw==
X-Gm-Message-State: AC+VfDzH5Wt2P+1VScHZqqZlE8pkQsqtsYKyXIALsAYNZ6wqYAG0QKJ5
        Ngs5/yNSgNCgyjtX7z92+RiZ26mM0Kj7TWKFvvjG+OCzYTunzjJZPPM=
X-Google-Smtp-Source: ACHHUZ5LOoa3P39i93jypvGzDQpy99O01V+hZiGBsWCZOBdBnZ7gXO1AI35NdOEwe6fVsK8cMXzTlDCcuJ9uuWn3ev0=
X-Received: by 2002:a50:934f:0:b0:518:7076:74bc with SMTP id
 n15-20020a50934f000000b00518707674bcmr168472eda.1.1688056540650; Thu, 29 Jun
 2023 09:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <CADE8Naq5W3Bn=gwV7W-xMvYOMMRO=ZY9Ly6im4Rb_qFjMWTbTg@mail.gmail.com>
 <CAJoAoZ=OEfsgkqsag926tH4GEuafX26A09SGZ1vR1uLh2W_4TA@mail.gmail.com>
In-Reply-To: <CAJoAoZ=OEfsgkqsag926tH4GEuafX26A09SGZ1vR1uLh2W_4TA@mail.gmail.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Thu, 29 Jun 2023 09:35:29 -0700
Message-ID: <CAJoAoZnVAe3kvUdPZmanbKffG7cx3Tc-==H4+FH=L5qQP2smEg@mail.gmail.com>
Subject: Re: Documentation/MyFirstObjectWalk: add #include "trace.h" to use trace_printf()
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2023 at 9:33=E2=80=AFAM Emily Shaffer <nasamuffin@google.co=
m> wrote:
>
> On Thu, Jun 29, 2023 at 9:06=E2=80=AFAM Vinayak Dev <vinayakdev.sci@gmail=
.com> wrote:
> >
> > Hey there!
> > I was looking through Documentation/MyFirstObjectWalk.txt, and upon
> > building the branch containing the given code, I find that I get the
> > error that C99 does not allow implicit function declaration where
> > trace_printf() is encountered. However, upon including trace.h the
> > error disappears, and the build proceeds just fine.
> >
> > I did put DEVELOPER=3D1 in config.mak before building, but it doesn't
> > seem to work.
> >
> > Is the error pointing to a problem, or am I doing something wrong?
> > If it is the former, I would be very happy to send a patch fixing this.
>
> Yeah, it's almost certainly stale in MyFirstObjectWalk - there was
> very recently a patch to clean up some headers which probably were
> implicitly including trace.h when I wrote this walkthrough. Patches
> totally welcome - and if you were working from the reference code in
> https://github.com/nasamuffin/git/tree/myfirstrevwalk

bah, wrong link, the tutorial points to branch `revwalk` instead of
`myfirstrevwalk`, but the offer stands :)

> and it's on your
> way to rebase and fix that too, I'm happy to update my branch
> accordingly too. (If you weren't, don't worry about doing the extra
> work, though.)
>
> >
> > Thanks a lot!
> > Vinayak
