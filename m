Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E38C56201
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F722075A
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VDkFg9zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgKZBEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbgKZBEs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:04:48 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7EEC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:04:48 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id s21so72581pfu.13
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9YL0TyK1SocZoZyF96XqmmTCJ3lWxKNu/C5giddUJM4=;
        b=VDkFg9zdoM+bluJ2/EgpimLuYM320lJ4ZnQs6f7U2gBLmCEYD8fG2B1RuYJJKiQzHA
         gJvfy+ciWKynSVrqEE3bJv6Y2qFACeZacsMpu54bcrCOu/JFMvGssiwQ34dy3LfULl7M
         JJIJpXQh5+bNzhZ7okOO+QA8LFw6e+PiE45scGcXQxvr9fcYHTUt1X/qwee51nKUtAyp
         iVZ1nT1ZeNlVZAiVgktGBRsRMEucd7PyKMbufBAMivgUqy+pHGPs5LTT1i8K+sMTVu/0
         EZ89VKrf6BHjKfXa6WUy+Gn+NWUN25cME31qJ4xsoJBHFNXNVbXEaHUedv8e/iC/Arn+
         kUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9YL0TyK1SocZoZyF96XqmmTCJ3lWxKNu/C5giddUJM4=;
        b=FucfKiDatQor3zkG627zLx4gd0UGSH0XpfACVXv7m/J4GHMDjT2tS/X9oyttGpW8N6
         p/hSQ/8l5UFpqySO03g9q1lPRfdi7EqcolIW92SPdQM57NkGX6ZHe5S167OgiF6u+kHB
         cErZ26kWzeHDyVJteBWQhl0f4PwLq71R0KTaEbXdQ+1N2UeKIDekV54tLCjuqkxV+gNO
         ZqhwwG+S7bwwMzaxww7LmNnc2hb1m/7jVWceQ4Ks/655ZYq10ZtSKnOE7j1E0IK1Vc1+
         xmkhED7jphPonQum6yBBpdd5MpLNLlSf/xkEYPqO2CZoiLUKRCphOV7KUbPziOvJ3Vbh
         SJ6w==
X-Gm-Message-State: AOAM531fog/5/ArwaOsHlA+LT+rzR55xb8nk6/LmvnXVAUcjigOEIB6h
        vREC0dhctIu/tegJSUGbDazvLg==
X-Google-Smtp-Source: ABdhPJwz8bQsnGIx9CmY//7Ycy52DZnoCjGHS36KbxAz8DY7MtiJfTwRu/Xhkny+19bkjD4clPNn3Q==
X-Received: by 2002:a17:90b:1894:: with SMTP id mn20mr609750pjb.100.1606352687533;
        Wed, 25 Nov 2020 17:04:47 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id f5sm2813251pgg.74.2020.11.25.17.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:04:46 -0800 (PST)
Date:   Wed, 25 Nov 2020 20:04:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 0/2] midx: prevent against racily disappearing packs
Message-ID: <X77/LEwWlz9fjbYM@nand.local>
References: <cover.1606324509.git.me@ttaylorr.com>
 <xmqqblfldts4.fsf@gitster.c.googlers.com>
 <X777dl3pqioME7uM@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X777dl3pqioME7uM@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 07:48:54PM -0500, Jeff King wrote:
> Yeah, the race reproduction in the second commit message can actually
> reproduce the segfault as well (it depends on the exact timing which
> error you get). So the segfault is in the reader, who is not checking
> the result of find_revindex_entry().
>
> Arguably every call there should be checking for NULL, but in practice
> I think it would always be a bug:
>
>   - we were somehow unable to open the index in order to generate the
>     revindex (which is what happened here). But I think we are better
>     off making sure that we can always do so, which is what this series
>     does.
>
>   - the caller asked about an object at a position beyond the number of
>     objects in the packfile. This is a bug in the caller.
>
> So we could perhaps BUG() in find_revindex_entry() instead of returning
> NULL. A quick segfault accomplishes mostly the same thing, though the
> BUG() could distinguish the two cases more clearly.

Yeah, a find_revindex_entry() that returns NULL means that the caller is
probably dead in the water.

FWIW, this function gets touched by a series that I'm working on here:
[1]. There, I think "returning NULL" is equivalent to "returning -1",
and the problem exists there, too.

We could return a different negative number, call BUG(), or do nothing
other than what's written. I don't have any strong feelings, though.

> -Peff

Thanks,
Taylor

[1]: https://github.com/ttaylorr/git/blob/tb/on-disk-revindex-part-one/pack-revindex.c#L177-L201
