From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] apply: fix segfault
Date: Mon, 11 Feb 2008 22:28:25 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802112227400.3870@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 11 23:28:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOh8u-0008Vg-R8
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 23:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbYBKW2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 17:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752829AbYBKW2S
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 17:28:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:55716 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752716AbYBKW2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 17:28:18 -0500
Received: (qmail invoked by alias); 11 Feb 2008 22:28:16 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp022) with SMTP; 11 Feb 2008 23:28:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UXPhG32PUyDfLbGD+fNV/nzltoJ7uu96lgaHGUX
	YYsRwthoJzF3Mt
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73599>


When the patch reports a line number that is larger than the number of
lines in the current version of the file, git-apply used to segfault.

This fixes it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This just happened to me.

 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 4578542..ca7096f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1830,7 +1830,7 @@ static int find_pos(struct image *img,
 			return try_lno;
 
 	again:
-		if (backwards_lno == 0 && forwards_lno == img->nr)
+		if (backwards_lno == 0 && forwards_lno >= img->nr)
 			break;
 
 		if (i & 1) {
-- 
1.5.4.1264.gb53928
