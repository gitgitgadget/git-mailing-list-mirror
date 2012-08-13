From: y@google.com
Subject: [PATCH 1/4] teach log --no-walk=unsorted, which avoids sorting
Date: Sun, 12 Aug 2012 23:27:17 -0700
Message-ID: <50289e50.0aad320a.5916.39eaSMTPIN_ADDED@gmr-mx.google.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <1344839240-17402-1-git-send-email-y>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 08:27:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0o7l-000715-3P
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 08:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab2HMG1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 02:27:30 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:35547 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab2HMG13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 02:27:29 -0400
Received: by obbwc20 with SMTP id wc20so2563648obb.1
        for <git@vger.kernel.org>; Sun, 12 Aug 2012 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VD5nHKQRvbHjyEMpcaiMziL7fXcynM/LptqVPjSu60E=;
        b=E5MDEiBcZ3sj3fpm6gD0uKYOR0HGvSgXbY0Sk0xyLsYdGeCCDMITgcIq327dqYK72V
         ChzAR6ZCP9P5RkLXuAspbfxqmQgpH2Uflq7N0e4gN0uSB4Q8TjVMUwGQ9Gjyp+72IqDR
         xyqy2F513E8r2dD64vbsdt3m4JfdIBQlNJ/hnNVjo8LaMjS8H12r/zEfZK1PeKTmuRld
         Wd9EAkBopmgVGMbO+xJd1z7nM6+5t1AGbuzBgm1NAqdSmd9dbKGpYBpizzJyq30PsVxG
         D0ig6NtkBdjO4BKtDzSRDoA126ECVdt4FkJuiAjUzUAM4/Qc+58gbvafOsuUdmlDuoGG
         D2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=VD5nHKQRvbHjyEMpcaiMziL7fXcynM/LptqVPjSu60E=;
        b=e9YY8j1jnyygX1A7DyPBKfETbbDfLd4GbxQsuZ5W0pILBNCQkYIAj04FIRb8AV/JKf
         cs349vyG5MDdXfByodxQLCuH+Vb8FsViGF4imbQCAeF5arcQzjM9Kobdz+o8KNlm6RSd
         N1xclZmVK6ZM4du2B7UjCKF44aoPsgfofaJS6cTkqrQm1EPyntWSs+2/5uQThuaUJRhB
         XPPVz59YPaokEwzXX9GGkKW1AfHv22/qLXx1Bp8IbavXOWC7wFnOz3m5QQyYe+J5WMuh
         PT5JvmCaXizksx9YNfIC5Y/9LqZ7pZXv54KzeeBN4YDZ5Haw5M0qiwruWyVdwZg4OQM7
         gGJA==
Received: by 10.42.136.202 with SMTP id v10mr2762065ict.4.1344839248957;
        Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: by 10.42.136.202 with SMTP id v10mr2762056ict.4.1344839248895;
        Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id bg10si1890512igc.3.2012.08.12.23.27.28
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 6A8AE1E0048;
	Sun, 12 Aug 2012 23:27:28 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id DA7F8C1513; Sun, 12 Aug 2012 23:27:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1344839240-17402-1-git-send-email-y>
X-Gm-Message-State: ALoCoQmf5ofvttjycyQbHhbkl6jhcL0DdSx18k738tjjq5Y7eDwcTbfkGhkaeMePlzkawIfhkWhdF4odhDNxKqFfrd1FuXQUxP4p5ms/83R/851aThmbKluRKEV9eLxn9wzE9S2ir54ztfAJ2gGEavjNaoPgrXlzw3yxI8OySodyL8r6fZ19Mu+tvPPIM+SNQuAQ/Lq9+Gnh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203323>

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

When 'git log' is passed the --no-walk option, no revision walk takes
place, naturally. Perhaps somewhat surprisingly, however, the provided
revisions still get sorted by commit date. So e.g 'git log --no-walk
HEAD HEAD~1' and 'git log --no-walk HEAD~1 HEAD' give the same result
(unless the two revisions share the commit date, in which case they
will retain the order given on the command line). As the commit that
introduced --no-walk (8e64006 (Teach revision machinery about
--no-walk, 2007-07-24)) points out, the sorting is intentional, to
allow things like

 git log --abbrev-commit --pretty=oneline --decorate --all --no-walk

to show all refs in order by commit date.

But there are also other cases where the sorting is not wanted, such
as

 <command producing revisions in order> |
       git log --oneline --no-walk --stdin

To accomodate both cases, leave the decision of whether or not to sort
up to the caller, by allowing --no-walk={sorted,unsorted}, defaulting
to 'sorted'.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 builtin/log.c    |  2 +-
 builtin/revert.c |  2 +-
 revision.c       | 18 +++++++++++++++---
 revision.h       |  6 +++++-
 t/t4202-log.sh   | 10 ++++++++++
 5 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ecc2793..20838b1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -456,7 +456,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.always_show_header = 1;
-	rev.no_walk = 1;
+	rev.no_walk = REVISION_WALK_NO_WALK_SORTED;
 	rev.diffopt.stat_width = -1; 	/* Scale to real terminal size */
 
 	memset(&opt, 0, sizeof(opt));
diff --git a/builtin/revert.c b/builtin/revert.c
index 82d1bf8..42ce399 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -193,7 +193,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
 		init_revisions(opts->revs, NULL);
-		opts->revs->no_walk = 1;
+		opts->revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
diff --git a/revision.c b/revision.c
index 9e8f47a..2faf675 100644
--- a/revision.c
+++ b/revision.c
@@ -1298,7 +1298,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk") ||
 	    !strcmp(arg, "--bisect") || !prefixcmp(arg, "--glob=") ||
 	    !prefixcmp(arg, "--branches=") || !prefixcmp(arg, "--tags=") ||
-	    !prefixcmp(arg, "--remotes="))
+	    !prefixcmp(arg, "--remotes=") || !prefixcmp(arg, "--no-walk="))
 	{
 		unkv[(*unkc)++] = arg;
 		return 1;
@@ -1693,7 +1693,18 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^= UNINTERESTING;
 	} else if (!strcmp(arg, "--no-walk")) {
-		revs->no_walk = 1;
+		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
+	} else if (!prefixcmp(arg, "--no-walk=")) {
+		/*
+		 * Detached form ("--no-walk X" as opposed to "--no-walk=X")
+		 * not allowed, since the argument is optional.
+		 */
+		if (!strcmp(arg + 10, "sorted"))
+			revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
+		else if (!strcmp(arg + 10, "unsorted"))
+			revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
+		else
+			return error("invalid argument to --no-walk");
 	} else if (!strcmp(arg, "--do-walk")) {
 		revs->no_walk = 0;
 	} else {
@@ -2116,10 +2127,11 @@ int prepare_revision_walk(struct rev_info *revs)
 		}
 		e++;
 	}
-	commit_list_sort_by_date(&revs->commits);
 	if (!revs->leak_pending)
 		free(list);
 
+	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
+		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
 		return 0;
 	if (revs->limited)
diff --git a/revision.h b/revision.h
index cb5ab35..a95bd0b 100644
--- a/revision.h
+++ b/revision.h
@@ -41,6 +41,10 @@ struct rev_cmdline_info {
 	} *rev;
 };
 
+#define REVISION_WALK_WALK 0
+#define REVISION_WALK_NO_WALK_SORTED 1
+#define REVISION_WALK_NO_WALK_UNSORTED 2
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -62,7 +66,7 @@ struct rev_info {
 	/* Traversal flags */
 	unsigned int	dense:1,
 			prune:1,
-			no_walk:1,
+			no_walk:2,
 			show_all:1,
 			remove_empty_trees:1,
 			simplify_history:1,
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 71be59d..bd83355 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -178,11 +178,21 @@ test_expect_success 'git log --no-walk <commits> sorts by commit time' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git log --no-walk=sorted <commits> sorts by commit time' '
+	git log --no-walk=sorted --oneline 5d31159 804a787 394ef78 > actual &&
+	test_cmp expect actual
+'
+
 cat > expect << EOF
 5d31159 fourth
 804a787 sixth
 394ef78 fifth
 EOF
+test_expect_success 'git log --no-walk=unsorted <commits> leaves list of commits as given' '
+	git log --no-walk=unsorted --oneline 5d31159 804a787 394ef78 > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git show <commits> leaves list of commits as given' '
 	git show --oneline -s 5d31159 804a787 394ef78 > actual &&
 	test_cmp expect actual
-- 
1.7.11.1.104.ge7b44f1
