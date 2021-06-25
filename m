Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1F3C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA5A61962
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhFYTLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 15:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYTLE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 15:11:04 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D2BC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:08:43 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10362046otl.3
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2RYBH0Q3Fo9z8fy3Dr28UPMS8aJkH4+9SQn9egNN3zg=;
        b=N5xlwPpThY9kbY1sAHPPgjEM+QKvmm5Y280/7fNWcqSOWRot/8iTTDm4NN5OpNde0r
         5CuhCp5jP9/8n8QasacQkfTve9snTOMdgSxigLz9Fy73poS6OdJAKKV+RPtb1e8wMxUr
         /Uw5GieH9P2RTwFyN5s93rHfUDYPyPmUH1YIOR71khwHscLEGez/5OD+f/l+UGC4lE2j
         h0LcYl/8dAmfyKgkj1fczh2Yrfkyabf/h8NY9+4VwM7VhTUsDJkbpfT1b7uj9vMBZwGR
         rkzuzaqGVsZNz3vUTM8OL8lhx/aarpA4Kxol1OxEqXViNyg/KI1J9/aCTdF2rAMN4Qcd
         6zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2RYBH0Q3Fo9z8fy3Dr28UPMS8aJkH4+9SQn9egNN3zg=;
        b=Enj5imxbkIy9GJ1d/eayT6chutTJ0TFTsgIThjj83LzAdO577YT9VFDuFGuABMSkMF
         BVvVI8+tbf0SZz4i5fgl+PtA1cCs4tdel4org76mZilbDmUcSMz4czv6uMwB8WHOFAFf
         pSizoyX5K6CtG2vOpKMuzmQe6fE2Dcim8qMWX0LiX9ispYNnlFZ+51EcQAA9qbSGC0oL
         sYbcimem50d32C29+K8MC+tXpeahLz/Yf5/xtLoZOA3yxqbEME6ZbMQe9CE2dVu3GtFV
         PoN85ro7MgHhmBscVQitY2YC5hRQSi99CxWgvvr5h2h+td+SP34saqiUqgzIGpsZLQ9z
         rnKQ==
X-Gm-Message-State: AOAM533uFqh1xwK414E0am0NNJNpR4LJvixOs2ffMDC5aL6q9dEhwsLL
        SKcdKMwPWm3Ec9yQqxa4XVA=
X-Google-Smtp-Source: ABdhPJxKVskqDRAdnK4ZotCq3rd+ksGS+NNSW+ttBX6mLo7lZdoJ3auF4VU0DBcePLl1d77gczFefg==
X-Received: by 2002:a9d:589:: with SMTP id 9mr10933180otd.65.1624648122879;
        Fri, 25 Jun 2021 12:08:42 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id f2sm1383637ooj.22.2021.06.25.12.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:08:42 -0700 (PDT)
Date:   Fri, 25 Jun 2021 14:08:34 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Message-ID: <60d629b28a7ce_cc8d20882@natae.notmuch>
In-Reply-To: <YMfLO9CT+iIDR3OA@google.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <patch-01.30-447d349c738-20210614T101920Z-avarab@gmail.com>
 <YMfLO9CT+iIDR3OA@google.com>
Subject: Re: [PATCH v2 01/30] hook: add 'run' subcommand
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:
> On Mon, Jun 14, 2021 at 12:32:50PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> > =

> > In order to enable hooks to be run as an external process, by a
> > standalone Git command, or by tools which wrap Git, provide an extern=
al
> > means to run all configured hook commands for a given hook event.
> =

> From what it says on the box, I'm slightly worried about this patch
> doing too much at once, but let's see... (I think this is also a common=

> thing you and I disagree on - how much work to do per commit - so feel
> free to ignore me ;) )

From my cursory look this is the only big patch, and I trust the reason
=C3=86var made it so big is that he couldn't figure out a way to chop it =
into
smaller pieces that would somehow work.

> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> =

> Thanks for including attribution - I appreciate it.

It's not really an attribution, since he used your code he is pretty
much obligated to put your s-o-b, see Developer Certificate of Origin

https://en.wikipedia.org/wiki/Developer_Certificate_of_Origin

-- =

Felipe Contreras=
