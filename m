Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C72C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CDBF613F2
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhFQP1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhFQP1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 11:27:25 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB21C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 08:25:16 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so6519058oti.2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=riYfS9eWi75254rqn9QfkmsL6uNB9/UL5Ji21tEFTZk=;
        b=FqCVsDgaQ/LwHsx8vucaO62F/llGoquKjbx+kewCxE/5tQIcDgOceNpBEEWYUwYxyz
         ZT8s2dIOUnQccO3dVJAU8Dbgl8Pj2gTy26vTXLRyDf67E51RsQFvW3n1DXmJj1nVBbrN
         3YWwmtl5LEReXzBxUiz7kbGxJtwNl0P81wAzqt1z00DnZXWWXEAIp94BuVCYPohkVPep
         mUNSDkWcrolxjjG8ct3t5kczW/bE1w/mTHGQt8P4FTnuvUwXs4MZvm+ydCsPQRcq68BL
         iGDtdx0b2FQI9h0zepLLi8jFpgOU3QGVp5iopMa7My0iI3unxtbLwub0P+4NlEnlP4vD
         IjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=riYfS9eWi75254rqn9QfkmsL6uNB9/UL5Ji21tEFTZk=;
        b=ny58sXQd5b2hQ7/t31jztYzmEZvkklwEPUSA63E4AhJbIPuy0+K2RLG5KMdtR+vmoq
         MKTmbxLquddmX16dUmnHstDGPiZBafSEd052nog3syczmBNJ/xhyKZtCwtxlWMPSg0A1
         ecvCWGCXbGXOjX/zOWra4aOiDvWKPYu3xpOVfzN+3G8K+D0HFfvxtbylJPAIbzQcBANv
         JJKvid92VW7pjPEvAUGi8vRTzzkszXD9bOvIL/WeiPnkz+qUOrvhmdsbkztpXymj8w+V
         PpiQmdPW1UTUQyQ8Gool8/Q7YwWJoI1FB1LmjoNOhUxyyzyDL7IUaskLf0ZcFQcGMrOd
         PZFQ==
X-Gm-Message-State: AOAM5336C2690lZMCTu7MLNBrATQS/EokD88aTHnHZAaQVw1DWC9xQY5
        w61VVcavcHoR0PXeWg3oYsM=
X-Google-Smtp-Source: ABdhPJw6Pykt6D7XLFSNAoLodFPzyzGV1E6+iwsOuQZA0dkPVI3wAnDDt4L8kV23xmSdTmI2EmS0rg==
X-Received: by 2002:a9d:6d0e:: with SMTP id o14mr5121897otp.90.1623943515741;
        Thu, 17 Jun 2021 08:25:15 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id i15sm1368666ots.39.2021.06.17.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:25:15 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:25:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60cb6954deab4_1305720874@natae.notmuch>
In-Reply-To: <5755690e-ef13-e12c-4b10-9cb303ae843a@gmail.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com>
 <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
 <87bl85y15s.fsf@evledraar.gmail.com>
 <xmqqtulxnyhb.fsf@gitster.g>
 <5755690e-ef13-e12c-4b10-9cb303ae843a@gmail.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 6/16/2021 8:09 PM, Junio C Hamano wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> ...
> >> The references to "gendered prounouns" etc. are gone, perhaps there'=
s a
> >> good reason to re-include them, but the point of "isn't that issue
> >> solved by recommending an orthagonal approach?" is one of the many
> >> things Stolee hasn't been addressing in the threads related to this
> >> series.
> >>
> >> To me that whole approach is somewhere between a solution in search =
of a
> >> problem and a "let's fix it and move on". Not something we need
> >> explicitly carry in our CodingGuidelines forever.
> > =

> > This I think is the crux of the differences between you two.  I'd
> > love to hear Derrick's response and eventually see a middle ground
> > reached.
> =

> I disagree that removing gendered pronouns and updating the
> guidelines are orthogonal.

We already know that. We are waiting for an *explanation*.

Why?

-- =

Felipe Contreras=
