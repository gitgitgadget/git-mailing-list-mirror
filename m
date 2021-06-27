Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB3C48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 17:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3FA6197D
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 17:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhF0Rd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 13:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhF0Rdz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 13:33:55 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F9BC061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 10:31:31 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso15898301otu.10
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=CjJXaU0LySw7qLjpaKdrRsofIRN/pf9mFsuU8VENvDE=;
        b=FVLu4EkRc8ELiJ1Ic0fZ+wr8gZfw3/WxMu7U7POlPNK3MXAadYRd9qxDLeeIJQdT4t
         VFsXn3DcmTQQ2Jg9PF+HEjifM/6mQN3375478ZOL+ZzeXCSp8vkN8OfOO6egFg2xzfPk
         UFqJVOFk09NTuoXSJMu5SQIZg+ewz+CsBguns2eqzN4S7X7l7XnMq8zVK2KddPxVCy1I
         BEe+wWQl1nHrL0CpsYoBisn+umA6pxkb+0o1W2sRtKbnM3V2qWwPxZ3frPpFQLPn8aTi
         exY45IwHy5cJDggpJnMmTSOwCxNoo7WrONSxAV/qlmh6o+yo14mRv7H61TUsmQqhH7t7
         2frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=CjJXaU0LySw7qLjpaKdrRsofIRN/pf9mFsuU8VENvDE=;
        b=tv91Fn6pCgXByD7LOl+gwMd/vLnVnfFW867Nn05Lsx5Drp4opM6TFS/rPuhA+f6cbS
         0E/DUeY0OKNlaUpxKE+kbeRRrler8lkWK7g7AedC46xSllxHaex+Yq7Q+XY6VBUZNsBl
         G2vrZiAvx4Ndphth6L+2YcxCsnTG6Pj9dZEKggDkFiqR5ymQd9rwmTj5LuxUqmnBxnOJ
         dNJz+oVPRd2eImvFv1FG1nj5KAQUd17FqMt2std/CtcyrDvPlonCY5F4TPICjtHSgYmA
         MKf0JzUErM6L87lF+TrG7SQFsRr+/sy/YJ/EtOjWcAy7bSv3S1KSi4c4H46m/lobJ6Ak
         afqw==
X-Gm-Message-State: AOAM530DKcBsGYBjUavvnUag09PGdlGLXJf7s3XwfQKcY9EQryB6NWEM
        1214f9ovfXu7Uk56R3rXKkk=
X-Google-Smtp-Source: ABdhPJzwfvUQKXMs7o5x6ydRpSgIZ2ApzcO2pNmW9DJV9z5+K0r9K77l591ZkEu3jWw2stG2zWVdfQ==
X-Received: by 2002:a9d:6081:: with SMTP id m1mr17980589otj.226.1624815090700;
        Sun, 27 Jun 2021 10:31:30 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id v13sm59021ooq.30.2021.06.27.10.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 10:31:29 -0700 (PDT)
Date:   Sun, 27 Jun 2021 12:31:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Message-ID: <60d8b5f080160_ba5a220852@natae.notmuch>
In-Reply-To: <177c59bf-98e1-ff55-1b75-ea89c0de976a@web.de>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-5-szeder.dev@gmail.com>
 <87a6nk41wy.fsf@evledraar.gmail.com>
 <f580c5c6-304c-24f4-535c-35025b6b4a80@web.de>
 <87h7hr2cx0.fsf@evledraar.gmail.com>
 <c1c5316a-6a43-a377-69d5-531d226463c8@web.de>
 <87a6ncy9aq.fsf@evledraar.gmail.com>
 <177c59bf-98e1-ff55-1b75-ea89c0de976a@web.de>
Subject: Re: [PATCH 4/7] commit-graph: fix bogus counter in "Scanning merged
 commits" progress line
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe wrote:
> Am 26.06.21 um 16:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> > For what it's worth I had some extensive examples in our initial
> > thread[1][2] (search for "apple" and "throughput", respectively), tha=
t
> > you cut out when replying to the relevant E-Mails. I'd think we could=

> > probably have gotten here earlier :)
> =

> Perhaps, but the key point for me was to invert my basic assumption tha=
t
> a work item has value, and for that I had to realize and state it first=

> (done above).  A mathematician would have done that in an instant, I
> guess ("Invert, always invert").

When you get down to it, numbers almost never mean what most people
think they mean.

If work is a continuum, the probabilty that you would land exactly at
1/3 is 0 P(X=3D1/3). What you want is the probability of less than 1/3
P(X<=3D1/3), and that includes 0.

So, anything from 0 to 1/3 is part of the first chunk of work.

-- =

Felipe Contreras=
