Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2A0C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 18:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F574613C6
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 18:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhFKSZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 14:25:57 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:34639 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhFKSZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 14:25:56 -0400
Received: by mail-lf1-f51.google.com with SMTP id f30so9885295lfj.1
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sh11ZN6dMfK/LnAV1HBitl4te06krx0mCXfY0v72l0A=;
        b=bSpbSw72+o0ZteasXAv5se9haSUz0DCTxge+I2xs0Nk/xE9+xImfLMAtPGAj+vVC9t
         +dD/B+lHvxLKh/AShZSV3QI4dntgpLg5AUELt3651M4Wj7hWmrHpkzLSqkD+yBtNwqcI
         BBrZpKSL1Aq4YdjOa64xlPNA6ZLngmyrXykD2uVjfHvr+c1edJCz0J7WodDwtNsQpLre
         AWjqGiCo5Fk917jpIOU4tsNjcNs2C8ccvPEEjLj3D0/WYxR5tsLnAXrMYxiPOrQ7JCEd
         Qm1ANY/h0vaVmXCH3u2oeTvg/xX672K9h9+CiXs96CL3HhbFz35QsQHWejTDVhIESUnS
         TQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Sh11ZN6dMfK/LnAV1HBitl4te06krx0mCXfY0v72l0A=;
        b=gd/FaBkOUhdduUmK3kmqxn6Py44KszcZz/mgDyxzj07DyjDUo+eAB7WaxYoIamlj9D
         o2sxd+WQ3DCp1SVIARBG+OA5/LMyAi92/J8qp1ajp8auu/KLgI6DZJzAnpXxZ2nJeOTn
         WnTuSagoeaAnNT2+o52ChOya3cf7vFBou8PR+s+dbDsminybzVJPSZ4ggsHqfMx0YKTo
         IIQEnSYw/+4W0SUh+U/T4fxsYI54bQUr54zSoQSeLwJ2C7HxgHdRd6QvlI1NGNlvnDv6
         EmXxSs4KcR058bd/xlAH0J8QiIYmuthPJPdGMKdtfRLO3F3GNkOsSrccgaFtqe+LANAN
         WqFg==
X-Gm-Message-State: AOAM531kI0I1yAeEk9+f0aPCswpWxoWTuiDrSuEFL4Row1dWvkMo8DUK
        rP9eXxOYKt2GYdBNU+jWzd10wCp7qIE=
X-Google-Smtp-Source: ABdhPJydj/AfCzOh6+Jj+VDKGN9zKMd0ml9CJZ95FHQK8bZu2FW6K9cSfPGsqNGacqUcVTXTJXzY3Q==
X-Received: by 2002:ac2:5396:: with SMTP id g22mr3438138lfh.84.1623435761381;
        Fri, 11 Jun 2021 11:22:41 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l16sm653426lfe.263.2021.06.11.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:22:40 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
        <20210609192842.696646-8-felipe.contreras@gmail.com>
        <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
        <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
        <xmqqh7i5ci3t.fsf@gitster.g>
        <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
        <xmqqy2bg3nqw.fsf@gitster.g>
        <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
        <xmqqo8cc3maq.fsf@gitster.g> <875yykipq2.fsf@osv.gnss.ru>
        <dd5a1b6c-f0d3-f135-d03d-5d1f9205503d@kdbg.org>
        <60c39bb3b5cc4_8d0f20817@natae.notmuch> <87bl8ce1ug.fsf@osv.gnss.ru>
        <60c3a7058af24_8d0f20833@natae.notmuch>
Date:   Fri, 11 Jun 2021 21:22:39 +0300
In-Reply-To: <60c3a7058af24_8d0f20833@natae.notmuch> (Felipe Contreras's
        message of "Fri, 11 Jun 2021 13:10:13 -0500")
Message-ID: <87fsxob6s0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Johannes Sixt wrote:
>> >> then diff3 must display the conflict as
>> >> 
>> >>  12<ABC|34=AXC>56
>> >> 
>> >> to be technically correct. RCS style can coalesce A and C outside of the
>> >> conflict and display it as
>> >> 
>> >>  12A<B=X>C34
>> >> 
>> >> and *that* is the helpful part of this simpler style.
>> >
>> > I have trouble translating the above to what I'm familiar with in my
>> > mind, so...
>> >
>> > diff2:
>> >
>> >   1
>> >   2
>> >   A
>> >   <<<<<<< l
>> >   B
>> >   =======
>> >   X
>> >   >>>>>>> r
>> >   C
>> >   5
>> >   6
>> >
>> > diff3:
>> >
>> >   1
>> >   2
>> >   <<<<<<< l
>> >   A
>> >   B
>> >   C
>> >   ||||||| b
>> >   3
>> >   4
>> >   =======
>> >   A
>> >   X
>> >   C
>> >   >>>>>>> r
>> >   5
>> >   6
>> >
>> > I personally don't mind at all having a few extra lines in order to
>> > visualize what actually happened.
>> 
>> Plus a good tool should have an option to quickly show a diff between any
>> 2 of 3 parts, making analysis even simpler.
>
> Indeed, it depends on the mergetool, but personally I use vimdiff3
> (which I authored). All I need are diff3 conflict markers plus some
> colors.

Emacs's smerge-mode works fine too. In fact that was what made me switch
to diff3 in git config.

Thanks,
-- Sergey Organov
