Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EA1C433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECF560E97
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhIOS0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhIOS0P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:26:15 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28834C0613DF
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:54 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id q14so3968044ils.5
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6xwjchNRgIQLNEGxiUt7uOQyyc8FuRfUSK3gmWPQRy0=;
        b=kcV8wN1HOBKKgRhfQ0aduHPpWszVBvcwatAtAn9ZlpxinqRkyoZ6qsVzW/0vTwJXir
         U+SEPYmnCA+jq2N6PWHiZrLtQRjHqAmLf5TdtiCT1HJ1tO/gqsZFPN5dglXu6NCIfNy7
         wigQBPdiVT/jZt4vGyGU9yIOHJKBoVakZ3o4Q751ZcmegdAFhPmLbTdW9uUoETbswz2n
         l5gwBVgclUQpN0R0GjaA3kxLT9Sc2gjdw/2bftAdpqxeX5C7r8ISSvD+hXrCeCd+SuPD
         yUqJNBRvlg1Ejh+TxoOlMTx8AKMCmG9OQ2rNhVpsfv1afPTkiJvLR3ePjd8yxqWjXswZ
         BAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6xwjchNRgIQLNEGxiUt7uOQyyc8FuRfUSK3gmWPQRy0=;
        b=X7L5DU79Bg1ZA02STzlgz3adBNJSRbQabTzDZkzWs8EkIBC9hy/xYaEvodKe7Md/8T
         gRqT+eeTT1d2vnG44IADZnSWPfTOZ0R9UH3R4eQAzOAm0isBfxCSTo3n1VoH9Qb00ed6
         0ywnQZHgnE7l2SB9ZVlNm/eEsJbkI4ptqVxiMkub3GQd77KdrWmkVFq0H9SQDoOOfkLO
         28GtzynBEYZ+QfmG5L0jyofyNRWA+geovD+xgU5EEOtr3RCcPDEM2TF+eaUk9YZgrNsR
         c6O9jQ3ij6aZhsU4LHRa0zl2aS3lzKZsBAWSbQlOCNENApqFQkY+4xvgiaXxMEjF34nV
         qOig==
X-Gm-Message-State: AOAM532whkt3MtomUC3OJaixn7PjJzTJUaMQ5CThCEG3wVTwphVxPOEt
        W1erO7GtFJyniW40B+3TC9G1F2wLeezCr2UD
X-Google-Smtp-Source: ABdhPJz57lhNf3dlY9AA8GR7UHCc5N0/k5dxqCSAOEQ9DsTrMZXBbgfGNzd0x6REjzDLRZQXQjM0yw==
X-Received: by 2002:a92:3642:: with SMTP id d2mr1086585ilf.234.1631730293390;
        Wed, 15 Sep 2021 11:24:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s7sm337836ioc.42.2021.09.15.11.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:24:53 -0700 (PDT)
Date:   Wed, 15 Sep 2021 14:24:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 8/8] builtin/repack.c: pass `--refs-snapshot` when writing
 bitmaps
Message-ID: <eb24b308ecdbd7736fc63927130540abd0a668db.1631730270.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631730270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prevent the race described in an earlier patch, generate and pass a
reference snapshot to the multi-pack bitmap code, if we are writing one
from `git repack`.

This patch is mostly limited to creating a temporary file, and then
calling for_each_ref(). Except we try to minimize duplicates, since
doing so can drastically reduce the size in network-of-forks style
repositories. In the kernel's fork network (the repository containing
all objects from the kernel and all its forks), deduplicating the
references drops the snapshot size from 934 MB to just 12 MB.

But since we're handling duplicates in this way, we have to make sure
that we preferred references (those listed in pack.preferBitmapTips)
before non-preferred ones (to avoid recording an object which is pointed
at by a preferred tip as non-preferred).

We accomplish this by doing separate passes over the references: first
visiting each prefix in pack.preferBitmapTips, and then over the rest of
the references.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 8c7bc4551e..a0b515b139 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -15,6 +15,8 @@
 #include "promisor-remote.h"
 #include "shallow.h"
 #include "pack.h"
+#include "pack-bitmap.h"
+#include "refs.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -452,6 +454,65 @@ static void clear_pack_geometry(struct pack_geometry *geometry)
 	geometry->split = 0;
 }
 
+struct midx_snapshot_ref_data {
+	struct tempfile *f;
+	struct oidset seen;
+	int preferred;
+};
+
+static int midx_snapshot_ref_one(const char *refname,
+				 const struct object_id *oid,
+				 int flag, void *_data)
+{
+	struct midx_snapshot_ref_data *data = _data;
+	struct object_id peeled;
+
+	if (!peel_iterated_oid(oid, &peeled))
+		oid = &peeled;
+
+	if (oidset_insert(&data->seen, oid))
+		return 0; /* already seen */
+
+	if (oid_object_info(the_repository, oid, NULL) != OBJ_COMMIT)
+		return 0;
+
+	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
+		oid_to_hex(oid));
+
+	return 0;
+}
+
+static void midx_snapshot_refs(struct tempfile *f)
+{
+	struct midx_snapshot_ref_data data;
+	const struct string_list *preferred = bitmap_preferred_tips(the_repository);
+
+	data.f = f;
+	oidset_init(&data.seen, 0);
+
+	if (!fdopen_tempfile(f, "w"))
+		 die(_("could not open tempfile %s for writing"),
+		     get_tempfile_path(f));
+
+	if (preferred) {
+		struct string_list_item *item;
+
+		data.preferred = 1;
+		for_each_string_list_item(item, preferred)
+			for_each_ref_in(item->string, midx_snapshot_ref_one, &data);
+		data.preferred = 0;
+	}
+
+	for_each_ref(midx_snapshot_ref_one, &data);
+
+	if (close_tempfile_gently(f)) {
+		int save_errno = errno;
+		delete_tempfile(&f);
+		errno = save_errno;
+		die_errno(_("could not close refs snapshot tempfile"));
+	}
+}
+
 static void midx_included_packs(struct string_list *include,
 				struct string_list *existing_packs,
 				struct string_list *existing_kept_packs,
@@ -487,6 +548,7 @@ static void midx_included_packs(struct string_list *include,
 
 static int write_midx_included_packs(struct string_list *include,
 				     struct pack_geometry *geometry,
+				     const char *refs_snapshot,
 				     int show_progress, int write_bitmaps)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -513,6 +575,9 @@ static int write_midx_included_packs(struct string_list *include,
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
 			     pack_basename(largest));
 
+	if (refs_snapshot)
+		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
+
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
@@ -535,6 +600,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
+	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
 	FILE *out;
 	int show_progress = isatty(2);
@@ -623,6 +689,18 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));
 
+	if (write_midx && write_bitmaps) {
+		struct strbuf path = STRBUF_INIT;
+
+		strbuf_addf(&path, "%s/%s_XXXXXX", get_object_directory(),
+			    "bitmap-ref-tips");
+
+		refs_snapshot = xmks_tempfile(path.buf);
+		midx_snapshot_refs(refs_snapshot);
+
+		strbuf_release(&path);
+	}
+
 	if (geometric_factor) {
 		if (pack_everything)
 			die(_("--geometric is incompatible with -A, -a"));
@@ -799,6 +877,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				    &existing_kept_packs, &names, geometry);
 
 		ret = write_midx_included_packs(&include, geometry,
+						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
 						show_progress, write_bitmaps > 0);
 
 		string_list_clear(&include, 0);
-- 
2.33.0.96.g73915697e6
