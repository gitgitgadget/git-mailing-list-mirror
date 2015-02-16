From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] cmd_push: set "atomic" bit directly
Date: Mon, 16 Feb 2015 01:12:04 -0500
Message-ID: <20150216061204.GA32381@peff.net>
References: <20150216061051.GA29895@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Olszewski <cxreg@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 07:12:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNEui-0007gn-Hc
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 07:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbbBPGMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 01:12:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:49401 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752130AbbBPGMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 01:12:07 -0500
Received: (qmail 9135 invoked by uid 102); 16 Feb 2015 06:12:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 00:12:07 -0600
Received: (qmail 12520 invoked by uid 107); 16 Feb 2015 06:12:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 01:12:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 01:12:04 -0500
Content-Disposition: inline
In-Reply-To: <20150216061051.GA29895@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263878>

This makes the code shorter and more obvious by removing an
unnecessary interim variable.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/push.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index ab99f4c..f558c2e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -519,7 +519,6 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int flags = 0;
 	int tags = 0;
 	int rc;
-	int atomic = 0;
 	const char *repo = NULL;	/* default repository */
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
@@ -551,7 +550,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
 		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
-		OPT_BOOL(0, "atomic", &atomic, N_("request atomic transaction on remote side")),
+		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
 		OPT_END()
 	};
 
@@ -567,9 +566,6 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (tags)
 		add_refspec("refs/tags/*");
 
-	if (atomic)
-		flags |= TRANSPORT_PUSH_ATOMIC;
-
 	if (argc > 0) {
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1, repo);
-- 
2.3.0.rc1.287.g761fd19
