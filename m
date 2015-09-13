From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 8/8] branch: add '--points-at' option
Date: Sun, 13 Sep 2015 12:53:55 +0530
Message-ID: <1442129035-31386-9-git-send-email-Karthik.188@gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 09:24:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb1eV-0003n4-5r
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 09:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbbIMHYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 03:24:37 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33418 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbIMHYf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 03:24:35 -0400
Received: by pacex6 with SMTP id ex6so113675611pac.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 00:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QrshCHSmbIzPs846hHsAXTpjhJ0V52YosydyMoLsCVU=;
        b=ZnfWzWLYoSRhe2qQvo7lnHfm/vQ8FtnmEb0B5AADA2p1kRhPnK6bAohG1U3eTL3j+t
         Jaz043p4sGhN70US46A0qYblzdL/Ji+ePEl1HNGwsvvm5uxL+8PLu5lJu63Q+9FaH+uH
         Hhx6BCOwNJ9rXpzdwarHNxVFPyxdQocXp38HpFuO2atn9KGIRdCxlORJ894LFQbiIZNm
         7bIDKTt7dNDFaa9ibgS0ACdoa9vmPsOVFDNI7a5bA/bDdNt9pndpza7SPh6Bxhk5WfBL
         S6vqjRkNwq61ToC+YMzRkmWh3aWCQa8yEiJ5hW+TBGf3jpkpkrzuq7qNCNWK6bwphT37
         HJ5Q==
X-Received: by 10.66.141.199 with SMTP id rq7mr19526683pab.140.1442129074735;
        Sun, 13 Sep 2015 00:24:34 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id g5sm7688014pat.21.2015.09.13.00.24.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Sep 2015 00:24:34 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277768>

Add the '--points-at' option provided by 'ref-filter'. The option lets
the user to list only branches which points at the given object.

Add documentation and tests for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-branch.txt | 6 +++++-
 builtin/branch.c             | 7 ++++++-
 t/t3203-branch-output.sh     | 9 +++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 897cd81..211cfc3 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[--list] [-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column]
-	[(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>] [<pattern>...]
+	[(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>]
+	[--points-at <object>] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
@@ -237,6 +238,9 @@ start-point is either a local or remote-tracking branch.
 	for-each-ref`. Sort order defaults to sorting based on branch
 	type.
 
+--points-at <object>::
+	Only list branches of the given object.
+
 Examples
 --------
 
diff --git a/builtin/branch.c b/builtin/branch.c
index e0aa44c..32a0d11 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -26,6 +26,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
+	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	NULL
 };
 
@@ -652,6 +653,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
+		{
+			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
+			N_("print only branches of the object"), 0, parse_opt_object_name
+		},
 		OPT_END(),
 	};
 
@@ -680,7 +685,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
-	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE)
+	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
 		list = 1;
 
 	if (!!delete + !!rename + !!new_upstream +
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 53d166d..c819f3e 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -154,4 +154,13 @@ test_expect_success 'git branch `--sort` option' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'git branch --points-at option' '
+	cat >expect <<-\EOF &&
+	  master
+	  branch-one
+	EOF
+	git branch --points-at=branch-one >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.5.1
