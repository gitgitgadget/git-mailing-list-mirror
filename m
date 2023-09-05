Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00B7CA100D
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 20:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbjIEUgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243807AbjIEUgv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 16:36:51 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEBAD1
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 13:36:42 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58caaedb20bso30072567b3.1
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1693946201; x=1694551001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLVY8doTHJIbak1Hn85Z1exI/3nf4NSHqrRG9Jm/GX8=;
        b=jTSxFdjEHJbti8S8JYFcxu6oUNdP13G0DNXs6egme9rRiXyNy/Rc7PRuKh2O5eTWpL
         UpLjaRkqMVuB3RJZLesrYlclRM2RUXujc96NB7zu+7FVc+8KQzxMbZFF7OaPEG0gQcsp
         i0EXKbmclJkAWGkxmNuxmG15azMq+i5iQG2bY/O0gBLv2B1DKpWDxsADAPFyRd0PTWce
         r4Lgd9tL/yOPl2fp73ypLTQjzakZ4HlLNTMzBNDQs00HuXU5xzqlJEa6oG8Tmjv6qj51
         WbXQEgxNrf53BgAWclnICVuL+uozKCOvjhNNjTUOc5YBgAtI922fPFgSM5QqfYMo6nfb
         4Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946201; x=1694551001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLVY8doTHJIbak1Hn85Z1exI/3nf4NSHqrRG9Jm/GX8=;
        b=j7ZmAeultdpAEso72K7qAm9CufX9o4uo6KoIoZW3KefLlWHc3S8Jsl2x3ZfaE7TdzM
         v37bFywRQYANfmrOzCDv24hZtQgSFNSSVDfkHTNWHHk3usKRjr26OWEkDbtPBpQKGXqy
         kep4teNmGAPDzcBPpqEOdbITOvNxEaCt5/yf5E1yGB/H+NC7UXxnU2EoZHfhR5Gvse+Y
         lOJa7vYHjbGC8PZe2kVXDtzLpGCP/VEbph6scT0DqdUfhXhQBqdYJe7ZSsJRXvtIzLvI
         hOP7jY8GZbe50tCmzdjCvvTiOl+hZKlDmUneFm9vtO1LutnJsa03PAi1BOvtJCvrEu3w
         0Ssg==
X-Gm-Message-State: AOJu0YwRGYmik5f+kcai5W7p4D6dB7Mhjhy/pUDqawjJwJ2Zbo0puXNv
        iM+N/is57ssAbO4CFY7yutz5hHOng71fjhd7cU5iRQ==
X-Google-Smtp-Source: AGHT+IGRku6H3obZKmLozXqHxC8FvNhZo25kBx0/yKZxjBd8O+s/NoYWqXNuxtiqBWG6dzm7jnlrrQ==
X-Received: by 2002:a0d:d981:0:b0:589:f7ad:7702 with SMTP id b123-20020a0dd981000000b00589f7ad7702mr15497104ywe.36.1693946201657;
        Tue, 05 Sep 2023 13:36:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cs3-20020a05690c0ec300b0059a34cfa2a5sm1838863ywb.67.2023.09.05.13.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:36:41 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:36:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/8] builtin/repack.c: extract structure to store existing
 packs
Message-ID: <5b48b7e3cc03c83465a3dcecaa98b9d2e9667084.1693946195.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The repack machinery needs to keep track of which packfiles were present
in the repository at the beginning of a repack, segmented by whether or
not each pack is marked as kept.

The names of these packs are stored in two `string_list`s, corresponding
to kept- and non-kept packs, respectively. As a consequence, many
functions within the repack code need to take both `string_list`s as
arguments, leading to code like this:

    ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
                           cruft_expiration, &names,
                           &existing_nonkept_packs, /* <- */
                           &existing_kept_packs);   /* <- */

Wrap up this pair of `string_list`s into a single structure that stores
both. This saves us from having to pass both string lists separately,
and prepares for adding additional fields to this structure.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 90 ++++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 2b43a5be08..c3ab89912e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -95,14 +95,29 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
+struct existing_packs {
+	struct string_list kept_packs;
+	struct string_list non_kept_packs;
+};
+
+#define EXISTING_PACKS_INIT { \
+	.kept_packs = STRING_LIST_INIT_DUP, \
+	.non_kept_packs = STRING_LIST_INIT_DUP, \
+}
+
+static void existing_packs_release(struct existing_packs *existing)
+{
+	string_list_clear(&existing->kept_packs, 0);
+	string_list_clear(&existing->non_kept_packs, 0);
+}
+
 /*
- * Adds all packs hex strings (pack-$HASH) to either fname_nonkept_list
- * or fname_kept_list based on whether each pack has a corresponding
+ * Adds all packs hex strings (pack-$HASH) to either packs->non_kept
+ * or packs->kept based on whether each pack has a corresponding
  * .keep file or not.  Packs without a .keep file are not to be kept
  * if we are going to pack everything into one file.
  */
-static void collect_pack_filenames(struct string_list *fname_nonkept_list,
-				   struct string_list *fname_kept_list,
+static void collect_pack_filenames(struct existing_packs *existing,
 				   const struct string_list *extra_keep)
 {
 	struct packed_git *p;
@@ -126,16 +141,16 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 		strbuf_strip_suffix(&buf, ".pack");
 
 		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep)
-			string_list_append(fname_kept_list, buf.buf);
+			string_list_append(&existing->kept_packs, buf.buf);
 		else {
 			struct string_list_item *item;
-			item = string_list_append(fname_nonkept_list, buf.buf);
+			item = string_list_append(&existing->non_kept_packs, buf.buf);
 			if (p->is_cruft)
 				item->util = (void*)(uintptr_t)CRUFT_PACK;
 		}
 	}
 
-	string_list_sort(fname_kept_list);
+	string_list_sort(&existing->kept_packs);
 	strbuf_release(&buf);
 }
 
@@ -327,7 +342,7 @@ static int geometry_cmp(const void *va, const void *vb)
 }
 
 static void init_pack_geometry(struct pack_geometry *geometry,
-			       struct string_list *existing_kept_packs,
+			       struct existing_packs *existing,
 			       const struct pack_objects_args *args)
 {
 	struct packed_git *p;
@@ -344,23 +359,24 @@ static void init_pack_geometry(struct pack_geometry *geometry,
 
 		if (!pack_kept_objects) {
 			/*
-			 * Any pack that has its pack_keep bit set will appear
-			 * in existing_kept_packs below, but this saves us from
-			 * doing a more expensive check.
+			 * Any pack that has its pack_keep bit set will
+			 * appear in existing->kept_packs below, but
+			 * this saves us from doing a more expensive
+			 * check.
 			 */
 			if (p->pack_keep)
 				continue;
 
 			/*
-			 * The pack may be kept via the --keep-pack option;
-			 * check 'existing_kept_packs' to determine whether to
-			 * ignore it.
+			 * The pack may be kept via the --keep-pack
+			 * option; check 'existing->kept_packs' to
+			 * determine whether to ignore it.
 			 */
 			strbuf_reset(&buf);
 			strbuf_addstr(&buf, pack_basename(p));
 			strbuf_strip_suffix(&buf, ".pack");
 
-			if (string_list_has_string(existing_kept_packs, buf.buf))
+			if (string_list_has_string(&existing->kept_packs, buf.buf))
 				continue;
 		}
 		if (p->is_cruft)
@@ -565,14 +581,13 @@ static void midx_snapshot_refs(struct tempfile *f)
 }
 
 static void midx_included_packs(struct string_list *include,
-				struct string_list *existing_nonkept_packs,
-				struct string_list *existing_kept_packs,
+				struct existing_packs *existing,
 				struct string_list *names,
 				struct pack_geometry *geometry)
 {
 	struct string_list_item *item;
 
-	for_each_string_list_item(item, existing_kept_packs)
+	for_each_string_list_item(item, &existing->kept_packs)
 		string_list_insert(include, xstrfmt("%s.idx", item->string));
 	for_each_string_list_item(item, names)
 		string_list_insert(include, xstrfmt("pack-%s.idx", item->string));
@@ -600,7 +615,7 @@ static void midx_included_packs(struct string_list *include,
 			string_list_insert(include, strbuf_detach(&buf, NULL));
 		}
 
-		for_each_string_list_item(item, existing_nonkept_packs) {
+		for_each_string_list_item(item, &existing->non_kept_packs) {
 			if (!((uintptr_t)item->util & CRUFT_PACK)) {
 				/*
 				 * no need to check DELETE_PACK, since we're not
@@ -611,7 +626,7 @@ static void midx_included_packs(struct string_list *include,
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
 		}
 	} else {
-		for_each_string_list_item(item, existing_nonkept_packs) {
+		for_each_string_list_item(item, &existing->non_kept_packs) {
 			if ((uintptr_t)item->util & DELETE_PACK)
 				continue;
 			string_list_insert(include, xstrfmt("%s.idx", item->string));
@@ -700,8 +715,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 			    const char *pack_prefix,
 			    const char *cruft_expiration,
 			    struct string_list *names,
-			    struct string_list *existing_packs,
-			    struct string_list *existing_kept_packs)
+			    struct existing_packs *existing)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct strbuf line = STRBUF_INIT;
@@ -744,9 +758,9 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
 		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
-	for_each_string_list_item(item, existing_packs)
+	for_each_string_list_item(item, &existing->non_kept_packs)
 		fprintf(in, "-%s.pack\n", item->string);
-	for_each_string_list_item(item, existing_kept_packs)
+	for_each_string_list_item(item, &existing->kept_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
 
@@ -778,8 +792,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
-	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
-	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
+	struct existing_packs existing = EXISTING_PACKS_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
@@ -915,13 +928,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
 	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
 
-	collect_pack_filenames(&existing_nonkept_packs, &existing_kept_packs,
-			       &keep_pack_list);
+	collect_pack_filenames(&existing, &keep_pack_list);
 
 	if (geometry.split_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
-		init_pack_geometry(&geometry, &existing_kept_packs, &po_args);
+		init_pack_geometry(&geometry, &existing, &po_args);
 		split_pack_geometry(&geometry);
 	}
 
@@ -965,7 +977,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(&po_args, &names);
 
-		if (existing_nonkept_packs.nr && delete_redundant &&
+		if (existing.non_kept_packs.nr && delete_redundant &&
 		    !(pack_everything & PACK_CRUFT)) {
 			for_each_string_list_item(item, &names) {
 				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
@@ -1054,8 +1066,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
 				       cruft_expiration, &names,
-				       &existing_nonkept_packs,
-				       &existing_kept_packs);
+				       &existing);
 		if (ret)
 			goto cleanup;
 
@@ -1086,8 +1097,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 					       pack_prefix,
 					       NULL,
 					       &names,
-					       &existing_nonkept_packs,
-					       &existing_kept_packs);
+					       &existing);
 			if (ret)
 				goto cleanup;
 		}
@@ -1133,7 +1143,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
 		const int hexsz = the_hash_algo->hexsz;
-		for_each_string_list_item(item, &existing_nonkept_packs) {
+		for_each_string_list_item(item, &existing.non_kept_packs) {
 			char *sha1;
 			size_t len = strlen(item->string);
 			if (len < hexsz)
@@ -1152,8 +1162,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_NODUP;
-		midx_included_packs(&include, &existing_nonkept_packs,
-				    &existing_kept_packs, &names, &geometry);
+		midx_included_packs(&include, &existing, &names, &geometry);
 
 		ret = write_midx_included_packs(&include, &geometry,
 						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
@@ -1172,7 +1181,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (delete_redundant) {
 		int opts = 0;
-		for_each_string_list_item(item, &existing_nonkept_packs) {
+		for_each_string_list_item(item, &existing.non_kept_packs) {
 			if (!((uintptr_t)item->util & DELETE_PACK))
 				continue;
 			remove_redundant_pack(packdir, item->string);
@@ -1193,7 +1202,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				strbuf_strip_suffix(&buf, ".pack");
 
 				if ((p->pack_keep) ||
-				    (string_list_has_string(&existing_kept_packs,
+				    (string_list_has_string(&existing.kept_packs,
 							    buf.buf)))
 					continue;
 
@@ -1224,8 +1233,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 cleanup:
 	string_list_clear(&names, 1);
-	string_list_clear(&existing_nonkept_packs, 0);
-	string_list_clear(&existing_kept_packs, 0);
+	existing_packs_release(&existing);
 	free_pack_geometry(&geometry);
 
 	return ret;
-- 
2.42.0.119.gca7d13e7bf

