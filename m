Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F400A1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 20:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFDU17 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 16:27:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33717 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFDU16 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 16:27:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so3582265pfq.0
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TUgx2x2YHOrtaWflAUa/q4nCKm3Gm0OoeF8fnNui64=;
        b=bgaDWjl1saJ3vhaZlZ2aXRu4ehBgM8/IxFPaiHuezw/3mGJ8ndNlgUFmx/Oa6N/r93
         lwzveAieyCCEOQ3jH9fpVHXUIxsryHR3FF2a2GuYZ9Xx07oA6DbWx41XaijRFyQp8pKF
         bBq8t4huuaNLB0Oh24tch/xoBhVqkoPSnc0w7tcOpxYhspEYaHk/2VcqIwemyuENOllo
         9dJsgsWSS3EOA15hZdy5+ZOGUFMttQAvYjqCjOulN5oUUVcc0RHnB+6B7N5Rb7a1b1ZR
         7ii3zw4b1JlDJvSUOXqxI1QvXhP326S8UqJNeVHORXf4Li1DTqjguVC9mm5eq3PgUBEm
         tK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TUgx2x2YHOrtaWflAUa/q4nCKm3Gm0OoeF8fnNui64=;
        b=ak8LDFxJq7aR2o+IrijtvbGWW9ag2ubMpPMsmEQDpCkQYcYguoGF9CeO3OFjBVkyC9
         Y9cBSL+eOIzd8PQaypUhUGOITCYVMOm+JremKIb4+mt+jhki6nrWCFp8sLqlUdCuQZkM
         /Rk37+78DZHkxHoQyZr5Yw98IZEJTBdkU+8/I7sxkiEM4snsJd0FruzkoDBj3uAJmx3x
         +L3fDMUarAA90NN+2foeIDAeEKgWJrCPOUt5ZFDOK78Uz83Mx8Q35IbXZc6JxY13jynW
         WHMz60gRE6Slug9sreHJqDoRdxxbRuFDS+UqrQRej1Y/Q0i8xRWYkoVepJhftlUqi9JL
         vjwg==
X-Gm-Message-State: APjAAAXEQGmo1BJEdU2/rDAUf4I0419d4Rwy41qC7YTYLbXtzUS8HRpv
        0//AuFmXj7/W+JLDAtG9TUFMg2YO
X-Google-Smtp-Source: APXvYqzcx25Q3aJgbIvRz7M84hCzhd3ANX+PomhAwEPMWu0y75ql1BipQstEZq/adtQWsOhplgBoAw==
X-Received: by 2002:a65:4786:: with SMTP id e6mr512848pgs.85.1559680077945;
        Tue, 04 Jun 2019 13:27:57 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id m9sm18711916pgd.23.2019.06.04.13.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 13:27:57 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ben.humphreys@atlassian.com, Elijah Newren <newren@gmail.com>,
        Ben Humphreys <behumphreys@atlassian.com>
Subject: [PATCH v2] merge-recursive: restore accidentally dropped setting of path
Date:   Tue,  4 Jun 2019 13:27:50 -0700
Message-Id: <20190604202750.3925-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.rc3.1.gd51cc00994
In-Reply-To: <20190604072614.26885-1-newren@gmail.com>
References: <20190604072614.26885-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 8daec1df03de ("merge-recursive: switch from (oid,mode) pairs
to a diff_filespec", 2019-04-05), we actually switched from
(oid,mode,path) triplets to a diff_filespec -- but most callsites in the
patch only needed to worry about oid and mode so the commit message
focused on that.  The oversight in the commit message apparently spilled
over to the code as well; one of the dozen or so callsites accidentally
dropped the setting of the path in the conversion.  Restore the path
setting in that location.

Also, this pointed out that our testsuite was lacking a good rename/add
test, at least one that involved the need for merge content with the
rename.  Add such a test, and since rename/add vs. add/rename could
possibly be important, redo the merge the opposite direction to make
sure we don't have issues with the direction of the merge.  These
testcases failed before restoring the setting of path, but with the
paths appropriately set the testcases both pass.

Reported-by: Ben Humphreys <behumphreys@atlassian.com>
Based-on-patch-by: SZEDER Gábor <szeder.dev@gmail.com>
Tested-by: Ben Humphreys <behumphreys@atlassian.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1:
  * Minor tweaks suggested by SZEDER
  * Added a Tested-by tag for Ben since he reran with his extra testsuite.

Also, I posted an analysis verifying this was the only missed case
elsewhere in this thread.

 merge-recursive.c                    |   1 +
 t/t6042-merge-rename-corner-cases.sh | 118 +++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index a7bcfcbeb4..d2e380b7ed 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1660,6 +1660,7 @@ static int handle_rename_add(struct merge_options *opt,
 	       c->path, add_branch);
 
 	prev_path_desc = xstrfmt("version of %s from %s", path, a->path);
+	ci->ren1->src_entry->stages[other_stage].path = a->path;
 	if (merge_mode_and_contents(opt, a, c,
 				    &ci->ren1->src_entry->stages[other_stage],
 				    prev_path_desc,
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 09dfa8bd92..3fe2cd91dc 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -411,6 +411,124 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
 	)
 '
 
+# Test for basic rename/add-dest conflict, with rename needing content merge:
+#   Commit O: a
+#   Commit A: rename a->b, modifying b too
+#   Commit B: modify a, add different b
+
+test_expect_success 'setup rename-with-content-merge vs. add' '
+	test_create_repo rename-with-content-merge-and-add &&
+	(
+		cd rename-with-content-merge-and-add &&
+
+		test_seq 1 5 >a &&
+		git add a &&
+		git commit -m O &&
+		git tag O &&
+
+		git checkout -b A O &&
+		git mv a b &&
+		test_seq 0 5 >b &&
+		git add b &&
+		git commit -m A &&
+
+		git checkout -b B O &&
+		echo 6 >>a &&
+		echo hello world >b &&
+		git add a b &&
+		git commit -m B
+	)
+'
+
+test_expect_success 'handle rename-with-content-merge vs. add' '
+	(
+		cd rename-with-content-merge-and-add &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/add)" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		# Also, make sure both unmerged entries are for "b"
+		git ls-files -u b >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		test_path_is_missing a &&
+		test_path_is_file b &&
+
+		test_seq 0 6 >tmp &&
+		git hash-object tmp >expect &&
+		git rev-parse B:b >>expect &&
+		git rev-parse >actual  \
+			:2:b    :3:b   &&
+		test_cmp expect actual &&
+
+		# Test that the two-way merge in b is as expected
+		git cat-file -p :2:b >>ours &&
+		git cat-file -p :3:b >>theirs &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			ours empty theirs &&
+		test_cmp ours b
+	)
+'
+
+test_expect_success 'handle rename-with-content-merge vs. add, merge other way' '
+	(
+		cd rename-with-content-merge-and-add &&
+
+		git reset --hard &&
+		git clean -fdx &&
+
+		git checkout B^0 &&
+
+		test_must_fail git merge -s recursive A^0 >out &&
+		test_i18ngrep "CONFLICT (rename/add)" out &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		# Also, make sure both unmerged entries are for "b"
+		git ls-files -u b >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		test_path_is_missing a &&
+		test_path_is_file b &&
+
+		test_seq 0 6 >tmp &&
+		git rev-parse B:b >expect &&
+		git hash-object tmp >>expect &&
+		git rev-parse >actual  \
+			:2:b    :3:b   &&
+		test_cmp expect actual &&
+
+		# Test that the two-way merge in b is as expected
+		git cat-file -p :2:b >>ours &&
+		git cat-file -p :3:b >>theirs &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "A^0" \
+			ours empty theirs &&
+		git hash-object b >actual &&
+		git hash-object ours >expect &&
+		test_cmp ours b
+	)
+'
+
 # Test for all kinds of things that can go wrong with rename/rename (2to1):
 #   Commit A: new files: a & b
 #   Commit B: rename a->c, modify b
-- 
2.22.0.rc3.1.gd51cc00994

