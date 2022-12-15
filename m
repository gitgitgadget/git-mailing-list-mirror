Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C55C10F31
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiLOJ70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLOJ7P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:59:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8422BB32
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so1035301wml.4
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7KnLYvbMQBTPvHXxDqa/WX7P/XmY2tzxlMNnKwEudI=;
        b=V5mi+6aLohmx0LzHW3YubhyJ0oB5BgfEQpKybhAi9Zb/WcWQ+saEOkm14+7Bgjzm5Y
         g+ZCZMgTTOVgC9HordNvHoOcZFusGDLdZjDn744OSjRc2Bp+uuLSxT8fQqvgcFEG3Lgw
         mjsSK/J/FI/cKK7KkEY6c1MUgBoRSukxsQ1gP0qJWuWnqHdIxItLWPGITrFIbSlosqhI
         6ndpvR14Oq25iJ7fFh2dmsEeQoFMdacsTWC+92pMGb2JyQtnq0RwcJDqeAGXt+xaEFd0
         f66tvqsAyxZlL6U8/HgPjgr7I5F84uTt7sqF+K5SSRt7vBAEgFtUDyCebQsOwhv2nlj2
         b2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7KnLYvbMQBTPvHXxDqa/WX7P/XmY2tzxlMNnKwEudI=;
        b=1EPJFxLqGxfLbQiac9xNtO3c386dmG94mqSLRdCsLeD14KviHVyVvFqOQlbGe8aWhB
         CVbl22sE22TGRwJjoo8FwzKYOsYzSJfCwBhnALK6lr3WqOtZM11+mMiRDzEf2JrYUhzo
         nm4P4mHejqOHYcVlOUJhXTPc2y0WP8QVtvu550CXjTn/iUNSB5mZASZRTo/DKkMnjaYj
         YKKfN78jGFLrhu5AxY3fS9wsUKY+uOAtIJVbJxMKZtkwRutJ8V+zl2+hO20BM/ldoeBS
         JS47JlhEZG88oGbH7CcMldj6Bjgupr/g5ezdIn+5D/AAQKCjnSVYoH4ZUyXd9DGlOeUI
         8jvA==
X-Gm-Message-State: ANoB5pkVoKHlDlUBw8pTs2SM3ep91YRiiyDdCIgiDd2mAyeAY7wVn0us
        52m8p66hXhfhVTbMSmexOmaOgcMb6+k0LQ==
X-Google-Smtp-Source: AA0mqf6y7VsRcxyfpzokj83I4CbA8fMX4tvBQn2wj/VWIDQbO7eQWiNfHr588VRwX8WziA6Lwx/9Uw==
X-Received: by 2002:a05:600c:5546:b0:3d1:f6b3:2ce3 with SMTP id iz6-20020a05600c554600b003d1f6b32ce3mr28198332wmb.35.1671098351434;
        Thu, 15 Dec 2022 01:59:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b00228cbac7a25sm5495948wrn.64.2022.12.15.01.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:59:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] cocci & cache.h: apply pending "index_cache_pos" rule
Date:   Thu, 15 Dec 2022 10:59:02 +0100
Message-Id: <patch-3.6-2dbe4f45363-20221215T095335Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the rule added in [1] to change "cache_name_pos" to
"index_name_pos", which allows us to get rid of another
"USE_THE_INDEX_COMPATIBILITY_MACROS" macro.

The replacement of "USE_THE_INDEX_COMPATIBILITY_MACROS" here with
"USE_THE_INDEX_VARIABLE" is a manual change on top, now that these
files only use "&the_index", and don't need any compatibility
macros (or functions).

1. 0e6550a2c63 (cocci: add a index-compatibility.pending.cocci,
   2022-11-19)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mv.c                                         | 8 +++++---
 builtin/update-index.c                               | 4 ++--
 cache.h                                              | 1 -
 contrib/coccinelle/index-compatibility.cocci         | 3 +++
 contrib/coccinelle/index-compatibility.pending.cocci | 3 ---
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 19790ce38fa..edd7b931fdb 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2006 Johannes Schindelin
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "pathspec.h"
@@ -489,7 +489,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			if ((mode & SPARSE) &&
 			    path_in_sparse_checkout(dst, &the_index)) {
 				/* from out-of-cone to in-cone */
-				int dst_pos = cache_name_pos(dst, strlen(dst));
+				int dst_pos = index_name_pos(&the_index, dst,
+							     strlen(dst));
 				struct cache_entry *dst_ce = the_index.cache[dst_pos];
 
 				dst_ce->ce_flags &= ~CE_SKIP_WORKTREE;
@@ -500,7 +501,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				   !(mode & SPARSE) &&
 				   !path_in_sparse_checkout(dst, &the_index)) {
 				/* from in-cone to out-of-cone */
-				int dst_pos = cache_name_pos(dst, strlen(dst));
+				int dst_pos = index_name_pos(&the_index, dst,
+							     strlen(dst));
 				struct cache_entry *dst_ce = the_index.cache[dst_pos];
 
 				/*
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 82d5902cc8b..bf38885d546 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "bulk-checkin.h"
 #include "config.h"
@@ -381,7 +381,7 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 	if (has_symlink_leading_path(path, len))
 		return error("'%s' is beyond a symbolic link", path);
 
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(&the_index, path, len);
 	ce = pos < 0 ? NULL : the_index.cache[pos];
 	if (ce && ce_skip_worktree(ce)) {
 		/*
diff --git a/cache.h b/cache.h
index 9de988574e0..4c79e732e45 100644
--- a/cache.h
+++ b/cache.h
@@ -440,7 +440,6 @@ extern struct index_state the_index;
 #ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
 #define read_cache() repo_read_index(the_repository)
 #define discard_cache() discard_index(&the_index)
-#define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
 #endif
 #endif
 #endif
diff --git a/contrib/coccinelle/index-compatibility.cocci b/contrib/coccinelle/index-compatibility.cocci
index 028ff53354a..1d37546fdbd 100644
--- a/contrib/coccinelle/index-compatibility.cocci
+++ b/contrib/coccinelle/index-compatibility.cocci
@@ -91,6 +91,9 @@ identifier ACT = active_cache_tree;
 |
 - resolve_undo_clear
 + resolve_undo_clear_index
+|
+- cache_name_pos
++ index_name_pos
 )
   (
 + &the_index,
diff --git a/contrib/coccinelle/index-compatibility.pending.cocci b/contrib/coccinelle/index-compatibility.pending.cocci
index 01f875d0060..ecf3b45deca 100644
--- a/contrib/coccinelle/index-compatibility.pending.cocci
+++ b/contrib/coccinelle/index-compatibility.pending.cocci
@@ -15,9 +15,6 @@
 (
 - discard_cache
 + discard_index
-|
-- cache_name_pos
-+ index_name_pos
 )
   (
 + &the_index,
-- 
2.39.0.rc2.1048.g0e5493b8d5b

