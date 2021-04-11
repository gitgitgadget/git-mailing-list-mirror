Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A112C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2D4611CE
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhDKJOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 05:14:55 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:58068 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhDKJOw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 05:14:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id B367C40C45;
        Sun, 11 Apr 2021 11:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1618132475; x=1619946876; bh=/2HFS+cCYU04JmIzcVD
        +ElRcHW/WoI6wc88GBWAbEAo=; b=b04WENcsVAPfUWyG6857/nQBsGOnQfwA+AR
        h+3e/IWqACnAr7PFQSPOiA5vROKAsjLEOoOOhryxs9S0l2R10FfnP3qmEKswRu/j
        z9amp17GBjmb4je2UEAaTPj8/84nGV9YXxQ5HMIyfgbBPNZhbovpXc+bNi9/oTdJ
        hohy+iD908gwpW6rM3JlGy1RG2LcCnootlPyYsn65TUNbiuyHSo+9MZ9t/Iu82xl
        Zo5lklNSk3TAhCXyNLVY6qWut7RFv86cXGD9cA3/LRrhEUYKd+CFdpjZetx0Fcgy
        RbsAHuhcdOJqxQSZZJxwmv8yLjXDxbJGDZ4NwY4GtBIGCUg1tytqleI+pzauo1ut
        V/A6CpZLmbcf/BXmASDHtaT5QI/X7h8roJZZZG6BnptC80yYB3dEfppNuPQ8DzIG
        3SxGFS2iLwE/GJLFYQCrtgCmjyTseaLcAqotHdam9KjIrYu3N50HV1JwA77d2fa7
        JAVQDT1/32klMeGysYtyRO7SJaF5oNaT4Hwa90G3JjtLNn8KHC/ggtq3PcFbp1Qn
        kbEmDR7jnp97w053BVla/CsowaIUrjalWovIa+y2GhhacC28Y2o50DKjX1bjPxsZ
        UEWj9WvZvDqm4Qz7BVZoLuTdGdN3F5DuTeA4/2C342i6Zimy3anjygIuxLqQ0jGY
        1fgh3uSs=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zwLQguInzdcF; Sun, 11 Apr 2021 11:14:35 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 2238D40947;
        Sun, 11 Apr 2021 11:14:34 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 5B5BC3EC2;
        Sun, 11 Apr 2021 11:14:33 +0200 (CEST)
Subject: Re: [PATCH] merge-ort: only do pointer arithmetic for non-empty lists
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>
References: <pull.930.git.1618043449249.gitgitgadget@gmail.com>
 <1866b90b-fe07-18df-0d60-e2350d935375@web.de> <xmqq8s5pkav2.fsf@gitster.g>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <2cac1b8b-fe53-01c0-825c-0e10edb8a320@ahunt.org>
Date:   Sun, 11 Apr 2021 11:14:31 +0200
MIME-Version: 1.0
In-Reply-To: <xmqq8s5pkav2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11/04/2021 00:56, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> [...] >> Reading the diff I was wondering if QSORT now gets handed uninitialized
>> values if version-nr is 0.  The answer is no -- relevant_entries is
>> initialized at declaration.  Otherwise the compiler would have probably
>> warned, but sometimes it gets confused.
>>
>> I wonder why relevant_entries is introduced at all, though.  It's not
>> referenced later.  So how about this instead?
>>
>> 	if (versions->nr)
>> 		QSORT(versions->items + offset, nr, tree_entry_order);
>>
>> The intent to sort the last versions->nr-offset entries of versions,
>> but only if it's not empty, is easier to see like this, I think.
> 
> That does make sense.  I wonder if there needs some assertion to
> ensure that "offset" does not exceed "versions.nr", though.
> 

I think so - I will add the assertion. Following the original offset 
calculations is not trivial- which seems like a good enough reason for 
the assert.
