From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH resubmit] Allow cherry-pick (and revert) to add signoff line
Date: Sat, 26 Apr 2008 15:14:28 -0500
Message-ID: <1209240868-30815-1-git-send-email-dpmcgee@gmail.com>
References: <1209221215-13476-1-git-send-email-dpmcgee@gmail.com>
Cc: B.Steinbrink@gmx.de, gitster@pobox.com,
	Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 22:15:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpqnp-0008Dk-Dd
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 22:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759656AbYDZUOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 16:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759196AbYDZUOe
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 16:14:34 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:16006 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757230AbYDZUOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 16:14:33 -0400
Received: by py-out-1112.google.com with SMTP id u52so6697179pyb.10
        for <git@vger.kernel.org>; Sat, 26 Apr 2008 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0gQtezL0H5zrSoiUm3GuacLvQ0vg16vc+SsBH++64Hw=;
        b=iY9VBfmo9OXC5UTxTK2ByIUgzunDtsrdk6zf7X9s4k4ARe/aCiCaGKB4WMlHhc6bpSp8mob3LcuHg8zqlLkJF3yrdhhZG2f94wImTpQIZuFvxtD0nD7AukuDPISSQ0uBNOtaCODrEZxJ0/UtXUGAwoCTlK4iBLewu/49m/uc8zU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h/NBDSrvmc4IeRamVZOhggP1VmHA/rDoW+5HTWJ+Ib7uZQ18StoN+D3q8SyhTB4821JBkrbP7EBSYVCYXCa1OPzdMHzURyFN00WhwWZ3/Vsr76CzfocgeEZnJYOrd3W/dHzOJ7w6maa8MM9EPNSWW9VRJZHxNGS7CAff64s/Spg=
Received: by 10.35.63.5 with SMTP id q5mr10094629pyk.38.1209240872442;
        Sat, 26 Apr 2008 13:14:32 -0700 (PDT)
Received: from localhost ( [76.193.177.245])
        by mx.google.com with ESMTPS id f55sm10196960pyh.28.2008.04.26.13.14.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Apr 2008 13:14:30 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1209221215-13476-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80390>

I often find myself pulling patches off of other peoples trees using
cherry-pick, and following it with an immediate 'git commit --amend -s'
command. Eliminate the need for a double commit by allowing signoff on a
cherry-pick or revert.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

Documentation is a good thing too, so I've adjusted the patch to include it.

 Documentation/git-cherry-pick.txt |    5 ++++-
 Documentation/git-revert.txt      |    5 ++++-
 builtin-revert.c                  |   20 +++++++++++++++-----
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index f0beb41..ca048f4 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -7,7 +7,7 @@ git-cherry-pick - Apply the change introduced by an existing commit
 
 SYNOPSIS
 --------
-'git-cherry-pick' [--edit] [-n] [-m parent-number] [-x] <commit>
+'git-cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] <commit>
 
 DESCRIPTION
 -----------
@@ -64,6 +64,9 @@ OPTIONS
 This is useful when cherry-picking more than one commits'
 effect to your working tree in a row.
 
+-s|--signoff::
+	Add Signed-off-by line at the end of the commit message.
+
 
 Author
 ------
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 93e20f7..13ceabb 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -7,7 +7,7 @@ git-revert - Revert an existing commit
 
 SYNOPSIS
 --------
-'git-revert' [--edit | --no-edit] [-n] [-m parent-number] <commit>
+'git-revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>
 
 DESCRIPTION
 -----------
@@ -51,6 +51,9 @@ OPTIONS
 This is useful when reverting more than one commits'
 effect to your working tree in a row.
 
+-s|--signoff::
+	Add Signed-off-by line at the end of the commit message.
+
 
 Author
 ------
diff --git a/builtin-revert.c b/builtin-revert.c
index 607a2f0..3f08cfe 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -33,7 +33,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline;
+static int edit, no_replay, no_commit, mainline, signoff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 
@@ -53,6 +53,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
 		OPT_BOOLEAN('x', NULL, &no_replay, "append commit name when cherry-picking"),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
+		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by: header"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_END(),
 	};
@@ -404,10 +405,19 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	 */
 
 	if (!no_commit) {
-		if (edit)
-			return execl_git_cmd("commit", "-n", NULL);
-		else
-			return execl_git_cmd("commit", "-n", "-F", defmsg, NULL);
+		/* 6 is max possible length of our args array including NULL */
+		const char *args[6];
+		int i = 0;
+		args[i++] = "commit";
+		args[i++] = "-n";
+		if (signoff)
+			args[i++] = "-s";
+		if (!edit) {
+			args[i++] = "-F";
+			args[i++] = defmsg;
+		}
+		args[i] = NULL;
+		return execv_git_cmd(args);
 	}
 	free(reencoded_message);
 
-- 
1.5.5.1
