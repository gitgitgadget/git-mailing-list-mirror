Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB677C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiKCRHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiKCRHK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FD51DA56
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r14so4034505edc.7
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU+9AWIejphbpVBjwlj5U8k/7KBsgtJC7eA4B86uq6g=;
        b=eoAiaj40oQ5O/YSmtL3cso+K4ZhdnkuLz1rUVLW/RtAnRwIOZmQ49Dm1ePRU8vxk2I
         gD8gzZp407GtTJ2LoRlv3G9QiAaSZXc4HEUS7bYpnsOnFcLk6yrl1Ok42R92YNQC0KQr
         ASGFTPUggRaxAmjidjkUBe3ikFWLn8KBdix+Fduanh1C5Tb8vWKOr0ifTXDuOLc9M5Eu
         ox36QoppFXaUwVSAQlXmq8QeJrkx9H6ZUi96ilgk9m9otQQZpyA8QD1C9tGNcmmZETNz
         PCH1SeUAOVWOAfFnsEqEncksrCulJuJnAM7AooY7bXp8yM/ovTRdx4+ompRVGOJA9g6y
         uGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU+9AWIejphbpVBjwlj5U8k/7KBsgtJC7eA4B86uq6g=;
        b=P4lrE/linUqXQRgsfSMYi3wmD5MvsucM4JrhYT+oiTMC/QH5HkyJvPne0WqXUr+sXx
         YtxIXXiuTDXahSqEu6QmOqfbUY5WOOpRncl1f1tJOhmQfH/8cQTLqtqamVPCmS1ME45F
         3Bx7CiUKVH8sfuzMIzktVOWONpsuu3YBqgUOXNzZBDm8D5oWHs+G2Z+o1vrSk9/5Hlh7
         m6Aia8O9zgXXYVhDggmYCR7xP9q/qZ4LIIRbxklL0MEqIa/pG1ij5XDAWFj79SXMG0Mi
         uoXbVFb5PYSAHl7WdeNqTDWE4XKzSwYSRZdhbviTHnO5A0GRjgqUyIpp9q200rB56x/2
         xyKg==
X-Gm-Message-State: ACrzQf35bcUkIqTD9yMzgSEdIDQGzfpRoJWz4GsDqZ6INFxdeolCxUFu
        g4d8MbRXNTGyRtLf/2WlMupgvKpFwM3SSg==
X-Google-Smtp-Source: AMsMyM5OU36MUG4X/2yT8JDe6dHTkTF6wIs7apRHavRNj/jncsA616LR5V77245yexdRF7bsZn2HPQ==
X-Received: by 2002:a05:6402:27d2:b0:462:8e41:569c with SMTP id c18-20020a05640227d200b004628e41569cmr31596393ede.191.1667495183378;
        Thu, 03 Nov 2022 10:06:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:22 -0700 (PDT)
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
Subject: [PATCH 04/17] read-cache.c: clear and free "sparse_checkout_patterns"
Date:   Thu,  3 Nov 2022 18:06:03 +0100
Message-Id: <patch-04.17-68a390619b9-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
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
2.38.0.1451.g86b35f4140a

