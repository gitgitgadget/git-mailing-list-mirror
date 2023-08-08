Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8B0C41513
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjHHUeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjHHUeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:34:00 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A69A1CA53
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 12:59:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583d702129cso64901187b3.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691524784; x=1692129584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfG18uT4NG+e/cJ8ZQGlZK/6KyAI1UDtgxekW+KTQZI=;
        b=bAhRhN4eyFB9p1ghfn1sWkoR7K67r6dkYay1RcHS2Qfuzqfi+zHX71fbIgV50ygZmB
         LOC/uWMiLOKv/jmeK43KdWctf5F/+AjFwVxgkxwZChd1XoBztagZxHHBCvz44jREBZ3o
         eEZ4/VR4zZkCthrPx2WISYGv8vSowp6eLYGM9t9yI4e+ZDMC8GxA/R60wFs5/6kf19sh
         RJ8W8gw9u6ena3d4FoduD9ffpzZq131+hEbvNNW2jdIeN2WnV8CJ0zJveDK/4oLOPtMs
         lZEiXI6D8rxz0G6JZDndBPbkRQ8yUs4UY6c7w1OUo6cqd2QVEFcw/dUBzAaJ5ZVYf1KD
         ELqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691524784; x=1692129584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfG18uT4NG+e/cJ8ZQGlZK/6KyAI1UDtgxekW+KTQZI=;
        b=VH3gX0+96oh3aGdZsTcnT7a+cyyo1MkJNyn4KkhDv2k5noGnFPxZeHmFxbTPpikxlz
         Lce0b0CK3I3JSt9nIAbeSoN5DhfediGo5eZpfcmEuavSWD6QG313CB2WFTI+Ejj6AG94
         HsiQioI/HsHLh/FIfCuKdBMN92i55DUDma8qBQIQMUxgrFCwvjMn0RzEt5T7TRC5bvnu
         oej48WzDWNrWGSNsoqCjSqpK/hLjHf06s4x5WI6bTisCKuThr80ou77Yuw3VrQgbAF7r
         PPZseNV/HzScAwJPfmLnIhFouMv3QVVzREWpMPbl9t38rX51/mrt58utDq4u2ntUJvh1
         1eqw==
X-Gm-Message-State: AOJu0YwAMk3QRF+nKVi/+8A4gD8YeV0Vaf6s+7nCX0IhBCoGAdctcJ7A
        I8FpypRGXi9EkDPNJNoMgi38em7mGRfj8uwIXBae3g==
X-Google-Smtp-Source: AGHT+IHyBvAyk2unYEr11W6EM5cGJSe/WV3LGjvbvHHmiJqvNKDTElVq6CQOfce5Cn7+puYpkYyBCw==
X-Received: by 2002:a0d:cccb:0:b0:579:dfac:f507 with SMTP id o194-20020a0dcccb000000b00579dfacf507mr728747ywd.34.1691524784406;
        Tue, 08 Aug 2023 12:59:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j1-20020a0de001000000b00583b5564c1dsm3552909ywe.135.2023.08.08.12.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:59:44 -0700 (PDT)
Date:   Tue, 8 Aug 2023 15:59:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] repack: free geometry struct
Message-ID: <ZNKer8BfwaKEeV+W@nand.local>
References: <20230808185023.GA3498623@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808185023.GA3498623@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 02:50:23PM -0400, Jeff King wrote:
> Another option would be to put the struct on the stack rather than the
> heap. However, this gets tricky, as we check the pointer against NULL in
> several places to decide whether we're in geometric mode.

The patch you have here looks good, but...

> I did actually put together the "put it on the stack" patch, which swaps
> out:
>
>   if (geometry)
>
> for:
>
>   if (geometric_factor)
>
> to get around the NULL checks. But besides being noisy for little gain,
> it ends up with some subtle gotchas, because we pass "&geometry" into
> some functions which don't have access to "geometric_factor" (so now
> extra call-sites have to keep track of "is this struct valid enough to
> pass").

...I think that storing the geometric_factor value on the pack_geometry
struct itself gets around most of these issues.

This version is still somewhat noisy, but it's not too bad IMHO. I'm
fine with either your approach or mine :-).

--- 8< ---
diff --git a/builtin/repack.c b/builtin/repack.c
index aea5ca9d44..13e4f0094e 100644
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
@@ -781,7 +783,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
-	struct pack_geometry *geometry = NULL;
+	struct pack_geometry geometry = { 0 };
 	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
@@ -795,7 +797,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct pack_objects_args po_args = {NULL};
 	struct pack_objects_args cruft_po_args = {NULL};
-	int geometric_factor = 0;
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
@@ -844,7 +845,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
-		OPT_INTEGER('g', "geometric", &geometric_factor,
+		OPT_INTEGER('g', "geometric", &geometry.split_factor,
 			    N_("find a geometric progression with factor <N>")),
 		OPT_BOOL('m', "write-midx", &write_midx,
 			   N_("write a multi-pack index of the resulting packs")),
@@ -920,11 +921,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
@@ -938,7 +939,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_pushf(&cmd.args, "--keep-pack=%s",
 			     keep_pack_list.items[i].string);
 	strvec_push(&cmd.args, "--non-empty");
-	if (!geometry) {
+	if (!geometry.split_factor) {
 		/*
 		 * We need to grab all reachable objects, including those that
 		 * are reachable from reflogs and the index.
@@ -985,7 +986,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				strvec_push(&cmd.args, "--pack-loose-unreachable");
 			}
 		}
-	} else if (geometry) {
+	} else if (geometry.split_factor) {
 		strvec_push(&cmd.args, "--stdin-packs");
 		strvec_push(&cmd.args, "--unpacked");
 	} else {
@@ -993,7 +994,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--incremental");
 	}

-	if (geometry)
+	if (geometry.split_factor)
 		cmd.in = -1;
 	else
 		cmd.no_stdin = 1;
@@ -1002,17 +1003,17 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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

@@ -1155,9 +1156,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_NODUP;
 		midx_included_packs(&include, &existing_nonkept_packs,
-				    &existing_kept_packs, &names, geometry);
+				    &existing_kept_packs, &names, &geometry);

-		ret = write_midx_included_packs(&include, geometry,
+		ret = write_midx_included_packs(&include, &geometry,
 						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
 						show_progress, write_bitmaps > 0);

@@ -1180,12 +1181,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
@@ -1228,7 +1229,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&names, 1);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
-	clear_pack_geometry(geometry);
+	clear_pack_geometry(&geometry);

 	return ret;
 }
--- >8 ---

Thanks,
Taylor
