Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194B1C001DE
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 20:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjHIUcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjHIUcp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 16:32:45 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA6B2113
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 13:32:44 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bca3311b4fso218825a34.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691613163; x=1692217963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJChOKChHElNBnoUzLrUSa5bg8FpZB8QSTsAaFaPPWw=;
        b=ugm8eSk/OwM5c96B5Rp9POAiGOkrODnnQhroOuqDRG6k6fsKtdfs/JMAvLfiJw7H3z
         0KmOfc3ClFwI4MqEHEfzXoMkR1ruuz1ZnqztA3K63n+XKM9V66ny8QgBNmfkEz8/KByr
         MzzrfjjPXqklzLooOWENGmStmJdYW7MhUdXG5VPpJQxiqD7c2adZ6pIQQ8yB0AsxgIq2
         JsrEmF2vSRVqEf1H8n8Bz3W1wdpqbvE2f4P95+VTTV6qUqyvx9Sn5WRwNlUk1u9N/x5T
         2vH1EvBRHfDIqEXaPR2PZ30YrGasOhJkYQQwhuXSbH7L8UvqJbwCswwijRaMNSaKMGgi
         OcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613163; x=1692217963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJChOKChHElNBnoUzLrUSa5bg8FpZB8QSTsAaFaPPWw=;
        b=SmGWu0pYGT/AL7mrfbUD0LhlWIoKUg/dsP6UvZkLvBkgGM9Ftuw4pBUIPUi7zdEUA/
         4lpFLxymx1q0HdmiKBvya88AuUC6TwS9VDqclwDJWR+KNssSM7hfALgLntvZEfTPnxSB
         ziq8XoGpyla4Ho3OTGK1kliJfbslhnqvZRKG4DxLmQAcbmBIcjatSx5Nk2zqYbDhsg2Y
         cymCPPHCczSW47JoYt2AJT2JbeskvsZlXuYSkjM0nimCK/2FKgpA9u/ODuMVHr8aeFKo
         xA1EyEFTOenZ4+VHI+QJZptwJyjWEyvNEIoxqEMhua/5nzVpJEApNv20D3DBvtQAcWy2
         Il2w==
X-Gm-Message-State: AOJu0YypjMpGHIEa+bqekiYBf5R8rwi1fMlDIOKpppmagbFWxRw2yc46
        vF1jm6vSyZitGiCGJQkbCcjpAah0gm6cNLN+s2JnJA==
X-Google-Smtp-Source: AGHT+IGIH9Hr/V3ADX8VY8lBg0E0jS/fYHzlLN1kHCb7X0+f+WAqN7wbitbZsdcsDQHdZn/fk59Usw==
X-Received: by 2002:a05:6808:693:b0:3a3:3a0b:aab8 with SMTP id k19-20020a056808069300b003a33a0baab8mr408015oig.48.1691613163511;
        Wed, 09 Aug 2023 13:32:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 192-20020a2515c9000000b00c389676f3a2sm3539006ybv.40.2023.08.09.13.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:32:43 -0700 (PDT)
Date:   Wed, 9 Aug 2023 16:32:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/2] repack: move `pack_geometry` struct to the stack
Message-ID: <2e2a760381be1f7cdae83e2f43b17d16aa8ab161.1691613149.git.me@ttaylorr.com>
References: <20230808211759.GA322409@coredump.intra.peff.net>
 <cover.1691613149.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691613149.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `pack_geometry` struct is used to maintain and partition a list of
packfiles into a "frozen" set (to be left alone), and a non-frozen set
(to be combined into a single new pack). In the previous commit, we
removed a leak caused by neglecting to free() the heap allocated space
used to store the structure itself.

But there is no need for this structure to live on the heap anyway.
Instead, let's move it to be stack allocated, eliminating the
possibility of a direct leak like the one addressed in the previous
patch.

The one minor hitch is that we use the NULL-ness of the pack_geometry's
struct pointer to determine whether or not we are performing a geometric
repack with `--geometric=<d>`. But since we only initialize the
pack_geometry structure when the `geometric_factor` is non-zero, we can
use that variable (based on whether or not it is equal to zero) to
determine whether or not we are performing a geometric repack.

There are a couple of spots that have access to a pointer to the
pack_geometry struct, but not the geometric_factor itself. Instead of
passing in an additional variable, let's make the geometric_factor a
field of the pack_geometry struct.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 62 ++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 97051479e4..2b43a5be08 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -303,6 +303,8 @@ struct pack_geometry {
 	struct packed_git **pack;
 	uint32_t pack_nr, pack_alloc;
 	uint32_t split;
+
+	int split_factor;
 };
 
 static uint32_t geometry_pack_weight(struct packed_git *p)
@@ -324,17 +326,13 @@ static int geometry_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-static void init_pack_geometry(struct pack_geometry **geometry_p,
+static void init_pack_geometry(struct pack_geometry *geometry,
 			       struct string_list *existing_kept_packs,
 			       const struct pack_objects_args *args)
 {
 	struct packed_git *p;
-	struct pack_geometry *geometry;
 	struct strbuf buf = STRBUF_INIT;
 
-	*geometry_p = xcalloc(1, sizeof(struct pack_geometry));
-	geometry = *geometry_p;
-
 	for (p = get_all_packs(the_repository); p; p = p->next) {
 		if (args->local && !p->pack_local)
 			/*
@@ -380,7 +378,7 @@ static void init_pack_geometry(struct pack_geometry **geometry_p,
 	strbuf_release(&buf);
 }
 
-static void split_pack_geometry(struct pack_geometry *geometry, int factor)
+static void split_pack_geometry(struct pack_geometry *geometry)
 {
 	uint32_t i;
 	uint32_t split;
@@ -399,12 +397,14 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
 		struct packed_git *ours = geometry->pack[i];
 		struct packed_git *prev = geometry->pack[i - 1];
 
-		if (unsigned_mult_overflows(factor, geometry_pack_weight(prev)))
+		if (unsigned_mult_overflows(geometry->split_factor,
+					    geometry_pack_weight(prev)))
 			die(_("pack %s too large to consider in geometric "
 			      "progression"),
 			    prev->pack_name);
 
-		if (geometry_pack_weight(ours) < factor * geometry_pack_weight(prev))
+		if (geometry_pack_weight(ours) <
+		    geometry->split_factor * geometry_pack_weight(prev))
 			break;
 	}
 
@@ -439,10 +439,12 @@ static void split_pack_geometry(struct pack_geometry *geometry, int factor)
 	for (i = split; i < geometry->pack_nr; i++) {
 		struct packed_git *ours = geometry->pack[i];
 
-		if (unsigned_mult_overflows(factor, total_size))
+		if (unsigned_mult_overflows(geometry->split_factor,
+					    total_size))
 			die(_("pack %s too large to roll up"), ours->pack_name);
 
-		if (geometry_pack_weight(ours) < factor * total_size) {
+		if (geometry_pack_weight(ours) <
+		    geometry->split_factor * total_size) {
 			if (unsigned_add_overflows(total_size,
 						   geometry_pack_weight(ours)))
 				die(_("pack %s too large to roll up"),
@@ -498,7 +500,6 @@ static void free_pack_geometry(struct pack_geometry *geometry)
 		return;
 
 	free(geometry->pack);
-	free(geometry);
 }
 
 struct midx_snapshot_ref_data {
@@ -575,7 +576,7 @@ static void midx_included_packs(struct string_list *include,
 		string_list_insert(include, xstrfmt("%s.idx", item->string));
 	for_each_string_list_item(item, names)
 		string_list_insert(include, xstrfmt("pack-%s.idx", item->string));
-	if (geometry) {
+	if (geometry->split_factor) {
 		struct strbuf buf = STRBUF_INIT;
 		uint32_t i;
 		for (i = geometry->split; i < geometry->pack_nr; i++) {
@@ -779,7 +780,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
-	struct pack_geometry *geometry = NULL;
+	struct pack_geometry geometry = { 0 };
 	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
@@ -793,7 +794,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct pack_objects_args po_args = {NULL};
 	struct pack_objects_args cruft_po_args = {NULL};
-	int geometric_factor = 0;
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
@@ -842,7 +842,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
-		OPT_INTEGER('g', "geometric", &geometric_factor,
+		OPT_INTEGER('g', "geometric", &geometry.split_factor,
 			    N_("find a geometric progression with factor <N>")),
 		OPT_BOOL('m', "write-midx", &write_midx,
 			   N_("write a multi-pack index of the resulting packs")),
@@ -918,11 +918,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	collect_pack_filenames(&existing_nonkept_packs, &existing_kept_packs,
 			       &keep_pack_list);
 
-	if (geometric_factor) {
+	if (geometry.split_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
 		init_pack_geometry(&geometry, &existing_kept_packs, &po_args);
-		split_pack_geometry(geometry, geometric_factor);
+		split_pack_geometry(&geometry);
 	}
 
 	prepare_pack_objects(&cmd, &po_args, packtmp);
@@ -936,7 +936,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_pushf(&cmd.args, "--keep-pack=%s",
 			     keep_pack_list.items[i].string);
 	strvec_push(&cmd.args, "--non-empty");
-	if (!geometry) {
+	if (!geometry.split_factor) {
 		/*
 		 * We need to grab all reachable objects, including those that
 		 * are reachable from reflogs and the index.
@@ -983,7 +983,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				strvec_push(&cmd.args, "--pack-loose-unreachable");
 			}
 		}
-	} else if (geometry) {
+	} else if (geometry.split_factor) {
 		strvec_push(&cmd.args, "--stdin-packs");
 		strvec_push(&cmd.args, "--unpacked");
 	} else {
@@ -991,7 +991,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--incremental");
 	}
 
-	if (geometry)
+	if (geometry.split_factor)
 		cmd.in = -1;
 	else
 		cmd.no_stdin = 1;
@@ -1000,17 +1000,17 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (ret)
 		goto cleanup;
 
-	if (geometry) {
+	if (geometry.split_factor) {
 		FILE *in = xfdopen(cmd.in, "w");
 		/*
 		 * The resulting pack should contain all objects in packs that
 		 * are going to be rolled up, but exclude objects in packs which
 		 * are being left alone.
 		 */
-		for (i = 0; i < geometry->split; i++)
-			fprintf(in, "%s\n", pack_basename(geometry->pack[i]));
-		for (i = geometry->split; i < geometry->pack_nr; i++)
-			fprintf(in, "^%s\n", pack_basename(geometry->pack[i]));
+		for (i = 0; i < geometry.split; i++)
+			fprintf(in, "%s\n", pack_basename(geometry.pack[i]));
+		for (i = geometry.split; i < geometry.pack_nr; i++)
+			fprintf(in, "^%s\n", pack_basename(geometry.pack[i]));
 		fclose(in);
 	}
 
@@ -1153,9 +1153,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_NODUP;
 		midx_included_packs(&include, &existing_nonkept_packs,
-				    &existing_kept_packs, &names, geometry);
+				    &existing_kept_packs, &names, &geometry);
 
-		ret = write_midx_included_packs(&include, geometry,
+		ret = write_midx_included_packs(&include, &geometry,
 						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
 						show_progress, write_bitmaps > 0);
 
@@ -1178,12 +1178,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			remove_redundant_pack(packdir, item->string);
 		}
 
-		if (geometry) {
+		if (geometry.split_factor) {
 			struct strbuf buf = STRBUF_INIT;
 
 			uint32_t i;
-			for (i = 0; i < geometry->split; i++) {
-				struct packed_git *p = geometry->pack[i];
+			for (i = 0; i < geometry.split; i++) {
+				struct packed_git *p = geometry.pack[i];
 				if (string_list_has_string(&names,
 							   hash_to_hex(p->hash)))
 					continue;
@@ -1226,7 +1226,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&names, 1);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
-	free_pack_geometry(geometry);
+	free_pack_geometry(&geometry);
 
 	return ret;
 }
-- 
2.42.0.rc0.27.g2e2a760381
