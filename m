Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136D7C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15372078D
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 12:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpcJdKB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgHUMFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgHUMFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 08:05:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF31C061385
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 05:05:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ep8so739447pjb.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K+l4sqN5oqUj5TgUOek8OIzANtLwlgPimgFaErrOgPY=;
        b=IpcJdKB5ihkn7k8jZQbN4kJuoNR7wYVZNvyb4/Dq3NpVjord7M3UcUJBcxxXlMQ/W2
         Q7Jn2tCzkWkDaX0GBB8T0LrpivxdGMWx+dJOIeZKQzOarIlTCblzyztCtwKr0eqnAu1S
         lT7PgxDVJz9fN5Juq/jUn+IcPHAFcZfd8i1IZ1FGkG55a3zMtGWfLvkX1iUhfJvWvgG5
         1t8oSjlzWehCgK0l2rS5A1QsZQJxvP89jJdK6t+kY6opN7KRjf19HzKJJiMyLzd9LwbG
         XojmllOJXqun/ADU2FDp3dAK5UuxR9ColvnUVazB/jqe1WHYG3TXtdET02CTbORG+fiy
         oHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K+l4sqN5oqUj5TgUOek8OIzANtLwlgPimgFaErrOgPY=;
        b=jxhdlMoPu8RANMBVHJ0FAvxaPna/+q9mffBxup/WeNmj/Xmv02NJUbE2vz83djqfn6
         wt6//m3hfIcGp9LrIJn1l3Tdfjstc4Y2JekK4WvlB6QFeTEvyw//nlbiD43vR4mdLLMg
         i3nQ+rTxTNBh9pRdAGkbyxGG1+6yFCC28p6DyNEu44XmeRgKAuABdTfu7YLXrl8N630d
         eMzJdGypA35TiFE5QTnO1TfrMBb9zeccXDCFC53ZxakYNaSnspETtGSWucRqBV0x7TV6
         VMOqaem6LAmt7oTY+O0GfrItD1LDBF1C1zxgknGu4MNUONOXolUNgFp5hDcKkFbWS/hy
         pOIQ==
X-Gm-Message-State: AOAM531SWSUsfngAxHp+c6xzWTYglABCmX71BzILyiRIRAOvr54P1O1S
        Q8I3DFEnolFaIA3j2lmMXQg=
X-Google-Smtp-Source: ABdhPJxrXmJzW8pZBrXvbD8tvMv4rVA3KKOzK0TjlxNx5XVPVZo2FXsEOWDb6Tz4KswzfMDDmV7BXQ==
X-Received: by 2002:a17:902:9b8d:: with SMTP id y13mr2122899plp.279.1598011528574;
        Fri, 21 Aug 2020 05:05:28 -0700 (PDT)
Received: from localhost ([2402:800:63a8:cb7a:1eb1:40a4:f50c:706e])
        by smtp.gmail.com with ESMTPSA id a7sm2384532pfd.194.2020.08.21.05.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 05:05:27 -0700 (PDT)
Date:   Fri, 21 Aug 2020 19:05:25 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] t4013: improve diff-post-processor logic
Message-ID: <20200821120525.GA599@danh.dev>
References: <cover.1596887883.git.congdanhqx@gmail.com>
 <cover.1597926783.git.congdanhqx@gmail.com>
 <a52d0e59ecd5777f2a1d242a37c6bb6aaafb1ed2.1597926783.git.congdanhqx@gmail.com>
 <xmqqr1s1ayj2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1s1ayj2.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-20 12:49:05-0700, Junio C Hamano <gitster@pobox.com> wrote:
> > diff-processor logic.
> >
> > Let's fix the bug for all-zero object names and extend object names'
> > abbrev to 16 while we're at it.
> 
> "and support abbreviation of object names up to 16 bytes"?
> 
> Also while we are at it, we fixed the post-processing not to touch
> the file modes, which were mistakenly munged in the older code as if
> they were object names abbreviated to 7 hexdigits.

I've integrated your suggestion into newest series.
I think you meant 6 hex-digits here, and I took the liberty to change
to 7 digits.

Thanks,

-- 
Danh
