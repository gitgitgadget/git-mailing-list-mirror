Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B35C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13A860238
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhBJXF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbhBJXFH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 18:05:07 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4205FC06178B
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:03:36 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id m144so3504376qke.10
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bWZWcXNZpM6WLECyqkvoC3z8kJQUdP6374TT7TvyY+Q=;
        b=KypbYc5gZDC8jNKdraU2U3g+5b5vm/q0O2XDwpF7HmfAmNPZ+s6l7xlV9LUsUD6AsF
         GGg+1ZCWbPzk+ywvhgwOQGDgcbVBPlqL/FmUHuVEayItDqGQwpZCOwGPs4O+nmNzzbUP
         mXrBSowdsdCkBkEPQ3FVp9sA5J34aOt/3DuYM53mAlxv/gotQbfroR91VAKx22AMYl4N
         ykOZcC5K/QI0JeBbAEXV3SWp6SC9szjVRHCped23utka5UX9OI3tn0ZHPUOs1NtasHND
         OYq9UCjDsdAu+ENs5X8V0DeiGauXFkYtvhcMMYYHDSeKnSZTsbLTBLabyjqpSQIh808f
         Q4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bWZWcXNZpM6WLECyqkvoC3z8kJQUdP6374TT7TvyY+Q=;
        b=UYpMxI9ICnU/t9NEP2VI+7osA8fjAbxNku51T5HcAG/HTCBJXotFDrrzbTE3xsCvcr
         nuFqrJhCqSLl09TEEuSWo26EqYGTkGHMIyug4nvTOfshOIQQbTkIpUp9gCxL1KyTSUtw
         Zme/IYH7k/IQJYw1qi5PV12oYsswy5zjjw589yS7MiAoznvIyzpRjmQkPjhBbjz0mz/Y
         sdONemyhTUj6atK+33tMcrXLDGkAbNTrEID6wV8SwwcLJrtl9RVLugXX8hEF1BG9GHqF
         B7rAUvK0vHXPgQJmXlqfp4/qMKPsNV1kXWy7YHXdPskH5nJ0P+vGL3R+gPhHGjdDkJvW
         0BKg==
X-Gm-Message-State: AOAM531QBQz3/70/jav7jYtbTtgLR/JwAwmuHT4n9eOnp0Rd088EAbkM
        lBcom+5veJyO172CTTyWpXkvf6tHzPWXIYXO
X-Google-Smtp-Source: ABdhPJziHvH1FYenuRhpTXHUtNptO0LJWeBIF0O67wnmIaXUd+/B2Vq6D87Nuxaw+XYzwC21IaHKqw==
X-Received: by 2002:a05:620a:755:: with SMTP id i21mr5755347qki.225.1612998215157;
        Wed, 10 Feb 2021 15:03:35 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id f7sm2539428qkh.45.2021.02.10.15.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:03:34 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:03:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 9/9] pack-revindex: write multi-pack reverse indexes
Message-ID: <fb5954b769004e623e5cd49893b16e6d2adb0a54.1612998106.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement the writing half of multi-pack reverse indexes. This is
nothing more than the format describe a few patches ago, with a new set
of helper functions that will be used to clear out stale .rev files
corresponding to old MIDXs.

Unfortunately, a very similar comparison function as the one implemented
recently in pack-revindex.c is reimplemented here, this time accepting a
MIDX-internal type. An effort to DRY these up would create more
indirection and overhead than is necessary, so it isn't pursued here.

Currently, there are no callers which pass the MIDX_WRITE_REV_INDEX
flag, meaning that this is all dead code. But, that won't be the case
for long, since subsequent patches will introduce the multi-pack bitmap,
which will begin passing this field.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 midx.h |   1 +
 2 files changed, 124 insertions(+)

diff --git a/midx.c b/midx.c
index 12bfce8bb1..3d79a1930a 100644
--- a/midx.c
+++ b/midx.c
@@ -11,6 +11,7 @@
 #include "trace2.h"
 #include "run-command.h"
 #include "repository.h"
+#include "pack.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -841,6 +842,78 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 	return written;
 }
 
+struct midx_pack_order_data {
+	struct pack_midx_entry *entries;
+	uint32_t *pack_perm;
+};
+
+static int midx_pack_order_cmp(const void *va, const void *vb, void *_data)
+{
+	struct midx_pack_order_data *data = _data;
+
+	struct pack_midx_entry *a = &data->entries[*(const uint32_t *)va];
+	struct pack_midx_entry *b = &data->entries[*(const uint32_t *)vb];
+
+	uint32_t perm_a = data->pack_perm[a->pack_int_id];
+	uint32_t perm_b = data->pack_perm[b->pack_int_id];
+
+	/* Sort objects in the preferred pack ahead of any others. */
+	if (a->preferred > b->preferred)
+		return -1;
+	if (a->preferred < b->preferred)
+		return 1;
+
+	/* Then, order objects by which packs they appear in. */
+	if (perm_a < perm_b)
+		return -1;
+	if (perm_a > perm_b)
+		return 1;
+
+	/* Then, disambiguate by their offset within each pack. */
+	if (a->offset < b->offset)
+		return -1;
+	if (a->offset > b->offset)
+		return 1;
+
+	return 0;
+}
+
+static uint32_t *midx_pack_order(struct pack_midx_entry *entries,
+				 uint32_t *pack_perm,
+				 uint32_t entries_nr)
+{
+	struct midx_pack_order_data data;
+	uint32_t *pack_order;
+	uint32_t i;
+
+	data.entries = entries;
+	data.pack_perm = pack_perm;
+
+	ALLOC_ARRAY(pack_order, entries_nr);
+	for (i = 0; i < entries_nr; i++)
+		pack_order[i] = i;
+	QSORT_S(pack_order, entries_nr, midx_pack_order_cmp, &data);
+
+	return pack_order;
+}
+
+static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
+				     uint32_t *pack_order,
+				     uint32_t entries_nr)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
+
+	write_rev_file_order(buf.buf, pack_order, entries_nr, midx_hash,
+			     WRITE_REV);
+
+	strbuf_release(&buf);
+}
+
+static void clear_midx_files_ext(struct repository *r, const char *ext,
+				 unsigned char *keep_hash);
+
 static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
@@ -854,6 +927,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	struct lock_file lk;
 	struct pack_list packs;
 	uint32_t *pack_perm = NULL;
+	uint32_t *pack_order = NULL;
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
@@ -1111,6 +1185,14 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		    chunk_offsets[num_chunks]);
 
 	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	if (flags & MIDX_WRITE_REV_INDEX)
+		pack_order = midx_pack_order(entries, pack_perm, nr_entries);
+
+	if (flags & MIDX_WRITE_REV_INDEX)
+		write_midx_reverse_index(midx_name, midx_hash, pack_order,
+					 nr_entries);
+	clear_midx_files_ext(the_repository, ".rev", midx_hash);
+
 	commit_lock_file(&lk);
 
 cleanup:
@@ -1125,6 +1207,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	free(packs.info);
 	free(entries);
 	free(pack_perm);
+	free(pack_order);
 	free(midx_name);
 	return result;
 }
@@ -1137,6 +1220,44 @@ int write_midx_file(const char *object_dir,
 				   flags);
 }
 
+struct clear_midx_data {
+	char *keep;
+	const char *ext;
+};
+
+static void clear_midx_file_ext(const char *full_path, size_t full_path_len,
+				const char *file_name, void *_data)
+{
+	struct clear_midx_data *data = _data;
+
+	if (!(starts_with(file_name, "multi-pack-index-") &&
+	      ends_with(file_name, data->ext)))
+		return;
+	if (data->keep && !strcmp(data->keep, file_name))
+		return;
+
+	if (unlink(full_path))
+		die_errno(_("failed to remove %s"), full_path);
+}
+
+static void clear_midx_files_ext(struct repository *r, const char *ext,
+				 unsigned char *keep_hash)
+{
+	struct clear_midx_data data;
+	memset(&data, 0, sizeof(struct clear_midx_data));
+
+	if (keep_hash)
+		data.keep = xstrfmt("multi-pack-index-%s%s",
+				    hash_to_hex(keep_hash), ext);
+	data.ext = ext;
+
+	for_each_file_in_pack_dir(r->objects->odb->path,
+				  clear_midx_file_ext,
+				  &data);
+
+	free(data.keep);
+}
+
 void clear_midx_file(struct repository *r)
 {
 	char *midx = get_midx_filename(r->objects->odb->path);
@@ -1149,6 +1270,8 @@ void clear_midx_file(struct repository *r)
 	if (remove_path(midx))
 		die(_("failed to clear multi-pack-index at %s"), midx);
 
+	clear_midx_files_ext(r, ".rev", NULL);
+
 	free(midx);
 }
 
diff --git a/midx.h b/midx.h
index 0a8294d2ee..8684cf0fef 100644
--- a/midx.h
+++ b/midx.h
@@ -40,6 +40,7 @@ struct multi_pack_index {
 };
 
 #define MIDX_PROGRESS     (1 << 0)
+#define MIDX_WRITE_REV_INDEX (1 << 1)
 
 char *get_midx_rev_filename(struct multi_pack_index *m);
 
-- 
2.30.0.667.g81c0cbc6fd
