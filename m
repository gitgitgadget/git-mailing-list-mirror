Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD5C1F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 21:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbdH2VsM (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 17:48:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:52386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751440AbdH2VsL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 17:48:11 -0400
Received: (qmail 10330 invoked by uid 109); 29 Aug 2017 21:48:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 21:48:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14383 invoked by uid 111); 29 Aug 2017 21:48:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 17:48:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Aug 2017 17:48:09 -0400
Date:   Tue, 29 Aug 2017 17:48:09 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
Message-ID: <20170829214809.xxpsp76eqhd4hupo@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com>
 <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
 <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
 <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
 <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <CAN0heSomjqiSStq3eqGgCe21b0Pr0gbAQLL-2EEB6Zfnjj+Mjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSomjqiSStq3eqGgCe21b0Pr0gbAQLL-2EEB6Zfnjj+Mjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 09:22:08PM +0200, Martin Ågren wrote:

> One take-away for me from this thread is that memory-leak-plugging seems
> to be appreciated, i.e., it's not just an academic problem. I think I'll
> look into it some more, i.e., slowly pursue option 2. :-) That might help
> give some insights on how to identify interesting leaks.

Yes, I think if it's tractable that's the best path forward. It's not
clear to me how many of the things valgrind reports are false positives
(and in what way). Certainly the lock_file patch I just posted seems
like something worth addressing, even if we _tend_ to only leak a small
number of such structs per program invocation. It's not a problem now,
but it's a sign of a bad pattern.

-Peff
