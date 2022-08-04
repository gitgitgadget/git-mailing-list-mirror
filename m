Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95530C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiHDQ3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiHDQ3F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:29:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A0867CB6
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:29:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a18-20020a05600c349200b003a30de68697so3195371wmq.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=riAVfpZO9f419tcVmk4rd7USjeE9H7yroMNnzMKDdIs=;
        b=oHIiUckkuq+GxKWvYpJWEu4lIT/VGZVgb3/weMKBfz9ApWZ6zeTmdI5HWn1bzaY8Rd
         HwRyw/mpqfbaDZIkgPOM0BKL2DDqAalDw405FXP65tfm8wDwl8ACwrzXH9Ikwsu0HpPJ
         F5mIKXHU0FtA65AvpIRuVAW/kHRKerOkB5eJK5+KMf+T9UgrlUqd5D8T3qHplZzz+1ov
         G3JTDHTntcy7fj12GE57sfw5ZusDW0Tp9hZ2z1IPY63K1z6mw6Npv1tqfcKrolATXmwD
         XElkewUVz3ljVX2eV/vkf/WtdY+WtYUF0AyzyztbbAuGLEMYVskv2LKpOZvCsz71v+ri
         vkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=riAVfpZO9f419tcVmk4rd7USjeE9H7yroMNnzMKDdIs=;
        b=3Yx/8THXNp9QTJaWeTlxlorabngMapvHQiFdnE95rjeAW5Yro+JtQ7DZoiECRfozFA
         LEluniPQo1PB4cEQHTB5fCPPqKdAJquj4wEYsdOnFdod9SX5q1tarOv2RihnoG1MHyPE
         lzJzSxu+e1n9VA+84rQ12BbBkilFXyQ84fPs6r45lZuA9ir527O4AE0noTLbJqqOQetS
         U3tCuH9TmG7Rz7YRzzqbtJEOff17ZU3uPl6Kn4V0vfXGQ6ubX05CAwVJIw1A71fTiH3F
         79mQn2HfD99vi635mvdKb5Qx6iIsU1A/kJa7nH/nd5FbVBFnIApm6hpzHWlO1Vm7/wx4
         wh4Q==
X-Gm-Message-State: ACgBeo2nsV0U2ZYck+q96MPbtqDNq7vwUdytYfv0cQTfSgz4t6b7Uuzo
        dhDGLydEpceFtvZD9fXUh069DUawiXtGoA==
X-Google-Smtp-Source: AA6agR5KXG6AtpMr4ojCPhqHmUl7gauaRMLj90dNG7oyjSA+56QW+PFi+hLnkG1HiRmmj9NNU/kRBQ==
X-Received: by 2002:a05:600c:1f16:b0:3a3:214c:a85e with SMTP id bd22-20020a05600c1f1600b003a3214ca85emr2012984wmb.95.1659630540901;
        Thu, 04 Aug 2022 09:29:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a513ee7830sm1868063wme.27.2022.08.04.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:29:00 -0700 (PDT)
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
Subject: [PATCH v8 08/12] docs: move index format docs to man section 5
Date:   Thu,  4 Aug 2022 18:28:37 +0200
Message-Id: <patch-v8-08.12-ea98b37e41a-20220804T162138Z-avarab@gmail.com>
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
the index format documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  2 +-
 .../index-format.txt => gitformat-index.txt}  | 20 ++++++++++++++++++-
 command-list.txt                              |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)
 rename Documentation/{technical/index-format.txt => gitformat-index.txt} (98%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b53f3c12843..029067a77d5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -26,6 +26,7 @@ MAN1_TXT += gitweb.txt
 MAN5_TXT += gitattributes.txt
 MAN5_TXT += gitformat-bundle.txt
 MAN5_TXT += gitformat-commit-graph.txt
+MAN5_TXT += gitformat-index.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
 MAN5_TXT += gitmailmap.txt
@@ -104,7 +105,6 @@ TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/cruft-packs
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
-TECH_DOCS += technical/index-format
 TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/pack-format
diff --git a/Documentation/technical/index-format.txt b/Documentation/gitformat-index.txt
similarity index 98%
rename from Documentation/technical/index-format.txt
rename to Documentation/gitformat-index.txt
index f691c20ab0a..9c3844298b8 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/gitformat-index.txt
@@ -1,5 +1,19 @@
+gitformat-index(5)
+==================
+
+NAME
+----
+gitformat-index - Git index format
+
+SYNOPSIS
+--------
+[verse]
+$GIT_DIR/index
+
+DESCRIPTION
+-----------
+
 Git index format
-================
 
 == The Git index file has the following format
 
@@ -402,3 +416,7 @@ The remaining data of each directory block is grouped by type:
   with signature { 's', 'd', 'i', 'r' }. Like the split-index extension,
   tools should avoid interacting with a sparse index unless they understand
   this extension.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/command-list.txt b/command-list.txt
index ed859fdd798..5e8d8386683 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -211,6 +211,7 @@ giteveryday                             guide
 gitfaq                                  guide
 gitformat-bundle                        developerinterfaces
 gitformat-commit-graph                  developerinterfaces
+gitformat-index                         developerinterfaces
 gitglossary                             guide
 githooks                                userinterfaces
 gitignore                               userinterfaces
-- 
2.37.1.1233.g61622908797

