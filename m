From: Yao Zhao <zhaox383@umn.edu>
Subject: [PATCH] SoC 2014 MicroProject No.8:change multiple if-else statement to table-driven approach
Date: Tue, 11 Mar 2014 22:47:29 -0500
Message-ID: <1394596049-8767-1-git-send-email-zhaox383@umn.edu>
References: <zhaox383@umn.edu>
Cc: Yao Zhao <zhaox383@umn.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 05:03:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNaNr-0004fU-QS
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 05:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbaCLEDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 00:03:06 -0400
Received: from vs-a.tc.umn.edu ([134.84.135.107]:42706 "EHLO vs-a.tc.umn.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbaCLEDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 00:03:05 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Mar 2014 00:03:04 EDT
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com [209.85.213.173])
	by vs-a.tc.umn.edu (UMN smtpd) with ESMTP
	for <git@vger.kernel.org>; Tue, 11 Mar 2014 22:48:00 -0500 (CDT)
X-Umn-Remote-Mta: [N] mail-ig0-f173.google.com [209.85.213.173] #+LO+TS+TR
X-Umn-Classification: local
Received: by mail-ig0-f173.google.com with SMTP id t19so13170318igi.0
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 20:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5HDx01dWGPsXJNXx2YdrX3+64LI1NXBQZlFSmW1W9vg=;
        b=EiiJFnA1RWPL8OOlBzFxI7S7goIJaqsmQ+JYLd1s1iMYj6Nh7Zz0ndnLTuU4YqHp7g
         KdGwaHwARsURCoe8ukgP6EemstpvJcknckRVzw9+P7vqZJROwULbLDirkSNvDzFWFGDu
         gsQcCHGAoASxL1i+cfsEhfxZcf8P99LQ5fN4Ami35dhUcvnowMRy5hIpwX6wdmHaMAyv
         iPSFK3wICB8volYw+BBEKs/TNkAdlBXNqLc+vy9BvliD6YYs/C/a8vuSoZdEP8XXl6jY
         +V9QQAYD+quRTF15ltHvlgsPHjaGEe2z6OpbEQZIKJhvP1N3j+yfrZjgmlGgWsx6ZYuY
         GKBw==
X-Gm-Message-State: ALoCoQmJrYJ06eDLYAHnd1Haei7ekuEjCQkHlqj5uDxaHB9k9K5yq/nDQULdaTwhshIdQY9qAIuc/QNTPfgKm6vCwV4V6J6hVrG69GVYWXC0CFJenaVuLjv1hoxfIfAkMu3j/ZazdRN48rjj04JPK7Gr2H1Y4VxVCQ==
X-Received: by 10.42.97.193 with SMTP id p1mr35555426icn.32.1394596080227;
        Tue, 11 Mar 2014 20:48:00 -0700 (PDT)
X-Received: by 10.42.97.193 with SMTP id p1mr35555409icn.32.1394596079869;
        Tue, 11 Mar 2014 20:47:59 -0700 (PDT)
Received: from localhost.localdomain (c-71-63-157-152.hsd1.mn.comcast.net. [71.63.157.152])
        by mx.google.com with ESMTPSA id c17sm53718787igo.4.2014.03.11.20.47.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 20:47:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <zhaox383@umn.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243919>

Signed-off-by: Yao Zhao <zhaox383@umn.edu>
---
 branch.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..6432e27 100644
--- a/branch.c
+++ b/branch.c
@@ -53,7 +53,20 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	int remote_is_branch = starts_with(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
-
+	char** print_list = malloc(8 * sizeof(char*));
+	char* arg1=NULL;
+	char* arg2=NULL;
+	char* arg3=NULL;
+	int index=0;
+
+	print_list[7] = _("Branch %s set up to track remote branch %s from %s by rebasing.");
+	print_list[6] = _("Branch %s set up to track remote branch %s from %s.");
+	print_list[5] = _("Branch %s set up to track local branch %s by rebasing.");
+	print_list[4] = _("Branch %s set up to track local branch %s.");
+	print_list[3] = _("Branch %s set up to track remote ref %s by rebasing.");
+	print_list[2] = _("Branch %s set up to track remote ref %s.");
+	print_list[1] = _("Branch %s set up to track local ref %s by rebasing.");
+	print_list[0] = _("Branch %s set up to track local ref %s.");
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
 	    && !origin) {
@@ -77,7 +90,44 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
+		if(remote_is_branch)
+				index += 4;
+		if(origin)
+				index += 2;
+		if(rebasing)
+				index += 1;
+		
+		if(index < 0 || index > 7)
+		{
+			die("BUG: impossible combination of %d and %p",
+			    remote_is_branch, origin);
+		}
+
+		if(index <= 4) {
+			arg1 = local;
+			arg2 = remote;
+		}
+		else if(index > 6) {
+			arg1 = local;
+			arg2 = shortname;
+			arg3 = origin;
+		}
+		else {
+			arg1 = local;
+			arg2 = shortname;
+		}
+
+		if(!arg3) {
+			printf_ln(print_list[index],arg1,arg2);
+		}
+		else {
+			printf_ln(print_list[index],arg1,arg2,arg3);
+		}
+
+		free(print_list);
+
+
+/*		if (remote_is_branch && origin)
 			printf_ln(rebasing ?
 				  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
 				  _("Branch %s set up to track remote branch %s from %s."),
@@ -100,6 +150,7 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 		else
 			die("BUG: impossible combination of %d and %p",
 			    remote_is_branch, origin);
+*/
 	}
 }
 
-- 
1.8.3.2
