Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8117820248
	for <e@80x24.org>; Thu, 14 Mar 2019 00:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCNARS (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 20:17:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726477AbfCNARS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 20:17:18 -0400
Received: (qmail 30792 invoked by uid 109); 14 Mar 2019 00:17:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 00:17:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17670 invoked by uid 111); 14 Mar 2019 00:16:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 20:16:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 20:16:01 -0400
Date:   Wed, 13 Mar 2019 20:16:01 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 2/2] trace2: randomize/timestamp trace2 targets
Message-ID: <20190314001600.GC31968@sigill.intra.peff.net>
References: <cover.1552519463.git.steadmon@google.com>
 <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 04:33:29PM -0700, Josh Steadmon wrote:

> When the value of a trace2 environment variable contains instances of
> the string "%ISO8601%", expand them into the current UTC timestamp in
> ISO 8601 format.

This definitely seems useful. Could we drop the final "%" and make it
either a single-character "%t" or "%(iso8601)" to match our other
formatting strings? There's no _technical_ reason to do that, but it
just seems like there's not much point in being unnecessarily
inconsistent.

> When the value of a trace2 environment variable is an absolute path
> referring to an existing directory, write output to randomly-named
> files under the given directory. If the value is an absolute path
> referring to a non-existent file and ends with a dash, use the value as
> a prefix for randomly named files.
> 
> The random filenames will consist of the value of the environment
> variable (after potential timestamp expansion), followed by a 6
> character random string such as would be produced by mkstemp(3).

Doing this automatically for directories feels kind of magical. I'd have
expected it to be just another placeholder. And in fact, I'd think using
the process id as a placeholder would be pretty common. Between
timestamp and pid, that's generally unique (though I'm not opposed to
the random placeholder if somebody really wants to be thorough).

That leaves the door open for being able to append to or overwrite
existing trace files later, if we want to make that a possibility.

-Peff
