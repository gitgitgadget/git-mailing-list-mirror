Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F0A1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 17:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeIGWD4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 18:03:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39923 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIGWDz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 18:03:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so15396315wmq.4
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iUEkqvbTtwVYfffdbdgUVl0BUz+d2TTfYh0N3JMdExk=;
        b=oDbxJrNicecnaD5SeQ0FoER0BUTpe+wvT4xcgomKJhbbOmus3vrlTBy8MLxkKle7X1
         Rgo1p3En6dbYt46suIl+cuGXpfY8cmqCR4nUeA2CiDfYvTVrAQzgxXSnRZRXJOOjz3DT
         Y5JIj8DE6NXSbW4Z0GUtfBiboJgVgrjTvKfpYp2iCwxGfw25qQE4rKTA9AP0Oy/78N4R
         wUQ9VCFGIwXa2tDxf1Ko1mwBj+2yy/5M2IMd7l5mvJ/HqEPUcYDnBIMIO4A1XDUtXWKv
         niQblX43b+KIQ1JXCkaD3uS3Pdu7TWjMWrVQVFPOkT/UEaSvN1go60/fRZhp9fADJu7g
         pAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iUEkqvbTtwVYfffdbdgUVl0BUz+d2TTfYh0N3JMdExk=;
        b=ucXhdgrPEYq6S+ZKPsVh+jZbzTxSERtHx/jQ479BxXmWUssG597Nz+8u5hlBwtlbKa
         GQ4uPk/p6ynwZdqfDz2Lgm/6O3XX8j8cpl58kMfdS/edQy3eL6J6nEG5LugfidpzsDBu
         K3Hj+vDVp8y4DD1Dn87umIREljjzUyN7XL+Mdpip5N1N0/VaOwoFPgbT3upbeapEw2rn
         njuUo9TRaTCENxtKyx5ER4vQiD/JsiSt1kpRIWackp+xt1PBFLTcMyTbp5NOASFlaYpC
         U4K4Xt9Hfj0XPUg5eQnEz+ph2tf6Xdjc+YXDwQT6a/hKXkVUv8iL45SC4H8L1Exx94E8
         7O7g==
X-Gm-Message-State: APzg51CZXbFXc+g9j/09QGbCK1veldTg3Wn0ED/kb4NKa3t6XbrPd0oR
        +BirigarhXfPrLeh8Tyu18U=
X-Google-Smtp-Source: ANB0VdZRlENHcdmfdipCBnTMb9W69vN3JCFxxxMkVtG75RRmHmbqKwHR82qn+nkuIX/0dZv1ZedxMQ==
X-Received: by 2002:a1c:5e08:: with SMTP id s8-v6mr6226107wmb.88.1536340919070;
        Fri, 07 Sep 2018 10:21:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h18-v6sm13075711wru.42.2018.09.07.10.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 10:21:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v3 0/4] read-cache: speed up index load through parallelization
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180906210227.54368-1-benpeart@microsoft.com>
Date:   Fri, 07 Sep 2018 10:21:57 -0700
In-Reply-To: <20180906210227.54368-1-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 6 Sep 2018 21:03:53 +0000")
Message-ID: <xmqq5zzhxlxm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> On further investigation with the previous patch, I noticed that my test
> repos didn't contain the cache tree extension in their index. After doing a
> commit to ensure they existed, I realized that in some instances, the time
> to load the cache tree exceeded the time to load all the cache entries in
> parallel.  Because the thread to read the cache tree was started last (due
> to having to parse through all the cache entries first) we weren't always
> getting optimal performance.
>
> To better optimize for this case, I decided to write the EOIE extension
> as suggested by Junio [1] in response to my earlier multithreading patch
> series [2].  This enables me to spin up the thread to load the extensions
> earlier as it no longer has to parse through all the cache entries first.

Hmph. I kinda liked the simplicity of the previous one, but if we
need to start reading the extension sections sooner by eliminating
the overhead to scan the cache entries, perhaps we should bite the
bullet now.

> The big changes in this iteration are:
>
> - add the EOIE extension
> - update the index extension worker thread to start first

I guess I'd need to see the actual patch to find this out, but once
we rely on a new extension, then we could omit scanning the main
index even to partition the work among workers (i.e. like the topic
long ago, you can have list of pointers into the main index to help
partitioning, plus reset the prefix compression used in v4).  I
think you didn't get that far in this round, which is good.  If the
gain with EOIE alone (and starting the worker for the extension
section early) is large enough without such a pre-computed work
partition table, the simplicity of this round may give us a good
stopping point.

> This patch conflicts with Duy's patch to remove the double memory copy and
> pass in the previous ce instead.  The two will need to be merged/reconciled
> once they settle down a bit.

Thanks.  I have a feeling that 67922abb ("read-cache.c: optimize
reading index format v4", 2018-09-02) is already 'next'-worthy
and ready to be built on, but I'd prefer to hear from Duy to double
check.

