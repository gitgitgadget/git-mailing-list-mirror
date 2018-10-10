Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044321F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 20:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeJKD7X (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 23:59:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:35984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726911AbeJKD7X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 23:59:23 -0400
Received: (qmail 6765 invoked by uid 109); 10 Oct 2018 20:35:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Oct 2018 20:35:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21446 invoked by uid 111); 10 Oct 2018 20:34:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 16:34:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 16:35:32 -0400
Date:   Wed, 10 Oct 2018 16:35:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gc: introduce an --auto-exit-code option for undoing
 3029970275
Message-ID: <20181010203531.GA12949@sigill.intra.peff.net>
References: <20181010174624.GC8786@sigill.intra.peff.net>
 <20181010192732.13918-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010192732.13918-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 07:27:32PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Add an --auto-exit-code variable and a corresponding 'gc.autoExitCode'
> configuration option to optionally bring back the 'git gc --auto' exit
> code behavior as it existed between 2.6.3..2.19.0 (inclusive).
> 
> This was changed in 3029970275 ("gc: do not return error for prior
> errors in daemonized mode", 2018-07-16). The motivation for that patch
> was to appease 3rd party tools whose treatment of the 'git gc --auto'
> exit code is different from that of git core where it has always been
> ignored.

OK. I wouldn't want to use this myself, but I think you've made clear
why you find it useful. So I don't mind making it an optional behavior
(and it probably beats you trying to poke at the logfile yourself).

I'm not sure if the config is going to actually help that much, though.
The callers within Git will generally ignore the exit code anyway. So
for those cases, setting it will at best do nothing, and at worst it may
confuse the few stragglers (e.g., the git-svn one under recent
discussion).

Callers who _are_ prepared to act on the exit code probably ought to
just use --auto-exit-code in their invocation.

That said, I'm not entirely opposed to the matching config. There's
enough history here that somebody might want a sledgehammer setting to
go back to the old behavior.

-Peff
