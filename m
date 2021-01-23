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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E5FC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3098222DBF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhAWUAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 15:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbhAWT7o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:59:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D27C061794
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p15so1723367wrq.8
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3LC/1eestJjR+EOcwKHsjfdOZknum6kvDyZ7fg9I1AA=;
        b=gHakX2qOFeghf0gXhOSzQvUSZCVKsOnoX0xwdstX5fif3FDAcKrtkTCP/a9LKw7RuK
         YncpV3gI267Fuhjnod4+OxXRk05Hky9l+8/zYzbw7KtwV6Ry10/ITvBbZ1FkKtzsX5AL
         r6R9cqZxk77nY4zZwzmxbTunGBnpgVMzTptHUz59mfZXVjQyVmkqop2q1ELeojdRD4Cx
         AFd+LeCKI/VnwJvZTKg+/wmQVLRbMAsQ6lnGkF0/OithL+uJMyuVRfEBZXzy7RA1nI6v
         p5XDOxbaZakkZlW+Ba8IFI56A6asaYmCbkFj4pPqmNlyWweoddCN+Pw6OB8/1NNQ7LMr
         LtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3LC/1eestJjR+EOcwKHsjfdOZknum6kvDyZ7fg9I1AA=;
        b=O0lHR19913jtF/N9qy/5Ll5XoExNKLqLUFa6wZdSz7v/814eLxfb1lmU9/v+NxWwCD
         /u059yMSBX+u00J83VZPBcyMpFsJFDcoFXyypT5WNeNPaVPSXMLNppmsjx67xh/9igYq
         3rQXh1e3oQZLHpAbkNy/iySuW4JzzpvajSXVQrUxw6IGRoIziAzuf0M4rHcQVzeIZ5gI
         rA3yBG9JtpE9KkCBobSD0m1C3yXKV+qaR+Zr3Ij5+m+W+iumtpZk1lDSqW3Xiwz+j7dM
         wh4uNR60QW5kTPjoYmgXbKUVRLvhyTz+w/HMsYayveSSbq0Xrk7lYqLEFSPxjGL9+f1w
         JPmQ==
X-Gm-Message-State: AOAM5300gy9euRg29KHymciQ7YrlsIJ/lD56UXVbUscj2PKUzCJfe4zd
        /X3wchoQO8ikTN1xJq8sGtW+KFWfDhg=
X-Google-Smtp-Source: ABdhPJw0JDSnsdYmAsVHi4J2f0FGLlensBwkejldPLxpD21eKBz8edpd85rXp2Mf6B4ZZQe5NjCo0g==
X-Received: by 2002:a5d:53c3:: with SMTP id a3mr226869wrw.43.1611431906280;
        Sat, 23 Jan 2021 11:58:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm15625221wmc.31.2021.01.23.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 11:58:25 -0800 (PST)
Message-Id: <9b545d7dbecc6f071e58787e9d4339f59ac4e972.1611431900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 19:58:16 +0000
Subject: [PATCH v3 6/9] name-hash: use trace2 regions for init
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The lazy_init_name_hash() populates a hashset with all filenames and
another with all directories represented in the index. This is run only
if we need to use the hashsets to check for existence or case-folding
renames.

Place trace2 regions where there is already a performance trace.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 name-hash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/name-hash.c b/name-hash.c
index 5d3c7b12c18..4e03fac9bb1 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "thread-utils.h"
+#include "trace2.h"
 
 struct dir_entry {
 	struct hashmap_entry ent;
@@ -577,6 +578,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 	if (istate->name_hash_initialized)
 		return;
 	trace_performance_enter();
+	trace2_region_enter("index", "name-hash-init", istate->repo);
 	hashmap_init(&istate->name_hash, cache_entry_cmp, NULL, istate->cache_nr);
 	hashmap_init(&istate->dir_hash, dir_entry_cmp, NULL, istate->cache_nr);
 
@@ -597,6 +599,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 	}
 
 	istate->name_hash_initialized = 1;
+	trace2_region_leave("index", "name-hash-init", istate->repo);
 	trace_performance_leave("initialize name hash");
 }
 
-- 
gitgitgadget

