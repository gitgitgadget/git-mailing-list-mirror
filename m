Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201B6C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 01:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiITB4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiITBz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 21:55:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC84856B9B
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:55 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id s9so735213qkg.4
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cRQ1fkkdzVyp/zstyJwYpPYfjNH6K4/m02pgHgif390=;
        b=6KKX0vTQ+eQV8XNkuFxwJQ00OwgzWpqMARL8rkXJwviHZN8KlSwAxa77ySATTFlbcF
         rxC9gIz2gtblowD6OTXgt2osK01jtT8/P/sCNHinyCYvZztDraeYv0ztXFl0ydCUkodv
         7vHCAvrJ3Lq5+AcTgyklk6THbahdp8NVcuiC/wvCO5/IxaBFAR1tduk+iGVN4vfmsT0Q
         mMiIZ6TiWjB4lysbtEkmFvH4oTnbqYGUDwnZC0rIWC2Q3y0yxhSGlozF9X1u8KShJcvd
         E39KU17GkXSLKwj5baB/rRXzh130DW94/Od0WVdnrI/lxWPSbIf3i4Pt6UTnB8xTNLnX
         DKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cRQ1fkkdzVyp/zstyJwYpPYfjNH6K4/m02pgHgif390=;
        b=BrYlZh7bHHPETRyMtbB2QPw5sSRpCKqanzwXjeLNnYwCJyHJTS6UWvfIp7YLido9KD
         ew2DjAGcC5FxFivU1NgKgFsNPIpYgWjK8zA8foqg+2Aa57swsUc/olUVan2L66c3skRY
         eD7X2DgnL9USPLLDDOqy8Zn5LGuepDR8jXT9Cj789phgVtsiJ4WOyXjSJ14pPO/X4Xs4
         kDTSZ/uRoawG/kVyY3EwoHeuVXkaB93ntGhllFYGqun0gDCo1hzKZivLeb7FOHa1Eopc
         0uuuZ5LPBqyBFJEhu0pmKqzUevSz5pKpK+5FBqIkVc3uvRuQk7n0uBbss6tinOnZqpAb
         xXtA==
X-Gm-Message-State: ACrzQf0vMoEHykZwxcrNTCz2u0gAxcnwgmZtPeUSLkrhQkkKVzVaJhFN
        gTPb51ZOxB4venF/hlaDWRrw6FhYw7jnSA==
X-Google-Smtp-Source: AMsMyM4u3v1XrxQRprJXzEQj8V5Vy9DA0M6J8TD/HKzOSO7QDkVbVUCuTJ7wCodd3s6pqmoun4Zgcg==
X-Received: by 2002:a05:620a:2455:b0:6ce:9bfd:85d4 with SMTP id h21-20020a05620a245500b006ce9bfd85d4mr14704355qkn.45.1663638954661;
        Mon, 19 Sep 2022 18:55:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q10-20020a05620a0d8a00b006b9c6d590fasm87806qkl.61.2022.09.19.18.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:55:54 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:55:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com,
        gregory.szorc@gmail.com
Subject: [PATCH 6/7] midx.c: remove unnecessary loop condition
Message-ID: <4c9c18de2d3a36c0939d21027b73762b20298477.1663638929.git.me@ttaylorr.com>
References: <cover.1663638929.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1663638929.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fill_included_packs_batch() routine is responsible for aggregating
objects in packs with a non-zero value for the `--batch-size` option of
the `git multi-pack-index repack` sub-command.

Since this routine is explicitly called only when `--batch-size` is
non-zero, there is no point in checking that this is the case in our
loop condition.

Remove the unnecessary part of this condition to avoid confusion.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index d703fc5a16..273704caed 100644
--- a/midx.c
+++ b/midx.c
@@ -1928,7 +1928,7 @@ static int fill_included_packs_batch(struct repository *r,
 		pack_info[i].mtime = m->packs[i]->mtime;
 	}
 
-	for (i = 0; batch_size && i < m->num_objects; i++) {
+	for (i = 0; i < m->num_objects; i++) {
 		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
 		pack_info[pack_int_id].referenced_objects++;
 	}
-- 
2.37.0.1.g1379af2e9d

