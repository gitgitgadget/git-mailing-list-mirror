Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A834C19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiHBM6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbiHBM6N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:58:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE118370
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:58:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j1so9426334wrw.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=su0qHYYV+jN+Mx34di3lfJjrnDTzMx7vx2OsHRrxIUg=;
        b=CeWy+hszSCqoebBKVE7aFN/NPgNMZxUkajVMpxuyMBcummk6uwC74/TU4+VqA14U3I
         0mWrlR4QAMsrRD4dVoCENoxKQWagrUEKeUzbbq3WIIytStkYjmQoKgYpRabTcKQg7oBD
         A9zwJWD/PMHGQ77SOO3Y6DIjNbC1wwc/51Oj8snEVAweFEwDYui85TJKb0RIpLUja69n
         KhBuXz8c6ee1+QbFnu+n25Vx0Wh2WfJpXR0B2YF2UTK+p2Gi+it53wHwtJ3Nd8ck3g4c
         iXe/2iODom0fBsN/99Cb/Yo25RP14B8wLJJMfGPberfHEw5pX8nKZTqh6mASgFi3WQHA
         OwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=su0qHYYV+jN+Mx34di3lfJjrnDTzMx7vx2OsHRrxIUg=;
        b=RV3bWT+jsacqeiOW8SlRDqUzGNZvWOCMuIgwqa/OuxlREWXasLHXe0kp1Hz6MBPnyl
         Kcl4in2nPr+IlkaXUr0nO/jcH3D/Ict7c6m+DkhPimtGOuR95ZVG1V8M1PBgSXmqsS+i
         ch6jn6fR/ilgeiWlFKT5kRgAHRh31MY9wwfqb2aorNplp7G5h1/5GPGXSU/7L0m4OI//
         iBx35CuIp8nJ3RUJsqMmsbnPLxUKv/eAlFqJxkVZi3nw8Wa3RiSWN+UiN4wNPp7L7mx7
         IFMeOzD6hyrj1HDBrm+a9GrryNdzkp9KYGWcUblOMphT7M3HYVwM85QnOcu0hK4DlowU
         7zHA==
X-Gm-Message-State: ACgBeo0sEXMCmRBTZVVyo0tGSlL0jtkSHvba1QDry5kC2b2eXCUha2UM
        ucIgHLKeFKNu9F347MPv2puVCgWPUuecIQ==
X-Google-Smtp-Source: AA6agR5qM7nSfX5t240orpHvRDCcZ2/UumbiACXMPVGO8m3EO/FI01V8qkCYCnqYJ4ghaDZHoFpnhw==
X-Received: by 2002:adf:fb0b:0:b0:21e:f717:714a with SMTP id c11-20020adffb0b000000b0021ef717714amr13062404wrr.47.1659445089333;
        Tue, 02 Aug 2022 05:58:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t4-20020adfeb84000000b0021e45afa7b0sm15056145wrn.109.2022.08.02.05.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:58:08 -0700 (PDT)
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
Subject: [PATCH v7 10/10] docs: move multi-pack-index docs to man section 5
Date:   Tue,  2 Aug 2022 14:56:59 +0200
Message-Id: <patch-v7-10.10-8baf1db4d30-20220802T125258Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1232.gc0cde427aa7
In-Reply-To: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
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
index 2d5d6d17fb1..65b3e739be4 100644
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
2.37.1.1232.gc0cde427aa7

