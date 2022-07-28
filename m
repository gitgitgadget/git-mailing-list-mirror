Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33516C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiG1Qr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiG1QrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:47:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81AF6E2F7
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:47:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id id17so1304724wmb.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NZgmalU7gm5xuyasxQh844hcSmWQK8SyDQOsirqs2BI=;
        b=Bf+uxZO6ZkCfjgBuoKzlw8S/kRvr353fDtUx8ucwgKOc8ciLLXOsu/FBZ4jh+E5liF
         RWyg1F53/LVm1581Isz9vrrgMB68O2NseTj+yHy2MyS8V2YFt07GB//o9O0FPYHq1bsA
         IFCO0ILr0l3JVMQ4KAs9sbM/ARb3T615zpZd/He7Ghp+BnWJ/Y6q4nFxAokgFKZgqLYn
         JxNox928ctI9M9wbJHLIqaNdn5ny3fHoaYe5I3wEZcOXIeL/aNrXfs6ZJCDCSNuGHMr8
         YtdHhGewIP81vPtyiwAb4qyJWXLCKE9GZIoIak7739WGjUvzVGz54m4lgRu3bw56xCJ+
         Ipig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NZgmalU7gm5xuyasxQh844hcSmWQK8SyDQOsirqs2BI=;
        b=cT3LWjVNsUySUwvkpviInLhz+66CtmyJ6sUpKtPndDXWpcuNULEvlCmeDK5Z6sp6zQ
         mM7AsSHN31dXw0/L1278/Qrg2Df0OwEiofWkwAG4+cMcdXKGAcX954gehPiVPxZDsR+G
         aQa1wNzqOyZ8RzeEB7WF1ql4lQjfExlkp2LRTJ97Up7uOr4inM39uSRqUUOzUqDCtwWm
         R90+GBpElhVHzUhadAD/xqj+RXghVgE0kVAOPZgzZzLM7Vl9qe1EpsqHbxUlXt1BhBQ3
         VZ3ZO3bJUZM7M3W1Fgd+QRNncvSaVM7mSea2v+SBpI0WCi6EMg1ZRihEmJ0Ktt4ufrVx
         n1hA==
X-Gm-Message-State: AJIora/HDHtxNJ4ySbnqGjF7/u2EgAN2aoiPlSwh3ZIdKrJdo0AQ9UH8
        o0q6Z4GhfGvlw3ytmmwbufRKhaFpNIO4mA==
X-Google-Smtp-Source: AGRyM1snYY7Qjp0C4i1+0C4MpDwDiZlaxvg89XgmAfhZo86GFw08EXIq66DzEUKJnXe+4tAvIS5w9g==
X-Received: by 2002:a05:600c:358d:b0:3a3:2fe2:7d5e with SMTP id p13-20020a05600c358d00b003a32fe27d5emr184701wmq.77.1659026826564;
        Thu, 28 Jul 2022 09:47:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6043000000b0021efc75914esm1495403wrt.79.2022.07.28.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:47:05 -0700 (PDT)
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
Subject: [PATCH v6 9/9] docs: move multi-pack-index docs to man section 5
Date:   Thu, 28 Jul 2022 18:46:48 +0200
Message-Id: <patch-v6-9.9-ecfda8c6770-20220728T164243Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
References: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com> <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
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
 Documentation/git-multi-pack-index.txt        |  4 ++--
 ...dex.txt => gitformat-multi-pack-index.txt} | 20 +++++++++++++++++--
 Documentation/gitformat-pack.txt              |  5 +++++
 command-list.txt                              |  1 +
 5 files changed, 27 insertions(+), 5 deletions(-)
 rename Documentation/{technical/multi-pack-index.txt => gitformat-multi-pack-index.txt} (94%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6efac142e3e..522d6011e7a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -28,6 +28,7 @@ MAN5_TXT += gitformat-bundle.txt
 MAN5_TXT += gitformat-chunk.txt
 MAN5_TXT += gitformat-commit-graph.txt
 MAN5_TXT += gitformat-index.txt
+MAN5_TXT += gitformat-multi-pack-index.txt
 MAN5_TXT += gitformat-pack-cruft.txt
 MAN5_TXT += gitformat-pack.txt
 MAN5_TXT += gitformat-signature.txt
@@ -109,7 +110,6 @@ TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/long-running-process-protocol
-TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index a48c3d5ea63..0ffa8b852cd 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -127,8 +127,8 @@ $ git multi-pack-index verify
 
 SEE ALSO
 --------
-See link:technical/multi-pack-index.html[The Multi-Pack-Index Design
-Document] and linkgit:gitformat-pack[5] for more information on the
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
index 546c99f8871..68328bada6b 100644
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
index e3a5d417792..1215250c9ae 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -213,6 +213,7 @@ gitformat-bundle                        developerinterfaces
 gitformat-chunk                         developerinterfaces
 gitformat-commit-graph                  developerinterfaces
 gitformat-index                         developerinterfaces
+gitformat-multi-pack-index              developerinterfaces
 gitformat-pack                          developerinterfaces
 gitformat-pack-cruft                    developerinterfaces
 gitformat-signature                     developerinterfaces
-- 
2.37.1.1197.g7ed548b7807

