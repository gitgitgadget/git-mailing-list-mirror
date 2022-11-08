Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E401DC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiKHSSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbiKHSR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:17:59 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96EBB2
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:17:58 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id m22so3583958eji.10
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93DNEjn9CIk1RX2yBDLXWeCubWOpbFBS2wJZepZiEig=;
        b=lT/yJA4ORvNXTwnUtml4OIqH0y6NputebGyQl3YNoi8QhmryOtsY6G/xkO77i6yFEd
         9kaXM7OYYUaKtdeQgCwxd5F1YIyFckHObzWqISl7cTu0BLJ/TthPgsCa6AmSmPq//qNm
         lhzM4yr7dVBZLo3Fd7aGgef0jD4afm+YTiw4h7s8FLM0qdps+pj7cDGE5jmZMQKRdZn9
         DmdFyIwCxVG3e58JcYywY13usYRWO9W3fs918s8bIaj/PwgctUAySy00TBfBqCC2LKwd
         JLzPc0Td7CtcleOy+aikI5MWCCvS2K22tsAS2BAQCeIF2WERaLW5U94rxHlMZfqWKhjh
         tQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93DNEjn9CIk1RX2yBDLXWeCubWOpbFBS2wJZepZiEig=;
        b=oRK8lgAmu2v4wDVPRMUpJFxhc5fx+65rOWWHznX2Rtl4u4U7dU7YEaSbKTd3W+TIWK
         TGFE1/1ivDfpX8Vb/6TI/n7ssZ2ClBevdpROHovMh7G9aF6LRO5wEH4yrjNAlGYR4zVB
         WxFGK581h4TIjsVkSgsj+CXO/ETcnYI7yp3EuidwDO5iqgGKKHqrFHd3iQmOve+twbyd
         TsR3EEVHJAlnk5TvKoQM5IBIJ7/0g6QnwepwUC7clS2uZ+NETS68F2L1tfXNYEJ00561
         uklLTMylz+3+NR6PbykCVaG858VF8cwPry0kWlmEuGZDEHgWBOkYwNRnmgPbnPotkDdN
         sQxQ==
X-Gm-Message-State: ANoB5pnu8f2aLuBtXT9Rx2HvXU0LlW3lO9cCDR/jMUL5eboQ6d9BQiU7
        Rq0rfyhYWowkpUJ0DfhfvWH6vZT/wYPXHQ==
X-Google-Smtp-Source: AA0mqf6qCeVEck7jxxGukZFXq3FOhl41efBpOBIJY0QPPKM1mEaezfvRYPCIRXfDw0hQUP5lK0rdMQ==
X-Received: by 2002:a17:907:728a:b0:78d:2b4b:e7f7 with SMTP id dt10-20020a170907728a00b0078d2b4be7f7mr8974674ejc.269.1667931476586;
        Tue, 08 Nov 2022 10:17:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:17:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/15] read-cache.c: clear and free "sparse_checkout_patterns"
Date:   Tue,  8 Nov 2022 19:17:40 +0100
Message-Id: <patch-v2-04.15-24cefde07f0-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "sparse_checkout_patterns" member was added to the "struct
index_state" in 836e25c51b2 (sparse-checkout: hold pattern list in
index, 2021-03-30), but wasn't added to discard_index(). Let's do
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c                         | 5 +++++
 t/t1011-read-tree-sparse-checkout.sh | 1 +
 t/t2018-checkout-branch.sh           | 1 +
 t/t6435-merge-sparse.sh              | 1 +
 4 files changed, 8 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 32024029274..7c6477487a7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2558,6 +2558,11 @@ int discard_index(struct index_state *istate)
 	free_untracked_cache(istate->untracked);
 	istate->untracked = NULL;
 
+	if (istate->sparse_checkout_patterns) {
+		clear_pattern_list(istate->sparse_checkout_patterns);
+		FREE_AND_NULL(istate->sparse_checkout_patterns);
+	}
+
 	if (istate->ce_mem_pool) {
 		mem_pool_discard(istate->ce_mem_pool, should_validate_cache_entries());
 		FREE_AND_NULL(istate->ce_mem_pool);
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 742f0fa909f..595b24c0adb 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -12,6 +12,7 @@ test_description='sparse checkout tests
 '
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 771c3c3c50e..8581ad34379 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -3,6 +3,7 @@
 test_description='checkout'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Arguments: [!] <branch> <oid> [<checkout options>]
diff --git a/t/t6435-merge-sparse.sh b/t/t6435-merge-sparse.sh
index fde4aa3cd1a..78628fb248a 100755
--- a/t/t6435-merge-sparse.sh
+++ b/t/t6435-merge-sparse.sh
@@ -3,6 +3,7 @@
 test_description='merge with sparse files'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # test_file $filename $content
-- 
2.38.0.1467.g709fbdff1a9

