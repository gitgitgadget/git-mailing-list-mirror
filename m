Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D25C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 17:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiCQR25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiCQR2y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 13:28:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B013211EE8
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t11so8344620wrm.5
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQojHDXqff2wnMn35vq6vsn/hS5GJSrbd7DTdIvJ8Po=;
        b=SwD9g0ucx0Cl2tl7BxWKTaE88fm9imm0L9i12bfOYLYQROM7NIwYrtFJHbdQ2AZiDf
         7INj7jljtvsEEvtgtefvvUYNgWd867E9ta2Ye+n7NXPwl8YgxrzmMo9FZd9G2lquIUnz
         F6nczMi6tk0kAw+7ppF9qc7cSyEsz9WPjIrO9Mn1PqYAPhQgssaLObtiSzLaNENpO8I+
         fA718YOqei+zM8Zx6IgkAovINEyYEoiUnkkZfjWgNFbSCGVQ9ow0pAAxsrFlrafriee2
         GFnmqFFC2PNsaQ+xx8L2jC+o/19t2rK9TAZlX+K0BudGapqVQY9+BJ+UY8IoSDQ+4Ut8
         M8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQojHDXqff2wnMn35vq6vsn/hS5GJSrbd7DTdIvJ8Po=;
        b=252GMW8/FRQhW+SYxtHme6yAioLB7kwFHbGfb3taJ1tZmQ5es1lpeFTMRVRUHa4O+G
         +s0C4nFS8BMY4DZuGNny/10BKd8GONABE5I0IfBoIQW8xfstiU2a2xyo0Y1kxiY9A+a4
         U89cx4nhbqtTw/LTTBuSBf9MUyiLtZEy+qDH22OUFd/BXkuoVbOPV7RLiFn9r8y3rBme
         oRpXJ/ih3TmJurfK4ubKtAGJvXh+NaIOrihp++ZIdeH2Cgeu5gJqa7v1hRu+agm1LVwY
         ATM+9yk6F19AddWcJt57t/ZZP2U2ygi62y5/+YTzwZ6tpeZUrTmjJokak6btNaINGbjC
         d3kQ==
X-Gm-Message-State: AOAM531MPzSrrE8pVoAQM86rWnfPpbfR8tmGr9PH8rMz1sn/NOFvoIVf
        OmZC1tbdyCmoOOaovbGK9fP24zCWajT+4g==
X-Google-Smtp-Source: ABdhPJxvBeAMEyVVEtozTIXjdp8oAdxDiqVFPcMGyXT4GaGmDyAh+kXFodyEIz7yNSB8+J6Wjt3xrw==
X-Received: by 2002:a5d:6d41:0:b0:1ef:f32c:18ee with SMTP id k1-20020a5d6d41000000b001eff32c18eemr4947801wri.532.1647538055754;
        Thu, 17 Mar 2022 10:27:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm4690693wrw.91.2022.03.17.10.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:27:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] refs: use designated initializers for "struct ref_iterator_vtable"
Date:   Thu, 17 Mar 2022 18:27:16 +0100
Message-Id: <patch-2.5-3f82f24a17d-20220317T171618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/debug.c          |  5 +++--
 refs/files-backend.c  | 12 ++++++------
 refs/iterator.c       | 18 +++++++++---------
 refs/packed-backend.c |  6 +++---
 refs/ref-cache.c      |  6 +++---
 5 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index b03a83258be..b83b5817118 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -220,8 +220,9 @@ static int debug_ref_iterator_abort(struct ref_iterator *ref_iterator)
 }
 
 static struct ref_iterator_vtable debug_ref_iterator_vtable = {
-	debug_ref_iterator_advance, debug_ref_iterator_peel,
-	debug_ref_iterator_abort
+	.advance = debug_ref_iterator_advance,
+	.peel = debug_ref_iterator_peel,
+	.abort = debug_ref_iterator_abort,
 };
 
 static struct ref_iterator *
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f95552f9263..aa4e7182b6e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -822,9 +822,9 @@ static int files_ref_iterator_abort(struct ref_iterator *ref_iterator)
 }
 
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
-	files_ref_iterator_advance,
-	files_ref_iterator_peel,
-	files_ref_iterator_abort
+	.advance = files_ref_iterator_advance,
+	.peel = files_ref_iterator_peel,
+	.abort = files_ref_iterator_abort,
 };
 
 static struct ref_iterator *files_ref_iterator_begin(
@@ -2231,9 +2231,9 @@ static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
 }
 
 static struct ref_iterator_vtable files_reflog_iterator_vtable = {
-	files_reflog_iterator_advance,
-	files_reflog_iterator_peel,
-	files_reflog_iterator_abort
+	.advance = files_reflog_iterator_advance,
+	.peel = files_reflog_iterator_peel,
+	.abort = files_reflog_iterator_abort,
 };
 
 static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
diff --git a/refs/iterator.c b/refs/iterator.c
index a89d132d4fe..b2e56bae1c6 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -64,9 +64,9 @@ static int empty_ref_iterator_abort(struct ref_iterator *ref_iterator)
 }
 
 static struct ref_iterator_vtable empty_ref_iterator_vtable = {
-	empty_ref_iterator_advance,
-	empty_ref_iterator_peel,
-	empty_ref_iterator_abort
+	.advance = empty_ref_iterator_advance,
+	.peel = empty_ref_iterator_peel,
+	.abort = empty_ref_iterator_abort,
 };
 
 struct ref_iterator *empty_ref_iterator_begin(void)
@@ -201,9 +201,9 @@ static int merge_ref_iterator_abort(struct ref_iterator *ref_iterator)
 }
 
 static struct ref_iterator_vtable merge_ref_iterator_vtable = {
-	merge_ref_iterator_advance,
-	merge_ref_iterator_peel,
-	merge_ref_iterator_abort
+	.advance = merge_ref_iterator_advance,
+	.peel = merge_ref_iterator_peel,
+	.abort = merge_ref_iterator_abort,
 };
 
 struct ref_iterator *merge_ref_iterator_begin(
@@ -378,9 +378,9 @@ static int prefix_ref_iterator_abort(struct ref_iterator *ref_iterator)
 }
 
 static struct ref_iterator_vtable prefix_ref_iterator_vtable = {
-	prefix_ref_iterator_advance,
-	prefix_ref_iterator_peel,
-	prefix_ref_iterator_abort
+	.advance = prefix_ref_iterator_advance,
+	.peel = prefix_ref_iterator_peel,
+	.abort = prefix_ref_iterator_abort,
 };
 
 struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 47f01fa5c98..03002451f15 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -911,9 +911,9 @@ static int packed_ref_iterator_abort(struct ref_iterator *ref_iterator)
 }
 
 static struct ref_iterator_vtable packed_ref_iterator_vtable = {
-	packed_ref_iterator_advance,
-	packed_ref_iterator_peel,
-	packed_ref_iterator_abort
+	.advance = packed_ref_iterator_advance,
+	.peel = packed_ref_iterator_peel,
+	.abort = packed_ref_iterator_abort
 };
 
 static struct ref_iterator *packed_ref_iterator_begin(
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index be4aa5e0981..3080ef944d9 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -456,9 +456,9 @@ static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
 }
 
 static struct ref_iterator_vtable cache_ref_iterator_vtable = {
-	cache_ref_iterator_advance,
-	cache_ref_iterator_peel,
-	cache_ref_iterator_abort
+	.advance = cache_ref_iterator_advance,
+	.peel = cache_ref_iterator_peel,
+	.abort = cache_ref_iterator_abort
 };
 
 struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
-- 
2.35.1.1384.g7d2906948a1

