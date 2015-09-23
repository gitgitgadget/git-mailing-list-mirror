From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 8/8] branch: add '--points-at' option
Date: Wed, 23 Sep 2015 23:41:13 +0530
Message-ID: <1443031873-25280-9-git-send-email-Karthik.188@gmail.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 20:11:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeoW4-0001pw-8L
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 20:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbbIWSL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 14:11:27 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33793 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbbIWSLY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 14:11:24 -0400
Received: by padhy16 with SMTP id hy16so47094377pad.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r6sZqw7n7bZn7vu8rQf8KKfOuApZ24btliSLsCrGaVk=;
        b=fIJoTzK0J3iAwo+I53GNDs6yy8Phf5by6/po3hsLwABBCHlyPZy9qDUfxDIIlSBddE
         4SVLNqTO0u0tBV6b93vsKSb3ZQpBkIZvTdE3qOCX2S17erTGKvIJql4zS5k+Z/f0UX3L
         VXZ/5MAtfzg8zttQ5BntETeXzOqQCgCei7dPrF9OGO8t81gEDfQoKLiKF9FdxBoRxtKp
         pntF6SL+GIp1FlKPVf6qXO8MncINymb9h3OdgkVWmcPA0OpphkwtPjv7zktFUHIA0W9/
         1XtRKvBjjJFR4hVrhJEID28/iTHSQMlnyq2mpQaYmvsebQxn/d+0qYEuYaQ8wucPD6Hr
         t+sQ==
X-Received: by 10.68.103.5 with SMTP id fs5mr39305843pbb.55.1443031884224;
        Wed, 23 Sep 2015 11:11:24 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id bs3sm9107777pbd.89.2015.09.23.11.11.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Sep 2015 11:11:23 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278500>

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
index c45295d..03c7af1 100644
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
@@ -240,6 +241,9 @@ start-point is either a local or remote-tracking branch.
 	finally remote-tracking branches.
 
 
+--points-at <object>::
+	Only list branches of the given object.
+
 Examples
 --------
 
diff --git a/builtin/branch.c b/builtin/branch.c
index b83116a..b7a60f4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -26,6 +26,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
+	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	NULL
 };
 
@@ -646,6 +647,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
+		{
+			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
+			N_("print only branches of the object"), 0, parse_opt_object_name
+		},
 		OPT_END(),
 	};
 
@@ -674,7 +679,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
