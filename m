Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93356C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C46660F48
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241896AbhITXin (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243075AbhITXgh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:36:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED77C0EDAF3
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w29so32028708wra.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KspwnxdSa8Er+jl4dIgKxxwdOBY1RzcdnW/5uRa4oOI=;
        b=aKmztAC0UW1t1v3TDt+bFVlpiSGgSMNza6L9l9DhOqXLnAtDgoZJqbSCVN84H2JSP9
         tOvmk5HC0tRKeOLHiBxsLO4slGrUEBHV25Kh1GGJbRFfagw05cCMfetrjp32qmHxqEKD
         jJbng5P1tMTBnAgLJN29EKZbSJ0XOZ5MX7zrUsrA9kXwQknBDe9ofd8hXdaQ4VA6Bn2F
         pfmGlvOE5agA0kYXaKFj/pFVV4aMDyEwYcdULdAz+IUV54Yv21dT53hdwo8wN+7stYiP
         oqfXg+NnMmlPIAAt+Pp8ZCR6lV/fxtEy9FB9qm2RXVRS3uj1VoXsgiWLjZsQNYBp3tYe
         c8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KspwnxdSa8Er+jl4dIgKxxwdOBY1RzcdnW/5uRa4oOI=;
        b=K6edRA8qbLbfiNBahj8T52T2H5WnbLSXqh3B/p+gqBfCW7AXNVlY1eXUrgxiNKwDAi
         Zx2NyKMrS+gRKPvLpJNybmuPqYHi22dAL83T8wFOlKiaTq75JeKTKMSc67XbCD0/pTVy
         pddqymaitKE2q52RkVuPo63qEF6/UZbAMlkYVE63Vi6uOl6lW8GfbvgjG9xme5un3SDZ
         JVvzGBQt6LhBsq+SerhVyPX9Iul6D2qrvJbMycQtjyVCn+3vpU+K0xpRyjtd3XX47E7M
         15/dWZaVH8j0/5sROMe/u5W4knI9iQEEw/COHJ5RbVf/pcjBMhTeSM7jUiy6/RYMIE4N
         854A==
X-Gm-Message-State: AOAM531c8Dd5NJPyJeiAfA/ZOq3J1OUmePc6uBwYRjpPbzaifEjkJ451
        DrOk0xKvwBD/bm0M/rsI7UsqO6F25sM=
X-Google-Smtp-Source: ABdhPJzVfAphOu3vDdnmzpcBY6IPUV5MZSQiaVxz7hsXKcC/9JtKFJbRAq5M+6Y2b/P0mTzlFV/rCw==
X-Received: by 2002:adf:f486:: with SMTP id l6mr29409501wro.375.1632159939808;
        Mon, 20 Sep 2021 10:45:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm858252wmj.0.2021.09.20.10.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:39 -0700 (PDT)
Message-Id: <ea940f10a7cd26c6be3693b5a800afb7d6f752f2.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:24 +0000
Subject: [PATCH v3 01/14] t3705: test that 'sparse_entry' is unstaged
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The tests in t3705-add-sparse-checkout.sh check to see how 'git add'
behaves with paths outside the sparse-checkout definition. These
currently check to see if a given warning is present but not that the
index is not updated with the sparse entries. Add a new
'test_sparse_entry_unstaged' helper to be sure 'git add' is behaving
correctly.

We need to modify setup_sparse_entry to actually commit the sparse_entry
file so it exists at HEAD and as an entry in the index, but its exact
contents are not staged in the index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t3705-add-sparse-checkout.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 2b1fd0d0eef..e202a2ff74a 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -19,6 +19,7 @@ setup_sparse_entry () {
 	fi &&
 	git add sparse_entry &&
 	git update-index --skip-worktree sparse_entry &&
+	git commit --allow-empty -m "ensure sparse_entry exists at HEAD" &&
 	SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
 }
 
@@ -36,6 +37,11 @@ setup_gitignore () {
 	EOF
 }
 
+test_sparse_entry_unstaged () {
+	git status --porcelain >actual &&
+	! grep "^[MDARCU][M ] sparse_entry\$" actual
+}
+
 test_expect_success 'setup' "
 	cat >sparse_error_header <<-EOF &&
 	The following pathspecs didn't match any eligible path, but they do match index
@@ -55,6 +61,7 @@ test_expect_success 'git add does not remove sparse entries' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
 	test_must_fail git add sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
@@ -73,6 +80,7 @@ test_expect_success 'git add . does not remove sparse entries' '
 	rm sparse_entry &&
 	setup_gitignore &&
 	test_must_fail git add . 2>stderr &&
+	test_sparse_entry_unstaged &&
 
 	cat sparse_error_header >expect &&
 	echo . >>expect &&
@@ -88,6 +96,7 @@ do
 		setup_sparse_entry &&
 		echo modified >sparse_entry &&
 		test_must_fail git add $opt sparse_entry 2>stderr &&
+		test_sparse_entry_unstaged &&
 		test_cmp error_and_hint stderr &&
 		test_sparse_entry_unchanged
 	'
@@ -98,6 +107,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
 	git ls-files --debug sparse_entry | grep mtime >before &&
 	test-tool chmtime -60 sparse_entry &&
 	test_must_fail git add --refresh sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	git ls-files --debug sparse_entry | grep mtime >after &&
 	test_cmp before after
@@ -106,6 +116,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
 test_expect_success 'git add --chmod does not update sparse entries' '
 	setup_sparse_entry &&
 	test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged &&
 	! test -x sparse_entry
@@ -116,6 +127,7 @@ test_expect_success 'git add --renormalize does not update sparse entries' '
 	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
 	echo "sparse_entry text=auto" >.gitattributes &&
 	test_must_fail git add --renormalize sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
@@ -124,6 +136,7 @@ test_expect_success 'git add --dry-run --ignore-missing warn on sparse path' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
 	test_must_fail git add --dry-run --ignore-missing sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
@@ -148,6 +161,7 @@ test_expect_success 'do not warn when pathspec matches dense entries' '
 test_expect_success 'add obeys advice.updateSparsePath' '
 	setup_sparse_entry &&
 	test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp sparse_entry_error stderr
 
 '
-- 
gitgitgadget

