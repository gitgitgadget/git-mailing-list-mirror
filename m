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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27047C4360C
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0060664FBC
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhCPVSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhCPVRf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88EAC0613DA
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v11so8177414wro.7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pou/gpUa9pETGZK+kjLjxjTxUYn5JTnG63neWaT1igc=;
        b=iNvdMlZmWJPGbZRhtMcfw65pQ25l0Oeeb5cArg26+AzWAwOwwoHUaPn6ozBtBzMeEV
         cZE8spU1x1OraT7rfHL2uFEuwF98mea833LtksxjHr1ftD/ST18KsbPzjHpeoQbO5lLj
         WNH29NG8xTZHSoVeBGlKJdNCSH/alAIPjXtgmEYVPcaZejD55ELfEbK+V0oaN+FpP7cM
         o7W3B1n8S2UwWVVOB954FpckpKvneyuPv/pNdteZutKKti1QBrWhIDcigYviF4KPjoBA
         GSbzShlZ/q4EDBSo8dq0FNyBybRsqyO4DF4Zy3yqDxyQva5fBxhfwI3ScemskbjFNhnz
         0Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pou/gpUa9pETGZK+kjLjxjTxUYn5JTnG63neWaT1igc=;
        b=obX841wc/R+pyJg3xexjG10A+QFYgOvHF7nQDa/Gxn0XpOLn1CL1uHYP/Jb7pFS2iu
         ilJSa47z3n8GzivFpqyro8kLT5p9VDcjtiTVX9+HuCwQcd1+SFVHwJ4BtqskKfq6siIz
         T4dC2gRFBT24SSP4cAqTodfjgKgiKqW1nneygqY7TK+cxOSxgjn8tvnoTwLX8ZszqHJg
         eL+0+mLbls4ebP4GwKANwYu9DME1eBwTCXOmmeaDiG+zG4DKLu0qNOYCm5kBPI17b5EB
         Vxv4pgY9NBp2fvZPfWDWGh9+rWUJh0afr3X0iXiDxIBPr7euRyjZgp56r+GVAcJfXWyE
         VY8A==
X-Gm-Message-State: AOAM532j16R29qcOgBX+gQ/nRJl4QcJrdmDmJP6wuRTdl76j2cyF54xQ
        U50Xh7PdWywEUzKX6RVzI/gU9j7nQRk=
X-Google-Smtp-Source: ABdhPJyEdOks5I8I9d4JX5eNuz9zKXfCrtiy9mc8+tE4gGWD+p9Ddm2FCYz3/GQfbKlz3eAwHtOzqg==
X-Received: by 2002:a5d:58e8:: with SMTP id f8mr1004196wrd.102.1615929453478;
        Tue, 16 Mar 2021 14:17:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o188sm551455wme.7.2021.03.16.14.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:33 -0700 (PDT)
Message-Id: <6abb1813ae109f4be991aac7ab8897d35110aa36.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:13 +0000
Subject: [PATCH 25/27] revision: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all index entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior. This case could
be integrated later by ensuring that we walk the tree in the
sparse-directory entry, but the current behavior is only expecting
blobs. Save this integration for later when it can be properly tested.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index b78733f5089b..1eee55934c08 100644
--- a/revision.c
+++ b/revision.c
@@ -1680,6 +1680,7 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 {
 	int i;
 
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct blob *blob;
-- 
gitgitgadget

