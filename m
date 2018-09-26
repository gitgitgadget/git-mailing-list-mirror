Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C3C51F453
	for <e@80x24.org>; Wed, 26 Sep 2018 22:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeI0EWE (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 00:22:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52908 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeI0EWE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 00:22:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id l7-v6so3833200wme.2
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jp9nouSZ2TgXzDZCzfvK/knA83BKbUbXmrs8O5PgGsA=;
        b=mVJGSR2wSKvVviLrSG9ShcfN+3DFdwHJLJITdzuVXA7Yprq2rBmZXby/0SjfX6iWb4
         F6+GaNTd8xWPqazH7w2WEMdOQEiVWizdIcaIpyomaFMEAcDFLx+SO6NE77Q1cDBulys4
         ZiJY/xj3ay+3/tqK2WSMJuc4jl0vk10imGZGCnU+eSXnfRHrQ6e4FTwyAVHuC0Vfl0Ow
         lbqKbqmj9yjnr37qGeywu/xWXV/8K6kem2dBjVpiLKG12GwPkLhtmVqVUty0rev9vK2L
         28Tf0TFMjTse63pNi6d7HmUkrW452ELYt0F0tgxEbfc1FqRIHQ8G3lMq1DmA/mq7o/B4
         KKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jp9nouSZ2TgXzDZCzfvK/knA83BKbUbXmrs8O5PgGsA=;
        b=aq0wAbbeEU8eYzTHetF2/v7egO9XVmfFzCkx23mM6/+A0yKMew/yzPPquLm3igE7e3
         6v7z7X6YXEr/SKGl3M1MoG2UnlRMLeoMHnwTGI+oWKZfWKYvi/RIcwOioqvbSLdv0S+P
         Evy8e91VSdLnm8vxcgUkq5e7UYhVBKb85tksASFhA5Oko8wXKXCoO5FIHEEM5wF4vUYc
         gJbbfaXXLaW6ylCb2WnJmi2ATPL2Px8joNGdTfKdf0rbRSr/iBqWBkL8k2E646QFCbK2
         i7OYQ6zwD2S0lUCOto3qDjogjjQBABmaweVd/WW/8F4JBOVIw9SuBCrrt3nTzUVgi17M
         +FKA==
X-Gm-Message-State: ABuFfojTIUl7Atk3++oPDvDmk3dKUNGZhLJJIsHinJURhg9G0HOOSTUl
        SSx9e57kjSl+f+t0RzUhGlI=
X-Google-Smtp-Source: ACcGV62OGELRw0iqczGCOjpmHsf4/tIGnQ4V6jOOlQtlEzuql0b1db21lwldlY4xTe7MUhvp5aD56Q==
X-Received: by 2002:a1c:7212:: with SMTP id n18-v6mr5915912wmc.33.1537999618942;
        Wed, 26 Sep 2018 15:06:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r9sm139970wrx.65.2018.09.26.15.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:06:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v6 0/7] speed up index load through parallelization
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180926195442.1380-1-benpeart@microsoft.com>
Date:   Wed, 26 Sep 2018 15:06:57 -0700
In-Reply-To: <20180926195442.1380-1-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 26 Sep 2018 15:54:35 -0400")
Message-ID: <xmqq5zyrkj5q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Base Ref: master
> Web-Diff: https://github.com/benpeart/git/commit/a0300882d4
> Checkout: git fetch https://github.com/benpeart/git read-index-multithread-v6 && git checkout a0300882d4
>
>
> This iteration brings back the Index Entry Offset Table (IEOT) extension
> which enables us to multi-thread the cache entry parsing without having
> the primary thread have to scan all the entries first.  In cases where the
> cache entry parsing is the most expensive part, this yields some additional
> savings.

Nice.

> Test w/100,000 files    Baseline  Optimize V4    Extensions     Entries
> ----------------------------------------------------------------------------
> 0002.1: read_cache      22.36     18.74 -16.2%   18.64 -16.6%   12.63 -43.5%
>
> Test w/1,000,000 files  Baseline  Optimize V4    Extensions     Entries
> -----------------------------------------------------------------------------
> 0002.1: read_cache      304.40    270.70 -11.1%  195.50 -35.8%  204.82 -32.7%
>
> Note that on the 1,000,000 files case, multi-threading the cache entry parsing
> does not yield a performance win.  This is because the cost to parse the
> index extensions in this repo, far outweigh the cost of loading the cache
> entries.
> ...
> The high cost of parsing the index extensions is driven by the cache tree
> and the untracked cache extensions. As this is currently the longest pole,
> any reduction in this time will reduce the overall index load times so is
> worth further investigation in another patch series.

Interesting.

> One option would be to load each extension on a separate thread but I
> believe that is overkill for the vast majority of repos.  Instead, some
> optimization of the loading code for these two extensions is probably worth
> looking into as a quick examination shows that the bulk of the time for both
> of them is spent in xcalloc().

Thanks.  Looking forward to block some quality time off to read this
through, but from the cursory look (read: diff between the previous
round), this looks quite promising.
