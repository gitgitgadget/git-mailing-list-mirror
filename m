Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAABC433E6
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C343A207D2
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhA0Pgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhA0PDn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:03:43 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B2C06121D
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:10 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c128so1953956wme.2
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+DRAQNjk0bjEC6cdHtenVpAcIZ+yrXA2o9jF08e5BFs=;
        b=tZ/ocKqAOCkGcXjweB3UoNcuwQiuI+5Ql7UCvgEDsQAyx9puJeZPJFZFLmXF7blPn3
         em9YmKZoX459M2n0VqFW/6sZKxiuzTQ06vJUEH3Uj/k9dLwsLAeFtwwO8oWrrZDK/an1
         51jScuWpelmtWPnxuk1ZsvQZCKHGYk6WXh25MtEarQhRJjLa1TyzU7MbHgWNup9H20Ut
         WKFf7BVTXWJJ1qZCc9RS2YK2Dc+F3TS0wpolTjltK8y28k/p+OVcwT/HW9JZsMlwfP9f
         HrAdKsEFzNN2YMlLkzdvIns3aHdFBx7GyGzMln4ERV56VQ3Wbucwewme5TaXJw8skUDi
         MQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+DRAQNjk0bjEC6cdHtenVpAcIZ+yrXA2o9jF08e5BFs=;
        b=VpwN4/FhqIkNdwLPOV8K4ITEbPhdjRyz9qIXvh5uXtgZp4KA7HUr+BHXVqxdCecyRy
         WJpGt0lkvta3U6mLAfwJMGU8GoGWeCeebm/LyrSx7yYAPEdZT01QnX3/a+qoWNet/JwS
         1Y6sgYB72AvaKfr3yhezl5G1exvA7THD1a6F8oxtUPwmrwyPDyC1hqDm85mswqXi7OdG
         opldU+ecQyW7zQ+Y+W+ZLEGuLkWtbaLyTb+foh6y80l2Klje0yj3H6iay0t123xpE/z7
         r8wKLBvAOJlISl9ZBq1YzZtCoKOw03Zrg3GWLCdXPNs6zvA+hbWQ2zfM5fDyCipL37rB
         U6Xg==
X-Gm-Message-State: AOAM533bqQ5Fa7XIxK70XV1xDgao0A0oyH7UKsUqPkPm7GJNDLQj48xK
        d6gaPIrJWd3K4jh/aAY2PJAZ9lZauJk=
X-Google-Smtp-Source: ABdhPJxlQpzJRwYR1pKSw/IV6N9ml9VFhK70dHQ1vyQwMBh79oOKGkdxMgJ0wOV88xqs5cDSeUq00w==
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr4402960wmj.17.1611759729043;
        Wed, 27 Jan 2021 07:02:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16sm3318766wrx.36.2021.01.27.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:08 -0800 (PST)
Message-Id: <78744d3b7016520cfc946e858eb1f6233003bffc.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:49 +0000
Subject: [PATCH v2 10/17] midx: drop chunk progress during write
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Most expensive operations in write_midx_internal() use the context
struct's progress member, and these indicate the process of the
expensive operations within the chunk writing methods. However, there is
a competing progress struct that counts the progress over all chunks.
This is not very helpful compared to the others, so drop it.

This also reduces our barriers to combining the chunk writing code with
chunk-format.c.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/midx.c b/midx.c
index e23a5fc4903..6ee262aab79 100644
--- a/midx.c
+++ b/midx.c
@@ -808,7 +808,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	uint64_t header_size = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
-	struct progress *progress = NULL;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
@@ -976,9 +975,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		hashwrite_be64(f, chunk_offsets[i]);
 	}
 
-	if (flags & MIDX_PROGRESS)
-		progress = start_delayed_progress(_("Writing chunks to multi-pack-index"),
-					  num_chunks);
 	for (i = 0; i < num_chunks; i++) {
 		if (f->total + f->offset != chunk_offsets[i])
 			BUG("incorrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,
@@ -1011,10 +1007,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				BUG("trying to write unknown chunk id %"PRIx32,
 				    chunk_ids[i]);
 		}
-
-		display_progress(progress, i + 1);
 	}
-	stop_progress(&progress);
 
 	if (f->total + f->offset != chunk_offsets[num_chunks])
 		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
-- 
gitgitgadget

