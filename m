From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 09/10] branch: add '--points-at' option
Date: Tue,  4 Aug 2015 18:31:22 +0530
Message-ID: <1438693282-15516-9-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:01:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbqq-0003P5-Ss
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934029AbbHDNBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:01:45 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:32818 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934006AbbHDNBm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:01:42 -0400
Received: by pdbnt7 with SMTP id nt7so4285726pdb.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=loQwgmS8F3H+TJzdvbLRsUE9Oyr137Rpn9h4lKp0hqA=;
        b=Zft4pYQbLYPT9FPfI3Rll+PPYu+5XquTLSkNhUPA6utrm7pswN3Mc4FsOGxnwUVakG
         s5e5mGnvj/+RTeZlBuoVod5/W8zhMIpPXXZS3UciHCGD1zQKt0l4fHSzpTfozyKTI6wy
         /RYjmP8M6MIYrAHSwYhNG6LeBS5o/0ct+hgbjjppjSQ4zcrAhOHEhLfbrR2r0WwZ5LxG
         NOiMS4igpS54usFHqKqH0he1nmO6j7WeCAENtLZcs8int+zGpP1sb1bnyY4Cb1mnnH+8
         3z+ADvSD9drKDXLSXbk5uxxWp+aMwGLtWKDvaWo2vnigqsnj9ZI5PIyLFNaqkMW7Gy/c
         c4zA==
X-Received: by 10.70.135.129 with SMTP id ps1mr7591348pdb.110.1438693301489;
        Tue, 04 Aug 2015 06:01:41 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uy6sm1450657pbc.13.2015.08.04.06.01.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:01:40 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275270>

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
index 34ccf0c..5dad1da 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -26,6 +26,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
+	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	NULL
 };
 
@@ -654,6 +655,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
+		{
+			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
+			N_("print only branches of the object"), 0, parse_opt_object_name
+		},
 		OPT_END(),
 	};
 
@@ -682,7 +687,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
-	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE)
+	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
 		list = 1;
 
 	if (!!delete + !!rename + !!new_upstream +
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 38c68bd..1deb7cb 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -154,4 +154,13 @@ EOF
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'git branch --points-at option' '
+	cat >expect <<EOF &&
+  master
+  branch-one
+EOF
+	git branch --points-at=branch-one >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.5.0
