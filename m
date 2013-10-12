From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 13/14] reset: allow --keep with --stage
Date: Sat, 12 Oct 2013 02:04:44 -0500
Message-ID: <1381561488-20294-11-git-send-email-felipe.contreras@gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMY-0004MJ-5a
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745Ab3JLHLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:22 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48980 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab3JLHLT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:19 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so3106965oag.5
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l3+oVgeYwGrwMweYjMi8Zq27EiMSe+K6cbeCM+Huxe0=;
        b=ZtZyXOPWCQeeyLM1aN8w4K4bdzlnYuYqfOgsyRMnhOlX06xJx2KU8Dkp+v0E91nx1U
         5bxv1NQ75YJCnYME9azclySfiOK0pQLgNDcdbQKKhX+sSFl6sBNKRBnWZE/z3BJ2nRk9
         agIGo1jOfEUM++Ez0qqE2VrzIob3wPb/XXuBoKuV4EmHdg9PnajcLw42NkpDyJn+JwxX
         bM22GoLsnj7qnYOj0OxVGDUpWJ9ybTmIJmEBcukE38TWxnXqRGoCAObqQdsL07ibtXne
         hPFc9RiPkuv1xE2Kx23wnXxBMo9hA0qbf1ii+2ljND5tb94pUlEd9W1HY+6zeOZg9WIT
         TOhw==
X-Received: by 10.60.68.135 with SMTP id w7mr18232090oet.9.1381561879313;
        Sat, 12 Oct 2013 00:11:19 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm101375724oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235978>

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
index fbc1abc..dde03a7 100644
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
@@ -295,8 +295,15 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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
@@ -304,7 +311,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			reset_type = HARD;
 		} else {
 			if (stage == 1)
-				reset_type = NONE;
+				reset_type = keep ? KEEP : NONE;
 			else
 				reset_type = SOFT;
 		}
-- 
1.8.4-fc
