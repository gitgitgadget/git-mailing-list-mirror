Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2CF1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 06:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeCVGFo (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 02:05:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:38478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752004AbeCVGFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 02:05:44 -0400
Received: (qmail 28706 invoked by uid 109); 22 Mar 2018 06:05:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Mar 2018 06:05:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17726 invoked by uid 111); 22 Mar 2018 06:06:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Mar 2018 02:06:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2018 02:05:41 -0400
Date:   Thu, 22 Mar 2018 02:05:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2] routines to generate JSON data
Message-ID: <20180322060541.GA28476@sigill.intra.peff.net>
References: <20180321192827.44330-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321192827.44330-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 07:28:26PM +0000, git@jeffhostetler.com wrote:

> It includes a new "struct json_writer" which is used to guide the
> accumulation of JSON data -- knowing whether an object or array is
> currently being composed.  This allows error checking during construction.
> 
> It also allows construction of nested structures using an inline model (in
> addition to the original bottom-up composition).
> 
> The test helper has been updated to include both the original unit tests and
> a new scripting API to allow individual tests to be written directly in our
> t/t*.sh shell scripts.

Thanks for all of this. The changes look quite sensible to me (I do
still suspect we could do the "first_item" thing without having to
allocate, but I really like the assertions you were able to put in).

> So I think for our uses here, defining this as "JSON-like" is probably the
> best answer.  We write the strings as we received them (from the file system,
> the index, or whatever).  These strings are properly escaped WRT double
> quotes, backslashes, and control characters, so we shouldn't have an issue
> with decoders getting out of sync -- only with them rejecting non-UTF-8
> sequences.

Yeah, I think I've come to the same conclusion. My main goal in raising
it now was to see if there was some other format we might use before we
go too far down the JSON road. But as far as I can tell there really
isn't another good option.

> WRT binary data, I had not intended using this for binary data.  And without
> knowing what kinds or quantity of binary data we might use it for, I'd like
> to ignore this for now.

Yeah, I don't have any plans here either. I was thinking more about
things like author names and file paths.

-Peff
