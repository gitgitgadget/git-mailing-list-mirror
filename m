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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C349DC001B6
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943A761078
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhDABuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhDABuU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E364C061761
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j7so201978wrd.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bFOrvSw80zbNP+4EnPIiQiVg9EM0jRAPgsEPYaxvRlQ=;
        b=FP+Mco7594b0830RaXxZ1dqFnuwCahjLdeohrN6gehTBsqj6IBCIgauzywtmXdcAZN
         MH/FhMLoHbqTnjTQdmteq5lm+mOrbN73DwwkjRSUynuzlCZOL67uv5RmYd2MoAe+wfLD
         ECeYlLWeYmETA41n5+xacaN5q2Orlf5N7m/6gGvef/MZgAoPlb3rksjJ9e4SEMVb+b9q
         Dbim86OcoYWG9dJ+0w6pKnoUK8EZilhKYXfrjPeypuvKnQBO2ygAju3ici4JNQDErNzl
         akoeYxdDTOPw8lTnRHpDeuOmNAprg49FwCHdCDBSgmmZ8MFq9rCOOFnk6fpaHldolQ4N
         WBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bFOrvSw80zbNP+4EnPIiQiVg9EM0jRAPgsEPYaxvRlQ=;
        b=iPR77zyvJLKvYudJdfA1kmTTFcupl/O7F6H+tFslWNmOydVAI42JDB1cS4ipDo1OI/
         vegL2nZBWpJY5GHRK9brO2UfelC6ipwGT9X42WKA9eM9LjgI54DbOCSnhxuhJYNw/X95
         R/U6gwSS7iSTn6YSDl/0WmiC8UQIaG8zXjyNAjs04uw/0Nhyx86ck2ECjOBXD6QFmqeT
         4P/7OJM8kCt9xykd+kL2Hg6utzYgNfjzlNyNkMQ03Xzd+HQt79vH/ctyBQr9Pr6qKBbE
         C2eSAEBCJLjPSoMtUGVu8uHGbo7N8hlVXwNzz6gWoBC7eTWGBczFHbxbJtC9XQ9dCbje
         nW/Q==
X-Gm-Message-State: AOAM531CM7DIwLdWKuWWmNi6J18r0rQOJmtImn+yPL0hlX8fcUuJIenX
        wAHGW4A9VTQfgiVll/IhY+eZV6GeXfQ=
X-Google-Smtp-Source: ABdhPJz4I5xTeM8r3FjKk2P8UR0MNY0c/KEQgcu+AaMPtBVMwAtIC7fjJ8yvXf6tjyXfZOsDGWKEMA==
X-Received: by 2002:adf:f150:: with SMTP id y16mr6629576wro.414.1617241818313;
        Wed, 31 Mar 2021 18:50:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm7090652wrt.82.2021.03.31.18.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:18 -0700 (PDT)
Message-Id: <7e2d3fae9a2a0574d2f881d0bcd4931a2cad6b45.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:50:02 +0000
Subject: [PATCH v2 25/25] name-hash: use expand_to_path()
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
