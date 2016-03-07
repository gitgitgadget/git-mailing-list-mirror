From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/4] t6302: skip only signed tags rather than all tests when GPG is missing
Date: Sun,  6 Mar 2016 19:10:27 -0500
Message-ID: <1457309427-30124-5-git-send-email-sunshine@sunshineco.com>
References: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 01:11:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acilb-00087R-Az
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 01:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbcCGALK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 19:11:10 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:34010 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbcCGALB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 19:11:01 -0500
Received: by mail-io0-f194.google.com with SMTP id z76so1307832iof.1
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 16:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uHnrtjmK2Bi32uhMwR9aKrMzJT2Op4N1k8DMLAqqfXc=;
        b=WSRRqs5D7l6gCTMq2kcUaJHLLPFpEiFwYHTorw8a1PAeE5g1vbewCndW15KHC53lBn
         v6w4APVdDRqK+nwGc3rar0e7WpifRSlFb+C/2HqTfBpM0vyn5xyghn03YxTa9oKiRSiR
         y5Y9fQ2ib5onmjPPb3sCXnq3ulyVHqQ4vOzhEQjR3G1iZl2kHTjGbDdVJY/IyYnOrvxi
         4I8GvkhQy9VgrQyd89yyAHW5eMJwWOMtxBDsGbrxY3gN83fl4n9NWagsUkaNQQA/gUJu
         g3t8cfIzWhKZfU+tc58F6nsRjo3Je4awVTU6CQta4wov1vqYQv6UVlqDS6usgzxC2JJY
         kAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=uHnrtjmK2Bi32uhMwR9aKrMzJT2Op4N1k8DMLAqqfXc=;
        b=crhTy4yJg0Gt7ZSuel33kpXgV+3COoL5kDMSdsJdc7LbOG/9d5WM98y8gCmSrPBi9K
         VhXGM6ZWsZoFCGxwlJKLLJuMV6e11bqUi2fkuxmzNhrxHmO0ld8GMMRC5KKjgTzXqlm7
         SOJzVP30TT/OBirGccphgGXghThuExg2PdJeZlcvLbk+cQpgTn8s5LzFgSFKlmIx6ltp
         nd6Mj0M9v+0Hk+8yffAAk9JU46HaShULdz6bc1SsHC+S6FnJ+wHvKdX8T8mIF+pIwaN+
         7GdbYGXeTJSgLfKqHV7PMIS45Lu/apKIoYIkvJYkr18nNc/bK8fLao0HwXxIGSWezRtA
         9vQQ==
X-Gm-Message-State: AD7BkJL4dA+ASgH4CStqrqvZw4z6RFQQ23qvSSswLu7TMUc1GtmHbasuUIZB3Upl2mRzjQ==
X-Received: by 10.107.12.14 with SMTP id w14mr22693939ioi.8.1457309460626;
        Sun, 06 Mar 2016 16:11:00 -0800 (PST)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id t62sm1337418ioi.41.2016.03.06.16.10.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 16:11:00 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc1.175.g19dcece
In-Reply-To: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288372>

The primary purpose of these tests is to check filtering, sorting, and
formatting behavior of git-for-each-ref, so it is unfortunate that the
entire test script is skipped when GPG is not present. Rather than
skipping all tests, let's instead just skip testing against signed tags
when GPG is missing.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t6302-for-each-ref-filter.sh | 44 ++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 2e28559..70afb44 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -5,11 +5,14 @@ test_description='test for-each-refs usage of ref-filter APIs'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
-if ! test_have_prereq GPG
-then
-	skip_all="skipping for-each-ref tests, GPG not available"
-	test_done
-fi
+test_prepare_expect () {
+	if test_have_prereq GPG
+	then
+		cat
+	else
+		sed '/signed/d'
+	fi
+}
 
 test_expect_success 'setup some history and refs' '
 	test_commit one &&
@@ -19,8 +22,11 @@ test_expect_success 'setup some history and refs' '
 	test_commit four &&
 	git tag -m "An annotated tag" annotated-tag &&
 	git tag -m "Annonated doubly" doubly-annotated-tag annotated-tag &&
-	git tag -s -m "A signed tag" signed-tag &&
-	git tag -s -m "Signed doubly" doubly-signed-tag signed-tag &&
+	if test_have_prereq GPG
+	then
+		git tag -s -m "A signed tag" signed-tag &&
+		git tag -s -m "Signed doubly" doubly-signed-tag signed-tag
+	fi &&
 	git checkout master &&
 	git update-ref refs/odd/spot master
 '
@@ -36,7 +42,7 @@ test_expect_success 'filtering with --points-at' '
 '
 
 test_expect_success 'check signed tags with --points-at' '
-	sed -e "s/Z$//" >expect <<-\EOF &&
+	test_prepare_expect <<-\EOF | sed -e "s/Z$//" >expect &&
 	refs/heads/side Z
 	refs/tags/annotated-tag four
 	refs/tags/four Z
@@ -59,7 +65,7 @@ test_expect_success 'filtering with --merged' '
 '
 
 test_expect_success 'filtering with --no-merged' '
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	refs/heads/side
 	refs/tags/annotated-tag
 	refs/tags/doubly-annotated-tag
@@ -72,7 +78,7 @@ test_expect_success 'filtering with --no-merged' '
 '
 
 test_expect_success 'filtering with --contains' '
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	refs/heads/master
 	refs/heads/side
 	refs/odd/spot
@@ -93,7 +99,7 @@ test_expect_success '%(color) must fail' '
 '
 
 test_expect_success 'left alignment is default' '
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	refname is refs/heads/master  |refs/heads/master
 	refname is refs/heads/side    |refs/heads/side
 	refname is refs/odd/spot      |refs/odd/spot
@@ -111,7 +117,7 @@ test_expect_success 'left alignment is default' '
 '
 
 test_expect_success 'middle alignment' '
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	| refname is refs/heads/master |refs/heads/master
 	|  refname is refs/heads/side  |refs/heads/side
 	|   refname is refs/odd/spot   |refs/odd/spot
@@ -129,7 +135,7 @@ test_expect_success 'middle alignment' '
 '
 
 test_expect_success 'right alignment' '
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	|  refname is refs/heads/master|refs/heads/master
 	|    refname is refs/heads/side|refs/heads/side
 	|      refname is refs/odd/spot|refs/odd/spot
@@ -146,7 +152,7 @@ test_expect_success 'right alignment' '
 	test_cmp expect actual
 '
 
-cat >expect <<-\EOF
+test_prepare_expect >expect <<-\EOF
 |       refname is refs/heads/master       |refs/heads/master
 |        refname is refs/heads/side        |refs/heads/side
 |         refname is refs/odd/spot         |refs/odd/spot
@@ -193,7 +199,7 @@ EOF
 # Individual atoms inside %(align:...) and %(end) must not be quoted.
 
 test_expect_success 'alignment with format quote' "
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	|'      '\''master| A U Thor'\''      '|
 	|'       '\''side| A U Thor'\''       '|
 	|'     '\''odd/spot| A U Thor'\''     '|
@@ -211,7 +217,7 @@ test_expect_success 'alignment with format quote' "
 "
 
 test_expect_success 'nested alignment with quote formatting' "
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	|'         master               '|
 	|'           side               '|
 	|'       odd/spot               '|
@@ -229,7 +235,7 @@ test_expect_success 'nested alignment with quote formatting' "
 "
 
 test_expect_success 'check `%(contents:lines=1)`' '
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	master |three
 	side |four
 	odd/spot |three
@@ -247,7 +253,7 @@ test_expect_success 'check `%(contents:lines=1)`' '
 '
 
 test_expect_success 'check `%(contents:lines=0)`' '
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	master |
 	side |
 	odd/spot |
@@ -265,7 +271,7 @@ test_expect_success 'check `%(contents:lines=0)`' '
 '
 
 test_expect_success 'check `%(contents:lines=99999)`' '
-	cat >expect <<-\EOF &&
+	test_prepare_expect >expect <<-\EOF &&
 	master |three
 	side |four
 	odd/spot |three
-- 
2.8.0.rc1.175.g19dcece
