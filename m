Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF5C1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDFTdE (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:33:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:56296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751389AbeDFTdD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:33:03 -0400
Received: (qmail 24797 invoked by uid 109); 6 Apr 2018 19:33:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 19:33:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28818 invoked by uid 111); 6 Apr 2018 19:34:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 15:34:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 15:33:01 -0400
Date:   Fri, 6 Apr 2018 15:33:01 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Primrose <jprimros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: FREAD_READS_DIRECTORIES test fails for the wrong reasons
Message-ID: <20180406193301.GA11450@sigill.intra.peff.net>
References: <82c91eac-9dc4-834b-4648-3c4ba45af80d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82c91eac-9dc4-834b-4648-3c4ba45af80d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 02:06:50PM -0400, Jonathan Primrose wrote:

> A while ago, the configure test for FREAD_READS_DIRECTORIES was changed
> to (attempt to) check for a NULL result from fopen. Unfortunately, the
> test will always fail - because it won't compile. The code snippet in
> configure.ac translates to:
> 
> return f);
> 
> Either there's an extra ) or a missing (. A cast to int wouldn't hurt
> either.

Oops. This is due to my 3adf9fdecf (configure.ac: loosen
FREAD_READS_DIRECTORIES test program, 2017-06-14).

Neither I nor the original tester noticed, because we're on Linux, which
needs that set.

> I'd supply a patch to fix this, but I'm not sure what the results of
> suddenly fixing the test would be. It seems to work well on my
> machine, but I don't stress git much here, and it's just one machine.

I think it should be fixed (and agreed on the "int" thing; the return
value should be "f != NULL" or similar).

I don't know autoconf very well, but is there a way to invoke it that
will let us know if a test-program fails to compile at all? Obviously
for probing the system compler/includes, "does not compile" is an
expected possible outcome. But for tests like this it's really a
tristate: yes, no, or something went horribly wrong.

-Peff
