From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Checking for "diff.color." should come before "diff.color"
Date: Mon, 23 Oct 2006 20:51:17 +0100
Message-ID: <200610232051.17396.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 23 21:55:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc5ru-0006Q0-OA
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 21:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWJWTxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 15:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbWJWTxu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 15:53:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:53692 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965020AbWJWTxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 15:53:49 -0400
Received: by ug-out-1314.google.com with SMTP id q2so1490554uge
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 12:53:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=YqFOhA/3mPKh53g55+mJ5VIs0skVzQnGRvsNu3pmYjfq3ASde9Jbn4OIfAlycoqESnyKYyhe2Qay+lkvQMhDX+hQrtwOJjL/T0FuddO6pS7EvibGdeVfmV5e5nv+Z7yBDPa1x3NGEUqnQDUKj3MVeadIB5mFGce6S0St4ELv1v4=
Received: by 10.66.221.19 with SMTP id t19mr8005448ugg;
        Mon, 23 Oct 2006 12:53:47 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id b35sm246241ugd.2006.10.23.12.53.47;
        Mon, 23 Oct 2006 12:53:47 -0700 (PDT)
To: git@vger.kernel.org
X-TUID: 68a2698e4e4195c9
X-UID: 121
X-Length: 1322
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29870>

In git_diff_ui_config() the strncmp() for "diff.color" would have matched for
"diff.color.", so "diff.color." configs would never be processed.

Fix is to move "diff.color." check before "diff.color"
Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 diff.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 3315378..d795be4 100644
--- a/diff.c
+++ b/diff.c
@@ -60,10 +60,6 @@ int git_diff_ui_config(const char *var, 
 		diff_rename_limit_default = git_config_int(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.color")) {
-		diff_use_color_default = git_config_colorbool(var, value);
-		return 0;
-	}
 	if (!strcmp(var, "diff.renames")) {
 		if (!value)
 			diff_detect_rename_default = DIFF_DETECT_RENAME;
@@ -79,6 +75,10 @@ int git_diff_ui_config(const char *var, 
 		color_parse(value, var, diff_colors[slot]);
 		return 0;
 	}
+	if (!strcmp(var, "diff.color")) {
+		diff_use_color_default = git_config_colorbool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value);
 }
 
-- 
1.4.2.3
