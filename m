Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8271F462
	for <e@80x24.org>; Fri, 14 Jun 2019 20:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfFNUaZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 16:30:25 -0400
Received: from avasout04.plus.net ([212.159.14.19]:46454 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfFNUaY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:24 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id bsq5h2Hj4ticRbsq6hqA7D; Fri, 14 Jun 2019 21:30:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1560544223; bh=2rOmWNVywCNrHnPSduQxoXFSm31NLlCqoAGR9iUO5hs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mXDDLwgR0uBUxSRPgGSyFXYGZmTTDyN0+IqHmdgHj9A8yWw5KxIEUErFo4b7My5gM
         yI3c4AHb8j/C/JlxzNES00A2vUjkL3JPYAa/EOpJOv5TCQNBd3HrECg06BtU6ZIu9g
         oZSSjzhnv4gM6FzGnUnXWKCruqgYYyi9JuPqI4G6pSpEuu/wixL9osA2TP2c2XHEQR
         9Dajd2aeOdZMDfhBOyRvQ/C43CxYqyPu5/isrzR/aYh3N+iuAeJ/jibzIUSKHdCXeq
         z8DKT+HWZ6yA2VIp2/NidnH7eSBSkTRgcouRIGq1USBzqBQjf3r5SXqGU+CIOL0u4V
         kSi6qO/yCgZjA==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Gs88BX9C c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=FPFEPPMoXQQRYcvV6fEA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC/PATCH v1 0/4] compat/obstack: update from upstream
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20190614095308.GG31952@szeder.dev>
 <20190614100059.13540-1-szeder.dev@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <bd955bb3-626e-345d-550e-562027c2f7e6@ramsayjones.plus.com>
Date:   Fri, 14 Jun 2019 21:30:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614100059.13540-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfERT+PGTJaIlSN8IhFywCzCA+J8ERAYXT9QjDEfsRRXPRR686yYuoZ9+kPp4wHzLjlRKrQWiqWqzfnOW7NzFafOu11kAk/fC8oafgmniZ2KPchc87byV
 kyJ8qhcevZt4pTKXqMH6aHpaW6vgPj0UKf74EIiTov0AhjcCh+JXtiszbUpj4NpKBZhKmCrGCGsKSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/06/2019 11:00, SZEDER Gábor wrote:
> Update 'compat/obstack.{c,h}' from upstream, because they already use
> 'size_t' instead of 'long' in places that might eventually end up as
> an argument to malloc(), which might solve build errors with GCC 8 on
> Windows.
> 
> The first patch just imports from upstream and doesn't modify anything
> at all, and, consequently, it can't be compiled because of a screenful
> or two of errors.  This is bad for future bisects, of course.
> 
> OTOH, adding all the necessary build fixes right away makes review
> harder...
> 
> I'm not sure how to deal with this situation, so here is a series with
> the fixes in separate patches for review, for now.  If there's an
> agreement that this is the direction to take, then I'll squash in the
> fixes in the first patch and touch up the resulting commit message.
> 
> 
> Ramsay, could you please run sparse on top of these patch series to
> make sure that I caught and converted all "0 instead of NULL" usages
> in the last patch?  Thanks.

I applied your patches to current master (@0aae918dd9) and, since
you dropped the final hunk of commit 3254310863 ("obstack.c: Fix
some sparse warnings", 2011-09-11), sparse complains, thus:

  $ diff sp-out sp-out1
  27a28,30
  > compat/obstack.c:331:5: warning: incorrect type in initializer (different modifiers)
  > compat/obstack.c:331:5:    expected void ( *[addressable] [toplevel] obstack_alloc_failed_handler )( ... )
  > compat/obstack.c:331:5:    got void ( [noreturn] * )( ... )
  $ 

So, yes you did catch all "using plain integer as NULL pointer"
warnings! :-D

Thanks.

ATB,
Ramsay Jones
