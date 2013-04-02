From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] branch: mention start_name in set-upstream error messages
Date: Tue, 2 Apr 2013 15:04:51 -0400
Message-ID: <20130402190451.GD32316@sigill.intra.peff.net>
References: <20130402190134.GA17784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Garrett Cooper <yaneurabeya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:05:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6WR-0007YE-V8
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015Ab3DBTE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52504 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932991Ab3DBTEz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:55 -0400
Received: (qmail 13086 invoked by uid 107); 2 Apr 2013 19:06:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 15:06:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 15:04:51 -0400
Content-Disposition: inline
In-Reply-To: <20130402190134.GA17784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219847>

If we refuse a branch operation because the tracking
start_name the user gave us is bogus, we just print
something like:

 fatal: Cannot setup tracking information; start point is not a branch

If we mention the actual name we tried to use, that may help
the user figure out why it didn't work (e.g., if they gave
us the arguments in the wrong order).

Signed-off-by: Jeff King <peff@peff.net>
---
 branch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/branch.c b/branch.c
index 060e9e3..d6f4001 100644
--- a/branch.c
+++ b/branch.c
@@ -198,9 +198,9 @@ static const char upstream_missing[] =
 }
 
 static const char upstream_not_branch[] =
-N_("Cannot setup tracking information; starting point is not a branch.");
+N_("Cannot setup tracking information; starting point '%s' is not a branch.");
 static const char upstream_missing[] =
-N_("Cannot setup tracking information; starting point does not exist");
+N_("Cannot setup tracking information; starting point '%s' does not exist");
 
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
@@ -231,7 +231,7 @@ void create_branch(const char *head,
 	real_ref = NULL;
 	if (get_sha1(start_name, sha1)) {
 		if (explicit_tracking)
-			die(_(upstream_missing));
+			die(_(upstream_missing), start_name);
 		die("Not a valid object name: '%s'.", start_name);
 	}
 
@@ -239,14 +239,14 @@ void create_branch(const char *head,
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
-			die(_(upstream_not_branch));
+			die(_(upstream_not_branch), start_name);
 		break;
 	case 1:
 		/* Unique completion -- good, only if it is a real branch */
 		if (prefixcmp(real_ref, "refs/heads/") &&
 		    prefixcmp(real_ref, "refs/remotes/")) {
 			if (explicit_tracking)
-				die(_(upstream_not_branch));
+				die(_(upstream_not_branch), start_name);
 			else
 				real_ref = NULL;
 		}
-- 
1.8.2.rc0.33.gd915649
