Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D64C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbiHVTuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbiHVTum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:50:42 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E064D4F5
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:40 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id n21so8738027qkk.3
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=/gi8CYbMyQmjBWk4p4hGJoYwPgWEnR36155X72Fh47g=;
        b=IXMMlQcGg3zwQSBKMoRfQTmb0yNLb7ZMc84IAr/23DlDkoAEWW8EU01326kXD60YIj
         hcDXphij//afb+/JSayUzdmAXL6AT/CB//HCjsG3HrYtlStVdpjkmf52pxqPYViG/LRX
         KdNVAsALi2B9YE9NcE+aOr7C8GVmRYqo7jmoisuThEBDVnlwWSjA4B1yJMutlgChO6u9
         0PaPVtVD8Vkrmmrf4oOYNKp0YqnbayfQIGv/lngmmOJM1Pt/9vAiIp2OzEOY9mAQ/Ig3
         8tG+7eC7QHR+aaA5HxiHSKbuKupvNLzbVV2XoFxGhW4M1ROuNc2vA/gGxVGsykAF/XSX
         1OgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/gi8CYbMyQmjBWk4p4hGJoYwPgWEnR36155X72Fh47g=;
        b=nsr1OqRTlxhmrcwutBK/uGbc5jVdTLFwjeBpp1BLskXM2JvNEVBe5Y6PqRy2Xcnx7u
         qdWqpqn0oHsa1y+5zn++qhQad8mhQ7PBgn5ErGk2MRdhFIJweHn8Cu5DVf5nsfpeskWz
         DNkJyVmUBIDnal9pBOW2hLwE+gf8c3VdOiZUm3Br/myzH89NkXuyTDVUkyRYSu8m2EJl
         yNBIkz1aEUz+JziSGcsr0Se+ZpzxuqrS3w9fOxUEzv/W56tZfcYvoij/st3APtKbrzNN
         kiqTje2TCNgaoq4IzBjJSxDSvFZebsKLKUz8gXaIYpz42teKhX9UXsgrwzZc9h3m5FBp
         xH2A==
X-Gm-Message-State: ACgBeo0UBEyMH8RDWvufUkdf+cCgAAp4NbTChm5VxNM6Des616TxOEtF
        PKPyeKRJ1MpK6VRvfLP6hsbnu5QDo0zr8YCT
X-Google-Smtp-Source: AA6agR6O6RLk3bDJePopqkMB6BsWMF2kX4VHBCtZaUqJidMSicc6VQqcgDuXTzYWiFfmQlL1xUA4nw==
X-Received: by 2002:a05:620a:1402:b0:6bc:2055:6da0 with SMTP id d2-20020a05620a140200b006bc20556da0mr3322017qkj.534.1661197839429;
        Mon, 22 Aug 2022 12:50:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t201-20020a37aad2000000b006bacf4703c5sm12131074qke.111.2022.08.22.12.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:50:39 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:50:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH v2 3/7] midx.c: extract `struct midx_fanout`
Message-ID: <ae2077acb795311c87ce3bbcef60bffb66a6aa79.1661197803.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
 <cover.1661197803.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1661197803.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To build up a list of objects (along with their packs, and the offsets
within those packs that each object appears at), the MIDX code
implements `get_sorted_entries()` which builds up a list of candidates,
sorts them, and then removes duplicate entries.

To do this, it keeps an array of `pack_midx_entry` structures that it
builds up once for each fanout level (ie., for all possible values of
the first byte of each object's ID).

This array is a function-local variable of `get_sorted_entries()`. Since
it uses the ALLOC_GROW() macro, having the `alloc_fanout` variable also
be local to that function, and only modified within that function is
convenient.

However, subsequent changes will extract the two ways this array is
filled (from a pack at some fanout value, and from an existing MIDX at
some fanout value) into separate functions. Instead of passing around
pointers to the entries array, along with `nr_fanout` and
`alloc_fanout`, encapsulate these three into a structure instead. Then
pass around a pointer to this structure instead.

This patch does not yet extract the above two functions, but sets us up
to begin doing so in the following commit. For now, the implementation
of get_sorted_entries() is only modified to replace `entries_by_fanout`
with `fanout.entries`, `nr_fanout` with `fanout.nr`, and so on.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 54 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/midx.c b/midx.c
index 4e956cacb7..cdb6c481c7 100644
--- a/midx.c
+++ b/midx.c
@@ -577,6 +577,22 @@ static void fill_pack_entry(uint32_t pack_int_id,
 	entry->preferred = !!preferred;
 }
 
+struct midx_fanout {
+	struct pack_midx_entry *entries;
+	uint32_t nr;
+	uint32_t alloc;
+};
+
+static void midx_fanout_grow(struct midx_fanout *fanout, uint32_t nr)
+{
+	ALLOC_GROW(fanout->entries, nr, fanout->alloc);
+}
+
+static void midx_fanout_sort(struct midx_fanout *fanout)
+{
+	QSORT(fanout->entries, fanout->nr, midx_oid_compare);
+}
+
 /*
  * It is possible to artificially get into a state where there are many
  * duplicate copies of objects. That can create high memory pressure if
@@ -595,8 +611,8 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						  int preferred_pack)
 {
 	uint32_t cur_fanout, cur_pack, cur_object;
-	uint32_t alloc_fanout, alloc_objects, total_objects = 0;
-	struct pack_midx_entry *entries_by_fanout = NULL;
+	uint32_t alloc_objects, total_objects = 0;
+	struct midx_fanout fanout = { 0 };
 	struct pack_midx_entry *deduplicated_entries = NULL;
 	uint32_t start_pack = m ? m->num_packs : 0;
 
@@ -608,14 +624,14 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 	 * slices to be evenly distributed, with some noise. Hence,
 	 * allocate slightly more than one 256th.
 	 */
-	alloc_objects = alloc_fanout = total_objects > 3200 ? total_objects / 200 : 16;
+	alloc_objects = fanout.alloc = total_objects > 3200 ? total_objects / 200 : 16;
 
-	ALLOC_ARRAY(entries_by_fanout, alloc_fanout);
+	ALLOC_ARRAY(fanout.entries, fanout.alloc);
 	ALLOC_ARRAY(deduplicated_entries, alloc_objects);
 	*nr_objects = 0;
 
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
-		uint32_t nr_fanout = 0;
+		fanout.nr = 0;
 
 		if (m) {
 			uint32_t start = 0, end;
@@ -625,15 +641,15 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 			end = ntohl(m->chunk_oid_fanout[cur_fanout]);
 
 			for (cur_object = start; cur_object < end; cur_object++) {
-				ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
+				midx_fanout_grow(&fanout, fanout.nr + 1);
 				nth_midxed_pack_midx_entry(m,
-							   &entries_by_fanout[nr_fanout],
+							   &fanout.entries[fanout.nr],
 							   cur_object);
 				if (nth_midxed_pack_int_id(m, cur_object) == preferred_pack)
-					entries_by_fanout[nr_fanout].preferred = 1;
+					fanout.entries[fanout.nr].preferred = 1;
 				else
-					entries_by_fanout[nr_fanout].preferred = 0;
-				nr_fanout++;
+					fanout.entries[fanout.nr].preferred = 0;
+				fanout.nr++;
 			}
 		}
 
@@ -646,36 +662,36 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 			end = get_pack_fanout(info[cur_pack].p, cur_fanout);
 
 			for (cur_object = start; cur_object < end; cur_object++) {
-				ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
+				midx_fanout_grow(&fanout, fanout.nr + 1);
 				fill_pack_entry(cur_pack,
 						info[cur_pack].p,
 						cur_object,
-						&entries_by_fanout[nr_fanout],
+						&fanout.entries[fanout.nr],
 						preferred);
-				nr_fanout++;
+				fanout.nr++;
 			}
 		}
 
-		QSORT(entries_by_fanout, nr_fanout, midx_oid_compare);
+		midx_fanout_sort(&fanout);
 
 		/*
 		 * The batch is now sorted by OID and then mtime (descending).
 		 * Take only the first duplicate.
 		 */
-		for (cur_object = 0; cur_object < nr_fanout; cur_object++) {
-			if (cur_object && oideq(&entries_by_fanout[cur_object - 1].oid,
-						&entries_by_fanout[cur_object].oid))
+		for (cur_object = 0; cur_object < fanout.nr; cur_object++) {
+			if (cur_object && oideq(&fanout.entries[cur_object - 1].oid,
+						&fanout.entries[cur_object].oid))
 				continue;
 
 			ALLOC_GROW(deduplicated_entries, *nr_objects + 1, alloc_objects);
 			memcpy(&deduplicated_entries[*nr_objects],
-			       &entries_by_fanout[cur_object],
+			       &fanout.entries[cur_object],
 			       sizeof(struct pack_midx_entry));
 			(*nr_objects)++;
 		}
 	}
 
-	free(entries_by_fanout);
+	free(fanout.entries);
 	return deduplicated_entries;
 }
 
-- 
2.37.0.1.g1379af2e9d

