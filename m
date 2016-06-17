Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12F6E1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 23:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbcFQXdN (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 19:33:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:56442 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750774AbcFQXdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 19:33:12 -0400
Received: (qmail 7902 invoked by uid 102); 17 Jun 2016 23:33:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:33:12 -0400
Received: (qmail 30189 invoked by uid 107); 17 Jun 2016 23:33:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:33:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 19:33:10 -0400
Date:	Fri, 17 Jun 2016 19:33:10 -0400
From:	Jeff King <peff@peff.net>
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] run-command: mark file-local symbols static
Message-ID: <20160617233309.GB26564@sigill.intra.peff.net>
References: <57646524.7040708@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57646524.7040708@ramsayjones.plus.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 17, 2016 at 10:01:24PM +0100, Ramsay Jones wrote:

> If you need to re-roll your 'jk/gpg-interface-cleanup' branch, could
> you please squash this into the relevant patch (commit 74287e34,
> "run-command: add pipe_command helper", 16-06-2016).

Thanks, yes.

> BTW, also on that branch, commit 6fec0a89 ("verify_signed_buffer: use
> tempfile object", 16-06-2016) removes the last use of the git_mkstemp()
> function. Should it be removed?

I think so. We still have git_mkstemp_mode and friends, so in that sense
this is part of a family of commands that somebody might use again. But:

  1. Unlike the others in the family, where we implement mkstemp
     ourselves, this one uses the system mkstemp. Which probably behaves
     in totally the same way, but it's kind of weird and oddball.

  2. I think we should be steering people towards tempfile.c anyway, for
     its auto-cleanup properties.

Want to do a patch on top?

-Peff
