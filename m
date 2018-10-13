Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40FF71F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 08:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeJMPlc (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 11:41:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55962 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeJMPlc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 11:41:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so14276864wmb.5
        for <git@vger.kernel.org>; Sat, 13 Oct 2018 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=v2IGQn+cLB23Z+3sW/1zf+X9XLz+qJb9FcDkis71dQw=;
        b=eBcnyPq8w5OpZJCd6L4fqDams4jdlNtFQ8tMqQPMW7IWPRj1RaHati0Ue9qn+rJzVx
         OW7YsrEPZOoHKKLtLwprUHHoNf2p1JhGY63ZVzgvSJByHD/NVlkju822ykSTu6uu87Ht
         Oga7NIFssVlKuvA5udf4sMVqeCo70xrzzwsZyUN/TmxvsiMzgEHdyQc5sl9pKT68LqXj
         Yy9E71rD1Zi5oZYk162zq3p80l/1Q08oL5Dyb0AHh0Ur6pBgJYbPsCnmIEdDJU7kwzoE
         wV3TanoS4VMvUvGTbi+/ovy4z9IMTMBdDwFBZxcqzzRDwOd0j70zxhU8zZS8Wzqa9wsW
         IiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=v2IGQn+cLB23Z+3sW/1zf+X9XLz+qJb9FcDkis71dQw=;
        b=M4SGQwhuq+7Lhm4s2Gz74OtysVKqnjkvNkoWN729BRpA/EN+SHj4fIkw3PYIVhlIvi
         qtZ9oJslAZBgA2VddvbsXtwSSPFvyfaZPn5zEMfG22Noeo12YCe5CpbP/qJCwI4HB54x
         hyk74Xe66PZwwaAV7XCUsMsLz5WGSzWXu1PixElg5Bv39FQoFrgZ5jdZULCzA7OWFiW7
         mGzTYEoMtHl9TZ5Zto/S4Uzt7PZUwy3gYPEvC57xnsGBcOX1X9X38zM8B9z1jfkxbxg0
         T3vfFz4X7xSShI1gp2hWikiw8a5pKp8BTUO47hefGZCCrOJa6uyejHPXt6yCHdVkWaUe
         GrpQ==
X-Gm-Message-State: ABuFfoiXAG8MFw+PslT77OfZSxrnWdoAlg/FRLcr0B4EjSpgKQNyMR6h
        I00iF04CoM6Z2hDfXr7N8QE=
X-Google-Smtp-Source: ACcGV60Nr0NMeXqB3zv9KVxEI5RJTtBvsgGi7x8llTDSCJLqD2KcF9tiBOP9ZY2ULCNanFdJFx6TDQ==
X-Received: by 2002:a1c:4d7:: with SMTP id 206-v6mr7768631wme.13.1539417919720;
        Sat, 13 Oct 2018 01:05:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e133-v6sm4503208wma.42.2018.10.13.01.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 01:05:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/7] revision.c: begin refactoring --topo-order logic
References: <pull.25.v2.git.gitgitgadget@gmail.com>
        <pull.25.v3.git.gitgitgadget@gmail.com>
        <fd1a0ab7cdaa06fd99f86fec51b483238f588296.1537551564.git.gitgitgadget@gmail.com>
        <xmqqwoqnbrmw.fsf@gitster-ct.c.googlers.com>
        <fa365691-e8ae-4aa8-5c76-b5c8c925c2f8@kdbg.org>
Date:   Sat, 13 Oct 2018 17:05:18 +0900
In-Reply-To: <fa365691-e8ae-4aa8-5c76-b5c8c925c2f8@kdbg.org> (Johannes Sixt's
        message of "Fri, 12 Oct 2018 18:15:24 +0200")
Message-ID: <xmqqva668e69.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 12.10.18 um 08:33 schrieb Junio C Hamano:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> +struct topo_walk_info {};
>>> +
>>> +static void init_topo_walk(struct rev_info *revs)
>>> +{
>>> +	struct topo_walk_info *info;
>>> +	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
>>> +	info = revs->topo_walk_info;
>>> +	memset(info, 0, sizeof(struct topo_walk_info));
>>
>> There is no member in the struct at this point.  Are we sure this is
>> safe?  Just being curious.
>
> sizeof cannot return 0. sizeof(struct topo_walk_info) will be 1 here.

Thanks.
