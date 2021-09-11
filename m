Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8D6C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD0860F46
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhIKDeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 23:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhIKDeD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 23:34:03 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C9AC061757
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:51 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a15so4897375iot.2
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uu0wawx66RaM8zpuLmxh0zsTeM4voy7ay4UAsO8S7Qc=;
        b=YbcJOOriB3AmsIGja9CMPfXP/H7AIkxkyT+qGUC7slIQUG4X2PJT24WyQJDvoEPXaE
         iGUxCzqujHyXLI8ZQBjSuukefXl2NoG2t9utKfl9ks/MCGorWfNFP8rwY4Qkv3/5d1X0
         DiablMT2wVVxrHc12ob5qGhHJ3S8wzALhF7t0TDaaAOGFyZSQkO642i7Sj/naxSdpwJg
         WEQB699Y+LXt7PA2rMvn6sM20bdg9n+KL0gYHYIDdGNz0MC5oAszcmUiMFHEBTNorWZz
         6rZ4pq31QTPuVVX69JwHRLLO4Rwzy8b/Sedunmhat7FmeP90ALXUKYJ0g66NqIFnSUVP
         dv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uu0wawx66RaM8zpuLmxh0zsTeM4voy7ay4UAsO8S7Qc=;
        b=Q/2fAK2W4zkYgDB+KYzCwOxXx4evhhnLly1X0D7NoSmV8EcDNufIvMUgLu0b80hxVW
         2zHmwuzjlTYZYLGSjbgLIaTmKB0n7gdBt8CxIstNbjTTXe3RjlHC9hrIw/QXgoon+HaO
         lP7xiEMbNBC5uYh5aaKCFHngewVhGtgz673Jy6CVnIGKT2I46vLNzDbwSW5Z4uk5Bbns
         yiksy5TaZ0vcxKiRx33Rv6UB4pDIGvS1GhggvAEXDKOxe7D5Zlq/jnTuqrtNGGCrQq+4
         nrTi5Ek05ZP2y8jUDEnTqiARF0nAWROVvIQXL6vzOtqMOzYAkveAa6z3uovI4A/2/KfF
         414A==
X-Gm-Message-State: AOAM530xbIw3TkbE9KZa1Uo8WAlaPBi/6R28gk7otZNUIw+gD/ZGpNzm
        lTsfPIJJT8u0mIJvIFjuMOYI01Odmw2omSKW
X-Google-Smtp-Source: ABdhPJw0XZPZDZpp58SNZCuZrTw7/G9cZWVGqYX5+n2OfNDgKLaTaI3jbj8bI+MFfP28+OQT8ZQL5A==
X-Received: by 2002:a5d:9ada:: with SMTP id x26mr754095ion.50.1631331170809;
        Fri, 10 Sep 2021 20:32:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f3sm332051iow.3.2021.09.10.20.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 20:32:50 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:32:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 8/8] builtin/repack.c: pass `--refs-snapshot` when writing
 bitmaps
Message-ID: <6a1c52181e8c8c9fe2f0e2d7fbeb1057f68c1f3d.1631331139.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631331139.git.me@ttaylorr.com>
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
 builtin/repack.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index e958caff8b..3fda837cb5 100644
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
@@ -440,6 +442,61 @@ static void clear_pack_geometry(struct pack_geometry *geometry)
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
+static int midx_snapshot_refs(struct tempfile *f)
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
+		for_each_string_list_item(item, preferred) {
+			for_each_ref_in(item->string, midx_snapshot_ref_one, &data);
+		}
+		data.preferred = 0;
+	}
+
+	for_each_ref(midx_snapshot_ref_one, &data);
+
+	return close_tempfile_gently(f);
+}
+
 static void midx_included_packs(struct string_list *include,
 				struct string_list *existing_packs,
 				struct string_list *existing_kept_packs,
@@ -477,6 +534,7 @@ static void midx_included_packs(struct string_list *include,
 
 static int write_midx_included_packs(struct string_list *include,
 				     struct pack_geometry *geometry,
+				     const char *refs_snapshot,
 				     int show_progress, int write_bitmaps)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -511,6 +569,9 @@ static int write_midx_included_packs(struct string_list *include,
 			;
 	}
 
+	if (refs_snapshot)
+		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
+
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
@@ -534,6 +595,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
+	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
 	FILE *out;
 	int show_progress = isatty(2);
@@ -622,6 +684,19 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));
 
+	if (write_midx && write_bitmaps) {
+		struct strbuf path = STRBUF_INIT;
+
+		strbuf_addf(&path, "%s/%s_XXXXXX", get_object_directory(),
+			    "bitmap-ref-tips");
+
+		refs_snapshot = xmks_tempfile(path.buf);
+		if (midx_snapshot_refs(refs_snapshot) < 0)
+			die(_("could not take a snapshot of references"));
+
+		strbuf_release(&path);
+	}
+
 	if (geometric_factor) {
 		if (pack_everything)
 			die(_("--geometric is incompatible with -A, -a"));
@@ -798,6 +873,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				    &existing_kept_packs, &names, geometry);
 
 		ret = write_midx_included_packs(&include, geometry,
+						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
 						show_progress, write_bitmaps > 0);
 
 		string_list_clear(&include, 0);
-- 
2.33.0.96.g73915697e6
