Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE92C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F14023A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgLHAGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgLHAGL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:06:11 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D13C0611CC
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:05:30 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id d8so6388497otq.6
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/xbW6H63n+yti/OsJjfkYsqvsHOXl31qvIGu38SrEno=;
        b=mesdvj6UHVOxJLDKkdh+ablDkj9rJY2jjm3lNHOsT/Z0XlRlN+PlMNny7diSMP+rwH
         waddUWaqE8dn0rVGT9ec6w7oXzYJRJii6lz+AX9PytctfI6YYyqtmCyytb/3bRseiery
         ecSvCYig5CsQM5GwST+5VZih2e2pwLbwQHk+G7adk7Vj/8eAPKMy2CdtjA3+gj4l2JjT
         dx3iQbGSqNizQPwbjugeDxgxP3IrTLiL/rMot+eiG4kX25v21xRGbUnDLC2UL17xNIcl
         dFjN022te2uuUrhfzyK3S0Y5QszvZoHooNSzLXT8JB6ahYvy+B8yJ/797xD9+Bl38nZi
         xCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/xbW6H63n+yti/OsJjfkYsqvsHOXl31qvIGu38SrEno=;
        b=O9qV6ToRz4i32zw26qeODI4e1MJFkrVl5oKb6zHKmy5tAJ6pjEADspOLUb3w0DkddR
         QZIY3FjwpNQOYt66ovtEJkVGAEHbz8FbM1w00pMnnwbHRO7nIK9yc8LUVGgvWKpmkCbh
         noUJBXhgf9B1t1UQuimjNvSp7452QeGJ1PzMFwBV/BEJZUpvZDXqTHHz2DaWPG6+T7aK
         wWKycmMiyx6jtGyGCy5IiaRlOmyDHQ4QAqpZY1TwG5vxlsjI2SNwkmMnhCEbQsc7OG1u
         2fX42aDEo4JqX/4PXur5pwTQaEntNoLrOqrB51pGwADm+rLMzbYTEKwIJL1pwZehGPol
         4Nxw==
X-Gm-Message-State: AOAM5324rryiI5Wx+Dz+r1feLDLtzpbKRwbe7KNklsvm8wL//N5SMzKe
        fLmdhsMpN31dihoTP+TOwS5rdeud55ty+q7r
X-Google-Smtp-Source: ABdhPJxzrqPZDpG81Kh7tJrjcTvyhVhhISQgHN8XRatEblpTnd3mjLn8iSz4+aYpT/mSlUyysm7tAg==
X-Received: by 2002:a9d:5613:: with SMTP id e19mr14722115oti.153.1607385930135;
        Mon, 07 Dec 2020 16:05:30 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id j2sm291879otq.78.2020.12.07.16.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:05:29 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:05:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 17/24] pack-bitmap.c: check reads more aggressively when
 loading
Message-ID: <37f96360983557f6653af85da45383dc16d8b00c.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before 'load_bitmap_entries_v1()' reads an actual EWAH bitmap, it should
check that it can safely do so by ensuring that there are at least 6
bytes available to be read (four for the commit's index position, and
then two more for the xor offset and flags, respectively).

Likewise, it should check that the commit index it read refers to a
legitimate object in the pack.

The first fix catches a truncation bug that was exposed when testing,
and the second is purely precautionary.

There are some possible future improvements, not pursued here. They are:

  - Computing the correct boundary of the bitmap itself in the caller
    and ensuring that we don't read past it. This may or may not be
    worth it, since in a truncation situation, all bets are off: (is the
    trailer still there and the bitmap entries malformed, or is the
    trailer truncated?). The best we can do is try to read what's there
    as if it's correct data (and protect ourselves when it's obviously
    bogus).

  - Avoid the magic "6" by teaching read_be32() and read_u8() (both of
    which are custom helpers for this function) to check sizes before
    advancing the pointers.

  - Adding more tests in this area. Testing these truncation situations
    are remarkably fragile to even subtle changes in the bitmap
    generation. So, the resulting tests are likely to be quite brittle.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4431f9f120..60c781d100 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -229,11 +229,16 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		uint32_t commit_idx_pos;
 		struct object_id oid;
 
+		if (index->map_size - index->map_pos < 6)
+			return error("corrupt ewah bitmap: truncated header for entry %d", i);
+
 		commit_idx_pos = read_be32(index->map, &index->map_pos);
 		xor_offset = read_u8(index->map, &index->map_pos);
 		flags = read_u8(index->map, &index->map_pos);
 
-		nth_packed_object_id(&oid, index->pack, commit_idx_pos);
+		if (nth_packed_object_id(&oid, index->pack, commit_idx_pos) < 0)
+			return error("corrupt ewah bitmap: commit index %u out of range",
+				     (unsigned)commit_idx_pos);
 
 		bitmap = read_bitmap_1(index);
 		if (!bitmap)
-- 
2.29.2.533.g07db1f5344

