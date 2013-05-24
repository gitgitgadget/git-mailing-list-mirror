From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/2] Improve diffcore-pickaxe documentation
Date: Fri, 24 May 2013 16:03:53 +0530
Message-ID: <1369391635-13056-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 12:32:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfpIJ-0007HK-JB
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 12:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab3EXKcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 06:32:15 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35559 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759741Ab3EXKcO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 06:32:14 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so4005465pdi.36
        for <git@vger.kernel.org>; Fri, 24 May 2013 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=C1HjAlfSue7KLIDZhMO/Wy3+JnVp9Ud2tychrSRf69U=;
        b=cNi6vFBG2eXLVMpnwh4B1/x2sosVP+wBN9zy3EFqb7cEebAAxFMsT8RQEq3UblXOS9
         zIao/5VQhxcB7xYMArEJcR5jR7CHcPRLoHFhAuMHZ+pIxb847JW1FH4aRDz/SuVj0Dih
         yYLtbpnI4aIrEp9gm/NI604d75ipFSm8QgmzpBB+zLvDJsr0pc1wQuFkNAUlwy9vFUQh
         GeyVv5jLJ2I6RuOjU/7ef+dT8lAww6kqaZ9rDeJ3wZ7iUUGwKJG4rD+fLh5aYsGRD/oW
         O/8zIu/LXZaElXsG1LNR4tCi1nGHV5rfX9CdUI10I1Q1W9cu4T6+L+8zQ00or/aAZHCZ
         Y1kw==
X-Received: by 10.66.8.69 with SMTP id p5mr17659406paa.57.1369391533598;
        Fri, 24 May 2013 03:32:13 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id v7sm15680718pbq.32.2013.05.24.03.32.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 May 2013 03:32:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225341>

[1/2] replaces "pickaxe regex" with "regex", as suggested by Junio.

[2/2] is now co-authored by Junio.  I've taken what I think are the
best changes introduced by both versions and merged them.  The
inter-diff follows.

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b61a666..2835eef 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -383,18 +383,19 @@ ifndef::git-format-patch[]
 	that matches other criteria, nothing is selected.
 
 -S<string>::
-	Look for commits that change the number of occurrences of the
-	specified string (i.e. addition/ deletion) in a file.
+	Look for differences that change the number of occurrences of
+	the specified string (i.e. addition/deletion) in a file.
 	Intended for the scripter's use.
 +
 It is especially useful when you're looking for an exact block of code
 (like a struct), and want to know the history of that block since it
-first came into being.
+first came into being: use the feature iteratively to feed the
+interesting block in the preimage back into `-S`, and keep going until
+you get the very first version of the block.
 
 -G<regex>::
-	Grep through the patch text of commits for added/removed lines
-	that match <regex>.  `--pickaxe-regex` is implied in this
-	mode.
+	Look for differences whose patch text contains added/removed
+	lines that match <regex>.
 +
 To illustrate the difference between `-S<regex> --pickaxe-regex` and
 `-G<regex>`, consider a commit with the following diff in the same
@@ -408,7 +409,7 @@ file:
 +
 While `git log -G"regexec\(regexp"` will show this commit, `git log
 -S"regexec\(regexp" --pickaxe-regex` will not (because the number of
-occurrences of that string didn't change).
+occurrences of that string did not change).
 +
 See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
 information.
@@ -419,8 +420,8 @@ information.
 	in <string>.
 
 --pickaxe-regex::
-	Treat the <string> not as a plain string, but an extended
-	POSIX regex to match.  It is implied when `-G` is used.
+	Treat the <string> given to `-S` as an extended POSIX regular
+	expression to match.
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index d0f2b91..ef4c04a 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -225,31 +225,29 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 There are two kinds of pickaxe: the S kind (corresponding to 'git log
 -S') and the G kind (mnemonic: grep; corresponding to 'git log -G').
 
-The S kind detects filepairs whose "result" side and "origin" side
-have different number of occurrences of specified string.  By
-definition, it will not detect in-file moves.  Also, when a commit
-moves a file wholesale without affecting the string being looked at,
-rename detection kicks in as usual, and 'git log -S' omits the commit
-(since the number of occurrences of that string didn't change in that
-rename-detected filepair).  The implementation essentially runs a
-count, and is significantly cheaper than the G kind.
-
-The G kind detects filepairs whose patch text has an added or a
-deleted line that matches the given regexp.  This means that it can
-detect in-file (or what rename-detection considers the same file)
-moves.  The implementation of 'git log -G' runs diff twice and greps,
-and this can be quite expensive.
-
-When `--pickaxe-regex` is used with `-S`, treat the <string> not as a
-plain string, but an extended POSIX regex to match.  It is implied
-when `-G` is used.
-
-When `--pickaxe-all` is not in effect, diffcore-pickaxe leaves only
-the filepairs that touch the specified string in its output.  When in
-effect, diffcore-pickaxe leaves all filepairs intact if there is such
-a filepair, or makes the output empty otherwise.  The latter behavior
-is designed to make reviewing of the changes in the context of the
-whole changeset easier.
+"-S<block of text>" detects filepairs whose preimage and postimage
+have different number of occurrences of the specified block of text.
+By definition, it will not detect in-file moves.  Also, when a
+changeset moves a file wholesale without affecting the interesting
+string, rename detection kicks in as usual, and `-S` omits the
+filepair (since the number of occurrences of that string didn't change
+in that rename-detected filepair).  The implementation essentially
+runs a count, and is significantly cheaper than the G kind.  When used
+with `--pickaxe-regex`, treat the <block of text> as an extended POSIX
+regular expression to match, instead of a literal string.
+
+"-G<regular expression>" detects filepairs whose textual diff has an
+added or a deleted line that matches the given regular expression.
+This means that it can detect in-file (or what rename-detection
+considers the same file) moves.  The implementation runs diff twice
+and greps, and this can be quite expensive.
+
+When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
+that match their respective criterion are kept in the output.  When
+`--pickaxe-all` is used, if even one filepair matches their respective
+criterion in a changeset, the entire changeset is kept.  This behavior
+is designed to make reviewing changes in the context of the whole
+changeset easier.
 
 diffcore-order: For Sorting the Output Based on Filenames
 ---------------------------------------------------------


Ramkumar Ramachandra (2):
  diffcore-pickaxe: make error messages more consistent
  diffcore-pickaxe doc: document -S and -G properly

 Documentation/diff-options.txt | 38 +++++++++++++++++++++++++++++--------
 Documentation/gitdiffcore.txt  | 43 ++++++++++++++++++++++++------------------
 diffcore-pickaxe.c             |  4 ++--
 3 files changed, 57 insertions(+), 28 deletions(-)

-- 
1.8.3.rc3.17.gd95ec6c.dirty
