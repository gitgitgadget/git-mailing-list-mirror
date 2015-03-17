From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/14] handle_revision_opt(): use skip_prefix() in many places
Date: Tue, 17 Mar 2015 17:00:06 +0100
Message-ID: <1426608016-2978-5-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:00:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtvB-00015M-KV
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbbCQQAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:39 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:46435 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932144AbbCQQAc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:32 -0400
X-AuditID: 1207440d-f79976d000005643-e9-55084f9b6aad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 86.DC.22083.B9F48055; Tue, 17 Mar 2015 12:00:27 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSf023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:27 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqDvbnyPUYEWTlUXXlW4mi4beK8wW
	t1fMZ7Z4fGsCkwOLx9/3H5g85t639Lh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6MmdfvsBXs
	M6o4dmMmewPjL40uRk4OCQETiQn7JrNC2GISF+6tZ+ti5OIQErjMKHGpqZkFJCEkcJJJ4n6b
	I4jNJqArsainmQnEFhFQk5jYdgishlkgRaLzzx12EFtYwE/i4IRDzCA2i4CqxL8FjUA17By8
	As4SR2ohVslJnD/+E6yCU8BF4sWf14wQm5wl1k6bzDaBkXcBI8MqRrnEnNJc3dzEzJzi1GTd
	4uTEvLzUIl0jvdzMEr3UlNJNjJDA4d3B+H+dzCFGAQ5GJR7eGwXsoUKsiWXFlbmHGCU5mJRE
	efM8OEKF+JLyUyozEosz4otKc1KLDzFKcDArifDecQfK8aYkVlalFuXDpKQ5WJTEedWWqPsJ
	CaQnlqRmp6YWpBbBZGU4OJQkeHX8gBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLi
	QVERXwyMC5AUD9BeG5B23uKCxFygKETrKUZFKXHeN75ACQGQREZpHtxYWDp4xSgO9KUwbwJI
	Ow8wlcB1vwIazAQ0uKWdDWRwSSJCSqqBsey/hlG68tV6xUx9/5JSPwHGIy+i0xa/47Qv3D/H
	teT0zOaqZ2q9tQqTT7OYbObM+vhzu6vx6WPxZzqVt+yyr7n/dn3NupZPjl+658ycojn51akU
	xX+sKavTjodKfskMbutY3+pXPe348b/e275EnrnuuHHmdOcN5yo3BHFtO79kzhJh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265632>

This reduces the need for "magic numbers".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 revision.c | 59 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/revision.c b/revision.c
index 66520c6..25838fc 100644
--- a/revision.c
+++ b/revision.c
@@ -1719,8 +1719,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->max_count = atoi(argv[1]);
 		revs->no_walk = 0;
 		return 2;
-	} else if (starts_with(arg, "-n")) {
-		revs->max_count = atoi(arg + 2);
+	} else if (skip_prefix(arg, "-n", &arg)) {
+		revs->max_count = atoi(arg);
 		revs->no_walk = 0;
 	} else if ((argcount = parse_long_opt("max-age", argv, &optarg))) {
 		revs->max_age = atoi(optarg);
@@ -1779,15 +1779,15 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--author-date-order")) {
 		revs->sort_order = REV_SORT_BY_AUTHOR_DATE;
 		revs->topo_order = 1;
-	} else if (starts_with(arg, "--early-output")) {
+	} else if (skip_prefix(arg, "--early-output", &arg)) {
 		int count = 100;
-		switch (arg[14]) {
+		switch (*arg++) {
 		case '=':
-			count = atoi(arg+15);
+			count = atoi(arg);
 			/* Fallthrough */
 		case 0:
 			revs->topo_order = 1;
-		       revs->early_output = count;
+			revs->early_output = count;
 		}
 	} else if (!strcmp(arg, "--parents")) {
 		revs->rewrite_parents = 1;
@@ -1804,12 +1804,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->min_parents = 2;
 	} else if (!strcmp(arg, "--no-merges")) {
 		revs->max_parents = 1;
-	} else if (starts_with(arg, "--min-parents=")) {
-		revs->min_parents = atoi(arg+14);
+	} else if (skip_prefix(arg, "--min-parents=", &arg)) {
+		revs->min_parents = atoi(arg);
 	} else if (starts_with(arg, "--no-min-parents")) {
 		revs->min_parents = 0;
-	} else if (starts_with(arg, "--max-parents=")) {
-		revs->max_parents = atoi(arg+14);
+	} else if (skip_prefix(arg, "--max-parents=", &arg)) {
+		revs->max_parents = atoi(arg);
 	} else if (starts_with(arg, "--no-max-parents")) {
 		revs->max_parents = -1;
 	} else if (!strcmp(arg, "--boundary")) {
@@ -1891,26 +1891,27 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
 		get_commit_format(NULL, revs);
-	} else if (starts_with(arg, "--pretty=") || starts_with(arg, "--format=")) {
+	} else if (skip_prefix(arg, "--pretty=", &arg) ||
+		   skip_prefix(arg, "--format=", &arg)) {
 		/*
 		 * Detached form ("--pretty X" as opposed to "--pretty=X")
 		 * not allowed, since the argument is optional.
 		 */
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
-		get_commit_format(arg+9, revs);
+		get_commit_format(arg, revs);
 	} else if (!strcmp(arg, "--show-notes") || !strcmp(arg, "--notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
 		revs->notes_opt.use_default_notes = 1;
 	} else if (!strcmp(arg, "--show-signature")) {
 		revs->show_signature = 1;
-	} else if (!strcmp(arg, "--show-linear-break") ||
-		   starts_with(arg, "--show-linear-break=")) {
-		if (starts_with(arg, "--show-linear-break="))
-			revs->break_bar = xstrdup(arg + 20);
-		else
-			revs->break_bar = "                    ..........";
+	} else if (!strcmp(arg, "--show-linear-break")) {
+		revs->break_bar = "                    ..........";
+		revs->track_linear = 1;
+		revs->track_first_time = 1;
+	} else if (skip_prefix(arg, "--show-linear-break=", &arg)) {
+		revs->break_bar = xstrdup(arg);
 		revs->track_linear = 1;
 		revs->track_first_time = 1;
 	} else if (starts_with(arg, "--show-notes=") ||
@@ -1961,8 +1962,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->abbrev = 0;
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev = DEFAULT_ABBREV;
-	} else if (starts_with(arg, "--abbrev=")) {
-		revs->abbrev = strtoul(arg + 9, NULL, 10);
+	} else if (skip_prefix(arg, "--abbrev=", &arg)) {
+		revs->abbrev = strtoul(arg, NULL, 10);
 		if (revs->abbrev < MINIMUM_ABBREV)
 			revs->abbrev = MINIMUM_ABBREV;
 		else if (revs->abbrev > 40)
@@ -2112,20 +2113,20 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
-	} else if (starts_with(arg, "--branches=")) {
+	} else if (skip_prefix(arg, "--branches=", &arg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
+		for_each_glob_ref_in(handle_one_ref, arg, "refs/heads/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (starts_with(arg, "--tags=")) {
+	} else if (skip_prefix(arg, "--tags=", &arg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
+		for_each_glob_ref_in(handle_one_ref, arg, "refs/tags/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (starts_with(arg, "--remotes=")) {
+	} else if (skip_prefix(arg, "--remotes=", &arg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
+		for_each_glob_ref_in(handle_one_ref, arg, "refs/remotes/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
@@ -2135,14 +2136,14 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		*flags ^= UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
 		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
-	} else if (starts_with(arg, "--no-walk=")) {
+	} else if (skip_prefix(arg, "--no-walk=", &arg)) {
 		/*
 		 * Detached form ("--no-walk X" as opposed to "--no-walk=X")
 		 * not allowed, since the argument is optional.
 		 */
-		if (!strcmp(arg + 10, "sorted"))
+		if (!strcmp(arg, "sorted"))
 			revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
-		else if (!strcmp(arg + 10, "unsorted"))
+		else if (!strcmp(arg, "unsorted"))
 			revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		else
 			return error("invalid argument to --no-walk");
-- 
2.1.4
