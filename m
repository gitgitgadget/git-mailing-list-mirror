Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD3C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352576AbiHSVag (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352560AbiHSVaU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:30:20 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F42A105236
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:18 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id n14so1021148qvq.10
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=/gi8CYbMyQmjBWk4p4hGJoYwPgWEnR36155X72Fh47g=;
        b=dD6EZGhCEpeR4joidHuaDLu6zfGPmL/KOdxPzRoq1qQa0I60lUx+R2sOlbzWMmXNHU
         of/r+rH8iiwQW0HRLaYPvfi8pGAV814xWJzIxmY/HbjjxcKyW3I1JXiSKgA0MyStJMQ3
         g4Qj7ih3DkikckOh4Uv4rrZdcfQugVL9Id0TQBcVwv9PD19cgwO2F0zLg0KzW58FSogt
         4XzO2tYEhTQxdctvGX7cISXqMaHbJADq4MXgSJ98KwyUSq27SyPslt3nGBHwWidl+x6K
         drJZaeyXvM2z+lVSeOfq+uU1qIqrRYfHhyyYmHRWXUcLOHOA9L+33pfcUM81ylz3Y5R+
         VN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/gi8CYbMyQmjBWk4p4hGJoYwPgWEnR36155X72Fh47g=;
        b=cuTsK0b4kn4mOfC7VEUf/hhuweaP+cQNtl6ZC6J98JL3ORQdnU5D+Fz9hbWYmrT1vF
         SwjCKy9t+rEuYmdOAGFCJ6rpqMmg7WM8WY4i02kdZn4UPkxQgx0TNQJkXwMEg9DBfbQj
         rK0iIzugk6sFAa0uk1Loqq6iY2mOOCCs/5FrdE8d2fkw0pdg/fp/fkrX/7uYvqBMZjC+
         hDyyY+j5NBsph5KGaj9tvVXz3xaTiWEWxcjH3Y1oovN4X0NYUSzP+llGDn3wjhWX0aWg
         xaJgPKKPr9bL0LWAQQDNA/vawRPqsEEybMdMEX4OhTOJpMwqlQVcSiPQmmJaAdfvEsk1
         /sEw==
X-Gm-Message-State: ACgBeo0BEdtu9e7zngk56+l9DVkhS5xkFWbJyi4DXgm7RaEQcG5sJ7Qh
        fwmq7mJDaGcE6w4nWFinf7eZxMiPl3z+uSKa
X-Google-Smtp-Source: AA6agR4N31Eb6+OEKrPf55f4/E7gcUtWGibg4OeWNnfqPdQMVSAzYNOODGCMGoRToTACRUsifDMXxg==
X-Received: by 2002:a05:6214:411e:b0:474:991e:37bd with SMTP id kc30-20020a056214411e00b00474991e37bdmr8060771qvb.125.1660944617005;
        Fri, 19 Aug 2022 14:30:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q10-20020a05620a0d8a00b006b9b319adacsm4544720qkl.126.2022.08.19.14.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:30:16 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:30:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH 3/6] midx.c: extract `struct midx_fanout`
Message-ID: <2df8f1e8843ff7b53f45d99da5f8dbbbd3415b9e.1660944574.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1660944574.git.me@ttaylorr.com>
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

