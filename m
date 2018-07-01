Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49151F516
	for <e@80x24.org>; Sun,  1 Jul 2018 01:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeGABZU (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 21:25:20 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42802 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbeGABZP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 21:25:15 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so11739779oib.9
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 18:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MDu0zG3JdzvLXDxcnNyfRKDW1WbjfU9df+ZTFznohH8=;
        b=fjiDlrbGvRcF9pgOGAJpIywx9lhNXVGntsuYL/SKbSQZa0GyrH9erb8vUiwaFeyg3S
         +IN6G7/mPVFZfOsU38sooYpnv5dvanaEcwh+M6rNUTpmcfxTOLhXEjcpZfmnevBvyU1p
         0RFWeQak8Qa35PE8tTJq9FU8aD+ZXk9pAFNbaHTQCdZt5u/pyBoeVCW80FmYyARprtnt
         rUvx0jqE7LQlEMdgKjfqz64ax3geu2kw5CmDL4IjMnLxwjQ4SfQCXVB0UTetRy7Ayk+8
         hvJn+EQ8xaraRMshBs0AVNNlyP4CCeOmRR/0gpgw0lZwesjAHO6BUxfponBTsLbWB8TK
         xIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MDu0zG3JdzvLXDxcnNyfRKDW1WbjfU9df+ZTFznohH8=;
        b=Vtemg3ANZZZtEB4sDgzm1h15p3uJ6IwDxsN0fBfbl8W5xjSbXldI/dICULXs7g1Kw4
         846mlEErTOvAllL0ZkNgiWiopgWGIiO8FIT+HsVIHO4E42qO1upI4K7KuIsN3ZZwIbZy
         SmReb2ZFHzirqtp5/B5modt05KWmBbnOcobLuE8zYZtQ1fmc4cfEkPsz+sY5JqspkOuR
         9jpG6NI0iMV4kQCACkz4ZZJPAa6r8Ux5tGlHCiOayXEEHfdTb5A4Dt9AkHRtnn7Sco7e
         BlW4dssrA1BDel/3YhB6OSLm+KvXqKqoghqs9DkT2DUSrkqgZ97dfafBFnhF0bsP+5hf
         TrYw==
X-Gm-Message-State: APt69E1Njk6j1GdBkmE0baVKZQ2Tft0WKlRRMZFMLKjYTP5jpXwexyAK
        5JAggaPZK/Dqq51BGpBBUuvxHA==
X-Google-Smtp-Source: AAOMgpebSOhPbFp3LYS+HxbTJhJ43o5pqpdH3J8/8xTUCsqqRNlsxqtzGYZON8ckxvfb3Bczw1ocGg==
X-Received: by 2002:aca:d80b:: with SMTP id p11-v6mr10968646oig.210.1530408314159;
        Sat, 30 Jun 2018 18:25:14 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id g20-v6sm3509394ote.38.2018.06.30.18.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 18:25:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/9] t6044: verify that merges expected to abort actually abort
Date:   Sat, 30 Jun 2018 18:24:57 -0700
Message-Id: <20180701012503.14382-4-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.137.g2a11d05a6.dirty
In-Reply-To: <20180701012503.14382-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
 <20180701012503.14382-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t6044 has lots of tests for verifying that merge will abort as expected
when there are changes staged before the merge starts.  However, it only
checked for non-zero exit code, which could mean that the merge ran to
completion with conflicts.  Check that the merge was actually correctly
aborted, i.e. that .git/MERGE_HEAD is not present.

This changes one of the tests from expect_success to expect_failure.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6044-merge-unrelated-index-changes.sh | 32 ++++++++++++++++--------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index 23b86fb97..f9c2f8179 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -82,7 +82,8 @@ test_expect_success 'ff update, important file modified' '
 	touch subdir/e &&
 	git add subdir/e &&
 
-	test_must_fail git merge E^0
+	test_must_fail git merge E^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'resolve, trivial' '
@@ -91,7 +92,8 @@ test_expect_success 'resolve, trivial' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s resolve C^0
+	test_must_fail git merge -s resolve C^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'resolve, non-trivial' '
@@ -100,7 +102,8 @@ test_expect_success 'resolve, non-trivial' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s resolve D^0
+	test_must_fail git merge -s resolve D^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'recursive' '
@@ -109,16 +112,18 @@ test_expect_success 'recursive' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s recursive C^0
+	test_must_fail git merge -s recursive C^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
-test_expect_success 'recursive, when merge branch matches merge base' '
+test_expect_failure 'recursive, when merge branch matches merge base' '
 	git reset --hard &&
 	git checkout B^0 &&
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s recursive F^0
+	test_must_fail git merge -s recursive F^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'octopus, unrelated file touched' '
@@ -127,7 +132,8 @@ test_expect_success 'octopus, unrelated file touched' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge C^0 D^0
+	test_must_fail git merge C^0 D^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'octopus, related file removed' '
@@ -136,7 +142,8 @@ test_expect_success 'octopus, related file removed' '
 
 	git rm b &&
 
-	test_must_fail git merge C^0 D^0
+	test_must_fail git merge C^0 D^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'octopus, related file modified' '
@@ -145,7 +152,8 @@ test_expect_success 'octopus, related file modified' '
 
 	echo 12 >>a && git add a &&
 
-	test_must_fail git merge C^0 D^0
+	test_must_fail git merge C^0 D^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'ours' '
@@ -154,7 +162,8 @@ test_expect_success 'ours' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s ours C^0
+	test_must_fail git merge -s ours C^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'subtree' '
@@ -163,7 +172,8 @@ test_expect_success 'subtree' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s subtree E^0
+	test_must_fail git merge -s subtree E^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_done
-- 
2.18.0.137.g2a11d05a6.dirty

