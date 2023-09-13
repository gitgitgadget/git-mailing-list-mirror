Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE36EE020A
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 19:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjIMTRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjIMTRs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 15:17:48 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7F3170F
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:44 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7b9de8139fso198241276.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694632664; x=1695237464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/zBrG9vaXf0P4savWUkFGQJmWWw6bQFT/Un8wPq6MY=;
        b=VP60ub/CXVpkfy+bZsrOd3vZdWMIZhMB4K3WWr7xJDzHbBGPy+suKiLHsRpEIA8F/n
         lMOBgOS0DdqTdbj8/o0bcg1Rmkdl7b4zj1zckAzgfmC/3OyozbkNi7oEjhdtFRk4FE1U
         6Xl1XEpMuum/nsOjlW6NRnKeL/F17SibXUVW4kInOEiJFEBTAQ129FMi6TC+8Pk/diMx
         WopCa6Bt/oN0BlUfu+m1o+9eC3PtZ5SCuH5WWlKTmSI9XmTSVWyltC4CqhSC9YQ+FwgN
         fyIP/Nef2Tx+v/kVA/2W8P1wLkinPZKYYw54+XPwXzAlZ8+CosuNyZttJTWZX1k7jUbM
         mBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694632664; x=1695237464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/zBrG9vaXf0P4savWUkFGQJmWWw6bQFT/Un8wPq6MY=;
        b=rkuxBnEdxXyKP5GOFzJ7tjLXBQ/42OD9xq4RMPnKq7LBKNQEHjBRUsBuOyToUb205g
         ABhnDzOlLW16Kckrerf8P5NFnhGzYOytYFz8PCk2jagJmlwOnlPMPMf5BnZPWFunGDLv
         lRb7PFoiy2lssaOv0Cq76FMswxXZaBoEjAbP5ZfsgrTyltHZqdkkUMUBsEqKjEty6FGw
         /B+fENybG01n9gmlfBhG6xffESGVEkXMCCeTvaHxo+v9OIOQNMF9fDRbrM/XcJWYfK/O
         7VZZ/1mxibUwXKw1WqsnioQZYf7VGTFKt4KMaZLMdd1LPRpZ0FdyPt195Ak+4ZF8dzSx
         lpvA==
X-Gm-Message-State: AOJu0Yz43gq0FVZMAJv/yMPvWWiXInOql6hGki0mDR0VKQAOFqmeSOnp
        gzHXfWLXgYYsDdR1wzaoj9sEHC8w7cMTkXRvq2O2eA==
X-Google-Smtp-Source: AGHT+IHe/GdCplNXLk+pSSBln5RjENV8uIQ6pfluSVyXv2TZx0F2NE7TOWq/3mvjI0qDZq/THnppJg==
X-Received: by 2002:a25:be8b:0:b0:d74:6188:19e7 with SMTP id i11-20020a25be8b000000b00d74618819e7mr3250936ybk.35.1694632663528;
        Wed, 13 Sep 2023 12:17:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l7-20020a252507000000b00d7badcab84esm2883130ybl.9.2023.09.13.12.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 12:17:43 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:17:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/8] builtin/repack.c: extract structure to store existing
 packs
Message-ID: <2e26beff22414282ecbbe846113d55845c7d0df8.1694632644.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
 <cover.1694632644.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1694632644.git.me@ttaylorr.com>
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
index 6943c5ba11..67bf86567f 100644
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
@@ -743,9 +757,9 @@ static int write_cruft_pack(const struct pack_objects_args *args,
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
 
@@ -777,8 +791,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
-	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
-	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
+	struct existing_packs existing = EXISTING_PACKS_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
@@ -914,13 +927,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
 
@@ -964,7 +976,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(&po_args, &names);
 
-		if (existing_nonkept_packs.nr && delete_redundant &&
+		if (existing.non_kept_packs.nr && delete_redundant &&
 		    !(pack_everything & PACK_CRUFT)) {
 			for_each_string_list_item(item, &names) {
 				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
@@ -1055,8 +1067,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
 				       cruft_expiration, &names,
-				       &existing_nonkept_packs,
-				       &existing_kept_packs);
+				       &existing);
 		if (ret)
 			goto cleanup;
 
@@ -1087,8 +1098,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 					       pack_prefix,
 					       NULL,
 					       &names,
-					       &existing_nonkept_packs,
-					       &existing_kept_packs);
+					       &existing);
 			if (ret)
 				goto cleanup;
 		}
@@ -1134,7 +1144,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
 		const int hexsz = the_hash_algo->hexsz;
-		for_each_string_list_item(item, &existing_nonkept_packs) {
+		for_each_string_list_item(item, &existing.non_kept_packs) {
 			char *sha1;
 			size_t len = strlen(item->string);
 			if (len < hexsz)
@@ -1153,8 +1163,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_NODUP;
-		midx_included_packs(&include, &existing_nonkept_packs,
-				    &existing_kept_packs, &names, &geometry);
+		midx_included_packs(&include, &existing, &names, &geometry);
 
 		ret = write_midx_included_packs(&include, &geometry,
 						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
@@ -1173,7 +1182,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (delete_redundant) {
 		int opts = 0;
-		for_each_string_list_item(item, &existing_nonkept_packs) {
+		for_each_string_list_item(item, &existing.non_kept_packs) {
 			if (!((uintptr_t)item->util & DELETE_PACK))
 				continue;
 			remove_redundant_pack(packdir, item->string);
@@ -1194,7 +1203,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				strbuf_strip_suffix(&buf, ".pack");
 
 				if ((p->pack_keep) ||
-				    (string_list_has_string(&existing_kept_packs,
+				    (string_list_has_string(&existing.kept_packs,
 							    buf.buf)))
 					continue;
 
@@ -1225,8 +1234,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 cleanup:
 	string_list_clear(&names, 1);
-	string_list_clear(&existing_nonkept_packs, 0);
-	string_list_clear(&existing_kept_packs, 0);
+	existing_packs_release(&existing);
 	free_pack_geometry(&geometry);
 
 	return ret;
-- 
2.42.0.166.g68748eb9c8

