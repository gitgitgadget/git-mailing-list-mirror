From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] branch: die explicitly why when calling "git branch [-a|-r] branchname".
Date: Wed, 30 Dec 2009 15:45:31 +0100
Message-ID: <1262184331-9102-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 30 15:45:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPzo3-000647-TA
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 15:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbZL3Opn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 09:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbZL3Opn
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 09:45:43 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47607 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807AbZL3Opm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 09:45:42 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nBUEiYrG025638
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 30 Dec 2009 15:44:34 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NPznq-0005oR-9G; Wed, 30 Dec 2009 15:45:34 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NPznq-0002NN-71; Wed, 30 Dec 2009 15:45:34 +0100
X-Mailer: git-send-email 1.6.6.71.gcc720.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 Dec 2009 15:44:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nBUEiYrG025638
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1262789075.7664@pzgHQtYJzBn7GT5X1bAgBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135902>

The -a and -r options used to be silently ignored in such a command.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin-branch.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index c87e63b..8aef2bb 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -638,10 +638,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
 		rename_branch(argv[0], argv[1], rename > 1);
-	else if (argc <= 2)
+	else if (argc <= 2) {
+		if (kinds != REF_LOCAL_BRANCH) {
+			die("-a and -r options to 'git branch' do not make sense with a branch name");
+		}
 		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
 			      force_create, reflog, track);
-	else
+	} else
 		usage_with_options(builtin_branch_usage, options);
 
 	return 0;
-- 
1.6.6.71.gcc720.dirty
