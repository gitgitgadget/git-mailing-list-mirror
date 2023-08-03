Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B3BC001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 05:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjHCFRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 01:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjHCFRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 01:17:05 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607FB3A87
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 22:16:14 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-583f65806f8so5380167b3.0
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 22:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691039773; x=1691644573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IihN7bf4OYezj+I5FR20rWbYu2eQMd7H+b2wIlCEL2w=;
        b=cg44t7uorF/dyPhWxH9OwnbG8K7erbPmtDLJ16+sdpf/pn/dQIDJ++4yKjj0bZyrGG
         NE7OOFRgBDHIFaoanjcf3SbmsQrRer9MrQ3rNbVZ5CsD6aYvTiUVHlwJ3LRnHwVmC5E6
         +XDjtAOIin5jp5dRW/LsriF8885iOBkdAD0d40J0aBV7/ANEkWEQDqEInnA8mqkbxlir
         GNpqZwSqOvCU6rbBUhMIZ4d5ThEbBdBAH2vX79BzfZuIBvtQX6280vr05DNNJLoV1D9N
         0EbyAWMldUxGws8isXJS9K1HxHnAlWRE8N0/vicASEqd8/C1Ozr3/mPGgZekOtECIsi5
         tGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691039773; x=1691644573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IihN7bf4OYezj+I5FR20rWbYu2eQMd7H+b2wIlCEL2w=;
        b=QPNA5tiq+IbeVBMhvX1uuQtzTc7ZZtYgXoHbEBO9wDZcpSKdD7lCcbRhSuZov2Y3uN
         jDQ+Qvziy3HO54oLKi/MBg1tmjEOzz5qEWOe5iIFvC1RZfpLFrt94GWRjd9OoyyH3Boa
         1TooRTDyDrCdV3QTtfCpl+sA9wPMVR2pz29TUmX0oV6byfVC7YC2ftDZ50vXOvFeqEAb
         lXSOzB/a+ABsxOM7hZatSSE7PhHyaJIq9gZ+zQYg+pByt08a7uZt0AmYGzm+pYNoPcm+
         V3XfkPssxPzvBqJuJLK4PY9dujGvOLEuY+9aSm0LpUu5/Ekg8C6tP4xsm9UulOWxFd/P
         5Uxg==
X-Gm-Message-State: ABy/qLZAscv/lTGp2FT6rrZ86xzc2XV+UFCi9fxIVZyr0Tk2kv/jnqdE
        SJwA6ogrYicjnX/83FKwEMWhyQEEwV4KAQNpjfzNutJfUNaBykUt
X-Google-Smtp-Source: APBJJlEkwBz33Sg0jna7byKQNsmuU2YLgCqJshrZw1zUHLCxIK02DDTem7Lv9W2xCz2Z+3i9h+wCLGGhpAapD6/tEN8=
X-Received: by 2002:a0d:e891:0:b0:583:5a34:cfd with SMTP id
 r139-20020a0de891000000b005835a340cfdmr19140878ywe.2.1691039773441; Wed, 02
 Aug 2023 22:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
 <xmqqo7k7c1yw.fsf@gitster.g> <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
 <xmqqila6cz0n.fsf@gitster.g> <ZMKtcaN7xYaTtkcI@nand.local> <CAOLTT8Ru+3efmUNMOwbhzwRu-FW-SVPYn88-xtrRQiRuweFG+Q@mail.gmail.com>
In-Reply-To: <CAOLTT8Ru+3efmUNMOwbhzwRu-FW-SVPYn88-xtrRQiRuweFG+Q@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 3 Aug 2023 13:16:02 +0800
Message-ID: <CAOLTT8S=_1Vd2Y4rBqq03JsJ1megRBcx9v-HYAWXe88jDek98Q@mail.gmail.com>
Subject: Re: [QUESTION] how to diff one blob with nothing
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 11:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Taylor Blau <me@ttaylorr.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8828=E6=97=A5=
=E5=91=A8=E4=BA=94 01:46=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Jul 26, 2023 at 11:23:52AM -0700, Junio C Hamano wrote:
> > > ZheNing Hu <adlternative@gmail.com> writes:
> > >
> > > >> If you haven't created one, of course it would fail.  It should he=
lp
> > > >> to do
> > > >>
> > > >>     $ git hash-object -w --stdin </dev/null
> > > >>
> > > >> before running
> > > >>
> > > >>     $ git diff 00750edc e69de29bb
> > > >>
> > > >
> > > > This is a viable solution, but it's a bit ugly since a read-only "d=
iff"
> > > > requires =E2=80=9Dwrite=E2=80=9C an empty blob.
> > >
> > > If you do not even have an empty blob, you have no business
> > > comparing some other blobs you have with it, do you?
> > >
> > > If you do not have a file with a single line "hello, world\n" (that
> > > hashes to 4b5fa63702dd96796042e92787f464e28f09f17d if written in a
> > > blob), then you cannot do "git diff 4b5fa637" with anything and
> > > expect it to work.  It is the same thing.
> > >
> > > Besides, if you _know_ you want to compare a blob X to emptyness,
> > > you are better of doing "git cat-file blob X" in the first place.
> >
> > Yeah, exactly. In 346245a1bb6 (hard-code the empty tree object,
> > 2008-02-13), the rationale was partly that having the empty tree object
> > is useful for showing some diffs, such as for the initial commit.
> >
> > But I can't think of a similar argument for the empty blob. Like Junio
> > said, if you're purposefully diff-ing against the empty blob, wouldn't
> > you simply want the entire contents anyway? If that's the case, cat-fil=
e
> > seems like a much more appropriate tool.
> >
>
> Here, it is necessary to compare multiple versions of blobs while also
> considering the situations of creation and deletion.
>
> Well, what I need is the "diff" content, with lines in the diff indicatin=
g
> '+' or '-' signs. This can be achieved by manually adding them, but it is
> not very compatible with the original logic.
>

The native diff command itself supports comparison with an empty file.

#diff -u  /dev/null a
--- /dev/null 2023-07-25 16:47:50.270094301 +0800
+++ a 2023-08-03 13:14:16.980262362 +0800
@@ -0,0 +1 @@
+a

So I believe this feature would also be useful in git.

> > Thanks,
> > Taylor
