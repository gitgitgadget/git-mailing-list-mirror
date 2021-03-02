Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B3DC43381
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127D764F30
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578464AbhCBPYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhCBEhU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 23:37:20 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36DDC061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 20:36:23 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v3so13929692qtw.4
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 20:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OlMlGiQiOggLpLXXXht0OCu7j/Rkf4Tqw+gDSm+504U=;
        b=BHfkkv1TZ6Ro49qWD3EiuVDSY59e9XwOBRC49aa87wjmhWN7lOClLLY+fI1falv2gT
         SLS8oY3OYJxyMyuTaGQa56epzEt6NOV2VAZC1rR6ld2XFiNJToJ6NXmdRLRRmQe6D2q5
         K8rsktvEQQyZEbKIiGiEDWcpqaHXHbSMWjC7OMs6gOV7L0m/IVWoyEE0KIM1UJ+A7TJ5
         K+6+2HOEPAH1twb9NiZfFt8sYj6TNPVSqYQQgVIj7UThvxFGaOB43kMo/mDI7Dss6gDc
         xS7RLaMrnDi/IqmCyU8iIkANl4hYSo8CKEUz/7guihhSICRuuM1Jnj2uvohHzYme9y3v
         vB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OlMlGiQiOggLpLXXXht0OCu7j/Rkf4Tqw+gDSm+504U=;
        b=Eo2a5UPJFFgESqbYg8k6yMTHKSzZ0H3FQ2YNuDfzp7Oflmg09wT3vMNs/gP+VuSuC1
         cj7uELl6B7jpHVlGwtHr8LoVaNl2FJ3qv2zlZIMMFqpXMpWLHxOI0mXV/JrN9GlyVmdK
         8QxF09Fez7dnOtwlJNrkY33AyPOH1D0CwbyzW1359kXcWKZYx8bxzuTrGBo8zoI6+PVZ
         QSE3+a+l6KXEM3uTV20Zq0h/GZI4YsOvytZ/Goosuw5ggZ0ROrT9Istji72h3/Fe0cO/
         +GDLcWcSpgNwprzmLX51GMR0SCezDDNM7rk/PZd3EtafZ9wOiYu1puIlzx+CTgw+y3Bm
         k11g==
X-Gm-Message-State: AOAM533QePTyR2bj9PDoOZ00G+Z7/DWUM+7ftAuZtbiQNhEJTKK84frn
        ZPsAdz7qK5XUv2FglSQpNDtZ0E7ZGGDme9yL
X-Google-Smtp-Source: ABdhPJyudwy5Mraymr6bBdqcUT+l7lRD93uakq8rYuMdO9srWUsE5l5O7gXR7C+ppX85W6GBJuzNbA==
X-Received: by 2002:ac8:5503:: with SMTP id j3mr5173728qtq.19.1614659783005;
        Mon, 01 Mar 2021 20:36:23 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1582:4add:dc39:710a])
        by smtp.gmail.com with ESMTPSA id c5sm14107957qkj.100.2021.03.01.20.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 20:36:22 -0800 (PST)
Date:   Mon, 1 Mar 2021 23:36:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 12/15] Documentation/technical: describe multi-pack
 reverse indexes
Message-ID: <YD3AxOqA1wvUBkZO@nand.local>
References: <404d730498938da034d860d894ddbb7d6dffc27d.1614193703.git.me@ttaylorr.com>
 <20210302042111.4038479-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210302042111.4038479-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 01, 2021 at 08:21:11PM -0800, Jonathan Tan wrote:
> The previous patches look good to me, and I'll review the remaining
> patches hopefully tomorrow.

Thanks; I am sorely behind recent activity on the list. I had a
last-minute errand to run last weekend and I haven't managed to quite
dig out of the hole I created for myself since then.

Incidentally, I have had this code (and the tb/multi-pack-bitmaps)
running on a couple of high-traffic repositories internal to GitHub, and
so have a couple of improvements that I was hoping to squash in, too.

Thanks,
Taylor
