Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E635C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6982E60F3A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbhIAVIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 17:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhIAVIL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 17:08:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FDDC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 14:07:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p38so1987497lfa.0
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=acesquality.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=prO7e8kKLjI+odV4HsFW2ccdXJk6FbtdByeDIMmHx3Q=;
        b=gDZTJ7N5YFzWQ+L4bq0NriGhuuoRr8bNnszyK0nC4zcePkrmLH76hLtTbmihO/B2lh
         ITHjKwwyWPvVzrfisv8TtXsKJzP3JZR47fS3oV8zk2RGBqqfgD8uG0ICd1Isksh6kI4S
         HV9UYnMCD7RglhQ6MEhfljpzpl1sySdxSBDu8vdow/g137IIBs9sY/dnldqegkMh6p5q
         YBQ/LUAqtTpPs0KEk+KL1syoH6ex/KkBUBQ5RmEhmeNr7DINpDDbDuT7c5rPEgy/VdcX
         4/8gc5oWGWQzWT5UZkNlUNFaeUoaLJe0bhzNf2mQwCRVBJOHixtzjGpH7M88Pcv/LiGH
         KpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=prO7e8kKLjI+odV4HsFW2ccdXJk6FbtdByeDIMmHx3Q=;
        b=KQSPrv0ScgoxucnIKI2nFvTEjAWTrauwY9BUfmgbFxCuFVePsWQeTPcaANyIWtWEUA
         pJcAvvb+bTio+1wp03++y4av5E2DHjozp5dgIxwgQvu6SBy1R0ma7lkwWz6ZThdOYNan
         ox9pIwtNklrqDppv+ELxABJswRl5YOiq9rAYm1hQaiNeogzLSGgPnYVe7QBISIJsB1PQ
         b5u1XcxeOXtaRqKxMJhnjmmNRfTxPUayGNpk/MY3DPAce9Pr9tLvIW3jCZJWLYtMjZET
         aoikBUqBqhGhhAaw310xz3IyUFSqp76RkhVhWy17X38Gk++VXwOEqbCIRkOM74O+9KWw
         zXIQ==
X-Gm-Message-State: AOAM530A/riY9vzWhicY6nqOi9SYImq6LIvDIxIUcYpU4mEHw2vcwC/h
        dGJH60JjTmjDFiicRCPamJnW3VmrQtVLoFwIC4W4vQ==
X-Google-Smtp-Source: ABdhPJzXg7xm29Aos/EHn5Jf+8tB/We803WYa9IGnjyQjf/IRAIeB8tYyykDooQTYtCQ2Q6q4QYIMrr+08nJk8aJ6tg=
X-Received: by 2002:ac2:5fca:: with SMTP id q10mr1025986lfg.235.1630530431911;
 Wed, 01 Sep 2021 14:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAG83euoGmVUUBh00wAEX1muZogNPOQUV6+ppL8x8qCaDnzTbDw@mail.gmail.com>
 <010f01d79525$f10a1f60$d31e5e20$@nexbridge.com> <CAG83euo2B4QFU_S6Yqd3UACWq63p=L+T30CwzT52D8H=S5pRVg@mail.gmail.com>
 <YR/tyHWQ6+2sP2iA@coredump.intra.peff.net> <CAG83euofNXHx8-=7Obj-Ju5U_fjwNBuLVJjmccVhe9bqRFyBiw@mail.gmail.com>
 <YR//IDB9ml5RO2H6@camp.crustytoothpaste.net> <01a101d795fc$ca46e520$5ed4af60$@nexbridge.com>
In-Reply-To: <01a101d795fc$ca46e520$5ed4af60$@nexbridge.com>
From:   Jonathon Anderson <janderson@acesquality.com>
Date:   Wed, 1 Sep 2021 16:07:00 -0500
Message-ID: <CAG83euoQW=HHN-cSJc3pOzsYUMEmJ0=9o2+zymm-z5e=b1SXjA@mail.gmail.com>
Subject: Re: Git Modifying DLL
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, I somehow didn't realize what this was when I was looking at it,
but this is the first line in our .gitattributes

* text eol=3Dlf

It all makes sense now.

And, yea, we're using git to retain dependency relationships and bring
those files under version control so we can audit changes and go
through the full peer review process, etc

On Fri, Aug 20, 2021 at 2:51 PM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> On August 20, 2021 3:15 PM, brian m. carlson wrote:
> >On 2021-08-20 at 18:47:02, Jonathon Anderson wrote:
> >> On Fri, Aug 20, 2021 at 1:00 PM Jeff King <peff@peff.net> wrote:
> >> >
> >> > On Thu, Aug 19, 2021 at 01:21:03PM -0500, Jonathon Anderson wrote:
> >> >
> >> > > I had not. I tested that and it worked. I assumed that git would
> >> > > automatically treat dll files as binary. Thanks for the help!
> >> >
> >> > Git doesn't know about any file extensions by default. Its default
> >> > "is it binary" test looks for NUL bytes in the first 8k or so of the=
 file.
> >> > I'd expect your DLL would probably have such a NUL byte.
> >> >
> >> > Is it possible you have other .gitattributes set which are confusing
> >> > things?
> >> >
> >> > You might try:
> >> >
> >> >   git check-attr --all <path>
> >> >
> >> > or:
> >> >
> >> >   git ls-files --stdin | git check-attr --stdin --all
> >> >
> >> > -Peff
> >>
> >> When I remove '*.dll binary" from .gitattributes, I get this:
> >>
> >> $ git check-attr --all ./PSWindowsUpdate.dll
> >> ./PSWindowsUpdate.dll: text: set
> >> ./PSWindowsUpdate.dll: eol: lf
> >
> >Yes, this is definitely not correct.  The flag "text" being set tells Gi=
t to do line-ending conversion and "eol=3Dlf" says to convert line endings
> >into LF.
> >
> >You should look for things in your .gitattributes file that say somethin=
g like "* text", which you probably don't want.  You could use
> >"* text=3Dauto", which should be fine for most cases, though.  It's also=
 possible those aren't in a .gitattributes file in your repository but one
> >elsewhere on your system.  You can check gitattributes(5) for the locati=
ons of other files that can affect it.
> >
> >As a note, it is best practice not to check binary dependencies or build=
 artifacts into the repo.  Those are best stored elsewhere, such as an
> >artifact server.
>
> OT: Unless you are using git as an artifact repository to retain the depe=
ndency relationship between objects and the source commits that built them =
for PCI and SWIFT compliance. git is exceptional when it comes to evidence-=
of-origin forensics of specific installation artifacts when release structu=
res are more complex than "deploy everything" use cases. But that may be a =
discussion we can have elsewhere.
>
> Just my $20.00.
> -Randall
>
