From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] t/t1300-repo-config.sh: value continued on next line
Date: Tue, 23 Jan 2007 13:37:25 +0100
Message-ID: <11695558453053-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 23 13:36:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9KtI-0002IA-Ct
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 13:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbXAWMgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 07:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbXAWMgl
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 07:36:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:4144 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964855AbXAWMgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 07:36:41 -0500
Received: by nf-out-0910.google.com with SMTP id o25so216451nfa
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 04:36:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=dJ7XxuP+QvqW+ypK0srUa6O+b1fKR8hs/Zl5WsKIky0rDPwaVVFH90W0M2fvypbaN0kq1k405HVSydNJ/QMsRfixnvmHNT616mwd7Y1yDf5yTaXekfpL0kAaUREJF3p3PmlYpxAvuoQVmVr4GJJHEBEA6cO0FWyy3hUo4pXe3VE=
Received: by 10.48.217.11 with SMTP id p11mr936070nfg.1169555798989;
        Tue, 23 Jan 2007 04:36:38 -0800 (PST)
Received: from roke.D-201 ( [81.190.20.200])
        by mx.google.com with ESMTP id z73sm2374805nfb.2007.01.23.04.36.37;
        Tue, 23 Jan 2007 04:36:38 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l0NCbQvL018162;
	Tue, 23 Jan 2007 13:37:26 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l0NCbPNn018161;
	Tue, 23 Jan 2007 13:37:25 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37505>

Documentation/config.txt:
  Variable value ending in a '`\`' is continued on the next line in the
  customary UNIX fashion.

Test it.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 t/t1300-repo-config.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index eb7455b..5210aa2 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -424,5 +424,25 @@ newline 123'
 test_expect_success 'value with newline' 'git repo-config key.sub value.with\\\
 newline'
 
+cat > .git/config << EOF
+[section]
+	; comment \\
+	continued = cont\\
+inued
+	noncont   = not continued ; \\
+	quotecont = "cont;\\
+inued"
+EOF
+
+cat > expect <<EOF
+section.continued=continued
+section.noncont=not continued
+section.quotecont=cont;inued
+EOF
+
+git repo-config --list > result
+
+test_expect_success 'value continued on next line' 'cmp result expect'
+
 test_done
 
-- 
1.4.4.4
