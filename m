Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8732B1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 01:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbdFTBDY (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 21:03:24 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34045 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbdFTBDX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 21:03:23 -0400
Received: by mail-pf0-f173.google.com with SMTP id s66so61597101pfs.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 18:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zLz5B+EozbQNdRg8tPdpPA+a7AmV30XrGgm9PacoIf8=;
        b=EHK9t4BBSdgKVr/H2/Pi787+Y5BEBUFfwaCOmSQ0Ugc/3N+vFt4P/MK+aqAPLZvAhg
         g6iuNhzwJWfIsRb44r0KP372uxK6qMreaYnfGQGUSaSodmZwemgyDYU1lLP8YLtzClba
         XMcAPGud2U8sruP2K9/75bRsLN/G3ZNjSNDUZRqnKRPTf4XlbA6P8Mde7tU2TZRfWNQV
         O/EFa5AWhFJ8+KnPewE1EUmmvIobS+g9QzfOZjDV9tQ4XrWpgHjgwDyve3omzjJg1P6a
         6oGqEaAsatcZ9BZysymgXVPnLjP1NKkfr58lckZFUJ2bm4yN0VaOxl2yuvYxudtNjiRn
         OAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zLz5B+EozbQNdRg8tPdpPA+a7AmV30XrGgm9PacoIf8=;
        b=lwkdL/cywySqLDzd/Wbd8w8w6sJGJiyjLqAxvkMeNFy25axef+UhGYTV9qmo/pkdY9
         AzKBvfnRcpM6aCQ+ocPmVmNfiEaqg9Le2DByn5iN2ND5wq+r9ljf2Wh3UcRBUDWgPSBL
         0qMWr4FyXvG+EiOQXrirNTBiwO+c7KCB0iejNQiGDBfkDkRH24l5rxM+GPKXXZi6+72c
         Ts8I+mmjTx+wUAENQYk5PylPOkAqNpQBbw3kul+//kbvHggqeMQqIUHzcqpfqL4pUClu
         rJChuR0mfvSwERrmPFUE8gschuUK3uR+yCwaSH0+z/5xemyTcfwd2UwrGzRKuxGtscTf
         CHvA==
X-Gm-Message-State: AKS2vOymUG4jX3AelECB9Ltd0m/HiX1ELlSBDWuRK1iqokUFT9ARPach
        W7Ze7AMu3M9szi5Vocs7tQ==
X-Received: by 10.101.73.135 with SMTP id r7mr28646895pgs.224.1497920602543;
        Mon, 19 Jun 2017 18:03:22 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id l63sm22249819pfc.132.2017.06.19.18.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 18:03:21 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 1/8] sha1_file: teach packed_object_info about typename
Date:   Mon, 19 Jun 2017 18:03:08 -0700
Message-Id: <e7a79c114b7131ba286bf3f76789b2efaeeb1cf1.1497920092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497920092.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497920092.git.jonathantanmy@google.com>
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
2.13.1.611.g7e3b11ae1-goog

