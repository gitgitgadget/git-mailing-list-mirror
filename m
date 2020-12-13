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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA67FC4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9565B22D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393200AbgLMIGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393505AbgLMIF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:59 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71FC0611C5
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:43 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w206so7089762wma.0
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B1g5reDOKhODNLyOrVGW7c/8Vk5Z0+9AlFs/EoWvjWo=;
        b=PL3yMOf2ifGpMlPf2e8xkLH9V30UMyRI+1I+X2Z+lnN3L9ngGuQbfyLh339s2cKsm2
         YcMPSNUoihtzTL0Kqzvq7BptIy8WFgHX6D7bKSqRCcvXec5p8k2AdGwEKVBfiqkguToJ
         7thcLUUKogwzEgF9yrJ4jUgEvcpv489dW+8RcnjncNhrca7xXTqmTB2UE5U+WwSfV4/+
         kKqUPnkve6Rxunc8lWu27O6GclDwvza+ypv0XRPxotgNMv5uOcDS/3IcXeSTBxrcE57v
         7htPVLMFUB5uyktZ4uSD0fJc4pzEYfvXCLH+aotvWJ6yV2H1By+haTuwICqTwy3n3Fjo
         FJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B1g5reDOKhODNLyOrVGW7c/8Vk5Z0+9AlFs/EoWvjWo=;
        b=ffiFh0s4xIRzFmTJZ0RkpPrNoImfOySCxWVgugmTO1UE1ZRrxKhgJocZQk6mQOcORW
         gASqi02mfgIbh4w3igB0L+AaIWqT4LjIFUB38pPaX0iJZ65/P4psiWvJNS87GOPYAZYF
         X+yRWFHhJthhskDeIuybqrR3XaGKR0bVAa3L0ZUcKxutX8+F/CnVbiSiJ5sKNviDFhoo
         UpQLhFVRFd+1jimTHX70vTpGT+jGN6WKDgXD1r5COdBZyjrObpw4Vw5zLTTgpx1pL0EM
         Nujt/UpPAgXhCBmOZ2HNxUSdukKs0rHAFnmfBRqhM0KWpjc9dGp2iXDgvruK8wePXPSL
         1zMQ==
X-Gm-Message-State: AOAM530lT73tNR0kJC2Y9OPi9JpWQtfZwP8mqfHwy5Ug9o/kYwluWo/b
        TF3q7girUoiiZKCYEl+KiYdAJEXfOzY=
X-Google-Smtp-Source: ABdhPJwgpT4HgBpzMntuDp3VmgzwCE13PEMi9QLD2BmrHMRrWIC63I0VUGb0LiRDX0jwWsTfk0m1yg==
X-Received: by 2002:a1c:3902:: with SMTP id g2mr21770126wma.117.1607846681381;
        Sun, 13 Dec 2020 00:04:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm24589397wmf.19.2020.12.13.00.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:40 -0800 (PST)
Message-Id: <b5d9ba10f8c83b744516d54fbbdf40552dd5b7b6.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:21 +0000
Subject: [PATCH v3 14/20] merge-ort: step 2 of tree writing -- function to
 create tree object
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Create a new function, write_tree(), which will take a list of
basenames, modes, and oids for a single directory and create a tree
object in the object-store.  We do not yet have just basenames, modes,
and oids for just a single directory (we have a mixture of entries from
all directory levels in the hierarchy) so we still die() before the
current call to write_tree(), but the next patch will rectify that.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 95369c6a052..f7041cfeac4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -19,6 +19,7 @@
 
 #include "diff.h"
 #include "diffcore.h"
+#include "object-store.h"
 #include "strmap.h"
 #include "tree.h"
 #include "xdiff-interface.h"
@@ -523,6 +524,62 @@ struct directory_versions {
 	struct string_list versions;
 };
 
+static int tree_entry_order(const void *a_, const void *b_)
+{
+	const struct string_list_item *a = a_;
+	const struct string_list_item *b = b_;
+
+	const struct merged_info *ami = a->util;
+	const struct merged_info *bmi = b->util;
+	return base_name_compare(a->string, strlen(a->string), ami->result.mode,
+				 b->string, strlen(b->string), bmi->result.mode);
+}
+
+static void write_tree(struct object_id *result_oid,
+		       struct string_list *versions,
+		       unsigned int offset,
+		       size_t hash_size)
+{
+	size_t maxlen = 0, extra;
+	unsigned int nr = versions->nr - offset;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list relevant_entries = STRING_LIST_INIT_NODUP;
+	int i;
+
+	/*
+	 * We want to sort the last (versions->nr-offset) entries in versions.
+	 * Do so by abusing the string_list API a bit: make another string_list
+	 * that contains just those entries and then sort them.
+	 *
+	 * We won't use relevant_entries again and will let it just pop off the
+	 * stack, so there won't be allocation worries or anything.
+	 */
+	relevant_entries.items = versions->items + offset;
+	relevant_entries.nr = versions->nr - offset;
+	QSORT(relevant_entries.items, relevant_entries.nr, tree_entry_order);
+
+	/* Pre-allocate some space in buf */
+	extra = hash_size + 8; /* 8: 6 for mode, 1 for space, 1 for NUL char */
+	for (i = 0; i < nr; i++) {
+		maxlen += strlen(versions->items[offset+i].string) + extra;
+	}
+	strbuf_grow(&buf, maxlen);
+
+	/* Write each entry out to buf */
+	for (i = 0; i < nr; i++) {
+		struct merged_info *mi = versions->items[offset+i].util;
+		struct version_info *ri = &mi->result;
+		strbuf_addf(&buf, "%o %s%c",
+			    ri->mode,
+			    versions->items[offset+i].string, '\0');
+		strbuf_add(&buf, ri->oid.hash, hash_size);
+	}
+
+	/* Write this object file out, and record in result_oid */
+	write_object_file(buf.buf, buf.len, tree_type, result_oid);
+	strbuf_release(&buf);
+}
+
 static void record_entry_for_tree(struct directory_versions *dir_metadata,
 				  const char *path,
 				  struct merged_info *mi)
@@ -675,9 +732,17 @@ static void process_entries(struct merge_options *opt,
 		}
 	}
 
+	/*
+	 * TODO: We can't actually write a tree yet, because dir_metadata just
+	 * contains all basenames of all files throughout the tree with their
+	 * mode and hash.  Not only is that a nonsensical tree, it will have
+	 * lots of duplicates for paths such as "Makefile" or ".gitignore".
+	 */
+	die("Not yet implemented; need to process subtrees separately");
+	write_tree(result_oid, &dir_metadata.versions, 0,
+		   opt->repo->hash_algo->rawsz);
 	string_list_clear(&plist, 0);
 	string_list_clear(&dir_metadata.versions, 0);
-	die("Tree creation not yet implemented");
 }
 
 void merge_switch_to_result(struct merge_options *opt,
-- 
gitgitgadget

