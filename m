Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F661C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 21:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF966103A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 21:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhHWVsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 17:48:16 -0400
Received: from mout02.posteo.de ([185.67.36.66]:56899 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232503AbhHWVsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 17:48:14 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 703E7240103
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 23:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1629755249; bh=Z9/bA358mtvLvr4yugxkVaGaPOLj+psXgwOT+Eq5BQE=;
        h=Subject:To:Cc:From:Date:From;
        b=q8N8XipnMkc5QVipuh+CziIBBaZQqqeReWL/8XpI+bwwGxfMoK6yo5mUyed9VENjx
         tQGphswDWRaVUA1pnE1w+bCDK32ANJcbB/qrpkI5Yv3s6sFJx2JrvbTTlb4T3XFkH4
         8CH59hPFTO6lWMcQwaQAcuWteizlizZjrYnFcOfsm/7KC7Tjwf0Twd1jtlYnVkcJZn
         aq3Q2Mu2QmrpAkFZ3FTvd8+3AO0ml3O2GfSTKtcmzhmfTj3mPs0BDvkoG3LNfk5v2X
         UDxhfkPw7dgucMoEHyUWT91GDVDj+DfXsdwUYS1YTcUFyleN5Wp6oDdCTD5IQ7vPZP
         2YK2/dMLeLxOQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Gtm746RkSz6tmN;
        Mon, 23 Aug 2021 23:47:28 +0200 (CEST)
Subject: Re: [BUG] send-email propagates "In-Reply-To"
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <4db7759c-2123-533b-9f89-954c07f5832a@posteo.de>
 <YSPOOGxTMEgStdjJ@coredump.intra.peff.net>
 <5cd5a58b-ac9e-4628-a8d3-836b1f795732@posteo.de>
 <YSPomC95hxZZTHRe@coredump.intra.peff.net>
From:   =?UTF-8?Q?Marvin_H=c3=a4user?= <mhaeuser@posteo.de>
Message-ID: <2412df60-f8ee-ab0f-08b2-20a0b6b641fa@posteo.de>
Date:   Mon, 23 Aug 2021 21:47:28 +0000
MIME-Version: 1.0
In-Reply-To: <YSPomC95hxZZTHRe@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/08/2021 20:27, Jeff King wrote:
> But either that should go into its own patch, or the commit message
> should be modified to explain that it is covering not just
> in-reply-to/references, but we think this fixes all similar variables.

Fixed, opted for latter [1].

> You'd want something like the patch below (and possibly something
> similar for the $subject handling).

Thanks a lot! my last question for the patch would now be, how do I use 
your snippet? Do I add you to S-o-b of the single patch, do I split the 
patches with the second S-o-b being yours, or do I submit only the first 
and you will submit the second?

> Both of the new tests fail without your patch and pass with it, but:
>
>    - note the weird behavior I found with --in-reply-to; this is
>      something we might want to address at the same time

I think this case must error? The definition of the "--in-reply-to" does 
not declare it as a default, so it must be enforced (and it is), but 
it's also very unintuitive the file value is discarded. Who would decide 
the behaviour spec?

>    - applying your patch fails the earlier t9001.52 ("In-Reply-To without
>      --chain-reply-to"). I didn't dig into what's going on there.

Fixed [1].

Best regards,
Marvin


[1] 
https://github.com/mhaeuser/git/commit/5f2ff790cc0d0d779bc252b08f9c9c632c4ff01c
