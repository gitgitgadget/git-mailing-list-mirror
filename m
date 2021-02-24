Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154B5C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67C464F06
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhBXTz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbhBXTxi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2474C061356
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c7so3040040wru.8
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cG+uULvfiuwIQgvSVTGYx2ppDe1gnVP8ks4c6FgYZio=;
        b=bgRMXNl5x04bCvwdnI2ccRKHb4iI35D2kTgwInTb32EiskH4eEf6pWdKkiNnWIYedU
         JIBhR1uFrhCJg5rGaCxi2jrUnLfzfSjvrEGPoMZZbCv+MdQuE+qu3XQatqAm5QXpS1Ol
         zNaYTtxKkT3sMyLj82ZN/fT7eXP5Av6pzyRAXhmVmYGWILHf+oM9YLZTxv+MBjc8KIsZ
         GPGDKoJBx6olR8w4kSbyM6GZ93+zIWWNC7WcAKO5F2QHRuPXsJ+9qKxwCL8HSQ/xz2rs
         A9+ZEz2VVodXO/Sks4kK1MD6S04dOa8aRUuQqBdZmlPxSpqWoxJ107qxPjn7FSgPXtBk
         yaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cG+uULvfiuwIQgvSVTGYx2ppDe1gnVP8ks4c6FgYZio=;
        b=GGP/KceYkizEFZytTQR/ygfVYKR7JzK7DBH4fcxgcVo61c0TYG6bemTvHgggdfdOwi
         Clfi1zYrfeXkL7DbcLjvFUXxAr407DlBzOVGva0qUlbxSt+zhcJTA+UkO3xQCxN/yinv
         6IHTGVKzh10ZR7XYWCmKWz+eQrNdM3kl0TXPo1KdpVkfJ30Cl50jNqH9kOPcn/mJvH1t
         IZlQrzUK2h00eZYN2zNUIPXKkE5NXtZMZi70ONCTV4TV6Nqu/A8szKbcKgvJnqCQCLlX
         VhJRRQy9kAi2ztJxQOg664X917jHRSgd7vA9XxZ6/TwTRh3ub3UnYD3Knp8CSd8kDrIx
         0R8w==
X-Gm-Message-State: AOAM533qROJmcNReVBEHgTwip92fevVUh+PuKgSBDTWR1cKkDw/c8G+U
        XdsdisfuMa12wT4wXbSV/H0iCFuOWZ3YNQ==
X-Google-Smtp-Source: ABdhPJyzhvCfM5//hrtfmHTipKi8x7goMZCi8A/sBQ+PtID7VP1exozQKk9jTUGEpFzpgJtWbFbYvg==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr13520315wrt.370.1614196324236;
        Wed, 24 Feb 2021 11:52:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/35] userdiff tests: add alternative hunk header test infrastructure
Date:   Wed, 24 Feb 2021 20:51:08 +0100
Message-Id: <20210224195129.4004-15-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an alternative to the hunk header test infrastructure introduced
in bfa7d01413 (t4018: an infrastructure to test hunk headers,
2014-03-21). See c228a5c077 (Merge branch 'js/userdiff-cc',
2014-03-31) for the whole series that commit was part of.

As noted in an earlier commit that change introduced the regression of
not testing for the full hunk line, but just whether "RIGHT" appeared
on it.

A preceding commit fixed that specific issue, but we are still left
with the inflexibility of not being able to do any testing except that
which fits inside the narrow confines of this custom test syntax,
e.g. being unable to setup config variables before specific tests.

So introduce a new "test_diff_funcname()" function which is expected
to be used by tests in t4018/*.sh, and move the "custom" tests over to
that. As will be seen in follow-up changes we'll make use of this new
function infrastructure in the "custom" tests.

There's no reason for not moving all of the tests over to this new
infrastructure as far as test coverage goes, but Junio and Johannes
expressed a desire to keep the existing test mode [1], so I'm only
moving a narrow set of tests over to the new mode.

1. https://lore.kernel.org/git/xmqqsg5vrhha.fsf@gitster.c.googlers.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh                      | 38 +++++++++++++++-
 t/t4018/README                                | 44 ++++++++++++++++---
 t/t4018/{custom1-pattern => custom1.sh}       | 11 ++++-
 t/t4018/custom2-match-to-end-of-line          |  9 ----
 t/t4018/custom2.sh                            | 18 ++++++++
 ...tom3-alternation-in-pattern => custom3.sh} | 11 ++++-
 6 files changed, 113 insertions(+), 18 deletions(-)
 rename t/t4018/{custom1-pattern => custom1.sh} (71%)
 mode change 100644 => 100755
 delete mode 100644 t/t4018/custom2-match-to-end-of-line
 create mode 100755 t/t4018/custom2.sh
 rename t/t4018/{custom3-alternation-in-pattern => custom3.sh} (66%)
 mode change 100644 => 100755

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 8a8a7a99c88..6fd3dce1364 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -87,7 +87,7 @@ last_diff_context_line () {
 }
 
 # check each individual file
-for i in $(git -C t4018 ls-files)
+for i in $(git -C t4018 ls-files -- ':!*.sh')
 do
 	test_expect_success "setup hunk header: $i" "
 		grep -v '^t4018' \"t4018/$i\" >\"t4018/$i.content\" &&
@@ -106,4 +106,40 @@ do
 	"
 done
 
+test_diff_funcname () {
+	desc=$1
+	cat <&8 >arg.header &&
+	cat <&9 >arg.test &&
+	what=$(cat arg.what) &&
+
+	test_expect_success "setup: $desc" '
+		cp arg.test "$what" &&
+		cp arg.header expected &&
+		git add "$what" &&
+		do_change_me "$what"
+	' &&
+
+	test_expect_success "$desc" '
+		git diff -U1 "$what" >diff &&
+		last_diff_context_line diff >actual &&
+		test_cmp expected actual
+	'
+}
+
+for what in $diffpatterns
+do
+	test="$TEST_DIRECTORY/t4018/$what.sh"
+	if ! test -e "$test"
+	then
+		continue
+	fi &&
+
+	test_expect_success "setup: hunk header for $what" '
+		echo "$what diff=$what" >.gitattributes &&
+		echo "$what" >arg.what
+	' &&
+
+	. "$test"
+done
+
 test_done
diff --git a/t/t4018/README b/t/t4018/README
index 0a246bbc10e..54ae735d5f8 100644
--- a/t/t4018/README
+++ b/t/t4018/README
@@ -1,13 +1,45 @@
-t4018 header: description of the test.
+t4018 header: There are two ways of writing tests in this directory. In both cases
 How to write test cases
 =======================
 
-Create test cases called "LANG-whatever" in this directory, where
-"LANG" is e.g. the userdiff driver name, where "whatever" is a brief
-description of the test.
+There are two ways of writing tests in this directory. In both cases
+"LANG" is the userdiff driver name, e.g. "perl" or "cpp".
+
+The word "ChangeMe" (exactly this form) should appear at a distance of
+at least two lines from the line that must appear in the hunk
+header. See below sections.
+
+t4018 header: t/README.
+"LANG.sh" test cases
+====================
+
+These tests use the normal test-lib.sh syntax and environment, and are
+sourced by t4018-diff-funcname.sh. The "test_diff_funcname()" function
+is a thin wrapper around the "test_expect_success()" function. See
+t/README.
+
+The content of the "EOF_TEST" argument is used as-is, with the
+exception of the "ChangeMe" token discussed above.
+
+The advantage of using this over the "LANG-whatever" test cases (see
+below) are:
 
-Insert the word "ChangeMe" (exactly this form) at a distance of
-at least two lines from the line that must appear in the hunk header.
+ - The ability to do custom test setup/teardown, e.g. using
+   "test_config" before the test is run.
+
+ - The description of the test is a string, and doesn't need to be a
+   valid filename.
+
+ - All the tests for a given driver are present in one file. As
+   demonstrated with the two "t4018 header" lines in this file this is
+   also possible with the "LANG-whatever" tests, but those N tests in
+   one file won't benefit from different test descriptions.
+
+"LANG-whatever" test cases
+==========================
+
+Create test cases called "LANG-whatever" in this directory, where
+"whatever" is a brief description of the test.
 
 Any line starting with "t4018" is a control line for the test:
 
diff --git a/t/t4018/custom1-pattern b/t/t4018/custom1.sh
old mode 100644
new mode 100755
similarity index 71%
rename from t/t4018/custom1-pattern
rename to t/t4018/custom1.sh
index 37a3422384b..f8bbccadb47
--- a/t/t4018/custom1-pattern
+++ b/t/t4018/custom1.sh
@@ -1,4 +1,12 @@
-t4018 header: int special, RIGHT;
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'custom1: pattern' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+int special, RIGHT;
+EOF_HUNK
 public class Beer
 {
 	int special, RIGHT;
@@ -16,3 +24,4 @@ public class Beer
 			+ "99 bottles of beer on the wall.\n");
 	}
 }
+EOF_TEST
diff --git a/t/t4018/custom2-match-to-end-of-line b/t/t4018/custom2-match-to-end-of-line
deleted file mode 100644
index 4800bb1c568..00000000000
--- a/t/t4018/custom2-match-to-end-of-line
+++ /dev/null
@@ -1,9 +0,0 @@
-t4018 header: RIGHT_Beer
-public class RIGHT_Beer
-{
-	int special;
-	public static void main(String args[])
-	{
-		System.out.print("ChangeMe");
-	}
-}
diff --git a/t/t4018/custom2.sh b/t/t4018/custom2.sh
new file mode 100755
index 00000000000..c68421f788e
--- /dev/null
+++ b/t/t4018/custom2.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'custom2: match to end of line' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT_Beer
+EOF_HUNK
+public class RIGHT_Beer
+{
+	int special;
+	public static void main(String args[])
+	{
+		System.out.print("ChangeMe");
+	}
+}
+EOF_TEST
diff --git a/t/t4018/custom3-alternation-in-pattern b/t/t4018/custom3.sh
old mode 100644
new mode 100755
similarity index 66%
rename from t/t4018/custom3-alternation-in-pattern
rename to t/t4018/custom3.sh
index bf7df3d9a73..07c5c134ffe
--- a/t/t4018/custom3-alternation-in-pattern
+++ b/t/t4018/custom3.sh
@@ -1,4 +1,12 @@
-t4018 header: public static void main(String RIGHT[])
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'custom3: alternation in pattern' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+public static void main(String RIGHT[])
+EOF_HUNK
 public class Beer
 {
 	int special;
@@ -16,3 +24,4 @@ public class Beer
 			+ "99 bottles of beer on the wall.\n");
 	}
 }
+EOF_TEST
-- 
2.30.0.284.gd98b1dd5eaa7

