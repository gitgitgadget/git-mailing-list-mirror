Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AE3C2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CD922248
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HitevINK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgKLOru (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOrt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 09:47:49 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8213C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:47:49 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id m65so4072708qte.11
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=l+gkhIE6id0kiaZH2L0IHemX+rVaJWHQqPbeKSs33Ok=;
        b=HitevINK1sTtdY9XDGHu//AIP1aH+PuQo8UXU51BHy+BhpIkNvmU4FV5jWI5eqUdd4
         n0Ii9AmEZGNp1bvIRTlaJu8y3a4TBdfOgSUOaW0S3X5189gWFyywqVlnrKlpXS17wmCL
         LS/3dBidAcJxaqccMSHanEiFWadjFImB8SjZZWwCwbj1VvVUksoLTouXEhGcSHuyvwT2
         Lu5vEUtPg+vJgBjmTyc+tEynEHXgHGj31fdIQraEHZl2LwoxJFehNqHgF5WV73SHiFzq
         uKCjPjWXaVsgbNdTRbgicP/gf19590iAue33j4hAvxCZWVTDXKJulF89rDED7JJwqZHU
         PkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l+gkhIE6id0kiaZH2L0IHemX+rVaJWHQqPbeKSs33Ok=;
        b=i2JTuWidWIEXQkBV8ewxNF5u8dZsVMEtgjK6K/ehn8K1YWPp6T/2Ep/4PRKHnyA+oM
         AErLG0Xyt0UMc4Dmuv7XzFRmQ9l/SZiFX+p7uoEN0CQEv5UqFfNJBblTtPM7KfwiNzR+
         BZYTLGEy7tNNIhqhATxklWoXEQIYKvBf9vBkjUmtzdKpTHKYjkdVkowRQFVw2N9BXKzx
         ELy984hjsZDzWbcwzrbT8kXmYvt9i3zmNyO0zZhx1Sma5iCwldwYlomEQHjmkueR7rTd
         K1UUvjha8K7Q9cDBjU9XCyqMueTP0ZcPVY0BvTcbYtOeGXniXSuoJHDvVaevC7zafqOq
         IXrw==
X-Gm-Message-State: AOAM532QxCcL45zk/cIqTL408sAqmgY8DjT0FSHjdyiYFK/3lnhR4qMh
        KTE6sd9GHRf4fW9rXDXHTF9Ppw==
X-Google-Smtp-Source: ABdhPJx99Lu20dCfz9T/dUvHHqd3VmsY3zmoMW8EMr9pyjURAh+i8pvok1saNGnfbdNNZUoH4T8+Ww==
X-Received: by 2002:ac8:5142:: with SMTP id h2mr7990676qtn.29.1605192468503;
        Thu, 12 Nov 2020 06:47:48 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:508e:3ccd:52c2:244c])
        by smtp.gmail.com with ESMTPSA id q15sm4815530qki.13.2020.11.12.06.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 06:47:47 -0800 (PST)
Date:   Thu, 12 Nov 2020 09:47:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] csum-file: add hashwrite_be64()
Message-ID: <X61LEUBDyhnboZAv@nand.local>
References: <16932ced-8bcd-89bd-b927-cae1bce0365a@web.de>
 <fcebe67f-f1d7-0069-01de-12844508cae1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcebe67f-f1d7-0069-01de-12844508cae1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 08:52:24AM -0500, Derrick Stolee wrote:
> On 11/12/2020 7:20 AM, René Scharfe wrote:
> > Add a helper function for hashing and writing 64-bit integers in network
> > byte order.  It returns the number of written bytes.  This simplifies
> > callers that keep track of the file offset, even though this number is a
> > constant.
> >
> > Suggested-by: Derrick Stolee <dstolee@microsoft.com>
> > Original-patch-by: Taylor Blau <me@ttaylorr.com>
>
> These patches are absolutely correct, and I'm glad to see them show up
> in a very clear presentation. I had to go look to see why these were
> not already present, with [1] being the last instance of these showing
> up on-list. They did not get into the new version after a significant
> refactor [2].

That's right. What happened was we stopped writing the uncompressed "has
an unpresentable Bloom filter" bitmap between the two versions you're
talking about. Since we wrote each word as a big-endian 8-byte unsigned
value, introducing hashwrite_be64() was useful in the earlier version.

But in the rewritten version, there were no _new_ callers that would
have wanted hashwrite_be64(), so I dropped those patches since the
series was already large.

That all being said, these are definitely useful patches to have, so I'm
glad to see them being dug back up. Thanks, René :-).

> Thanks,
> -Stolee
>
> [1] https://lore.kernel.org/git/20200904202226.GA21837@nand.local/
> [2] https://lore.kernel.org/git/cover.1599664389.git.me@ttaylorr.com/

Thanks,
Taylor
