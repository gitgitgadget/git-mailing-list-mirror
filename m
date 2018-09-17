Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23F941F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeIRDBr (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:01:47 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:52093 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRDBr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:01:47 -0400
Received: by mail-wm1-f44.google.com with SMTP id y2-v6so211025wma.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KcS0Aif5j9pDbf+hIBHyX0C0jHzMJ3M4Dx922PDZb1M=;
        b=cmzPBpEb/8kxH27KKQEmonAWqWSiqmNz0w+7OiXY45UZ3v6MDhHlT94aHEPvANnY00
         GxD7cuSsrCyBVSbXsU4W+6VflHhzjVBqfwhBIwJNtmHMKet1BByktERWJqhpesWAKXem
         bmRJA2P6+4GGnwhnqrJiAcvx9L27q7nhBiYxVlU2BAuBIDttsyZvb95/o6rZ59/+mmbF
         xyPyKXcis3Kj5IUHWSfLWE+/vPtydP9zthgOgwtzwsLeaMpnad+eBj9irVQ9w1QJxPFO
         ujiFupr9/4SGgQiw44mNUC89EPIrd53qZb4Pp59lMFjmonSQLC8k3VmdSNv0m2cRyZuh
         7F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KcS0Aif5j9pDbf+hIBHyX0C0jHzMJ3M4Dx922PDZb1M=;
        b=GrnISuwMM43VB1QnX/L+Kf9Sr1z4MHj7GIQ0ljgXwLJNTbfBz9UKDVofJf10RVoUZw
         BpaXaGh5Jn4Ka+nSLz/W3FIcIiw/xvsDIJvK8BbRF+Ellrzbe8dsYSgpVlzq6fHSgnk1
         1B01TqtnUQXgWcYlURTHRYVSq392H4bfsj6JagYZRchAC3XsxTT6TPEvt6toqZjUY/6a
         KJ1nigAFYvKbECHVI0DJVA0iKaYPyaQgpDCXFOTtM+k3hRR2TKskDRTL2UgLEl+N+6tq
         7fkcSFZk8Dod+7AlbOPU+o3sEtsmWkmq7eXAAafSPyb5CJxQle5w2j07ebUv5E7XtKA+
         sgvw==
X-Gm-Message-State: APzg51A7LPYpIk5kNRo7GidgmwPk/eajb5j5we4Be1Rrf0l7qXDu2Aq+
        +gBjUC6DQuQw4Ygv2TpbmRI=
X-Google-Smtp-Source: ANB0VdaV+X7REORg8Rm2WQQOxNiVemRx3Zg2Z8DRz65/MB8rB4hFRotQtE6ogdqbLvzRcT/+hFLo4Q==
X-Received: by 2002:a1c:bb85:: with SMTP id l127-v6mr12813763wmf.156.1537219957360;
        Mon, 17 Sep 2018 14:32:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o15-v6sm16148893wru.23.2018.09.17.14.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 14:32:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v5 2/5] read-cache: load cache extensions on a worker thread
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180912161832.55324-1-benpeart@microsoft.com>
        <20180912161832.55324-3-benpeart@microsoft.com>
        <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com>
Date:   Mon, 17 Sep 2018 14:32:35 -0700
In-Reply-To: <CACsJy8ATsS6S5zib2FqJf1stPcGwSTO1qYBSz514Xu2GfJ4Apw@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 15 Sep 2018 12:22:02 +0200")
Message-ID: <xmqqh8in6c98.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> diff --git a/read-cache.c b/read-cache.c
>> index 858935f123..b203eebb44 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -23,6 +23,10 @@
>>  #include "split-index.h"
>>  #include "utf8.h"
>>  #include "fsmonitor.h"
>> +#ifndef NO_PTHREADS
>> +#include <pthread.h>
>> +#include <thread-utils.h>
>> +#endif
>
> I don't think you're supposed to include system header files after
> "cache.h". Including thread-utils.h should be enough (and it keeps the
> exception of inclduing pthread.h in just one place). Please use
> "pthread-utils.h" instead of <pthread-utils.h> which is usually for
> system header files. And include ptherad-utils.h unconditionally.

All correct except for s/p\(thread-utils\)/\1/g;
Sorry for missing this during my earlier review.

Thanks.


