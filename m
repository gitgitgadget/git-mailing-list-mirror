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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B0BC433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E84F22262
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgL3T2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgL3T2R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:28:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1740DC06179F
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:27:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 91so18298731wrj.7
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+bBj/3spC8b6bi5zcCITehdRVRVjOAOFrCLkIBojeb0=;
        b=iW42aGqmh0oc6g5IAmbJkJQsvZCi7qH8HN3d5ZuofwYaUpbKPTsQ7F0BLzsrkAZ5Jb
         Frxdfb3Uok6SS7LDnyi45GPqAPz8YJ3MKZlOZ4HKSrIZAeCUpAL9gwEveLvaY+XlG1Od
         e5w9ziyRs2rnqYgBaUA7YyHH0jdtWCbGPyL2PhoiFoAOTk1O/03YQOU3PNMHTViUSViI
         Gows3KwtYa199LDHcZ3shVlBZZ2Hf6eeAoFYUVumZs3Sy5NBrGWOr99xwG8PW+B2o8CD
         N33c7PYIPAaWnQ0Ktwui1v/OxE+YMT30OSQ+egz0JX0XOiU2Z4iIr8at+jyTbajwE4Cr
         YObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+bBj/3spC8b6bi5zcCITehdRVRVjOAOFrCLkIBojeb0=;
        b=mL6bSZpke9hNokSyVJPz70XCx6dJZpSYC5YuTsPnFL6kt2ICy8P+FZYSufyB1K5Wan
         I0i+hkJV9ej2QAERsQP5gJOyyb+QwYzFDPPdsxyE8wXRiZwX4VgqxsKqmGbpQF0or6KD
         uU4uRZ0bBueCP/HDn7wIZLsHMh1BglW4OgPQJwnH0NhhwTu7YvjvyhO7ArhgC8OuvvMo
         FiH9IFHHaSYSkSD94iQbwn7F7ZulJTxRUtjozX6uBYroP2Z5OqAVoKz72EkLccQFYBqH
         X5QzFYKih3Rg17+CdB5UN+0sdN2ocLiHYxbKLH+JNJ8I3yHzw/LTBOIf1Mwn4eV+2HHe
         mEzw==
X-Gm-Message-State: AOAM532Hdfhwt26IdZ9sxOsjq+F1oLgF9t16z4zfvG60KP052S2D3F8J
        S6NDX/uR1qaKp395mzjReccb7wdhGrY=
X-Google-Smtp-Source: ABdhPJwaRyM91m8U2eKRHi1UQY07VXJ+e1h078EhNfgfZgO239bf/wNJSU6QmC5yL5xr6kSBbU1+dw==
X-Received: by 2002:adf:a50a:: with SMTP id i10mr61791741wrb.123.1609356419684;
        Wed, 30 Dec 2020 11:26:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 189sm8570431wma.22.2020.12.30.11.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 11:26:59 -0800 (PST)
Message-Id: <fb9d5468184c4cbb3d80569f685743b9a5b45c8e.1609356414.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.1609356413.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Dec 2020 19:26:51 +0000
Subject: [PATCH 6/8] index-format: update preamble to cached tree extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

I had difficulty in my efforts to learn about the cached tree extension
based on the documentation and code because I had an incorrect
assumption about how it behaved. This might be due to some ambiguity in
the documentation, so this change modifies the beginning of the cached
tree format by expanding the description of the feature.

My hope is that this documentation clarifies a few things:

1. There is an in-memory recursive tree structure that is constructed
   from the extension data. This structure has a few differences, such
   as where the name is stored.

2. What does it mean for an entry to be invalid?

3. When exactly are "new" trees created?

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/index-format.txt | 36 ++++++++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 69edf46c031..c614e136e24 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -138,12 +138,36 @@ Git index format
 
 === Cached tree
 
-  Cached tree extension contains pre-computed hashes for trees that can
-  be derived from the index. It helps speed up tree object generation
-  from index for a new commit.
-
-  When a path is updated in index, the path must be invalidated and
-  removed from tree cache.
+  Since the index does not record entries for directories, the cache
+  entries cannot describe tree objects that already exist in the object
+  database for regions of the index that are unchanged from an existing
+  commit. The cached tree extension stores a recursive tree structure that
+  describes the trees that already exist and completely match sections of
+  the cache entries. This speeds up tree object generation from the index
+  for a new commit by only computing the trees that are "new" to that
+  commit.
+
+  The recursive tree structure uses nodes that store a number of cache
+  entries, a list of subnodes, and an object ID (OID). The OID references
+  the exising tree for that node, if it is known to exist. The subnodes
+  correspond to subdirectories that themselves have cached tree nodes. The
+  number of cache entries corresponds to the number of cache entries in
+  the index that describe paths within that tree's directory.
+
+  Note that the path for a given tree is part of the parent node in-memory
+  but is part of the child in the file format. The root tree has an empty
+  string for its name and its name does not exist in-memory.
+
+  When a path is updated in index, Git invalidates all nodes of the
+  recurisive cached tree corresponding to the parent directories of that
+  path. We store these tree nodes as being "invalid" by using "-1" as the
+  number of cache entries. To create trees corresponding to the current
+  index, Git only walks the invalid tree nodes and uses the cached OIDs
+  for the valid trees to construct new trees. In this way, Git only
+  constructs trees on the order of the number of changed paths (and their
+  depth in the working directory). This comes at a cost of tracking the
+  full directory structure in the cached tree extension, but this is
+  generally smaller than the full cache entry list in the index.
 
   The signature for this extension is { 'T', 'R', 'E', 'E' }.
 
-- 
gitgitgadget

