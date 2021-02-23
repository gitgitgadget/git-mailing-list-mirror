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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFBBC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0085764E6C
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhBWUQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhBWUP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F2C061356
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:40 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w11so1185414wrr.10
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Mp5BVNLsy38/PeuLsDthiJ4Bt4qP52QXR7S+t+DRT4=;
        b=IbECb4XZ2mb2BT/pH/es5ta4gY2dsga/jtJ0nd6/ySWYxW7Ra7f0zZAq1VXYr9Q1pC
         aFHmg+7J/6yF7+CosBzsp/ykN4aE+X4HXhcn0Pz6xxi3e6ZjL223xxIPGVSrQXjmEGmh
         9QMPN++2EgHVJyuevcAtcr9+rhY40tXYqMx+xoE/Gx9lt15CTGYQ6sD8qBySUiRwZ0Cr
         neo1tPYzZkocAxv0gibbWfcAtDBJJ+ZM3sV1EDN0O7j5zhUu++Io0K7rrK4QRRu7h0eI
         Lkp5rM0WlT8FHA+irjr17S5ez6Mh963BEeODKMCqq9F1OdZBUdVy1faMzjjZPWxeYsoO
         BCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Mp5BVNLsy38/PeuLsDthiJ4Bt4qP52QXR7S+t+DRT4=;
        b=XhabKhOApNAHW9KiZpG6OoonVEZ/FuF65pZqJ6Brrs7JtLHWxnsOfvondzjLzu73DK
         OrDG4+6ifLgRDgBVH7vtcAURR91ZNMxAXvfETvTUDEm+keGv56HdWnM7k88MyKmu5cOm
         jLx9u1q3+Zll+BGAgVnBTo0sjZeWiGXjHOMZG79n/mAW2u853aCutGE2Bg8h51ZSFWPv
         TK/iNfTWWIsl8XCuAmNEa8JKnhIwyE/wB09SwS5cV9MmcT1X55fR3wETkagKMp8bAJwi
         j5W6w9wFqURZlKpRnUitzrsrOw1AH9+xK51ssk49yFu1Ew75ULS0Au3MpQECwYwMFdfr
         /QLQ==
X-Gm-Message-State: AOAM5314XbT5ApGTTch6mnqh7SKxC8gPIdA0MAyTa6JYmJmZSfL1OXuj
        OBp7ewt/EDw/lrJrg5FwEatoUoyirlw=
X-Google-Smtp-Source: ABdhPJxOMIkOZjXNE/dmVIpvYEPtrYCoYK39518nH/7JpimgDaBwwI8ZNGzN6aknDMxFAayu/m1h5w==
X-Received: by 2002:a5d:45cd:: with SMTP id b13mr5543568wrs.296.1614111279075;
        Tue, 23 Feb 2021 12:14:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm10362249wrv.73.2021.02.23.12.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:38 -0800 (PST)
Message-Id: <fda23f07e6a20408b0a10c8944d54e7c65a1d629.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:22 +0000
Subject: [PATCH 13/20] unpack-trees: allow sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The index_pos_by_traverse_info() currently throws a BUG() when a
directory entry exists exactly in the index. We need to consider that it
is possible to have a directory in a sparse index as long as that entry
is itself marked with the skip-worktree bit.

The negation of the 'pos' variable must be conditioned to only when it
starts as negative. This is identical behavior as before when the index
is full.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4dd99219073a..b324eec2a5d1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -746,9 +746,12 @@ static int index_pos_by_traverse_info(struct name_entry *names,
 	strbuf_make_traverse_path(&name, info, names->path, names->pathlen);
 	strbuf_addch(&name, '/');
 	pos = index_name_pos(o->src_index, name.buf, name.len);
-	if (pos >= 0)
-		BUG("This is a directory and should not exist in index");
-	pos = -pos - 1;
+	if (pos >= 0) {
+		if (!o->src_index->sparse_index ||
+		    !(o->src_index->cache[pos]->ce_flags & CE_SKIP_WORKTREE))
+			BUG("This is a directory and should not exist in index");
+	} else
+		pos = -pos - 1;
 	if (pos >= o->src_index->cache_nr ||
 	    !starts_with(o->src_index->cache[pos]->name, name.buf) ||
 	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
-- 
gitgitgadget

