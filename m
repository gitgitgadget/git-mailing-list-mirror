From: Jeff King <peff@peff.net>
Subject: [PATCH v2 07/10] sequencer: use argv_array_pushf
Date: Thu, 19 Jun 2014 17:28:20 -0400
Message-ID: <20140619212820.GG28474@sigill.intra.peff.net>
References: <20140619211659.GA32412@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:28:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxjsg-0001oW-AC
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965515AbaFSV2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:28:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:47797 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964845AbaFSV2W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:28:22 -0400
Received: (qmail 17177 invoked by uid 102); 19 Jun 2014 21:28:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 16:28:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 17:28:20 -0400
Content-Disposition: inline
In-Reply-To: <20140619211659.GA32412@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252190>

This avoids a manual allocation calculation, and is shorter
to boot.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a80c58..2fea824 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -396,18 +396,13 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 {
 	struct argv_array array;
 	int rc;
-	char *gpg_sign;
 
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
 
-	if (opts->gpg_sign) {
-		gpg_sign = xmalloc(3 + strlen(opts->gpg_sign));
-		sprintf(gpg_sign, "-S%s", opts->gpg_sign);
-		argv_array_push(&array, gpg_sign);
-		free(gpg_sign);
-	}
+	if (opts->gpg_sign)
+		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
 	if (opts->signoff)
 		argv_array_push(&array, "-s");
 	if (!opts->edit) {
-- 
2.0.0.566.gfe3e6b2
