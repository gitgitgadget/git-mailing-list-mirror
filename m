Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA66C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 02:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4D620708
	for <git@archiver.kernel.org>; Tue, 19 May 2020 02:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="KhD8obdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgESCXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 22:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgESCXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 22:23:11 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D47C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 19:23:09 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w4so7142399oia.1
        for <git@vger.kernel.org>; Mon, 18 May 2020 19:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W+QHT3TxepUv9A15vVzl4nj6yoXepbmYam0Q1kZes5M=;
        b=KhD8obdJR5RZ2kTLTzQ+4PeYDvvsgLkHvur2nPA9IVNLnyyBtgF5uyOsiVTJK7ex20
         duBkjQdOHxmojzC2q/MHVz7hbBFKwbrZMXllo1aH/yRTaCX8nZWXxttQlclj2xNqWqDC
         dkTXR9iDBN+XsZKKLT3tn7qQSfmi30FKAe/LzWrJICTSjsBTfXU5m1OwwiYnoUr6F/T5
         ORMOpsboWpNqzuT+4vOl+vC+LMTcXSKn+Fp9DKptLrrqzIOHsfenJ6Wuwkta9EUHRaic
         vNApIo9GzuN6cuQhkVBGEaGbWKeVRAyjTw2+V1UKhn/mlX+BHxFovjuef0/nlkdfhs1m
         iWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W+QHT3TxepUv9A15vVzl4nj6yoXepbmYam0Q1kZes5M=;
        b=loxg6ClSYBiiKu12gpjJG2gzqP7KvwvUgi4XWrxTzkN5Qf8V/OYcZVaVKNlaG2jcWm
         yWVbQPMKSOd5RsXBIlMYe4YYzGuNLbM6Nyu82AWnpWQrYppjE31Cd8pR3mU3MT0KTNq6
         dCUbglTtEGmWrKsyrAsuzw0E0cWETamK5ivtU3HyIb1Vu7iXSwkY4jOwFIZW8ErvlJGg
         gdozHfDF0/ZcFXSeo67bGaUjHgS0pEHMZes8AXTxF8K/GlVU0HdiqOsYM77+HmGsXtfV
         eB6/p9FwWAda7fzCGAEO2ojdJyDr5ZE8Pa5B1YVEdEKnNWyHz602eVnBAJr8g+bPRA7r
         xRRw==
X-Gm-Message-State: AOAM530ALq1OSSYvgBfVJpY0vAbS02MRRYEXZ3C/vvlXVHtjJ3nZlihQ
        /78AY2cjpiL5fV8ryPu52zVlnjEt1sk5KmPKGbPHYw==
X-Google-Smtp-Source: ABdhPJyYOn/hOTOU74EulltYkwNhKDpyXVtf2EyV6sxi4tajPaXhoWQB1AudhASJzVEvphxg+wE0Q2uKl7TUIW+nH/8=
X-Received: by 2002:a54:4199:: with SMTP id 25mr1736108oiy.58.1589854988839;
 Mon, 18 May 2020 19:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200518100356.29292-1-dtucker@dtucker.net> <20200518141311.GC1980@danh.dev>
 <CALDDTe13_utn7E+QF1AgndX_6nPph=Gr1hesLwfV8e9LwgUPOQ@mail.gmail.com>
 <20200518153025.GD1980@danh.dev> <CALDDTe0BvyXYz39n0EqGnJgdfHMziwW7V5xQO_H=+OKm20jfFA@mail.gmail.com>
 <20200519005645.GD1999@danh.dev>
In-Reply-To: <20200519005645.GD1999@danh.dev>
From:   Darren Tucker <dtucker@dtucker.net>
Date:   Tue, 19 May 2020 12:22:57 +1000
Message-ID: <CALDDTe1k7Fsb9p+4TEd3GSG_bOucrxSKmENsjACwga8L7LvLXg@mail.gmail.com>
Subject: Re: [PATCH] t5703: replace "grep -a" usage by perl
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 May 2020 at 10:56, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <c=
ongdanhqx@gmail.com> wrote:
> On 2020-05-19 09:22:01+1000, Darren Tucker <dtucker@dtucker.net> wrote:
> > On Tue, 19 May 2020 at 01:30, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Dan=
h <congdanhqx@gmail.com> wrote:
> > [...]
> > > > printf: \3: invalid escape
> > >
> > > Look like HP-UX's printf doesn't understand octal escape.
> >
> > The HP-UX one is actually OK with that.  The error is from an old gnu
> > coreutils (2.0), and it's complaining because there no leading zero,
> > which POSIX says octal escapes have:
> > https://pubs.opengroup.org/onlinepubs/9699919799/utilities/printf.html

I've replaced the printf in question.  You could add leading zeroes in
case anything else strictly conforms to POSIX but it looks like
there's quite a lot of them.

> I think it's better to use HP-UX native tools for the test.
> Can you check with this patch applied on top of your tree.
[...]
> On some platforms likes HP-UX, grep(1) doesn't understand "-a".

nit: "like HP-UX"

Yep that works:

$ PATH=3D/usr/local/bin:$PATH ./t5703-upload-pack-ref-in-want.sh
ok 1 - setup repository
ok 2 - config controls ref-in-want advertisement
ok 3 - invalid want-ref line
ok 4 - basic want-ref
ok 5 - multiple want-ref lines
ok 6 - mix want and want-ref
ok 7 - want-ref with ref we already have commit for
ok 8 - setup repos for fetching with ref-in-want tests
ok 9 - fetching with exact OID
ok 10 - fetching multiple refs
ok 11 - fetching ref and exact OID
ok 12 - fetching with wildcard that does not match any refs
ok 13 - fetching with wildcard that matches multiple refs
# passed all 13 test(s)
# SKIP skipping test, git built without http support
1..13

Thanks.

--=20
Darren Tucker (dtucker at dtucker.net)
GPG key 11EAA6FA / A86E 3E07 5B19 5880 E860  37F4 9357 ECEF 11EA A6FA (new)
    Good judgement comes with experience. Unfortunately, the experience
usually comes from bad judgement.
