Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBCDC433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 02:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553E764E7A
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 02:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhCNCiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 21:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCNChw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 21:37:52 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F0DC061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 18:37:52 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 101-20020a9d04ee0000b02901b506659320so3448436otm.7
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 18:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c1g3KVqAws5pjcqlDI21L5u3pitX+vIoOvLeJwJEMH0=;
        b=moQWBllifyzp+QAlqY3GICtHEILutu9KZXf0T45m/hF+5/3dIWRKrit/xm0ucphDe+
         qF9h8Uzif1hAHxgtrubtCXILl8KYNq05h//SbvG0ZHqF9AbqrEDfl/QL+8o0gwvMB65D
         cYcw31V6o3falFcbuKbQWn1n6qVzs9rKhWWAbIn1YT39ekx0aRF0YYhSd6bnCUOxseZJ
         mnD65210M5bEfCCKf7luqoJ2pxKzBpVHaRXqkuO7+JeBGzmh8bLJBizhXfYXoS2yjjLr
         MPblZc8mhgmieeMT1R3O52ZUn6ENttb+OMeIZsA2e+uEWB6WtyekDFHMv4bD97G7oRER
         hoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c1g3KVqAws5pjcqlDI21L5u3pitX+vIoOvLeJwJEMH0=;
        b=p6zBOb2gcWttMYBAsQgKDVit+sMa20KZeqlZ87F9qzB3/mUvaZ9yfRxl609fSn8pOr
         hGUFrE+aLuxt3ozBzy98iMSccuOhWDgMEElk3ad+lJ2eP7ZgtbMoW3kmB+e0JI4KU3Fc
         vCLruC3VpbY64oNkl1+SfqPeqbWbem/pFn8x/ejBg2VBspd/dHiUJZi+0D1wKAV427g+
         gtXqECIvj5NX9Nfe2nAdhpddGViqkMqezg+DrUSTsSWgFiNKPN/5unthMrFoxRtT9COe
         a0pV7b5HMgGGA2Qr+2IsDWpNXOUIJbGFK+xcFVkCQpJsHLHHXCrwDKh9WCMGYNxraxZu
         Y8iw==
X-Gm-Message-State: AOAM531o9FAClGR6yySWAEtExtrkOV9ukPAeVMLTnLa6AT69YEtBvX68
        dS9IeRxUjzs/Uxrc3f/0K8wKehtG89QCbZqfT1s=
X-Google-Smtp-Source: ABdhPJzPdx/iHGBaISSXSvvrDTMVZzKgoqUJDgZaTA0c4xHYsqsVe/rISLxnd4iBE/tomnlHPB9nBLFbEvT28lD6ZfM=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr1702109otq.160.1615689471556;
 Sat, 13 Mar 2021 18:37:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com>
 <pull.898.v3.git.1615285726482.gitgitgadget@gmail.com> <xmqqpn0456lr.fsf@gitster.g>
 <CAOLTT8QhgeGim6ujqqyXwQ=bmQtJ43T5i3CPmNMPmBr0amR-HQ@mail.gmail.com>
 <xmqqwnua4ozy.fsf@gitster.g> <CAOLTT8TT6rKdF-quS-t3X31PfQcrHPom4Rk5LcrMUBKha78MGg@mail.gmail.com>
In-Reply-To: <CAOLTT8TT6rKdF-quS-t3X31PfQcrHPom4Rk5LcrMUBKha78MGg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 14 Mar 2021 10:37:40 +0800
Message-ID: <CAOLTT8RS_FDGEJZ-ogfMf-QJAUEkycju3757uTcQ+Tczub+gqQ@mail.gmail.com>
Subject: Re: [PATCH v3] [GSOC][RFC] format-patch: pass --left-only to range-diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Taylor Blau <ttaylorr@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8814=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8810:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8814=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=887:23=E5=86=99=E9=81=93=EF=BC=9A
>
> >
> > Yes, it would be, but that is why you need to educate users what
> > causes it, and what the right way to avoid unrelated commits from
> > appearing, and how this --left-only fits in the solution.
> >
> > If some of the time, "--left-only T1...T2" would give you the same
> > result as the more strict "B1..T1 B2..T2", that may be why users may
> > want to use the "--left-only" instead as an easy/lazy alternative.
> >
> > But I suspect that it would give an incorrect result some of the
> > time---for example, in the above example, wouldn't one of the
> > commits labeled as 's' be completely hidden?  And if that is the
> > case, the end-user documentation would need to warn about it, and
> > explain that it is a easy/lazy alternative that can produce
> > incorrect result in the log message.
>
> Thanks, I will try to illustrate these issues in the document.
>
> My another thinking is:
> Since `--left-only` inhibits "B1..B2" and "B2..T2" ( let the user
> choose the left B1..T1 ), To some extent, `--right-only` can also
> add ( let the user choose the right B2..T2 ). A separate `--left-only`
> will be strange to the user ( If user call T2...T1 ). Since the
> `git rebase --apply` will internal call `git format-patch -k --stdout
> --full-index --cherry-pick --right-only ...`, I don't know what to deal
> with this `--right-only` yet, because I don't how to teach git to judge
> if the `--right-only` is pass from user or `git rebase --apply`, Is there
> any good way?  If can solve this problem,  the user can choose the left
> or right side of the free choice. (Or users don't need `--right-only?`)

Let me refute my own point just now :`--right-only` can not show "B2..T2",
but "B1..T1", and it may be useful only when user want an inverted "T2...T1=
".
