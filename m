Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A836C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 13:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3FB8206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 13:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq2BNCVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgEENGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 09:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgEENGq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 09:06:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F979C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 06:06:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so2217016wmj.3
        for <git@vger.kernel.org>; Tue, 05 May 2020 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ogq3DqHXOgZKadtPpECYHTzXCmD52DTTl7AaryecnXE=;
        b=fq2BNCVmRNsFfgwB4jTsjQ4/JOOwFMTqhd/os3WiyXkRBSggqPIuL9H+cf74+JFmHB
         hhjtHnN06EOPHLLnIEHGHF6wIpSJ6zIUVKQGU+xvQAXbv+oO1BX+B4BNVgA/SXKBBDb+
         7mVRnKvqSK+B9auqVZo5FJoquVEGlkwDBYRYm/Kl+XIk5ndmcoZdDuWWaonrlMiNJEe7
         IkpGHvfTp3yA1Lew/pLNJznp3Vj65T1WehzM5roZbqHjIUnqqMjG/uugjBh2ukDyNosd
         BWCN2Nu9ZpHXMNmdr64JjTS24C2ucovLRzYBWCcbev0/cyS3wsD/Stg7EnLQrUMja42f
         zCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ogq3DqHXOgZKadtPpECYHTzXCmD52DTTl7AaryecnXE=;
        b=kEs1bSIC078/UngVGAXu5ygKbqGkGyn8HX/telqAx0YRod7W9bXhzAjMy32u+zGDRY
         ijAhcD2HLGjZJWJy/D3yNmWmNynPsKQe2SkTFqXnYuHMufhzPrpxJjymy98yPCfBr4Qc
         d6huBiyltIcR3cE97V0NQgIMYHIiksfz/YW7Ip17LviD+hRVEQv0f2V+RM/yNeNeKFVN
         erBLTrdM+yhJ2WePaXEg+7UUTISP37hly1dl0bpedH+Ezn+s2vRe1zEGEdkHmXWf+rri
         0yIuWqg7pRV+6M9VcZnhkBgfZ/1TF3cShqM2PGxkL1Mk0gdZ6YGwkf2BVKVmMf9FLYS0
         +fSQ==
X-Gm-Message-State: AGi0Pua0kLi39QB8d5zgr4apLLMyNN4rCyaVifhcdoxbbJy05UmnHOW2
        rM2cbSF6kf3rwUA7eB71xg9a9L5h
X-Google-Smtp-Source: APiQypKTNWkbPBlJmVFFZxAkGVazUoWR4EB0jffbRzeup/vwxdul/uSay+ToTge3lmH+JXE4Q/jBLg==
X-Received: by 2002:a1c:a344:: with SMTP id m65mr3451927wme.20.1588684004925;
        Tue, 05 May 2020 06:06:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5sm841287wmz.16.2020.05.05.06.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 06:06:44 -0700 (PDT)
Message-Id: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
From:   "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 May 2020 13:06:43 +0000
Subject: [PATCH] midx: apply gitconfig to midx repack
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Son Luong Ngoc <sluongng@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Son Luong Ngoc <sluongng@gmail.com>

Multi-Pack-Index repack is an incremental, repack solutions
that allows user to consolidate multiple packfiles in a non-disruptive
way. However the new packfile could be created without some of the
capabilities of a packfile that is created by calling `git repack`.

This is because with `git repack`, there are configuration that would
enable different flags to be passed down to `git pack-objects` plumbing.

In this patch, I applies those flags into `git multi-pack-index repack`
so that it respect the `repack.*` config series.

Note: I left out `repack.packKeptObjects` intentionally as I dont think
its relevant to midx repack use case.

Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
    midx: apply gitconfig to midx repack
    
    Midx repack has largely been used in Microsoft Scalar on the client side
    to optimize the repository multiple packs state. However when I tried to
    apply this onto the server-side, I realized that there are certain
    features that were lacking compare to git repack. Most of these features
    are highly desirable on the server-side to create the most optimized
    pack possible.
    
    One of the example is delta_base_offset, comparing an midx repack
    with/without delta_base_offset, we can observe significant size
    differences.
    
    > du objects/pack/*pack
    14536   objects/pack/pack-08a017b424534c88191addda1aa5dd6f24bf7a29.pack
    9435280 objects/pack/pack-8829c53ad1dca02e7311f8e5b404962ab242e8f1.pack
    
    Latest 2.26.2 (without delta_base_offset)
    > git multi-pack-index write
    > git multi-pack-index repack
    > git multi-pack-index expire
    > du objects/pack/*pack
    9446096 objects/pack/pack-366c75e2c2f987b9836d3bf0bf5e4a54b6975036.pack
    
    With delta_base_offset
    > git version
    git version 2.26.2.672.g232c24e857.dirty
    > git multi-pack-index write
    > git multi-pack-index repack
    > git multi-pack-index expire
    > du objects/pack/*pack
    9152512 objects/pack/pack-3bc8c1ec496ab95d26875f8367ff6807081e9e7d.pack
    
    In this patch, I intentionally leaving out repack.packKeptObjects as I
    don't think its very relevant to midx repack use case:
    
     * One could always exclude biggest packs with --batch-size option
       
       
     * For non-biggest-packs exclusion use case, its rather rare (unless you
       want to have a special pack with only commits and trees being
       excluded from repack to serve partial clone better?)
       
       
    
    Please let me know if anyone think that we should include that option
    for the sake of completions.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-626%2Fsluongng%2Fsluongngoc%2Fmidx-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-626/sluongng/sluongngoc/midx-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/626

 midx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/midx.c b/midx.c
index 9a61d3b37d9..88f16594268 100644
--- a/midx.c
+++ b/midx.c
@@ -1361,6 +1361,10 @@ static int fill_included_packs_batch(struct repository *r,
 	return 0;
 }
 
+static int delta_base_offset = 1;
+static int write_bitmaps = -1;
+static int use_delta_islands;
+
 int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
 {
 	int result = 0;
@@ -1381,12 +1385,25 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	} else if (fill_included_packs_all(m, include_pack))
 		goto cleanup;
 
+  git_config_get_bool("repack.usedeltabaseoffset", &delta_base_offset);
+  git_config_get_bool("repack.writebitmaps", &write_bitmaps);
+  git_config_get_bool("repack.usedeltaislands", &use_delta_islands);
+
 	argv_array_push(&cmd.args, "pack-objects");
 
 	strbuf_addstr(&base_name, object_dir);
 	strbuf_addstr(&base_name, "/pack/pack");
 	argv_array_push(&cmd.args, base_name.buf);
 
+	if (delta_base_offset)
+		argv_array_push(&cmd.args, "--delta-base-offset");
+	if (use_delta_islands)
+		argv_array_push(&cmd.args, "--delta-islands");
+	if (write_bitmaps > 0)
+		argv_array_push(&cmd.args, "--write-bitmap-index");
+	else if (write_bitmaps < 0)
+		argv_array_push(&cmd.args, "--write-bitmap-index-quiet");
+
 	if (flags & MIDX_PROGRESS)
 		argv_array_push(&cmd.args, "--progress");
 	else

base-commit: b34789c0b0d3b137f0bb516b417bd8d75e0cb306
-- 
gitgitgadget
