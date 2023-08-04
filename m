Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030C3C001DB
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 02:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjHDC2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 22:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjHDC2k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 22:28:40 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB8CE46
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 19:28:37 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-583b3939521so19188057b3.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 19:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691116116; x=1691720916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhVJf0xU1WS/gEvI63Et8qPFDMNCIWP8RKOfxhblYlg=;
        b=bHbU7yyg3+eXllCD2QwsbzcfO5BtVQPeKdWRRdjN51GS6SINrBs4MkC5rHiWP7/9Vb
         0IQjXHvaM6X5WZdTnZaBwD4JGFdWDyrYYQYJczj3Tkl0XE3NitbESTqd2bdhflaC1kAG
         RSQCbQZqUJSA+MRV7FuplrTTKUl8gblrV7LPJ4f2/JXLQK7nTazOJ9KcatjxNm8lH/xw
         2uV1YMivuYuVFZIpjyy3zWrWJxHYUWljKcQbO6trNHsWjEQVVlX/FGnXj1ly/rNk3Txv
         HNpi9pHWg4PsDFNloHmnxC/qbYVPULZRUX82eCdOZennpvecFpV7UKgqzPgNYKfn2Cbu
         S69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691116116; x=1691720916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhVJf0xU1WS/gEvI63Et8qPFDMNCIWP8RKOfxhblYlg=;
        b=S5mJcuVz/i8t46Kc79snmM9byQlgio/51rGLkwdQXQXWdGaBb67Tz6iwaxxR8NBUki
         xZv9otUmyVF3IQoWJ90nnzO7siJmBg6M78HAiiRzR05BuCCrcssC4JKHJ5jleRA/vnB2
         Y/c25fIO4QzQNzsP2kN11DoXqcuuxX32Xjk7+41gOK57TYPX80qr8rlcNMj1pPPI3gte
         ovDNaRYg5BNnzLlXBqPhetbxeO53kSVWaUL+Uch9dc5UW9zmXfvpYw/T7FHC+oBIiq+7
         4xGg1cuK678dF5QgCYSck5HOr7rS/8tkKbLYcKHSpsghAH/ypOnAW77fkihPF2SZwETV
         0CQg==
X-Gm-Message-State: AOJu0YyLsomDe1dAF5EmNjpAaiWCsG1wRing6EaHqQwo05tqwGTVvh08
        tGqX5DS2ye0tZsyE8Zw/DlQXfXXnlEC6SYMuVqKtr5yNoaboJJTZ
X-Google-Smtp-Source: AGHT+IFqJH7M1wvNoTZquC+8vWC+ZAzfb9ePylD8ipdfr5m8zC50lXcBJY63a877mXzME29n4PCdfTEalnGaG0SMcUk=
X-Received: by 2002:a0d:dd89:0:b0:583:1bc7:8754 with SMTP id
 g131-20020a0ddd89000000b005831bc78754mr344338ywe.33.1691116116484; Thu, 03
 Aug 2023 19:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
 <xmqqo7k7c1yw.fsf@gitster.g> <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
 <xmqqila6cz0n.fsf@gitster.g> <ZMKtcaN7xYaTtkcI@nand.local>
 <CAOLTT8Ru+3efmUNMOwbhzwRu-FW-SVPYn88-xtrRQiRuweFG+Q@mail.gmail.com>
 <CAOLTT8S=_1Vd2Y4rBqq03JsJ1megRBcx9v-HYAWXe88jDek98Q@mail.gmail.com> <ZMvGsYSystLu6oBY@nand.local>
In-Reply-To: <ZMvGsYSystLu6oBY@nand.local>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 4 Aug 2023 10:28:25 +0800
Message-ID: <CAOLTT8Tc9NevyUfwiPscEH7BqShSscb=iZP4r+7mjsEwouLeXg@mail.gmail.com>
Subject: Re: [QUESTION] how to diff one blob with nothing
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=883=E6=97=A5=E5=
=91=A8=E5=9B=9B 23:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Aug 03, 2023 at 01:16:02PM +0800, ZheNing Hu wrote:
> > > Here, it is necessary to compare multiple versions of blobs while als=
o
> > > considering the situations of creation and deletion.
> > >
> > > Well, what I need is the "diff" content, with lines in the diff indic=
ating
> > > '+' or '-' signs. This can be achieved by manually adding them, but i=
t is
> > > not very compatible with the original logic.
> >
> > The native diff command itself supports comparison with an empty file.
> >
> > #diff -u  /dev/null a
> > --- /dev/null 2023-07-25 16:47:50.270094301 +0800
> > +++ a 2023-08-03 13:14:16.980262362 +0800
> > @@ -0,0 +1 @@
> > +a
> >
> > So I believe this feature would also be useful in git.
>
> Sure, you can easily diff any file against any other, including if
> either one or both are empty. I think the main difference here is that
> /dev/null exists on your system without additional configuration and
> the empty blob does not exist in a Git repository without additional
> configuration (in this case, `git hash-object -w -t blob --stdin
> </dev/null`).
>
> TBH, I don't know if /dev/null existing by default is necessarily a
> solid argument in favor of having Git repositories come initialized with
> the empty blob by default.
>
> (To be clear, when I say "initialized", I mean that a Git repository
> would recognize the empty blob object's hash for any value of
> `the_hash_algo`, not that every repository would be prepared with a
> loose object by default.)
>

Actually, there is no need to support a default empty blob.
For example, with the command "git diff --no-index <file> /dev/null",
it can compare a file with /dev/null, but it can only compare <file>
and not <oid>.
Therefore, using commands like "git diff <oid> /dev/null",
"git diff --no-index <oid> /dev/null", or even "git diff <oid> --stdin"
could potentially solve this issue.

Thanks,
ZheNing Hu
