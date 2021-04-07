Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17FCC43460
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62226121E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhDGW4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhDGW4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:56:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D447C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:56:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b4so716613lfi.6
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mSugcimYS1yM0nhmdIY7KmBpLpqgyja/1sAs1db3Q5s=;
        b=cB13QoxQfRxPWYy/n8Woz/Lf91ulZgg7ggZGPkOjVlXFQOGTPsxZ9PKnQpYhL1W65f
         bqDm6pbb0bcoT+oNacXsGmvo3v75LOl2Sr6/UhzQaMDHCT4lMVNtg5q6pN75g478hO/Y
         TIvu/6AlXdkM0qpxEaAgDLcieUaraWGf18jj8tjI07PkyGZl6Iw0uOxpGCwuufZAemWR
         U28IPzAVmNLCb68FbagJzi/g9df6T1AXZZVjdDfpJTcTSoXQouCIJXSPxvPFMCx7++OD
         0FUA5BQqPoFFYqnIrFKRHwDvYAGzQdD3pVGV/JcdTxdsH6CSLxe5nMpyqz/TIs9i3O3u
         lnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSugcimYS1yM0nhmdIY7KmBpLpqgyja/1sAs1db3Q5s=;
        b=ApfhX0TPhWrQH+cu0g2C3JrVb/uyEe6rRWZZ2SnjUA7iegpr9MzKq5nsItv5fqdP9G
         X9W7jkAtUPdy/LaytUWnrw9NoHNSulbVmO9YtgStnHduQbnIBEi4FQvpUGbChRDhzC1n
         Vp34V0bPX58BPWcY54njvE+lxoU1Nr7tnN8/Qv8pfRt4FEKhvgU/wO9Y25GuLIpi4W9p
         hpQUdGQ/9Xt3AX+UN/Tw6kFZ+28a6Ul7Uh0XiR4TI3bxVVXCHsBLHJUn09FNNmu4MFvh
         9gADNBorwAwPwirylzQ2yaIZZeekTFhIEekg21h5WdpyhZZkUfG9btcnytrzvQgjEGPT
         SZsg==
X-Gm-Message-State: AOAM531sGTLSypeh0hla1gUaPbFzCPw5wfzyo3Yof7jwwFIWda201rQd
        ePCnSp75zIadmhRCy9HjVbE=
X-Google-Smtp-Source: ABdhPJzTEtcJK34mWHHThhUvb9+H1EVtL/NmYaeo+KZbt8Ds7JQfp9FUGtsDMZwfboci0r5ZH3pdnw==
X-Received: by 2002:a05:6512:c04:: with SMTP id z4mr3980844lfu.299.1617836184746;
        Wed, 07 Apr 2021 15:56:24 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t25sm2580101ljo.102.2021.04.07.15.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:56:24 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 4/9] diff-merges: adapt -m to enable default diff format
Date:   Thu,  8 Apr 2021 01:56:03 +0300
Message-Id: <20210407225608.14611-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407225608.14611-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let -m option (and --diff-merges=m) enable the default format instead
of "separate", to be able to tune it with log.diffMerges option.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index ca4d94a9039d..f68e4376fd63 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -34,10 +34,10 @@ static void set_m(struct rev_info *revs)
 {
 	/*
 	 * To "diff-index", "-m" means "match missing", and to the "log"
-	 * family of commands, it means "show full diff for merges". Set
+	 * family of commands, it means "show default diff for merges". Set
 	 * both fields appropriately.
 	 */
-	set_separate(revs);
+	set_to_default(revs);
 	revs->match_missing = 1;
 }
 
@@ -61,13 +61,13 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
 		return suppress;
 	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
 		return set_first_parent;
-	else if (!strcmp(optarg, "m") || !strcmp(optarg, "separate"))
+	else if (!strcmp(optarg, "separate"))
 		return set_separate;
 	else if (!strcmp(optarg, "c") || !strcmp(optarg, "combined"))
 		return set_combined;
 	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
 		return set_dense_combined;
-	else if (!strcmp(optarg, "def"))
+	else if (!strcmp(optarg, "m") || !strcmp(optarg, "def"))
 		return set_to_default;
 	return NULL;
 }
-- 
2.25.1

