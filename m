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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A597C433E6
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B7E21D79
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbhADDKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbhADDKE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 22:10:04 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B94EC061794
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 19:09:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r3so30802417wrt.2
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 19:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Dkys2TZsvFsYLc4Nzw+wTJ/OAwTXIQdwI+QSCleLVFI=;
        b=AIDyyjehKyUFz49rbRybNkA85pZQLtfkZT8QpiRURqVDsMe9TUcbgGdbRmJ+BjRxXU
         56buZ9bJm2IrPGPEVCa/oUEGlVf20WL63FXP0lL5Y0FEUQ0isv/HLBCkqWAimQ42nFop
         zZu/Js/1TanBL1R+/zerYkcjsQA7fEDlLXXVYRb2M7sGCK5gv1O4KjxsAu4W1nkmk6mk
         B0it24XPhvcrPoWpFkSQsKwomi6dk3+HWVx0l4UoEMAbdkfiXznvXTuHlxGnGYX4/djM
         2Ncbped0fwS446V3Dlu2kKr53lb2g90ynlzPIkzZGe9C3jbXXxH23pVk1/3eACQ62WCX
         DH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Dkys2TZsvFsYLc4Nzw+wTJ/OAwTXIQdwI+QSCleLVFI=;
        b=RSyAti2Ap8giBkRozbweEdupWTMJ0JaVY0jW6e7fi9jB93E79fRey0GzEaUsBLhKqd
         RASNz3sSwVm5gmM3CqaMiW6/wqPAatK+85C4WyBthJmFPfQ/kJz+TobcmdhHQOTz/69f
         NGtsqlPRUA7yK6Yw9x3yt7wha/PgDi5caQigml4dtN76nuD1Hle6C4HcpDSeVdwyiPiu
         E1Eskx/It+UyVFaYtAJEOLVPwtZSOLZUjLxwxZ3iiiM9OvIdFq+qFdVq/fnA5noennsq
         krgPohgDK28IiWm3/7k3Fic4cgkT9MDOHTvSCKF2hSlYoPGJY+uxlV19jcGQn6tjvswH
         VuNg==
X-Gm-Message-State: AOAM533QJ0QkHLP8iNRz0G3brl+jHPkC9VtlNmAWzofWZ0CzE+FM0nJg
        Olm/BT8Nz4q3BEgtZzd+18TT8nFTnyg=
X-Google-Smtp-Source: ABdhPJyTphoVVvGeBPM57vfQ5/fvUTJCpR02AaKhjLY0WNvcfLwW8WJDjQ8dDiMua5X19Kh3MHTWKQ==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr79351701wrx.170.1609729761259;
        Sun, 03 Jan 2021 19:09:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 67sm33107739wmb.47.2021.01.03.19.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 19:09:20 -0800 (PST)
Message-Id: <0e500c86f397987c4d03beac52b1e91f683e4d11.1609729758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jan 2021 03:09:10 +0000
Subject: [PATCH v2 1/9] tree-walk: report recursion counts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The traverse_trees() method recursively walks through trees, but also
prunes the tree-walk based on a callback. Some callers, such as
unpack_trees(), are quite complicated and can have wildly different
performance between two different commands.

Create constants that count these values and then report the results at
the end of a process. These counts are cumulative across multiple "root"
instances of traverse_trees(), but they provide reproducible values for
demonstrating improvements to the pruning algorithm when possible.

This change is modeled after a similar statistics reporting in 42e50e78
(revision.c: add trace2 stats around Bloom filter usage, 2020-04-06).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 tree-walk.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tree-walk.c b/tree-walk.c
index 0160294712b..2d6226d5f18 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -4,6 +4,7 @@
 #include "object-store.h"
 #include "tree.h"
 #include "pathspec.h"
+#include "json-writer.h"
 
 static const char *get_mode(const char *str, unsigned int *modep)
 {
@@ -167,6 +168,25 @@ int tree_entry_gently(struct tree_desc *desc, struct name_entry *entry)
 	return 1;
 }
 
+static int traverse_trees_atexit_registered;
+static int traverse_trees_count;
+static int traverse_trees_cur_depth;
+static int traverse_trees_max_depth;
+
+static void trace2_traverse_trees_statistics_atexit(void)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "traverse_trees_count", traverse_trees_count);
+	jw_object_intmax(&jw, "traverse_trees_max_depth", traverse_trees_max_depth);
+	jw_end(&jw);
+
+	trace2_data_json("traverse_trees", the_repository, "statistics", &jw);
+
+	jw_release(&jw);
+}
+
 void setup_traverse_info(struct traverse_info *info, const char *base)
 {
 	size_t pathlen = strlen(base);
@@ -180,6 +200,11 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
 	info->namelen = pathlen;
 	if (pathlen)
 		info->prev = &dummy;
+
+	if (trace2_is_enabled() && !traverse_trees_atexit_registered) {
+		atexit(trace2_traverse_trees_statistics_atexit);
+		traverse_trees_atexit_registered = 1;
+	}
 }
 
 char *make_traverse_path(char *path, size_t pathlen,
@@ -416,6 +441,12 @@ int traverse_trees(struct index_state *istate,
 	int interesting = 1;
 	char *traverse_path;
 
+	traverse_trees_count++;
+	traverse_trees_cur_depth++;
+
+	if (traverse_trees_cur_depth > traverse_trees_max_depth)
+		traverse_trees_max_depth = traverse_trees_cur_depth;
+
 	if (n >= ARRAY_SIZE(entry))
 		BUG("traverse_trees() called with too many trees (%d)", n);
 
@@ -515,6 +546,8 @@ int traverse_trees(struct index_state *istate,
 	free(traverse_path);
 	info->traverse_path = NULL;
 	strbuf_release(&base);
+
+	traverse_trees_cur_depth--;
 	return error;
 }
 
-- 
gitgitgadget

