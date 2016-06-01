From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 23/39] i18n: bisect: mark strings for translation
Date: Wed,  1 Jun 2016 16:41:13 +0000
Message-ID: <1464799289-7639-24-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:44:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89G2-0005CT-7B
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756054AbcFAQoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:44:32 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:43820 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756032AbcFAQo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:44:29 -0400
Received: (qmail 13929 invoked from network); 1 Jun 2016 16:44:25 -0000
Received: (qmail 29875 invoked from network); 1 Jun 2016 16:44:25 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:44:23 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296119>

In the last message, involving Q_(), try to mark the message in such way
that is suited for RTL (Right to Left) languages.

Update test t6030-bisect-porcelain.sh to reflect the changes.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 bisect.c                    | 56 +++++++++++++++++++++++++--------------------
 t/t6030-bisect-porcelain.sh | 22 +++++++++---------
 2 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6d93edb..a8713a8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -438,12 +438,12 @@ static void read_bisect_paths(struct argv_array *array)
 	FILE *fp = fopen(filename, "r");
 
 	if (!fp)
-		die_errno("Could not open file '%s'", filename);
+		die_errno(_("Could not open file '%s'"), filename);
 
 	while (strbuf_getline_lf(&str, fp) != EOF) {
 		strbuf_trim(&str);
 		if (sq_dequote_to_argv_array(str.buf, array))
-			die("Badly quoted content in file '%s': %s",
+			die(_("Badly quoted content in file '%s': %s"),
 			    filename, str.buf);
 	}
 
@@ -649,7 +649,7 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	print_commit_list(tried, "%s\n", "%s\n");
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
-	printf("We cannot bisect more!\n");
+	printf(_("We cannot bisect more!\n"));
 	exit(2);
 }
 
@@ -702,7 +702,7 @@ static struct commit *get_commit_reference(const unsigned char *sha1)
 {
 	struct commit *r = lookup_commit_reference(sha1);
 	if (!r)
-		die("Not a valid commit name %s", sha1_to_hex(sha1));
+		die(_("Not a valid commit name %s"), sha1_to_hex(sha1));
 	return r;
 }
 
@@ -726,27 +726,27 @@ static void handle_bad_merge_base(void)
 		char *bad_hex = oid_to_hex(current_bad_oid);
 		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 		if (!strcmp(term_bad, "bad") && !strcmp(term_good, "good")) {
-			fprintf(stderr, "The merge base %s is bad.\n"
+			fprintf(stderr, _("The merge base %s is bad.\n"
 				"This means the bug has been fixed "
-				"between %s and [%s].\n",
+				"between %s and [%s].\n"),
 				bad_hex, bad_hex, good_hex);
 		} else if (!strcmp(term_bad, "new") && !strcmp(term_good, "old")) {
-			fprintf(stderr, "The merge base %s is new.\n"
+			fprintf(stderr, _("The merge base %s is new.\n"
 				"The property has changed "
-				"between %s and [%s].\n",
+				"between %s and [%s].\n"),
 				bad_hex, bad_hex, good_hex);
 		} else {
-			fprintf(stderr, "The merge base %s is %s.\n"
+			fprintf(stderr, _("The merge base %s is %s.\n"
 				"This means the first '%s' commit is "
-				"between %s and [%s].\n",
+				"between %s and [%s].\n"),
 				bad_hex, term_bad, term_good, bad_hex, good_hex);
 		}
 		exit(3);
 	}
 
-	fprintf(stderr, "Some %s revs are not ancestor of the %s rev.\n"
+	fprintf(stderr, _("Some %s revs are not ancestor of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
-		"Maybe you mistook %s and %s revs?\n",
+		"Maybe you mistook %s and %s revs?\n"),
 		term_good, term_bad, term_good, term_bad);
 	exit(1);
 }
@@ -757,11 +757,11 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 	char *bad_hex = sha1_to_hex(current_bad_oid->hash);
 	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 
-	warning("the merge base between %s and [%s] "
+	warning(_("the merge base between %s and [%s] "
 		"must be skipped.\n"
 		"So we cannot be sure the first %s commit is "
 		"between %s and %s.\n"
-		"We continue anyway.",
+		"We continue anyway."),
 		bad_hex, good_hex, term_bad, mb_hex, bad_hex);
 	free(good_hex);
 }
@@ -792,7 +792,7 @@ static void check_merge_bases(int no_checkout)
 		} else if (0 <= sha1_array_lookup(&skipped_revs, mb)) {
 			handle_skipped_merge_base(mb);
 		} else {
-			printf("Bisecting: a merge base must be tested\n");
+			printf(_("Bisecting: a merge base must be tested\n"));
 			exit(bisect_checkout(mb, no_checkout));
 		}
 	}
@@ -843,7 +843,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	int fd;
 
 	if (!current_bad_oid)
-		die("a %s revision is needed", term_bad);
+		die(_("a %s revision is needed"), term_bad);
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -860,7 +860,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 	if (fd < 0)
-		warning_errno("could not create file '%s'",
+		warning_errno(_("could not create file '%s'"),
 			      filename);
 	else
 		close(fd);
@@ -910,7 +910,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 			*read_good = "good";
 			return;
 		} else {
-			die_errno("could not read file '%s'", filename);
+			die_errno(_("could not read file '%s'"), filename);
 		}
 	} else {
 		strbuf_getline_lf(&str, fp);
@@ -936,10 +936,11 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
 	const unsigned char *bisect_rev;
+	char steps_msg[32];
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
-		die("reading bisect refs failed");
+		die(_("reading bisect refs failed"));
 
 	check_good_are_ancestors_of_bad(prefix, no_checkout);
 
@@ -959,7 +960,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		 */
 		exit_if_skipped_commits(tried, NULL);
 
-		printf("%s was both %s and %s\n",
+		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
 		       term_bad);
@@ -967,8 +968,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	}
 
 	if (!all) {
-		fprintf(stderr, "No testable commit found.\n"
-			"Maybe you started with bad path parameters?\n");
+		fprintf(stderr, _("No testable commit found.\n"
+			"Maybe you started with bad path parameters?\n"));
 		exit(4);
 	}
 
@@ -985,9 +986,14 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	nr = all - reaches - 1;
 	steps = estimate_bisect_steps(all);
-	printf("Bisecting: %d revision%s left to test after this "
-	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
-	       steps, (steps == 1 ? "" : "s"));
+	xsnprintf(steps_msg, sizeof(steps_msg),
+		  Q_("(roughly %d step)", "(roughly %d steps)", steps),
+		  steps);
+	/* TRANSLATORS: the last %s will be replaced with
+	   "(roughly %d steps)" translation */
+	printf(Q_("Bisecting: %d revision left to test after this %s\n",
+		  "Bisecting: %d revisions left to test after this %s\n",
+		  nr), nr, steps_msg);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 7012011..86d1380 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -362,7 +362,7 @@ test_expect_success 'bisect starting with a detached HEAD' '
 test_expect_success 'bisect errors out if bad and good are mistaken' '
 	git bisect reset &&
 	test_must_fail git bisect start $HASH2 $HASH4 2> rev_list_error &&
-	grep "mistook good and bad" rev_list_error &&
+	test_i18ngrep "mistook good and bad" rev_list_error &&
 	git bisect reset
 '
 
@@ -404,7 +404,7 @@ test_expect_success 'side branch creation' '
 
 test_expect_success 'good merge base when good and bad are siblings' '
 	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
-	grep "merge base must be tested" my_bisect_log.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	git bisect good > my_bisect_log.txt &&
 	test_must_fail grep "merge base must be tested" my_bisect_log.txt &&
@@ -413,7 +413,7 @@ test_expect_success 'good merge base when good and bad are siblings' '
 '
 test_expect_success 'skipped merge base when good and bad are siblings' '
 	git bisect start "$SIDE_HASH7" "$HASH7" > my_bisect_log.txt &&
-	grep "merge base must be tested" my_bisect_log.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	git bisect skip > my_bisect_log.txt 2>&1 &&
 	grep "warning" my_bisect_log.txt &&
@@ -423,11 +423,11 @@ test_expect_success 'skipped merge base when good and bad are siblings' '
 
 test_expect_success 'bad merge base when good and bad are siblings' '
 	git bisect start "$HASH7" HEAD > my_bisect_log.txt &&
-	grep "merge base must be tested" my_bisect_log.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	test_must_fail git bisect bad > my_bisect_log.txt 2>&1 &&
-	grep "merge base $HASH4 is bad" my_bisect_log.txt &&
-	grep "fixed between $HASH4 and \[$SIDE_HASH7\]" my_bisect_log.txt &&
+	test_i18ngrep "merge base $HASH4 is bad" my_bisect_log.txt &&
+	test_i18ngrep "fixed between $HASH4 and \[$SIDE_HASH7\]" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -460,9 +460,9 @@ test_expect_success 'many merge bases creation' '
 
 test_expect_success 'good merge bases when good and bad are siblings' '
 	git bisect start "$B_HASH" "$A_HASH" > my_bisect_log.txt &&
-	grep "merge base must be tested" my_bisect_log.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
 	git bisect good > my_bisect_log2.txt &&
-	grep "merge base must be tested" my_bisect_log2.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log2.txt &&
 	{
 		{
 			grep "$SIDE_HASH5" my_bisect_log.txt &&
@@ -477,14 +477,14 @@ test_expect_success 'good merge bases when good and bad are siblings' '
 
 test_expect_success 'optimized merge base checks' '
 	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
-	grep "merge base must be tested" my_bisect_log.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
 	grep "$HASH4" my_bisect_log.txt &&
 	git bisect good > my_bisect_log2.txt &&
 	test -f ".git/BISECT_ANCESTORS_OK" &&
 	test "$HASH6" = $(git rev-parse --verify HEAD) &&
 	git bisect bad > my_bisect_log3.txt &&
 	git bisect good "$A_HASH" > my_bisect_log4.txt &&
-	grep "merge base must be tested" my_bisect_log4.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log4.txt &&
 	test_must_fail test -f ".git/BISECT_ANCESTORS_OK"
 '
 
@@ -562,7 +562,7 @@ test_expect_success 'skipping away from skipped commit' '
 
 test_expect_success 'erroring out when using bad path parameters' '
 	test_must_fail git bisect start $PARA_HASH7 $HASH1 -- foobar 2> error.txt &&
-	grep "bad path parameters" error.txt
+	test_i18ngrep "bad path parameters" error.txt
 '
 
 test_expect_success 'test bisection on bare repo - --no-checkout specified' '
-- 
2.7.3
