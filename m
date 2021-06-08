Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02438C4743D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED0061370
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhFHRvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:51:19 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43819 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhFHRvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 13:51:16 -0400
Received: by mail-ot1-f43.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso21118744otu.10
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=V/0lmrM9zxYij6tBvLXwhnSLhkOJ5Qxw9CpfJ5Wi/Xs=;
        b=OGTLhcwa0G7l3uegRLuNECd7ed6iLlvKyPxc+I7Jn/k7pgulU4EYYuwRbKERGLuRl+
         MhZViGY8bm2tbxAPoF45521GYFTUJ+xXZdUFHVitr08Vl1gpHQWN5RuFp6JtcputL9la
         FvcIkiqN+9uFMnTgybhXlRoM3G3erIlDCXl0w4j3LHKN5BKBRnmzM/oMiuYjrqbXlSNr
         Vs/PQmReLEq9FYkxQmPQHkEW0tWwg4eX41wcPBsEHBMBFrcAxgg98erKEYHFj/xB9mCq
         FizuPl5xKs+MrhD+MtEfprujEI85Qch86nLn3AfRfQkS5jPMMfqD6tk4OkT1NH2eQkZZ
         vnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=V/0lmrM9zxYij6tBvLXwhnSLhkOJ5Qxw9CpfJ5Wi/Xs=;
        b=t3bWRfGNJreRsVe7LEFV2t2UC9YLAUT4Pm1VS5PDCnPMiEOVHWExwycO7ELVv8E7RE
         gdpO049YU707XaOBmNI0011ngHRaz/Zh9fP52KfuNeZPfMTPMOvYYvFvUDYJr3JiHV7z
         rngF8+fcBUCbGIjwS2ZZjAx6Us5K1FoHhjfMwBnq4zXQE3CGD1Ww1lbsObhvn9faMPxr
         1U7dTwOwdgLKQ4dhII3hD9DuPTEop/zQRVKrEwsh1qDAiYdOVAzb/UlTwiT/vIwD/JzO
         0ck3M+Cuzyqmm37i5lJuxDuzzL192n3Xu2OAxfct/NvdTAaXeAVepJ5HRHCDgP8lV3sO
         uLtw==
X-Gm-Message-State: AOAM533hqcBvWnA2ubMIFFQemn+cvDpZ2B8m+zPlJaPi2u0j2wEWqRfq
        TyGcL/aFCGzTJBCqrxsJtco=
X-Google-Smtp-Source: ABdhPJwbeaP7oBwKv7XgnsFtzNgggHyHEx+H9aR7h8EEAg+i3Yf0LRtXd1fcMtkby+LYgg5U54hksA==
X-Received: by 2002:a9d:39e3:: with SMTP id y90mr19788837otb.257.1623174497085;
        Tue, 08 Jun 2021 10:48:17 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id k14sm2933482ooi.21.2021.06.08.10.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:48:16 -0700 (PDT)
Date:   Tue, 08 Jun 2021 12:48:15 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>
Message-ID: <60bfad5f170df_1abb47208c1@natae.notmuch>
In-Reply-To: <xmqq4ke8pig9.fsf@gitster.g>
References: <20210523054454.1188757-1-felipe.contreras@gmail.com>
 <87o8cg34t8.fsf@evledraar.gmail.com>
 <xmqq4ke8pig9.fsf@gitster.g>
Subject: Re: [PATCH v6] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> =

> > I've been running with this on my personal git build since May 26th. =
I
> > haven't had any issues with it, and I like the new coloring.
> > ...
> > I think this is a good example of a change that we're better off just=

> > merging down and then reverting if the wider audience of git users ha=
tes
> > it, rather than trying to come to some perfect consensus here
> > on-list.
> =

> My impression was tht we already had a rough consensus here on-list
> that it may be good to educate users who like this "new coloring"
> like you do to configure their "less",

Not true.

Jeff said users would probably have configured man to use colors
themselves, but he never responded back when I asked him *how* [1].

It is a tricky question, because I already know it's not possible to do
it in a way that works in all distributions, for all programs without
polluting the user environment to do things she probably doesn't want.

> so that they consistently get the "new coloring" they like whether
> they are doing "git help git", "man git", or even "man ls", and the
> approach the posted patch takes will not help (it only affects "git
> help git" among these).

Please explain exactly *how* the user will be able to do that.


Moreover. I don't think git should be in the business of educating users
how to use other software. The way they use less in conjunction with
other software is up to them.

And in fact we already help naive users that have not configured their
pager, so that it works better in git.

We do this for them:

  LESS=3DFRX LV=3D-c # see PAGER_ENV

Why aren't we "educating them" about LESS=3DFRX instead?

We have set good defaults for less since pretty much the start:

  f67b45f862 (Introduce trivial new pager.c helper infrastructure, 2006-0=
2-28)


I don't think Jeff is the consensus. He expressed an opinion that
perhaps X is better, but without clearly defining X, that's not really
a viable option.

> I'd rather not to take it.

Can you explain why? All the outstanding comments have been addressed.

Cheers.

[1] https://lore.kernel.org/git/60a96e76a4b20_857e92085c@natae.notmuch/

-- =

Felipe Contreras=
