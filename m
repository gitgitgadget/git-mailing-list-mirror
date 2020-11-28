Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1FDC83011
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E0F22240
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WbUTg3Hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbgK1Vtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732434AbgK1SH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 13:07:58 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2952C02547F
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 09:30:41 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w202so7199016pff.10
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VBaHHiruHoIwOPUL0z2QgzuvQ/XHEXi3gX2X+tVYYh0=;
        b=WbUTg3HcpU0BLDQO2s7LTXUn4v5RL0jQvTHg2fSaWzHE41LliduoG2RyT5qE9TtSIc
         Wee0om+yy4pdL68GZoUOzs7T7Up4zuJMoJcmI5kdaUbOy3CY8kdGWMbWY3CySYqz5x25
         rcJLsqWzJmJYUaVWAcGcXsLdv/Knw3ltzCjQ+zW2Dnej1y2aDcmozG/Gc8Mi/Q+WCRlj
         0Fziqa4wQ+LjQ3Y2bpf1ZHb78tm+auD7NdOqEhyGPdJeSV7Ro4bszZrPLgUZRd/Q0RUi
         68rpjiAu6qAM5ty8qr41svdv8AIltKytC7cmgvayCADkvcfJZbSJ0hTz5Bdx2EnxpJF6
         v/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VBaHHiruHoIwOPUL0z2QgzuvQ/XHEXi3gX2X+tVYYh0=;
        b=FAxj0qgM2uy7msIrImtAnisVxZ/6LT6VhwU+41tcS1BylGPxpBLGsWC2Gh7O+sxPXB
         p5wjq/ptHl3YXHzFCrDeV2fYosxs4UXcul+PGPkgT+qGdU+Qdmg7q5Jx1GA+mWa7unyB
         HPOgL4QUNQbK3cOIMhtWhmHP5SbE2MAdE2fo415uDs+JiGJEkjPwRbwgqf64NF1J6NgQ
         Q3CPPIB+I6GLi1bRwPQ03vyeeshKZw4fIloWebfgKXF9NchDd3pD5m1qqp5WffvM18Y1
         +Yd4b2GdYTj6xmqsF2TLWPm95UJlQ6/kKzEMZw5ZKcCiffRMUNJG8+aZetkvCDChgoLK
         VpJQ==
X-Gm-Message-State: AOAM533pZKUDuetnehOc9P6t2RdU8DDZzIIpKQ1hec8Jt73DOO9b52Ao
        gWEuAAGv8Jyvup83kVl89M+60A==
X-Google-Smtp-Source: ABdhPJwOiLNevYibQT1K6XDCbQL1pd++RpxVlLc7B94zGOyRzLuba4ccEEznCGAmExVxYNbwwNt19w==
X-Received: by 2002:a62:e70e:0:b029:18b:913e:9d1d with SMTP id s14-20020a62e70e0000b029018b913e9d1dmr11927009pfh.47.1606584641505;
        Sat, 28 Nov 2020 09:30:41 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q7sm10523278pfh.91.2020.11.28.09.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 09:30:40 -0800 (PST)
Date:   Sat, 28 Nov 2020 12:30:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, dstolee@microsoft.com,
        gitster@pobox.com, peff@peff.net, martin.agren@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 15/24] t5310: add branch-based checks
Message-ID: <X8KJPwwG4eD+9TGW@nand.local>
References: <8b5d23933301988e42ddd57687e0535f8749367f.1605649533.git.me@ttaylorr.com>
 <20201125011748.944638-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125011748.944638-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 05:17:48PM -0800, Jonathan Tan wrote:
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > The current rev-list tests that check the bitmap data only work on HEAD
> > instead of multiple branches. Expand the test cases to handle both
> > 'master' and 'other' branches.
>
> [snip]
>
> > +rev_list_tests () {
> > +	state=$1
> > +
> > +	for branch in "master" "other"
>
> Would it be worth including "HEAD" in the list here? It would make more
> sense with the commit message saying "exstend" instead of "replace".

I don't think so. These tests were run with master checked out, so
testing HEAD would be no different than including "master" in the list
of branches here, so the commit message is correct that this is an
extension, too.

> [snip rest]
>
> The 2 prior patches (13 and 14) look good to me.

Thanks for taking a look.

Thanks,
Taylor
