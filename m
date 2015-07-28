From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] docs/config.txt: reorder hideRefs config
Date: Tue, 28 Jul 2015 15:59:11 -0400
Message-ID: <20150728195911.GA13795@peff.net>
References: <20150728195747.GA13596@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 21:59:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKB1y-0004JU-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbbG1T7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:59:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:35979 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752535AbbG1T7O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:59:14 -0400
Received: (qmail 32411 invoked by uid 102); 28 Jul 2015 19:59:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jul 2015 14:59:14 -0500
Received: (qmail 20366 invoked by uid 107); 28 Jul 2015 19:59:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jul 2015 15:59:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jul 2015 15:59:11 -0400
Content-Disposition: inline
In-Reply-To: <20150728195747.GA13596@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274825>

The descriptions for receive.hideRefs and
uploadpack.hideRefs are largely the same, and then
transfer.hideRefs refers to both of them. Instead, let's
make transfer.hideRefs the "master" source, and refer to it
from the other sites (with appropriate program-specific
annotations).

This avoids duplication, and will make it easier to document
changes to the config option without having to copy and
paste the description in two places.

While we're at it, this fixes some bogus subject/verb
agreement in the original description.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this makes sense, though I could also see an argument that the
reader would rather hit the individual program's hideRefs config first
and not get redirected. The second patch relies on this textually, but
if we want to drop this one, I can rebase the second to just add the new
text in both places.

 Documentation/config.txt | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43bb53c..448eb9d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2242,13 +2242,10 @@ receive.denyNonFastForwards::
 	set when initializing a shared repository.
 
 receive.hideRefs::
-	String(s) `receive-pack` uses to decide which refs to omit
-	from its initial advertisement.  Use more than one
-	definitions to specify multiple prefix strings. A ref that
-	are under the hierarchies listed on the value of this
-	variable is excluded, and is hidden when responding to `git
-	push`, and an attempt to update or delete a hidden ref by
-	`git push` is rejected.
+	This variable is the same as `transfer.hideRefs`, but applies
+	only to `receive-pack` (and so affects pushes, but not fetches).
+	An attempt to update or delete a hidden ref by `git push` is
+	rejected.
 
 receive.updateServerInfo::
 	If set to true, git-receive-pack will run git-update-server-info
@@ -2536,9 +2533,13 @@ transfer.fsckObjects::
 	Defaults to false.
 
 transfer.hideRefs::
-	This variable can be used to set both `receive.hideRefs`
-	and `uploadpack.hideRefs` at the same time to the same
-	values.  See entries for these other variables.
+	String(s) `receive-pack` and `upload-pack` use to decide which
+	refs to omit from their initial advertisements.  Use more than
+	one definition to specify multiple prefix strings. A ref that is
+	under the hierarchies listed in the value of this variable is
+	excluded, and is hidden when responding to `git push` or `git
+	fetch`.  See `receive.hideRefs` and `uploadpack.hideRefs` for
+	program-specific versions of this config.
 
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
@@ -2553,13 +2554,10 @@ uploadarchive.allowUnreachable::
 	`false`.
 
 uploadpack.hideRefs::
-	String(s) `upload-pack` uses to decide which refs to omit
-	from its initial advertisement.  Use more than one
-	definitions to specify multiple prefix strings. A ref that
-	are under the hierarchies listed on the value of this
-	variable is excluded, and is hidden from `git ls-remote`,
-	`git fetch`, etc.  An attempt to fetch a hidden ref by `git
-	fetch` will fail.  See also `uploadpack.allowTipSHA1InWant`.
+	This variable is the same as `transfer.hideRefs`, but applies
+	only to `upload-pack` (and so affects only fetches, not pushes).
+	An attempt to fetch a hidden ref by `git fetch` will fail.  See
+	also `uploadpack.allowTipSHA1InWant`.
 
 uploadpack.allowTipSHA1InWant::
 	When `uploadpack.hideRefs` is in effect, allow `upload-pack`
-- 
2.5.0.rc3.557.g17a1555
