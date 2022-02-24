Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA93C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiBXJdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiBXJdo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EC326A38F
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n25-20020a05600c3b9900b00380f41e51e6so867532wms.2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmnvB3gaV/Ou55qHhxKFLyDaJAjlx6xcpXsC6pu196A=;
        b=VOAB27897nvZnw1mH63Trdf1Yzjeb88qJB51i3xh+xiJTiw1edptBeRAAETSJPNIaZ
         ABwlGcUnNWQAueN/wRokDtM2j8Dkn/oEoLAoyAr+WDU7LG/SWQ6u7pv3g6G1hQFYiK1a
         c0UsuJKAeY5DKtpMlfVqlzjVMDX6cKfNazL7Y/mjyP+VcoGylXS2cYhVVMHoON5VLh4z
         nCbD7if9mCFTzlSjBDrnZirzbV1XNwQifePR0t3Vm1zWmKgNGYUYwfS50d+tD+GCaoiQ
         Cl+GRSXjc21Rwvy68U1Nblx2H6gl2E5QjNyacbYZqjXjxqp0ICZ0XMD2dWgra5QQYvR6
         gcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmnvB3gaV/Ou55qHhxKFLyDaJAjlx6xcpXsC6pu196A=;
        b=2tan/q9Mrd/lKzm+JA8n4I7olbteeT+yMOBJ3guCruFV+NoWeuajSuBx9373C2Js0q
         dIrII08NIgLDF5g2PJdBwL+fCSeGjyJXmE0qkwh4QFOuqp0o9y5X5Olx5gCJgYa9eTqN
         HBlHCOXnWRkCb8f1JQVwhU0SF2Wp/flUeYsBENauJ8x5JAgCoumIDTpyOHymlBNNxpZu
         mZFirFQCwaEBPwoW8K++P/Up3Yvoujxf/qAvsDsotV5X5FP24OpMq2cSqCjXvyk8RsdE
         sSt709S5tgARMViHAmaflTH2ExWywoLrGhEO2pBPBKMsqfPLxu6D6XQOZBiT9oQV5sWS
         yTMw==
X-Gm-Message-State: AOAM531gzJVCuFAsOVFFk2LpaYMg/PjQHYsuAuYQSdE/QL7vF54pYwAu
        sLOUL/PSR4jXNuEA8gpucKhgJQiFcreqLA==
X-Google-Smtp-Source: ABdhPJyGUkPv0r0dU+rl4nvVNE6dY+1/4mxK1KVwuOEpfkXEyg28/JyhI3Mk3Tyzv1u0xNFNg4W8PQ==
X-Received: by 2002:a7b:c932:0:b0:381:c66:fff2 with SMTP id h18-20020a7bc932000000b003810c66fff2mr2092906wml.42.1645695192598;
        Thu, 24 Feb 2022 01:33:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/12] refs: use designated initializers for "struct ref_storage_be"
Date:   Thu, 24 Feb 2022 10:32:57 +0100
Message-Id: <patch-02.12-167d4bfdd82-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the definition of the three refs backends we currently carry to
use designated initializers.

The "= NULL" assignments being retained here are redundant, and could
be removed, but let's keep them for clarity. All of these backends
define almost all fields, so we're not saving much in terms of line
count by omitting these, but e.g. for "refs_be_debug" it's immediately
apparent that we're omitting "init" when comparing its assignment to
the others.

This is a follow-up to similar work merged in bd4232fac33 (Merge
branch 'ab/struct-init', 2021-07-16), a4b9fb6a5cf (Merge branch
'ab/designated-initializers-more', 2021-10-18) and a30321b9eae (Merge
branch 'ab/designated-initializers' into
ab/designated-initializers-more, 2021-09-27).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/debug.c          | 50 +++++++++++++++++++++----------------------
 refs/files-backend.c  | 50 +++++++++++++++++++++----------------------
 refs/packed-backend.c | 50 +++++++++++++++++++++----------------------
 3 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 2b0771ca53b..c8b52d43a79 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -418,29 +418,29 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 }
 
 struct ref_storage_be refs_be_debug = {
-	NULL,
-	"debug",
-	NULL,
-	debug_init_db,
-	debug_transaction_prepare,
-	debug_transaction_finish,
-	debug_transaction_abort,
-	debug_initial_transaction_commit,
-
-	debug_pack_refs,
-	debug_create_symref,
-	debug_delete_refs,
-	debug_rename_ref,
-	debug_copy_ref,
-
-	debug_ref_iterator_begin,
-	debug_read_raw_ref,
-
-	debug_reflog_iterator_begin,
-	debug_for_each_reflog_ent,
-	debug_for_each_reflog_ent_reverse,
-	debug_reflog_exists,
-	debug_create_reflog,
-	debug_delete_reflog,
-	debug_reflog_expire,
+	.next = NULL,
+	.name = "debug",
+	.init = NULL,
+	.init_db = debug_init_db,
+	.transaction_prepare = debug_transaction_prepare,
+	.transaction_finish = debug_transaction_finish,
+	.transaction_abort = debug_transaction_abort,
+	.initial_transaction_commit = debug_initial_transaction_commit,
+
+	.pack_refs = debug_pack_refs,
+	.create_symref = debug_create_symref,
+	.delete_refs = debug_delete_refs,
+	.rename_ref = debug_rename_ref,
+	.copy_ref = debug_copy_ref,
+
+	.iterator_begin = debug_ref_iterator_begin,
+	.read_raw_ref = debug_read_raw_ref,
+
+	.reflog_iterator_begin = debug_reflog_iterator_begin,
+	.for_each_reflog_ent = debug_for_each_reflog_ent,
+	.for_each_reflog_ent_reverse = debug_for_each_reflog_ent_reverse,
+	.reflog_exists = debug_reflog_exists,
+	.create_reflog = debug_create_reflog,
+	.delete_reflog = debug_delete_reflog,
+	.reflog_expire = debug_reflog_expire,
 };
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f59589d6cce..efc942958ef 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3269,29 +3269,29 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 }
 
 struct ref_storage_be refs_be_files = {
-	NULL,
-	"files",
-	files_ref_store_create,
-	files_init_db,
-	files_transaction_prepare,
-	files_transaction_finish,
-	files_transaction_abort,
-	files_initial_transaction_commit,
-
-	files_pack_refs,
-	files_create_symref,
-	files_delete_refs,
-	files_rename_ref,
-	files_copy_ref,
-
-	files_ref_iterator_begin,
-	files_read_raw_ref,
-
-	files_reflog_iterator_begin,
-	files_for_each_reflog_ent,
-	files_for_each_reflog_ent_reverse,
-	files_reflog_exists,
-	files_create_reflog,
-	files_delete_reflog,
-	files_reflog_expire
+	.next = NULL,
+	.name = "files",
+	.init = files_ref_store_create,
+	.init_db = files_init_db,
+	.transaction_prepare = files_transaction_prepare,
+	.transaction_finish = files_transaction_finish,
+	.transaction_abort = files_transaction_abort,
+	.initial_transaction_commit = files_initial_transaction_commit,
+
+	.pack_refs = files_pack_refs,
+	.create_symref = files_create_symref,
+	.delete_refs = files_delete_refs,
+	.rename_ref = files_rename_ref,
+	.copy_ref = files_copy_ref,
+
+	.iterator_begin = files_ref_iterator_begin,
+	.read_raw_ref = files_read_raw_ref,
+
+	.reflog_iterator_begin = files_reflog_iterator_begin,
+	.for_each_reflog_ent = files_for_each_reflog_ent,
+	.for_each_reflog_ent_reverse = files_for_each_reflog_ent_reverse,
+	.reflog_exists = files_reflog_exists,
+	.create_reflog = files_create_reflog,
+	.delete_reflog = files_delete_reflog,
+	.reflog_expire = files_reflog_expire
 };
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 27dd8c3922b..ba75c28f1bf 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1667,29 +1667,29 @@ static int packed_reflog_expire(struct ref_store *ref_store,
 }
 
 struct ref_storage_be refs_be_packed = {
-	NULL,
-	"packed",
-	packed_ref_store_create,
-	packed_init_db,
-	packed_transaction_prepare,
-	packed_transaction_finish,
-	packed_transaction_abort,
-	packed_initial_transaction_commit,
-
-	packed_pack_refs,
-	packed_create_symref,
-	packed_delete_refs,
-	packed_rename_ref,
-	packed_copy_ref,
-
-	packed_ref_iterator_begin,
-	packed_read_raw_ref,
-
-	packed_reflog_iterator_begin,
-	packed_for_each_reflog_ent,
-	packed_for_each_reflog_ent_reverse,
-	packed_reflog_exists,
-	packed_create_reflog,
-	packed_delete_reflog,
-	packed_reflog_expire
+	.next = NULL,
+	.name = "packed",
+	.init = packed_ref_store_create,
+	.init_db = packed_init_db,
+	.transaction_prepare = packed_transaction_prepare,
+	.transaction_finish = packed_transaction_finish,
+	.transaction_abort = packed_transaction_abort,
+	.initial_transaction_commit = packed_initial_transaction_commit,
+
+	.pack_refs = packed_pack_refs,
+	.create_symref = packed_create_symref,
+	.delete_refs = packed_delete_refs,
+	.rename_ref = packed_rename_ref,
+	.copy_ref = packed_copy_ref,
+
+	.iterator_begin = packed_ref_iterator_begin,
+	.read_raw_ref = packed_read_raw_ref,
+
+	.reflog_iterator_begin = packed_reflog_iterator_begin,
+	.for_each_reflog_ent = packed_for_each_reflog_ent,
+	.for_each_reflog_ent_reverse = packed_for_each_reflog_ent_reverse,
+	.reflog_exists = packed_reflog_exists,
+	.create_reflog = packed_create_reflog,
+	.delete_reflog = packed_delete_reflog,
+	.reflog_expire = packed_reflog_expire
 };
-- 
2.35.1.1157.g524e2d5a0db

