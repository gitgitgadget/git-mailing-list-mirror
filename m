Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A517C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 07:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548BC61244
	for <git@archiver.kernel.org>; Wed, 19 May 2021 07:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbhESHUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 03:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbhESHUq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 03:20:46 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA2C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 00:19:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id g38so16729685ybi.12
        for <git@vger.kernel.org>; Wed, 19 May 2021 00:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mqWATnP+NwpepCYZK1slt0OUuQTZuRcpQ0cn4YhvC5I=;
        b=NnkSUC2WgZuzoc2mOsR6C5fKyJo2MGum1QpaSdjk04A5QxckXJVQhxJ0At5011jcz3
         u4PHMoTo4LLsVJOoxJ0xgxKa3OGPl57Fv/7xcfdeITP9KO5vu5QJTSP0ghLLwSfhvY4z
         uEpzpEjr8jmzvwMza4y+zSuUZzYoHsezMYV50k3P/LeP9IhL8ssWBP5JZEqb4gbWKQo8
         cATLZMe/bY7HnE1cXgRqZvwFx6+sfeMcPylUAmBTwHM3pkeC51N/XUftcqXqT13Z5eFB
         CR0/bSej3Sf821+50ybr383L5humzz5t2KPL5zw6j1qsyZ4XNruxCxkIdx5AnfJSP3/5
         A5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mqWATnP+NwpepCYZK1slt0OUuQTZuRcpQ0cn4YhvC5I=;
        b=mTlOka3r3RlVnQ1bUCge62CRvd349RFxJl8/vEUCmtKh2bZoEgsZCsmrFTk1cGsW3c
         9nH1L9uVdglyhvPqu6H62fOopWsnCrkX0VQtrok8SPy8nj+Zfe7lcQYwPGiRcdt/3Djb
         dIngmdf7R/GJnpiwCG/hDBrqpfVG52atF1Xh4N8Fe9WDtdBiG8IC3ITkx9syrwpj9nOD
         TmFBf04bvlx2HGliqNWtaDK08PDLre9wRRL3KX4K+XLCmMRutrdJh2tWTi6Y8cmjp/zZ
         /cSKGDw6tx/gTgR+UrLgkNw8KA7PlyWwWl8AsYkZQ0ca07glq3/+h1xiPdVuIHkuneSl
         0nAg==
X-Gm-Message-State: AOAM533UeCWAT5NKYFVmjbGyfMaZWrAlkacTjbU/Ud1yqookIOSUlICz
        Ftc2Db90yKwCPkYOJrKbKyjtTw3zlZPFx9Jytj78a7KbvZE=
X-Google-Smtp-Source: ABdhPJy5bRzGTKGNnLo/Xhmt2I1B7g0QL9OgqeWuJUKvuFwBEXLN8fRm2yY1YMNAT6gH4XpLMDj6i7cLmB33Al0hQy4=
X-Received: by 2002:a25:ae12:: with SMTP id a18mr12567806ybj.155.1621408766193;
 Wed, 19 May 2021 00:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com>
In-Reply-To: <CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 19 May 2021 15:19:15 +0800
Message-ID: <CANYiYbGV1LO33piD+oMxjF83K6Nt=19Lk_8oBgzNCVcB=AokfA@mail.gmail.com>
Subject: Re: [GSoC] Hello Git
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello=EF=BC=8CGit!
>
> ### Self introduction
>
> I'm ZheNing Hu, I am very lucky to participate in the GSoC
> git project this year. Many people in the git community already
> have given me a lot of help in the past few months.
> Junio, Christian, Peff, Eric, Denton..., it's great to get along with
> you guys! Your review and guidance have greatly benefited
> my growth.

I admire you so much that you can join the open source community at a
very young age. I will continue to offer my help both online and
offline, in your favorite language (Chinese of course).

> In these days before GSoC, I learned some simple command
> implementation and data structures of git, learned strict coding
> standards and learned how to test, More importantly, I learned how
> to communicate with these kind-hearted reviewers.
>
> Of course, there are still many difficulties for me:
> * My poor English sometimes can=E2=80=99t express the meaning clearly.

There are too many differences between English and Chinese, but don't
worry. Remember, practice is perfect. You can also practice your
English by reviewing Git l10n in Chinese, see: "po/README.md".

> ### The connection between Git and the file system
>
> I am currently studying operating system course, git as a
> file system on top of the file system.
> There are many differences and similarities with ordinary
> file systems. I am very curious about this knowledge, do
> not know if there are any relevant reading materials?

Git objects are stored in ".git/objects" directory in two forms: loose
object and packfile.  These two types of files are deflated in zlib
format. In order to increase the speed of traversing these objects in
this object store, many meta files are created. For example, index
files and reverse index files for packfiles, bitmap file, commit-graph
files, etc.

Docs for these files:

 * Documentation/technical/pack-format.txt
 * Documentation/technical/index-format.txt
 * Documentation/technical/chunk-format.txt
 * Documentation/technical/multi-pack-index.txt
 * Documentation/technical/bitmap-format.txt
 * Documentation/technical/commit-graph-format.txt
 * Documentation/technical/commit-graph.txt

--
Jiang Xin
