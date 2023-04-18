Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B783BC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjDRUlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjDRUky (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:40:54 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38332C670
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:49 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fe3cd445aso168683327b3.5
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681850448; x=1684442448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bLMfk3306UpekY3xnL2cHG7+MAMdF8giKuJ6YI8Hac=;
        b=q0300kfTqO0FffcZMaJOj3/Hgv53VWkcXPx8mdxEAIerCB2ymaGHAZ1xBcbmnZGueo
         5L3gWaQz9qpJqBLVmKtFZrmSRx1WXyWso7ZtbB5DyiMQnbfm9iQVR+VMEDcOScYNxK7b
         JoQA1OOD/TPN+Hf+1MKnswy2lRRELDxWdH5QK8gjnXN0Zzr5tqR6EgvuNysRKXU91mO5
         1/uJUkZKKNvSaqjWZoUxMbjzhP8rPBr/ZJUpeAaFn/FcrY11NwpG1eHlZhzHPR0ANrrq
         FnSDXo7FnikT8/FgJGVYwxDV3K3ZuQEtIB8cssI494I4LXCN3ufVwCf/eNYGfUsMnSPg
         5jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850448; x=1684442448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bLMfk3306UpekY3xnL2cHG7+MAMdF8giKuJ6YI8Hac=;
        b=HnEBbShz+op9jkcn8iRWEbgGntLCEfGF6Tu6dI8adY4LqRv2F2Cct/LQcxFv3T64Kl
         8dYAA7e68HbqAh5Aaf7KY4qd+XhhzF6H81jre31IbvJdrAqeRoUoo+HA5TVqlmpXVitR
         +NiNMuDkN1QDD2kruOh+TeVBi7yFL+7E+HfEw0fY4XqRoHSiU0HpkZ85nfuViPgV0SnX
         OVBfkuYqjBoVtfCUdDOWwEYzGF53OQO6UbLZChDTLdQn7wH8kIjv8ihgr0qL2LXXTLC2
         zUWk1zw2sJr1Oog+qGwPCB2JCaSH+e5bDj2BrxiHl8thyn1wB57GoJAwFMk703YT0zaA
         gA6Q==
X-Gm-Message-State: AAQBX9eC6iY6cFV3rf5+9NOt1wDhhNMvVQpFtE5YiVofvjgttGiW/+Cg
        SAe+KMxu9/MYYPXixJt1IWRGAW2rQmCNK9ONQcTBMA==
X-Google-Smtp-Source: AKy350bw57QekciFqcuOxoTJnh+FXGa7osp3amC75i6N3+QBmDOnCCJDMYr1hSXSBEPu6YTwIB6nOA==
X-Received: by 2002:a0d:c102:0:b0:54f:d7f7:9d61 with SMTP id c2-20020a0dc102000000b0054fd7f79d61mr1275589ywd.14.1681850448166;
        Tue, 18 Apr 2023 13:40:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v132-20020a81488a000000b0054fa99bed5asm4048696ywa.129.2023.04.18.13.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:40:47 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:40:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/10] t/t6500-gc.sh: refactor cruft pack tests
Message-ID: <e6270d75fa1112a7ed92a87f3d0cf24187292d10.1681850424.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681850424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 12253ab6d0 (gc: add tests for --cruft and friends, 2022-10-26), we
added a handful of tests to t6500 to ensure that `git gc` respected the
value of `--cruft` and `gc.cruftPacks`.

Then, in c695592850 (config: let feature.experimental imply
gc.cruftPacks=true, 2022-10-26), another set of similar tests was added
to ensure that `feature.experimental` correctly implied enabling cruft
pack generation (or not).

These tests are similar and could be consolidated. Do so in this patch
to prepare for expanding the set of command-line invocations that enable
or disable writing cruft packs. This makes it possible to easily test
more combinations of arguments without being overly repetitive.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t6500-gc.sh | 126 ++++++++++++++++++--------------------------------
 1 file changed, 44 insertions(+), 82 deletions(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index df6f2e6e52..a2f988c5c2 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -210,93 +210,55 @@ prepare_cruft_history () {
 	git reset HEAD^^
 }
 
-assert_cruft_packs () {
-	find .git/objects/pack -name "*.mtimes" >mtimes &&
-	sed -e 's/\.mtimes$/\.pack/g' mtimes >packs &&
-
-	test_file_not_empty packs &&
-	while read pack
-	do
-		test_path_is_file "$pack" || return 1
-	done <packs
-}
-
 assert_no_cruft_packs () {
 	find .git/objects/pack -name "*.mtimes" >mtimes &&
 	test_must_be_empty mtimes
 }
 
-test_expect_success 'gc --cruft generates a cruft pack' '
-	test_when_finished "rm -fr crufts" &&
-	git init crufts &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git gc --cruft &&
-		assert_cruft_packs
-	)
-'
-
-test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
-	test_when_finished "rm -fr crufts" &&
-	git init crufts &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git -c gc.cruftPacks=true gc &&
-		assert_cruft_packs
-	)
-'
-
-test_expect_success 'feature.experimental=true generates a cruft pack' '
-	git init crufts &&
-	test_when_finished "rm -fr crufts" &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git -c feature.experimental=true gc &&
-		assert_cruft_packs
-	)
-'
-
-test_expect_success 'feature.experimental=false allows explicit cruft packs' '
-	git init crufts &&
-	test_when_finished "rm -fr crufts" &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git -c gc.cruftPacks=true -c feature.experimental=false gc &&
-		assert_cruft_packs
-	)
-'
-
-test_expect_success 'feature.experimental=true can be overridden' '
-	git init crufts &&
-	test_when_finished "rm -fr crufts" &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git -c feature.expiremental=true -c gc.cruftPacks=false gc &&
-		assert_no_cruft_packs
-	)
-'
-
-test_expect_success 'feature.experimental=false avoids cruft packs by default' '
-	git init crufts &&
-	test_when_finished "rm -fr crufts" &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git -c feature.experimental=false gc &&
-		assert_no_cruft_packs
-	)
-'
+for argv in \
+	"gc --cruft" \
+	"-c gc.cruftPacks=true gc" \
+	"-c feature.experimental=true gc" \
+	"-c gc.cruftPacks=true -c feature.experimental=false gc"
+do
+	test_expect_success "git $argv generates a cruft pack" '
+		test_when_finished "rm -fr repo" &&
+		git init repo &&
+		(
+			cd repo &&
+
+			prepare_cruft_history &&
+			git $argv &&
+
+			find .git/objects/pack -name "*.mtimes" >mtimes &&
+			sed -e 's/\.mtimes$/\.pack/g' mtimes >packs &&
+
+			test_file_not_empty packs &&
+			while read pack
+			do
+				test_path_is_file "$pack" || return 1
+			done <packs
+		)
+	'
+done
+
+for argv in \
+	"-c feature.expiremental=true -c gc.cruftPacks=false gc" \
+	"-c feature.experimental=false gc"
+do
+	test_expect_success "git $argv does not generate a cruft pack" '
+		test_when_finished "rm -fr repo" &&
+		git init repo &&
+		(
+			cd repo &&
+
+			prepare_cruft_history &&
+			git $argv &&
+
+			assert_no_cruft_packs
+		)
+	'
+done
 
 test_expect_success '--keep-largest-pack ignores cruft packs' '
 	test_when_finished "rm -fr repo" &&
-- 
2.40.0.362.gc67ee7c2ff

