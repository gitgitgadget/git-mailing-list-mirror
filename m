Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B5C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiHDQ3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbiHDQ3S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:29:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE6267CBA
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:29:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p8-20020a05600c05c800b003a50311d75cso2271780wmd.4
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eodntviBtOj5eEEAlVrXDixkAAvFNkyH9eBG1ScoJWI=;
        b=iXkBNS/d7ZKPQ6xy23Un1VDoMEeHLOqjjf6exjhFEO5HF7RcGpjzpdypnuCnpGpQQz
         SYu0Hbc6xIWGZcCw9NOWrCaOz/JyYVcrf6jc7+nnexrkOnHJWiL5OrvoVZxlcAiH0Dqt
         tZO2Gb8TRs4PN+7tXCYDlw6tJZetq8mu5rzdLkl6jRHyFfCl5i/709v7iPb0CC8OLIPD
         Vv0Q0Z3/FA+z1YSRGoHVvgV3yxXBDCb0eKDmFhkCLZR3ZVGYWyX1ClXHaSYXbQdribO4
         I8B3iPY5OMYFqvZirf3SYb4Gr9DwpuV7PyJV5eIq5cBgedOek3PI7KWaT8DxzuPQn2gr
         6XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eodntviBtOj5eEEAlVrXDixkAAvFNkyH9eBG1ScoJWI=;
        b=mx6in1XSPqhc18wU6N3OY52bTMaDQDSCPSO9yq08jeIimdhIEqq62WoPqQxQ7iWGrA
         2jl153VQfDDsIjkIZYK7Pq6wYNZY8iURdLlCNvvUFLNCHbvGDpK1Vl0K/sjP4DbN6Vqo
         Z8iUHTIMcGbmVvIShXhr0Hw77eHiI4uhxQGQGxRZz7bX07a0NFb3FAdH/Mz0L4Mw3j8+
         Fv1uQjVT3o8xsvkqwX/VKMPjCe1ezFYKlyPP34+mkeIq4BKfMMRWOfYNTR+bqVWlWnua
         YLjQVbuCpZR+EI2bh40YpDFoMhhbo6dl1b8FYRsFuyo8Yrdq3NFDMOIhopVg3qe6JOCN
         /+aQ==
X-Gm-Message-State: ACgBeo16ivTWW9kekodL+KdW18J9JGAwUjYUNy7P78Rm704cZYw3juE9
        +hR0nPjICfy6wkJpEmw4p7AQkMkROCfhcA==
X-Google-Smtp-Source: AA6agR5BPB4gc100QiCO+JWuLv5YTCVfbFuKIH2oXngLwQcSX2w8DRBLyGqYwEQwyfsV6LRIRxqPoA==
X-Received: by 2002:a7b:c7d4:0:b0:3a5:737:3e1e with SMTP id z20-20020a7bc7d4000000b003a507373e1emr2004454wmk.123.1659630541836;
        Thu, 04 Aug 2022 09:29:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a513ee7830sm1868063wme.27.2022.08.04.09.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:29:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 09/12] docs: move signature docs to man section 5
Date:   Thu,  4 Aug 2022 18:28:38 +0200
Message-Id: <patch-v8-09.12-42a4a3c3be8-20220804T162138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.g61622908797
In-Reply-To: <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com> <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the move of existing Documentation/technical/* protocol and
file-format documentation into our main documentation space by moving
the signature format documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  2 +-
 ...ure-format.txt => gitformat-signature.txt} | 21 ++++++++++++++++---
 command-list.txt                              |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)
 rename Documentation/{technical/signature-format.txt => gitformat-signature.txt} (96%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 029067a77d5..d122d1751d8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -27,6 +27,7 @@ MAN5_TXT += gitattributes.txt
 MAN5_TXT += gitformat-bundle.txt
 MAN5_TXT += gitformat-commit-graph.txt
 MAN5_TXT += gitformat-index.txt
+MAN5_TXT += gitformat-signature.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
 MAN5_TXT += gitmailmap.txt
@@ -115,7 +116,6 @@ TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/reftable
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
-TECH_DOCS += technical/signature-format
 TECH_DOCS += technical/trivial-merge
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
diff --git a/Documentation/technical/signature-format.txt b/Documentation/gitformat-signature.txt
similarity index 96%
rename from Documentation/technical/signature-format.txt
rename to Documentation/gitformat-signature.txt
index 166721be6f6..a249869fafa 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/gitformat-signature.txt
@@ -1,7 +1,18 @@
-Git signature format
-====================
+gitformat-signature(5)
+======================
 
-== Overview
+NAME
+----
+gitformat-signature - Git cryptographic signature formats
+
+SYNOPSIS
+--------
+[verse]
+<[tag|commit] object header(s)>
+<over-the-wire protocol>
+
+DESCRIPTION
+-----------
 
 Git uses cryptographic signatures in various places, currently objects (tags,
 commits, mergetags) and transactions (pushes). In every case, the command which
@@ -200,3 +211,7 @@ Date:   Wed Jun 15 09:13:29 2016 +0000
     # gpg:          There is no indication that the signature belongs to the owner.
     # Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
 ----
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/command-list.txt b/command-list.txt
index 5e8d8386683..68212e3c1bd 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -212,6 +212,7 @@ gitfaq                                  guide
 gitformat-bundle                        developerinterfaces
 gitformat-commit-graph                  developerinterfaces
 gitformat-index                         developerinterfaces
+gitformat-signature                     developerinterfaces
 gitglossary                             guide
 githooks                                userinterfaces
 gitignore                               userinterfaces
-- 
2.37.1.1233.g61622908797

