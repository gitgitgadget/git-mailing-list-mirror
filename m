From: Nishhal Gaba <nishgaba9@gmail.com>
Subject: [PATCH] install_branch_config(): switch from 'else-if' series to 'nested if-else'
Date: Wed, 12 Mar 2014 14:04:35 +0530
Message-ID: <1394613275-3327-1-git-send-email-nishgaba9@gmail.com>
Cc: Nishchal <nishgaba9@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 09:34:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNecm-00062h-B0
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 09:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbaCLIer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 04:34:47 -0400
Received: from mail-pd0-f193.google.com ([209.85.192.193]:46101 "EHLO
	mail-pd0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756336AbaCLIep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 04:34:45 -0400
Received: by mail-pd0-f193.google.com with SMTP id x10so379500pdj.8
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wUJvgi3n5i78ksRmWzHWNOi1+z5YDjO/8ws4t6Zzblk=;
        b=y4h1AsBPvqj+qhpn6bQeDGrJlo7vXNSwHjkxum9eshJZDwtjGpx6eJ1QV6bBY4BxWd
         aC0lQLWVq9S8+m/Y0a4yQgdg0O4y6pKqIESN7ycrfTgsJSVIy9cc3fE+zJLRzuK/xEgg
         8PKLnZZ0x6ORqIZDbkWAdBNj+2KkmkXYkfLHojlPnYEUeAi9mUROm9ILR8+Iizc42ont
         XTumT02CVqrCK9np2KxNAMRoQNFYMPGFxS78y6f9bYcYgijzat31QSljnvJjpobX4Kpa
         R2SWRAyYBG77rlOYzYLAfjeEk+SRW1scx83Zk2dkgjVM38ZBCRMdFLE0EG4swewfhUE+
         a7vA==
X-Received: by 10.66.144.227 with SMTP id sp3mr3438471pab.100.1394613284752;
        Wed, 12 Mar 2014 01:34:44 -0700 (PDT)
Received: from localhost.localdomain ([14.139.60.220])
        by mx.google.com with ESMTPSA id ha2sm4780712pbb.8.2014.03.12.01.34.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Mar 2014 01:34:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243926>

From: Nishchal <nishgaba9@gmail.com>

I am Nishchal Gaba, a GSOC 2014 aspirant, submitting patch in response to microproject(8)
Similar Execution Time, but increased readability

Alternate Solution Discarded: Table driven code using commonanilty of the statements to be printed due to _()

Signed-off-by: Nishchal Gaba <nishgaba9@gmail.com>
---
---
 branch.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..04e9e24 100644
--- a/branch.c
+++ b/branch.c
@@ -77,26 +77,32 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
-			printf_ln(rebasing ?
+		if (origin){
+			if(remote_is_branch)
+				printf_ln(rebasing ?
 				  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
 				  _("Branch %s set up to track remote branch %s from %s."),
 				  local, shortname, origin);
-		else if (remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local branch %s by rebasing.") :
-				  _("Branch %s set up to track local branch %s."),
-				  local, shortname);
-		else if (!remote_is_branch && origin)
-			printf_ln(rebasing ?
+			else
+				printf_ln(rebasing ?
 				  _("Branch %s set up to track remote ref %s by rebasing.") :
 				  _("Branch %s set up to track remote ref %s."),
 				  local, remote);
-		else if (!remote_is_branch && !origin)
-			printf_ln(rebasing ?
+		}
+
+		else if (!origin){
+			if(remote_is_branch)
+				printf_ln(rebasing ?
+				  _("Branch %s set up to track local branch %s by rebasing.") :
+				  _("Branch %s set up to track local branch %s."),
+				  local, shortname);
+			else
+				printf_ln(rebasing ?
 				  _("Branch %s set up to track local ref %s by rebasing.") :
 				  _("Branch %s set up to track local ref %s."),
 				  local, remote);
+		}
+
 		else
 			die("BUG: impossible combination of %d and %p",
 			    remote_is_branch, origin);
-- 
1.8.1.2
