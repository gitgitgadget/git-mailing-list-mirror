From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] verify-tag: also grok CR/LFs in the tag signature
Date: Mon, 3 Sep 2007 17:51:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031749110.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 03 18:52:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISF9c-0000EG-Ly
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 18:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbXICQv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 12:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbXICQv4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 12:51:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:39488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751907AbXICQvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 12:51:55 -0400
Received: (qmail invoked by alias); 03 Sep 2007 16:51:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 03 Sep 2007 18:51:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PGpw6XHIPHnqddLGYZXPakg/rkxP3HRZLZyFdmy
	Jtw3oBxpLWDiH+
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57494>


On some people's favorite platform, gpg outputs signatures
with CR/LF line endings.  So verify-tag has to play nice with
them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I just pushed a fix to 4msysgit.git which prevents the generation 
	of such tag signatures, but it's always better to be a little more 
	graceful.

	Note that the match less strict than before, but if you really 
	have to start a line in a signed tag with that magic BEGIN 
	PGP SIGNATURE string, you cannot be helped anyway.

 builtin-verify-tag.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 5c1314d..8cfefcf 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -35,7 +35,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 
 	/* find the length without signature */
 	len = 0;
-	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE "\n")) {
+	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE)) {
 		eol = memchr(buf + len, '\n', size - len);
 		len += eol ? eol - (buf + len) + 1 : size - len;
 	}
-- 
1.5.3.2.g46909
