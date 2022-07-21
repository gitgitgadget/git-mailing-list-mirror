Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606F3C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiGUQQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiGUQPg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:15:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4BA8875B
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:15:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h9so3015502wrm.0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGZgbRJXVVS7kjQjlDffbZsCmWs5Aa/G8caZ6wN4zv0=;
        b=EUJxntsSgf8uDnrejFq/s5Gz0XklH2eUdY26DrHq97DK2LNEEnsdCqnL4jTzU/xscF
         z01I3jqBFil4Y0Fc8Ty1xNHRMuEb+42k6Roi6soAxSM6Gba8qiNIzdS0Fy5CHe7az8s9
         BAAUOYsAxyLB0+RfXtjnj/aOlTLw8Lc6mIcp3RzcxwcrP7WHoOTcfQ75CvFFnlB8dh7X
         mNA7KLrMJfsHnnBx0SKupJU2ZtP2q6Shf22B9EHF/b267IgBgLQogZAjKePQf/uMdWUw
         qIVbhNeCktNBpeE5CChQNifDPlHwo45OZf+/tvBpVnlmsXcpK2/FlLSt78PMQeZfJ/xd
         Af9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGZgbRJXVVS7kjQjlDffbZsCmWs5Aa/G8caZ6wN4zv0=;
        b=BYPzucFXyK0SNjiVshubwcSWzEETGy8sipKYSETjfUp+uM2eHGrbXkXVIc3Q+YBKAu
         D2CCbwvyq+M8Xa0JljK8OHy0GqEaFCcU3xam8exsfYZ+SrZAEEl0Z79Il8lmHtqwuNtx
         4/xeI5Rdbgnx8VGtDtg6k2pVR1FAALvCGoOsqQsdjI/D3rCnon0yZZNwOqp6/8N2vtL4
         Z20+Mag7k8PvnL2RgnF/J21D2Es/OhMeC5fB141gaAT9PdZXGRe7EgaP/or7cbg8pPCs
         s0Osxu/EhxIkXxHKdWzb66Z1xFkd1P3m45sPlOlBR8ZLmAi4kBuW/ezX8p87FzB7H0Iq
         et0A==
X-Gm-Message-State: AJIora8VOa0Y1ZVSljWVrxMGtKO0GeKOj94cfvFUUaz1vU34OAdGUHZ4
        MUfKAvvB4jfB3dEE1cJOa41tQxKIHajPRg==
X-Google-Smtp-Source: AGRyM1uo5YUeqNe/vI54RfCMsUpE+lhsgRjdtIbyVruk077LJvpWlxCo6Q6ZDTGtNzKkWjI56IkIew==
X-Received: by 2002:a05:6000:1f0b:b0:21d:6dae:7d04 with SMTP id bv11-20020a0560001f0b00b0021d6dae7d04mr35570234wrb.414.1658420071045;
        Thu, 21 Jul 2022 09:14:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003a2f2bb72d5sm8498608wmq.45.2022.07.21.09.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:14:29 -0700 (PDT)
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
Subject: [PATCH v5 9/9] docs: move multi-pack-index docs to man section 5
Date:   Thu, 21 Jul 2022 18:13:58 +0200
Message-Id: <patch-v5-9.9-19601ac36a2-20220721T160721Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
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
2.37.1.1095.g64a1e8362fd

