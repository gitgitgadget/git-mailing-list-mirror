Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74BE81F404
	for <e@80x24.org>; Sat, 15 Sep 2018 11:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeIOQ0u (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 12:26:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38983 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeIOQ0u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 12:26:50 -0400
Received: by mail-it0-f68.google.com with SMTP id h1-v6so5651699itj.4
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 04:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKEDp4OEPJrZKcwAy+4GnjVuDUMIgRcNUDLdzJOq7Ok=;
        b=L2mwDAZuf1eH/0GNaE9KhpgjElrYDTv1g03uEHdJh94eNnpqD8GxDHi0pc+eIuV7jE
         6XxtKiRyGjSjQXUFsIdMhJlsClilbYpXL1oRN9vmBZ5gRTN6o+SB6Q++iCJAaKCbJlv+
         +M8HKjYe16jkROeHZbe/LkE9FtzrZrZNYlFOKMcn8fRXDDvLibtOYWK94otqlYL1YqC/
         ERLzhi5aalqpTWgWp+XyvULHy+u6T/BHqhVtRfqsONk27LYe48AMkO0/epQxzt4CH0LL
         wFDTPIDkiG/1DzNoEYXP0Z7TdRr5mBE8YiRrxFocPhOp1spQgoZ8kjNwnDwkA2wHx1Qn
         SMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKEDp4OEPJrZKcwAy+4GnjVuDUMIgRcNUDLdzJOq7Ok=;
        b=duO08L1Htg3Gn/T7c9Y2nx84+LJUtCCesTf3gDJj5C07fTL94+hVWqvcIC3Xhrk9tm
         3DYPXNdxmTHLPsPvCY7X/hIZ6iSfliBFEH/Xp4Y9/1+TBR48sEJiKouaomKQ66NImIm1
         F2hExL0/MJ+1kTPO6X4/2fRJSErSYlpPfqdXgCuU0v7VyihgH9+ql4n7xFbUEifYM7E4
         MBU/d63xrd419R9hlSUv2mcdOINi2hd1hFCPDbvM3m3b7ffQ/HT059leXtw/N80KLLMh
         uVs9RCIqNmjV1qYSMLpiuqXb3ctRWvYxs16LmKpe1Ic2kO2tvUZbjLofdHoIyAsLjHm8
         f4wA==
X-Gm-Message-State: APzg51DTvooBG1qN1o8P5gy6WH3DGutGCiS3XpI08BghhI11L3Fei2+7
        1c+kzhyHlKLO7HfX7A3Zz7GDsog6aF06Y2kD96DMoEN/
X-Google-Smtp-Source: ANB0VdY9h0Qpbu7CjeVE1o3JSmLITn8f4msnWrVGq7NIFuuDugRuwiiK9SxnBClly/mhYmR5k5NizgeR5qU4FBmL6/8=
X-Received: by 2002:a24:d583:: with SMTP id a125-v6mr5877615itg.91.1537009692910;
 Sat, 15 Sep 2018 04:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com> <20180912161832.55324-4-benpeart@microsoft.com>
In-Reply-To: <20180912161832.55324-4-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 15 Sep 2018 13:07:46 +0200
Message-ID: <CACsJy8CUsOLy_OWdJbx5TqyzPJ5eZ0QcrJniQ82nAiwwtk9iyA@mail.gmail.com>
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

I added a couple trace_printf() to see how time is spent. This is with
a 1m entry index (basically my webkit.git index repeated 4 times)

12:50:00.084237 read-cache.c:1721       start loading index
12:50:00.119941 read-cache.c:1943       performance: 0.034778758 s:
loaded all extensions (1667075 bytes)
12:50:00.185352 read-cache.c:2029       performance: 0.100152079 s:
loaded 367110 entries
12:50:00.189683 read-cache.c:2126       performance: 0.104566615 s:
finished scanning all entries
12:50:00.217900 read-cache.c:2029       performance: 0.082309193 s:
loaded 367110 entries
12:50:00.259969 read-cache.c:2029       performance: 0.070257130 s:
loaded 367108 entries
12:50:00.263662 read-cache.c:2278       performance: 0.179344458 s:
read cache .git/index

Two observations:

- the extension thread finishes up quickly (this is with TREE
extension alone). We could use that spare core to parse some more
entries.

- the main "scanning and allocating" thread does hold up the two
remaining threads. You can see the first index entry thread is
finished even before the scanning thread. And this scanning thread
takes a lot of cpu.

If all index entry threads start at the same time, based on these
numbers we would be finished around 12:50:00.185352 mark, cutting
loading time by half.

Could you go back to your original solution? If you don't want to
spend more time on this, I offer to rewrite this patch.
-- 
Duy
