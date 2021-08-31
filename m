Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF83C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C5A61026
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbhHaUxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbhHaUxH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266B0C061764
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:11 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id g9so741994ioq.11
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xml83dDhotBELRc4X2XFpr0Il4GpSkXu+BGRGXaC2ao=;
        b=o23Nxaf1rQuwQoOE4ljzNL4R1PENhvSRgfq8v6uxRfaD642GahnddzlKZs+sqrGioJ
         SYNqcmZku9DK0SdVCHDXSDDKa5FUuW67pnLqZQVpQTN1NqTMUi6lyuon1PsJSbcwzt4K
         heX9dcYtl8Bc9wUXZmxTjX3jp0h1bG0hYkAFVJqTxFoXncytPW2IWvSmx+7kym5hOeqq
         og/s/v5Vzz9F+FT1L8LJKPmxMJQVhynGa71HCkVzAdpAZQX4XPCNAgeYZun0e7/rIdmx
         7V4Z8yyhHauKYg18Nu7WbEOO05pjlNN3vMCMAbQ+R+s82o69R3GB2Z2iU4LEhtFzph+5
         WlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xml83dDhotBELRc4X2XFpr0Il4GpSkXu+BGRGXaC2ao=;
        b=oH1ahuETbJ3gzo1Zcj7/LoK4dt0LG/OYKHZKAEnjlU0h36fJSbT8h0fHXYkQX2mKfj
         3ajEWEZUOccvehWoiTXCY6N9kAIE+NDXA7JXOW1DQNKZiWHFPXW0eNz5qUTHBLLn+NTA
         dyWwWPOSYvWOEne4v/dLDDQIzwwcSWbn2PfLH2q4+GGq55Y+I7MhDZRsIh9HTKWkWC4a
         7XBKpx/c8yll7WRyIaXQ7a54IHIIR3IsaOXmMoag62jfkfQ4bQ6m9k1dq1rU/i9CD5QR
         SnlGjhKGql1grWwBemYjlSLnAkUK0m7fSLrVZ9u4czGSKnHpTknh0OQLQ7RWGlpotO3G
         JzMQ==
X-Gm-Message-State: AOAM530wP8Mh8yR5WwmXwUBCVhiT37Nw8RxJub0qrxSUtwS7etPsaCjT
        YBBtyQT6ATYU3jWad6N0Rf5whIcZOEr6CbVR
X-Google-Smtp-Source: ABdhPJwh4tIQZkunH2hxD/s60jrxSjeHj9hzoA1LqwXD2N0lOE13eWixb1NFT9oX7AOh8M+PEPOCcA==
X-Received: by 2002:a02:c7d2:: with SMTP id s18mr4699811jao.22.1630443130431;
        Tue, 31 Aug 2021 13:52:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f6sm10893105ilr.77.2021.08.31.13.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:10 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 11/27] midx: avoid opening multiple MIDXs when writing
Message-ID: <4656608f7350a059748c75c5ed8731cb66a52d9b.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
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
 Documentation/git-multi-pack-index.txt |  2 ++
 midx.c                                 | 26 +++++++++++++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index c9b063d31e..0af6beb2dd 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -23,6 +23,8 @@ OPTIONS
 	Use given directory for the location of Git objects. We check
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
 	`<dir>/packs` for the pack-files to index.
++
+`<dir>` must be an alternate of the current repository.
 
 --[no-]progress::
 	Turn progress on/off explicitly. If neither is specified, progress is
diff --git a/midx.c b/midx.c
index e83f22b5ee..43510290dc 100644
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
2.33.0.96.g73915697e6

