Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E56AC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 14:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6CE207B7
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 14:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhA0OOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 09:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhA0OMm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 09:12:42 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020A9C06174A
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 06:11:58 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z22so1944161ioh.9
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 06:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AtqNDg5tnTvICO7SIeu4swaR4SJYuQfWaRJ1CcrgXIU=;
        b=H4cw47lCkQkDaowuVpROxUdV9gqtReh/45PGFta1+ae0X5Z+I79ImgP85h4DfuGDqC
         erryO687dISqRP/kRwjqq+vX7WVPaVD7qUGkyUpsSi8d+udwtEX+0AAsGW6+tAvtvbmq
         nhbSOk8ecuLToA7GgBv0llITxtt3IpFrFx9x/jprzeo0KmFWu4lBC8ZP2/iMzc830l4l
         KTkG/TYEcn85V1IufQqjkKT+bA+0gTUsJnauVNEHWVmGzPGW8X8vUhjk6JvKw5cXe6gw
         6HF5o3XAF+uHUh6COsfZShgk37xi6wVNBvUaMP8Kwaj4RMW2AuVyfnm3i3p+qr2taUqh
         dM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AtqNDg5tnTvICO7SIeu4swaR4SJYuQfWaRJ1CcrgXIU=;
        b=U+ZF700QyPOCspMtCkhndZaRJH2UsXS2C1cLT6Ceeazv4NBy0HQjY9A6bLcAa1MGJ3
         1NJB77nx/BXMHNItl7tCUlIvUausebkX9AJi76D1Mq/EeqTDR5uyJ7vgVCNmAMpS8EiC
         NEj0jsw+GgoSNbwlXh6ozxigEg2qfmITLOzEYcDANh01MEMxaMkJ59L4lO9YSSJWfTQT
         rrWEDu8Eg/s555lxqkiOE9X1kG7I4ArCKzKMM5uJ3TvP+IY1JK/K0yTFQAcbK7EG09Qg
         U2x65f1uBazr1REcveki0Z6md0cWhcGN7reCHClmTrtnZQlSqepRYn6lQhiBuS9WKsOL
         8Zcg==
X-Gm-Message-State: AOAM533csxTtDJ7+T5qgiGCSds+wXWBEMYzCYm57e2ThPTiI1v/Bi6A4
        ubKWV3GM5Yvx+hP6EHYpZVqeJvCEzu+tXWY9eDw=
X-Google-Smtp-Source: ABdhPJz1/u190BaGxBB5lhcJ0X29t2jWfs2M/q38sCDFXycfGfeEectMWCNz/fJkbZx9WAcTLgTHiJjJ0kTbSGzKc5M=
X-Received: by 2002:a02:37ca:: with SMTP id r193mr9327816jar.33.1611756717498;
 Wed, 27 Jan 2021 06:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20210123154056.48234-1-mirucam@gmail.com> <xmqq8s8gwjaq.fsf@gitster.c.googlers.com>
 <CAN7CjDAsRcLSZPjtJxcjyunSErer8DWKqnMcNNo2rxad7xA+Cw@mail.gmail.com> <xmqq4kj3342v.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4kj3342v.fsf@gitster.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Wed, 27 Jan 2021 15:11:46 +0100
Message-ID: <CAN7CjDCMe6xFmguqPNkjbZeB0mMieVVuZ61m+Cre1geKs3_22w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Finish converting git bisect to C part 3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El mar, 26 ene 2021 a las 20:12, Junio C Hamano (<gitster@pobox.com>) escri=
bi=C3=B3:
>
> "Miriam R." <mirucam@gmail.com> writes:
>
> >> cf.
> >> https://github.com/git/git/runs/1766239699?check_suite_focus=3Dtrue#st=
ep:5:814
> >
> > I have seen that is "t3415-rebase-autosquash.sh" the test that fails in=
 CI jobs.
>
> Sorry, a false alarm.  This I think was caused by another topic,
> cm/rebase-i, and not the bisect topic.
>
Ok.
Best,
Miriam.
