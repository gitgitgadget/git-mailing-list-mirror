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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A55CC4332B
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E3820DD4
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbhADDKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbhADDKm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 22:10:42 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E5BC06179A
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 19:09:26 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c5so30767407wrp.6
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 19:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+bBj/3spC8b6bi5zcCITehdRVRVjOAOFrCLkIBojeb0=;
        b=qsoGPaOCOyQr2Fky3NNR9WJ2lz9EPjSI670/w+gxzGD1sA6otcfM9xHiB3NU45yLcD
         SYR0LjtlOJRh8b3ujBjmahNcF7V3Sl3JTduK9ShLYIZSm9t/AW2Ll+ftSwyaATyyPxq+
         VFWCJz0IODi/TVYeVUXjFx3o3l2FkcqVFtkNq4GwbUmOWyrJUaJvEgRXxQL3tBPWcePe
         3GQrSE5PodI9qZ87svz2dEnkTH/tOhyv0SxahjuYXq1WRSFS8HSSUwn5O26HfK8jujJ3
         qzYTPly9zTCg/FdcInUJABWL/InK1tC7FO+rWTHX8sOGhAWg6556yFtCrQX4y2lin9UW
         qBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+bBj/3spC8b6bi5zcCITehdRVRVjOAOFrCLkIBojeb0=;
        b=pjwbKkaVJC5gbLaFDA+M0X5G5MpvZeXUi5tpfOq6LTXH8YgaxGUrtXHOpEigr30ef1
         qfkS4kadhT2cxbSfLoqcdkO2TXoErfY5v/UhYIgBb6Q83hnIBmc7NDx20ScH8UNtPPvM
         Na5qg50Fttw+TNrdd2lslI1GEew8Mkjz+4mPfDYcn1DsSkefDaWWuM0d3WSK06y2AZS0
         akKLDTee/poIlK+3m0FE/HGGmQu09VfP+mBx/ygFiCUhoNTPPHGjCieOO7Hsgo+g2/5B
         JxV6mDtkDGW/lrsX4UzmppuXrheDOWAUGcIe2DBSo4ERd4kjHed6F5o9otucB0nXCLEH
         tYVQ==
X-Gm-Message-State: AOAM532tjV5wvGTrVvzhAqHF0RPhreD16q1Xovk+6Kb/v/TAIxZEJm6C
        hstFesh/jmFOqzuiRSPsWfv7d1Ng5jg=
X-Google-Smtp-Source: ABdhPJxbSv7d9x13pJLkhFFVhCgJ/8eYOG56wDw36EYWEVXEueeWhnYOcHa8Xwt/27o9UEqBDCqUNQ==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr79698688wrx.53.1609729765371;
        Sun, 03 Jan 2021 19:09:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm91114250wrl.95.2021.01.03.19.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 19:09:24 -0800 (PST)
Message-Id: <75b51483d3c7088d0cfae36544966672374c50f9.1609729758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jan 2021 03:09:15 +0000
Subject: [PATCH v2 6/9] index-format: update preamble to cached tree extension
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

