From: Brian Ewins <brian.ewins@gmail.com>
Subject: [PATCH v2 2/2] Add a --dry-run option to git-push.
Date: Thu, 11 Oct 2007 20:32:27 +0100
Message-ID: <11921311522755-git-send-email-Brian.Ewins@gmail.com>
References: <8c5c35580710110057r29c1fe0w7f9e2825fa33@mail.gmail.com>
 <119213114734-git-send-email-Brian.Ewins@gmail.com>
Cc: hjemli@gmail.com, gitster@pobox.com,
	Brian Ewins <Brian.Ewins@gmail.com>,
	Brian Ewins <brian.ewins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 21:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig3mZ-0007EB-HH
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 21:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571AbXJKTc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 15:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757574AbXJKTc3
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 15:32:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:65465 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757571AbXJKTc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 15:32:27 -0400
Received: by ug-out-1314.google.com with SMTP id z38so515496ugc
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:message-id:in-reply-to:references:from;
        bh=lnAghQNMapKTVbmLGsEHUZoJQzIK3Syu+eCRt5F5mgk=;
        b=j9vsGXtltyn0WiS84HO9JcaKlcyXgo30faDzmRTvCZzm9TGU9690YA88Jd0+XxaZb3sUtTethYG9fUoFpIz0P3F7c4NqPUjSKsqosriwDI9K+NHQcIN0DaSgkQkRuHiClmCfwHyEwGlGa3dHYSNeWpiYa6TMdQeVpJNHc5IYS/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=lfIEyCltyiw26rWnDszNe0kBYcZwS96YRS32BSlwF07Z6Xae48pmaVZnT00AADoTcXQjqi6dl5MZuSxw70vsETHwJqma6/QYzeMf2j2FiZZdQjw3MWEi8d3V/vdV51b9b7qagehuftFJKIFqlSTigyL78bAWFzqsdINVCDuHbtk=
Received: by 10.78.131.8 with SMTP id e8mr1796130hud.1192131145563;
        Thu, 11 Oct 2007 12:32:25 -0700 (PDT)
Received: from localhost ( [86.0.198.221])
        by mx.google.com with ESMTPS id i3sm2605837nfh.2007.10.11.12.32.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Oct 2007 12:32:24 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <119213114734-git-send-email-Brian.Ewins@gmail.com>
Message-Id: <fe9a919ada9f6b6a79d9810eda11c13fb1091103.1192130892.git.Brian.Ewins@gmail.com>
In-Reply-To: <16913589bee1374245d8b8f7333ab3984b56ffcb.1192130892.git.Brian.Ewins@gmail.com>
References: <16913589bee1374245d8b8f7333ab3984b56ffcb.1192130892.git.Brian.Ewins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The default behaviour of git-push is potentially confusing
for new users, since it will push changes that are not on
the current branch. Publishing patches that were still
cooking on a development branch is hard to undo.

It would also be nice to be able to verify the expansion
of refspecs if you've edited them, so that you know
what branches matched on the server.

Adding a --dry-run flag allows the user to experiment
safely and learn how to use git-push properly. Originally
suggested by Steffen Prohaska.

Signed-off-by: Brian Ewins <brian.ewins@gmail.com>
---
 Documentation/git-push.txt |    5 ++++-
 builtin-push.c             |   10 ++++++++--
 t/t5516-fetch-push.sh      |   10 ++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 6bc559d..e5dd4c1 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git-push' [--all] [--tags] [--receive-pack=<git-receive-pack>]
+'git-push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
            [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]
 
 DESCRIPTION
@@ -63,6 +63,9 @@ the remote repository.
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/heads/` be pushed.
 
+\--dry-run::
+	Do everything except actually send the updates.
+
 \--tags::
 	All refs under `$GIT_DIR/refs/tags` are pushed, in
 	addition to refspecs explicitly listed on the command
diff --git a/builtin-push.c b/builtin-push.c
index 88c5024..141380b 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -7,9 +7,9 @@
 #include "builtin.h"
 #include "remote.h"
 
-static const char push_usage[] = "git-push [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
+static const char push_usage[] = "git-push [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
 
-static int all, force, thin, verbose;
+static int all, dry_run, force, thin, verbose;
 static const char *receivepack;
 
 static const char **refspec;
@@ -69,6 +69,8 @@ static int do_push(const char *repo)
 	argc = 1;
 	if (all)
 		argv[argc++] = "--all";
+	if (dry_run)
+		argv[argc++] = "--dry-run";
 	if (force)
 		argv[argc++] = "--force";
 	if (receivepack)
@@ -147,6 +149,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			all = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--dry-run")) {
+			dry_run = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--tags")) {
 			add_refspec("refs/tags/*");
 			continue;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ca46aaf..4fbd5b1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -244,4 +244,14 @@ test_expect_success 'push with colon-less refspec (4)' '
 
 '
 
+test_expect_success 'push with dry-run' '
+
+	mk_test heads/master &&
+	cd testrepo &&
+	old_commit=$(git show-ref -s --verify refs/heads/master) &&
+	cd .. &&
+	git push --dry-run testrepo &&
+	check_push_result $old_commit heads/master
+'
+
 test_done
-- 
1.5.2.5
