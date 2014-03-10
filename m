From: Adam <adam@sigterm.info>
Subject: [PATCH] [GSOC] branch.c: install_branch_config: simplify if chain
Date: Mon, 10 Mar 2014 01:32:01 -0400
Message-ID: <1394429521-10974-1-git-send-email-Adam@sigterm.info>
Cc: Adam <Adam@sigterm.info>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 06:32:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMspa-0003O0-1O
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 06:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbaCJFcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 01:32:47 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:40527 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbaCJFcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 01:32:41 -0400
Received: by mail-qc0-f176.google.com with SMTP id m20so7222955qcx.35
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 22:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IblWcQ8wPDE4yDKbj0znNJT8MV8ma9dHDRzVnxrdJYM=;
        b=QZ8H4QIQ6NnSD6u8fmcTajDgLqgcu+KERIhhy7YjrCvfTTmge4WoO0jkBP1/LpzWWn
         6bRF8MMEhv8K+FRE+L0WyvD4nMIZAhib1AdCfpZ5AqszoduOaifA2bFBqaS6Mw/bSQa1
         n/EvNWpsgU1yJLGborTXLgfX8XiMej7M3KVXtetob08SgiI6t9NdWhK59d+819bsZSVy
         2JpnWTIpPLVeLXNPrKkneocw62hswlXY4X2lVmfWhFkwJszI77lFmfnsjDBBfghs7wzh
         ilyYm5KQzzI+PwQ+1P8UJSmWaCrfvUEJr+gstY0si3Vrn1ytXmcO+2g6NvNuZjJr5CX3
         Pypg==
X-Gm-Message-State: ALoCoQlKBS5V/KKfXS/NdoO8wgKol06ypC1vuXF7WHOuPwNX+CCEM8nGlUasgE00cjVlzE3W/Voe
X-Received: by 10.140.31.9 with SMTP id e9mr36372810qge.76.1394429560637;
        Sun, 09 Mar 2014 22:32:40 -0700 (PDT)
Received: from localhost.localdomain ([97.102.54.5])
        by mx.google.com with ESMTPSA id p67sm24861156qgd.8.2014.03.09.22.32.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Mar 2014 22:32:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243704>

Simplify if chain in install_branch_config().

Signed-off-by: Adam <Adam@sigterm.info>
---
 branch.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..b2d59f1 100644
--- a/branch.c
+++ b/branch.c
@@ -77,29 +77,29 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
-				  _("Branch %s set up to track remote branch %s from %s."),
-				  local, shortname, origin);
-		else if (remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local branch %s by rebasing.") :
-				  _("Branch %s set up to track local branch %s."),
-				  local, shortname);
-		else if (!remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote ref %s by rebasing.") :
-				  _("Branch %s set up to track remote ref %s."),
-				  local, remote);
-		else if (!remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local ref %s by rebasing.") :
-				  _("Branch %s set up to track local ref %s."),
-				  local, remote);
-		else
-			die("BUG: impossible combination of %d and %p",
-			    remote_is_branch, origin);
+		if (remote_is_branch) {
+			if (origin)
+				printf_ln(rebasing ?
+					  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
+					  _("Branch %s set up to track remote branch %s from %s."),
+					  local, shortname, origin);
+			else
+				printf_ln(rebasing ?
+					  _("Branch %s set up to track local branch %s by rebasing.") :
+					  _("Branch %s set up to track local branch %s."),
+					  local, shortname);
+		} else {
+			if (origin)
+				printf_ln(rebasing ?
+					  _("Branch %s set up to track remote ref %s by rebasing.") :
+					  _("Branch %s set up to track remote ref %s."),
+					  local, remote);
+			else
+				printf_ln(rebasing ?
+					  _("Branch %s set up to track local ref %s by rebasing.") :
+					  _("Branch %s set up to track local ref %s."),
+					  local, remote);
+		}
 	}
 }
 
-- 
1.7.1
