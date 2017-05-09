Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FC02018D
	for <e@80x24.org>; Tue,  9 May 2017 22:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdEIWvy (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 18:51:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33955 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdEIWvx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 18:51:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id u187so1651792pgb.1
        for <git@vger.kernel.org>; Tue, 09 May 2017 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+9Ox2MeXTWnPUCfcbxSk8mcb4878tnpCys8ND90dyr0=;
        b=lSMwpt9UrwqNTmrfc91bmLl7ydn6e3Q66f/g8veCaoBHB2HQWuZWAnzFvhnFjt+Cey
         7gjkr8D3YuBlL0OfnSK277y/gPZhXX6HuysUnlaVHm7u+9p4Uw4wbVj4PB+Ozgv8jPF8
         pyWH7jXW1m77cFdmazc6DS375IN7fh95e0xHwJsAeq+VOQ6NQr3NenlsOMWB6jbOPXzR
         Eu7AJXcJtK3QqKpFt5Y8of1BYjVXvPCrR9iuMmcUa4Y/YLNC4XZED+1hPXZXe4790AKt
         1VqRh660UTLWdkG8vRBOB/nkn6umqHBidy99J4eTzXVEQsAf6NXkj67yrSQJgvk0VInt
         VKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+9Ox2MeXTWnPUCfcbxSk8mcb4878tnpCys8ND90dyr0=;
        b=Nlq17k/zwKUIGWES1pgvo7tnNV5+/xfjfLNE5t06odBXjkj22wI2FVsMc9BZa/bhAI
         YH/WqfPJf9XgfQmJzS32eRQvyjiYySDrEB6YJJdUmA0L6YTmeVyf9GHf+iluqUjwmraS
         K7X58x4YvtvL8M4ECzSH6QCJd6GgJHQbe4nyLY4j58GqKPdAqBn5OKpB4EJVktY9tkTa
         q+vU3cLyvWC6x6tXrtM3iLtj3Zgzkd0Hi+bvMECitLBrIt9Nb2WGMWd/S8QpUbtdAU44
         20Z/u7grykq+eg9b3bk26q+Hq8JLAmhz5IFf3HLESJzSiIhDRx/EhV67SmTDjQsEqpF1
         B0gA==
X-Gm-Message-State: AODbwcAgekA7MT9GCexM6PmcaY4mMte5e5mDVNzkAnQuPtE5UJip9aLf
        Q0LV7thkj60vWg==
X-Received: by 10.98.13.220 with SMTP id 89mr2664755pfn.112.1494370312570;
        Tue, 09 May 2017 15:51:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id i15sm1912189pfj.51.2017.05.09.15.51.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 15:51:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 11/25] checkout: fix memory leak
References: <cover.1493740497.git.johannes.schindelin@gmx.de>
        <cover.1493906084.git.johannes.schindelin@gmx.de>
        <2704e145927c851c4163a68cfdfd5ada48fff21d.1493906085.git.johannes.schindelin@gmx.de>
        <36a581f6-077e-ca89-49d0-ad487ff222a3@web.de>
        <xmqqk25sch89.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705091540130.146734@virtualbox>
Date:   Wed, 10 May 2017 07:51:51 +0900
In-Reply-To: <alpine.DEB.2.21.1.1705091540130.146734@virtualbox> (Johannes
        Schindelin's message of "Tue, 9 May 2017 15:42:17 +0200 (CEST)")
Message-ID: <xmqq4lwt1w54.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > A leak is better than a use after free, so
>> > let's be extra careful here.  Would it leave the index inconsistent?  Or
>> > perhaps freeing it has become safe in the meantime?
>> >
>> > @Junio: Do you remember the reason for the leaks in 0cf8581e330
>> > (checkout -m: recreate merge when checking out of unmerged index).
>> 
>> Yes.
>> 
>> In the very old days it was not allowed to free(3) contents of
>> active_cache[] and this was an old brain fart that came out of
>> inertia.  We are manufacturing a brand new ce, only to feed it to
>> checkout_entry() without even registering it to the active_cache[]
>> array, and the ancient rule doesn't even apply to such a case.
>> 
>> So I think it was safe to free(3) even back then.
>
> So this patch is good, then?

Unless I from this year is failing to spot a breakage that will be
caused in the codepath that I from year 2008 and René spotted, I
think freeing ce after we are done updating the working tree file
with it is safe.  I'd need to find time to make sure, though.

>> > And result_buf is still leaked here, right?
>> 
>> Good spotting.  It typically would make a larger leak than a single
>> ce, I would suppose ;-)
>
> I saw you added this as a fixup! commit. If you don't mind, and if no
> other changes are requested, would you mind rebase'ing this yourself?

I think it would be better to leave the fix as a separate patch.  It
wasn't spotted by Coverity in the first place ;-)
