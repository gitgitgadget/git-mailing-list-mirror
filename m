From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/2] Improve diffcore-pickaxe documentation
Date: Fri, 17 May 2013 17:53:21 +0530
Message-ID: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
Cc: Phil Hord <phil.hord@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 17 14:21:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdJfS-0000vE-4w
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 14:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795Ab3EQMVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 08:21:46 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:45324 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448Ab3EQMVp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 08:21:45 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so3259040pdj.24
        for <git@vger.kernel.org>; Fri, 17 May 2013 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=uac8fxewlzlk0CURvJLQ6DXWInTZ71kIgDuO/CG/wE4=;
        b=r1zlbSO4n8vOMUz6KlXll5WKXhbshglsITJU3nsKmInZyn5kBWaVpdO9b2xW2hNL8n
         +ZEmTB6t5MAjnza/7ixt4HjWHwt1uvz+fUcpe2tt3g2POeFaaeSc/OUw+nNIPRDwLEIq
         KUu53UMsmmHQUtQTzWyYk1wX1uFUEc26HLcI6AUd4JVNXfPVR9f3ml45ld4GCkjRbFDb
         cnaWoZzWAB/MnKBWC4vrLzeNxgEpL6jEjsuwpnQMeEuwfzTLmnAxlNb5chjKDsoJLRCX
         /08p0qOUQ05XoX5CMr3ORQyaHZ/F4oC6pxJXIWJiNrAdejijXFtcrelFAKcE40HwAow+
         lDIQ==
X-Received: by 10.66.146.7 with SMTP id sy7mr28628282pab.16.1368793304793;
        Fri, 17 May 2013 05:21:44 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id rn7sm11064643pbc.12.2013.05.17.05.21.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 May 2013 05:21:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2.432.g070c57d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224684>

[1/2] is unchangd, but [2/2] has some major changes: thanks to inputs
from Junio and Phil.  The inter-diff for [2/2] follows.

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 765abc5..b61a666 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -383,13 +383,13 @@ ifndef::git-format-patch[]
 	that matches other criteria, nothing is selected.
 
 -S<string>::
-	Look for commits where the specified string was added or
-	removed.  More precisely, find commits that change the number
-	of occurrences of the specified string.
+	Look for commits that change the number of occurrences of the
+	specified string (i.e. addition/ deletion) in a file.
+	Intended for the scripter's use.
 +
-It is often useful when you're looking for an exact string (like a
-function prototype), and want to know the history of that string since
-it first came into being.
+It is especially useful when you're looking for an exact block of code
+(like a struct), and want to know the history of that block since it
+first came into being.
 
 -G<regex>::
 	Grep through the patch text of commits for added/removed lines
@@ -419,8 +419,8 @@ information.
 	in <string>.
 
 --pickaxe-regex::
-	Make the <string> not a plain string but an extended POSIX
-	regex to match.  Implied when using `-G`.
+	Treat the <string> not as a plain string, but an extended
+	POSIX regex to match.  It is implied when `-G` is used.
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 39b9c51..d0f2b91 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -223,16 +223,16 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 ---------------------------------------------------------------------
 
 There are two kinds of pickaxe: the S kind (corresponding to 'git log
--S') and the G kind (corresponding to 'git log -G').
+-S') and the G kind (mnemonic: grep; corresponding to 'git log -G').
 
 The S kind detects filepairs whose "result" side and "origin" side
-have different number of occurrences of specified string.  While
-rename detection works as usual, 'git log -S' cannot omit commits
-where a the small string being looked for is moved verbatim from one
-file to another (since the number of occurrences of that string
-changed in each of those two filepairs). The implementation
-essentially runs a count, and is significantly cheaper than the G
-kind.
+have different number of occurrences of specified string.  By
+definition, it will not detect in-file moves.  Also, when a commit
+moves a file wholesale without affecting the string being looked at,
+rename detection kicks in as usual, and 'git log -S' omits the commit
+(since the number of occurrences of that string didn't change in that
+rename-detected filepair).  The implementation essentially runs a
+count, and is significantly cheaper than the G kind.
 
 The G kind detects filepairs whose patch text has an added or a
 deleted line that matches the given regexp.  This means that it can
@@ -240,12 +240,16 @@ detect in-file (or what rename-detection considers the same file)
 moves.  The implementation of 'git log -G' runs diff twice and greps,
 and this can be quite expensive.
 
-A diffcore-pickaxe option worth mentioning: `--pickaxe-all`.  When not
-in effect, diffcore-pickaxe leaves only such filepairs that touch the
-specified string in its output.  When in effect, diffcore-pickaxe
-leaves all filepairs intact if there is such a filepair, or makes the
-output empty otherwise.  The latter behavior is designed to make
-reviewing of the changes in the context of the whole changeset easier.
+When `--pickaxe-regex` is used with `-S`, treat the <string> not as a
+plain string, but an extended POSIX regex to match.  It is implied
+when `-G` is used.
+
+When `--pickaxe-all` is not in effect, diffcore-pickaxe leaves only
+the filepairs that touch the specified string in its output.  When in
+effect, diffcore-pickaxe leaves all filepairs intact if there is such
+a filepair, or makes the output empty otherwise.  The latter behavior
+is designed to make reviewing of the changes in the context of the
+whole changeset easier.
 
 diffcore-order: For Sorting the Output Based on Filenames
 ---------------------------------------------------------


Ramkumar Ramachandra (2):
  diffcore-pickaxe: make error messages more consistent
  diffcore-pickaxe doc: document -S and -G properly

 Documentation/diff-options.txt | 37 ++++++++++++++++++++++++++-------
 Documentation/gitdiffcore.txt  | 47 +++++++++++++++++++++++++-----------------
 diffcore-pickaxe.c             |  2 +-
 3 files changed, 58 insertions(+), 28 deletions(-)

-- 
1.8.1.2.432.g070c57d
