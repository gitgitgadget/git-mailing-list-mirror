Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE201F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeDXVDv (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:03:51 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42372 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbeDXVDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:03:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id e12so11739477pgn.9
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FuZL2tXdeg0o59oTECCTga90c3nghZwnWMhp5yBv+c0=;
        b=E/1fxNMhS3KXPWtfophx19WI84F4utGxIy41RtDgx2fUjA03LU1m3PbmVTEZx+Sthd
         O+u1igN4tpgfqvcES1nHIM8i+yOHidYjmncv7LpY1FqqEhU08nOXyVoVy+fQwEkLATvE
         MmNqut9R4QzFXg/MDZ9KfgD3h4wC/YjGT/CC1mZseKI4e+Cwm8tkHJnQ8DexoePnXgjF
         nz6k3BYhtfaMpUI7z0zvvZjqWqG+ORn+8wcKuznsjiB661EiKDJbB/ptwE+ADOzuwz43
         xRph1AsHb7uH2xjJ/agxcVr3bnkD2X3Nk9AEfJ/EOFrmUR2jc7w039wxbwdAHZ6ZKqOw
         U6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FuZL2tXdeg0o59oTECCTga90c3nghZwnWMhp5yBv+c0=;
        b=Bts3Et3WjdriVuacTCqtl28UB0sLiXM+KJKPp3c4afXGZW8xDjGoMKUXQF7oopGnKt
         xsXC+Jm5q9skOpR39P0DKYjFSqxlmWMa8UxP3iGyjBJihfuzgfyu0t6iu+kedeG7UeaW
         kgyMwkLPHTIKcNoAP1mdXxbIVil5nrme10vmZR997ekGWnlRTSVP2IW96Yy/IZH6q0g/
         GesKz0TPmJxjYW1Xsz/TQ0UgZd5IGaTcVEaDd8gxicGzdB5YE4l2bklkNvmL2VSG91h1
         RgWV4ot0W7CF4VghZVXIsHQcpGaL+RYHLUOpwY9YyF+wHY7OJDh6QQonP3/V/wqvwAHq
         RxlQ==
X-Gm-Message-State: ALQs6tBexXOdjvRC/HVSqdX+4Bspt6SaY+RczbNDha7JeGvTKZSKDmLg
        7z0wMZiSZL/6vDgiNzrcfAIcDXqGPQ8=
X-Google-Smtp-Source: AIpwx4+YShlP2zL+/k8+gxbekt4H6VlXoW5bvnGtOTvSXMH1wmpTokP6SHKDTGxkzB01u3YHmgDmZg==
X-Received: by 10.99.175.29 with SMTP id w29mr21937532pge.247.1524603818248;
        Tue, 24 Apr 2018 14:03:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k24sm24224388pff.147.2018.04.24.14.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:03:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/7] diff.c: adjust hash function signature to match hashmap expectation
Date:   Tue, 24 Apr 2018 14:03:27 -0700
Message-Id: <20180424210330.87861-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424210330.87861-1-sbeller@google.com>
References: <20180424210330.87861-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the follow up patch easier.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index ce7bedc1b9..d1bae900cd 100644
--- a/diff.c
+++ b/diff.c
@@ -707,11 +707,15 @@ struct moved_entry {
 	struct moved_entry *next_line;
 };
 
-static int moved_entry_cmp(const struct diff_options *diffopt,
-			   const struct moved_entry *a,
-			   const struct moved_entry *b,
+static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
+			   const void *entry,
+			   const void *entry_or_key,
 			   const void *keydata)
 {
+	const struct diff_options *diffopt = hashmap_cmp_fn_data;
+	const struct moved_entry *a = entry;
+	const struct moved_entry *b = entry_or_key;
+
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
 				    diffopt->xdl_opts);
@@ -5534,10 +5538,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 		if (o->color_moved) {
 			struct hashmap add_lines, del_lines;
 
-			hashmap_init(&del_lines,
-				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
-			hashmap_init(&add_lines,
-				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
+			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
+			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
 
 			add_lines_to_move_detection(o, &add_lines, &del_lines);
 			mark_color_as_moved(o, &add_lines, &del_lines);
-- 
2.17.0.441.gb46fe60e1d-goog

