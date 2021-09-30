Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F10C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7E7619E5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351658AbhI3NjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351486AbhI3NjP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C959C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x20so10111651wrg.10
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xi8Yw8Zz+Pnv32fJpGaQ5ZIgCJdjep8vmnOjlAz8n1E=;
        b=IDs/YmkMy9F/3tP07urkBsQ9f9QwERYSX3sBMcgF8Up4fut1mrR8VoUh0nnPsA9HoG
         Vt3GxPI3H3itP8JzUSObl0gy0vlp2qnQdbHN0UEDKIdP7/BmtyPUNUbX1+O+dfrNWcE0
         GrHo0f8yv1jzIiBK8b99rD1PK0Fu1UwVJsR0dWVAiaM/C9EvEsVtajPoK3uueunKOSXb
         5IQmv7svwjefhdK0qYsQ6Yz/xBAIeLLhvHYlwilo50fVJCve5+xoz7WI2Kyze1sU+R+a
         aGzVvSzivY3uO5YFptpqhf86Nkwho7HgWrtGT58u2ujOgvW0BFwGKbtO3YxbKGEV+ue4
         l4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xi8Yw8Zz+Pnv32fJpGaQ5ZIgCJdjep8vmnOjlAz8n1E=;
        b=3dYw+ugidUULENl4ydmG+gmCgfQieWdCVqPcqpUhXQtxh3fL7FYUmsM0z3iIFzJ/SH
         JxwapmkMMYsW/BkHIk0naGcu/nvN/gJURICzStBUC8j54n1kZHlp1njjqjveKDhdkmn/
         pzjg3ALKIBfmNLmxZn0jgAmHhn28CnLk33lEOElhtVT7VIqtdJM6GTpa8LWd4iM4fLlS
         z9QX7Nu7t/7SO4SlPXJSplcfhRns8BP11iTZL/DQFdU3IkzLLxtvRFAVxIFw7JU919DM
         ulcoeEJzJShG1X+3WZTVkJPmWOO73Hm8btsMtI6C41WM+V6eW9AymCVYiE56xG/yw9/d
         Bobg==
X-Gm-Message-State: AOAM533c+kdyC2zWvcBQK/am7/dosJAs3d9MwMPhWi8V9UFHF8S33CIF
        ezpmp66zBl4drj5wf6T2uffdq7C/pHMFdjER
X-Google-Smtp-Source: ABdhPJy0eBKUjStgeb3hHtmry/C8w/vNIr7hxRnmfDEFJl06jht+91gWl/WjxiNvOmXUqw/4YFV2qA==
X-Received: by 2002:a5d:64a7:: with SMTP id m7mr6348192wrp.171.1633009051005;
        Thu, 30 Sep 2021 06:37:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 05/17] cat-file tests: move bogus_* variable declarations earlier
Date:   Thu, 30 Sep 2021 15:37:10 +0200
Message-Id: <patch-v9-05.17-278df093239-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the short/long bogus bogus object type variables into a form
where the two sets can be used concurrently. This'll be used by
subsequently added tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 18b3779ccb6..ea6a53d425b 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -315,36 +315,39 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
-bogus_type="bogus"
-bogus_content="bogus"
-bogus_size=$(strlen "$bogus_content")
-bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
+test_expect_success 'setup bogus data' '
+	bogus_short_type="bogus" &&
+	bogus_short_content="bogus" &&
+	bogus_short_size=$(strlen "$bogus_short_content") &&
+	bogus_short_sha1=$(echo_without_newline "$bogus_short_content" | git hash-object -t $bogus_short_type --literally -w --stdin) &&
+
+	bogus_long_type="abcdefghijklmnopqrstuvwxyz1234679" &&
+	bogus_long_content="bogus" &&
+	bogus_long_size=$(strlen "$bogus_long_content") &&
+	bogus_long_sha1=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
+'
 
 test_expect_success "Type of broken object is correct" '
-	echo $bogus_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_short_type >expect &&
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success "Size of broken object is correct" '
-	echo $bogus_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_short_size >expect &&
+	git cat-file -s --allow-unknown-type $bogus_short_sha1 >actual &&
 	test_cmp expect actual
 '
-bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
-bogus_content="bogus"
-bogus_size=$(strlen "$bogus_content")
-bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
 
 test_expect_success "Type of broken object is correct when type is large" '
-	echo $bogus_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_long_type >expect &&
+	git cat-file -t --allow-unknown-type $bogus_long_sha1 >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success "Size of large broken object is correct when type is large" '
-	echo $bogus_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
+	echo $bogus_long_size >expect &&
+	git cat-file -s --allow-unknown-type $bogus_long_sha1 >actual &&
 	test_cmp expect actual
 '
 
-- 
2.33.0.1374.g05459a61530

