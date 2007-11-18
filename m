From: Jeff King <peff@peff.net>
Subject: [PATCH] avoid "defined but not used" warning for
	fetch_objs_via_walker
Date: Sun, 18 Nov 2007 03:17:23 -0500
Message-ID: <20071118081722.GA31563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 09:17:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItfLg-0001Z8-HZ
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 09:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbXKRIR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 03:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbXKRIR2
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 03:17:28 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3732 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbXKRIR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 03:17:27 -0500
Received: (qmail 8828 invoked by uid 111); 18 Nov 2007 08:17:25 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 18 Nov 2007 03:17:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Nov 2007 03:17:23 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65348>

Because this function is static and used only by the
http-walker, when NO_CURL is defined, gcc emits a "defined
but not used" warning.

Signed-off-by: Jeff King <peff@peff.net>
---
On master. I like to compile with -Werror to make sure I don't miss
warnings as the compile scrolls by.

This fix feels a little wrong, since the function isn't specific to http
support, but hopefully the comment should be obvious if we ever add
another similar commit walker that needs it.

 transport.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index e8a2608..43b9e7c 100644
--- a/transport.c
+++ b/transport.c
@@ -344,6 +344,7 @@ static int rsync_transport_push(struct transport *transport,
 
 /* Generic functions for using commit walkers */
 
+#ifndef NO_CURL /* http fetch is the only user */
 static int fetch_objs_via_walker(struct transport *transport,
 				 int nr_objs, struct ref **to_fetch)
 {
@@ -370,6 +371,7 @@ static int fetch_objs_via_walker(struct transport *transport,
 	free(dest);
 	return 0;
 }
+#endif /* NO_CURL */
 
 static int disconnect_walker(struct transport *transport)
 {
-- 
1.5.3.5.1817.gd2b4b-dirty
