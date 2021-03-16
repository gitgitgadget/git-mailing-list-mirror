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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBFDC432C3
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD16664FA5
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhCPVSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbhCPVRi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DFAC0613DB
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x13so8168355wrs.9
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bFOrvSw80zbNP+4EnPIiQiVg9EM0jRAPgsEPYaxvRlQ=;
        b=NQhz+jMVUW7XyJOaSafcoaKrQtaRyIPxaRc37NM91J8vKoE2QPDN2iAAg5t/6rY9yy
         qu1EmKYcy9eZDPX4ci7XXamXaFfdsMh/7g/wb5u1sX156HJa2UOxJwrYGEbx5TioGv0n
         9Eq5ub5tSyP8Nlh6yehfJA+IkpukVyvLxYi1I0opgn5KeiUhneT1U0GeJ2XwINJgxFro
         fbZGlthVOoqTAmWwHXMdCBhNFDHz8lTviYeA/a+nwRhFGR1NEt0RD159beFxnwLWLMCV
         ahisUexjSopCsa8QdKEvOqcGVD1Exuko3c6M4hmBTRM4zq299+gz0d3yx+YVub4RXzJx
         eEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bFOrvSw80zbNP+4EnPIiQiVg9EM0jRAPgsEPYaxvRlQ=;
        b=ZlZiP8FxRHsAcpIGzzsvz7s9kfDNAfZ7Z3H5pU6ogsu2Vww5rC5YVm9YZyah7OmAh1
         tPrORJ6SJy7TvUpA85eaIYTtOxiM9asuhGT+LROuz5+sWb/3XPNGz/4PrW1G51upi2VW
         ySKU4CrVC14bkmGqr9YzL+8qQobYWjvEfnkrdLjv+NZtfYAzAbQ1Jn3pXeiebubQ+U7w
         87sBCA2ICpnEy5cl4VC2KSLLVOmwR+s/OQEfxtRB0USVW5HUG2hyJHeTafNPPGta7u0P
         fjPYpDBdUzAFzJVQjnaLIjoagsKc6gfo4bwzUYrYi8C1cPHJMuXb5jsuPlS47Rw0ZlHr
         Uypw==
X-Gm-Message-State: AOAM533xlbFRZBmB+CcY0lLlNIV89TrZPQuSEp2CiMUewdZqXPOfSrvI
        EH8lir+qttx1TF6CJYY6uXquJNA/Nco=
X-Google-Smtp-Source: ABdhPJzTyzcromlvDLywDZYIRit50BENBIvMVNAMd4xUlgrX7+ILtT5ywj+R7ZD+42O9nuccJS5deg==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr954783wrq.136.1615929454613;
        Tue, 16 Mar 2021 14:17:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm24394480wrg.80.2021.03.16.14.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:34 -0700 (PDT)
Message-Id: <40cfc59f695a6069277d4744a12c9f607e9aa35f.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:15 +0000
Subject: [PATCH 27/27] name-hash: use expand_to_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A sparse-index loads the name-hash data for its entries, including the
sparse-directory entries. If a caller asks for a path that is contained
within a sparse-directory entry, we need to expand to a full index and
recalculate the name hash table before returning the result. Insert
calls to expand_to_path() to protect against this case.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 name-hash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/name-hash.c b/name-hash.c
index 4e03fac9bb12..75c159e06eeb 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "thread-utils.h"
 #include "trace2.h"
+#include "sparse-index.h"
 
 struct dir_entry {
 	struct hashmap_entry ent;
@@ -109,6 +110,12 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	if (ce->ce_flags & CE_HASHED)
 		return;
 	ce->ce_flags |= CE_HASHED;
+
+	if (S_ISSPARSEDIR(ce->ce_mode)) {
+		add_dir_entry(istate, ce);
+		return;
+	}
+
 	hashmap_entry_init(&ce->ent, memihash(ce->name, ce_namelen(ce)));
 	hashmap_add(&istate->name_hash, &ce->ent);
 
@@ -680,6 +687,7 @@ int index_dir_exists(struct index_state *istate, const char *name, int namelen)
 	struct dir_entry *dir;
 
 	lazy_init_name_hash(istate);
+	expand_to_path(istate, name, namelen, 0);
 	dir = find_dir_entry(istate, name, namelen);
 	return dir && dir->nr;
 }
@@ -690,6 +698,7 @@ void adjust_dirname_case(struct index_state *istate, char *name)
 	const char *ptr = startPtr;
 
 	lazy_init_name_hash(istate);
+	expand_to_path(istate, name, strlen(name), 0);
 	while (*ptr) {
 		while (*ptr && *ptr != '/')
 			ptr++;
@@ -713,6 +722,7 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
 	unsigned int hash = memihash(name, namelen);
 
 	lazy_init_name_hash(istate);
+	expand_to_path(istate, name, namelen, icase);
 
 	ce = hashmap_get_entry_from_hash(&istate->name_hash, hash, NULL,
 					 struct cache_entry, ent);
-- 
gitgitgadget
