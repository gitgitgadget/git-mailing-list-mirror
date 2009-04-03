From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] commit: abort commit if interactive add failed
Date: Fri, 3 Apr 2009 15:28:56 -0400
Message-ID: <20090403192856.GA5547@coredump.intra.peff.net>
References: <20090403192700.GA14965@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 21:31:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpp6U-0003Na-9X
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 21:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbZDCT3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 15:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761171AbZDCT3P
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 15:29:15 -0400
Received: from peff.net ([208.65.91.99]:50421 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757889AbZDCT3N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 15:29:13 -0400
Received: (qmail 1067 invoked by uid 107); 3 Apr 2009 19:29:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 15:29:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 15:28:56 -0400
Content-Disposition: inline
In-Reply-To: <20090403192700.GA14965@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115555>

Previously we ignored the result of calling add_interactive,
which meant that if an error occurred we simply committed
whatever happened to be in the index.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a fix I noticed while looking at t7501.

 builtin-commit.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 46e649c..81371b1 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -224,7 +224,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	const char **pathspec = NULL;
 
 	if (interactive) {
-		interactive_add(argc, argv, prefix);
+		if (interactive_add(argc, argv, prefix) != 0)
+			die("interactive add failed");
 		if (read_cache_preload(NULL) < 0)
 			die("index file corrupt");
 		commit_style = COMMIT_AS_IS;
-- 
1.6.2.2.569.g2d4b2
