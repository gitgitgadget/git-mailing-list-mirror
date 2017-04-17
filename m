Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AD881FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 07:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbdDQH7e (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 03:59:34 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:29493 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932413AbdDQH7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 03:59:33 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w60z665n8z5tlG;
        Mon, 17 Apr 2017 09:59:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DB95B42B6;
        Mon, 17 Apr 2017 09:59:29 +0200 (CEST)
Subject: Re: [PATCH v3 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
 <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
 <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
 <33c63fb9-281c-8fd2-66e7-b85f62f4f447@web.de>
 <8555c61f-2617-eec8-6dbe-87c79c6ca302@suse.cz>
 <587b0cb9-bd66-ddf7-5cca-023df3470883@kdbg.org>
 <e392e05c-2815-8cfa-eed0-bd990f8ce954@web.de>
 <357d045a-b1c5-1a73-2256-839efb543fe3@kdbg.org>
 <96beb4c6-0569-0c12-8151-462c20be6a2a@suse.cz>
 <xmqqy3uzkdm4.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <930be745-944f-62f3-3d57-4f1cd6f2df66@kdbg.org>
Date:   Mon, 17 Apr 2017 09:59:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3uzkdm4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.04.2017 um 03:49 schrieb Junio C Hamano:
> "Something or NULL" is a name we use for a function that returns
> something (under normal circumstances) or returns NULL.  This
> wrapper is not about returning NULL at all, as far as I can see, and
> is misnamed.  If it is about "avoid moving 0 bytes", similar to how
> COPY_ARRAY() is used in the previous hunk, perhaps MOVE_ARRAY() is a
> better name?

It is not about "avoid moving 0 bytes", but "if we move 0 bytes, then we 
allow NULL pointers". Plain memmove/memcpy do not allow the pointers to 
be NULL even if the count is 0. It just so happens that the 
implementation of memmove_or_null that permits the relaxed condition 
looks like "avoid moving 0 bytes".

The name was my suggestion, but I agree that it is not the best name. 
[Sentence about two most difficult things in software engineering 
omitted for brevity.]

-- Hannes

