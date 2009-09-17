From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] branch: die when calling "git branch [-a|-r] branchname".
Date: Thu, 17 Sep 2009 11:35:28 +0200
Message-ID: <1253180128-670-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 11:35:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoDP4-0001lh-DD
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 11:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686AbZIQJfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 05:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbZIQJfc
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 05:35:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60298 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbZIQJfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 05:35:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8H9VI5b012966
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 17 Sep 2009 11:31:18 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MoDOk-0007wY-5E; Thu, 17 Sep 2009 11:35:30 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MoDOk-0000BP-3W; Thu, 17 Sep 2009 11:35:30 +0200
X-Mailer: git-send-email 1.6.5.rc1.11.g2d184.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 17 Sep 2009 11:31:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8H9VI5b012966
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253784679.0518@K+Ku8TVR2oXWDoXgPN9XVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128739>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin-branch.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 9f57992..fe11b55 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -635,10 +635,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
 		rename_branch(argv[0], argv[1], rename > 1);
-	else if (argc <= 2)
+	else if (argc <= 2) {
+		if (kinds != REF_LOCAL_BRANCH) {
+			die("-a or -r do not make sense with branch name");
+		}
 		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
 			      force_create, reflog, track);
-	else
+	} else
 		usage_with_options(builtin_branch_usage, options);
 
 	return 0;
-- 
1.6.5.rc1.11.g2d184.dirty
