From: Yao Zhao <zhaox383@umn.edu>
Subject: [PATCH/GSoC_v3] branch.c: turn nested if-else logic to table-driven
Date: Sun, 16 Mar 2014 01:08:23 -0500
Message-ID: <1394950103-2264-1-git-send-email-zhaox383@umn.edu>
References: <CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com>
Cc: git@vger.kernel.org, Yao Zhao <zhaox383@umn.edu>
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sun Mar 16 07:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP4FW-0002sd-3y
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 07:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbaCPGIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 02:08:38 -0400
Received: from vs-w.tc.umn.edu ([134.84.135.88]:46111 "EHLO vs-w.tc.umn.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbaCPGIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 02:08:37 -0400
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com [209.85.223.174])
	by vs-w.tc.umn.edu (UMN smtpd) with ESMTP
	for <git@vger.kernel.org>; Sun, 16 Mar 2014 01:08:34 -0500 (CDT)
X-Umn-Remote-Mta: [N] mail-ie0-f174.google.com [209.85.223.174] #+LO+TS+TR
X-Umn-Classification: local
Received: by mail-ie0-f174.google.com with SMTP id rp18so4093908iec.5
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 23:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YX+dMbtK3d9p1sIHNWpxkP+nMLiIQ4Teczt4KnvMxds=;
        b=ch4Pi8WzEe8PTEDL6/4MURQ7UUiIQMONlErM2//NO77AZ6ZkU21me9w0u7tcui9RGE
         IhOH+ie2vlIEaRCjxCske2YLMtk/F6O4fUZU/QN5UjLV1jdtz4tDh/sSFoRLZO2O22lT
         0oGIz8BkMJwDjnuueiVJK6c6O4lCsA6u8nuCb89FrwddlJc4x0rcSwnbMcURt4eM8sS7
         CYgdZw0RGTLDOFg1U0ssplK35PiSYUXOzPILe081265e5LoSJoxB9TjNr4ywF83MKgi1
         jM2j+XyQJd9XtBsPfybTqrZeUtv7HUyMJgzpyJZTE4dr4XUv6Ju5gahdO1RCZWqQ0Y42
         ASYg==
X-Gm-Message-State: ALoCoQlNnri+NG4KjRkJGleqcnbpVhZInCQt3muBdgFYNWUCeMFwSgQ3x6ie7kmonmKkOY30Xfgkg3Kofi7YXdFS5WYdDu0fbUybgnzU3CwthfbCKoZvJV/W08W+u9kk0rQe/kD8KLBQvfOFSOEOA2FVoGnbYqwePQ==
X-Received: by 10.50.138.104 with SMTP id qp8mr6225719igb.39.1394950112781;
        Sat, 15 Mar 2014 23:08:32 -0700 (PDT)
X-Received: by 10.50.138.104 with SMTP id qp8mr6225709igb.39.1394950112676;
        Sat, 15 Mar 2014 23:08:32 -0700 (PDT)
Received: from localhost.localdomain (c-71-63-157-152.hsd1.mn.comcast.net. [71.63.157.152])
        by mx.google.com with ESMTPSA id v2sm11113920igk.7.2014.03.15.23.08.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Mar 2014 23:08:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244179>

Signed-off-by: Yao Zhao <zhaox383@umn.edu>
---
 branch.c | 53 +++++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 24 deletions(-)
Hello Eric,

Thank you and Junio for reviewing my code. It is really helpful to improve my code quality.

This is version 3 of patch. Previous address : http://thread.gmane.org/gmane.comp.version-control.git/243919. I do not use positional initializer because it is not allowed to use variable in it. I don't know if it's ok to use this redundant way to initialize "list".

I cannot find -v flag in documentation you indicated in last email so I use set-prefix to add it into prefix.
	
Now I am working on writing proposal for git project. I am really interested in last one, about improve git_config. I know it's important to get known about git_config first and have read documentation about it. But I am really confused about how to understand code of git_config. When user type in git config in terminal, what is the execute order of functions? How git config influence other git command? Does program read config file every time when they execuate config-related command?

Thank you,

Yao

diff --git a/branch.c b/branch.c
index 723a36b..1df30c7 100644
--- a/branch.c
+++ b/branch.c
@@ -53,7 +53,33 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	int remote_is_branch = starts_with(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
-
+	struct print_list {
+		const char *print_str;
+		const char *arg2; 
+		const char *arg3;
+	} ; 
+	struct print_list target;
+
+	struct print_list list[2][2][2];
+	list[0][0][0].print_str = N_("Branch %s set up to track local ref %s.");
+	list[0][0][0].arg2 = remote;
+	list[0][0][1].print_str = N_("Branch %s set up to track local ref %s by rebasing.");
+	list[0][0][1].arg2 = remote;
+	list[0][1][0].print_str = N_("Branch %s set up to track remote ref %s.");
+	list[0][1][0].arg2 = remote;
+	list[0][1][1].print_str = N_("Branch %s set up to track remote ref %s by rebasing.");
+	list[0][1][1].arg2 = remote;
+	list[1][0][0].print_str = N_("Branch %s set up to track local branch %s.");
+	list[1][0][0].arg2 =shortname;
+	list[1][0][1].print_str = N_("Branch %s set up to track local branch %s by rebasing.");
+	list[1][0][1].arg2 = shortname;
+	list[1][1][0].print_str = N_("Branch %s set up to track remote branch %s from %s.");
+	list[1][1][0].arg2 = shortname;
+	list[1][1][0].arg3 = origin;
+	list[1][1][1].print_str = N_("Branch %s set up to track remote branch %s from %s by rebasing.");
+	list[1][1][1].arg2 = shortname;
+	list[1][1][1].arg3 = origin;
+ 
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
 	    && !origin) {
@@ -77,29 +103,8 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
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
+			target = list[!!remote_is_branch][!!origin][!!rebasing];
+			printf_ln (_(target.print_str), local, target.arg2, target.arg3);
 	}
 }
 
-- 
1.8.3.2
