From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] name-rev: include taggerdate in considering the best name
Date: Fri, 22 Apr 2016 14:11:04 -0400
Message-ID: <20160422181103.GA5920@sigill.intra.peff.net>
References: <d58135a6720d6fda4c7bc609e77e2709d161fe25.1461332260.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 22 20:11:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atfXt-0007Wt-L9
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 20:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbcDVSLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 14:11:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:54285 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753284AbcDVSLH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 14:11:07 -0400
Received: (qmail 16742 invoked by uid 102); 22 Apr 2016 18:11:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 14:11:06 -0400
Received: (qmail 8622 invoked by uid 107); 22 Apr 2016 18:11:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 14:11:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Apr 2016 14:11:04 -0400
Content-Disposition: inline
In-Reply-To: <d58135a6720d6fda4c7bc609e77e2709d161fe25.1461332260.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292237>

On Fri, Apr 22, 2016 at 03:39:01PM +0200, Johannes Schindelin wrote:

> We most likely want the oldest tag that contained the commit to be
> reported. So let's remember the taggerdate, and make it more important
> than anything else when choosing the best name for a given commit.
> 
> Suggested by Linus Torvalds.
> 
> Note that we need to update t9903 because it tested for the old behavior
> (which preferred the description "b1~1" over "tags/t2~1").
> 
> We might want to introduce a --heed-taggerdate option, and make the new
> behavior dependent on that, if it turns out that some scripts rely on the
> old name-rev method.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/name-rev.c     | 19 +++++++++++++------
>  t/t9903-bash-prompt.sh |  2 +-
>  2 files changed, 14 insertions(+), 7 deletions(-)

That turned out to be quite simple (I wasn't sure originally if we'd
actually visit all of the tags, which is why I had conceived of this as
an initial pass; but of course it makes sense that we'd have to see all
of the tags in the existing code).

I confirmed that it does find the "optimal" tag for the case we've been
discussing.

We could _also_ tweak the merge-weight as Linus's patch did, just
because 10000 has more basis than 65535. But I think it really matters a
lot less at this point.

-Peff
