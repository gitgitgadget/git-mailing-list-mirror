Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E84AC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 18:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029036195B
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 18:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFYSYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 14:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYSYj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 14:24:39 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1D6C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 11:22:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id h9so12285018oih.4
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=RCpcxy/1ptXAev3WOgxeotoX0qCyX2bwfjCRh3+KJc8=;
        b=rYh00j5c+UQirvlMneK4tGdnaGqccNitvEdn20XA0KSxZ+N0CcqCk1Y7HVodMRsVyq
         1w8iRAqSNTpoejJQhBbri4hiSBo6KZQKdJed12SUgQqaRmkBKotvaotDcqLXDHtDFQbY
         lagM5SiqzSvG8V71Xzk+Airt9zupz+WcjZa0CzAheoviA7kuSAre9r4PMFPcOgFugvcY
         un3X7po4RWQFX39iSYUK4V6sxJoW0xZRalwDhR2EvvuJLA+I6vyOPgrnNX0JVcFwqBNP
         QQ8Fwag81V2sD1zIG1oTjcnBjEen5CitSHALYHlJHJjI/MdVQ6v8QmFowoo4Vv/hkF1C
         6uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=RCpcxy/1ptXAev3WOgxeotoX0qCyX2bwfjCRh3+KJc8=;
        b=c60tYRZrS0+EJvRAGG1vZ1aPXLXYOkPX2Awa/cZL9etWilYTnzp7vdZInvV+Dgn0zM
         xVJOBYs2awS0mvKJCdkAIjPhrtkzj3DGeLm/MFO2SR2Ot6it64lE2/q9ln7BTEWBDQER
         WxbOh0T37qqvuFNqdvtkLKQvU4Dir9AgEiM9geSNHoUFBOzdIMpb2aJ10+BJsEihJ6CI
         k22KYZQrrtr/Cmk4HX6V+YqbJ1GpA6PdGozHlN2/6x67f+lTTKCE7x1KRpnXrUa1+xBl
         3a5ejtq1/aWVJXJsuICaEuV++ctH+0LSUPlJlzIHiMQE/YYkbIgxa3a+xcn2dFmrpq3n
         FQ/w==
X-Gm-Message-State: AOAM532MC1fwvid+g7OoFt6ZKYKSLnCJTllAyKJgmdd4YKNJy5DxnGut
        AaAgHEzQChyonBXCf9WAvz8=
X-Google-Smtp-Source: ABdhPJyu5tcetJT2dX2QglhJqdSnyDIaB7Bn4bTn+4DDXlfXzErYFy+c+UBTRIVvcmh06Ku9kXVrfg==
X-Received: by 2002:aca:d605:: with SMTP id n5mr12896683oig.71.1624645336553;
        Fri, 25 Jun 2021 11:22:16 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id s19sm497018oic.16.2021.06.25.11.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 11:22:15 -0700 (PDT)
Date:   Fri, 25 Jun 2021 13:22:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60d61ed6a45dd_cc8d20891@natae.notmuch>
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
Subject: RE: [PATCH v2 00/30] Minimal restart of "config-based-hooks"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I proposed splitting Emily's "hook config" topic[1] into at least a
> topic that retains all current behavior of the codebase, and merely
> refactors existing behavior to new APIs, and then doing behavior
> changes later.

This is good but can you add an introduction that is more than "Emily's
hook config topic"? What is this patch series doing? (assume that
Emily's patches don't exist)

-- =

Felipe Contreras=
