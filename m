Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289121F516
	for <e@80x24.org>; Fri, 29 Jun 2018 00:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030268AbeF2AUX (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 20:20:23 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:34041 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030243AbeF2AUT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 20:20:19 -0400
Received: by mail-io0-f202.google.com with SMTP id w23-v6so5613964ioa.1
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 17:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=7VZ5tId4Ls5aRxMyaUPbFaEP9dEqoPRlnTLfhePh7Qo=;
        b=RndAqbOvxiGVhAKRUWo1bjQNHf07JL4q8KuHy8ug1Wt/79dmontSCfKr9eNQ+jmD20
         9Ybb54CCD5A4lMJSANTRzAdgi45AsLTPpNjK9/RypojWjwCj1JyH1nKJI7ikoLyWbXm1
         vfGSGWiikc32j2ZRmNzLwlyMO0T75yG0x8bMONrmIc8RFW9ENIsPcOMZ6TbByysYDM9v
         fyrAxmcolXUaCm8sbeF+EmRkzw1XJVBXrZIdoutiAvNGuzmSj3LNgexwJTOqp9fu8ZYd
         WKA6RBVEo+u026Vfvbayto9ad8JxvixCFM7zrURUwGRbIltdW5IanT3R1V4u1QDlMDY6
         tC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=7VZ5tId4Ls5aRxMyaUPbFaEP9dEqoPRlnTLfhePh7Qo=;
        b=mz8JYjGMfPZob6HEW6U/sPnhA8ja0FgDirtBrLQIhFRzQRXfm2KCZ16xj+zWGZNnEv
         Oua4z5AH4l0XcAgUjNg88H0WANnt7vSjzH9uuXbUBxMTexisev1sTDBNxsv7MZk/Kpq+
         BvjdgxMLV6wSq0eesIRbxbw9mKKGlBg+ePtWsFH9pDm5pCp/IP0lbmxF0Y9sugyl1IcX
         q33Fq2/OJONgNgbJZkpPZcBF7Rftx8CTq8+fRPaAxEYTn9Wibhuv881YN49mmDW6spUc
         OYr6U/7CVr0pjZ4yWtX/dhPWDM9cq6LRYMaK8aEHR9wkeVfDwcqA66755IO1N5+kGFQU
         Ak7A==
X-Gm-Message-State: APt69E0F5kwJVfkhvxRU3L96BnFTCnApDi/cOUJQPLK/vQFmuxd/nlJy
        Q5Kj22hxrcW8pZtz6y4Yim85Qhft2rXr
X-Google-Smtp-Source: AAOMgpe0M1Vavhioj0M20B/gKTgCCkfw6tXu1YgN/iqkf7KR+uhpnzSRUXxjQdCsBJSb6ysAOeR7XzvfIOSU
MIME-Version: 1.0
X-Received: by 2002:a24:6193:: with SMTP id s141-v6mr34648itc.38.1530231618845;
 Thu, 28 Jun 2018 17:20:18 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:19:52 -0700
In-Reply-To: <20180629001958.85143-1-sbeller@google.com>
Message-Id: <20180629001958.85143-4-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com> <20180629001958.85143-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v4 3/9] t4015: avoid git as a pipe input
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t4015 we have a pattern of

    git diff [<options, related to color>] |
        grep -v "index" |
        test_decode_color >actual &&

to produce output that we want to test against. This pattern was introduced
in 86b452e2769 (diff.c: add dimming to moved line detection, 2017-06-30)
as then the focus on getting the colors right. However the pattern used
is not best practice as we do care about the exit code of Git. So let's
not have Git as the upstream of a pipe. Piping the output of grep to
some function is fine as we assume grep to be un-flawed in our test suite.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t4015-diff-whitespace.sh | 50 +++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 17df491a3ab..ddbc3901385 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1271,9 +1271,8 @@ test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
 	test_config color.diff.newMovedDimmed "normal cyan" &&
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
-	git diff HEAD --no-renames --color-moved=dimmed_zebra --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved=dimmed_zebra --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1315,9 +1314,8 @@ test_expect_success 'cmd option assumes configured colored-moved' '
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
 	test_config diff.colorMoved zebra &&
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1395,9 +1393,8 @@ test_expect_success 'move detection ignoring whitespace ' '
 	line 4
 	line 5
 	EOF
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1419,9 +1416,8 @@ test_expect_success 'move detection ignoring whitespace ' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -w --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames -w --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1459,9 +1455,8 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	line 5
 	EOF
 
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1483,9 +1478,8 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames -b --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames -b --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1526,9 +1520,8 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	# avoid cluttering the output with complaints about our eol whitespace
 	test_config core.whitespace -blank-at-eol &&
 
-	git diff HEAD --no-renames --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1550,9 +1543,8 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	EOF
 	test_cmp expected actual &&
 
-	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
 	<BOLD>--- a/lines.txt<RESET>
@@ -1597,9 +1589,8 @@ test_expect_success '--color-moved block at end of diff output respects MIN_ALNU
 	irrelevant_line
 	EOF
 
-	git diff HEAD --color-moved=zebra --color --no-renames |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --color --no-renames >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/bar b/bar<RESET>
 	<BOLD>--- a/bar<RESET>
@@ -1636,9 +1627,8 @@ test_expect_success '--color-moved respects MIN_ALNUM_COUNT' '
 	nineteen chars 456789
 	EOF
 
-	git diff HEAD --color-moved=zebra --color --no-renames |
-		grep -v "index" |
-		test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --color --no-renames >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/bar b/bar<RESET>
 	<BOLD>--- a/bar<RESET>
-- 
2.18.0.399.gad0ab374a1-goog

