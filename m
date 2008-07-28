From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH] builtin-verify-tag: fix -v option parsing
Date: Mon, 28 Jul 2008 12:48:44 +0200
Message-ID: <488DA40C.8020400@free.fr>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-2-git-send-email-barra_cuda@katamail.com> <4888B4E3.9000504@free.fr> <alpine.DEB.1.00.0807241807550.8986@racer> <4889EF22.6020604@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 12:50:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQIy-00015h-7U
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 12:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbYG1Ksr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 06:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752961AbYG1Ksq
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 06:48:46 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:38755 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbYG1Ksq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 06:48:46 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id CE7701AB2EF;
	Mon, 28 Jul 2008 12:48:44 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 941B61AB307;
	Mon, 28 Jul 2008 12:48:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <4889EF22.6020604@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90435>

From: Olivier Marin <dkr@freesurf.fr>

Since the C rewrite, "git verify-tag -v" just does nothing instead of
printing the usage message with an error. This patch fix the regression.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 builtin-verify-tag.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 7d837f0..729a159 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -92,14 +92,15 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	if (argc == 1)
-		usage(builtin_verify_tag_usage);
-
-	if (!strcmp(argv[i], "-v") || !strcmp(argv[i], "--verbose")) {
+	if (argc > 1 &&
+	    (!strcmp(argv[i], "-v") || !strcmp(argv[i], "--verbose"))) {
 		verbose = 1;
 		i++;
 	}
 
+	if (argc <= i)
+		usage(builtin_verify_tag_usage);
+
 	/* sometimes the program was terminated because this signal
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
-- 
1.6.0.rc0.79.gb0320
