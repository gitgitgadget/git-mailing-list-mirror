Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02BEC19F2B
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiG2Iwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiG2Iwc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:52:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792A182FBB
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:52:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so5187147wrh.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NocFcw3d3rienDT5/DOWhDp56rTaSkSrqf5OPFXFTXs=;
        b=iYD/TauS3pVzUj7prgKNYjn37cQPyB5zopUe+5g6lH+1BQfNlGfj2YK/Z3iN2qcj9c
         0uW7OHXVAdu/syb1A2vl+Tgtlay53sWyh/tinHDTMKLV7+8FrhIGl9Zfk7SHGO1wTpdQ
         9/PNxVvO0bgswcXYTXnJYyItDpOB0fihhYn5D2Qq+ZKp2OnUfzYz+TRet2PcfAaGSHBe
         eRJ+p8xQEl57j6ldRuYq/FFFqRY1aV9yXi5M8VQAc1J1V8CSkkzkFoxAyPCxk391K07+
         owA59+mvyI+9foi1nHEDH9S5lJJvwj1S11EjtWaRkXPOhndjlyAhXIra+xYHW8M+9BuM
         emsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NocFcw3d3rienDT5/DOWhDp56rTaSkSrqf5OPFXFTXs=;
        b=KUL1Jw/otexQfWk8bbD4glnyX/xRmCEak5iGZD/IXa5h0xHySQWKCZzHSUREW5+3AT
         /VhPj6aPBvvZq9aMBeNtyYYmdknTbBFIZ7g74+8kp2R4TA1BzqZGDZ0V/E3uGDdJAB/V
         gVYo5n7KRqus/SUlLc91+f6BCZQStzW4M+E5Ky1+InZC9moB23e7eaqkTdUEi/1rnPav
         B1cWCpWo9EZS7fpiqj7ZuNXn6O6MhgqLF3F3YJcLSqhfKe1vaWNbEXUoZ8zc5bB16DTF
         oI0XcpXr8PgKiqo3aEDe1BUPNslQte8fkQSXYlWbS1EOKjKJJOcdOeLgnJpbTVvnmwyT
         x0JA==
X-Gm-Message-State: ACgBeo0S8NfPJ69/nig/qwEp4DwMWWA1ODQViLGPf2mt5eudpM+EWsA6
        Otxm1TNh/we+w/LnfJZNQbukNpeb8XI=
X-Google-Smtp-Source: AA6agR6UjThnvTHBpXFGyJBLWoSFRbr8kuA5T6COCkYMD9IbiW9qp3A3b86O20dIPA7AEzVSAiLluQ==
X-Received: by 2002:a05:6000:1f16:b0:21e:d72a:59d2 with SMTP id bv22-20020a0560001f1600b0021ed72a59d2mr1788449wrb.194.1659084749437;
        Fri, 29 Jul 2022 01:52:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d560b000000b0021f131de6aesm675713wrv.34.2022.07.29.01.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:52:28 -0700 (PDT)
Message-Id: <pull.1307.git.1659084748350.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 08:52:27 +0000
Subject: [PATCH] merge-ort: clean up after failed merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 9fefce68dc8 (merge-ort: basic outline for merge_switch_to_result(),
2020-12-13), we added functionality to lay down the result of a merge on
disk. But we forgot to release the data structures in case
`unpack_trees()` failed to run properly.

This was pointed out by the `linux-leaks` job in our CI runs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    merge-ort: clean up after failed merge
    
    I was investigating why seen's CI runs fail, and came up with this fix.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1307%2Fdscho%2Fmerge-ort-impl-leakfix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1307/dscho/merge-ort-impl-leakfix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1307

 merge-ort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index ee7fbe71404..61b9e90018b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1002,6 +1002,7 @@ void merge_switch_to_result(struct merge_options *opt,
 		if (checkout(opt, head, result->tree)) {
 			/* failure to function */
 			result->clean = -1;
+			merge_finalize(opt, result);
 			return;
 		}
 
@@ -1010,6 +1011,7 @@ void merge_switch_to_result(struct merge_options *opt,
 						    &opti->conflicted)) {
 			/* failure to function */
 			result->clean = -1;
+			merge_finalize(opt, result);
 			return;
 		}
 	}

base-commit: 9fefce68dc85d96781090f86c067d83f7c50b617
-- 
gitgitgadget
