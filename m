From: Jeff King <peff@peff.net>
Subject: [PATCH] format-patch: fix bug with --stdout in a subdirectory
Date: Mon, 22 Jan 2007 22:38:28 -0500
Message-ID: <20070123033828.GA22599@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 04:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9CUV-00009j-8s
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 04:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbXAWDib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 22:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932794AbXAWDib
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 22:38:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3175 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932739AbXAWDia (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 22:38:30 -0500
Received: (qmail 13051 invoked from network); 22 Jan 2007 22:38:50 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 22 Jan 2007 22:38:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jan 2007 22:38:28 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37481>

We set the output directory to the git subdirectory prefix if one has
not already been specified. However, in the case of --stdout, we
explicitly _don't_ want the output directory to be set. The result was
that "git-format-patch --stdout" in a directory besides the project root
produced the "standard output, or directory, which one?" error message.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-log.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 9691296..d4bf2dc 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -482,7 +482,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!rev.diffopt.text)
 		rev.diffopt.binary = 1;
 
-	if (!output_directory)
+	if (!output_directory && !use_stdout)
 		output_directory = prefix;
 
 	if (output_directory) {
-- 
1.5.0.rc2.g8cad-dirty
