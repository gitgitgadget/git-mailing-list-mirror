Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65A7C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D6161056
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhILNYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhILNYs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30667C061757
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso4930566wms.3
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IiS3fEfviUExWgb8WB/VoOys2Wk2rRgn6Qzz5WQY2aU=;
        b=chJgrHeMjnJup3YJPvDRoBTlhU3w/xfdRXxz/zlJEMN7wBwuxucDL0qivjLuqTkrLG
         BlRGn8/QrHKWE5PuBzXDc/ze4e1qIt8JfsifqsPEPfuoWLrsK6BjbOXUsFHNnO2UCUaZ
         +sxwux2loaBXQ84BREs4gr+8WNgxC6Mkw0NAUxLqGPsEMwLcKSVq0TVTJi1mTx2kd3Ub
         i1UTOm1tqhqUxUmWEKKHO2sY6uxfuUyUoXUBDlGs9gkGhfsyyOBsy+2frou8k5aqLcQe
         G+uVDK8q64gM+lpP+/v1Fhh7aZltkdzqRSXHfKfJ53fJ1JroLOyC0RslxxeVOmsMNooh
         6Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IiS3fEfviUExWgb8WB/VoOys2Wk2rRgn6Qzz5WQY2aU=;
        b=SNDtuB1O/V2doekxWUDSzOLSodhdBW8cLnSXl6BmXSDUsT3kGPkCoyuo2Lh6nK4SID
         XYHYe+iwb39oyOIuFcvoVaPfWiiygwYA3xeAvIvIM6Dc1IkY16Iqc33ccPz6+cR3GgLQ
         IIi4ww4uPKiN9LPmCGhSDfLaRZETw8zeHTB5iOwede0bMQqNFf+5DgIvvwbJqj3YyWYa
         v34gu/QI7vFJVEfnKTgrYmkSvuyvl+KbkLlyYqAkGJU6af1m0Q/0RjL8GarolOR5WjY6
         1KuW4B5MdaJEDxqjyeq4N4+bvkI5Zbvujys4ACg6qf5FQ6mQhJr4FuVF6A+DI2T0AqUh
         yKoA==
X-Gm-Message-State: AOAM5339W8S2Wh4rQrAIsN5TdEACO/P5UuoV7F9bjgVG/Isixby7c9Ri
        YTSL58VJT/jFY8nCeOILYtpGs/nty5g=
X-Google-Smtp-Source: ABdhPJwKeTB+TJQRw6DfzCat86p68ItWXXQ1wJAcoJ8bHkZhLrYQeBg4SH4p392DYgUPH45q9creJQ==
X-Received: by 2002:a05:600c:4fc8:: with SMTP id o8mr6634153wmq.153.1631453012728;
        Sun, 12 Sep 2021 06:23:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u26sm4672550wrd.32.2021.09.12.06.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:32 -0700 (PDT)
Message-Id: <8aefce6254c0bcbbbca909a62d033c74c90f980b.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:17 +0000
Subject: [PATCH v2 01/14] t3705: test that 'sparse_entry' is unstaged
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
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
file so it exists at HEAD but is not already staged in the index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t3705-add-sparse-checkout.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 2b1fd0d0eef..af81b4b6846 100755
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
+	! grep "^M  sparse_entry\$" actual
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

