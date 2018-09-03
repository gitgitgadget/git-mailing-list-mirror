Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA731F404
	for <e@80x24.org>; Mon,  3 Sep 2018 19:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeICXuA (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 19:50:00 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34482 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbeICXuA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 19:50:00 -0400
Received: by mail-io0-f195.google.com with SMTP id c22-v6so1137336iob.1
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yV7E8qGmJIdz+rzjeMDDTqkvPJHimLuc0jAyausgRlw=;
        b=ttTdxRphep072jGdypHbxAcHhfHUvZX8AJd+ZYB8YTZOjUgZTmBij+cfkOyVnkLs5n
         0gJ922lJNsJC0fj6oKLWKDh+8sORHoHKtpPDW6jeqqexcQ+h8Bl08VPJ/x9CPgiyHDhz
         02hscYXvv0UIl3CAjzJ0axMYR0YaNkPnQK4zBTrRZUehkb4Jf493We+fl8tYeOPkGMe0
         LGs9h8DZ/6XRDwLEZmhmOXJATo6lBCIWwf8I3mVGpwv7M0DZRxrrlVgPH9WgLcWJLLyk
         vQhzZuVh43W+xmCdC9YPIc2vrlOkW/n/PUaSFvh/jz3QmoTk1FahWFoVWFnSHMJMFHCP
         bF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yV7E8qGmJIdz+rzjeMDDTqkvPJHimLuc0jAyausgRlw=;
        b=YcPy3iDeMNVFgATLL3+s+AbnqWSONXfBLKRqD597NrACIWMTrzBn3FJam4miglg/Xj
         0ub4QsKvValYUm9p7ZOjDrUZ+Bm6LW6zlUNh9LaiC4cBvI4cjpxlrbdQGYBlTNu6RMSR
         HKwYIrMZizIGDa8KYQvEO4kWjHmPt66lXJsbNOiO73rg/rOissWzx3cLVwde/tEDUs7q
         NOjCcX5ExVys3sMl7v56uAkgTz9jF6fGBJqI/PxrEdo9rsFNkOZjaJU7XSbSf02OdxkJ
         wZZdo5ohQXvec5JLFe34lhVP5VEK223zF6jW7XABdApxBEwUJiQ71xq8L6nSGHObFSYT
         a/CA==
X-Gm-Message-State: APzg51CvRSb7QtQxisBq58G1yU8BEaYVgHRRW9UZq5GgtmorpKZS77Eq
        SX1z2J704Q6TIhwGbdF5de82L6ka2929kOpf5iI=
X-Google-Smtp-Source: ANB0Vda2NuTFDoUVJ/ZL45GyC1j56t0T/y3mt9dDf16VCbbocs53g99KLDpXaFwoBYg23LOHvchkOK6wvE2oHEJPKH4=
X-Received: by 2002:a6b:8fd0:: with SMTP id r199-v6mr20072734iod.118.1536002903620;
 Mon, 03 Sep 2018 12:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180829152500.46640-1-benpeart@microsoft.com> <20180829152500.46640-3-benpeart@microsoft.com>
 <CACsJy8AC8VT=DEcmqAtW26pYKRVT1Kz=pVyj-Wnu3uOsKwWGTw@mail.gmail.com>
In-Reply-To: <CACsJy8AC8VT=DEcmqAtW26pYKRVT1Kz=pVyj-Wnu3uOsKwWGTw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 3 Sep 2018 21:27:57 +0200
Message-ID: <CACsJy8Dm-jRYfp1UVu8O+NiHf61RVY5t1vvsbXan0YrhsDabbA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] read-cache: load cache extensions on worker thread
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 3, 2018 at 9:21 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > I used p0002-read-cache.sh to generate some performance data on the
> > cumulative impact:
> >
> > 100,000 entries
> >
> > Test                                HEAD~3           HEAD~2
> > ---------------------------------------------------------------------------
> > read_cache/discard_cache 1000 times 14.08(0.01+0.10) 9.72(0.03+0.06) -31.0%
>
> This is misleading (if I read it correctly). 1/3 already drops
> execution time down to 9.81, so this patch alone only has about 6%
> saving.

I may have miscalculated that. 1/3 says -30% saving, here it's -31%,
so I guess it's 1% extra saving (or ~3% on 1m entries)? That's
definitely not worth doing.
-- 
Duy
