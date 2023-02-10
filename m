Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90951C636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 10:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjBJK3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 05:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjBJK24 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 05:28:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081A642BE6
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o18so4597908wrj.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+lIjCE3jh7jHy0hXF4Z5ItT3qtfTITHLgxTi4d9C4Y=;
        b=OT/jBWazUf99yq8E1JmRDQa4js7deR64tcf13rg8/uBhSnWgTUIrKglqoLs5WGR0lH
         B8MRe3cYD65So7ip/cdK+Q5BuT6yTKA6uH/XWe+ZzUHPal5qOpfVyb8gok18VAS3s+la
         pQDdRxO1kDMXOqgRoz7LR4YfR5gqOTd/khdTUXhOZOSFbEp0kasCEwZJAJiYAmUfXSYW
         xHkGmUKht3vR5pTiQItTn932e2Y5qN/N3PkZySUPr44retmuRHDM/G6j9YjKWhse7cnW
         bwowtCm07pZ1gxVFhtDZRUR4YGKHht0ugzEl5Nk9TvJdZmCSbzfJ2IGCpjeQI9jDWhlw
         oZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+lIjCE3jh7jHy0hXF4Z5ItT3qtfTITHLgxTi4d9C4Y=;
        b=fUy5dJO8cdqTpPdkNLwy4ydy/29DTVKw7JEKga0AkwcHqVJ9x/ms0gdOzVpF5F71G8
         xC5WnZ0ArDJTsNix9KhEiLWe2JpIYhSVLpRRHe+UAU3zDisRQGxV2mJlVQsK1bdjfJDc
         yprtYcdxILbP++gk+dodOk+he2/nPWNLk/08eykKLW7qbSqUxN+X4L8jO9lXRiBZjwfg
         PziWe3hvoMthTZatKwuXNwD9FDs31pA99JFsCCauC9UrCekXks8yY+sbzhS6mcVbz3Rw
         jY4u9YGWdbl7BIxUuFaOqASPvLWeD5VZzKBBQSVoCDrNlDF3A3dH6/Bc2bJK1ZEV11JV
         IBBw==
X-Gm-Message-State: AO0yUKU1IqWlh8YLQwnOZBL6scdxwICMtL2SwP86aeeoidll4rglaO7w
        xC4Xt4XdhzRVozCv8smsxSIjA7KS4ihdLH4R
X-Google-Smtp-Source: AK7set8Pe2114/4h2hD/lGE2rJLfSp20cUWeivkUzRlzHiwW8lEz1/3Mm1L+fZi+XmyQSKOCn3QGDw==
X-Received: by 2002:adf:d0c2:0:b0:2bb:f88b:43b6 with SMTP id z2-20020adfd0c2000000b002bbf88b43b6mr15007019wrh.3.1676024932133;
        Fri, 10 Feb 2023 02:28:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002c3f50228afsm3244792wrt.3.2023.02.10.02.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:28:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] cocci & cache.h: apply pending "index_cache_pos" rule
Date:   Fri, 10 Feb 2023 11:28:36 +0100
Message-Id: <patch-v2-3.6-3e9d97dbff2-20230210T102114Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
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
index b0bbecf35ef..c44aef1af7c 100644
--- a/cache.h
+++ b/cache.h
@@ -456,7 +456,6 @@ extern struct index_state the_index;
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
2.39.1.1475.gc2542cdc5ef

