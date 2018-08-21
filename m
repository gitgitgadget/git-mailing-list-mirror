Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51EF61F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeHUWzu (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:55:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34222 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeHUWzu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:55:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so6762028wrd.1
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 12:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l4KsR6aDgm1QPnzKcOTBer3e/cIkDk6f9fAYoHSm5zQ=;
        b=Zsdi36BQxABRkjUVkykJPO1jOFrs9tgauYTkvqxutBcMCS3eHb3sXAD47eersM0Pk7
         38QFiCSVIvBKOCO65t6WQ8648EOlX5dw2Ao8Gf5uUfO55m9FKCDj+TMDe8TMKsnb+NPB
         /hkkWcoV9RaqkjS1fIPhuh93Mxl4aXKkjZhxdDKBPr8hGEJH8C11Rep7KiKmKnCKFft4
         rLyRttjB4xbEiG2Mxwh2O6pgNsuwGYDs+Ue5OirB6Rc3ZZyeotTshbSKtPE0I65EHpyX
         lvI2goJCktmMv0mUWRUMoL+g8xErZ44DAi/U/RAu1QlSjLhMg6W4tvMuhv/uxMt7fH6a
         2NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l4KsR6aDgm1QPnzKcOTBer3e/cIkDk6f9fAYoHSm5zQ=;
        b=mPjx5tiV6TJInNDVwX+HBitoKCaUgZqIrZ31lr0dvhvjz7HCD0fouSpwVN8hiXsCSP
         eAV3hpDaEFHCq5Ar2o1b6NeZP24URJ1dLxlI88VsFLpQu5gmA0lcwVH5P/kIu8Vf1PYP
         +Iaha8TWNrvo8GDFCV+oMgo6f+l+3r8UC+o2fovsXDYJMd/fieXwDbSGOAz5Y78eiTE5
         pqq22uxqH0fF91dVylnlpSZR43Xf950DjGF/hUQfznThpxQYCQtSnYAhr/JKPNikRbXS
         ntugYDDZEsg9jM8xq1ZmOtemIvMU7ir42k3Kz9LFnda3jRPW6hO0pSHK4HPCkyY8lktz
         zNEA==
X-Gm-Message-State: AOUpUlGiNoEFm9vIZnoPs04Ca5zdRYzIiLbRqvUoglvW0TH+abVWxQaE
        LAS0OKW/jXWpNsz9CgJ9dls=
X-Google-Smtp-Source: AA+uWPyBlrC/agExvFuW6fZZ6rcXeoDh9h2/kr/B6U3UUzd4g1gcwrag5mBFY4lW431iGwTYoHJopA==
X-Received: by 2002:adf:dd07:: with SMTP id a7-v6mr31734623wrm.2.1534880060530;
        Tue, 21 Aug 2018 12:34:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l6-v6sm5351986wrq.76.2018.08.21.12.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 12:34:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/6] reuse on-disk deltas for fetches with bitmaps
References: <20180817205427.GA19580@sigill.intra.peff.net>
        <20180821190622.GA30301@sigill.intra.peff.net>
Date:   Tue, 21 Aug 2018 12:34:18 -0700
In-Reply-To: <20180821190622.GA30301@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 21 Aug 2018 15:06:22 -0400")
Message-ID: <xmqqo9dv8qf9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Aug 17, 2018 at 04:54:27PM -0400, Jeff King wrote:
>
>> This series more aggressively reuses on-disk deltas to serve fetches
>> when reachability bitmaps tell us a more complete picture of what the
>> client has. That saves server CPU and results in smaller packs. See the
>> final patch for numbers and more discussion.
>
> Here's a v2, with just a few cosmetic fixes to address the comments on
> v1 (range-diff below).
>
>   [1/6]: t/perf: factor boilerplate out of test_perf
>   [2/6]: t/perf: factor out percent calculations
>   [3/6]: t/perf: add infrastructure for measuring sizes
>   [4/6]: t/perf: add perf tests for fetches from a bitmapped server
>   [5/6]: pack-bitmap: save "have" bitmap from walk
>   [6/6]: pack-objects: reuse on-disk deltas for thin "have" objects

Thanks.

> 1:  89fa0ec8d8 ! 1:  3e1b94d7d6 pack-bitmap: save "have" bitmap from walk
>     @@ -69,6 +69,8 @@
>      +
>      +	if (!bitmap_git)
>      +		return 0; /* no bitmap loaded */
>     ++	if (!bitmap_git->result)
>     ++		BUG("failed to perform bitmap walk before querying");
>      +	if (!bitmap_git->haves)
>      +		return 0; /* walk had no "haves" */
>      +

The first four are unchanged, so this actually compares 5/6 of the
previous and the current one.  Omitting the four identical ones
makes sense, but I wonder if it makes it easier to see if we keep
the number-label of the surviving patches.

> 2:  f7ca0d59e3 ! 2:  b8b2416aac pack-objects: reuse on-disk deltas for thin "have" objects

