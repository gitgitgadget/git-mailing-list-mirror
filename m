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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22987C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2DC23AAA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbhAHUE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbhAHUEX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:04:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60ABC0612A6
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 190so8745123wmz.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+37K2Cpfk5xUV/APXn1+LZ0XFNT5/nJxATiZzmdqwwA=;
        b=KbOcdrOkeBc9iiklD66EMYLDvecmI6HH/Eo+TjSe+IHBIywGmj8zLVBuw9NsGnPIW+
         8yHOa+IDQQRVIP6Gqum0ni32+dBRnNc+54VJQo+XvA1AchLMkQTyZAB0SnToVdj8ySjr
         n7WB5DUnX53ec3y+6XTJ+Iclatg7wPgFI4C5Kzouz/mjo2PvD2bUL46vCwpRlHNUktB5
         Dx9/q3ge03uk4Icw5ZBbY0i/ctgPTEB7sCNZuB8cGEthqanJsKRn69kFkQac9Mv1/ZbV
         gcFCRsTnZAbXJ8faNsxOgsz4EH0ZCuSAiTOKLoHDB2cvOjCdDq4rkUhZ0kD3R6v7gLo3
         cJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+37K2Cpfk5xUV/APXn1+LZ0XFNT5/nJxATiZzmdqwwA=;
        b=ML/Fx6LdTC9wVq6/fQprqEyUQbTYb1tqhxThbRwaa2/MlwUiVXbe8RU/K226YWH/S6
         yixrO9vbPZimjUKQ7IzJ7OKafvLLI38sdYbY6k9KZAvCZeXvoy5CYPbe5mYmjdsG0DZ1
         1Ku6lrkuVzL7nevZ0sT9SstR4UttJdemCxpK4YzFYCCXlOSvzUh7sr6yrD6JAbnX4Okm
         ug99YC1U7UsBdKn48pO3RgeK6a4kILwRsjr+FXS6ZQvheV/F8El8zDfooRrQmqxAFz7W
         eEQ6NbwIapXyOrMSDODwGvYV6luhLRUCVcUst7yU1O6twWUrvqyl6KHfsgy1lM6lwIiL
         FVhA==
X-Gm-Message-State: AOAM533IuDKHL9c47wNbyycVit09IL5+gBCMcp2L4t7I55njWG89yFAD
        3Fy6fqii43dpY/obj9BzZOJQcJBdANU=
X-Google-Smtp-Source: ABdhPJwhwxdLitNqWGxiJhnO7U6y5LSn5QjP4lE8O+wJ4tvF/8QQguheBt7APrftjTB+EI3pbeNA2A==
X-Received: by 2002:a1c:e342:: with SMTP id a63mr4606471wmh.64.1610136188541;
        Fri, 08 Jan 2021 12:03:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm14475033wre.24.2021.01.08.12.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:08 -0800 (PST)
Message-Id: <efe9fddd0a9a44d6fb04eeb01d2868fe7829f2f6.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:53 +0000
Subject: [PATCH v3 10/14] update-index: replace several compatibility macros
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
index a1e4ee89056..64feb47c97f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -429,7 +429,7 @@ static void chmod_path(char flip, const char *path)
 	if (pos < 0)
 		goto fail;
 	ce = istate->cache[pos];
-	if (chmod_cache_entry(ce, flip) < 0)
+	if (chmod_index_entry(istate, ce, flip) < 0)
 		goto fail;
 
 	report("chmod %cx '%s'", flip, path);
@@ -626,7 +626,7 @@ static int unresolve_one(const char *path)
 	pos = index_name_pos(repo->index, path, namelen);
 	if (0 <= pos) {
 		/* already merged */
-		pos = unmerge_cache_entry_at(pos);
+		pos = unmerge_index_entry_at(repo->index, pos);
 		if (pos < repo->index->cache_nr) {
 			const struct cache_entry *ce = repo->index->cache[pos];
 			if (ce_stage(ce) &&
@@ -777,8 +777,9 @@ struct refresh_params {
 static int refresh(struct refresh_params *o, unsigned int flag)
 {
 	setup_work_tree();
-	read_cache();
-	*o->has_errors |= refresh_cache(o->flags | flag);
+	repo_read_index(repo);
+	*o->has_errors |= refresh_index(repo->index, o->flags | flag,
+					NULL, NULL, NULL);
 	return 0;
 }
 
@@ -814,7 +815,7 @@ static int resolve_undo_clear_callback(const struct option *opt,
 {
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	resolve_undo_clear();
+	resolve_undo_clear_index(repo->index);
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

