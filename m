From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/6] t8001/t8002 (blame): modernize style
Date: Wed, 17 Jul 2013 17:25:28 -0400
Message-ID: <1374096332-7891-3-git-send-email-sunshine@sunshineco.com>
References: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 23:26:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzZEq-0003tI-8F
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 23:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399Ab3GQV0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 17:26:09 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:37579 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab3GQV0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 17:26:07 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so3271996oag.31
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=NdEEosx0zxjdXN2a2WSliE4TkJFl5gkeMS0uHNlrlpE=;
        b=nObrHUDV7yiOb4B1R4LTngudRa0tCSPyVzu59hUVkeBrGAt6r+FSAyH2ClHQ1Hpmzx
         w4pER4zqKyQuPLm2PsUPwfO3Iby5F9KE+qSqAnLiCw/BrtXkBqoFyHfIic/HqyW0LPTV
         u4q4h9LLxPU71cBeF3zqAGXfPQwDSJoWrrW8bk0Puc5C6gLDkB53r8ZSX5EdWsHhXIWa
         7+TgK+sBWOpHZoSAxS2tENlX3i/588PhP3MmO9fy0ypwIiExSBsRkaooI93AwT0J1cVq
         hFn0uHfenZkUVDgWKvd0iFA25/k31Uymh3mIsTLlI4jWvLFp6orNKyRryUxe6IzlsehF
         hk7A==
X-Received: by 10.60.56.82 with SMTP id y18mr10341504oep.86.1374096367416;
        Wed, 17 Jul 2013 14:26:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ps5sm10308187oeb.8.2013.07.17.14.26.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 14:26:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.1016.g4f0baba
In-Reply-To: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230653>

In particular,

- indent with tabs
- cuddle test description and opening body quote with test_expect_foo
- normalize test descriptions and case
- remove whitepsace following redirection operator
- use standardized filenames (such as "actual", "expected")

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/annotate-tests.sh | 221 +++++++++++++++++++++++++++-------------------------
 t/t8001-annotate.sh |   6 +-
 t/t8002-blame.sh    |  12 ++-
 3 files changed, 127 insertions(+), 112 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index c56a77d..3aa6964 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -2,11 +2,11 @@
 # sourced from t8001-annotate.sh and t8002-blame.sh.
 
 check_count () {
-	head=
-	case "$1" in -h) head="$2"; shift; shift ;; esac
-	echo "$PROG file $head" >&4
-	$PROG file $head >.result || return 1
-	cat .result | perl -e '
+	head= &&
+	case "$1" in -h) head="$2"; shift; shift ;; esac &&
+	echo "$PROG file $head" >&4 &&
+	$PROG file $head >actual &&
+	perl -e '
 		my %expect = (@ARGV);
 		my %count = map { $_ => 0 } keys %expect;
 		while (<STDIN>) {
@@ -31,107 +31,114 @@ check_count () {
 			print STDERR "Author $author (expected $value, attributed $count) $ok\n";
 		}
 		exit($bad);
-	' "$@"
+	' "$@" <actual
 }
 
-test_expect_success \
-    'prepare reference tree' \
-    'echo "1A quick brown fox jumps over the" >file &&
-     echo "lazy dog" >>file &&
-     git add file &&
-     GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" git commit -a -m "Initial."'
-
-test_expect_success \
-    'check all lines blamed on A' \
-    'check_count A 2'
-
-test_expect_success \
-    'Setup new lines blamed on B' \
-    'echo "2A quick brown fox jumps over the" >>file &&
-     echo "lazy dog" >> file &&
-     GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" git commit -a -m "Second."'
-
-test_expect_success \
-    'Two lines blamed on A, two on B' \
-    'check_count A 2 B 2'
-
-test_expect_success \
-    'merge-setup part 1' \
-    'git checkout -b branch1 master &&
-     echo "3A slow green fox jumps into the" >> file &&
-     echo "well." >> file &&
-     GIT_AUTHOR_NAME="B1" GIT_AUTHOR_EMAIL="B1@test.git" git commit -a -m "Branch1-1"'
-
-test_expect_success \
-    'Two lines blamed on A, two on B, two on B1' \
-    'check_count A 2 B 2 B1 2'
-
-test_expect_success \
-    'merge-setup part 2' \
-    'git checkout -b branch2 master &&
-     sed -e "s/2A quick brown/4A quick brown lazy dog/" < file > file.new &&
-     mv file.new file &&
-     GIT_AUTHOR_NAME="B2" GIT_AUTHOR_EMAIL="B2@test.git" git commit -a -m "Branch2-1"'
-
-test_expect_success \
-    'Two lines blamed on A, one on B, one on B2' \
-    'check_count A 2 B 1 B2 1'
-
-test_expect_success \
-    'merge-setup part 3' \
-    'git pull . branch1'
-
-test_expect_success \
-    'Two lines blamed on A, one on B, two on B1, one on B2' \
-    'check_count A 2 B 1 B1 2 B2 1'
-
-test_expect_success \
-    'Annotating an old revision works' \
-    'check_count -h master A 2 B 2'
-
-test_expect_success \
-    'Annotating an old revision works' \
-    'check_count -h master^ A 2'
-
-test_expect_success \
-    'merge-setup part 4' \
-    'echo "evil merge." >>file &&
-     git commit -a --amend'
-
-test_expect_success \
-    'Two lines blamed on A, one on B, two on B1, one on B2, one on A U Thor' \
-    'check_count A 2 B 1 B1 2 B2 1 "A U Thor" 1'
-
-test_expect_success \
-    'an incomplete line added' \
-    'echo "incomplete" | tr -d "\\012" >>file &&
-    GIT_AUTHOR_NAME="C" GIT_AUTHOR_EMAIL="C@test.git" git commit -a -m "Incomplete"'
-
-test_expect_success \
-    'With incomplete lines.' \
-    'check_count A 2 B 1 B1 2 B2 1 "A U Thor" 1 C 1'
-
-test_expect_success \
-    'some edit' \
-    'mv file file.orig &&
-    {
-	cat file.orig &&
-	echo
-    } | sed -e "s/^3A/99/" -e "/^1A/d" -e "/^incomplete/d" > file &&
-    echo "incomplete" | tr -d "\\012" >>file &&
-    GIT_AUTHOR_NAME="D" GIT_AUTHOR_EMAIL="D@test.git" git commit -a -m "edit"'
-
-test_expect_success \
-    'some edit' \
-    'check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1'
-
-test_expect_success \
-    'an obfuscated email added' \
-    'echo "No robots allowed" > file.new &&
-     cat file >> file.new &&
-     mv file.new file &&
-     GIT_AUTHOR_NAME="E" GIT_AUTHOR_EMAIL="E at test dot git" git commit -a -m "norobots"'
-
-test_expect_success \
-    'obfuscated email parsed' \
-    'check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1 E 1'
+test_expect_success 'setup A lines' '
+	echo "1A quick brown fox jumps over the" >file &&
+	echo "lazy dog" >>file &&
+	git add file &&
+	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
+	git commit -a -m "Initial."
+'
+
+test_expect_success 'blame 1 author' '
+	check_count A 2
+'
+
+test_expect_success 'setup B lines' '
+	echo "2A quick brown fox jumps over the" >>file &&
+	echo "lazy dog" >>file &&
+	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
+	git commit -a -m "Second."
+'
+
+test_expect_success 'blame 2 authors' '
+	check_count A 2 B 2
+'
+
+test_expect_success 'setup B1 lines (branch1)' '
+	git checkout -b branch1 master &&
+	echo "3A slow green fox jumps into the" >>file &&
+	echo "well." >>file &&
+	GIT_AUTHOR_NAME="B1" GIT_AUTHOR_EMAIL="B1@test.git" \
+	git commit -a -m "Branch1-1"
+'
+
+test_expect_success 'blame 2 authors + 1 branch1 author' '
+	check_count A 2 B 2 B1 2
+'
+
+test_expect_success 'setup B2 lines (branch2)' '
+	git checkout -b branch2 master &&
+	sed -e "s/2A quick brown/4A quick brown lazy dog/" <file >file.new &&
+	mv file.new file &&
+	GIT_AUTHOR_NAME="B2" GIT_AUTHOR_EMAIL="B2@test.git" \
+	git commit -a -m "Branch2-1"
+'
+
+test_expect_success 'blame 2 authors + 1 branch2 author' '
+	check_count A 2 B 1 B2 1
+'
+
+test_expect_success 'merge branch1 & branch2' '
+	git pull . branch1
+'
+
+test_expect_success 'blame 2 authors + 2 merged-in authors' '
+	check_count A 2 B 1 B1 2 B2 1
+'
+
+test_expect_success 'blame ancestor' '
+	check_count -h master A 2 B 2
+'
+
+test_expect_success 'blame great-ancestor' '
+	check_count -h master^ A 2
+'
+
+test_expect_success 'setup evil merge' '
+	echo "evil merge." >>file &&
+	git commit -a --amend
+'
+
+test_expect_success 'blame evil merge' '
+	check_count A 2 B 1 B1 2 B2 1 "A U Thor" 1
+'
+
+test_expect_success 'setup incomplete line' '
+	echo "incomplete" | tr -d "\\012" >>file &&
+	GIT_AUTHOR_NAME="C" GIT_AUTHOR_EMAIL="C@test.git" \
+	git commit -a -m "Incomplete"
+'
+
+test_expect_success 'blame incomplete line' '
+	check_count A 2 B 1 B1 2 B2 1 "A U Thor" 1 C 1
+'
+
+test_expect_success 'setup edits' '
+	mv file file.orig &&
+	{
+		cat file.orig &&
+		echo
+	} | sed -e "s/^3A/99/" -e "/^1A/d" -e "/^incomplete/d" >file &&
+	echo "incomplete" | tr -d "\\012" >>file &&
+	GIT_AUTHOR_NAME="D" GIT_AUTHOR_EMAIL="D@test.git" \
+	git commit -a -m "edit"
+'
+
+test_expect_success 'blame edits' '
+	check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1
+'
+
+test_expect_success 'setup obfuscated email' '
+	echo "No robots allowed" >file.new &&
+	cat file >>file.new &&
+	mv file.new file &&
+	GIT_AUTHOR_NAME="E" GIT_AUTHOR_EMAIL="E at test dot git" \
+	git commit -a -m "norobots"
+'
+
+test_expect_success 'blame obfuscated email' '
+	check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1 E 1
+'
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index 41962f0..72176e4 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -6,9 +6,9 @@ test_description='git annotate'
 PROG='git annotate'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
-test_expect_success 'Annotating an old revision works' '
-	git annotate file master >result &&
-	awk "{ print \$3; }" <result >authors &&
+test_expect_success 'annotate old revision' '
+	git annotate file master >actual &&
+	awk "{ print \$3; }" <actual >authors &&
 	test 2 = $(grep A <authors | wc -l) &&
 	test 2 = $(grep B <authors | wc -l)
 '
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index e2896cf..5cdf3f1 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -7,8 +7,16 @@ PROG='git blame -c'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
 PROG='git blame -c -e'
-test_expect_success 'Blame --show-email works' '
-    check_count "<A@test.git>" 1 "<B@test.git>" 1 "<B1@test.git>" 1 "<B2@test.git>" 1 "<author@example.com>" 1 "<C@test.git>" 1 "<D@test.git>" 1 "<E at test dot git>" 1
+test_expect_success 'blame --show-email' '
+	check_count \
+		"<A@test.git>" 1 \
+		"<B@test.git>" 1 \
+		"<B1@test.git>" 1 \
+		"<B2@test.git>" 1 \
+		"<author@example.com>" 1 \
+		"<C@test.git>" 1 \
+		"<D@test.git>" 1 \
+		"<E at test dot git>" 1
 '
 
 test_done
-- 
1.8.3.3.1016.g4f0baba
