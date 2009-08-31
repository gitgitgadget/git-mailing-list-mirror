From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] transport: don't show push status if --quiet is
 given
Date: Mon, 31 Aug 2009 15:28:34 -0400
Message-ID: <20090831192834.GC4876@sigill.intra.peff.net>
References: <20090805201937.GB9004@coredump.intra.peff.net>
 <20090805202326.GC23226@coredump.intra.peff.net>
 <7vhbwm0zcs.fsf@alter.siamese.dyndns.org>
 <20090805204835.GA24539@coredump.intra.peff.net>
 <7vws5ix9dz.fsf@alter.siamese.dyndns.org>
 <20090805211700.GA24697@coredump.intra.peff.net>
 <4A9C175E.6020905@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:28:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiCYW-0003a9-PB
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 21:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbZHaT2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 15:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbZHaT2f
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 15:28:35 -0400
Received: from peff.net ([208.65.91.99]:40710 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003AbZHaT2e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 15:28:34 -0400
Received: (qmail 28001 invoked by uid 107); 31 Aug 2009 19:28:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 Aug 2009 15:28:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2009 15:28:34 -0400
Content-Disposition: inline
In-Reply-To: <4A9C175E.6020905@hartwork.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127495>

On Mon, Aug 31, 2009 at 08:33:02PM +0200, Sebastian Pipping wrote:

> I run git push in a cron job, too.  I want mails in error cases only
> so I need git push to print errors but _only_ errors to stderr.  That
> seems impossible with 1.6.4.* and related to what you're discussing here.
> 
> Does the patch you're building address that case already?  has it been
> applied to any branch already?  I got a bit lost in this thread, sorry.

Junio applied the series, and it is in 'master' right now (and so should
be part of the upcoming 1.6.5).

Using "git push -q" will do what you want, but playing with it a bit, I
think there is one bit missing from the original series:

-- >8 --
Subject: [PATCH] push: teach --quiet to suppress "Everything up-to-date"

This should have been part of 481c7a6, whose goal was to
make "git push -q" silent unless there is an error.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index ce91387..f2bd998 100644
--- a/transport.c
+++ b/transport.c
@@ -908,7 +908,7 @@ int transport_push(struct transport *transport,
 				update_tracking_ref(transport->remote, ref, verbose);
 		}
 
-		if (!ret && !refs_pushed(remote_refs))
+		if (!quiet && !ret && !refs_pushed(remote_refs))
 			fprintf(stderr, "Everything up-to-date\n");
 		return ret;
 	}
-- 
1.6.4.2.372.gf7961.dirty
