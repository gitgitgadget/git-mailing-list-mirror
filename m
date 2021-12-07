Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6769EC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbhLGUFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhLGUFv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:05:51 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1AC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:02:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso2615759wms.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SW7KP2FKXWZD8JoH4kNbs/21W1QaalBtFoxsXrhI4vw=;
        b=o2h8h24y5txHw4js0XBSHW58TtkNNy9so/WLAsQptRFkvpG2XLNH+xAsN2n7gdSVLh
         T5oBr0mQbVMmj+lMnkDL0iu1jsY+PPnVVgdDH0ePyknHM/Wbb3qzsqGyqWx9JO8iIU0S
         DgRIjjTjD6ijGq76mGUrLAYGCVc8mU7skRUiivz51jfpQFCy5oTZ+yIA8jOttgJKv6xn
         H5eWpQnRXPIzs0yJu53xDb2aWxi4eEpNlS/5sZwOZ/ZxgtNYyzILvp1CofXc77KaTMB7
         psviG1DS9tKi77V+43tmhSV/4YM54ZrtMRtSY8HTGdFbO3aIWwkGmWM5fvhDDPK8Ti6M
         5I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SW7KP2FKXWZD8JoH4kNbs/21W1QaalBtFoxsXrhI4vw=;
        b=r3fMKo8GVIyhmqmcAvfWUBm1PTezCWiLO4WvSbUMOH6FDVBZnydXWnu36RoYN7Gr4y
         TAW+KIR3MwoT6TMJJ2VpAzIBDYOxthbVPW7BLurmX2gsY85Ei3ktiA8TL2o/OEYy+PrH
         LrotWdTvkc074zPxZq4+BbadBXrma0el+allriiWTkjoajaceprO+Y8OoelDZ/TxYZKW
         hEWE1XDTt2TOXnOar4O4ISVG69OzCCwcORpPx83qVPLLK6N8AviB1PNt7h9oZjeQ/gF6
         BqZW65gTxDRvXmFKca1ZqMM7o3rwi9Wk5niGzItp807Jvwm4e0yMQw59fZfADuOIxSDG
         zkiw==
X-Gm-Message-State: AOAM530lfMla38JzLHdXwETGXBYnb1mk6wMUoo8HYKS4auxjEL0HSkMO
        2uoIBE2KhvZ3gMgRNb9UxDqjWGZN23g=
X-Google-Smtp-Source: ABdhPJwBh/xex07PqjoVmNMC/mR+NW5A6en4YTu7qFrDkwdvhSDI5zmLDuajqQK3iMKrxFS5X4HwKQ==
X-Received: by 2002:a7b:cd02:: with SMTP id f2mr9717845wmj.115.1638907338631;
        Tue, 07 Dec 2021 12:02:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm767203wre.46.2021.12.07.12.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:02:18 -0800 (PST)
Message-Id: <becbee16d2ee503a7f698364aef672d4cadf5079.1638907336.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
References: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:02:14 +0000
Subject: [PATCH 1/3] sparse-checkout: fix segfault on malformed patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Then core.sparseCheckoutCone is enabled, the sparse-checkout patterns are
used to populate two hashsets that accelerate pattern matching. If the user
modifies the sparse-checkout file outside of the 'sparse-checkout' builtin,
then strange patterns can happen, triggering some error checks.

One of these error checks is possible to hit when some special characters
exist in a line. A warning message is correctly written to stderr, but then
there is additional logic that attempts to remove the line from the hashset
and free the data. This leads to a segfault in the 'git sparse-checkout
list' command because it iterates over the contents of the hashset, which is
no invalid.

The fix here is to stop trying to remove from the hashset. Better to leave
bad data in the sparse-checkout matching logic (with a warning) than to
segfault. If we are in this state, then we are already traversing into
undefined behavior, so this change to keep the entry in the hashset is no
worse than removing it.

Add a test that triggers the segfault without the code change.

Reported-by: John Burnett <johnburnett@johnburnett.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              |  3 ---
 t/t1091-sparse-checkout-builtin.sh | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 5aa6fbad0b7..0693c7cb3ee 100644
--- a/dir.c
+++ b/dir.c
@@ -819,9 +819,6 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		/* we already included this at the parent level */
 		warning(_("your sparse-checkout file may have issues: pattern '%s' is repeated"),
 			given->pattern);
-		hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
-		free(data);
-		free(translated);
 	}
 
 	return;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 272ba1b566b..c72b8ee2e7b 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -708,4 +708,19 @@ test_expect_success 'cone mode clears ignored subdirectories' '
 	test_cmp expect out
 '
 
+test_expect_success 'malformed cone-mode patterns' '
+	git -C repo sparse-checkout init --cone &&
+	mkdir -p repo/foo/bar &&
+	touch repo/foo/bar/x repo/foo/y &&
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/foo/
+	!/foo/*/
+	/foo/\*/
+	EOF
+	cat repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout list
+'
+
 test_done
-- 
gitgitgadget

