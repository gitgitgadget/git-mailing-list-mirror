Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337BEC11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB2F61C9C
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhF2Be0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhF2Be0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:34:26 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAC8C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:31:59 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so20964312oti.2
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SkgQXjm4caCy9uH/FO1bt1L295uzFuSF4BtetUTLejU=;
        b=oiY5pgF1o8Fn9mmCck8C0cWasC3ldCC92o2NiTA0b71YpTK9jv+555f9IeheHi38po
         X9J0jEa5UUiPnUSIXM35XVYnH61AGPmnMChv9AEXK+mo3OwBu+Dhl5DWeIHqEXubBN5/
         B9EEGFjly/33OFH9KhIiBbDObEKPhHtVa9DVnuN4Aa7j5pliHECY/mAM5Ahal0ZaQy6v
         X1rUwVO2xrH1dDzsfkWIujAidpeT3Qf179oKhjX8d63yLx7ju6b7uYl4x37/eotPzk4/
         Yu9dwC9nyBi2G5r30o9GUIfBjAym3Y0hrJwqNqvGQdGTa/OEDfdAy4n4LDOT4YBLN3Cg
         2N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SkgQXjm4caCy9uH/FO1bt1L295uzFuSF4BtetUTLejU=;
        b=YNmJDaLojwKHyRkbcLuzAZvJGzKRrtseUOa27z82N7fKhnVYnM3RmKi53EE9QDaAJ6
         xJtCoYxNOD26OseiVvEWGAi380MsQREK6kg4kUcl1Kuw9tfc6+2sPBsrGAiTN3K2t9o3
         2Veb0GHxULC5YZGftusc6lCsS2wlV42vVXh702a2bjHlr36cUD9TdeDp41JZDqFPykVY
         NfHFAAMsfuvAsyI7wMUd1HI/M/VDiokprvMcR/fLB5aphes8XpgxWJtzgzOOdCRtZ2o8
         zWtmz0qUObBRDxHh+j3btAIXLlEO2YpHp+sDivj9iY4rZWg9H/YmO69eFPYyIYxrRsv2
         cQ3w==
X-Gm-Message-State: AOAM533bwPBA39fIW/TtW8YaX8TA38cArh9cEnE6TQhll12bR7Cx33ot
        Ctu0OuB2Ul8mDVgpz0YiESw=
X-Google-Smtp-Source: ABdhPJxmUNDVyXtdAmFN0wwFhu4F2lI1Si/0wodUwBhxoKuWc82LJzxNwkYfxuOZ6mU1hstWbJ3VCQ==
X-Received: by 2002:a9d:7c85:: with SMTP id q5mr2066642otn.347.1624930319014;
        Mon, 28 Jun 2021 18:31:59 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id j66sm64138oif.6.2021.06.28.18.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:31:58 -0700 (PDT)
Date:   Mon, 28 Jun 2021 20:31:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60da780cd6a78_2042720820@natae.notmuch>
In-Reply-To: <xmqqfsx162nu.fsf@gitster.g>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com>
 <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
 <87bl85y15s.fsf@evledraar.gmail.com>
 <YMvuprVu1MnokHM5@camp.crustytoothpaste.net>
 <xmqqr1gyjpyb.fsf@gitster.g>
 <xmqqfsx162nu.fsf@gitster.g>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> =

> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> >> I agree that in many cases we can effectively rephrase to avoid need=
ing
> >> to do this, but if we acknowledge that sometimes we will need to wri=
te
> >> using third-person personal pronouns in some cases, it's worth
> >> documenting what those should be.
> >
> > I think we've heard enough from both sides and there probably is not
> > misunderstanding among the folks, even though there are differences
> > of opinions.
> >
> > I would like to consider that the last draft I did [*1*] based on
> > earlier suggestions by Derrick and =C3=86var would be a reasonable mi=
ddle
> > ground.
> >
> > I'll go mostly offline next week---I'd notice if the list came up
> > with a vastly different concensus when I come back, but hopefully
> > not ;-)
> =

> Well, I misspoke.  If the list reached a consensus while I was away,
> then that would have been a happy outcome, whether it was close to,
> or vastly different from, the one I suggested.
> =

> In any case, I haven't even started to try catching up with the list
> traffic last week, so hopefully I'll see soon enough what you folks
> decided (or not).

I took "I think we've heard enough" as "don't discuss about this
anymore". And judging from the lack of responses from oher people I
think others did interpret it in a similar vein.

I still haven't seen a single argument as to why the fixes in the
wording have to be necessarily tied to an update in the guidelines, so I
don't see why would have changed my mind.

They are orthogonal.

-- =

Felipe Contreras=
