From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] cat-file: add short option '-c' for 'cat-file --textconv'
Date: Fri,  9 Jan 2015 14:47:59 +0600
Message-ID: <1420793279-27853-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 09:55:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9VEx-0001TD-WF
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 09:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbbAIIsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 03:48:11 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:57657 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699AbbAIIsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 03:48:09 -0500
Received: by mail-lb0-f176.google.com with SMTP id p9so7058039lbv.7
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 00:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5YzP3NmMHaorBHZadmagHCtyXOMfaIYVVRSIdnbY4W8=;
        b=Drvpts3mr/p+rIclkZLrYegOPmDCO2X0qMhxXQOEr/dTNgUE3CNpEsL/h+4n55xeFP
         +sNpBkQls03M5dm1U6AijTySWV7uNLyoKRoYJELpvDYNowHE44srgUl5G7cxGAMsPxFa
         hTwpaaKLF6CHDejywfChZ/st0emSBgVqFchGfafvd18ADq/6Ga60V/9QhNO0hwW8B1od
         0qtDw5EvgbjM5+waUQWnqsJwoxWnguecL+Ss1INxGv6cku6coLt79QI8DHX5w05oi0Gd
         0c/T3TXx2sK0zj8jHedoX5UyuAs0zAlRJanCs6/DDcOiviB70cnda1ws6DYasdvi856h
         16wg==
X-Received: by 10.112.167.228 with SMTP id zr4mr20331594lbb.20.1420793288270;
        Fri, 09 Jan 2015 00:48:08 -0800 (PST)
Received: from localhost.localdomain ([92.46.69.16])
        by mx.google.com with ESMTPSA id wq1sm1717313lbb.24.2015.01.09.00.48.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jan 2015 00:48:07 -0800 (PST)
X-Mailer: git-send-email 2.2.1.522.g2561c04.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262237>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-cat-file.txt |  5 +++--
 builtin/cat-file.c             |  4 ++--
 t/t8007-cat-file-textconv.sh   | 10 ++++++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f6a16f4..b346a5d 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,14 +9,14 @@ git-cat-file - Provide content or type and size information for repository objec
 SYNOPSIS
 --------
 [verse]
-'git cat-file' (-t | -s | -e | -p | <type> | --textconv ) <object>
+'git cat-file' (-t | -s | -e | -p | <type> | (-c | --textconv) ) <object>
 'git cat-file' (--batch | --batch-check) < <list-of-objects>
 
 DESCRIPTION
 -----------
 In its first form, the command provides the content or the type of an object in
 the repository. The type is required unless '-t' or '-p' is used to find the
-object type, or '-s' is used to find the object size, or '--textconv' is used
+object type, or '-s' is used to find the object size, or '-c/--textconv' is used
 (which implies type "blob").
 
 In the second form, a list of objects (separated by linefeeds) is provided on
@@ -52,6 +52,7 @@ OPTIONS
 	or to ask for a "blob" with <object> being a tag object that
 	points at it.
 
+-c
 --textconv::
 	Show the content as transformed by a textconv filter. In this case,
 	<object> has be of the form <tree-ish>:<path>, or :<path> in order
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f8d8129..a8154a0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -329,7 +329,7 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t|-s|-e|-p|<type>|--textconv) <object>"),
+	N_("git cat-file (-t|-s|-e|-p|<type>|(-c|--textconv)) <object>"),
 	N_("git cat-file (--batch|--batch-check) < <list_of_objects>"),
 	NULL
 };
@@ -373,7 +373,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('e', NULL, &opt,
 			    N_("exit with zero when there's no error"), 'e'),
 		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
-		OPT_SET_INT(0, "textconv", &opt,
+		OPT_SET_INT('c', "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index eacd49a..994c5b0 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -24,6 +24,11 @@ bin: test version 2
 EOF
 
 test_expect_success 'no filter specified' '
+	git cat-file -c :one.bin >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'no filter specified' '
 	git cat-file --textconv :one.bin >result &&
 	test_cmp expected result
 '
@@ -52,6 +57,11 @@ cat >expected <<EOF
 converted: test version 2
 EOF
 
+test_expect_success 'cat-file -c on last commit' '
+	git cat-file -c :one.bin >result &&
+	test_cmp expected result
+'
+
 test_expect_success 'cat-file --textconv on last commit' '
 	git cat-file --textconv :one.bin >result &&
 	test_cmp expected result
-- 
2.2.1.522.g2561c04.dirty
