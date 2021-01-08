Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753A7C43217
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520B123A7B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbhAHSSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbhAHSSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:23 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD6C0612A7
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:18:00 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q137so10623844iod.9
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lWyQSLMWGYK3VB2Z8idCthw32Pu7mSVUrKnWDgsJ440=;
        b=J0AX+GYpolhR5IosLZlsNZkGOt4nKiz/9YlGva+vQBBrx/Y9xSOQsaKc8oAx+OVNe/
         2DGOcGj7rbKxKPZffmCvoanIYXP+tfNtRwf/RXMGNggw4W+Ua20zAN8wQt7pj4zP+53I
         xBNhxUWiZOELcpfdpDYSuthYdQz7xrbKOo25Rg6T6rKPr6zsl+xuFX9/SWpqEObQfU6M
         y+nbAGChp0guKcKHrI6yehL++Va/9E1la71RzHWLgWi6ouqji3Fr9WMY9aKTAha+lxkN
         UgwvG0SkNeYDREicSQikzjYsjUv7oYyLZgNQM9ArR8ey2Ukk6U3F9rFeWr7qxat3wAsl
         85EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lWyQSLMWGYK3VB2Z8idCthw32Pu7mSVUrKnWDgsJ440=;
        b=Eb1volvtNz8qXZ/xCui/Qm+Q3eE5JWewhjtQaevp52+hxGXm+McXUMUexOIMFwCAxB
         NC+RMDMBpBM1VhfvRKzEalhloqjiW61w/rqor8WhYWvjkASBZmgKq96s+3+vCOCbOQbo
         lNYDKg3PhvkC4E/yRYk7y6/q07AGG4vlIymttc1N5r7OEOJL6YqWzdAgLQ+Yr83ItIwt
         jJZmGzygLZa6Izv57jkxv0sqJFgdXzZbpYBaTZadhRGiIZxwMNXSjLDd/zGj8ZQBKqOF
         FuH1bb1s8AR0Chg1vllBY3Q1IeK19Y0e3hnZbf5YQ3duMiElfXVIf+ibT9ruZ/Is2tf9
         f3og==
X-Gm-Message-State: AOAM531FDbNNrNKdklXV71U/G9ran25nlKqMtkEfOwcPpy6ssVukRg2R
        sHfJRUNhg1B7PJ0UPCIKgFeXGEGCSUgsIQ==
X-Google-Smtp-Source: ABdhPJxbCihFuA9YlNw/twlvKVPqwddytuuKEo1qTYGAcj24CmIFNsjJAOnttAi1kZVKXCb0bMVaXw==
X-Received: by 2002:a5d:8483:: with SMTP id t3mr6409209iom.35.1610129879731;
        Fri, 08 Jan 2021 10:17:59 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id k15sm67456ilp.10.2021.01.08.10.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:59 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 18/20] pack-revindex: remove unused 'find_revindex_position()'
Message-ID: <d60411d524656f4680ac578765b2a8704325a060.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that all 'find_revindex_position()' callers have been removed (and
converted to the more descriptive 'offset_to_pack_pos()'), it is almost
safe to get rid of 'find_revindex_position()' entirely. Almost, except
for the fact that 'offset_to_pack_pos()' calls
'find_revindex_position()'.

Inline 'find_revindex_position()' into 'offset_to_pack_pos()', and
then remove 'find_revindex_position()' entirely.

This is a straightforward refactoring with one minor snag.
'offset_to_pack_pos()' used to load the index before calling
'find_revindex_position()'. That means that by the time
'find_revindex_position()' starts executing, 'p->num_objects' can be
safely read. After inlining, be careful to not read 'p->num_objects'
until _after_ 'load_pack_revindex()' (which loads the index as a
side-effect) has been called.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 29 +++++++++++------------------
 pack-revindex.h |  1 -
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 4e42238906..9392c4be73 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -169,16 +169,23 @@ int load_pack_revindex(struct packed_git *p)
 	return 0;
 }
 
-int find_revindex_position(struct packed_git *p, off_t ofs)
+int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 {
 	int lo = 0;
-	int hi = p->num_objects + 1;
-	const struct revindex_entry *revindex = p->revindex;
+	int hi;
+	const struct revindex_entry *revindex;
+
+	if (load_pack_revindex(p) < 0)
+		return -1;
+
+	hi = p->num_objects + 1;
+	revindex = p->revindex;
 
 	do {
 		const unsigned mi = lo + (hi - lo) / 2;
 		if (revindex[mi].offset == ofs) {
-			return mi;
+			*pos = mi;
+			return 0;
 		} else if (ofs < revindex[mi].offset)
 			hi = mi;
 		else
@@ -189,20 +196,6 @@ int find_revindex_position(struct packed_git *p, off_t ofs)
 	return -1;
 }
 
-int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
-{
-	int ret;
-
-	if (load_pack_revindex(p) < 0)
-		return -1;
-
-	ret = find_revindex_position(p, ofs);
-	if (ret < 0)
-		return -1;
-	*pos = ret;
-	return 0;
-}
-
 uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
 {
 	if (!p->revindex)
diff --git a/pack-revindex.h b/pack-revindex.h
index 07c1a7a3c8..b5dd114fd5 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -9,7 +9,6 @@ struct revindex_entry {
 };
 
 int load_pack_revindex(struct packed_git *p);
-int find_revindex_position(struct packed_git *p, off_t ofs);
 
 int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos);
 uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
-- 
2.30.0.138.g6d7191ea01

