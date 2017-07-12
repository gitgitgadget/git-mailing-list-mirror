Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83CDD202AC
	for <e@80x24.org>; Wed, 12 Jul 2017 07:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756880AbdGLHmZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 03:42:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:37760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756718AbdGLHmX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 03:42:23 -0400
Received: (qmail 11886 invoked by uid 109); 12 Jul 2017 07:42:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 07:42:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21641 invoked by uid 111); 12 Jul 2017 07:42:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 03:42:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jul 2017 03:42:20 -0400
Date:   Wed, 12 Jul 2017 03:42:20 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 0/3] Convert grep to recurse in-process
Message-ID: <20170712074220.565z3gahruqb2e7q@sigill.intra.peff.net>
References: <20170711220408.173269-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170711220408.173269-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 03:04:05PM -0700, Brandon Williams wrote:

> This series utilizes the new 'struct repository' in order to convert grep to be
> able to recurse into submodules in-process much like how ls-files was converted
> to recuse in-process.  The result is a much smaller code footprint due to not
> needing to compile an argv array of options to be used when launched a process
> for operating on a submodule.

I didn't follow the rest of the "struct repository" series closely, but
I don't feel like we ever reached a resolution on how config would be
handled. I notice that the in-process "ls-files" behaves differently
than the old one when config differs between the submodule and the
parent repository. As we convert more commands (that use more config)
this will become more likely to be noticed by somebody.

Do we have a plan for dealing with this? Is our solution just "recursed
operations always respect the parent config, deal with it"?

-Peff
