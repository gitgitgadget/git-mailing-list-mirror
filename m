From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/86] revision: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:00 +0100
Message-ID: <20131109070720.18178.44053.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:12:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2iS-0006NE-Ds
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933376Ab3KIHLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:35 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36278 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933224Ab3KIHIX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:23 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 3E4E03A;
	Sat,  9 Nov 2013 08:08:22 +0100 (CET)
X-git-sha1: 36e625a9a0aa0e3c75756dbe5489250adeb9ac5f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237542>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 revision.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/revision.c b/revision.c
index 0173e01..968320a 100644
--- a/revision.c
+++ b/revision.c
@@ -1576,9 +1576,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	    !strcmp(arg, "--tags") || !strcmp(arg, "--remotes") ||
 	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
 	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk") ||
-	    !strcmp(arg, "--bisect") || !prefixcmp(arg, "--glob=") ||
-	    !prefixcmp(arg, "--branches=") || !prefixcmp(arg, "--tags=") ||
-	    !prefixcmp(arg, "--remotes=") || !prefixcmp(arg, "--no-walk="))
+	    !strcmp(arg, "--bisect") || has_prefix(arg, "--glob=") ||
+	    has_prefix(arg, "--branches=") || has_prefix(arg, "--tags=") ||
+	    has_prefix(arg, "--remotes=") || has_prefix(arg, "--no-walk="))
 	{
 		unkv[(*unkc)++] = arg;
 		return 1;
@@ -1601,7 +1601,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->max_count = atoi(argv[1]);
 		revs->no_walk = 0;
 		return 2;
-	} else if (!prefixcmp(arg, "-n")) {
+	} else if (has_prefix(arg, "-n")) {
 		revs->max_count = atoi(arg + 2);
 		revs->no_walk = 0;
 	} else if ((argcount = parse_long_opt("max-age", argv, &optarg))) {
@@ -1661,7 +1661,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--author-date-order")) {
 		revs->sort_order = REV_SORT_BY_AUTHOR_DATE;
 		revs->topo_order = 1;
-	} else if (!prefixcmp(arg, "--early-output")) {
+	} else if (has_prefix(arg, "--early-output")) {
 		int count = 100;
 		switch (arg[14]) {
 		case '=':
@@ -1686,13 +1686,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->min_parents = 2;
 	} else if (!strcmp(arg, "--no-merges")) {
 		revs->max_parents = 1;
-	} else if (!prefixcmp(arg, "--min-parents=")) {
+	} else if (has_prefix(arg, "--min-parents=")) {
 		revs->min_parents = atoi(arg+14);
-	} else if (!prefixcmp(arg, "--no-min-parents")) {
+	} else if (has_prefix(arg, "--no-min-parents")) {
 		revs->min_parents = 0;
-	} else if (!prefixcmp(arg, "--max-parents=")) {
+	} else if (has_prefix(arg, "--max-parents=")) {
 		revs->max_parents = atoi(arg+14);
-	} else if (!prefixcmp(arg, "--no-max-parents")) {
+	} else if (has_prefix(arg, "--no-max-parents")) {
 		revs->max_parents = -1;
 	} else if (!strcmp(arg, "--boundary")) {
 		revs->boundary = 1;
@@ -1742,7 +1742,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->verify_objects = 1;
 	} else if (!strcmp(arg, "--unpacked")) {
 		revs->unpacked = 1;
-	} else if (!prefixcmp(arg, "--unpacked=")) {
+	} else if (has_prefix(arg, "--unpacked=")) {
 		die("--unpacked=<packfile> no longer supported.");
 	} else if (!strcmp(arg, "-r")) {
 		revs->diff = 1;
@@ -1767,7 +1767,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
 		get_commit_format(arg+8, revs);
-	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
+	} else if (has_prefix(arg, "--pretty=") || has_prefix(arg, "--format=")) {
 		/*
 		 * Detached form ("--pretty X" as opposed to "--pretty=X")
 		 * not allowed, since the argument is optional.
@@ -1781,12 +1781,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->notes_opt.use_default_notes = 1;
 	} else if (!strcmp(arg, "--show-signature")) {
 		revs->show_signature = 1;
-	} else if (!prefixcmp(arg, "--show-notes=") ||
-		   !prefixcmp(arg, "--notes=")) {
+	} else if (has_prefix(arg, "--show-notes=") ||
+		   has_prefix(arg, "--notes=")) {
 		struct strbuf buf = STRBUF_INIT;
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
-		if (!prefixcmp(arg, "--show-notes")) {
+		if (has_prefix(arg, "--show-notes")) {
 			if (revs->notes_opt.use_default_notes < 0)
 				revs->notes_opt.use_default_notes = 1;
 			strbuf_addstr(&buf, arg+13);
@@ -1829,7 +1829,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->abbrev = 0;
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev = DEFAULT_ABBREV;
-	} else if (!prefixcmp(arg, "--abbrev=")) {
+	} else if (has_prefix(arg, "--abbrev=")) {
 		revs->abbrev = strtoul(arg + 9, NULL, 10);
 		if (revs->abbrev < MINIMUM_ABBREV)
 			revs->abbrev = MINIMUM_ABBREV;
@@ -1968,15 +1968,15 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref(handle_one_ref, optarg, &cb);
 		return argcount;
-	} else if (!prefixcmp(arg, "--branches=")) {
+	} else if (has_prefix(arg, "--branches=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
-	} else if (!prefixcmp(arg, "--tags=")) {
+	} else if (has_prefix(arg, "--tags=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
-	} else if (!prefixcmp(arg, "--remotes=")) {
+	} else if (has_prefix(arg, "--remotes=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
@@ -1986,7 +1986,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		*flags ^= UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
 		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
-	} else if (!prefixcmp(arg, "--no-walk=")) {
+	} else if (has_prefix(arg, "--no-walk=")) {
 		/*
 		 * Detached form ("--no-walk X" as opposed to "--no-walk=X")
 		 * not allowed, since the argument is optional.
-- 
1.8.4.1.566.geca833c
