Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8171F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936412AbeF2BLI (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:11:08 -0400
Received: from avasout07.plus.net ([84.93.230.235]:59907 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935665AbeF2BLF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:11:05 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id YhwCf6O64jlDzYhwDfMRc4; Fri, 29 Jun 2018 02:11:04 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=NxsfUQ8XkgfFYnwsQnIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
 <20180628114912.GA12901@sigill.intra.peff.net>
 <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
 <20180628174501.GC31766@sigill.intra.peff.net>
 <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
 <20180628220332.GA5128@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <9162ed69-d245-8b2f-0dcc-3b345264b029@ramsayjones.plus.com>
Date:   Fri, 29 Jun 2018 02:10:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628220332.GA5128@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPxfZfPxiU6vlu21omLwwAWihp60dq0I6iWnDkuSLeMeVMpVlj7cR2YZ6HRbGafQa6iEqVnJdp1kqMbORiWpPuG6KKvmvtkvGlrn9sNzg86DDfH6bCSg
 Zj/yIr656iDhOOvz9bDotCs2jhj2YdQOFP1rbWGheJP/pLdpfyLyTFgx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/06/18 23:03, Jeff King wrote:
> On Thu, Jun 28, 2018 at 07:53:27PM +0100, Ramsay Jones wrote:
[snip]
> Yes, it can go in quickly. But I'd prefer not to keep it in the long
> term if it's literally doing nothing.

Hmm, I don't think you can say its doing nothing!

    "Yeah, this solution seems sensible. Given that we would
     never report any error for that blob, there is no point
     in even looking at it."

... is no less true, with or without additional patches! ;-)

> I have some patches which I think solve your problem. They apply on
> v2.18.0, but not on v2.17.1 (because they rely on Dscho's increased
> passing of config_options in v2.18). Is that good enough?

Heh, I was also writing patches to address this tonight (but
I was also watching the football, so I was somewhat behind you).
My patches were not too dissimilar to yours, except I was aiming
to allow even do_config_from_file() etc., to suppress errors.

Your patches were cleaner and more focused than mine. (Instead of
turning die_on_error into an enum, I added an additional 'quiet'
flag. When pushing the stack (eg. for include files), I had to
copy the quiet flag from the parent struct, etc, ... ;-) ).

> Yes, it would include any syntax error. I also have a slight worry about
> that, but nobody seems to have screamed _yet_. :)

Hmm, I don't think we can ignore this. :(

> Here are the patches I came up with.

Yes, I applied these locally and tested them. All OK here.

So, FWIW, Ack!

[I still think my original patch, with the 'to_be_skipped'
function name changed to 'object_on_skiplist', should be
the first patch of the series!]

ATB,
Ramsay Jones
