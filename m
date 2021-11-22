Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD3FC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhKVWgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhKVWgP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:36:15 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8DFC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:33:08 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id c6-20020aa781c6000000b004a4fcdf1d6dso768086pfn.4
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1ZBnoYlNLuCrJ0s5Z5CcSRYjFcGti2Z5TgzLzFmgVgc=;
        b=qXMDmhkt4yic+NhpJ3pIsauRi3kCpDeiZmpboEwUYDaEh6MiX6D5rXqUm7l+lZFS0X
         mNnLwTPLmwxmD8KO76H1L4c6EW9V0uvUk5YQiEaXrIwg+jFMl0HiITWaE3FZCWdqz/pG
         axwImTMavMQTbGp+SNYRDJTs7ULT6hLyBJC9y6GlrCwYC29wPB4p72VXT4RcwP6NFd59
         Kt3Q+fo4NCMfoss4/lzIbB02cqoBcsrg+NQtoXu1rchjGwaW+E9IB0M8NtVu+KcgnkLU
         nVVnFnwYR/fD8sfgdM0YIy1EHADJKsHoQnrMQZFiLQVMHpcOrVVA6IyFKfZifolS7MWd
         Bygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1ZBnoYlNLuCrJ0s5Z5CcSRYjFcGti2Z5TgzLzFmgVgc=;
        b=wT87roo8xNmlNdfhVDd+idxWZBYbHdKbUu3qqtCLYgH3jOCOALUqCwzidM1vM+Agru
         MLyG7+NlAw3FoximGZfLHMkiGc1D/LgjxchpdoUWvZLooeFeJbviT7k0b8Ni7kNjXfVD
         GnWpyDulPN9wsPdBuBRxanEY5V6sN8zJztbukPCpqSdOexZ80hh/SUL5JaBp1kFe97bf
         Nbfgkcg3+cv0vJYKTBsSDCWnQ4AeCcfY2sqgiA7DuKTCC0uRaxRLW37mzaZt917iZGfk
         d+3IRZQ+QXV3baheaOiabh+1PEYLpfI0GFy/gWZXGl8gcPpLSJFqOLYHxDd0PvNEGHV7
         iubA==
X-Gm-Message-State: AOAM531vdsonf9V//0/BCH+xYZKXOR7Ymv/YyhCeBFSmKmYuo8ayRygp
        1T3YUn1TODwCGcz46k4vSZfxfyUA79uLa89VmXgmu8xs1KT9Zj/3nNs1gR9WxyDBDGvlWqruRK1
        4XNwHvvb6xCNMb17v/fx2Zs1W9SP/pjxKyxy8ABdKpKNETAsAXq6F3W52GZqlewk=
X-Google-Smtp-Source: ABdhPJw3GAa1batCefvGDLELn9PpHIE0BXTneofHJtkdx5mTZ+65CeH/P09IzvrPnh/BMwEBxuy/c14Ctwu7kA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:cf85:: with SMTP id
 i5mr37422449pju.101.1637620387566; Mon, 22 Nov 2021 14:33:07 -0800 (PST)
Date:   Mon, 22 Nov 2021 14:32:49 -0800
In-Reply-To: <20211122223252.19922-1-chooglen@google.com>
Message-Id: <20211122223252.19922-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 1/4] submodule-config: add submodules_of_tree() helper
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we introduce a submodule UX with branches, we would like to be able
to get the submodule commit ids in a superproject tree because those ids
are the source of truth e.g. "git branch --recurse-submodules topic
start-point" should create branches based off the commit ids recorded in
the superproject's 'start-point' tree.

To make this easy, introduce a submodules_of_tree() helper function that
iterates through a tree and returns the tree's gitlink entries as a
list.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule-config.c | 19 +++++++++++++++++++
 submodule-config.h | 13 +++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index f95344028b..97da373301 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "object-store.h"
 #include "parse-options.h"
+#include "tree-walk.h"
 
 /*
  * submodule cache lookup structure
@@ -726,6 +727,24 @@ const struct submodule *submodule_from_path(struct repository *r,
 	return config_from(r->submodule_cache, treeish_name, path, lookup_path);
 }
 
+struct submodule_entry_list *
+submodules_of_tree(struct repository *r, const struct object_id *treeish_name)
+{
+	struct tree_desc tree;
+	struct name_entry entry;
+	struct submodule_entry_list *ret;
+
+	CALLOC_ARRAY(ret, 1);
+	fill_tree_descriptor(r, &tree, treeish_name);
+	while (tree_entry(&tree, &entry)) {
+		if (!S_ISGITLINK(entry.mode))
+			continue;
+		ALLOC_GROW(ret->name_entries, ret->entry_nr + 1, ret->entry_alloc);
+		ret->name_entries[ret->entry_nr++] = entry;
+	}
+	return ret;
+}
+
 void submodule_free(struct repository *r)
 {
 	if (r->submodule_cache)
diff --git a/submodule-config.h b/submodule-config.h
index 65875b94ea..4379ec77e3 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -6,6 +6,7 @@
 #include "hashmap.h"
 #include "submodule.h"
 #include "strbuf.h"
+#include "tree-walk.h"
 
 /**
  * The submodule config cache API allows to read submodule
@@ -67,6 +68,18 @@ const struct submodule *submodule_from_name(struct repository *r,
 					    const struct object_id *commit_or_tree,
 					    const char *name);
 
+struct submodule_entry_list {
+	struct name_entry *name_entries;
+	int entry_nr;
+	int entry_alloc;
+};
+
+/**
+ * Given a tree-ish, return all submodules in the tree.
+ */
+struct submodule_entry_list *
+submodules_of_tree(struct repository *r, const struct object_id *treeish_name);
+
 /**
  * Given a tree-ish in the superproject and a path, return the submodule that
  * is bound at the path in the named tree.
-- 
2.33.GIT

