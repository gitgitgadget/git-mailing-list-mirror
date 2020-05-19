Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BE3C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 19:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC66206C3
	for <git@archiver.kernel.org>; Tue, 19 May 2020 19:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmZla4cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgESTst (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 15:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 15:48:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B655C08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 12:48:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m185so526345wme.3
        for <git@vger.kernel.org>; Tue, 19 May 2020 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TPV0Jc0peArjgzeHl14EiO5yHmmDK5NLovsehq4bHh4=;
        b=qmZla4cwN5512/Wpmqd0XM0hjM+7oY1fnMEiPnwS3SK62EE5O6POen5rJFj/+OuFJy
         e54XOj+uPPF64ZdAoEMplq+IxoKRXBLAmdR9gLK4r9rUXJTls/w70YhqCVA036BA18Z3
         7vWttI4ECmev/D1B3aqipsqYfNFREfWbXhnBD7RV2CjPxSLPk9a8CnBXuD5HZuJ4n+uu
         XeUqn0OsjjO80AbdNe/FD/pI16bl5xyK1r6AFaPfrYAv7gnw7w070HMbEB7pnaZTNbPx
         Rw9PHHU4GNflZ+JV3K4H5QVKgrAjd440loF4C3/I3UVdVonMfxxU5nVpeFSKVHD4ETjm
         csVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TPV0Jc0peArjgzeHl14EiO5yHmmDK5NLovsehq4bHh4=;
        b=YvkoHqhFOsyMVjZ10kz047Cm6QkBd53srzTzOa0CVouSvCTvRyQ/32YbHhsn1ctm1z
         R4nLZA297+z/qbDKX0tXGoSZA3ovKeAwp/3SIjqZhQSf6nwWaZhl1DxH2OXyqXKkW5gW
         W02MXlNaDU6gGbqVR82Fyua72mUTLXazHS5gd4qJILEMq1EooOAfKwja0J7hAEkuCP1K
         VjXePPv/eFnXzVE6ogKw7za8Ctv5ZYAMZavIu0uWcag28wnzM8Wrb8JnGFhrhBo+fbR6
         SKOIybNm8QyIFLmjr9zqAIXhWHwzVja8+xU25VYH+6PVki5g6NOi4TvAMiRisoLEJdC/
         eGog==
X-Gm-Message-State: AOAM532yhTYAxpLqH6XDDPU9sCgevSOlDT/SqRCa9QTKchRFAyqBXcI8
        brFo1gTlDMwlDVqoHiMxscrqnyly
X-Google-Smtp-Source: ABdhPJyuAhSV3TP5PhmZRvw0mal0Mczpy7HutYPzudIsYrLcla1wwMan+PrU4AEicNFQCSzx22ti+Q==
X-Received: by 2002:a1c:e157:: with SMTP id y84mr992905wmg.15.1589917726617;
        Tue, 19 May 2020 12:48:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 77sm518371wrc.6.2020.05.19.12.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 12:48:46 -0700 (PDT)
Message-Id: <pull.637.git.1589917725263.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 May 2020 19:48:45 +0000
Subject: [PATCH] fsck: use ERROR_MULTI_PACK_INDEX
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The multi-pack-index was added to the data verified by git-fsck in
ea5ae6c3 "fsck: verify multi-pack-index". This implementation was
based on the implementation for verifying the commit-graph, and a
copy-paste error kept the ERROR_COMMIT_GRAPH flag as the bit set
when an error appears in the multi-pack-index.

Add a new flag, ERROR_MULTI_PACK_INDEX, and use that instead.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    fsck: use ERROR_MULTI_PACK_INDEX
    
    Here is a clean-up that I forgot to send a while back.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-637%2Fderrickstolee%2Ffsck-midx-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-637/derrickstolee/fsck-midx-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/637

 builtin/fsck.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8d13794b141..f02cbdb439b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -49,6 +49,7 @@ static int name_objects;
 #define ERROR_PACK 04
 #define ERROR_REFS 010
 #define ERROR_COMMIT_GRAPH 020
+#define ERROR_MULTI_PACK_INDEX 040
 
 static const char *describe_object(const struct object_id *oid)
 {
@@ -952,7 +953,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			midx_argv[2] = "--object-dir";
 			midx_argv[3] = odb->path;
 			if (run_command(&midx_verify))
-				errors_found |= ERROR_COMMIT_GRAPH;
+				errors_found |= ERROR_MULTI_PACK_INDEX;
 		}
 	}
 

base-commit: efcab5b7a3d2ce2ae4bf808b335938098b18d960
-- 
gitgitgadget
