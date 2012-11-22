From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH] emacs: make 'git-status' work with separate git dirs
Date: Thu, 22 Nov 2012 16:58:54 +0100
Message-ID: <1353599934-23222-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 22 20:14:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbcDs-0006vu-48
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433Ab2KVTNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:13:43 -0500
Received: from mail.cvg.de ([62.153.82.30]:35410 "EHLO mail.cvg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932428Ab2KVTNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:13:38 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2012 14:13:37 EST
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail.cvg.de (8.14.4/8.14.4) with ESMTP id qAMFx0S7025085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 22 Nov 2012 16:59:01 +0100
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.76)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1TbZB6-000637-Ee; Thu, 22 Nov 2012 16:59:00 +0100
X-Mailer: git-send-email 1.7.11.7
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 0.88
X-Spam-Score: -5.6
X-Spam-Level: -----
X-Spam-Tests: AWL,BAYES_00,RP_MATCHES_RCVD,SPF_NEUTRAL,DSPAM_INNOCENT
X-Scanned-By: MIMEDefang 2.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210192>

when trying 'M-x git-status' in a submodule created with recent (1.7.5+)
git, the command fails with

| ... is not a git working tree

This is caused by creating submodules with '--separate-git-dir' but
still checking for a working tree by testing for a '.git' directory.

The patch fixes this by relaxing the existing detection a little bit.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 contrib/emacs/git.el | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 65c95d9..5ffc506 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1671,7 +1671,7 @@ Commands:
   "Entry point into git-status mode."
   (interactive "DSelect directory: ")
   (setq dir (git-get-top-dir dir))
-  (if (file-directory-p (concat (file-name-as-directory dir) ".git"))
+  (if (file-exists-p (concat (file-name-as-directory dir) ".git"))
       (let ((buffer (or (and git-reuse-status-buffer (git-find-status-buffer dir))
                         (create-file-buffer (expand-file-name "*git-status*" dir)))))
         (switch-to-buffer buffer)
-- 
1.7.11.7
