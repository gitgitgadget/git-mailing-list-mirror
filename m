From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 8/8] branch: add '--points-at' option
Date: Sun, 20 Sep 2015 23:40:27 +0530
Message-ID: <1442772627-25421-9-git-send-email-Karthik.188@gmail.com>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 20:10:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdj4a-000718-6F
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 20:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbbITSKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 14:10:41 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35460 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311AbbITSKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 14:10:39 -0400
Received: by pacgz1 with SMTP id gz1so11571053pac.2
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3HwFYUFkeh290mPIiO4hlpVXpzJInuLDo/L/35cQbu4=;
        b=bDsyl3HccRMqCxLODHsFFQyBJxGljmFMp4u/FqJf4pxxZoOiiY3MWueiBCyCik1206
         EIN8CMgg6NIA9rvGNHZySkVMxBOGicMnywUaOLmQOoYCDs9cDxImf6vifuooIVibwJ3p
         n/d+w5dd58DTrg04QuEhC0buCitz5Hffsi0N4Nk7/OmeDz5zzG3k8N/n4AwfVl/ziwc8
         qGgod+tmjWVnkqzhTB7bvr9/k9asfnumd70Di883qLu8cbr9y6aH8cTrz5dIkDatwzDM
         OA5ql3UCQlpFlTIyYNyvEa8mwUfMSiw5erN/mbH7TN5N2epxwegM1CXXzDuCW1ywRKo4
         VYaA==
X-Received: by 10.68.65.2 with SMTP id t2mr19375458pbs.75.1442772639058;
        Sun, 20 Sep 2015 11:10:39 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id qr5sm20037916pbb.26.2015.09.20.11.10.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 11:10:38 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278257>

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
index b87bd7b..647a9cf 100644
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
@@ -239,6 +240,9 @@ start-point is either a local or remote-tracking branch.
 	for-each-ref`. Sort order defaults to sorting based on branch
 	type.
 
+--points-at <object>::
+	Only list branches of the given object.
+
 Examples
 --------
 
diff --git a/builtin/branch.c b/builtin/branch.c
index c31d1c4..b0a96e1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -26,6 +26,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
+	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	NULL
 };
 
@@ -645,6 +646,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
+		{
+			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
+			N_("print only branches of the object"), 0, parse_opt_object_name
+		},
 		OPT_END(),
 	};
 
@@ -673,7 +678,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
-	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE)
+	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
 		list = 1;
 
 	if (!!delete + !!rename + !!new_upstream +
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index a427163..f1ae5ff 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -154,4 +154,13 @@ test_expect_success 'git branch `--sort` option' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'git branch --points-at option' '
+	cat >expect <<-\EOF &&
+	  branch-one
+	  master
+	EOF
+	git branch --points-at=branch-one >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.5.1
