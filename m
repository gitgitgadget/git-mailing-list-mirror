From: Jeff King <peff@peff.net>
Subject: [PATCH] push: always load default config
Date: Sun, 25 Oct 2009 15:15:22 -0400
Message-ID: <20091025191521.GA19014@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 20:11:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N28VN-00023z-8A
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 20:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbZJYTLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 15:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbZJYTLk
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 15:11:40 -0400
Received: from peff.net ([208.65.91.99]:35488 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbZJYTLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 15:11:40 -0400
Received: (qmail 19028 invoked by uid 1000); 25 Oct 2009 19:15:22 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131235>

This is needed because we want to use the
advice.pushnonfastforward variable.

Previously, we would load the config on demand only when we
needed to look at push.default.  Which meant that "git push"
would load it, but "git push remote" would not, leading to
differing behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-push.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index b5cd2cd..7338176 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -66,7 +66,6 @@ static void setup_push_tracking(void)
 
 static void setup_default_push_refspecs(void)
 {
-	git_config(git_default_config, NULL);
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_MATCHING:
@@ -174,6 +173,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int rc;
 	const char *repo = NULL;	/* default repository */
 
+	git_config(git_default_config, NULL);
+
 	struct option options[] = {
 		OPT_BIT('q', "quiet", &flags, "be quiet", TRANSPORT_PUSH_QUIET),
 		OPT_BIT('v', "verbose", &flags, "be verbose", TRANSPORT_PUSH_VERBOSE),
-- 
1.6.4.2.269.g75194.dirty
