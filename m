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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D59C3E8C5
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DB0207CD
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ievJt+GL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgK2Hp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgK2Hp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:45:27 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA86C061A56
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:41 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t4so10781391wrr.12
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5Vqos9ENXW+RP/6IqXk99famSFdcxfCZlVpwjy1vIpo=;
        b=ievJt+GLJjyr3WDrITmLxTTtYIP4IpOV71sFKvwHdcopzZb5D8gdAv9llRGEaq9CyR
         Tas5D2bQv6d8PcbXaz5HmSP24G0ujzJbCeh5UFekYsyOIc65USnwADK6nmX2R2Lh/uD2
         q7ZerlNbz8HhiKWjdkTm3rrNXuC+ioHM9P7MpLYkqXbt6YuFPw2QGzFsEnGYy/QL3YLZ
         QaTIc4bpVwAzZGTjCkg6nokixdbFHA5gd28xmBZenHhA0TTENkCBG4GGk0iHxz40UTEi
         +8L0iA3QKVBkMpDCABfXeUBz1QEK/icZIRcLsYgHfYFejcykw59mGnTpTkrduHkk5JhN
         Sbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5Vqos9ENXW+RP/6IqXk99famSFdcxfCZlVpwjy1vIpo=;
        b=mmOPzyIsFkLMsadR0YTFjcUrO4OUqkE9f7v9z0TX1AvLiBd87gYlDOgWuupYrx/7Hs
         3QRzSnUu+AqRiJH+8lz4b/nnGPywYH4r/ZiZJXIzuXIzwCxa0pXG6mWopFAQMQkZ9Kbi
         2fZuXaJFCk3xqPU/gal7OsV5t82XTuqaxKORo7rzWV2ydROfNJFc9kLOqWvud8wCtgKp
         wGuCoyiAeRzArSAl6oSP9ZrtbKG9A2KvjSeqfjGT8XH0mk1o4BNe80DXTxn3CT2nhxxx
         u4j446tJqdOSoT2VJx3tHcvSnxY7E6pyWPKRCqQzzfT++pj9svYHGjW/ZNqT8ntHGR4i
         memg==
X-Gm-Message-State: AOAM532I6RLTMcW4aAaYKFt2xlnsifYcbdnFbQ1IaD2In8wvggnlByt2
        gdltqeGOauGHH58FmLip3WmxQDfVlrE=
X-Google-Smtp-Source: ABdhPJz5+F0UDUiaj5btlTpQtjQeXjGMSNNVMWW0VVQ/NT5rlaidyA9aAjU8rOSELskP6oNgv/RvsQ==
X-Received: by 2002:adf:fc8c:: with SMTP id g12mr21308679wrr.355.1606635820178;
        Sat, 28 Nov 2020 23:43:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 35sm22301086wro.71.2020.11.28.23.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:39 -0800 (PST)
Message-Id: <a3cd563621c0589e18761cd1b93b1c7288183e71.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:21 +0000
Subject: [PATCH 18/20] tree: enable cmp_cache_name_compare() to be used
 elsewhere
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 tree.c | 2 +-
 tree.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tree.c b/tree.c
index e76517f6b1..a52479812c 100644
--- a/tree.c
+++ b/tree.c
@@ -144,7 +144,7 @@ int read_tree_recursive(struct repository *r,
 	return ret;
 }
 
-static int cmp_cache_name_compare(const void *a_, const void *b_)
+int cmp_cache_name_compare(const void *a_, const void *b_)
 {
 	const struct cache_entry *ce1, *ce2;
 
diff --git a/tree.h b/tree.h
index 9383745073..3eb0484cbf 100644
--- a/tree.h
+++ b/tree.h
@@ -28,6 +28,8 @@ void free_tree_buffer(struct tree *tree);
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
 struct tree *parse_tree_indirect(const struct object_id *oid);
 
+int cmp_cache_name_compare(const void *a_, const void *b_);
+
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, int, void *);
 
-- 
gitgitgadget

