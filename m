Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B25C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 13:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiK2NSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiK2NRs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 08:17:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6B720F5F
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:17:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k5so12631999pjo.5
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HYMxRNa4yrfbMfYCPEc2CQ6nKz0MtBX6xWbEWmS08A=;
        b=WGiWVTVuS58eQKnMyVp/xKumDrKW7ESmISdyFEawEEnbPGMIEXNbQfPAU3uLASv58e
         XimYD8/MjvC3Y5xizpJ03YBwWKx91mGHkbSSi/I7cLyqZ/iaPp39drVIHn0ANDRagZgK
         zewrdUuhnUMUzq7KNJtGhkHzg6Xet5TgxNjeuaAUp3C/7LfWFM+S7ySO92z1yEgksBVk
         yTQ3ZMsfC4aPATOmTzcGa5DDfZEOqZha7pXJKn7G1pe3U85XzPHuvr9Jbq49lMRSg01/
         MBoc3zxraK43UfuBnkUrgZ+mxatIyRTbU0bwkzHsR8jtBrh8c33BGNfke/j2StsUL4gI
         DvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HYMxRNa4yrfbMfYCPEc2CQ6nKz0MtBX6xWbEWmS08A=;
        b=xK4eYEVbSUqtRKFvqlFGpxW2QKo1X1sDjF91aeMS3QM9WnHoOeDPaPsFPvyfmg00Dl
         GMpj+UDhmSsbds29Ct61eyzsIu+6xIXsK8K5OWelov+JeYasQvEkD9q7O3kGCc/vE0/S
         BhZX72tvlAhoGIg1+m+nBTADPfPjO1MMsGV80LkBdA52KTukeQI8HhyN5K1YllCsLFTZ
         sDhycM5tZy9rnKZZr3Gr9ZVzT+egol9ckD0izRXtZD8FVY0YQpjyW7NYCRqh1QqrKU4U
         gvYyPlUcfmLaSp+BzO/GTGAWd1L7gmlDoj5Tct2hdtMpnWMM6eM6XlSLKS5TQqLmySRw
         jPhQ==
X-Gm-Message-State: ANoB5plLo+93qastEuS8RmqSHWeA2cvwy6A0lD7fL96Pq75RaAttBlO7
        bm0PMYXkVvcCkX2S9mDQ3ls=
X-Google-Smtp-Source: AA0mqf6uBgGfzcGDuqHqu7uqAIWfMPocbXzp2EmKz/Kq7Nl42IierI9CjUEK5cMgJ6PutV8tpawbvA==
X-Received: by 2002:a17:902:ea06:b0:186:abaf:8fe with SMTP id s6-20020a170902ea0600b00186abaf08femr50353027plg.95.1669727865579;
        Tue, 29 Nov 2022 05:17:45 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.61])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b00186fa988a13sm10853412pld.166.2022.11.29.05.17.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:17:45 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 3/4] pack-bitmap.c: break out of the bitmap loop early if not tracing
Date:   Tue, 29 Nov 2022 21:17:39 +0800
Message-Id: <20221129131739.82847-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.385.g28306b7e8d5
In-Reply-To: <Y4VDkq9vlLjFfnCx@nand.local>
References: <Y4VDkq9vlLjFfnCx@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index aaa2d9a104..3b6c2f804a 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -527,8 +527,15 @@ static int open_pack_bitmap(struct repository *r,
> >  	assert(!bitmap_git->map);
> >
> >  	for (p = get_all_packs(r); p; p = p->next) {
> > -		if (open_pack_bitmap_1(bitmap_git, p) == 0)
> > +		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
>
> While we're here, we *could* change this line to read:
>
>     if (!open_pack_bitmap_1(bitmap_git, p))

Feeling a bit sad why I didn't notice here.

> which more closely adheres to our conventions. But I don't think just
> because we could do something necessarily means that we have to, so I'm
> happy to leave it alone, too. It definitely does not merit a reroll on
> its own.
>
> Otherwise this patch looks quite reasonable.

That's a good catch and thanks for your suggestion.
