Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E90B1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 21:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbeHIAEJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:04:09 -0400
Received: from gproxy10-pub.mail.unifiedlayer.com ([69.89.20.226]:55815 "EHLO
        gproxy10-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbeHIAEJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 20:04:09 -0400
X-Greylist: delayed 1919 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Aug 2018 20:04:08 EDT
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy10.mail.unifiedlayer.com (Postfix) with ESMTP id D6C0D140508
        for <git@vger.kernel.org>; Wed,  8 Aug 2018 15:10:41 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id nVj7frwbPvdTunVj7feVPF; Wed, 08 Aug 2018 15:10:41 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nHW15e9R02ff1Ky/Q+qb6Wfibk0W4olf8giZNCJ7Bpk=; b=acUsAf7DO+Fy+ZujPjp+/FxG8o
        rOTnUN85Je2OBxyrfhnv0ZUKl5jsavsKwL1TUFrXWBj1AbwjtjBO/BuhPab+LxWrUBeCtnuMu5oy0
        vc+1iFyqflzauFybxA5EwTho7;
Received: from [50.226.24.42] (port=33196 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1fnVj7-002Rd1-7D; Wed, 08 Aug 2018 15:10:41 -0600
Message-ID: <d5f07990ed810b62c3a7be54dbd5ba7febb4f2e7.camel@mad-scientist.net>
Subject: Re: Help with "fatal: unable to read ...." error during GC?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Wed, 08 Aug 2018 17:10:38 -0400
In-Reply-To: <20180808182436.GA19096@sigill.intra.peff.net>
References: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
         <20180808160612.GC1607@sigill.intra.peff.net>
         <b247434b62ccd30f32adbebb83fa6ea12b51b6ff.camel@mad-scientist.net>
         <20180808182436.GA19096@sigill.intra.peff.net>
Organization: I may be mad, but I'm a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 50.226.24.42
X-Source-L: No
X-Exim-ID: 1fnVj7-002Rd1-7D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [50.226.24.42]:33196
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2018-08-08 at 14:24 -0400, Jeff King wrote:
> Let's narrow it down first and make sure we're dying where I expect.
> Can
> you try:
> 
>   GIT_TRACE=1 git gc
> 
> and confirm the program running when the fatal error is produced?
> 
> From what you've shown it's going to be git-repack, but what I'm not
> clear on is whether it is repack itself that is complaining, or the
> pack-objects process it spawns. I'd guess the latter.

You are correct:

15:27:24.264161 git.c:415               trace: built-in: git pack-
objects --keep-true-parents --honor-pack-keep --non-empty --all --
reflog --indexed-objects --unpack-unreachable=2.weeks.ago --local --
delta-base-offset .git/objects/pack/.tmp-17617-pack

> If so, can you try running it under gdb and getting a stack trace?

I would... but I discovered all my Git binaries are stripped to the max
and no symbols available.

I'll do a quick rebuild with some debug info and get back to you.

Thanks for the pointers!
