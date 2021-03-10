Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572AEC4332E
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143DB64FE5
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhCJTbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhCJTbK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:10 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB2C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e10so24610054wro.12
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sr8T60pvjyaHGo05oWI6Lye8k/6nZgW5k/6ArV7rGJ8=;
        b=CYrEFxfScBIWo/a767gRPubKMPC+NAXMFdEJj8fXvnsOWRY0NCrLH6WTmX6G+ohdHL
         ZifK9yFnO7QvyV0jjc5uRJY8aHt3GiW+Ssceo85k9lAaGaU6iMfCP28/6pI4qsSwaD++
         cw+ucQNwv1GzlH60Dtr3DQUhWDebEML0Yb2NVCknp8Pr/bs6mCtYudAoZk1z/onw29mw
         JT/0RiwitV3SkxBruCBocePjXvlL9AaMJgBtOBhikO1EQrTnraAuymFz9LLlIQGXoUHX
         O3btunF/WqubRLii7aGCJR7zA6SfhRI1OXp5x1YjPULL4ZJXjxgKleMqs27G1XIXoD2V
         ZbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sr8T60pvjyaHGo05oWI6Lye8k/6nZgW5k/6ArV7rGJ8=;
        b=LWYZt2cEySlIbeFRN8SbaMUhAgZDp+PnJmpY8dVrVCTZrsPtaZYdGdDfYyDnjJMImh
         f7z1uuZCbSmD8LBKEmU1bYeQehyw8+rUL04PdtVv+mj+fHmWNKQplot3jbO94Udqx/z/
         qXR66kx7bFpsr9H750G0OmMqttPj6/HndpuKfUrsMyu8LKWmNnfRXXYyZ67iFppWkm0+
         aBGyVsqwoCGpfITkJUq6HylRjIn5DdAjO8X7k5j8IFsGTbR7SsOMsEazjvPsvwiiNg4y
         BScyBU2ie/MEW4be89tT4QwclnoB/0l9Mo/RAovrmJKejQpmyuwOSTcAWqcHgm3PtjvX
         CGTA==
X-Gm-Message-State: AOAM530yOLbummIg8uy575a3xh1rKFRXZ8bssjI1dyRbYK+PePsWSHA/
        WS4GdlGYZRtgH1Q2ExNxlKd1Ots7t3Y=
X-Google-Smtp-Source: ABdhPJxK9VtxWJwG8MKbbVHaP3wsGLS7nP947ZtmZMeaGYPcuGcV4JUEVz9YhYKSDz9lH5BDUuGqdA==
X-Received: by 2002:adf:8562:: with SMTP id 89mr5108976wrh.101.1615404669191;
        Wed, 10 Mar 2021 11:31:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm307264wrw.69.2021.03.10.11.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:08 -0800 (PST)
Message-Id: <5cbedb377b37ebdc103d9d94e68b6621bcd3d3cf.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:46 +0000
Subject: [PATCH v2 03/20] t1092: clean up script quoting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This test was introduced in 19a0acc83e4 (t1092: test interesting
sparse-checkout scenarios, 2021-01-23), but these issues with quoting
were not noticed until starting this follow-up series. The old mechanism
would drop quoting such as in

   test_all_match git commit -m "touch README.md"

The above happened to work because README.md is a file in the
repository, so 'git commit -m touch REAMDE.md' would succeed by
accident.

Other cases included quoting for no good reason, so clean that up now.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8cd3e5a8d227..3725d3997e70 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -96,20 +96,20 @@ init_repos () {
 run_on_sparse () {
 	(
 		cd sparse-checkout &&
-		$* >../sparse-checkout-out 2>../sparse-checkout-err
+		"$@" >../sparse-checkout-out 2>../sparse-checkout-err
 	)
 }
 
 run_on_all () {
 	(
 		cd full-checkout &&
-		$* >../full-checkout-out 2>../full-checkout-err
+		"$@" >../full-checkout-out 2>../full-checkout-err
 	) &&
-	run_on_sparse $*
+	run_on_sparse "$@"
 }
 
 test_all_match () {
-	run_on_all $* &&
+	run_on_all "$@" &&
 	test_cmp full-checkout-out sparse-checkout-out &&
 	test_cmp full-checkout-err sparse-checkout-err
 }
@@ -119,7 +119,7 @@ test_expect_success 'status with options' '
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git status --porcelain=v2 -z -u &&
 	test_all_match git status --porcelain=v2 -uno &&
-	run_on_all "touch README.md" &&
+	run_on_all touch README.md &&
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git status --porcelain=v2 -z -u &&
 	test_all_match git status --porcelain=v2 -uno &&
@@ -135,7 +135,7 @@ test_expect_success 'add, commit, checkout' '
 	write_script edit-contents <<-\EOF &&
 	echo text >>$1
 	EOF
-	run_on_all "../edit-contents README.md" &&
+	run_on_all ../edit-contents README.md &&
 
 	test_all_match git add README.md &&
 	test_all_match git status --porcelain=v2 &&
@@ -144,7 +144,7 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout HEAD~1 &&
 	test_all_match git checkout - &&
 
-	run_on_all "../edit-contents README.md" &&
+	run_on_all ../edit-contents README.md &&
 
 	test_all_match git add -A &&
 	test_all_match git status --porcelain=v2 &&
@@ -153,7 +153,7 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout HEAD~1 &&
 	test_all_match git checkout - &&
 
-	run_on_all "../edit-contents deep/newfile" &&
+	run_on_all ../edit-contents deep/newfile &&
 
 	test_all_match git status --porcelain=v2 -uno &&
 	test_all_match git status --porcelain=v2 &&
@@ -186,7 +186,7 @@ test_expect_success 'diff --staged' '
 	write_script edit-contents <<-\EOF &&
 	echo text >>README.md
 	EOF
-	run_on_all "../edit-contents" &&
+	run_on_all ../edit-contents &&
 
 	test_all_match git diff &&
 	test_all_match git diff --staged &&
@@ -280,7 +280,7 @@ test_expect_success 'clean' '
 	echo bogus >>.gitignore &&
 	run_on_all cp ../.gitignore . &&
 	test_all_match git add .gitignore &&
-	test_all_match git commit -m ignore-bogus-files &&
+	test_all_match git commit -m "ignore bogus files" &&
 
 	run_on_sparse mkdir folder1 &&
 	run_on_all touch folder1/bogus &&
-- 
gitgitgadget

