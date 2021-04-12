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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46222C43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297E961369
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbhDLVJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240409AbhDLVIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C026C061344
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s7so14202920wru.6
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ikt/CHZ3vNbn9OBWK+EZ28ZSXcACALejndYwRFSQIwY=;
        b=IM9TN1pZF2wykmVwxFpRRaPLNIqais2Ys9ZQbf/oKFA831IpgxZX8aWYEbVw3hBi5h
         bLzt67NULIOq/5yzW+iQb6Y86qyCUed1EL+PYdi31pzxjKWmpRDMW2Tq2J3/b2ttj7S/
         WEOf5F8AJVKQfd2prne/kx5xLqXhnojRzB6VVf7brVXy6boRLUDUuOPHXKUbglHb8BCN
         74YFDQCQRp6Xj5xSUz8Brd+dSYpPBK1kfnaiHtG8v1VJKYrBRXgjpBKPtKUtyERafjUU
         9dDZi2/54hCM0ugJehcQ2vTbdhvc9Z49AzUxVOs/LHlTszwrlmbaMz2/bpMa5r7kUW8W
         KkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ikt/CHZ3vNbn9OBWK+EZ28ZSXcACALejndYwRFSQIwY=;
        b=fZOHNeSFYip3niwulzFOGZ2DiyJhE5bYZpO+jNTBGZ9W6WLclOiSMBMB+g6X159zEO
         FB6pk0Dtg65DzE7+MOyHSWn6wyuHBknFt7lYU2DrzJFvikIfDDta4VjLQuBUcjCQcnQZ
         QVbog3xFwJi3KDZQWbQSBbbEDKR+yQUfOLQv0R8C1I5JgWWmn+Dvsb7BKkVZXYJQWQDr
         +ImI6oigYcO1dFIrneVbmR9Q5gAdpM705dLLxs21cxA6qcjEN/4KGeX0KyDMQi3Tfx78
         FhgjFDdJ+qs+H5/3HGvT6zbue6AJTJhR/mSQliEKOed7X2o5AZAPCXbJtASQgzjtF4R2
         d1dA==
X-Gm-Message-State: AOAM530buU9x10pQico8Sptk/1hs51R8y7eyO5QX/B3yvDmP342XeW3X
        TXdUFfmaDe3YIqId1XDK96QEpdIz5LU=
X-Google-Smtp-Source: ABdhPJxUpXkvO6Uf+ohpuvnAvJjjhjtScYlB+2rJoNlRp1KsmyisUaLvUOrGSAqZBUfWpvh5Lk1rqQ==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr8944837wro.52.1618261714281;
        Mon, 12 Apr 2021 14:08:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm18194089wrt.15.2021.04.12.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:34 -0700 (PDT)
Message-Id: <5fd83dcf2747dddc04a1386b7e57a48d3d9aa49b.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:15 +0000
Subject: [PATCH v3 24/26] name-hash: don't add directories to name_hash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Sparse directory entries represent a directory that is outside the
sparse-checkout definition. These are not paths to blobs, so should not
be added to the name_hash table. Instead, they should be added to the
directory hashtable when 'ignore_case' is true.

Add a condition to avoid placing sparse directories into the name_hash
hashtable. This avoids filling the table with extra entries that will
never be queried.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 name-hash.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 4e03fac9bb12..d08deaa2c9e7 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -109,8 +109,11 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	if (ce->ce_flags & CE_HASHED)
 		return;
 	ce->ce_flags |= CE_HASHED;
-	hashmap_entry_init(&ce->ent, memihash(ce->name, ce_namelen(ce)));
-	hashmap_add(&istate->name_hash, &ce->ent);
+
+	if (!S_ISSPARSEDIR(ce->ce_mode)) {
+		hashmap_entry_init(&ce->ent, memihash(ce->name, ce_namelen(ce)));
+		hashmap_add(&istate->name_hash, &ce->ent);
+	}
 
 	if (ignore_case)
 		add_dir_entry(istate, ce);
-- 
gitgitgadget

