From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 13/14] reset: allow --keep with --stage
Date: Fri, 25 Apr 2014 13:12:46 -0500
Message-ID: <1398449567-16314-14-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:24:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdknN-0007Rv-1E
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbaDYSYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:24:11 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:62233 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbaDYSYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:24:09 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so4614753oag.14
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z73XCRX6MGbjVqPxLFTc/AkyfI+FeT5k1cenKV6kXLA=;
        b=hevYFY/R1ADYjt92br2/UPnwdyCFwdMv6OjXUiS0to8MZ3DOHz13TZOCMwmNXULQgE
         BbwHAT41SfuiFbVP1j11kE/nEBMBJJPW9y4fZjkZvzALDl3XJJqFJo8X6Rn5Aaatpwhm
         Aq6k4d6zv8s3sx/1lz/rVC/M4QJDCo9Gfn6zuY0Ll1RX2fW6lyUxAotX5QKlyMF5n/bJ
         V5gycWAibRRBLQGr9DBJksoo1Q6aRhwXVS8fcaDEYCo3F8jLD68huzI+Dg3P1I4toptG
         AKpXC+Z/4RDXI2eOvq4HEVk8M5CIeyMwNGRyDfSdc+KEdevcFFN/lvUEgytZQ9FVJOaz
         TtfA==
X-Received: by 10.182.33.73 with SMTP id p9mr8060262obi.37.1398450249246;
        Fri, 25 Apr 2014 11:24:09 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zm8sm17050847obc.16.2014.04.25.11.24.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:24:08 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247085>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-reset.txt |  2 +-
 builtin/reset.c             | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 5cd75a8..a1419c9 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git reset' [-q] [<tree-ish>] [--] <paths>...
 'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
 'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
-'git reset' [--stage | --work] [-q] [<commit>]
+'git reset' [--stage | --work | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
diff --git a/builtin/reset.c b/builtin/reset.c
index c40987e..8d6d9a1 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -23,7 +23,7 @@
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
-	N_("git reset [--stage | --work] [-q] [<commit>]"),
+	N_("git reset [--stage | --work | --keep] [-q] [<commit>]"),
 	N_("git reset [-q] <tree-ish> [--] <paths>..."),
 	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
 	NULL
@@ -306,8 +306,15 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	}
 
 	if (stage >= 0 || working_tree >= 0) {
-		if (reset_type != NONE)
+		int keep = 0;
+
+		if (reset_type == KEEP) {
+			if (working_tree == 1)
+				die(_("--keep is incompatible with --work"));
+			keep = 1;
+		} else if (reset_type != NONE) {
 			die(_("--{stage,work} are incompatible with --{hard,mixed,soft,merge}"));
+		}
 
 		if (working_tree == 1) {
 			if (stage == 0)
@@ -315,7 +322,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			reset_type = HARD;
 		} else {
 			if (stage == 1)
-				reset_type = NONE;
+				reset_type = keep ? KEEP : NONE;
 			else
 				reset_type = SOFT;
 		}
-- 
1.9.2+fc1.2.gfbaae8c
