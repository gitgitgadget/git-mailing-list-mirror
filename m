From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/6] pretty: treat "--format=" as an empty userformat
Date: Tue, 29 Jul 2014 13:54:46 -0400
Message-ID: <20140729175446.GB31181@peff.net>
References: <20140729175300.GA21536@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 19:54:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCBby-0008VP-S6
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 19:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbaG2Ryv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 13:54:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:42608 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751212AbaG2Ryu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 13:54:50 -0400
Received: (qmail 2369 invoked by uid 102); 29 Jul 2014 17:54:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 12:54:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 13:54:46 -0400
Content-Disposition: inline
In-Reply-To: <20140729175300.GA21536@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254453>

Until now, we treated "--pretty=" or "--format=" as "give me
the default format". This was not planned nor documented,
but only what happened to work due to our parsing of
"--pretty" (which should give the default format).

Let's instead let these be an actual empty userformat.
Otherwise one must write out the annoyingly long
"--pretty=tformat:" to get the same behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
If we are really concerned with people expecting "--pretty=" to turn on
the default format, we could introduce a new mode "none" which does the
same thing behind the scenes. I don't think it's a problem, though.

 pretty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 3a1da6f..f97a762 100644
--- a/pretty.c
+++ b/pretty.c
@@ -146,7 +146,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 	struct cmt_fmt_map *commit_format;
 
 	rev->use_terminator = 0;
-	if (!arg || !*arg) {
+	if (!arg) {
 		rev->commit_format = CMIT_FMT_DEFAULT;
 		return;
 	}
@@ -155,7 +155,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		return;
 	}
 
-	if (strchr(arg, '%')) {
+	if (!*arg || strchr(arg, '%')) {
 		save_user_format(rev, arg, 1);
 		return;
 	}
-- 
2.1.0.rc0.286.g5c67d74
