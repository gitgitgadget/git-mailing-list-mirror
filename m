Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3736DC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0331C214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef0UdP5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgAaUQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35197 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgAaUQV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so10179770wro.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FZrkWwoOV3NNkcvOwJlM7IbVcGOH3Js85ThSFj7lETA=;
        b=Ef0UdP5v4WQXXMz+ScNCcUuQc/gquBaW+UqTUn9nAndKhi+euqlvVeGQesJBu8C2r7
         4chDoaOtDrk173rXn3OakEOK90b22gdo212ZBq7fGeDZezpjILprdcvFRljI7YINVgC0
         NNvs/sRMotUuLR1r1f8lGo2cv73Es9wLZ30IgG91erM97EZgp0NJakYjDG0A3SJFzYzE
         c4rk8JXQxr7RbBJqD6iT3nLzLC9dXUYDrnFxL72RzU2zTpCBHw3m3/DriGoPxKIC0mGv
         pgS6ycQoi/MUnZT0FT1JIVGQlfjhvpWH2lfwBiE9gZswNGuLN7HYd6dxsYq6zx6hX/Wy
         twAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FZrkWwoOV3NNkcvOwJlM7IbVcGOH3Js85ThSFj7lETA=;
        b=I0rkv5/VeE75pjej9Tq3wCRqKm7xkjmw/LjPCRn39F7CEWQim2Z/rAJBFKVg/cbtoj
         RJ+8PQZND3C/gJqA3gMZ6k1hGOPlFn0wf1kM1a3sKetQElou69G0vEh1QBDNF9TLrU2e
         A5PhztnUxV+pj4qf21PdBOd+LiF+y4XOcnqSanR4AOKSMUXyT0G3Z3QMGxC5s6xbgZpH
         2ZBQNNwrN1EmKy8HdVzfGQgsaFoQQvHghmMvoCNAbJ/mbevI8bqt+mC7HvZD44gA7GAO
         V7L/Z9VCLTiFrtFSJwPcVolwBo0IZRzA2VyrkjW0WoZziWVcswzly2qTfUDYJsaZq0Yo
         Kybg==
X-Gm-Message-State: APjAAAVwCGuyNMxcDulpSAAPaHkuhjk3sP1YhjzwlBscqOGD5dVtaZN6
        m9peWUoDxptT5BcqFvcvjLKwRBMQ
X-Google-Smtp-Source: APXvYqxk6gcpmkuRb5bckPsc5stku04TEtlbq5AvE+dq8IVEgo/HZ3HuGnOq2v/akgKdbh6XioQszA==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr105310wru.353.1580501777944;
        Fri, 31 Jan 2020 12:16:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm4119259wrb.33.2020.01.31.12.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:17 -0800 (PST)
Message-Id: <b7a6ad145af6a5560bb07ed7e36f587f0f60f41f.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:02 +0000
Subject: [PATCH v4 02/15] t1091: improve here-docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

t1091-sparse-checkout-builtin.sh uses here-docs to populate the
expected contents of the sparse-checkout file. These do not use
shell interpolation, so use "-\EOF" instead of "-EOF". Also use
proper tabbing.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1091-sparse-checkout-builtin.sh | 98 +++++++++++++++---------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e058a20ad6..e28e1c797f 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -46,11 +46,11 @@ test_expect_success 'git sparse-checkout list (empty)' '
 
 test_expect_success 'git sparse-checkout list (populated)' '
 	test_when_finished rm -f repo/.git/info/sparse-checkout &&
-	cat >repo/.git/info/sparse-checkout <<-EOF &&
-		/folder1/*
-		/deep/
-		**/a
-		!*bin*
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/folder1/*
+	/deep/
+	**/a
+	!*bin*
 	EOF
 	cp repo/.git/info/sparse-checkout expect &&
 	git -C repo sparse-checkout list >list &&
@@ -59,9 +59,9 @@ test_expect_success 'git sparse-checkout list (populated)' '
 
 test_expect_success 'git sparse-checkout init' '
 	git -C repo sparse-checkout init &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
 	test_cmp_config -C repo true core.sparsecheckout &&
@@ -70,9 +70,9 @@ test_expect_success 'git sparse-checkout init' '
 
 test_expect_success 'git sparse-checkout list after init' '
 	git -C repo sparse-checkout list >actual &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
 	EOF
 	test_cmp expect actual
 '
@@ -80,10 +80,10 @@ test_expect_success 'git sparse-checkout list after init' '
 test_expect_success 'init with existing sparse-checkout' '
 	echo "*folder*" >> repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		*folder*
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	*folder*
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
 	check_files repo a folder1 folder2
@@ -92,9 +92,9 @@ test_expect_success 'init with existing sparse-checkout' '
 test_expect_success 'clone --sparse' '
 	git clone --sparse repo clone &&
 	git -C clone sparse-checkout list >actual &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
 	EOF
 	test_cmp expect actual &&
 	check_files clone a
@@ -116,10 +116,10 @@ test_expect_success 'set enables config' '
 
 test_expect_success 'set sparse-checkout using builtin' '
 	git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		*folder*
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	*folder*
 	EOF
 	git -C repo sparse-checkout list >actual &&
 	test_cmp expect actual &&
@@ -128,11 +128,11 @@ test_expect_success 'set sparse-checkout using builtin' '
 '
 
 test_expect_success 'set sparse-checkout using --stdin' '
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		/folder1/
-		/folder2/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/folder1/
+	/folder2/
 	EOF
 	git -C repo sparse-checkout set --stdin <expect &&
 	git -C repo sparse-checkout list >actual &&
@@ -179,28 +179,28 @@ test_expect_success 'cone mode: init and set' '
 	check_files repo a deep &&
 	check_files repo/deep a deeper1 &&
 	check_files repo/deep/deeper1 a deepest &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		/deep/
-		!/deep/*/
-		/deep/deeper1/
-		!/deep/deeper1/*/
-		/deep/deeper1/deepest/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/deep/
+	!/deep/*/
+	/deep/deeper1/
+	!/deep/deeper1/*/
+	/deep/deeper1/deepest/
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	git -C repo sparse-checkout set --stdin 2>err <<-EOF &&
-		folder1
-		folder2
+	git -C repo sparse-checkout set --stdin 2>err <<-\EOF &&
+	folder1
+	folder2
 	EOF
 	test_must_be_empty err &&
 	check_files repo a folder1 folder2
 '
 
 test_expect_success 'cone mode: list' '
-	cat >expect <<-EOF &&
-		folder1
-		folder2
+	cat >expect <<-\EOF &&
+	folder1
+	folder2
 	EOF
 	git -C repo sparse-checkout set --stdin <expect &&
 	git -C repo sparse-checkout list >actual 2>err &&
@@ -211,10 +211,10 @@ test_expect_success 'cone mode: list' '
 test_expect_success 'cone mode: set with nested folders' '
 	git -C repo sparse-checkout set deep deep/deeper1/deepest 2>err &&
 	test_line_count = 0 err &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		/deep/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/deep/
 	EOF
 	test_cmp repo/.git/info/sparse-checkout expect
 '
@@ -271,10 +271,10 @@ test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status'
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	git -C repo sparse-checkout init --cone &&
 	git -C repo -c core.ignoreCase=true sparse-checkout set folder1 &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		/folder1/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/folder1/
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
 	check_files repo a folder1
-- 
gitgitgadget

