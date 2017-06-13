Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C3E1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbdFMVGN (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:06:13 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34505 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbdFMVGM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:06:12 -0400
Received: by mail-io0-f179.google.com with SMTP id i7so81390236ioe.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rpTPV9xDT9DY624zyVASu39xQy1FuS4rtMr7LYL8e8A=;
        b=LrivOKtGZXSwnOWp3XQVCv4bj0ra2bHgH0zGHZyckKsgSDLZA+kL9v/dR4OnmPbLRh
         wK/DRK7XardcdJP9QLTjcPIVGVOJDhCxh4DhvXpSsBvCQap0M5uFDyXe2jWB1EXqw81C
         U67QfQxHxNwis9ezh37+UKVAbcRXcPnCdE8E1UaXkOooM18jQPBqGUYO280hsdqkm4ab
         RlJ0DeIRklV4jywPbq+xo6QuxVsvOzQwZmH2gYCtcJAH718/CBaoQxp3aDJuswFW6il1
         7vSodjYXCV86YuPcgJaYZqkB4CkZgXGH80dTFr8m7pIMBZglMMzx46L5fgCJM0d7Guth
         HG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rpTPV9xDT9DY624zyVASu39xQy1FuS4rtMr7LYL8e8A=;
        b=qtHDqTmJ2jWR3LQw2y84OTW3fbxM5XyUWnQi+v+3+askWcKYTYKKoZ6m1OajTERc/4
         c0EjyrHL7mdxxAwm1hgufgOT9x7hNRMCZBKg+/xtbbpVn8jHUw8S9TiOS9s+mznRuL68
         nZJU7Rms+Z4nuLOf80ZAwQ1DGIXlXVBwaNHqCc4Ve0bV1ySGWcPwe/Su+bROyy0pUhAa
         A4kBy3fsRJvP8P4Zfq2iGeMDDey4GzsM9sLX5dOTDkzwpmRtappZwh+FRc9/R2tMxopR
         6eUSK9w9l69X82OPfJHgHncq5Jp/FniXU5XNBJgzU4BhR6ZEwYHkbo4bODxd/GIx2O0O
         5OOQ==
X-Gm-Message-State: AKS2vOxDaubz1i5eC789Rw6lBWoY2tin2JC22rQhYThNlityAQIg1PMB
        0VUXnzUaGe2IZAV/Iih+xQ==
X-Received: by 10.107.134.91 with SMTP id i88mr2397915iod.53.1497387971079;
        Tue, 13 Jun 2017 14:06:11 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id d185sm6885228ioe.38.2017.06.13.14.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:06:10 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v2 1/4] sha1_file: teach packed_object_info about typename
Date:   Tue, 13 Jun 2017 14:05:57 -0700
Message-Id: <e7a79c114b7131ba286bf3f76789b2efaeeb1cf1.1497387714.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <cover.1497387713.git.jonathantanmy@google.com>
References: <cover.1497387713.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497387713.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497387713.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 46f0344 ("sha1_file: support reading from a loose object of
unknown type", 2015-05-06), "struct object_info" gained a "typename"
field that could represent a type name from a loose object file, whether
valid or invalid, as opposed to the existing "typep" which could only
represent valid types. Some relatively complex manipulations were added
to avoid breaking packed_object_info() without modifying it, but it is
much easier to just teach packed_object_info() about the new field.
Therefore, teach packed_object_info() as described above.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sha1_file.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 59a4ed2ed..a52b27541 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2277,9 +2277,18 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 		*oi->disk_sizep = revidx[1].offset - obj_offset;
 	}
 
-	if (oi->typep) {
-		*oi->typep = packed_to_object_type(p, obj_offset, type, &w_curs, curpos);
-		if (*oi->typep < 0) {
+	if (oi->typep || oi->typename) {
+		enum object_type ptot;
+		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
+					     curpos);
+		if (oi->typep)
+			*oi->typep = ptot;
+		if (oi->typename) {
+			const char *tn = typename(ptot);
+			if (tn)
+				strbuf_addstr(oi->typename, tn);
+		}
+		if (ptot < 0) {
 			type = OBJ_BAD;
 			goto out;
 		}
@@ -2960,7 +2969,6 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
-	enum object_type real_type;
 	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
 
 	co = find_cached_object(real);
@@ -2992,18 +3000,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			return -1;
 	}
 
-	/*
-	 * packed_object_info() does not follow the delta chain to
-	 * find out the real type, unless it is given oi->typep.
-	 */
-	if (oi->typename && !oi->typep)
-		oi->typep = &real_type;
-
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
-		if (oi->typep == &real_type)
-			oi->typep = NULL;
 		return sha1_object_info_extended(real, oi, 0);
 	} else if (in_delta_base_cache(e.p, e.offset)) {
 		oi->whence = OI_DBCACHED;
@@ -3014,10 +3013,6 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
 					 rtype == OBJ_OFS_DELTA);
 	}
-	if (oi->typename)
-		strbuf_addstr(oi->typename, typename(*oi->typep));
-	if (oi->typep == &real_type)
-		oi->typep = NULL;
 
 	return 0;
 }
-- 
2.13.1.518.g3df882009-goog

