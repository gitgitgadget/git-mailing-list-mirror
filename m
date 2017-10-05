Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6562C2036B
	for <e@80x24.org>; Thu,  5 Oct 2017 11:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbdJELMw (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 07:12:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:33498 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751755AbdJELMw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 07:12:52 -0400
Received: (qmail 19914 invoked by uid 109); 5 Oct 2017 11:12:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 11:12:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27299 invoked by uid 111); 5 Oct 2017 11:12:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 07:12:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 07:12:49 -0400
Date:   Thu, 5 Oct 2017 07:12:49 -0400
From:   Jeff King <peff@peff.net>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, jrnieder@gmail.com,
        gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 1/2] entry.c: update cache entry only for existing
 files
Message-ID: <20171005111249.4fdezbjnysb6t2zm@sigill.intra.peff.net>
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
 <20171005104407.65948-2-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171005104407.65948-2-lars.schneider@autodesk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 12:44:06PM +0200, lars.schneider@autodesk.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> In 2841e8f ("convert: add "status=delayed" to filter process protocol",
> 2017-06-30) we taught the filter process protocol to delay responses.
> 
> That means an external filter might answer in the first write_entry()
> call on a file that requires filtering  "I got your request, but I
> can't answer right now. Ask again later!". As Git got no answer, we do
> not write anything to the filesystem. Consequently, the lstat() call in
> the finish block of the function writes garbage to the cache entry.
> The garbage is eventually overwritten when the filter answers with
> the final file content in a subsequent write_entry() call.
> 
> Fix the brief time window of garbage in the cache entry by adding a
> special finish block that does nothing for delayed responses. The cache
> entry is written properly in a subsequent write_entry() call where
> the filter responds with the final file content.

Nicely explained and the patch looks correct. I also verified that MSan
is happy with t0021 after this.

Thanks for the quick turnaround.

-Peff
