Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EB8C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 05:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDC260D07
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 05:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhGMFUr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Jul 2021 01:20:47 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:44981 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhGMFUr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 01:20:47 -0400
Received: by mail-ed1-f50.google.com with SMTP id l1so9636111edr.11
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 22:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Tjv/Cc2/HgnG6p2Vbiv5GNFVz/FsfVujCZe57u0zHg=;
        b=Jd+q1UO5VCjYeHLbCNIJbb+V6NPLfksVLNtR9tj/BU5Qge1njh+PL17y24TpJJHFYf
         rSU8UVQW0vklYRC296LLlusAEgO+gzBE5VAomOqhOICI1V0SacFIm+ic6HOoX3OOdalz
         xP84takNszsWm/HM8RZ3M32WtAtouvlDsE7DcrPhy0Gs2RsjYoeORzSEFuWKWNr/XLws
         UCCXDQJ4/YP5cifVb0ac+7hcDECKoW51GgJsot4US/4KfoRWlDMk5edZ+tVVdgHjEyy3
         ru6fVFuu6h/cnlH58v3fzAdwibmC+44kyedXK1bzC86GysMvcrbTQ8lwVb2O7VmjeoCJ
         a8xw==
X-Gm-Message-State: AOAM530TCv+thgL4kbes2yHKX1RIksiohlMbdp4GDXrBt+3bAC/7jA5X
        1wqupIpImAwDFXolbB+gYgDQDxb67kB2blpCZeo=
X-Google-Smtp-Source: ABdhPJw80XYTaEoRZr7/3SuXiVKFd/h7eq9PIqTu64dWVCLGJUAYvR50d2yxfH1GvdEImXa4l62h8t/pbtJfcyLd9Oc=
X-Received: by 2002:aa7:cb86:: with SMTP id r6mr3116064edt.181.1626153476737;
 Mon, 12 Jul 2021 22:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210612165043.165579-1-lenaic@lhuard.fr> <20210702142556.99864-1-lenaic@lhuard.fr>
 <20210702142556.99864-3-lenaic@lhuard.fr> <87h7h75hzz.fsf@evledraar.gmail.com>
 <xmqq5yxni2rn.fsf@gitster.g> <YOzbO1/mfL8hKhBT@coredump.intra.peff.net>
 <CAPig+cT-x4_YuxmmoFw62jFqKRFJrS_UkyNOkdQz9-Gwec3QCQ@mail.gmail.com> <YO0O9JHtnYrk9qRm@coredump.intra.peff.net>
In-Reply-To: <YO0O9JHtnYrk9qRm@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 13 Jul 2021 01:17:45 -0400
Message-ID: <CAPig+cQFHw3qGdFLPuu6zq8zQy2h25Nkk6T1u0gBTQd-LCXt1w@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 11:56 PM Jeff King <peff@peff.net> wrote:
> On Mon, Jul 12, 2021 at 10:22:22PM -0400, Eric Sunshine wrote:
> > On Mon, Jul 12, 2021 at 8:16 PM Jeff King <peff@peff.net> wrote:
> > > And indeed, Lénaïc's patches use it elsewhere. I think it doesn't work
> > > in this instance because it can't take an arbitrary delimiter. But I
> > > wouldn't at all mind seeing it grow that feature (and I suspect it could
> > > even share some code with string_list_split(), but didn't look).
> >
> > Since Lénaïc is a relative newcomer to the project, can we, as
> > reviewers, be clear that we don't expect him to perform the task of
> > generalizing strvec_split() just to get this series -- which is
> > already at v7 -- landed?
>
> Yeah, sorry if I was unclear on that. That is absolutely not a
> requirement for this series.

Thanks, and sorry if my response seemed to be aimed only at your
reply. It wasn't. It was a reaction to a number of recent reviews --
in general -- containing only subjective comments or a mix of
subjective comments and genuine actionable items without necessarily
making it clear which is which. Such ambiguity is hard on newcomers,
who may end up doing unnecessary work trying to get their patches
accepted, or might scare them away altogether.
