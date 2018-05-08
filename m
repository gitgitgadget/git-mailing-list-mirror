Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B827D200B9
	for <e@80x24.org>; Tue,  8 May 2018 01:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeEHBH5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 21:07:57 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:40188 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753569AbeEHBH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 21:07:56 -0400
Received: by mail-wr0-f175.google.com with SMTP id v60-v6so30501943wrc.7
        for <git@vger.kernel.org>; Mon, 07 May 2018 18:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=650yvKSd5WpvWHR288IEwS5nid6beGDccvhGuGwDV3w=;
        b=YeEKQ1fR/aFUKzk/Qr7xD2581kNH9BkWvShXSnAcl/J4h/PfubPw2jY4AOtpGJICTC
         XHTcK/lqlt979rlgfIjAt15HJs5DTEY2Ha2rJhA/8ZecmuVEOBVMZzQOYGVCyVTjDSto
         3qG5XeRq70I/CqSdXdJ1j6/bIO4u+LpATcksDeiujf9uxWZvi/4TqYDdPnh5XihSJjee
         W8CMDvXxnhZqiUIXfZtnA5X0VUmiHOmw4L0Ir/hwaV92uHcSONrAszMBkSPNqjwqSseZ
         tZNuT3EZmtJ+J4yhzc1eX2I9Y1u8uBd+Hj1F7trdTCB8g4Sj5LIkte1qZ7GUToSocfHY
         TkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=650yvKSd5WpvWHR288IEwS5nid6beGDccvhGuGwDV3w=;
        b=K/JEt2pCAPMxWZKZQ7/QcPCXeRwil7MGnyw65UsUegoAg5MUEIvrwTGEL7n372Nf2F
         vjjGmro7Zeh2mKTzi1s3VWPZzLQe4iN+/2e4L2JFLkgT8S7YmsQDc+UWyx/oE9B+Alo2
         32ihWiO+VtOnCcyXHtznGpEljCMywAy8YfdNOwZoNH7KGb4jNuSMQWEZ296ZMHK1JGMo
         iGOfDKf7DyNAM8ySCJ2nq3cxQsb36VZmcCE9uesOWoKeRluv/FUrWnU0c4PGqixWh+7V
         yb7W6eNZOKg4ygpy3xltSE4o8UpwyOqh/318fEf/NJ4oaT49dJgLnqjda/3tiPntegb8
         AVcw==
X-Gm-Message-State: ALQs6tDONt4iHuaDSunF5yoKpfyjLGvEIfNTN/f/cSyvUR8UVCacQ1pG
        bMvmWsIA2W1hObbMmbQ60UM=
X-Google-Smtp-Source: AB8JxZpPMveIfH0vrHWDOWA7HdCbfKZlWWf23O9Twxehj5TPn/ir77Acpyzx30jb76ga2yaqDmC8Pw==
X-Received: by 2002:adf:988c:: with SMTP id w12-v6mr30050210wrb.215.1525741675287;
        Mon, 07 May 2018 18:07:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u36-v6sm36090863wrf.87.2018.05.07.18.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 18:07:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jameson Miller <jamill@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] alloc.c: replace alloc by mempool
References: <BL0PR2101MB1106BA184260609DA69988A6CE870@BL0PR2101MB1106.namprd21.prod.outlook.com>
        <20180503221802.61110-1-sbeller@google.com>
        <CACsJy8De2SUGj9hgq3h7pODm=9Wn+TkCKfJjrm1c=UxS9BZvTA@mail.gmail.com>
        <xmqqsh73nfta.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbC1f856Pbf-Uucdr-FnNemjTTb07RiECBMDW2ZTA2xDA@mail.gmail.com>
Date:   Tue, 08 May 2018 10:07:54 +0900
In-Reply-To: <CAGZ79kbC1f856Pbf-Uucdr-FnNemjTTb07RiECBMDW2ZTA2xDA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 7 May 2018 17:44:36 -0700")
Message-ID: <xmqqd0y7nedx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The replacement with mem-pool might be easier than making sure
> that alloc.c has no globals and handles allocations per repository
> correctly. It would make the sb/object-store-alloc series shorter than
> it currently is, and maybe easier to review the code.
>
> However now that sb/object-store-alloc is rerolled with keeping
> the logic of alloc.c and not replacing it with mem-pool, the only
> reason would be ease of maintainability by less code

That is sensible considertation; the patch should be sold as such,
instead of with an empty log message as if the reasoning is obvious
to everybody without being told ;-)
