Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B83AC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5461D235FC
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbhAGVg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbhAGVg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:36:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF10C0612FA
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d13so6976034wrc.13
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hDyryaov45i5VpCMwMfYmGC3XG+kMJuhszeqQ9Ks0RE=;
        b=aIBdKHpBAAyndq0dpz7RYzitk4B2NgdV1EAFdCvof1SuaZRKE0Yzwt2UpPMuVQKjJp
         j+iACPc2KtQaLwhWoR8tmWNnExCep+7xjEW9rj5/sTHHFbpfX8l9xGcsJPxF7ry6Yvha
         U982qQPyFDIaw5H+XY/LG1TVcXFUS6WZdwkrVFfsRzMBBXYjfjmK+OhWJ118owhYM7LU
         Uo2YrOCDG71fKtU8KXYEz3p+n0ejrG1zkAcNKkBfF187/gtQMGinGJA28GkGZwTw5JgC
         TRP5JwnA0eTXiUou0ewbsZDOov/0gPTXy6lvueseLhzqouwks8p48zX+4VJ8ETAMhB/g
         QUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hDyryaov45i5VpCMwMfYmGC3XG+kMJuhszeqQ9Ks0RE=;
        b=eOdEkAK2a2rChtFC4EGmJ3k1kp97+ZutF9Pg3TMrOwRwwzsBrbBbGsjbEFRM6XEfC3
         1ZcAIBI4DFljZT8F3mlKPjyqx+MErnXHetefy+deNTrdpdOU38lXVxLrZ1TYkzeIvXQk
         HA00zZUhhBtM+zj4LrwddHPRCLSrM7CbEDAO1ScDDjPBPmhcnfIr60Gis6Vz/0tMjTVj
         TGGY/aS4IFK1N2llqozqbNHQOHgJONvP8w/Q9XOCBYNwsSGe7t2/bEzZVq48Gnwyy6Yq
         MAC3e4mnP3218MS6QhnTqnvAYbPTQT0bNmxzrkKebQzL2Ozbg7cAuTX+8udlMef39P3g
         VkrA==
X-Gm-Message-State: AOAM530jaiFhU/W8L1i8tzcqHVmcWRmrnqLEFRVsqxmhh0u7ipobYPC4
        7u3bc2+ta8oxlhPy/HuVBSPGXBac7dI=
X-Google-Smtp-Source: ABdhPJxo/vSQvJAFJ0INA53wCBb82uoM6IPAqlKUBC+Dy0xB7InEVj6uKTqGlrfmiWBnT7ZnQfrXzw==
X-Received: by 2002:adf:aa83:: with SMTP id h3mr576071wrc.108.1610055369682;
        Thu, 07 Jan 2021 13:36:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm10996766wrn.59.2021.01.07.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:07 -0800 (PST)
Message-Id: <41a99640cc55d71659116dd66db6048cfb436e34.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:35:49 +0000
Subject: [PATCH v2 01/17] merge-ort: add new data structures for directory
 rename detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d36a92b59b7..652ff730afa 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -49,14 +49,42 @@ enum merge_side {
 };
 
 struct rename_info {
+	/*
+	 * All variables that are arrays of size 3 correspond to data tracked
+	 * for the sides in enum merge_side.  Index 0 is almost always unused
+	 * because we often only need to track information for MERGE_SIDE1 and
+	 * MERGE_SIDE2 (MERGE_BASE can't have rename information since renames
+	 * are determined relative to what changed since the MERGE_BASE).
+	 */
+
 	/*
 	 * pairs: pairing of filenames from diffcore_rename()
-	 *
-	 * Index 1 and 2 correspond to sides 1 & 2 as used in
-	 * conflict_info.stages.  Index 0 unused.
 	 */
 	struct diff_queue_struct pairs[3];
 
+	/*
+	 * dirs_removed: directories removed on a given side of history.
+	 */
+	struct strset dirs_removed[3];
+
+	/*
+	 * dir_rename_count: tracking where parts of a directory were renamed to
+	 *
+	 * When files in a directory are renamed, they may not all go to the
+	 * same location.  Each strmap here tracks:
+	 *      old_dir => {new_dir => int}
+	 * That is, dir_rename_count[side] is a strmap to a strintmap.
+	 */
+	struct strmap dir_rename_count[3];
+
+	/*
+	 * dir_renames: computed directory renames
+	 *
+	 * This is a map of old_dir => new_dir and is derived in part from
+	 * dir_rename_count.
+	 */
+	struct strmap dir_renames[3];
+
 	/*
 	 * needed_limit: value needed for inexact rename detection to run
 	 *
-- 
gitgitgadget

