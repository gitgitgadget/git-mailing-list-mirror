Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27260C47257
	for <git@archiver.kernel.org>; Wed,  6 May 2020 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071E42082E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 09:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/aGsxR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgEFJnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 05:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728729AbgEFJnR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 05:43:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A4BC061A10
        for <git@vger.kernel.org>; Wed,  6 May 2020 02:43:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so1376765wrt.9
        for <git@vger.kernel.org>; Wed, 06 May 2020 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tLcsUDegH4iHU5aJxH8+4TPqG1wttl+EVhRIxo+M9gY=;
        b=q/aGsxR+He9Ki99V0h8RvQ0mfj7LVQzkaLc9hiCrVW5JgABTxbOjv1rnKvNkI0fV7G
         fux7lLZnb27m7am1Ay2mXPJYeTc/bgw0Pj6m0V6vg0O62Y8dlTQb7KqUK83bP9Yn36d7
         G5v4CEd9n7oRDszmJKbPPuxQZDuYSXVudWwwixMsm9/WrRtofbN77wnMG6BlAJYaSMxn
         Ijp9fHdhc9ybTo2APD9NH7rMDo988V8XSD/6FVOKSAVOsg5n1Kru9afh9shbgUISpVFU
         sVdPIpNrOSHdAMucRa8RbfGndH2mzazlpGxd9JTBzfJv0pKuXC0NvE5ZyDwfUJtVM4Kf
         /hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tLcsUDegH4iHU5aJxH8+4TPqG1wttl+EVhRIxo+M9gY=;
        b=Y8Qxy6r2+XFAn2e7u+qOGmCu4nz1T0/tDq7DW4llDP68yxJXDpxGY6HLOHTDIpACnx
         5Cuj4I5bqT+BOcuvJ0BJNO7IVJ1MdpBsjNks3MCUDhK7Sfr87JDKnymswY/oHX4TtUGp
         aWuyAsXoU82JpqhlBi7GDsiWn6icozX+sQ2KeG+7A492ZlNHzk1CRaw/GugGihOaia32
         DGFE/OB3I158rcUo5JdBHRjBD1sXLCQyV5Uyu/hCdYSmW2n0qnCb76u059XCfvez1GTr
         eG1JiwBRQ331Q6yl099cz/DaS8ltBzCAdy4faMbhPMzuN+ghj7ObfcbEHqkiBZThElKE
         Zx1g==
X-Gm-Message-State: AGi0PubLg2Hw4Ep29fHyoAxN97lNQfdRdTo5PLgViqZRkGoFFba0HDkA
        EnD8eHZvHnJ7dQWoFY+0ffie8Rwd
X-Google-Smtp-Source: APiQypIbgR7hTWPGBMLOtS/1okgNVafpLK2ElIU+DvoBkfSijVR6nv2zFCKIVL4a3ItBKIwW7wCcww==
X-Received: by 2002:adf:f0c9:: with SMTP id x9mr4456858wro.375.1588758195989;
        Wed, 06 May 2020 02:43:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm1786404wru.92.2020.05.06.02.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 02:43:15 -0700 (PDT)
Message-Id: <21c648cc486cf1abee51076d21e55649b1464516.1588758194.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
References: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
        <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
From:   "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 May 2020 09:43:13 +0000
Subject: [PATCH v2 1/2] midx: apply gitconfig to midx repack
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

Note:
- `repack.packKeptObjects` will be addressed by Derrick Stolee in
the following patch
- `repack.writeBitmaps` when `--batch-size=0` was NOT adopted here as it
requires `--all` to be passed onto `git pack-objects`, which is very
slow. I think it would be nice to have this in a future patch.

Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
---
 midx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/midx.c b/midx.c
index 9a61d3b37d9..3348f8e569b 100644
--- a/midx.c
+++ b/midx.c
@@ -1369,6 +1369,8 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct strbuf base_name = STRBUF_INIT;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	int delta_base_offset = 1;
+	int use_delta_islands;
 
 	if (!m)
 		return 0;
@@ -1381,12 +1383,20 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	} else if (fill_included_packs_all(m, include_pack))
 		goto cleanup;
 
+	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
+	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
+
 	argv_array_push(&cmd.args, "pack-objects");
 
 	strbuf_addstr(&base_name, object_dir);
 	strbuf_addstr(&base_name, "/pack/pack");
 	argv_array_push(&cmd.args, base_name.buf);
 
+	if (delta_base_offset)
+		argv_array_push(&cmd.args, "--delta-base-offset");
+	if (use_delta_islands)
+		argv_array_push(&cmd.args, "--delta-islands");
+
 	if (flags & MIDX_PROGRESS)
 		argv_array_push(&cmd.args, "--progress");
 	else
-- 
gitgitgadget

