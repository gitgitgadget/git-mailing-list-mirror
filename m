Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB5D1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeBFAJY (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:09:24 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45410 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeBFAJV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:09:21 -0500
Received: by mail-pl0-f68.google.com with SMTP id p5so95226plo.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Aq1VKhGhxnVvGIbP2rwvoZDe9/C3Ix33GZcXrFJJapk=;
        b=CvI3ncpWDxitFiUaZBYoIEoeVb3bRb7CA7pbPOmDKnFkjce7gor8ls7hEk9ML9w7dD
         rtG1tzU3ewX4ld57DoYnV1pEyy0iza57CP8gJPRbNt8InuAFt8Xz9Mr5aLK9Jx1I5OZa
         xdSf3o2XQM1C7ZGnbis4WpBf56SoI7saX5K8zOykR3/f6uEKlBE8MBt6/OnjtxvKLaa4
         TLI//7NkNIMDbZcb1y0AwNpCBFMuF/RDlhIfSDVRrDzIMdFcaoR1nqiBFfbPTIbsC0Rs
         fWb4t8G8Bi+8bSCPTgqjx8fL5IEFgHvORS5c1j9C56eIMQXWWKjsI7iTgj90qPMvfYsQ
         OEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Aq1VKhGhxnVvGIbP2rwvoZDe9/C3Ix33GZcXrFJJapk=;
        b=QNBUBwVMY+Cq64lw0xyiZ/EBihqL9nzfGfMnOlyFpOY0EfhVCwQibhpMgar6t0a+iu
         l4eciIm+BNeI8Gf2tq/WWGgtrirnqm2OD1lIR5TnYzt7dd+NPfTZi3nBOG0PziLb0vdN
         i3YNRcZOTUW4CVlTBiDSeMg0UrTtEQh7cVkJalpKCavy3H1T7dhv0eL9fisDAe5ACMPK
         Nh5yzeJBdSOSQqP8maDJxZu/pSsdntbam5HGYB0ffOz80zxiN8YXIppg1mT8z/7q2JO6
         baXIvmk+1xEHkHrws0rget7iIsppGBVUS6sYqd8YA/CNyusfj9R7GOLMfCqYNdz4re8/
         1RCg==
X-Gm-Message-State: APf1xPAMV+f8bAGSUSMJjcNmj0cMwrC4ciO0QE1q4UhsWhuZl2OCJNtX
        JTX0AQ/A23U3unvRX1ifDeCOXzvtzwI=
X-Google-Smtp-Source: AH8x225TK5xHy99HGUwd/BBY1GeN1vZNFyebfdJCyxUDAqN1wEWv1n1smmz4id2VSIJlZlVLYfZoPw==
X-Received: by 2002:a17:902:9895:: with SMTP id s21-v6mr499978plp.297.1517875760382;
        Mon, 05 Feb 2018 16:09:20 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o2sm14870973pgq.87.2018.02.05.16.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:09:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 072/194] packfile: add repository argument to cache_or_unpack_entry
Date:   Mon,  5 Feb 2018 15:55:33 -0800
Message-Id: <20180205235735.216710-52-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of cache_or_unpack_entry
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 69a1cedbe1..9f7ca8f211 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1250,7 +1250,8 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 	free(ent);
 }
 
-static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
+#define cache_or_unpack_entry(r, p, bo, bs, t) cache_or_unpack_entry_##r(p, bo, bs, t)
+static void *cache_or_unpack_entry_the_repository(struct packed_git *p, off_t base_offset,
 	unsigned long *base_size, enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
@@ -1324,7 +1325,7 @@ int packed_object_info_the_repository(struct packed_git *p, off_t obj_offset,
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(p, obj_offset, oi->sizep,
+		*oi->contentp = cache_or_unpack_entry(the_repository, p, obj_offset, oi->sizep,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
-- 
2.15.1.433.g936d1b9894.dirty

