Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155B31F404
	for <e@80x24.org>; Sat, 15 Sep 2018 10:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeIOPu0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 11:50:26 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:40167 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeIOPu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 11:50:26 -0400
Received: by mail-io1-f47.google.com with SMTP id l14-v6so7952976iob.7
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8o78wFw7JAmTHeqBRbETtZ+8YywLHRoXjZmxsVBt6E=;
        b=ugFK48oQSFQmjvYxV/zZl4Ryr/JsRmd9A0EVSSh5ZO0SKMqSU/61kJUDQHWtoAMPLd
         kdmgt2Bl0WPb4UaGiDhfVVxT2QhqpQkO3XsSPNdHrPCbf4dGffmr9/DVJbN6bh3GDAFr
         nGBfkXlBHLjWp0jGZzYln2az2JDVYqu6SMg/SVT8ADLrli2ZiH/wkr2eIJNtt0QWHKFH
         Jk4Bxz0W50LPttk0tJtuPfT5Dx/AuAg8QG1SbulC3N2PgkFfXexE3ktXasPlHMVELoYO
         wzc5neEHvdoa+IsPPU+NBWeYLJXyBNeBfxb53JnIAK3ZsE8oMoSkEBpe1CNZsrpijRTr
         JMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8o78wFw7JAmTHeqBRbETtZ+8YywLHRoXjZmxsVBt6E=;
        b=ei9gi/JHbjifjkphx6xjkouIkegK73gsoRRhugJh+8HCOkuF9TzX055NrW8ej656mF
         yyEqE+5UBFgNTP90OQMymDpGui/J7sH+h+XCUlrubzHgQrUyoJC8tNrceuerXhSlIwik
         iGM+VAtqnneR73nbr6v0Ewe0fxI5MyfpLoEmX/+YCDQp6g8kZRMnHDy294HxBgY8P7Mh
         sY0LhCoGTAFE1ZZpCzdUxlkSiObTacoObi6O51ZAvGRMLQRCA8N6Hlqui0aQnYfQsnWM
         nhC0Gb2XbOXnEjwNFTBmPVk57CAYcXT8JR0YOrKZrFlh+WiTyJBf4eMgGo7ebGDzkd/q
         1yeQ==
X-Gm-Message-State: APzg51B9qXalfT+kR4o5K4qDr9ZGEI+huEWAKRx9Ya+Tr4WeZE7chKAf
        Tp6D4KVs8Q8je/tqRWBhbFPOKPw/AFtyfSsh51U=
X-Google-Smtp-Source: ANB0VdZ0VNlPsndvs/ccqurpusjIig2IW4aWiPLbgUQaNo4A3omfDonfaZqLCTjepvKSoIpXeslNgCXpLlPMKpsJt5U=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr12742449iok.236.1537007515598;
 Sat, 15 Sep 2018 03:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com> <20180912161832.55324-4-benpeart@microsoft.com>
In-Reply-To: <20180912161832.55324-4-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 15 Sep 2018 12:31:29 +0200
Message-ID: <CACsJy8CjWD_CHwv5NoURLt9is7-UUDpKDo-3EcM28imznZAOpA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] read-cache: load cache entries on worker threads
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 6:18 PM Ben Peart <benpeart@microsoft.com> wrote:
>
> This patch helps address the CPU cost of loading the index by creating
> multiple threads to divide the work of loading and converting the cache
> entries across all available CPU cores.
>
> It accomplishes this by having the primary thread loop across the index file
> tracking the offset and (for V4 indexes) expanding the name. It creates a
> thread to process each block of entries as it comes to them.
>
> I used p0002-read-cache.sh to generate some performance data:
>
> Test w/100,000 files                Baseline         Parallel entries
> ---------------------------------------------------------------------------
> read_cache/discard_cache 1000 times 14.08(0.01+0.10) 9.72(0.03+0.06) -31.0%
>
> Test w/1,000,000 files              Baseline         Parallel entries
> ------------------------------------------------------------------------------
> read_cache/discard_cache 1000 times 202.95(0.01+0.07) 154.14(0.03+0.06) -24.1%

The numbers here and the previous patch to load extensions in parallel
are exactly the same. What do these numbers mean? With both changes?
-- 
Duy
