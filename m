Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C5EC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 411CA61352
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbhI2B5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243696AbhI2B5I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 21:57:08 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1EFC061766
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:25 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id a11so1096687ilk.9
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GVAEaDvJESveSFFWdD9hElxuP8CI9v2+PMwEro7P404=;
        b=HtYDIAkT/qox0aKRxzMmX7588P96IJ6Th9y9AK5cgBaEZ+fHEkut7w28dy391z1YSu
         dFxLKZHuCAI/gID+m6Qdh3Xdu904ZYiUpJ7F84HyrG/xwwkxB4c1hEVTOtxrTc2iwpU/
         ZA7ll7N8ldDPRtEhCYH4kykSnPG9URlfhVqOWjTsHUnB5NExHK+tdMPYq5LS5Zg8HLT5
         6TK+uomO4nFkESC1cjpet+b6hq1ZRrAE/VpqAsFcnY8dNQro+eUPbnj28n5BrsNqq2A7
         V3OyF6jZSpMsxCIG4N1v7eZwNu8rgbfS54SeitlVDSTspFLJGs9WPkT7lCTFlkchMBzs
         ZbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GVAEaDvJESveSFFWdD9hElxuP8CI9v2+PMwEro7P404=;
        b=quME+dtbX6SPfY6/G9nebT3hQsadlEm/8D2BX2jLicUd5t8wwi//Xcsj2TZk5oFmu8
         xLjKd3CfBJSgESQuC5629VPbnQL4bGemtih8gxu309YAcr/yVuSvAbjh3YAeX3mPggG9
         4eLLHPb4LS/nwvGsbx4GnsKwRz++34M/WtUPZkkAHtlvm+tiITTprJeL1TTsd54/55Sv
         k+bQ2e1/xP6zI/4ylqYvZop3UMFycBUoiv2NzjVDje+X0a4kUm4mrG+Y/zEqbheaWgH4
         CSO7CWiqOhGFx2SRfGX+Qpa5RU5wVaOGnAP7BXaOwBmJ3RnuCKFSQCgW4eBhcjlqGi1e
         CWTw==
X-Gm-Message-State: AOAM531uzHyJ0TqP8R4BVvwgAmNWHbGV1Ku99VuQOoePuqXUAnAYvYYw
        sIC5KHYaX/XNOoCVUqsKvc2cJ9A1rmOGlA==
X-Google-Smtp-Source: ABdhPJwIOGwWP4hKbemijyq77uq+LFLNlXYtCxjhqvsbYqhmJqpGJDpKoi3Y6HD+tlZMa1DuzEZOyQ==
X-Received: by 2002:a05:6e02:1e0c:: with SMTP id g12mr6325930ila.155.1632880524451;
        Tue, 28 Sep 2021 18:55:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b14sm504760ilc.63.2021.09.28.18.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 18:55:24 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:55:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, steadmon@google.com
Subject: [PATCH v3 9/9] builtin/repack.c: pass `--refs-snapshot` when writing
 bitmaps
Message-ID: <d99f0753213a8073afbb1213f0e6d082bf3e5195.1632880469.git.me@ttaylorr.com>
References: <cover.1631730270.git.me@ttaylorr.com>
 <cover.1632880469.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1632880469.git.me@ttaylorr.com>
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
index 1577f0d59f..5cc0dff77c 100644
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
@@ -453,6 +455,65 @@ static void clear_pack_geometry(struct pack_geometry *geometry)
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
 				struct string_list *existing_nonkept_packs,
 				struct string_list *existing_kept_packs,
@@ -488,6 +549,7 @@ static void midx_included_packs(struct string_list *include,
 
 static int write_midx_included_packs(struct string_list *include,
 				     struct pack_geometry *geometry,
+				     const char *refs_snapshot,
 				     int show_progress, int write_bitmaps)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -517,6 +579,9 @@ static int write_midx_included_packs(struct string_list *include,
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
 			     pack_basename(largest));
 
+	if (refs_snapshot)
+		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
+
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
@@ -539,6 +604,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
+	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
 	FILE *out;
 	int show_progress = isatty(2);
@@ -627,6 +693,18 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
@@ -809,6 +887,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				    &existing_kept_packs, &names, geometry);
 
 		ret = write_midx_included_packs(&include, geometry,
+						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
 						show_progress, write_bitmaps > 0);
 
 		string_list_clear(&include, 0);
-- 
2.33.0.96.g73915697e6
