Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC4EC432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95F4613AB
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhHXVwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbhHXVwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:52:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A47C061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso2889948wmj.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0n87QV9Z/mw0KmAZmpsOxn8gQVw5CMem+cn2Z07qKf8=;
        b=QBxnBQJlPb/ybEJsZmjxz9b0zFFWHp6l+uJPQ7FaVnlGwKjsDazSR6ARqSlW3UdDHD
         rZhSXmkrUyLI97BBP18BJsEPPO5i06RbPpdwbbHCMdcDKuQlRqezhgOgGEY0PK/sJV6B
         desjPoKyalTbvbudEIgr9YfmQdLdKOLVPgF/vlgzmv62iAbOs2sgCbSnggYNudHFb8WP
         QjDGeNmGeO9JLWqttQOP7JusUOaNGxWdfUAYpUvQMn3/jyIJQfnDCgeqSYN9zYPYMBLs
         P7eiz2p6maWNJB7cN4/hGCYHeaG1UwAQlYgSy8h8SeKQ2NWPuZ02AMy8fV91fMiD6SkB
         0Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0n87QV9Z/mw0KmAZmpsOxn8gQVw5CMem+cn2Z07qKf8=;
        b=Ou1fEtQBD+ucLGtdb7QEQs2zLhidgBL2Ova1uqlP0yelEMcwuwYe8qtnopCd1voMio
         /PQYa1RhPH+Qy5tmDUSPjH3hdkfezR0TD4WXFoNIQr2E+F36yhIbZZRKGM4QWhaaFAN2
         pmNKoCVoh5ZlemwdDI7oWMOjlEBsgr+23wwBuHsI+dc3+BmwQqZuUTmKjt5/3gArRblq
         mO9CIpRKDb6/dQJwQbxD20QgH7cLDbYHlbrLYwuBn2uzaG+HtlcZzkaDYFsyY+0+PRMX
         kVN0K4Fp/J/jmQAjj8XN2SAUvENbxniefy1at29Kha8auZ/pjugSszaOkAJ842ViqyA/
         1Z/w==
X-Gm-Message-State: AOAM5307czGwykxotpWA5JA2BNqtFNthaILKtqSpiZ9X/lRsU6N/omdm
        ihKLRUGLEuBG9lmNaXuvjBokOYNvDEQ=
X-Google-Smtp-Source: ABdhPJxfl9OGCVn1FZg+KKIypyZVqhtbsVcSzTL5t6SzOl5d5fasywL6omGqEokRr+0CwyNcma9K1A==
X-Received: by 2002:a05:600c:354d:: with SMTP id i13mr5973480wmq.89.1629841907618;
        Tue, 24 Aug 2021 14:51:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q22sm3378792wmj.32.2021.08.24.14.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:51:47 -0700 (PDT)
Message-Id: <a669740af9ad7edbc6067644e50a927a284c732d.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
        <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:51:37 +0000
Subject: [PATCH v4 03/10] sparse-index: silently return when cache tree fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If cache_tree_update() returns a non-zero value, then it could not
create the cache tree. This is likely due to a path having a merge
conflict. Since we are already returning early, let's return silently to
avoid making it seem like we failed to write the index at all.

If we remove our dependence on the cache tree within
convert_to_sparse(), then we could still recover from this scenario and
have a sparse index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index cd6e0d5f408..d9b07695953 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -178,10 +178,12 @@ int convert_to_sparse(struct index_state *istate)
 
 	/* Clear and recompute the cache-tree */
 	cache_tree_free(&istate->cache_tree);
-	if (cache_tree_update(istate, 0)) {
-		warning(_("unable to update cache-tree, staying full"));
-		return -1;
-	}
+	/*
+	 * Silently return if there is a problem with the cache tree update,
+	 * which might just be due to a conflict state in some entry.
+	 */
+	if (cache_tree_update(istate, 0))
+		return 0;
 
 	remove_fsmonitor(istate);
 
-- 
gitgitgadget

