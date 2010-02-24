From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] shortlog: do not stall when there is no input
Date: Wed, 24 Feb 2010 20:20:27 +0100
Message-ID: <201002242020.27801.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 20:18:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMkR-0004G7-KI
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607Ab0BXTSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 14:18:09 -0500
Received: from smtp189-pc.aruba.it ([62.149.157.189]:34669 "HELO
	smtp1-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1757562Ab0BXTSH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:18:07 -0500
Received: (qmail 30458 invoked by uid 89); 24 Feb 2010 19:17:59 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp1-pc.ad.aruba.it
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,RDNS_NONE
	autolearn=ham version=3.2.5
Received: from unknown (HELO darkstar.localnet) (barra?cuda@katamail.com@78.134.85.202)
  by smtp1-pc.ad.aruba.it with SMTP; 24 Feb 2010 19:17:58 -0000
User-Agent: KMail/1.11.4 (Linux/2.6.32.8-mike-1mike; KDE/4.2.4; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140972>

A simple "git shortlog" outside of a git repository used to stall
waiting for an input. Fix this by testing with isatty() before
calling read_from_stdin().

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-shortlog.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index b3b055f..ff5dca6 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -294,9 +294,8 @@ parse_done:
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
 		add_head_to_pending(&rev);
-	if (rev.pending.nr == 0) {
+	if (rev.pending.nr == 0 && !isatty(0))
 		read_from_stdin(&log);
-	}
 	else
 		get_from_rev(&rev, &log);
 
-- 
1.7.0
