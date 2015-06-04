From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH 2/3] bisect: use name_(bad|good) instead of bisect_(bad|good)
Date: Thu,  4 Jun 2015 09:59:12 +0200
Message-ID: <1433404753-12039-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
References: <1433404753-12039-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: thomasxnguy@gmail.com, valentinduperray@gmail.com,
	remi.lespinet@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 09:59:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Q3q-0002nF-GH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 09:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbbFDH7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 03:59:31 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:60973 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750805AbbFDH7Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 03:59:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0BEE827F1;
	Thu,  4 Jun 2015 09:59:22 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dYg+4NZUEZ+T; Thu,  4 Jun 2015 09:59:21 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id EF89A27EF;
	Thu,  4 Jun 2015 09:59:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id EB33F20DC;
	Thu,  4 Jun 2015 09:59:21 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xg1TCvmjbmcM; Thu,  4 Jun 2015 09:59:21 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id D9C9320D4;
	Thu,  4 Jun 2015 09:59:21 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1433404753-12039-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270752>

From: Christian Couder <chriscool@tuxfamily.org>

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
---
 bisect.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/bisect.c b/bisect.c
index d6c19fd..68417bb 100644
--- a/bisect.c
+++ b/bisect.c
@@ -21,8 +21,8 @@ static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 static const char *argv_update_ref[] = {"update-ref", "--no-deref", "BISECT_HEAD", NULL, NULL};
 
-static const char *bisect_bad;
-static const char *bisect_good;
+static const char *name_bad;
+static const char *name_good;
 
 /* Remember to update object flag allocation in object.h */
 #define COUNTED		(1u<<16)
@@ -406,7 +406,7 @@ struct commit_list *find_bisection(struct commit_list *list,
 static int register_ref(const char *refname, const unsigned char *sha1,
 			int flags, void *cb_data)
 {
-	if (!strcmp(refname, bisect_bad)) {
+	if (!strcmp(refname, name_bad)) {
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
 		hashcpy(current_bad_oid->hash, sha1);
 	} else if (starts_with(refname, "good-") ||
@@ -638,7 +638,7 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 		return;
 
 	printf("There are only 'skip'ped commits left to test.\n"
-	       "The first %s commit could be any of:\n", bisect_bad);
+	       "The first %s commit could be any of:\n", name_bad);
 	print_commit_list(tried, "%s\n", "%s\n");
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
@@ -736,7 +736,7 @@ static void handle_bad_merge_base(void)
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
 		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
-		if (!strcmp(bisect_bad,"bad")) {
+		if (!strcmp(name_bad,"bad")) {
 			fprintf(stderr, "The merge base %s is bad.\n"
 				"This means the bug has been fixed "
 				"between %s and [%s].\n",
@@ -753,8 +753,7 @@ static void handle_bad_merge_base(void)
 	fprintf(stderr, "Some %s revs are not ancestor of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
 		"Maybe you mistook %s and %s revs?\n",
-		bisect_good, bisect_bad, bisect_good,
-		bisect_bad);
+		name_good, name_bad, name_good, name_bad);
 	exit(1);
 }
 
@@ -769,7 +768,7 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 		"So we cannot be sure the first %s commit is "
 		"between %s and %s.\n"
 		"We continue anyway.",
-		bad_hex, good_hex, bisect_bad, mb_hex, bad_hex);
+		bad_hex, good_hex, name_bad, mb_hex, bad_hex);
 	free(good_hex);
 }
 
@@ -850,7 +849,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	int fd;
 
 	if (!current_bad_oid)
-		die("a %s revision is needed", bisect_bad);
+		die("a %s revision is needed", name_bad);
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -913,13 +912,13 @@ void read_bisect_terms(void)
 	FILE *fp = fopen(filename, "r");
 
 	if (!fp) {
-		bisect_bad = "bad";
-		bisect_good = "good";
+		name_bad = "bad";
+		name_good = "good";
 	} else {
 	strbuf_getline(&str, fp, '\n');
-	bisect_bad = strbuf_detach(&str, NULL);
+	name_bad = strbuf_detach(&str, NULL);
 	strbuf_getline(&str, fp, '\n');
-	bisect_good = strbuf_detach(&str, NULL);
+	name_good = strbuf_detach(&str, NULL);
 	}
 	strbuf_release(&str);
 	fclose(fp);
@@ -965,8 +964,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 		printf("%s was both %s and %s\n",
 		       oid_to_hex(current_bad_oid),
-		       bisect_good,
-		       bisect_bad);
+		       name_good,
+		       name_bad);
 		exit(1);
 	}
 
@@ -982,7 +981,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
 		printf("%s is the first %s commit\n", bisect_rev_hex,
-			bisect_bad);
+			name_bad);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
 		exit(10);
@@ -994,8 +993,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
 	       steps, (steps == 1 ? "" : "s"));
 
-	free((char*)bisect_bad);
-	free((char*)bisect_good);
+	free((char*)name_bad);
+	free((char*)name_good);
 
 	return bisect_checkout(bisect_rev_hex, no_checkout);
 }
-- 
2.4.1.173.gd47f443.dirty
