Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48D0A20899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdHIBX3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:29 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34331 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbdHIBXU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:20 -0400
Received: by mail-pg0-f50.google.com with SMTP id u185so21605756pgb.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kMwf/I//QSRwQHKO9sTG4UOjISDL06QZttAOJJ+wWKs=;
        b=OKMAib3E3kyYVe2LSED3SFS6EdbnwI6psNL3tm7MxVH9YdBoOsmJbjkgkkIMyO9gvj
         NfReGSGv8HqZ37nHK7evoxBm0jlc+GzHo+n+Y7HJ9HRVnNiuPcuUmcFLyNLezZvL7MMs
         ohVqSaqabf6ENJhW2jfMTkmIc4cjOgV1333OfhfXAOMQoxIBw/plyJQGbBxPVqNerZf2
         XCFILwZ4hxqKkgWeCK47FZ1TbY8nKDwTFRFYRTWygUKV5WD1Xwzk2T1/c5zFmGAWqyT2
         2muXLxhI8cshXd85E5cZ3nf4egZrDlhJQJN6clRa3vyaaGfpYk2lEYo8C57OY30lYr5l
         QHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kMwf/I//QSRwQHKO9sTG4UOjISDL06QZttAOJJ+wWKs=;
        b=IUi2lIeAIxPvRwPRrCO7ZdtUR3WT2HEDYcOtOB6nvBNoBN35Ih6H7WV+3FuvaMXS0W
         A+U5JsO512lMX/In8ukZcpLvz//hDOd41XTeDGfNzUzeu2NYkpbU0n/FBnwTmLLGWyOL
         e+KpvrsKmym48bLsENlhzG6arxdJEKVlb4+4l3CO8gDfImWZoIqXqv7CO1pd3XAoi/LR
         9hJ+9Ig58B7dTF648BiOyTMiiOF664Djth5FEpjGJJSUIPiUBFzjA4eTyjOdBodLFTnl
         kgvCIfJBiA2RGVbTNM1j7ScjTrGsT4epeQ3YMACN6uy9A5NmTtRmeFA9B95QE3+CYnbR
         5vmw==
X-Gm-Message-State: AHYfb5iuOj5WvklMaqqLLQpwYKPH38sEGt7brHQGko5Badj+fLMue7Kq
        gpDcSxJdyC5RT9uXiCns6g==
X-Received: by 10.98.8.93 with SMTP id c90mr6393927pfd.237.1502241799694;
        Tue, 08 Aug 2017 18:23:19 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:18 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 15/25] sha1_file: set whence in storage-specific info fn
Date:   Tue,  8 Aug 2017 18:22:47 -0700
Message-Id: <24f10480b473f7fd2775184fa0693668163dc8e5.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the setting of oi->whence to sha1_loose_object_info() and
packed_object_info(). This allows sha1_object_info_extended() to not
need to know about the delta base cache.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sha1_file.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f3bcdae17..9eadda388 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1473,6 +1473,9 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 			hashclr(oi->delta_base_sha1);
 	}
 
+	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
+							  OI_PACKED;
+
 out:
 	unuse_pack(&w_curs);
 	return type;
@@ -2002,6 +2005,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
 	strbuf_release(&hdrbuf);
+	oi->whence = OI_LOOSE;
 	return (status < 0) ? status : 0;
 }
 
@@ -2039,10 +2043,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags)) {
-			oi->whence = OI_LOOSE;
+		if (!sha1_loose_object_info(real, oi, flags))
 			return 0;
-		}
 
 		/* Not a loose object; someone else may have just packed it. */
 		if (flags & OBJECT_INFO_QUICK) {
@@ -2065,10 +2067,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
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

