Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3205C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC607610A3
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhHXQRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhHXQQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:16:58 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8320CC0613CF
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:14 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z1so27075141ioh.7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=99QFc6iWE46oS6WpjKr6khuiQmTu6kQ1e9j/Shryp6E=;
        b=uLQSxmnQ3yRksPvtGwQycSihORSjMucirAN1uQ9Ac5RE8gC8k1li4FqAS2YM2OZrwh
         ZkijSujM1MpaQhR24vbfkyal9OR74Wo0W1AsqjEFcc5SVDuS6z2yFFA5+8i759S4te9H
         7pVk602L38t39uSNmFn+IGMRZd3OrZEDvfsGw95u9MrqlBaL7QFSe0K7dj8MenSJwbys
         WMk7YmYJkzYwT+w46kKYKzYGn4I1EQjTpZGsb6TZUh+nJrURxdhOmaEDMfl1HoYC3dVp
         gCC59M1WX0VNBlxg3+WR4HYb3dwnXp85ZAGp+1onjWP3NPdR7a2oVaT76bLmAPjYzMDL
         LTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=99QFc6iWE46oS6WpjKr6khuiQmTu6kQ1e9j/Shryp6E=;
        b=EjyTnHzj4FXrJMgIujlSxFTyQYGzxcIVTHk0qY38zNiny2Qu83hzE3U0JENxG2YbQr
         N34ptigjLdkvLKP6SfSUhTf2dhG94Wr1gxsGCnL+m7+CVIUBiJdFlBThqr+1rT+NV93u
         vKftCQDfyOJ2Qm0rfEI6n2Y/E8Yx0ht8amWRo7IaDfl1FsnJ2gTsFX9W03WI61z+40pN
         S/X7l0F1cxGJ/Go47mLskelyhc3CU9wQB77l8UYxQFG0PBBJpV1FhxyFnpq/yk6W7UV+
         0yuTLS6kvuzXeKbVhcGtVzV41rQkXjL84ibtRppC6OdBI2+03tUOut7xTcNqOACuZg3a
         JnUQ==
X-Gm-Message-State: AOAM5337gbvIRtmq72u2xEtXA0i7sMLv0a8iS41bACm7JlC9INC8opHI
        P6jcN2/Wfyq1NbzhNmzcZsnHl1b8wKOkhmre
X-Google-Smtp-Source: ABdhPJxtQJd8N1m9FxJzrhrWtUmckPILiJKkMATtN/xu4sMeedQLkS9CI/BH52k5YjBS5qGvjEbXmg==
X-Received: by 2002:a6b:e616:: with SMTP id g22mr32831687ioh.67.1629821773785;
        Tue, 24 Aug 2021 09:16:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c25sm10643653iom.9.2021.08.24.09.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:13 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 09/25] midx: avoid opening multiple MIDXs when writing
Message-ID: <c9fea31fa875188de5aeb66ad0dd5b64f4c941ca.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Opening multiple instance of the same MIDX can lead to problems like two
separate packed_git structures which represent the same pack being added
to the repository's object store.

The above scenario can happen because prepare_midx_pack() checks if
`m->packs[pack_int_id]` is NULL in order to determine if a pack has been
opened and installed in the repository before. But a caller can
construct two copies of the same MIDX by calling get_multi_pack_index()
and load_multi_pack_index() since the former manipulates the
object store directly but the latter is a lower-level routine which
allocates a new MIDX for each call.

So if prepare_midx_pack() is called on multiple MIDXs with the same
pack_int_id, then that pack will be installed twice in the object
store's packed_git pointer.

This can lead to problems in, for e.g., the pack-bitmap code, which does
something like the following (in pack-bitmap.c:open_pack_bitmap()):

    struct bitmap_index *bitmap_git = ...;
    for (p = get_all_packs(r); p; p = p->next) {
      if (open_pack_bitmap_1(bitmap_git, p) == 0)
        ret = 0;
    }

which is a problem if two copies of the same pack exist in the
packed_git list because pack-bitmap.c:open_pack_bitmap_1() contains a
conditional like the following:

    if (bitmap_git->pack || bitmap_git->midx) {
      /* ignore extra bitmap file; we can only handle one */
      warning("ignoring extra bitmap file: %s", packfile->pack_name);
      close(fd);
      return -1;
    }

Avoid this scenario by not letting write_midx_internal() open a MIDX
that isn't also pointed at by the object store. So long as this is the
case, other routines should prefer to open MIDXs with
get_multi_pack_index() or reprepare_packed_git() instead of creating
instances on their own. Because get_multi_pack_index() returns
`r->object_store->multi_pack_index` if it is non-NULL, we'll only have
one instance of a MIDX open at one time, avoiding these problems.

To encourage this, drop the `struct multi_pack_index *` parameter from
`write_midx_internal()`, and rely instead on the `object_dir` to find
(or initialize) the correct MIDX instance.

Likewise, replace the call to `close_midx()` with
`close_object_store()`, since we're about to replace the MIDX with a new
one and should invalidate the object store's memory of any MIDX that
might have existed beforehand.

Note that this now forbids passing object directories that don't belong
to alternate repositories over `--object-dir`, since before we would
have happily opened a MIDX in any directory, but now restrict ourselves
to only those reachable by `r->objects->multi_pack_index` (and alternate
MIDXs that we can see by walking the `next` pointer).

As far as I can tell, supporting arbitrary directories with
`--object-dir` was a historical accident, since even the documentation
says `<alt>` when referring to the value passed to this option.

A future patch could clean this up and provide a warning() when a
non-alternate directory was given, since we'll still write a new MIDX
there, we just won't reuse any MIDX that might happen to already exist
in that directory.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/midx.c b/midx.c
index 0a515d8711..3dacb31f9d 100644
--- a/midx.c
+++ b/midx.c
@@ -893,7 +893,7 @@ static int midx_checksum_valid(struct multi_pack_index *m)
 	return hashfile_checksum_valid(m->data, m->data_len);
 }
 
-static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
+static int write_midx_internal(const char *object_dir,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
 			       unsigned flags)
@@ -904,6 +904,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
+	struct multi_pack_index *cur;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
@@ -914,10 +915,12 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name);
 
-	if (m)
-		ctx.m = m;
-	else
-		ctx.m = load_multi_pack_index(object_dir, 1);
+	for (cur = get_multi_pack_index(the_repository); cur; cur = cur->next) {
+		if (!strcmp(object_dir, cur->object_dir)) {
+			ctx.m = cur;
+			break;
+		}
+	}
 
 	if (ctx.m && !midx_checksum_valid(ctx.m)) {
 		warning(_("ignoring existing multi-pack-index; checksum mismatch"));
@@ -1119,7 +1122,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
 
 	if (ctx.m)
-		close_midx(ctx.m);
+		close_object_store(the_repository->objects);
 
 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
@@ -1182,8 +1185,7 @@ int write_midx_file(const char *object_dir,
 		    const char *preferred_pack_name,
 		    unsigned flags)
 {
-	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
-				   flags);
+	return write_midx_internal(object_dir, NULL, preferred_pack_name, flags);
 }
 
 struct clear_midx_data {
@@ -1461,8 +1463,10 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 
 	free(count);
 
-	if (packs_to_drop.nr)
-		result = write_midx_internal(object_dir, m, &packs_to_drop, NULL, flags);
+	if (packs_to_drop.nr) {
+		result = write_midx_internal(object_dir, &packs_to_drop, NULL, flags);
+		m = NULL;
+	}
 
 	string_list_clear(&packs_to_drop, 0);
 	return result;
@@ -1651,7 +1655,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, m, NULL, NULL, flags);
+	result = write_midx_internal(object_dir, NULL, NULL, flags);
 	m = NULL;
 
 cleanup:
-- 
2.31.1.163.ga65ce7f831

