From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] fix portability issues with $ in double quotes
Date: Tue, 26 Jan 2010 15:08:31 -0800
Message-ID: <1264547311-25251-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 00:08:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZuWY-0002i3-6o
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 00:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab0AZXIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 18:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590Ab0AZXIh
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 18:08:37 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:50457 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577Ab0AZXIg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 18:08:36 -0500
Received: by ywh6 with SMTP id 6so4529525ywh.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 15:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dkllVlRvsJ5y9J2GjJMFZoVmtCS8A7NVypdaUGnzVEI=;
        b=v/92IQDPe7XqtgUqUQd5B338OqRY4/36RaSc/cvByziatZKXuBsWNRXeLXKtKJdLO9
         xZ/NLWokSlo3PzLrh6ttCrr4+LrQFbeEj6jtls5cnbAtehYYkA2s1XfC5kI5FYoi4ALm
         eI+vg6eHHvP+rIqSUhCmsaT2BFxhWbBpU6gJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=spsoOIuNWfvpEjbvNA+fpxMcKNHa80cTDm4ebjlBnto1N6bD17G2eW/2pc9/6TkYon
         c3ThOSymCjtxggnZNxj808nLBHuSQL6Aqvqm+Men/5r8o596EOCCV+qtGYZVDT9oHvA5
         e8TOCrRi/DnPZ8kSAmh93O/C6V4UVnk7kCXTw=
Received: by 10.151.58.8 with SMTP id l8mr11521788ybk.59.1264547315562;
        Tue, 26 Jan 2010 15:08:35 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 6sm2269735ywc.8.2010.01.26.15.08.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 15:08:34 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc0.8.ge3f67d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138085>

Using a dollar sign in double quotes isn't portable. Escape them with
a backslash or replace the double quotes with single quotes.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 git-filter-branch.sh            |    4 +-
 git-instaweb.sh                 |    2 +-
 git-rebase--interactive.sh      |    2 +-
 t/t3408-rebase-multi-line.sh    |    4 +-
 t/t4014-format-patch.sh         |   44 +++++++++++++++++++-------------------
 t/t4125-apply-ws-fuzz.sh        |    4 +-
 t/t4150-am.sh                   |    6 ++--
 t/t4202-log.sh                  |    6 ++--
 t/t6023-merge-file.sh           |    4 +-
 t/t7500-commit.sh               |    2 +-
 t/t9001-send-email.sh           |    8 +++---
 t/t9400-git-cvsserver-server.sh |   18 ++++++++--------
 12 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 195b5ef..81fd3db 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -462,11 +462,11 @@ if [ "$filter_tag_name" ]; then
 						"$new_sha1" "$new_ref"
 				git cat-file tag "$ref" |
 				sed -n \
-				    -e "1,/^$/{
+				    -e '1,/^$/{
 					  /^object /d
 					  /^type /d
 					  /^tag /d
-					}" \
+					}' \
 				    -e '/^-----BEGIN PGP SIGNATURE-----/q' \
 				    -e 'p' ) |
 				git mktag) ||
diff --git a/git-instaweb.sh b/git-instaweb.sh
index b8e6456..6a65f25 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -320,7 +320,7 @@ EOF
 	else
 		# plain-old CGI
 		resolve_full_httpd
-		list_mods=$(echo "$full_httpd" | sed "s/-f$/-l/")
+		list_mods=$(echo "$full_httpd" | sed 's/-f$/-l/')
 		$list_mods | sane_grep 'mod_cgi\.c' >/dev/null 2>&1 || \
 		if test -f "$module_path/mod_cgi.so"
 		then
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9187e9b..19a608c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -407,7 +407,7 @@ update_squash_messages () {
 }
 
 peek_next_command () {
-	sed -n -e "/^#/d" -e "/^$/d" -e "s/ .*//p" -e "q" < "$TODO"
+	sed -n -e "/^#/d" -e '/^$/d' -e "s/ .*//p" -e "q" < "$TODO"
 }
 
 # A squash/fixup has failed.  Prepare the long version of the squash
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index e12cd57..2062b85 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -32,8 +32,8 @@ test_expect_success rebase '
 
 	git checkout side &&
 	git rebase master &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
-	git cat-file commit side@{1} | sed -e "1,/^$/d" >expect &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit side@{1} | sed -e "1,/^\$/d" >expect &&
 	test_cmp expect actual
 
 '
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 3bc1ccc..f2a2aaa 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -93,9 +93,9 @@ test_expect_success 'extra headers' '
 	git config --add format.headers "Cc: S. E. Cipient <scipient@example.com>
 " &&
 	git format-patch --stdout master..side > patch2 &&
-	sed -e "/^$/q" patch2 > hdrs2 &&
-	grep "^To: R. E. Cipient <rcipient@example.com>$" hdrs2 &&
-	grep "^Cc: S. E. Cipient <scipient@example.com>$" hdrs2
+	sed -e "/^\$/q" patch2 > hdrs2 &&
+	grep "^To: R. E. Cipient <rcipient@example.com>\$" hdrs2 &&
+	grep "^Cc: S. E. Cipient <scipient@example.com>\$" hdrs2
 
 '
 
@@ -104,9 +104,9 @@ test_expect_success 'extra headers without newlines' '
 	git config --replace-all format.headers "To: R. E. Cipient <rcipient@example.com>" &&
 	git config --add format.headers "Cc: S. E. Cipient <scipient@example.com>" &&
 	git format-patch --stdout master..side >patch3 &&
-	sed -e "/^$/q" patch3 > hdrs3 &&
-	grep "^To: R. E. Cipient <rcipient@example.com>$" hdrs3 &&
-	grep "^Cc: S. E. Cipient <scipient@example.com>$" hdrs3
+	sed -e "/^\$/q" patch3 > hdrs3 &&
+	grep "^To: R. E. Cipient <rcipient@example.com>\$" hdrs3 &&
+	grep "^Cc: S. E. Cipient <scipient@example.com>\$" hdrs3
 
 '
 
@@ -115,32 +115,32 @@ test_expect_success 'extra headers with multiple To:s' '
 	git config --replace-all format.headers "To: R. E. Cipient <rcipient@example.com>" &&
 	git config --add format.headers "To: S. E. Cipient <scipient@example.com>" &&
 	git format-patch --stdout master..side > patch4 &&
-	sed -e "/^$/q" patch4 > hdrs4 &&
-	grep "^To: R. E. Cipient <rcipient@example.com>,$" hdrs4 &&
-	grep "^ *S. E. Cipient <scipient@example.com>$" hdrs4
+	sed -e "/^\$/q" patch4 > hdrs4 &&
+	grep "^To: R. E. Cipient <rcipient@example.com>,\$" hdrs4 &&
+	grep "^ *S. E. Cipient <scipient@example.com>\$" hdrs4
 '
 
 test_expect_success 'additional command line cc' '
 
 	git config --replace-all format.headers "Cc: R. E. Cipient <rcipient@example.com>" &&
-	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^$/q" >patch5 &&
-	grep "^Cc: R. E. Cipient <rcipient@example.com>,$" patch5 &&
-	grep "^ *S. E. Cipient <scipient@example.com>$" patch5
+	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch5 &&
+	grep "^Cc: R. E. Cipient <rcipient@example.com>,\$" patch5 &&
+	grep "^ *S. E. Cipient <scipient@example.com>\$" patch5
 '
 
 test_expect_success 'command line headers' '
 
 	git config --unset-all format.headers &&
-	git format-patch --add-header="Cc: R. E. Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^$/q" >patch6 &&
-	grep "^Cc: R. E. Cipient <rcipient@example.com>$" patch6
+	git format-patch --add-header="Cc: R. E. Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch6 &&
+	grep "^Cc: R. E. Cipient <rcipient@example.com>\$" patch6
 '
 
 test_expect_success 'configuration headers and command line headers' '
 
 	git config --replace-all format.headers "Cc: R. E. Cipient <rcipient@example.com>" &&
-	git format-patch --add-header="Cc: S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^$/q" >patch7 &&
-	grep "^Cc: R. E. Cipient <rcipient@example.com>,$" patch7 &&
-	grep "^ *S. E. Cipient <scipient@example.com>$" patch7
+	git format-patch --add-header="Cc: S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch7 &&
+	grep "^Cc: R. E. Cipient <rcipient@example.com>,\$" patch7 &&
+	grep "^ *S. E. Cipient <scipient@example.com>\$" patch7
 '
 
 test_expect_success 'multiple files' '
@@ -406,9 +406,9 @@ test_expect_success 'cover-letter inherits diff options' '
 	git mv file foo &&
 	git commit -m foo &&
 	git format-patch --cover-letter -1 &&
-	! grep "file => foo .* 0 *$" 0000-cover-letter.patch &&
+	! grep "file => foo .* 0 *\$" 0000-cover-letter.patch &&
 	git format-patch --cover-letter -1 -M &&
-	grep "file => foo .* 0 *$" 0000-cover-letter.patch
+	grep "file => foo .* 0 *\$" 0000-cover-letter.patch
 
 '
 
@@ -425,7 +425,7 @@ EOF
 test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 
 	git format-patch --cover-letter -2 &&
-	sed -e "1,/A U Thor/d" -e "/^$/q" < 0000-cover-letter.patch > output &&
+	sed -e "1,/A U Thor/d" -e "/^\$/q" < 0000-cover-letter.patch > output &&
 	test_cmp expect output
 
 '
@@ -450,7 +450,7 @@ EOF
 test_expect_success 'format-patch respects -U' '
 
 	git format-patch -U4 -2 &&
-	sed -e "1,/^$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
+	sed -e "1,/^\$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
 	test_cmp expect output
 
 '
@@ -471,7 +471,7 @@ EOF
 test_expect_success 'format-patch -p suppresses stat' '
 
 	git format-patch -p -2 &&
-	sed -e "1,/^$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
+	sed -e "1,/^\$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
 	test_cmp expect output
 
 '
diff --git a/t/t4125-apply-ws-fuzz.sh b/t/t4125-apply-ws-fuzz.sh
index 3b471b6..9671de7 100755
--- a/t/t4125-apply-ws-fuzz.sh
+++ b/t/t4125-apply-ws-fuzz.sh
@@ -37,11 +37,11 @@ test_expect_success setup '
 	# patch-2 is the same as patch-1 but is based
 	# on a version that already has whitespace fixed,
 	# and does not introduce whitespace breakages.
-	sed -e "s/ $//" patch-1 >patch-2 &&
+	sed -e "s/ \$//" patch-1 >patch-2 &&
 
 	# If all whitespace breakages are fixed the contents
 	# should look like file-fixed
-	sed -e "s/ $//" file-1 >file-fixed
+	sed -e "s/ \$//" file-1 >file-fixed
 
 '
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index a034918..810b04b 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -302,7 +302,7 @@ test_expect_success 'am --committer-date-is-author-date' '
 	git checkout first &&
 	test_tick &&
 	git am --committer-date-is-author-date patch1 &&
-	git cat-file commit HEAD | sed -e "/^$/q" >head1 &&
+	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
 	at=$(sed -ne "/^author /s/.*> //p" head1) &&
 	ct=$(sed -ne "/^committer /s/.*> //p" head1) &&
 	test "$at" = "$ct"
@@ -312,7 +312,7 @@ test_expect_success 'am without --committer-date-is-author-date' '
 	git checkout first &&
 	test_tick &&
 	git am patch1 &&
-	git cat-file commit HEAD | sed -e "/^$/q" >head1 &&
+	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
 	at=$(sed -ne "/^author /s/.*> //p" head1) &&
 	ct=$(sed -ne "/^committer /s/.*> //p" head1) &&
 	test "$at" != "$ct"
@@ -326,7 +326,7 @@ test_expect_success 'am --ignore-date' '
 	git checkout first &&
 	test_tick &&
 	git am --ignore-date patch1 &&
-	git cat-file commit HEAD | sed -e "/^$/q" >head1 &&
+	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
 	at=$(sed -ne "/^author /s/.*> //p" head1) &&
 	echo "$at" | grep "+0000"
 '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 779a5ad..1dc224f 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -255,7 +255,7 @@ EOF
 
 test_expect_success 'log --graph with merge' '
 	git log --graph --date-order --pretty=tformat:%s |
-		sed "s/ *$//" >actual &&
+		sed "s/ *\$//" >actual &&
 	test_cmp expect actual
 '
 
@@ -315,7 +315,7 @@ EOF
 test_expect_success 'log --graph with full output' '
 	git log --graph --date-order --pretty=short |
 		git name-rev --name-only --stdin |
-		sed "s/Merge:.*/Merge: A B/;s/ *$//" >actual &&
+		sed "s/Merge:.*/Merge: A B/;s/ *\$//" >actual &&
 	test_cmp expect actual
 '
 
@@ -383,7 +383,7 @@ EOF
 
 test_expect_success 'log --graph with merge' '
 	git log --graph --date-order --pretty=tformat:%s |
-		sed "s/ *$//" >actual &&
+		sed "s/ *\$//" >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 7dcf391..6291307 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -146,8 +146,8 @@ test_expect_success 'binary files cannot be merged' '
 	grep "Cannot merge binary files" merge.err
 '
 
-sed -e "s/deerit.$/deerit;/" -e "s/me;$/me./" < new5.txt > new6.txt
-sed -e "s/deerit.$/deerit,/" -e "s/me;$/me,/" < new5.txt > new7.txt
+sed -e "s/deerit.\$/deerit;/" -e "s/me;\$/me./" < new5.txt > new6.txt
+sed -e "s/deerit.\$/deerit,/" -e "s/me;\$/me,/" < new5.txt > new7.txt
 
 test_expect_success 'MERGE_ZEALOUS simplifies non-conflicts' '
 
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 8eec0fa..9f5c3ed 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -150,7 +150,7 @@ EOF
 test_expect_success '--signoff' '
 	echo "yet another content *narf*" >> foo &&
 	echo "zort" | git commit -s -F - foo &&
-	git cat-file commit HEAD | sed "1,/^$/d" > output &&
+	git cat-file commit HEAD | sed "1,/^\$/d" > output &&
 	test_cmp expect output
 '
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 752adaa..c09f375 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -186,8 +186,8 @@ test_expect_success 'Prompting works' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches \
 		2>errors &&
-		grep "^From: Example <from@example.com>$" msgtxt1 &&
-		grep "^To: to@example.com$" msgtxt1
+		grep "^From: Example <from@example.com>\$" msgtxt1 &&
+		grep "^To: to@example.com\$" msgtxt1
 '
 
 test_expect_success 'cccmd works' '
@@ -236,7 +236,7 @@ test_expect_success 'Author From: in message body' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
-	sed "1,/^$/d" < msgtxt1 > msgbody1
+	sed "1,/^\$/d" < msgtxt1 > msgbody1
 	grep "From: A <author@example.com>" msgbody1
 '
 
@@ -247,7 +247,7 @@ test_expect_success 'Author From: not in message body' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
-	sed "1,/^$/d" < msgtxt1 > msgbody1
+	sed "1,/^\$/d" < msgtxt1 > msgbody1
 	! grep "From: A <author@example.com>" msgbody1
 '
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index c2ec3cb..4327eb8 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -96,7 +96,7 @@ EOF
 
 test_expect_success 'pserver authentication' \
   'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU\$"'
 
 test_expect_success 'pserver authentication failure (non-anonymous user)' \
   'if cat request-git | git-cvsserver pserver >log 2>&1
@@ -105,11 +105,11 @@ test_expect_success 'pserver authentication failure (non-anonymous user)' \
    else
        true
    fi &&
-   sed -ne \$p log | grep "^I HATE YOU$"'
+   sed -ne \$p log | grep "^I HATE YOU\$"'
 
 test_expect_success 'pserver authentication (login)' \
   'cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU\$"'
 
 test_expect_success 'pserver authentication failure (login/non-anonymous user)' \
   'if cat login-git | git-cvsserver pserver >log 2>&1
@@ -118,7 +118,7 @@ test_expect_success 'pserver authentication failure (login/non-anonymous user)'
    else
        true
    fi &&
-   sed -ne \$p log | grep "^I HATE YOU$"'
+   sed -ne \$p log | grep "^I HATE YOU\$"'
 
 
 # misuse pserver authentication for testing of req_Root
@@ -156,7 +156,7 @@ test_expect_success 'req_Root failure (conflicting roots)' \
 
 test_expect_success 'req_Root (strict paths)' \
   'cat request-anonymous | git-cvsserver --strict-paths pserver "$SERVERDIR" >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU\$"'
 
 test_expect_success 'req_Root failure (strict-paths)' '
     ! cat request-anonymous |
@@ -165,7 +165,7 @@ test_expect_success 'req_Root failure (strict-paths)' '
 
 test_expect_success 'req_Root (w/o strict-paths)' \
   'cat request-anonymous | git-cvsserver pserver "$WORKDIR/" >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU\$"'
 
 test_expect_success 'req_Root failure (w/o strict-paths)' '
     ! cat request-anonymous |
@@ -183,7 +183,7 @@ EOF
 
 test_expect_success 'req_Root (base-path)' \
   'cat request-base | git-cvsserver --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU\$"'
 
 test_expect_success 'req_Root failure (base-path)' '
     ! cat request-anonymous |
@@ -194,14 +194,14 @@ GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false || exit 1
 
 test_expect_success 'req_Root (export-all)' \
   'cat request-anonymous | git-cvsserver --export-all pserver "$WORKDIR" >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU\$"'
 
 test_expect_success 'req_Root failure (export-all w/o whitelist)' \
   '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
 
 test_expect_success 'req_Root (everything together)' \
   'cat request-base | git-cvsserver --export-all --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU$"'
+   sed -ne \$p log | grep "^I LOVE YOU\$"'
 
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true || exit 1
 
-- 
1.7.0.rc0.8.ge3f67d
