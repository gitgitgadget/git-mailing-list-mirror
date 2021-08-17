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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF4C43214
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E44D60F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbhHQNYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbhHQNYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:24:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB93C0612AC
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r6so28645434wrt.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oc2wvXngXb26lsP7r8c0mk+JZ8u847riiXPKJWHBYNk=;
        b=oZXViYDK2DFnA/jP4QNO5GkF1hM6PSxqlkplr/LF9F6v2WcXcO+/7q5AhakCRVO4Gf
         kQNCFLBG9/zDBCV3dtBEYBd0Pax9nSmTwmB/xqs4zpPsLAfdsW83Ebj5sOJs3ygmzftJ
         xiGJil02Me7xONDQgdxAAwieLgE080NpW37J+fp3sk+WFiYc1FR4peH+HJ4URP3AFm2v
         T8gdl1YzLq/mPEyTdsKu0BI3u8e3t5Rjnr7Bo/1SexGO+LBzxpVgwC64DfKxswAEoQSg
         nFtWMv0gD3iB8oJKQoiMJUou0gYGDx99awMHusFj3W+XJ+2PjPuTfoZYxEsoxoAyr+oo
         iPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oc2wvXngXb26lsP7r8c0mk+JZ8u847riiXPKJWHBYNk=;
        b=gQArBxBMDkG3hL1HOlLBqsXMImgrYlO7WFWYiFSUunRWLacNT4gXCr3WDPAmqvRtrh
         btoQcK1TcWi9K5n+/7jaSixzHnnMH8QdjWHWu9QH0bh682HdCWrz+ZdsDONEgoThReny
         Ku70JjHIsjPZGZPXA4c0T0362mLq/8oTDaRIi+sLAeRUvE9Aq3+09Q1CND1fLQHegZS7
         6lK+/IC7z04z2u9Dj6RkfGWyWoBOOSLIhLPzOaZfWuE4U45F84886YwusIpw4FVQxzCr
         DMHcuDDGxCPS7lCESfaUXFkNWFIK2bHu+2xBNo0txV7s00xJQJP3ZTMDR9hdoVI2ho7X
         3Psg==
X-Gm-Message-State: AOAM533Q9iUnr1eg2hS80KCdtnGXMHW9UqbwNMU9iYlvJT7tkPkt/pKx
        qsPsiM/hBFxP+PuHLL6jjWK0tHd1nng=
X-Google-Smtp-Source: ABdhPJxwrtWrWSHdS46B0uZvZ5wp3Y8d6bBLFkN0cZhHdaFHJtfY89gnl7ugc8U/PubZozBUrjb3ew==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr4189585wrt.30.1629206608355;
        Tue, 17 Aug 2021 06:23:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm2417392wrw.58.2021.08.17.06.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:23:27 -0700 (PDT)
Message-Id: <10bcadb284e49419f9b4baf75e05f719ec395d98.1629206603.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:23:18 +0000
Subject: [PATCH v3 4/8] unpack-trees: fix nested sparse-dir search
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The iterated search in find_cache_entry() was recently modified to
include a loop that searches backwards for a sparse directory entry that
matches the given traverse_info and name_entry. However, the string
comparison failed to actually concatenate those two strings, so this
failed to find a sparse directory when it was not a top-level directory.

This caused some errors in rare cases where a 'git checkout' spanned a
diff that modified files within the sparse directory entry, but we could
not correctly find the entry.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5786645f315..df1f4437723 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1255,9 +1255,10 @@ static int sparse_dir_matches_path(const struct cache_entry *ce,
 static struct cache_entry *find_cache_entry(struct traverse_info *info,
 					    const struct name_entry *p)
 {
-	struct cache_entry *ce;
+	struct cache_entry *ce = NULL;
 	int pos = find_cache_pos(info, p->path, p->pathlen);
 	struct unpack_trees_options *o = info->data;
+	struct strbuf full_path = STRBUF_INIT;
 
 	if (0 <= pos)
 		return o->src_index->cache[pos];
@@ -1273,6 +1274,10 @@ static struct cache_entry *find_cache_entry(struct traverse_info *info,
 	if (pos < 0 || pos >= o->src_index->cache_nr)
 		return NULL;
 
+	strbuf_addstr(&full_path, info->traverse_path);
+	strbuf_add(&full_path, p->path, p->pathlen);
+	strbuf_addch(&full_path, '/');
+
 	/*
 	 * Due to lexicographic sorting and sparse directory
 	 * entries ending with a trailing slash, our path as a
@@ -1283,17 +1288,20 @@ static struct cache_entry *find_cache_entry(struct traverse_info *info,
 	while (pos >= 0) {
 		ce = o->src_index->cache[pos];
 
-		if (strncmp(ce->name, p->path, p->pathlen))
-			return NULL;
+		if (strncmp(ce->name, full_path.buf, full_path.len)) {
+			ce = NULL;
+			break;
+		}
 
 		if (S_ISSPARSEDIR(ce->ce_mode) &&
 		    sparse_dir_matches_path(ce, info, p))
-			return ce;
+			break;
 
 		pos--;
 	}
 
-	return NULL;
+	strbuf_release(&full_path);
+	return ce;
 }
 
 static void debug_path(struct traverse_info *info)
-- 
gitgitgadget

