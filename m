Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,MONEY_NOHTML,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA92C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADD523F37
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437422AbgLKJKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 04:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437391AbgLKJKN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 04:10:13 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503F0C06179C
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:56 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g185so7850519wmf.3
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QQatPLA2X4s8HeXNOn3kIQM7ZmA0C3EQfIlNmMO5AUY=;
        b=AZokjrsGMRJH1LXmu8/Jrsec/UCh82vA4QJMwtGy7hWi6kdhWedoRjheKnORBmV+bw
         tGHJv4H/8SXDzVhyS99Nmc1iQ+uWQtzKaWlwYGT6tpAMaCo6njS/DF4Hagy2Pj+qIOxr
         NmqRt47MNBLJz97Zpd7vjhofr6Z2ta6kKHyQYmxI3q3TYLcuOGPdwHKoAZ4E357kfSnj
         f7jhidCp2acDqkKwnkE+yayz+R13IMl8P1+EpHLuI+aNvfzpLqEeqUsbG63i1j81NkIO
         FSpZaaj3J5rlv+OA+xfmu7OBXhKue6bVdl6uOtYIQ6O9i9XVDB5EGd/TBGBho70dfeZY
         qfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QQatPLA2X4s8HeXNOn3kIQM7ZmA0C3EQfIlNmMO5AUY=;
        b=U6tyRXWzBdZAOjRkiPB1tFL8MMsTVyrNiECijxMFJUNxOrkPMQOgsLG23tIcN9qZZ4
         +p8S7cu+0Wp7JbPryEP3bIYOo47KoQB0WUu8maxkjfdGgnBYI0rXkD7M+cCr0f2FOHEw
         cmgZjClBC2GhIzUUhS42Vajz81Zl50StzXag2a01bgUxLwdlWJ4b+JqjoMXLwYDWt3kw
         1R4Lawu6BtJVMtoCLXCn+cY7BA+gVL/qSM2cY8Y+kD+NfPmLhoSAeghkUb+kETqCOWyB
         cWnC74SpS6CIEirGcwrKT6Xyrkwflt1BcxoaoWRq6cr0qZ+TM4u5KsHW84q2/ZePNr4l
         /hcw==
X-Gm-Message-State: AOAM532urVOeA4TRNPSuYlD2A1gsdSJ8HjEQxWmXwFiUUR4xxMQfVkCb
        tcQgN3vzTM/XDdaEUBuOlSA0SFvXR/I=
X-Google-Smtp-Source: ABdhPJw9aGGVMje9iDIJAU0uXT1iwXPqfoWydv6XGRYDMD+xkIhlazDy0EbUNRW2JBEb6atMusafBg==
X-Received: by 2002:a1c:6689:: with SMTP id a131mr12397221wmc.33.1607677734788;
        Fri, 11 Dec 2020 01:08:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm14059053wru.82.2020.12.11.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 01:08:54 -0800 (PST)
Message-Id: <9a4a3159acf6144bfbfc773195a141afaa95dad3.1607677728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 09:08:44 +0000
Subject: [PATCH v2 5/9] t4058: add more tests and documentation for duplicate
 tree entry handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 4d6be03b95 ("diffcore-rename: avoid processing duplicate
destinations", 2015-02-26) added t4058 to demonstrate that a workaround
it added to avoid double frees (namely to just turn off rename detection
when trees had duplicate entries) would indeed avoid segfaults.  The
tests, though, give the impression that the expected diffs are "correct"
when in reality they are just "don't segfault, and do something
semi-reasonable under the circumstances".  Add some notes to make this
clearer.

Also, commit 25d5ea410f ("[PATCH] Redo rename/copy detection logic.",
2005-05-24) added a similar workaround to avoid segfaults, but for
rename_src rather than rename_dst.  I do not see any tests in the
testsuite to cover the collision detection of entries limited to the
source side, so add a couple.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4058-diff-duplicates.sh | 47 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index c24ee175ef0..bd685089561 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -1,5 +1,14 @@
 #!/bin/sh
 
+# NOTICE:
+#   This testsuite does a number of diffs and checks that the output match.
+#   However, it is a "garbage in, garbage out" situation; the trees have
+#   duplicate entries for individual paths, and it results in diffs that do
+#   not make much sense.  As such, it is not clear that the diffs are
+#   "correct".  The primary purpose of these tests was to verify that
+#   diff-tree does not segfault, but there is perhaps some value in ensuring
+#   that the diff output isn't wildly unreasonable.
+
 test_description='test tree diff when trees have duplicate entries'
 . ./test-lib.sh
 
@@ -57,7 +66,16 @@ test_expect_success 'create trees with duplicate entries' '
 	git tag two $outer_two
 '
 
-test_expect_success 'diff-tree between trees' '
+test_expect_success 'create tree without duplicate entries' '
+	blob_one=$(echo one | git hash-object -w --stdin) &&
+	outer_three=$(make_tree \
+		100644 renamed $blob_one
+	) &&
+	git tag three $outer_three
+'
+
+test_expect_success 'diff-tree between duplicate trees' '
+	# See NOTICE at top of file
 	{
 		printf ":000000 100644 $ZERO_OID $blob_two A\touter/inner\n" &&
 		printf ":000000 100644 $ZERO_OID $blob_two A\touter/inner\n" &&
@@ -71,9 +89,34 @@ test_expect_success 'diff-tree between trees' '
 '
 
 test_expect_success 'diff-tree with renames' '
-	# same expectation as above, since we disable rename detection
+	# See NOTICE at top of file.
 	git diff-tree -M -r --no-abbrev one two >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'diff-tree FROM duplicate tree' '
+	# See NOTICE at top of file.
+	{
+		printf ":100644 000000 $blob_one $ZERO_OID D\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $ZERO_OID D\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $ZERO_OID D\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $ZERO_OID D\touter/inner\n" &&
+		printf ":000000 100644 $ZERO_OID $blob_one A\trenamed\n"
+	} >expect &&
+	git diff-tree -r --no-abbrev one three >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff-tree FROM duplicate tree, with renames' '
+	# See NOTICE at top of file.
+	{
+		printf ":100644 000000 $blob_two $ZERO_OID D\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $ZERO_OID D\touter/inner\n" &&
+		printf ":100644 000000 $blob_two $ZERO_OID D\touter/inner\n" &&
+		printf ":100644 100644 $blob_one $blob_one R100\touter/inner\trenamed\n"
+	} >expect &&
+	git diff-tree -M -r --no-abbrev one three >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

