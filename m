Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBEBCCA483
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 20:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiGLUHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiGLUHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 16:07:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9BBB41A0
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 13:07:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so48113wme.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bi+z7dkLzTkyZRVmX2i1PwNtT+m3jdLnkYhyd+rAfdQ=;
        b=g7Na8OFXLV9IRJ/mGYguidJFNqlzWZ2qHd0DVmBzkm7AYRUYMN4T0+6MYiecmwHYfo
         ryfgFpUrncjyauT5fiyJHiXVECfuG9pIDWkmZADvP7fw/jFFqK/4z3C5kOKvsHeOslRC
         7qvdj9yYj8LeDVunha9Ryzg5F72KkWfN0NXqjQm9C3OUFBjRX/YpljBLCJ7rov07wYqD
         TUg0fDQ7D0HMCIwiOLm9zyOUoLNvp+lgu+tX8NFMxszNue2DM4HBq6PaE2E88HlQbwku
         Rp4AQisZSxyrYClzTdEBJzEgwEN75PXiUBLUKozyTDtafytD6GfhxA5XOdheQz0YuqYo
         pORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bi+z7dkLzTkyZRVmX2i1PwNtT+m3jdLnkYhyd+rAfdQ=;
        b=totP4LdLL9w0RS8B2G5gpIODkn5EaUa0NOr+6SXna1tS02dVbtJFNI7l8bEh3xShf/
         bNJbMUfYzI7oRdm2xGmrBb4ytS1kDfqjGUt8/3qhHxQdEtIzeO5SreVzMybTLVIQuB8h
         agcReeKqI1lUsH8fZqHhhA1Kykuy2X/EQXMsSXDS7OOH4ngpmF5h9zXnALkTcyubmg8D
         sApXsXVMjKOzxevYr1fqf4pjufL+bukHulIIBLERnH983BI8X65D97j93nBZdT5qNoj4
         M8+6UNKwAOtk536u+CU8UviOUCsW1GdlfPD9u32TQcWdNtHebxGJzkwYlleL+GQYKJaS
         2HwA==
X-Gm-Message-State: AJIora8tj7lu800po60HR/Cis6Kle743u7tMLaPBCD9wn+eRtlJP/hWr
        bH2assgZ5F+Y0cg9eHVQwpitlsZ4zuqaIQ==
X-Google-Smtp-Source: AGRyM1sh98bqGsQK3S7FaIAbJzlKsLaBqYpo3Gr/is2F9hjINOKojOesSpKlDtFvHVA8NnmVuDp68g==
X-Received: by 2002:a05:600c:4f55:b0:3a1:f1c5:2107 with SMTP id m21-20020a05600c4f5500b003a1f1c52107mr5759626wmq.114.1657656441185;
        Tue, 12 Jul 2022 13:07:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b5-20020adfe305000000b0021d8c8c79dbsm8929448wrj.65.2022.07.12.13.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:07:20 -0700 (PDT)
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
Subject: [PATCH v3 7/7] docs: move multi-pack-index docs to man section 5
Date:   Tue, 12 Jul 2022 22:07:02 +0200
Message-Id: <patch-v3-7.7-aabdc4a4151-20220712T195419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the move of existing Documentation/technical/* protocol and
file-format documentation into our main documentation space by moving
the multi-pack-index documentation over.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  2 +-
 Documentation/git-multi-pack-index.txt        |  5 +++--
 ...dex.txt => gitformat-multi-pack-index.txt} | 20 +++++++++++++++++--
 Documentation/gitformat-pack.txt              |  5 +++++
 command-list.txt                              |  1 +
 5 files changed, 28 insertions(+), 5 deletions(-)
 rename Documentation/{technical/multi-pack-index.txt => gitformat-multi-pack-index.txt} (94%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0e87d5151df..51c3e3a489a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -28,6 +28,7 @@ MAN5_TXT += gitformat-bundle.txt
 MAN5_TXT += gitformat-chunk.txt
 MAN5_TXT += gitformat-commit-graph.txt
 MAN5_TXT += gitformat-index.txt
+MAN5_TXT += gitformat-multi-pack-index.txt
 MAN5_TXT += gitformat-pack-bitmap.txt
 MAN5_TXT += gitformat-pack-cruft.txt
 MAN5_TXT += gitformat-pack-protocol.txt
@@ -109,7 +110,6 @@ TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/long-running-process-protocol
-TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index a48c3d5ea63..a147e047c91 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -127,8 +127,9 @@ $ git multi-pack-index verify
 
 SEE ALSO
 --------
-See link:technical/multi-pack-index.html[The Multi-Pack-Index Design
-Document] and linkgit:gitformat-pack[5] for more information on the
+
+See linkgit:git-multi-pack-index[1] and
+linkgit:gitformat-multi-pack-index[5] for more information on the
 multi-pack-index feature and its file format.
 
 
diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/gitformat-multi-pack-index.txt
similarity index 94%
rename from Documentation/technical/multi-pack-index.txt
rename to Documentation/gitformat-multi-pack-index.txt
index f2221d2b441..3bca1e7b10d 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/gitformat-multi-pack-index.txt
@@ -1,5 +1,17 @@
-Multi-Pack-Index (MIDX) Design Notes
-====================================
+gitformat-multi-pack-index(5)
+=============================
+
+NAME
+----
+gitformat-multi-pack-index - The multi-pack-index file format
+
+SYNOPSIS
+--------
+[verse]
+$GIT_DIR/objects/pack/multi-pack-index
+
+DESCRIPTION
+-----------
 
 The Git object directory contains a 'pack' directory containing
 packfiles (with suffix ".pack") and pack-indexes (with suffix
@@ -98,3 +110,7 @@ Related Links
 
 [2] https://lore.kernel.org/git/alpine.DEB.2.20.1803091557510.23109@alexmv-linux/
     Git Merge 2018 Contributor's summit notes (includes discussion of MIDX)
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index 5b21d0f2521..06b469c6944 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -507,6 +507,11 @@ packs arranged in MIDX order (with the preferred pack coming first).
 The MIDX's reverse index is stored in the optional 'RIDX' chunk within
 the MIDX itself.
 
+SEE ALSO
+--------
+
+linkgit:gitformat-multi-pack-index[5]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/command-list.txt b/command-list.txt
index fad553784d9..685ce8077d3 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -212,6 +212,7 @@ gitformat-bundle                        gitformats
 gitformat-chunk                         gitformats
 gitformat-commit-graph                  gitformats
 gitformat-index                         gitformats
+gitformat-multi-pack-index              gitformats
 gitformat-pack                          gitformats
 gitformat-pack-bitmap                   gitformats
 gitformat-pack-cruft                    gitformats
-- 
2.37.0.932.g7b7031e73bc

