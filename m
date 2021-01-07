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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86036C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BA023434
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbhAGQdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbhAGQdg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:33:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F46C0612FC
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:32:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w5so6210157wrm.11
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q090u5Fq3VEjw4SQHi6ensgBXQAOMjkEb5mKuxxqt3k=;
        b=dAYhAyAfOeDLx1mJBLhBOpM9xGT3gzbDH5XVTakDr0RpQF2zbnEu48+ZmskJxDu+Lg
         JhVCL83/frg0iOLTy3pSNZzX+zY4CtUu295EPe33KrZBbB77uSd4EdIyqQQ5gb72XEE/
         CehMml19f5Ylb9asR5A1uu3ZOfV+GXm2JSx9JNkkqBIO9ii0aDO5S7XrdilHlP3lFRzZ
         ge6/JQC5LU2JrZOUT5CKNtOKjSCUxkCkH+j9txEE+iRakLO1HFkn24zUPIC1Eglw4hoU
         LGi99lIVWVz4q082f+Nm9OxQrSZFLUYFp412ka+Sk+livtprhOHpDHeMcO0yk4Ny9fDq
         4dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q090u5Fq3VEjw4SQHi6ensgBXQAOMjkEb5mKuxxqt3k=;
        b=eLG5OABYlz39vWhssmZ+3/CCV6JzYX1DmKssijOj2DDLKXfUGV0h1fLqMb0qKZZY/X
         5QbOMCIz/01q8qsDVhSvq5fb9l2nSYynwOoeaQ0YNHurOD4IyABR9K8D+JrPubAzghDI
         oyF9thK/2J4GF3XVPU0p4NOG/splUyUVI600illTwaKu8/28T5r+zHK2PGaRpM/Cb8JP
         wQsm4UUcRWs3jMWHkEJrjMht3cumXqF6XRzABdooj9rFAYl33vvNrajfc6ZAktMSqLR6
         Y+NgQ4vzMOAQ9DtIaTPPApoV3azMCpWaZ3QD6zZ0GkV92vysPwBWxeWvHLrk32Ox4tkw
         4yNg==
X-Gm-Message-State: AOAM531YEcqhvJqmboyS9gPHpMSPm0G4aSo1MixxrYc3p9ZJDzBdL/nJ
        FmKp/7ABfWNhe5QV9BOAB1nL8E7HcCQ=
X-Google-Smtp-Source: ABdhPJyJPDZxHd8/TacmvB3PouOdyPjpk7IUYnFUZKS/YD4f6XGsFP9GBxVuL/bqSW5GrLFeMHYFzA==
X-Received: by 2002:a5d:6cc2:: with SMTP id c2mr9688246wrc.374.1610037139909;
        Thu, 07 Jan 2021 08:32:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h83sm8961719wmf.9.2021.01.07.08.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 08:32:19 -0800 (PST)
Message-Id: <c5cffb5956ee2f8e55210b64b6686c4cd1c839b6.1610037132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
References: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 16:32:08 +0000
Subject: [PATCH v3 07/10] index-format: update preamble to cache tree
 extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

I had difficulty in my efforts to learn about the cache tree extension
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

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/index-format.txt | 33 +++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index c71314731ec..65dcfa570df 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -138,12 +138,33 @@ Git index format
 
 === Cache tree
 
-  Cache tree extension contains pre-computed hashes for trees that can
-  be derived from the index. It helps speed up tree object generation
-  from index for a new commit.
-
-  When a path is updated in index, the path must be invalidated and
-  removed from tree cache.
+  Since the index does not record entries for directories, the cache
+  entries cannot describe tree objects that already exist in the object
+  database for regions of the index that are unchanged from an existing
+  commit. The cache tree extension stores a recursive tree structure that
+  describes the trees that already exist and completely match sections of
+  the cache entries. This speeds up tree object generation from the index
+  for a new commit by only computing the trees that are "new" to that
+  commit. It also assists when comparing the index to another tree, such
+  as `HEAD^{tree}`, since sections of the index can be skipped when a tree
+  comparison demonstrates equality.
+
+  The recursive tree structure uses nodes that store a number of cache
+  entries, a list of subnodes, and an object ID (OID). The OID references
+  the existing tree for that node, if it is known to exist. The subnodes
+  correspond to subdirectories that themselves have cache tree nodes. The
+  number of cache entries corresponds to the number of cache entries in
+  the index that describe paths within that tree's directory.
+
+  The extension tracks the full directory structure in the cache tree
+  extension, but this is generally smaller than the full cache entry list.
+
+  When a path is updated in index, Git invalidates all nodes of the
+  recursive cache tree corresponding to the parent directories of that
+  path. We store these tree nodes as being "invalid" by using "-1" as the
+  number of cache entries. Invalid nodes still store a span of index
+  entries, allowing Git to focus its efforts when reconstructing a full
+  cache tree.
 
   The signature for this extension is { 'T', 'R', 'E', 'E' }.
 
-- 
gitgitgadget

