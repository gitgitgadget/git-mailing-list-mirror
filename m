From: Jeff King <peff@peff.net>
Subject: [PATCH] error_resolve_conflict: rewrap advice message
Date: Tue, 3 Jun 2014 03:17:17 -0400
Message-ID: <20140603071717.GA32038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 09:17:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WriyM-0007RC-K7
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 09:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbaFCHRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 03:17:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:36432 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753770AbaFCHRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 03:17:19 -0400
Received: (qmail 7690 invoked by uid 102); 3 Jun 2014 07:17:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jun 2014 02:17:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jun 2014 03:17:17 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250616>

If you try to commit with unresolved conflicts in the index,
you get this message:

	$ git commit
	U       foo
	error: 'commit' is not possible because you have unmerged files.
	hint: Fix them up in the work tree,
	hint: and then use 'git add/rm <file>' as
	hint: appropriate to mark resolution and make a commit,
	hint: or use 'git commit -a'.
	fatal: Exiting because of an unresolved conflict.

The irregular line-wrapping makes this awkward to read, and
it takes up more lines than necessary. Instead, let's rewrap
it to about 60 characters per line:

	$ git commit
	U       foo
	error: 'commit' is not possible because you have unmerged files.
	hint: Fix them up in the work tree, and then use 'git add/rm <file>'
	hint: as appropriate to mark resolution and make a commit, or use
	hint: 'git commit -a'.
	fatal: Exiting because of an unresolved conflict.

Signed-off-by: Jeff King <peff@peff.net>
---
This always bugs me when I see it, so I thought I'd finally do something
about it. I left the wording alone, though I'd also be happy to see it
shortened to just advise "git add/rm" and not mention "git commit -a" at
all.

 advice.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 486f823..ef24733 100644
--- a/advice.c
+++ b/advice.c
@@ -82,10 +82,9 @@ int error_resolve_conflict(const char *me)
 		 * Message used both when 'git commit' fails and when
 		 * other commands doing a merge do.
 		 */
-		advise(_("Fix them up in the work tree,\n"
-			 "and then use 'git add/rm <file>' as\n"
-			 "appropriate to mark resolution and make a commit,\n"
-			 "or use 'git commit -a'."));
+		advise(_("Fix them up in the work tree, and then use 'git add/rm <file>'\n"
+			 "as appropriate to mark resolution and make a commit, or use\n"
+			 "'git commit -a'."));
 	return -1;
 }
 
-- 
2.0.0.rc1.436.g03cb729
