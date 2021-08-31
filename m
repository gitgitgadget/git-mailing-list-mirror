Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B410AC43214
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8CC61053
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbhHaUxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbhHaUxL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:11 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011DEC0617AD
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:16 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id z2so812965iln.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zq/v/JdXgximi7tjH/gLOQeRUsYSH2LAxO/CeqbSkrw=;
        b=OAlMxIP0bsyUzTf1mdZYs6sb9hmbjnrLeHVv74phJ+ZYbSIJAWZ6eXxJJvFjaerk2D
         b3yt49v6Pa9aqJ8WP6CiNlSQ5gXkL2BnJgvyPwcjqpRcZgboHZ86FRumm2Hp5ULjyp9P
         B1jORlVXDjawGEYMNWqVu2DfvZOdfUCoIYrDoNF44Ggn+qsQkD+e6ldU0v25v2YSzZf0
         fJabQoHUnLnfIVxe0TmJTrzBs+lDDBq0iMw6JryTYu8QDBWE483WB9CClf7ZhbjAtoC1
         PzcVTMJ3RlupUe5lrK1rLufSIEvV+V+ObESe6UxF122lWUOwsNlLfGqx+ocy0jr9TNSv
         /Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zq/v/JdXgximi7tjH/gLOQeRUsYSH2LAxO/CeqbSkrw=;
        b=Bx6VrZDSBwu8Pz2HfvnzyojA7XobuYnDLfvQaMb9oi84OKv6asTrRF9CL4qyJoggjl
         wcK6XLgGyqMTQaJCBzdrJc1wb4l5chP7vQ4Z0Ol588m5FF+mHoYkmOHqUQdCMMHPu/E3
         88aE5PEJqjdlEaGluRHFlRvvHqPA9f1rd3GvIUp3OfUW4/8oGcwXPOxnFvg7vvWgL7+P
         vh/BYdAzOAnoo+0ubjb8jHLJCLXgs2ME+gx8bYdss9WxPZ85KGchJfVpt/sRBw0CeEMT
         VTnzvScD+GKRxGS8hXsmhZqoPcGlj7LHRBMjt/1YPfYsGOu+MKGgN51jw+zqg1lMsLb9
         LY5w==
X-Gm-Message-State: AOAM530gZiFWJSJA7mkM2c4lqeGFmZtRZBeePzeHJawpco4R6rFRSs7v
        JTNvUNxubaBK4iTmjf7HW1vdEUW2iZRD/6bv
X-Google-Smtp-Source: ABdhPJwgPp1TNWnzd7ubnSrEHCg74zHhzRscd9C8HPO6rP6jIbo4fv6SYqLNh0ABzBWnatXk4W2wAA==
X-Received: by 2002:a92:ca89:: with SMTP id t9mr22459679ilo.178.1630443135301;
        Tue, 31 Aug 2021 13:52:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x15sm10715540ilp.23.2021.08.31.13.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:15 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 13/27] pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
Message-ID: <9f165037ce5e002fc7f4cc8d41969693f2376772.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch to support reading MIDX bitmaps will be less noisy
after extracting a generic function to fetch the nth OID contained in
the bitmap.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 65356f9657..612f62da97 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -223,6 +223,13 @@ static inline uint8_t read_u8(const unsigned char *buffer, size_t *pos)
 
 #define MAX_XOR_OFFSET 160
 
+static int nth_bitmap_object_oid(struct bitmap_index *index,
+				 struct object_id *oid,
+				 uint32_t n)
+{
+	return nth_packed_object_id(oid, index->pack, n);
+}
+
 static int load_bitmap_entries_v1(struct bitmap_index *index)
 {
 	uint32_t i;
@@ -242,7 +249,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		xor_offset = read_u8(index->map, &index->map_pos);
 		flags = read_u8(index->map, &index->map_pos);
 
-		if (nth_packed_object_id(&oid, index->pack, commit_idx_pos) < 0)
+		if (nth_bitmap_object_oid(index, &oid, commit_idx_pos) < 0)
 			return error("corrupt ewah bitmap: commit index %u out of range",
 				     (unsigned)commit_idx_pos);
 
@@ -868,8 +875,8 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 		off_t ofs = pack_pos_to_offset(pack, pos);
 		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
 			struct object_id oid;
-			nth_packed_object_id(&oid, pack,
-					     pack_pos_to_index(pack, pos));
+			nth_bitmap_object_oid(bitmap_git, &oid,
+					      pack_pos_to_index(pack, pos));
 			die(_("unable to get size of %s"), oid_to_hex(&oid));
 		}
 	} else {
-- 
2.33.0.96.g73915697e6

