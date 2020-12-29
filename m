Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,MONEY_NOHTML,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95396C43332
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A3D20867
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 20:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgL2UGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 15:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgL2UGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 15:06:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC78C06179A
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:35 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 3so3047447wmg.4
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 12:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QQatPLA2X4s8HeXNOn3kIQM7ZmA0C3EQfIlNmMO5AUY=;
        b=UMuH1WgHp2l5kX4ZaHMHfmgvG4XmNCR7qqRk85V4cFaBbkVyLcAf697IdLOPvRkODB
         ZABdkQzJAzxW9vJvrclrj4yhoTOMPEpEgzr8TzWVtKFw+zR+rKxFO/F2FoB0J/HA1qFv
         uDouCd+eTP7q8gtp3MCKDvQ3Ktl8KumKUzVUxWOIH379eNRs5G/7ocfM2fkyvwRyxcWA
         Z1j8h/N8DxiuM/9Gj0dy3pm7v5elm88KS+KyRSrnm1dnD92K3/TKE2zSSpixMMVzShBe
         W84NBj4GdRocGd+rBIo/DPZoug2VgW2qQeOgIVEiuQvRk/3kbwFBwG93lTPEIOxl9eWu
         X1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QQatPLA2X4s8HeXNOn3kIQM7ZmA0C3EQfIlNmMO5AUY=;
        b=jWO06EViPOX5B94ZYgIPcRw9P6MPaBABC8A2Q2b0FEKi9Kv1dRqXKA2CxRZkBCYISE
         GnbkF/+Nq7FT9xF/qLQP5vHbS9Xlj8kTsEtw1s7S5jeSD6/IY/4r/5MLoub0u54yolSH
         8jp/Nl0iQDRFRxcSK1Q3K93NuUnvr/riaFwMnz8ScgwSkmo2cPawf3t98wf8WGNdpuvY
         fUXPjKrltuPYEchJolaVqhCxrUduk1j8G7PRPjIKx4x3hud+LY20OXsCU2eL5T/v6dEK
         8NbGu99eXZnayI0nLkP/FZOsKC6jknN5I4ZpqivHW8qJPu/gmdw9HZVMeDULwPo0Xaqo
         4WGg==
X-Gm-Message-State: AOAM530jlMUP2JlW4CIJiwtgykTv7YlHPxozyUvlJW4GvCjM9q8IHU9c
        ou9y9AmYM7/pfQp6LvrvnU7GTCBNvLc=
X-Google-Smtp-Source: ABdhPJzzJWjhjgw+e2P4K+5T/7D66vo+j3to9qihQ3BdinJxMb2A/nMesCraF/pwLyLadagOZ6ulYQ==
X-Received: by 2002:a1c:e2c2:: with SMTP id z185mr4935521wmg.49.1609272334385;
        Tue, 29 Dec 2020 12:05:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm62346469wrs.6.2020.12.29.12.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 12:05:33 -0800 (PST)
Message-Id: <9a4a3159acf6144bfbfc773195a141afaa95dad3.1609272328.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
        <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Dec 2020 20:05:24 +0000
Subject: [PATCH v3 5/9] t4058: add more tests and documentation for duplicate
 tree entry handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
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

