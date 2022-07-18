Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A45C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 13:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiGRNaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiGRN3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 09:29:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694311C03
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso7343942wms.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtpRmMyreB5N942esupAHqZ4ZC9LA5qFDn74kMgovGE=;
        b=RVAMDxmzHzH66pq+XC0/svkshzkuquiR2tWb6LjMPRYrsM30wrmAt2MqQay8nxu5kL
         dn3wd9Wn3pgo0O7wGCuWYw/45wrUCadt05sS6SKd7vLgjtKB9h9e7t8mjW5f+ic3d6Yw
         FUyQ8PpEa+vYOwZvRTuhUx3lXQUL6Bb286+ZWYhrObvV60Z1nCuDDe8BlDuO4uznooFa
         Yf/Fa51Gf+KW/l33i0rcLeIcpZcjfB/5ozqRqUarPYlxo8u1ndoxMqT9owwhtyk0AHrl
         MEFnDgsF3Fg1kokHHHzBuQ9o0OTWVG/jCJB6gwDrvVXMIWY4vS6w32jdkSzVdSM1ANfe
         vAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtpRmMyreB5N942esupAHqZ4ZC9LA5qFDn74kMgovGE=;
        b=kDYq8KqtreMVNq7uGQZkgsaiY9NX0KpHI5h26/1VhRuIZJnJ7YoTpHUT1i+dTu550a
         /LbfBuSWvsGRw+QCk1gNg8pUr1UHKhW3Sn4qgrQLD4xoktzMOVIZ21G7A+7lAV7ETGDq
         I2sYIKyatJs7knFBgX64nfm0QvMBBShAzFFePFPpdeSoaYvLUd+EzfKV+CGdfNU2N8Gq
         zDNMn+JnLHjqTKKhMCHaJnJFSoVEtDE0CL312bTbK871ChEXhC3/HMQr/RVoJMEINGGt
         Qb2CzWkFXiBuNK/DQDwmZj5sD7iecZPfLXZSRD3LepFmGpANWmeHiPgRwxG/WtiGZJlL
         zv/g==
X-Gm-Message-State: AJIora/D5Hq7MDyXuUDP65r6Kib3jhNNd0LT8Gu7hoRObq1gRcaNxxaO
        eNS0RsXI0GW8QuQIFBvfdhVQsfu8/FYl2g==
X-Google-Smtp-Source: AGRyM1v2C9w771O3C7SxMBNar2BfEFJcmttt1CzFBXZUD9tBpFmRFgJ3HnvDVo/2QqWhF6+6oa1DjA==
X-Received: by 2002:a05:600c:4f83:b0:3a1:9c7c:9ea3 with SMTP id n3-20020a05600c4f8300b003a19c7c9ea3mr32708258wmq.39.1658150989261;
        Mon, 18 Jul 2022 06:29:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b003a30572072esm14277296wmi.6.2022.07.18.06.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:29:48 -0700 (PDT)
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
Subject: [PATCH v4 8/8] docs: move multi-pack-index docs to man section 5
Date:   Mon, 18 Jul 2022 15:29:34 +0200
Message-Id: <patch-v4-8.8-f186950e673-20220718T132911Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1032.gb00b5447790
In-Reply-To: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
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
index 44757823e96..984d86a96d3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -28,6 +28,7 @@ MAN5_TXT += gitformat-bundle.txt
 MAN5_TXT += gitformat-chunk.txt
 MAN5_TXT += gitformat-commit-graph.txt
 MAN5_TXT += gitformat-index.txt
+MAN5_TXT += gitformat-multi-pack-index.txt
 MAN5_TXT += gitformat-pack-cruft.txt
 MAN5_TXT += gitformat-pack-protocol.txt
 MAN5_TXT += gitformat-pack.txt
@@ -109,7 +110,6 @@ TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
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
index c87b07e779c..a802f5b3369 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -212,6 +212,7 @@ gitformat-bundle                        gitformats
 gitformat-chunk                         gitformats
 gitformat-commit-graph                  gitformats
 gitformat-index                         gitformats
+gitformat-multi-pack-index              gitformats
 gitformat-pack                          gitformats
 gitformat-pack-cruft                    gitformats
 gitformat-pack-protocol                 gitformats
-- 
2.37.1.1032.gb00b5447790

