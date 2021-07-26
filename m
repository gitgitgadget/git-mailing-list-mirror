Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1337C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6BE60F93
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhGZXJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhGZXJz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:09:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1A9C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:50:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id oz16so10625938ejc.7
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=tQrLfsyCcruTKxnSIa/TMZ2SoBiTBH/Ae40n3QVAJss=;
        b=THf1EHwBaQDKHfbCOzE7HDORXPhBa5/SVibMeQsJ0g1x80YWOSzf8AJJqGpKadK/3U
         QGmd6PlVfTgINpGTNaeCA1nQcDUYS286e0EYjlLQWzjpVv31TjFqxnBvajaZuOzqJT0y
         9+Hbo/BgDvYpFiBIKMEg+RfhZSqNP7pfjcrw4cffkTfl4GotSzlhrHlGSByPsv+72xkI
         v2wm7IUzjvUI4ahfdEtNMRWtruBmPg2tHdR8pXaZyYM2sFU1G1uevP0bbjBrQ2qdhgcq
         CKuh9BXzIxotOY2nkYuMcC7RqUx7F8WlcWhKYdJlik4vdYP9wxF8qMQMsLp4+pjL9aBq
         qy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=tQrLfsyCcruTKxnSIa/TMZ2SoBiTBH/Ae40n3QVAJss=;
        b=qp8fYxiEdagi6JWR3RB6e3aYk8dw3hmXNLbRzUYvZRJLEzkADhQBJyQrAaJ5ox4RCa
         +itveAzrgjumTgUXJsohVYcXYuOkcPF0zmJ4jvArzEjR7Yg8Hx8oyWPjuDiukBPUsvAu
         yOojCm+eTdmeLr+cUCq5z5ovwBFIqlg5zbcElCl9qTdqLuGQ0EndKW+YYynL8iCAV1rw
         6UL/MfZB6pPrPfmiKTwU2yOc8cxcCOg+IntwyG2ocGZ7s5rNXXY2suNw3lzYDQv4pdDa
         tcdAOcRSCS2gU1sDHSWf6pBup/nirQ/IQdDyJO89WfGJtcXLqYxONv2A2nzVyUTyc6aQ
         nOLQ==
X-Gm-Message-State: AOAM531SbpvqAoB0mhT3G47ux/s37HVsP4K9SkBuXjbo9/J9uVWz2rXX
        e3wvSMd4Ll3LYXIfn+fQbKAO8+GnrAGfdQ==
X-Google-Smtp-Source: ABdhPJxCR6BF3jTeik+zWuNV0zNlXX0MO/ObGhXejxvhpCAh5yis12YXZtVQqVbc8cAvupgiw++Lig==
X-Received: by 2002:a17:906:53ce:: with SMTP id p14mr3011451ejo.477.1627343418482;
        Mon, 26 Jul 2021 16:50:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c7sm510174edn.45.2021.07.26.16.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:50:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v9 0/7] refs: cleanup errno sideband ref related functions
Date:   Tue, 27 Jul 2021 01:49:40 +0200
References: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
 <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
Message-ID: <877dhcskh4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 20 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> A v9 re-roll of the v8, see
> https://lore.kernel.org/git/cover-0.7-00000000000-20210716T142032Z-avarab=
@gmail.com/
> and more imporantly the real summary of what this is in v7 at
> https://lore.kernel.org/git/cover-0.6-0000000000-20210714T114301Z-avarab@=
gmail.com/

FYI I did not re-roll a v10 of this on top of the just re-rolled base
topic:
https://lore.kernel.org/git/cover-00.11-0000000000-20210726T234237Z-avarab@=
gmail.com/#t

The range-diff I have locally between the two (this version, and my
rebased "should I need a re-roll" version) shows no changes, so this
still cleanly applies on top.
