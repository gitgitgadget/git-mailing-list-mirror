From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 2/5] Don't return 'undef' in case called in a vector
 context.
Date: Thu, 22 Nov 2007 04:55:34 -0600
Message-ID: <20071122045534.435f01bb@paradox.zwell.net>
References: <47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110180109.34febc3f@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvA8u-0007zC-Jo
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbXKVLWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbXKVLWb
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:22:31 -0500
Received: from gateway05.websitewelcome.com ([67.18.144.2]:58409 "HELO
	gateway05.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751676AbXKVLWa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 06:22:30 -0500
X-Greylist: delayed 1249 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2007 06:22:30 EST
Received: (qmail 21265 invoked from network); 22 Nov 2007 10:56:08 -0000
Received: from gator290.hostgator.com (74.53.26.226)
  by gateway05.websitewelcome.com with SMTP; 22 Nov 2007 10:56:08 -0000
Received: from [143.44.70.185] (port=40111 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <dzwell@zwell.net>)
	id 1Iv9io-00070o-CW; Thu, 22 Nov 2007 04:55:50 -0600
In-Reply-To: <20071110180109.34febc3f@paradox.zwell.net>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.12.1; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65795>

Previously, the Git->repository()->config('non-existent.key')
evaluated to as true in a vector context. Call 'return' with
no argument, instead.

Signed-off-by: Dan Zwell <dzwell@zwell.net>
---
This isn't color related, but the next change I make to Git.pm
depends on this.

 perl/Git.pm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index dca92c8..6603762 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -508,7 +508,7 @@ sub config {
 		my $E = shift;
 		if ($E->value() == 1) {
 			# Key not found.
-			return undef;
+			return;
 		} else {
 			throw $E;
 		}
-- 
1.5.3.5.565.gf0b83-dirty
