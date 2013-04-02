From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] branch: factor out "upstream is not a branch" error
 messages
Date: Tue, 2 Apr 2013 15:03:55 -0400
Message-ID: <20130402190355.GB32316@sigill.intra.peff.net>
References: <20130402190134.GA17784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Garrett Cooper <yaneurabeya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:04:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6VT-0006jS-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab3DBTEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:00 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52471 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761632Ab3DBTD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:03:59 -0400
Received: (qmail 12549 invoked by uid 107); 2 Apr 2013 19:05:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 15:05:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 15:03:55 -0400
Content-Disposition: inline
In-Reply-To: <20130402190134.GA17784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219832>

This message is duplicated, and is quite long. Let's factor
it out, which avoids the repetition and the long lines. It
will also make future patches easier as we tweak the
message.

While we're at it, let's also mark it for translation.

Signed-off-by: Jeff King <peff@peff.net>
---
 branch.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 2bef1e7..1acbd4e 100644
--- a/branch.c
+++ b/branch.c
@@ -197,6 +197,9 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 	return 1;
 }
 
+static const char upstream_not_branch[] =
+N_("Cannot setup tracking information; starting point is not a branch.");
+
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
 		   int force, int reflog, int clobber_head,
@@ -231,14 +234,14 @@ void create_branch(const char *head,
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
-			die("Cannot setup tracking information; starting point is not a branch.");
+			die(_(upstream_not_branch));
 		break;
 	case 1:
 		/* Unique completion -- good, only if it is a real branch */
 		if (prefixcmp(real_ref, "refs/heads/") &&
 		    prefixcmp(real_ref, "refs/remotes/")) {
 			if (explicit_tracking)
-				die("Cannot setup tracking information; starting point is not a branch.");
+				die(_(upstream_not_branch));
 			else
 				real_ref = NULL;
 		}
-- 
1.8.2.rc0.33.gd915649
