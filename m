Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B832FC2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 15:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902B6613C9
	for <git@archiver.kernel.org>; Fri, 28 May 2021 15:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhE1PON (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 11:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbhE1POL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 11:14:11 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FECC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 08:12:35 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso3786186ote.1
        for <git@vger.kernel.org>; Fri, 28 May 2021 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YUPQMvqKN4tHtSSksxISm7JL9cNDwGGhKDMvOoaxKss=;
        b=bHmFYY7LdGCH90lHfKwJk3V4PNWZ0YmAhN+K95HxXfn9UvfzbZpNYUcYZYYfq7EJQx
         2fRdCkfNHvMA1vFxO/6QrtaakDu/j2BPLAkK4KbsFVALubpI8CAJ5/NxqwuOiwZGMVxg
         MtzVPkwTnFX5j6KbNym+qLKYzJKGt+HnMnwe2lGo0sJd8e9JTKL0FIeubLfZ4HTwpur8
         Nag7Bk9pSunJGil+AHodV+1ijq6H3SNkF+zfo+t3/V0IEbIku1bBJypNvlJwr3mCpPOx
         Z2dks6ZySlq7id8GfxeyoUb31Q8gLHbxZktKiQmT14TvlRDIHT+tHrgXvyOlohFMwuK4
         81Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YUPQMvqKN4tHtSSksxISm7JL9cNDwGGhKDMvOoaxKss=;
        b=oaIBMn+moYx2DVeuYykKdwWFwPjVw3682TyLvbzn6Y/bWE/B/xi3noeaHBfCDfev6A
         IfzSI3cd5wXa3f/xyUAjEnqXPbfrUv33ovc1DZQWkBqWuis1B4B+m9GLy40Mcsw3DUI0
         UZOKm3HUvjf8jvij7RKy/16lg20BMSbvvyHeZbJZJxnO84QQ43VhW/RvSplyoPNTItyK
         dgIVbJwKpYNSJ8xGCXcWNsqdDD7gz8NzVNovfPNB7uOWEFZBMg4gsI8HeS/S/6DxWo3k
         BbZwkWmGEEA6pUdxx6CvHd8sRAPRACph3nJ1AEHrRw2seV4LP0e4idY4NimKi8fCoPnz
         rwRA==
X-Gm-Message-State: AOAM533hmQ7opE4r/JZ88wwhl6iEq2BOkXudU4KiuqHwJ2ES53jccxaP
        b/hPTdzOHSWmA5YJeERKb+M=
X-Google-Smtp-Source: ABdhPJwB/PIxKl6QDhhbnN2TrfVIzubt4aE9i+mDEekWUFPLKg9WjvDtXiByaKDgaBZCH5XyGSRydg==
X-Received: by 2002:a9d:4816:: with SMTP id c22mr7740874otf.283.1622214754905;
        Fri, 28 May 2021 08:12:34 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id n11sm1162450oom.1.2021.05.28.08.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 08:12:33 -0700 (PDT)
Date:   Fri, 28 May 2021 10:12:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Message-ID: <60b108608f0da_4b1112080@natae.notmuch>
In-Reply-To: <YKYdeom6SgAHqojm@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
 <YKYdeom6SgAHqojm@coredump.intra.peff.net>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up by
 >2x
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, May 20, 2021 at 10:18:57AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> =

> > A re-roll of [1], the work I based v1 on top of has landed in master,=

> > so this has been rebased on master.
> > =

> > The changes here are minor, just a typo fix / commit message
> > clarification, moving "require" closer to where it's used, and finall=
y
> > a new 10/10 patch to s/cwd/getcwd/g.
> =

> I like all of this, except for the change in the interface of
> Git::config_regexp(). You mention that it's new-ish, and probably not i=
n
> wide use. And I agree that's probably true. But it feels like violating=

> a principle of not breaking APIs, and we should stick to that principle=

> and not bend it for "well, it's not that old an API".

APIs are broken all the time. That's why they have versions.

Anyway, I find it odd that the git project cares about an API promise of
an outdated language steadily in decline (it's peak was in 2004 [1]),
and yet it does not provide an API of its own, like virtually all
important software.

Shouldn't we care more about a C API than a Perl API?

(a non-existent API is orders of magnitude worse than an API that broke
once)

[1] https://www.tiobe.com/tiobe-index/perl/

-- =

Felipe Contreras=
