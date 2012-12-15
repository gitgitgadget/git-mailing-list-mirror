From: Jeff King <peff@peff.net>
Subject: [PATCH] completion: complete refs for "git commit -c"
Date: Sat, 15 Dec 2012 12:46:43 -0500
Message-ID: <20121215174643.GA22342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 18:47:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjvpH-0001XI-24
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 18:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab2LORqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 12:46:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55533 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab2LORqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 12:46:45 -0500
Received: (qmail 22558 invoked by uid 107); 15 Dec 2012 17:47:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 15 Dec 2012 12:47:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2012 12:46:43 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211539>

The "-c" and "-C" options take an existing commit, so let's
complete refs, just as we would for --squash or --fixup.

Signed-off-by: Jeff King <peff@peff.net>
---
I notice that the existing code just handles the "--foo=bar" form of most
options. By checking $prev, we can also handle "--foo bar" form (which
we have to do for short options like "-c"). But it would mean
duplicating all of the existing logic. I don't know if it's worth it or
not, given that nobody has complained.

 contrib/completion/git-completion.bash | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b77eb1..a4c48e1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -971,6 +971,13 @@ _git_commit ()
 {
 	__git_has_doubledash && return
 
+	case "$prev" in
+	-c|-C)
+		__gitcomp_nl "$(__git_refs)" "" "${cur}"
+		return
+		;;
+	esac
+
 	case "$cur" in
 	--cleanup=*)
 		__gitcomp "default strip verbatim whitespace
-- 
1.8.0.2.4.g59402aa
