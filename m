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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3C0C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5CD227BF
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbhAEEob (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbhAEEoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:44:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F181AC0617A3
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t16so34886764wra.3
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mqPr3/fTsc9D2oFthYhDZfW9JiRllFSqavVMmAN0O0I=;
        b=gyfry2w8YuutpiWXLC9U+k9sAGcRKJV45IKJRB6t678T73HSYLRHQxnd19rBiMMxKI
         oEDjA2blL4zgOsEl/q0G6FRhRbssS80lhV0MInJiQ7bjitfqj8Ql9hZcQREmS7m9N1Ja
         Vssx/j7Yh0JeaMbIuvwRcWBol3IMv15SvJUKM316M74HlSj3y8jH7519MwZ9eXufZ/+/
         KKfXc1kHvhuvSRVlk00ioY39nSgc+QukyYsdjQQx+InZt/0yHNVT/kcsHPop7XovmfMi
         f9Bw99sy/WiUz5/3WUZWFsdifYBEPAnoRuA+ca4iw4SlT/fFk5e32UxUzKVuojenmDTe
         m6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mqPr3/fTsc9D2oFthYhDZfW9JiRllFSqavVMmAN0O0I=;
        b=cGIsB65dWG6pryNOiJ5zNlbvB9WwX4tvQebLQUD1ycB9yVHAUk7i6t642Rd18G3zXZ
         RhOyj26f2b9UsCgHj8luNEM9k6mCU5g8U7wZpYjJa7CRThWVEFnlc03u0haHX0FDgMlo
         WZsVQciqMDBU3tNOy4+vStXD6rETWwRESuTuQp5Z/SBB0Qo/uw7RmZSoB5ta0NqoTTox
         ZjTtc1J5poX3vzj9hBfXwehb44EZMDxIF3/E5V8/DdBzs+6hb0npczMkdCdBilvuAuAN
         tKLq75tTtBuBvUy+zCxlSRRGO8EClCjZLhWUYKIcDYtTJm+4ZDwTQPOXbK26w2AzmX8b
         LqHw==
X-Gm-Message-State: AOAM533f0JcdZ9xNQkKpAOl8k7ZTF21qSzz45Zodx5zt+iJfD/jUxzLs
        vHramkTZ7BgEFyoDPkl/rRKXvDyQTwQ=
X-Google-Smtp-Source: ABdhPJxNvNq8CHwCk8PKZvguI6Vyfnb2JURfo1wWUzUjZlSBVeviF1MSNxb3BmyjTuj3QT8FGW6XSQ==
X-Received: by 2002:adf:dd09:: with SMTP id a9mr82061887wrm.90.1609821793589;
        Mon, 04 Jan 2021 20:43:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h83sm2443498wmf.9.2021.01.04.20.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:13 -0800 (PST)
Message-Id: <68b26a11d779e225566f8581f4afcd514ef1cd70.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:42:59 +0000
Subject: [PATCH v2 10/14] update-index: replace several compatibility macros
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This is also the last usage of unmerge_cache_entry_at(), so it can be
removed from cache.h.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 11 ++++++-----
 cache.h                |  1 -
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ffa42813370..dd8e0acc52e 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -430,7 +430,7 @@ static void chmod_path(char flip, const char *path)
 	if (pos < 0)
 		goto fail;
 	ce = istate->cache[pos];
-	if (chmod_cache_entry(ce, flip) < 0)
+	if (chmod_index_entry(istate, ce, flip) < 0)
 		goto fail;
 
 	report("chmod %cx '%s'", flip, path);
@@ -626,7 +626,7 @@ static int unresolve_one(const char *path)
 	pos = index_name_pos(istate, path, namelen);
 	if (0 <= pos) {
 		/* already merged */
-		pos = unmerge_cache_entry_at(pos);
+		pos = unmerge_index_entry_at(istate, pos);
 		if (pos < istate->cache_nr) {
 			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_stage(ce) &&
@@ -777,8 +777,9 @@ struct refresh_params {
 static int refresh(struct refresh_params *o, unsigned int flag)
 {
 	setup_work_tree();
-	read_cache();
-	*o->has_errors |= refresh_cache(o->flags | flag);
+	repo_read_index(repo);
+	*o->has_errors |= refresh_index(istate, o->flags | flag,
+					NULL, NULL, NULL);
 	return 0;
 }
 
@@ -814,7 +815,7 @@ static int resolve_undo_clear_callback(const struct option *opt,
 {
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	resolve_undo_clear();
+	resolve_undo_clear_index(istate);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index fdf061cac56..8c091be6256 100644
--- a/cache.h
+++ b/cache.h
@@ -421,7 +421,6 @@ extern struct index_state the_index;
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
-#define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
 #define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
-- 
gitgitgadget

