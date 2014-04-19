From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] run_external_diff: drop fflush(NULL)
Date: Sat, 19 Apr 2014 15:19:30 -0400
Message-ID: <20140419191930.GD8981@sigill.intra.peff.net>
References: <20140419191128.GA9266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:19:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbank-0002IL-1o
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbaDSTTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:19:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:34498 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754991AbaDSTTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 15:19:32 -0400
Received: (qmail 26629 invoked by uid 102); 19 Apr 2014 19:19:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Apr 2014 14:19:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Apr 2014 15:19:30 -0400
Content-Disposition: inline
In-Reply-To: <20140419191128.GA9266@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246534>

This fflush was added in d5535ec (Use run_command() to spawn
external diff programs instead of fork/exec., 2007-10-19),
because flushing buffers before forking is a good habit.

But later, 7d0b18a (Add output flushing before fork(),
2008-08-04) added it to the generic run-command interface,
meaning that our flush here is redundant.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/diff.c b/diff.c
index b517d01..fdb7f6c 100644
--- a/diff.c
+++ b/diff.c
@@ -2928,7 +2928,6 @@ static void run_external_diff(const char *pgm,
 		argv_array_push(&argv, pgm);
 		argv_array_push(&argv, name);
 	}
-	fflush(NULL);
 
 	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
 	argv_array_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
-- 
1.9.1.656.ge8a0637
