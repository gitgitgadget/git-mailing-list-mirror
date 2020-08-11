Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E33C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC6D82076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgIdE8tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgHKPaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgHKPaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 11:30:22 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37C1C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:30:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t14so3248899wmi.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=udQfOSf4XdLqco47uAnE/JhCZ7HlkuphIpesPYnlO4I=;
        b=SgIdE8tkeQSd1gXrT49aHSMde3ndXBy2Kkai5MOV9x5djie4hzo5Oh8RMSNauv5kzS
         iELvrsSay33Izl82Mjt8ntfvsL+SB89ekDurguUOOYVMM0Zd98uLVI2C6LLo0U7uFg3x
         zG4E+gjA/Q6gngteGDUw/7aJqPjpSerrBaz6qNR38hh4n+1wfOOxXPSPuMKSN4uFqK49
         CUH20gjHM12Epm4eLB5prK+SaqCB6v+psplrGLcfdk94K6/fzooKn2TiUgNqC/vMVgWY
         AydkEOokE8MxMh9eepP4uWuB7n1w9xx5SrU62nC8aHEfIU6oPdxqcrApoTwYW7YijIJi
         6SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=udQfOSf4XdLqco47uAnE/JhCZ7HlkuphIpesPYnlO4I=;
        b=b464v6T+rwxDaZWvThwkO8tdx6NqPT0c9EmYMEwVguHf/0MqVgqLpp6VPHZq3MpDIx
         yrJY+NbD+EgOPx8YzfEaTQORrsbkVEoRWPhJue5UD5vN8MoyxtzD/H5SjWGi0Rn+J2S2
         s8FZBmTlflb/bdzQTmWLq37lIh7YaBhecX7vvpxuBdv4Edn6VVdg0itMaE4gV9V8HgZf
         tSjEIDoelL28QoqXUfjAxhUcdkcd2nBzkyP4HYRxn6XmdaXg6/1swAJ2QNkNnzlVjZ7i
         03MAh6udfhTIW76PdmpLOBtt2TzNljnOD/bcl/fxtbopoz6GNb8A3U/h0royOG8kOEDZ
         BzdQ==
X-Gm-Message-State: AOAM530oQ/Z6/vgUPh1opb7qt4b55BjPMUQDGIuICuWtehV9GfRGGHY7
        WjJ4Pl2eBtYQVK66eDVhL3xtrhgn
X-Google-Smtp-Source: ABdhPJyinZEH/19/CTiQj062L2jfDxIeGkMNxiu1OuAW5TNTFAfM2Btb7PZKLp+jIL9+iPjzJaFmFg==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr4435805wmh.89.1597159819432;
        Tue, 11 Aug 2020 08:30:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm5922107wmf.4.2020.08.11.08.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:30:19 -0700 (PDT)
Message-Id: <pull.698.git.1597159818457.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Aug 2020 15:30:18 +0000
Subject: [PATCH] multi-pack-index: repack batches below --batch-size
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sluongng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The --batch-size=<size> option of 'git multi-pack-index repack' is
intended to limit the amount of work done by the repack. In the case of
a large repository, this command should repack a number of small
pack-files but leave the large pack-files alone. Most often, the
repository has one large pack-file from a 'git clone' operation and
number of smaller pack-files from incremental 'git fetch' operations.

The issue with '--batch-size' is that it also _prevents_ the repack from
happening if the expected size of the resulting pack-file is too small.
This was intended as a way to avoid frequent churn of small pack-files,
but it has mostly caused confusion when a repository is of "medium"
size. That is, not enormous like the Windows OS repository, but also not
so small that this incremental repack isn't valuable.

The solution presented here is to collect pack-files for repack if their
expected size is smaller than the batch-size parameter until either the
total expected size exceeds the batch-size or all pack-files are
considered. If there are at least two pack-files, then these are
combined to a new pack-file whose size should not be too much larger
than the batch-size.

This new strategy should succeed in keeping the number of pack-files
small in these "medium" size repositories. The concern about churn is
likely not interesting, as the real control over that is the frequency
in which the repack command is run.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    multi-pack-index: repack batches below --batch-size
    
    As reported [1], the 'git multi-pack-index repack' command has some
    unexpected behavior due to the nature of "expected size" for un-thinned
    fetch packs and the fact that the batch size requires the total size to
    be at least as large as that batch-size. By removing this minimum size
    restriction, we will repack more frequently and prevent this "many
    pack-file" problems.
    
    [1] 
    https://lore.kernel.org/git/6FA8F54A-C92D-497B-895F-AC6E8287AACD@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-698%2Fderrickstolee%2Fmidx-repack-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-698/derrickstolee/midx-repack-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/698

 Documentation/git-multi-pack-index.txt | 11 ++++++-----
 midx.c                                 |  2 +-
 t/t5319-multi-pack-index.sh            | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 0c6619493c..eb0caa0439 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -51,11 +51,12 @@ repack::
 	multi-pack-index, then divide by the total number of objects in
 	the pack and multiply by the pack size. We select packs with
 	expected size below the batch size until the set of packs have
-	total expected size at least the batch size. If the total size
-	does not reach the batch size, then do nothing. If a new pack-
-	file is created, rewrite the multi-pack-index to reference the
-	new pack-file. A later run of 'git multi-pack-index expire' will
-	delete the pack-files that were part of this batch.
+	total expected size at least the batch size, or all pack-files
+	are considered. If only one pack-file is selected, then do
+	nothing. If a new pack-file is created, rewrite the
+	multi-pack-index to reference the new pack-file. A later run of
+	'git multi-pack-index expire' will delete the pack-files that
+	were part of this batch.
 +
 If `repack.packKeptObjects` is `false`, then any pack-files with an
 associated `.keep` file will not be selected for the batch to repack.
diff --git a/midx.c b/midx.c
index 6d1584ca51..38690b46c9 100644
--- a/midx.c
+++ b/midx.c
@@ -1371,7 +1371,7 @@ static int fill_included_packs_batch(struct repository *r,
 
 	free(pack_info);
 
-	if (total_size < batch_size || packs_to_repack < 2)
+	if (packs_to_repack < 2)
 		return 1;
 
 	return 0;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 7214cab36c..b05190f500 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -643,6 +643,7 @@ test_expect_success 'expire respects .keep files' '
 '
 
 test_expect_success 'repack --batch-size=0 repacks everything' '
+	cp -r dup dup2 &&
 	(
 		cd dup &&
 		rm .git/objects/pack/*.keep &&
@@ -662,4 +663,21 @@ test_expect_success 'repack --batch-size=0 repacks everything' '
 	)
 '
 
+test_expect_success 'repack --batch-size=<large> repacks everything' '
+	(
+		cd dup2 &&
+		rm .git/objects/pack/*.keep &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 2 idx-list &&
+		git multi-pack-index repack --batch-size=2000000 &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 3 idx-list &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 3 midx-list &&
+		git multi-pack-index expire &&
+		ls -al .git/objects/pack/*idx >idx-list &&
+		test_line_count = 1 idx-list
+	)
+'
+
 test_done

base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
-- 
gitgitgadget
