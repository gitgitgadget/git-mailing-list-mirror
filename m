From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 1/3] git: s/run_command/run_builtin/
Date: Tue, 27 Jan 2009 01:26:32 -0500
Message-ID: <20090127062632.GA13161@coredump.intra.peff.net>
References: <20090127062512.GA10487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 07:28:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRhQV-0000gi-HJ
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 07:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZA0G0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 01:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbZA0G0f
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 01:26:35 -0500
Received: from peff.net ([208.65.91.99]:40359 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbZA0G0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 01:26:34 -0500
Received: (qmail 9253 invoked by uid 107); 27 Jan 2009 06:26:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 27 Jan 2009 01:26:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jan 2009 01:26:32 -0500
Content-Disposition: inline
In-Reply-To: <20090127062512.GA10487@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107316>

There is a static function called run_command which
conflicts with the library function in run-command.c; this
isn't a problem currently, but prevents including
run-command.h in git.c.

This patch just renames the static function to something
more specific and non-conflicting.

Signed-off-by: Jeff King <peff@peff.net>
---
 git.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index ecc8fad..45e493d 100644
--- a/git.c
+++ b/git.c
@@ -219,7 +219,7 @@ struct cmd_struct {
 	int option;
 };
 
-static int run_command(struct cmd_struct *p, int argc, const char **argv)
+static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status;
 	struct stat st;
@@ -384,7 +384,7 @@ static void handle_internal_command(int argc, const char **argv)
 		struct cmd_struct *p = commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
-		exit(run_command(p, argc, argv));
+		exit(run_builtin(p, argc, argv));
 	}
 }
 
-- 
1.6.1.1.367.g30b36
