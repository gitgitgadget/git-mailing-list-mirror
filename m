Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B525C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3666222B3
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgLHWFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgLHWFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:05:15 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83556C061257
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:04:29 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id i6so271880otr.2
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/xbW6H63n+yti/OsJjfkYsqvsHOXl31qvIGu38SrEno=;
        b=WYm9nK13l24tH+5h5/2izJ7alJzlSUi6+dGxz0Srag6gzbWw4ns2fJR45RMMyK744n
         UF6wfIGtTg0uopHQSx9jMddy84QMh7dLORxlMUJKVLdkA9p89zXMJJWpd0rvYF4ZTW9O
         ODb6/cDI8doKhzoq2pOF+ZPWCHpkqk2D5/OhxUvnBCtjpNQRifx8+JSwuAI8Etfz1ou6
         OGm/agURTyu71Lrhl3N7QrshoUoUIs3RsewE5uvBm7hlEg7tYIRZ5wXgfaoUhQDXa2/e
         y5YnqJajC9AfWbhgk5MvrDP83keS6RysaeqZQLeLKDrjFW+gFVEN2lzo9CRm5bQe4lJN
         MNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/xbW6H63n+yti/OsJjfkYsqvsHOXl31qvIGu38SrEno=;
        b=YWum8XPIiIGOA1gdu5pzmvUoLwbPd4aY9Hn0S5LdgPYNyJi9/R5vGL8chRbqYM9H/y
         WZaz0/wf5iyP49GsSZxe1an0eTkbMyEBdE3csDNOc2Knm5ROyQfk7RtpUfLllo13APPZ
         Ukw1XldIwJ6RUMMcNTJIqiDmJxKu7RhCGb1a3Qw/k6Yder3HeiQHKWEsIQv4uTLym4tq
         +0GyoAP5pMYV+sfwjSzw20J0f4hntldGSaLH7zkS0u3CDibIz4ZsIoNwJeS87GLw8yQs
         Sl+u5wOxixaLLqvd3CkHfM0PPnP2UuXLoxjQ85ij/ut2Mo1w0gmEA1fke0AXVgURO2Zb
         ayMw==
X-Gm-Message-State: AOAM5319t37ch/ebCtOmwLppGqIX39Dojes24HSwwmwDXqHUctfbdX6u
        x5/NCBim56vDQvsvm7OA540YzpOujdlWu9EY
X-Google-Smtp-Source: ABdhPJxbNi/EFDjjXGrP66NFN9Ze5DW9eXCDU678+LbALhn5iR4g6QPcqw8dZWqWjmrvlKXuDtCPwQ==
X-Received: by 2002:a05:6830:402c:: with SMTP id i12mr129361ots.25.1607465068645;
        Tue, 08 Dec 2020 14:04:28 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id n63sm14980oih.39.2020.12.08.14.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:04:28 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:04:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 17/24] pack-bitmap.c: check reads more aggressively when
 loading
Message-ID: <2e082437060c43b7a6410be1f9ddd2eeb104e4bc.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
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

