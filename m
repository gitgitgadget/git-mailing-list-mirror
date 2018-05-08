Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DE0B200B9
	for <e@80x24.org>; Tue,  8 May 2018 00:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753650AbeEHAhJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 20:37:09 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37987 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeEHAhI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 20:37:08 -0400
Received: by mail-wr0-f193.google.com with SMTP id 94-v6so29169494wrf.5
        for <git@vger.kernel.org>; Mon, 07 May 2018 17:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qnXJbg1ScAuvAslwiyY7Dvdd92QvwLrff6jxIhW18W8=;
        b=dlCjpb7LjiCDyhAPloIHeNcx5talzm4C7NzPPNpRRa5+3NyCxvYOzBbiASjc27Pas9
         84L097fQOpQjYSmW+RJpOWJ1WyibkKFS2pvTs/gEdjcMBK4FyP9n1iYHCQTQaR+3EM9l
         pIPfuo+v45nnX6FmNuaZ9QUtL6jij5CJdGkheAvtu/wt8wHXYAH/5ST/L7zS78NDjOAB
         qTtYlvpBF8xR0dJXI4x6J7/Gx0UUeRNxtPLdXjFmTFWvX4ILQAb/c4HWzWSKtBZXA2td
         r3TO+EDDKqQEtZfmCt7xttCFLuErdIhGSWJx8RJYnrbBl7h45MPaPxrDOVNY5zynJ3JN
         1LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qnXJbg1ScAuvAslwiyY7Dvdd92QvwLrff6jxIhW18W8=;
        b=TS+k6hy3tpS3JxvoqFvhfxPcVuD/RwM4Fou82cEU0+vkEGAyr1TeXfW3Y3VY96Frlj
         xjnNxUC7pU8pNr7ezwsDw1G12s1vkrqjxL9ZojAaf1JiKNBFfZjBULQkhoTBI4+G7cmy
         lmUv46blz2qdjimgi0Y0cQrL1girHwVr5pyEcRe+NqRvFF8j5DrKL9lm2eaa2WbRaMWU
         YcV87paX+yJN/hkTcpXgg9AoSSW3zZd+QTGizO4TjjENksr4OolbPQM9TX4ff4+1yB79
         QX9JCKDSXejBiO5E4V4KLC4XHx1CgBAhhniOU/PQJrfIoixSl0ILsjOmGALIIt1Na05O
         eeHw==
X-Gm-Message-State: ALQs6tBD/j09BKiRTKsqlFuzT4wNYcXCDpdXqDbgpKiM6Ap9vPuMG3qz
        L0zHRe9wWKbzD5/cZF8eFDyK4gWuFuA=
X-Google-Smtp-Source: AB8JxZrZ8+Xx9wpOVbY33JGR1zLimQGDJrklzzg09wgHzDqK+JJoNT/s5NpRdtgkpFs5BED4b+mb0w==
X-Received: by 2002:adf:a317:: with SMTP id c23-v6mr20066823wrb.88.1525739826877;
        Mon, 07 May 2018 17:37:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w31-v6sm55348243wrb.93.2018.05.07.17.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 17:37:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jameson Miller <jamill@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] alloc.c: replace alloc by mempool
References: <BL0PR2101MB1106BA184260609DA69988A6CE870@BL0PR2101MB1106.namprd21.prod.outlook.com>
        <20180503221802.61110-1-sbeller@google.com>
        <CACsJy8De2SUGj9hgq3h7pODm=9Wn+TkCKfJjrm1c=UxS9BZvTA@mail.gmail.com>
Date:   Tue, 08 May 2018 09:37:05 +0900
In-Reply-To: <CACsJy8De2SUGj9hgq3h7pODm=9Wn+TkCKfJjrm1c=UxS9BZvTA@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 4 May 2018 18:33:52 +0200")
Message-ID: <xmqqsh73nfta.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> So I think we could just replace it for now and optimize again later, if it
>> turns out to be a problem. I think the easiest optimisation is to increase
>> the allocation size of having a lot more objects per mp_block.
>
> Yeah. I also tested this from a different angle: memory overhead. For
> 2M objects with one mp_block containing 1024 objects (same setting as
> alloc.c), the overhead (not counting malloc() internal overhead) is
> 46KB and we don't have any extra overhead due to padding between
> objects. This is true for all struct blob, commit, tree and tag. This
> is really good. alloc.c has zero overhead when measured this way but
> 46KB is practically zero to me.

Thanks.

The above in short sounds like arguing "replacing alloc.c internal
with mempool incurs negligible memory overhead and performance
degradation, but that can be optimized later".  It was unclear to me
why such a replacement needs to happen in the first place, though.
Without such a code churn, there won't be extra overhead or need to
fix it up later, no?
