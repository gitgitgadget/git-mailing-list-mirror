Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960B320248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCMX2G (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:28:06 -0400
Received: from avasout01.plus.net ([84.93.230.227]:34834 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMX2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:28:06 -0400
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 4DI4hNt0BbKva4DI5h74BP; Wed, 13 Mar 2019 23:28:05 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cdb8UELM c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=EBOSESyhAAAA:8 a=u8HcVdbOHOBWDEO9eBYA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] packfile: use extra variable to clarify code in
 use_pack()
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
References: <a026ce9f-b825-7fc2-2ad5-c0b00bc508b4@ramsayjones.plus.com>
Message-ID: <027273d3-be3c-ca38-e13f-9387c14221fb@ramsayjones.plus.com>
Date:   Wed, 13 Mar 2019 23:28:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a026ce9f-b825-7fc2-2ad5-c0b00bc508b4@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDI4nlvU8f4RL4BpWAOFTD8ANGUHA8p9o7dhpeQ1s2EUO0vt/L4YDL0+YtQ2jJZwrUB333VDhyAFdX+izYy1KFZoB5VlB54xFGa37eL8WiGCjQ2G8crA
 Ao8RnlLM8X7C2WWw6pdKUFg7Blj2UvkXkL9cE+VmPtpgwGf/mfZNCuNX/IDpBjgze2uVXFhjV2/I/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/03/2019 21:49, Ramsay Jones wrote:
> From: Jeff King <peff@peff.net>
> 
> We use the "offset" variable for two purposes. It's the offset into
> the packfile that the caller provides us (which is rightly an off_t,
> since we might have a packfile much larger than memory). But later we
> also use it as the offset within a given mmap'd window, and that
> window cannot be larger than a size_t.
> 
> For the second use, the fact that we have an off_t leads to some
> confusion when we assign it to the "left" variable, which is a size_t.
> It is in fact correct (because our earlier "offset -= win->offset" means
> we must be within the pack window), but using a separate variable of the
> right type makes that much more obvious.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Junio,
> 
> As promised, I am forwarding a 'saved' patch from Jeff, which was
> a by-product of a long-ago discussion regarding commit 5efde212fc
> ("zlib.c: use size_t for size", 2018-10-14).
> 
> I have tested this patch on 'pu' (@6fd68134c8) and directly on top
> of commit 5efde212fc. (see branch 'mk/use-size-t-in-zlib').
> 
> However, whilst I have been waiting for the tests to finish, I have
> been looking at the code and concluded that this does not _have_ to
> be applied on top of commit 5efde212fc. (I haven't done it, but just
> tweak the context line to read 'unsigned long *left)' rather than
> 'size_t *left)' and this should apply cleanly to 'master'. Also, it
> would have _exactly_ the same effect as the current code! ;-) ).

I have now done:

  $ diff 0001-packfile-use-extra-variable-to-clarify-code-in-use_p.patch ttt.patch
  28c28
  <  		size_t *left)
  ---
  >  		unsigned long *left)
  $ 

... this and it applies cleanly to 'master', builds and passes tests.

Just FYI. ;-)

ATB,
Ramsay Jones

