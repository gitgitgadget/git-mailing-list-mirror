Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F9120899
	for <e@80x24.org>; Fri, 11 Aug 2017 20:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbdHKUgV (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 16:36:21 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35383 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753401AbdHKUgU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 16:36:20 -0400
Received: by mail-pg0-f46.google.com with SMTP id v189so19615008pgd.2
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Wp879QSAwQM00W1pzjaOzT3AMYBCL6GDQaMkwsdxTFs=;
        b=hVsCQqDAM/UWAF+8aRFhczF5V5Jo/393ajBWI2mos8+2fg27lk/fO65IZwjU97OYkV
         SKHTIQPvjzK0GZ3CLqEbhE5HkJPv2/v464BuA6z+Zaj4B0te7HoYenslE4znFVz1W7NB
         4fEti+3WJL1nUe3lMWU0mXHp6/dZ5XJ5zS0nXm/ynW/gNlWY+XChVcbN9JYE29Vd+MIj
         IhdkezalmrX7sh8Jn2UEX2rJFOCjHBmgwScinpvfPxy8hfl/U4ETTf7CebxFEVNdH4Ad
         ZQHc8aYjq+rqsd3oK8X7irH0We+p+IWrsRzviXRcSbjM+fd3ebUnFWjR9wb96Ke1KjQp
         Wyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Wp879QSAwQM00W1pzjaOzT3AMYBCL6GDQaMkwsdxTFs=;
        b=AEkzzt1AB4e52yU5Yr4FlQPGhoCofl8zQENZjB0mirId998ymYisvNUSkSEYhdmm6y
         PIWF10xRxdyNayJdLZy5Xro27vqf83t1T6wT/pNSXj1O0kHAj+ca0piz1GqCKdOIuI4z
         jZ5ueukN5K7PzFgak6ln5TqsHm3r/AGRQRJZmf+f/6AjkV0m6+SqYHsyR82Pc+oeydwA
         htGwcMe59/7gwWcNUJhEgLW+HxvJ743pl4dGC/p4CUlLbvngZjGZfVSsSagNnTqVYlU8
         c9n/k0pn4DXBntVYZMXw7XwpiK8cFIVfuyM/A6D+hFIXvG/s5ez4C19fLIAaKIrqmTly
         G4bg==
X-Gm-Message-State: AHYfb5hQK9ugaQzNZ0m6svqnm7ZHj9L/FTHQfMsdfMFsMw5wvq59Nj1h
        T352CmWG0a1CEGzSh6vODg==
X-Received: by 10.84.178.4 with SMTP id y4mr18748379plb.135.1502483779418;
        Fri, 11 Aug 2017 13:36:19 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id z189sm2712139pgb.12.2017.08.11.13.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Aug 2017 13:36:18 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH 1/2] sha1_file: set whence in storage-specific info fn
Date:   Fri, 11 Aug 2017 13:36:14 -0700
Message-Id: <6fbc67183251a852f635154121fcf0f1006310d6.1502483486.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502483486.git.jonathantanmy@google.com>
References: <cover.1502483486.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502483486.git.jonathantanmy@google.com>
References: <xmqqfucz11yb.fsf@gitster.mtv.corp.google.com> <cover.1502483486.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the setting of oi->whence to sha1_loose_object_info() and
packed_object_info().

This allows sha1_object_info_extended() to not need to know about the
delta base cache. This will be useful during a future refactoring in
which packfile-related functions, including the handling of the delta
base cache, will be moved to a separate file.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sha1_file.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b60ae15f7..910109fd9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2444,6 +2444,9 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 			hashclr(oi->delta_base_sha1);
 	}
 
+	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
+							  OI_PACKED;
+
 out:
 	unuse_pack(&w_curs);
 	return type;
@@ -2973,6 +2976,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
 	strbuf_release(&hdrbuf);
+	oi->whence = OI_LOOSE;
 	return (status < 0) ? status : 0;
 }
 
@@ -3010,10 +3014,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags)) {
-			oi->whence = OI_LOOSE;
+		if (!sha1_loose_object_info(real, oi, flags))
 			return 0;
-		}
 
 		/* Not a loose object; someone else may have just packed it. */
 		if (flags & OBJECT_INFO_QUICK) {
@@ -3036,10 +3038,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
 		return sha1_object_info_extended(real, oi, 0);
-	} else if (in_delta_base_cache(e.p, e.offset)) {
-		oi->whence = OI_DBCACHED;
-	} else {
-		oi->whence = OI_PACKED;
+	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
 		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
-- 
2.14.0.434.g98096fd7a8-goog

