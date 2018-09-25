Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A511F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbeIZET2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:19:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36644 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeIZET2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:19:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id l10-v6so1750989wrp.3
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3Ad5Wc5FEnAM2KQLiQrF6olS4Aw4GmxtkT7rr+5aUQI=;
        b=eMxSHm/wfogVkk2PzgDtIAHH5dE2UaeOqYxUAypEu/98sX37y2qE/PapiK8khY/m5E
         RhwMg2WpdQDB5XfZIjZldLCok+JSdXJAe+PfE5wJE6B/ABdZYLOJTmm7RF4r6Up1nn66
         6s/omEhYdO9SOb95KQO81yiIsVwo+fUA4IO4Z083WWnfPf25ueRh2Jzau3dMkmEUdAJU
         REYBwOQFySymWp/c26GrAQEPo1e98SdcCHwM3Ewz9p0xlZe9AL8eM9cQiXISZvgfZBfb
         bpNIl9RruiptL/Nx83Yx/fl5eUeY9+sKgsiNY9Pu6XM3cklNlYVys/P3Sm3syzR5bcfm
         Hyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3Ad5Wc5FEnAM2KQLiQrF6olS4Aw4GmxtkT7rr+5aUQI=;
        b=S6GghvKkfJHpzEprY55bP4S3NlhY+toHnLnFmlC7VjxZdS21FrDXXWIQWqGghJ5ulj
         oENYpvGpAOw+lqYJh5WZFS1dI8F6KedtCJcRL3r+RMajMbQg7jCdyHjvV1/G9PXVjqfC
         OKm9Mz8nV40u3ZTLnFqTL4jKCUB4n6zw2TAuSsKQ1ZO6ZdBb9RMh3V+ijdKUcxiI2WQJ
         fT9vSL/7fry0XHsxm6zQ7Uuv/Wct6OZ4E1+J1RBiYUPBeo0H9nS9YuEzhoH8LECLNN1D
         fSUUxxawkr+tvsoq92g1d95WJQJja4svYpAeCzDfNyJYAvkrpJMCWNDYaW4KXyjrW+Em
         vcQQ==
X-Gm-Message-State: ABuFfoiexuVe1yVUKJGTiVUNLgHuS1hbMR089GZtnp7rntDm0Ip8xVpW
        HNdbzIBFOqyW+orM0NstZQtvn3Nz
X-Google-Smtp-Source: ACcGV606d0+MFWEVd8X4TZVgsCN+ROatb2Xq/ch56BMGedVkDj0myhUrSH7vWvR5/ATZgLRHa2tITQ==
X-Received: by 2002:adf:fe48:: with SMTP id m8-v6mr2710572wrs.171.1537913386726;
        Tue, 25 Sep 2018 15:09:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k7-v6sm3497676wmf.41.2018.09.25.15.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 15:09:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: approximate no_dependents with filter
References: <20180924154516.48704-1-jonathantanmy@google.com>
Date:   Tue, 25 Sep 2018 15:09:45 -0700
In-Reply-To: <20180924154516.48704-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 24 Sep 2018 08:45:16 -0700")
Message-ID: <xmqqh8idns9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Whenever a lazy fetch is performed for a tree object, any trees and
> blobs it directly or indirectly references will be fetched as well.
> There is a "no_dependents" argument in struct fetch_pack_args that
> indicates that objects that the wanted object references need not be
> sent, but it currently has no effect other than to inhibit usage of
> object flags.
>
> Extend the "no_dependents" argument to also exclude sending of objects
> as much as the current protocol allows: when fetching a tree, all trees
> it references will be sent (but not the blobs), and when fetching a
> blob, it will still be sent. (If this mechanism is used to fetch a
> commit or any other non-blob object, all referenced objects, except
> blobs, will be sent.) The client neither needs to know or specify the
> type of each object it wants.
>
> The necessary code change is done in fetch_pack() instead of somewhere
> closer to where the "filter" instruction is written to the wire so that
> only one part of the code needs to be changed in order for users of all
> protocol versions to benefit from this optimization.

It is very clear how you are churning the code, but it is utterly
unclear from the description what you perceived as a problem and why
this change is a good (if not the best) solution for that problem,
at least to me.

After reading the above description, I cannot shake the feeling that
this is tied too strongly to the tree:0 use case?  Does it help
other use cases (e.g. would it be useful or harmful if a lazy clone
was done to exclude blobs that are larger than certain threshold, or
objects of all types that are not referenced by commits younger than
certain threshold)?

