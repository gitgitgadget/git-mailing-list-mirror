From: Jeff King <peff@peff.net>
Subject: [PATCH] send-email: add transfer encoding header with content-type
Date: Tue, 20 Nov 2007 07:54:04 -0500
Message-ID: <20071120125404.GB7998@sigill.intra.peff.net>
References: <20071115105726.GA18555@bre-cln-ukleine.digi.com> <20071116104907.GA13087@sigill.intra.peff.net> <7vlk8xwvbu.fsf@gitster.siamese.dyndns.org> <20071119104950.GB8645@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brian Swetland <swetland@google.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Nov 20 13:54:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuScV-00036c-Hq
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 13:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760231AbXKTMyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2007 07:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760225AbXKTMyI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 07:54:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2786 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760211AbXKTMyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 07:54:07 -0500
Received: (qmail 30061 invoked by uid 111); 20 Nov 2007 12:54:05 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 20 Nov 2007 07:54:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2007 07:54:04 -0500
Content-Disposition: inline
In-Reply-To: <20071119104950.GB8645@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65544>

We add the content-type header only when we have non-7bit
characters from the 'From' header, so we really need to
specify the encoding (in other cases, where the commit text
needed a content-type, git-format-patch will already have
added the encoding header).

Signed-off-by: Jeff King <peff@peff.net>
---
On Mon, Nov 19, 2007 at 11:49:50AM +0100, Uwe Kleine-K=F6nig wrote:

> but no Content-Transfer-Encoding:.  This yield a 7bit mail with 8bit
> characters.
>=20
> I think we should add
>=20
> 	Content-Transfer-Encoding: 8bit

Even though Brian's mail turned out to be hand-generated, this problem
does exist in git-send-email. I don't know why I didn't add the encodin=
g
header in the first place, since it is clearly required.

Junio, I think this is maint-worthy.

 git-send-email.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fd0a4ad..d7b8391 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -781,7 +781,8 @@ foreach my $t (@files) {
 			else {
 				push @xh,
 				  'MIME-Version: 1.0',
-				  "Content-Type: text/plain; charset=3D$author_encoding";
+				  "Content-Type: text/plain; charset=3D$author_encoding",
+				  'Content-Transfer-Encoding: 8bit';
 			}
 		}
 	}
--=20
1.5.3.6.1784.gd1b1d-dirty
