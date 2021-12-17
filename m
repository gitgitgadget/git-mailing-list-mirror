Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B41C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbhLQQ2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhLQQ2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 11:28:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2280C061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 08:28:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c4so5070145wrd.9
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nS8iPv1KyBW6VmUjqvmww+5ntjnBpmLLIX3wt+I5Kik=;
        b=qfrYMfhbvzo7autGdN7mDjzBMPnqmRYvdi+Sq9TiIO0HNfLxg1HB4xGJ/Fa8FlCw22
         /RPaYh0g7gnwFF8cDVOFK1wb+BJ1F3+ItRPddDoD14kvf3wrvSeLIUj27S+YUndILTRG
         sxuy+iXT+bV6b1aqkegMlwQ/X7rmCdVDH7Z/QpgyV6Uf7ae7+wr23ArAuaX1X2i01baV
         I3JQLkttOd9+i5b6fvA0QPVmlTzAeO/GIwH/HfDTP4xJt9Og1LMiZs5U3wgHyQUAwEgb
         Z8KtL/aPwARspRdIQLNfytfuuJUmQ94V2uRQ6GrrIzi9/+/2NbqSrkbosiNWAzoUJ4fo
         a4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nS8iPv1KyBW6VmUjqvmww+5ntjnBpmLLIX3wt+I5Kik=;
        b=UlAMmX8cz+jn1Ennt8Ij0re1KcR9Tpqh1kYE45NeVkpB5u6rmM4MDvEXdmTm1abuyr
         7CCLSefY3uKItfDUEazifIUTCMhP8B44Q+OCKwzzAsBHsr8grpkoZ2PRwv8dahn2FjXA
         4iWyU8jQ+ZeYYjOpQly1V442F6cLLDUaZKRZPeRMrZ0o8WU2iC0zEzdnGiqKvHRCqu2j
         bei/OBOMgMMK+hEDUjJd65QnWaLdSiUSnPV8xbmNO0u3SJjYPP5IngZ2Au5ANb4uPr5/
         N73o3YP1JKD5jW8aonqB+BtQgIrsmDZ6jtLamaHuB4/jXdxm51bVWpFerDaPaCjc4wQh
         sZAQ==
X-Gm-Message-State: AOAM533tN7F2B7Z3fO4G3paul6HOYNcAQU/QCXqi8p6t8eKmHXZRlG0i
        oEGRWyuIvsIi8W7ToT9ts6cuIz0HyUQ=
X-Google-Smtp-Source: ABdhPJysk9a5Jf+SX4lHeTsy10umTl+Iw+10Hdmc0Vm6NvglNDpjJ7yHQFSNk6Y4VXHA2quRuzUnQg==
X-Received: by 2002:adf:f452:: with SMTP id f18mr926698wrp.240.1639758528583;
        Fri, 17 Dec 2021 08:28:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm12633873wmq.31.2021.12.17.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:28:48 -0800 (PST)
Message-Id: <1ed91f6d255b76bdbdcccea7e1effcebbb263ced.1639758526.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Dec 2021 16:28:45 +0000
Subject: [PATCH 1/2] repack: respect kept objects with '--write-midx -b'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Historically, we needed a single packfile in order to have reachability
bitmaps. This introduced logic that when 'git repack' had a '-b' option
that we should stop sending the '--honor-pack-keep' option to the 'git
pack-objects' child process, ensuring that we create a packfile
containing all reachable objects.

In the world of multi-pack-index bitmaps, we no longer need to repack
all objects into a single pack to have valid bitmaps. Thus, we should
continue sending the '--honor-pack-keep' flag to 'git pack-objects'.

The fix is very simple: only disable the flag when writing bitmaps but
also _not_ writing the multi-pack-index.

This opens the door to new repacking strategies that might want to keep
some historical set of objects in a stable pack-file while only
repacking more recent objects.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c  |  2 +-
 t/t7700-repack.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 9b0be6a6ab3..1f128b7c90b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -693,7 +693,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		write_bitmaps = 0;
 	}
 	if (pack_kept_objects < 0)
-		pack_kept_objects = write_bitmaps > 0;
+		pack_kept_objects = write_bitmaps > 0 && !write_midx;
 
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 0260ad6f0e0..8c4ba6500be 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -372,4 +372,19 @@ test_expect_success '--write-midx with preferred bitmap tips' '
 	)
 '
 
+test_expect_success '--write-midx -b packs non-kept objects' '
+	git init midx-kept &&
+	test_when_finished "rm -fr midx-kept" &&
+	(
+		cd midx-kept &&
+		test_commit_bulk 100 &&
+		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+			git repack --write-midx -a -b &&
+		cat trace.txt | \
+			grep \"event\":\"start\" | \
+			grep pack-objects | \
+			grep \"--honor-pack-keep\"
+	)
+'
+
 test_done
-- 
gitgitgadget

