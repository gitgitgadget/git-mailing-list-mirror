From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 11/11] branch: add '--points-at' option
Date: Tue, 28 Jul 2015 12:41:08 +0530
Message-ID: <1438067468-6835-2-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 09:11:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJz2p-0007es-6t
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 09:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbbG1HLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 03:11:18 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33529 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbbG1HLL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 03:11:11 -0400
Received: by padck2 with SMTP id ck2so65182100pad.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 00:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CGOtlJjodTcEj+uvJvPiBcoySCkXV10L+Y1iPmwlIws=;
        b=J+Wm81YU4AnH+1ls768Ra0ZxobVis81V8cBkDlMTBsZZ5s/SWtAi4ngTXIPeZWCbMS
         eBl6AiSbd6M+8FrZbtDgPRmAwCE599ZMinU10lQz/7mQ7KY7u3ZsAs2hvuZ2bYtsldyh
         tyjQw7/zWGwXwynyL7egE9gQsedwW5MpKRIAnb4tfXX7/cXlNcH2umJUB7H7YWfbqSeH
         4/vPqvAWgcPM/1t/vi71HTTrJHCkq/roth9k58kkWv2eO1zUBuD9p+09/3N3dFX9FRaK
         cS+uBHFa+kFwYp58fsoI+nr6pOARhPq5i6q0bxGPsZUoLikd4VnKI+mF+MmTlb/Y7fKW
         /I9A==
X-Received: by 10.66.141.232 with SMTP id rr8mr68620603pab.5.1438067470423;
        Tue, 28 Jul 2015 00:11:10 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ph4sm33197459pdb.43.2015.07.28.00.11.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 00:11:09 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274748>

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
index 897cd81..efa23a5 100644
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
+	Only list tags of the given object.
+
 Examples
 --------
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 75d8bfd..d25f43b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -26,6 +26,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
+	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	NULL
 };
 
@@ -647,6 +648,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
+		{
+			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
+			N_("print only tags of the object"), 0, parse_opt_object_name
+		},
 		OPT_END(),
 	};
 
@@ -675,7 +680,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
2.4.6
