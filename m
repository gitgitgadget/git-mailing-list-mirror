Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1DA01F404
	for <e@80x24.org>; Mon,  3 Sep 2018 19:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeICXn5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 19:43:57 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:53980 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbeICXn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 19:43:56 -0400
Received: by mail-it0-f42.google.com with SMTP id p79-v6so2196999itp.3
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMK1c2bAJ2JZfXMVX+8RG3ejFqxEUAhwQloSYIu8AEM=;
        b=Dg7bXDdjMD3IE0ctEXg/bvbdcY9MuxaZsyDEswVwUci+QDS4NQYkXIl9j5BneD1dW5
         36yJ0h5HewKsTPQSmmwPDt9T909lykPNtxwDKKGbLoVQpZ/lGpCcrb7a/nampfOcudPe
         t664krNwDVL8EbWH8/Czz95vyIIghf9YIZ/sL9RxOsm7MWZdtuDCrTQHGCDGdQSNug5R
         1+7G/PbUwnpTIEK+wh4Gl3RwAtF8bPR8AdzoFNjr0BYKkZlWuVGnLDJhDRiNVIJJKDHE
         iQs0A2ljw6E4yOdmOvwC+ELYE5mZrXyl1B2Tv2uPF7zUuCGYk+P7m14+f7bLUd0AAdhn
         KuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMK1c2bAJ2JZfXMVX+8RG3ejFqxEUAhwQloSYIu8AEM=;
        b=tSczdB2T3zJ7UClAi2050e12tfh33iHGkWgeC1C7T1PvYSvwT4DX5xmerT37mYu0tU
         gIHzSVPbDP5BDHEW0jdqxaQ7sR61sHPJyP4e2b5fLEHB/Cw1BWLheNRaIWnZkyVC7RO9
         xuQaC+NuKFZv4EhnMN5GjIRAgFRAHmadfCNGbtM6OqxlD3fo17Oh835kBU0ElB/YFDiT
         Qj15HKYN09xDQnnH4ZGuv/4bATmtouLXbILVe88a3lSeS8a64wjf4hgoXi89x4IRI/dV
         c/sEAWHcdtc3/uzQ8uxVAgIVgBqH+EufNFeU3sNIvhH/bVlBGw2oEKVqTCBH3rGiyvSs
         QZnQ==
X-Gm-Message-State: APzg51A08LEex8qU4BiVVtSOEqmOMmuq9gRwAhSuzsFXAovkQSX6XFcZ
        hSciOIORKv+068bCqnG81DI0MFnP1X27W3ZRj9oTgA==
X-Google-Smtp-Source: ANB0VdYgMMWtUl4KZ2oQEP9pmfHGN52MjmKpaN7j91jpRDig8kPHxD0vyLOGf28kC88b+yTdyNCCXswILatvqimBLBY=
X-Received: by 2002:a02:b006:: with SMTP id p6-v6mr20916162jah.97.1536002541455;
 Mon, 03 Sep 2018 12:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180829152500.46640-1-benpeart@microsoft.com> <20180829152500.46640-3-benpeart@microsoft.com>
In-Reply-To: <20180829152500.46640-3-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 3 Sep 2018 21:21:55 +0200
Message-ID: <CACsJy8AC8VT=DEcmqAtW26pYKRVT1Kz=pVyj-Wnu3uOsKwWGTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] read-cache: load cache extensions on worker thread
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 5:25 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
>
> This patch helps address the CPU cost of loading the index by loading
> the cache extensions on a worker thread in parallel with loading the cache
> entries.
>
> This is possible because the current extensions don't access the cache
> entries in the index_state structure so are OK that they don't all exist
> yet.
>
> The CACHE_EXT_TREE, CACHE_EXT_RESOLVE_UNDO, and CACHE_EXT_UNTRACKED
> extensions don't even get a pointer to the index so don't have access to the
> cache entries.
>
> CACHE_EXT_LINK only uses the index_state to initialize the split index.
> CACHE_EXT_FSMONITOR only uses the index_state to save the fsmonitor last
> update and dirty flags.
>
> I used p0002-read-cache.sh to generate some performance data on the
> cumulative impact:
>
> 100,000 entries
>
> Test                                HEAD~3           HEAD~2
> ---------------------------------------------------------------------------
> read_cache/discard_cache 1000 times 14.08(0.01+0.10) 9.72(0.03+0.06) -31.0%

This is misleading (if I read it correctly). 1/3 already drops
execution time down to 9.81, so this patch alone only has about 6%
saving. Have you measured how much time is spent on loading extensions
in single threaded mode? I'm just curious if we could hide that
completely (provided that we have enough cores) while we load the
index.
-- 
Duy
