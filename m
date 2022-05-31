Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF435C4332F
	for <git@archiver.kernel.org>; Tue, 31 May 2022 16:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346259AbiEaQ7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 12:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346263AbiEaQ7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 12:59:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B611B6AA42
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d26so13918997wrb.13
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdiSWKYP7uWYwexFewK1EHJ4E+JOC0Qkc6qzkNqKMfc=;
        b=GqwKpfScZAs0rqllh8xMNDPaGFwq5FDdeMqyG3XABPXWdEra6n7uhjcQNO3JRc7yRI
         dtirYMjw9A4mikkkTHDNb/jhHgvnirGmSozCtsppR9mvcciY2Ye8teBRnjJwYqqvYcY2
         dTCowzOScqTzGMVvtpDiNzmZjK830ZFJylw+maJSYMJia5AL7DLSVa+7fQM1KXi++Tc0
         bkHlchMU2f35DbVEKlROvLbbBXvkcs7Xnhdsjhk5a2CbBM4HFcm6YRsbjznpceYsAPwL
         /6hPXqex9U8IWQ5tg9hWC+v7FoY/adH0UofyH/v2ZkZy68SS/11Hj+2b1Jg1NgH4gL/R
         fCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdiSWKYP7uWYwexFewK1EHJ4E+JOC0Qkc6qzkNqKMfc=;
        b=BhQJrY8l2O5SwUnQ6bJy1whMg8PZXCofWXVfH1B2AvR8lMBWpvihO17JUoC3t/kqAN
         fdfeHfRSlL8T5Wqv68hzk8txZoTXoFlRM+n56bjqqhWbpbsP6tKKVKCvLtxYJQ5qYcbD
         6w6hFGP7RdDRX5DIPAlR55mQPiFquKd7+TQsI4qZGNdgL4WfsHWP/OxWo0M/z1f330FY
         fi0RcdCZI5TjnUJbz+Fwdg8XX7hliJGuP48+mzztX4lP+L1/ZGzYCklsE4WeQUHtCRqo
         C7hHToe2wKs5pja5CF62SGEjrQsnhPCXa4fsIgr4uIgV2AVGOfyViGrsxielm3URyQLb
         lB1g==
X-Gm-Message-State: AOAM5321J//dDSIHrhJIQfc0PMIne7mtq4us150PP8g1JgEdJrQuDxrL
        KT2m2NCj70Ie98STxLLw/pC+5M+nCQta9g==
X-Google-Smtp-Source: ABdhPJxXi619KisjzMS3UU+TfZBt+j8jGrXiONP6Q2zWMjIh30nJ7wEIGmfOg0I2H/3GMAgqrhKCzQ==
X-Received: by 2002:a5d:4450:0:b0:210:e8b:7896 with SMTP id x16-20020a5d4450000000b002100e8b7896mr21930810wrr.490.1654016349941;
        Tue, 31 May 2022 09:59:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d47c3000000b0020d0cdbf7eesm12829820wrc.111.2022.05.31.09.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 09:59:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] cache-tree.c: use bug() and BUG_if_bug()
Date:   Tue, 31 May 2022 18:58:48 +0200
Message-Id: <patch-v2-6.6-cbbe0276966-20220531T164806Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1100.g16130010d07
In-Reply-To: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "BUG" output originally added in a97e4075a16 (Keep
rename/rename conflicts of intermediate merges while doing recursive
merge, 2007-03-31), and later made to say it was a "BUG" in
19c6a4f8369 (merge-recursive: do not return NULL only to cause
segfault, 2010-01-21) to use the new bug() function.

This gets the same job done with slightly less code, as we won't need
to prefix lines with "BUG: ". More importantly we'll now log the full
set of messages via trace2, before this we'd only log the one BUG()
invocation.

While we're at it let's replace "There" with "there" in the message,
i.e. not start a message with a capital letter, per the
CodingGuidelines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 6752f69d515..b91995af602 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -692,14 +692,14 @@ struct tree* write_in_core_index_as_tree(struct repository *repo) {
 	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
 	if (ret == WRITE_TREE_UNMERGED_INDEX) {
 		int i;
-		fprintf(stderr, "BUG: There are unmerged index entries:\n");
+		bug("there are unmerged index entries:");
 		for (i = 0; i < index_state->cache_nr; i++) {
 			const struct cache_entry *ce = index_state->cache[i];
 			if (ce_stage(ce))
-				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
-					(int)ce_namelen(ce), ce->name);
+				bug("%d %.*s", ce_stage(ce),
+				    (int)ce_namelen(ce), ce->name);
 		}
-		BUG("unmerged index entries when writing inmemory index");
+		bug("unmerged index entries when writing inmemory index");
 	}
 
 	return lookup_tree(repo, &index_state->cache_tree->oid);
-- 
2.36.1.1100.g16130010d07

