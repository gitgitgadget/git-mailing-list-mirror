Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10173C433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiBXJdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiBXJdp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:45 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B87E26A393
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s13so1992766wrb.6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LVSmfKmY6dZzH6JptXA5AlcKafUbL1JfutkADMO47DE=;
        b=YjzdxsfGefXjIPKqxKOxcJ2PwYu1kxrDWXD0fZH3BTp6SBHsOKNejaAOuqX/U3mAAW
         lg/n6mnMgXA1FUaF7q1dVDw6lV4ytIlUB8ijwkLqpKEYLjqLAu0Rf4T030v+ZDLfq97C
         /O0/MDbZs9CMNpmHI0GRHli9+IFNaAbY2TpjsyNBwnTABTnF98JgD9qynfv9Vt3ajcaX
         0ugJbdO0J5xXvG3ldwFAzMEy/Q0ZjwO9/pj9e2eWOMF/9CJn/FT4woyeM6chuqJ8pP4A
         K0U+JcRs5rZkoldyZyZojgHoznSy9wu2bfJgYbtX7HAcdgXql4+uX4Mg7kz02kaN01b6
         znVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LVSmfKmY6dZzH6JptXA5AlcKafUbL1JfutkADMO47DE=;
        b=k6n93EU9w20Fd7CJSOD1pEahyYnc1gh1zU1/YQcQNWTcffmVXTIbqSqMS9Zjib+j9K
         LLkUT2WUhUM3oJZHacCS3Yh8q+lbP15W12q2dQmFYWjdyAO/+ATncVwdoB1DKqHpz3kB
         cvULLj9QArzziHMktLiAeNNO4sYHBT3pVebkclBsqCJuWknsPyYm/eO4e2D7cBok4zs7
         T+eS/ci2XG2tZ/NEqwXX32oFTdwSalX/i22tpZftiSJO4/vtXoA+ZMPfXjQ3THgNakPK
         n/HCBGDJcibQPs5SaqGFurd64roYYYS+I+kofXoaEglO7enMHVAgmP4oBDhWedUvpQYg
         Nq6A==
X-Gm-Message-State: AOAM532MHQJ7JLl0BY4gFfk8/sZ/bq60HywzICPsjWuC2tkdqxionau1
        Ax3meOo+u2JXvjUi3h1kx8NxdBZjlbbtBA==
X-Google-Smtp-Source: ABdhPJxxyzoJ1fGSes1V+LBAOZvEeZKSK5+PEkdFL8nMaIL91q7npovt6VAFrZ9AYubck5m/nPXZOg==
X-Received: by 2002:a5d:4390:0:b0:1e4:9b88:23df with SMTP id i16-20020a5d4390000000b001e49b8823dfmr1416250wrq.335.1645695193478;
        Thu, 24 Feb 2022 01:33:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/12] refs: use designated initializers for "struct ref_iterator_vtable"
Date:   Thu, 24 Feb 2022 10:32:58 +0100
Message-Id: <patch-03.12-6693c689936-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
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
index c8b52d43a79..c647a20abbd 100644
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
index efc942958ef..3159be5a37a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -800,9 +800,9 @@ static int files_ref_iterator_abort(struct ref_iterator *ref_iterator)
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
@@ -2209,9 +2209,9 @@ static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
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
index ba75c28f1bf..1406cb959c1 100644
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
2.35.1.1157.g524e2d5a0db

