Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D73CC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F7360EBC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhHDXvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbhHDXvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:51:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFA7C0617A0
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:51:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c16so4052425wrp.13
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ggh725ZYIJHS1Rsy5PO+KhNZiSnGW6AVuXC26nq3yD0=;
        b=WQtYP92Kh5aA19wEfQFdS3zc2b2PQF6DkoYgduL1mUeB1p1c6Tl/FMKdRVO4Bzz3TV
         F3st1tMJ3UnOV4DQ2cj+g8hcrOrPSExBl8jKjhNHZ0UQju8xYj9FhooTX6oZwzIZM6en
         NqEX2i0eRy3w7xRSVMa8ALUaftHQhF7L+Lxf5CdIMB1amaS0z8Ha5gZw6/oIGO2JiDSL
         cg4TZF3GV1y1ev0RsYAVJ2QM/2bDY8APBCb/7quXCnEIjaAXmvmyBKoDi0v+wlq3O0KB
         eBfn9IRto/g47gM2ddozw+vK9/QrkLmgdSy/KiPm4bxp8p2tivw9hY1OSEf52iw5IGHg
         ljbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ggh725ZYIJHS1Rsy5PO+KhNZiSnGW6AVuXC26nq3yD0=;
        b=FbBk5KB5F3Ko+Y8MJvJ7cs3WoYDJLFtv25jYMVf6uQl/xFIWuZaI/bX5kh6p6tqrlf
         sMkFq6hkGju05npaGCDuu8WB2zMWDHzd6rocvudwOyF3vtOZJWaOT2p5cQbekB/bU6ZS
         tnPyT99B7Ky1w40R6QkU6dbbrVge98zXubeEGbwP5DORO2bPwAvDPps5t31nR28FggKt
         39iVzski7E/0puEDwOKV8vA4uDUpfw6Bdv2hrTr+xRPQOBX1Vnx9iROieqX50kG7NfYl
         VF64DpPSKAam+Xnjwm+hcz3MN+tTVRbsVsmOB8PfIVKb17Q76pT7vBBbRYMg5z3wTn3O
         SgxQ==
X-Gm-Message-State: AOAM5325rb3Ul0ObmRz6FZxoHuzCqaaYLC2JtSdwv4lUe0NjOmQOowDb
        JAyFptHH/O0F6o1iQvI3ex61IekMGBQ=
X-Google-Smtp-Source: ABdhPJzgI2wzsGSgYoKwzyh6rwySTaAGUJmk/GA5NpaUdlsmILll5o9+2d5//N1TUtoZV9/aS2giRg==
X-Received: by 2002:adf:e550:: with SMTP id z16mr1813708wrm.250.1628121062104;
        Wed, 04 Aug 2021 16:51:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1sm7055566wmo.4.2021.08.04.16.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:51:01 -0700 (PDT)
Message-Id: <9ae77dbc2910dab773039f602e5878d4102d340f.1628121054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
        <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 23:50:53 +0000
Subject: [PATCH v3 09/10] merge-strategies.txt: add coverage of the `ort`
 merge strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Acked-by: Derrick Stolee <dstolee@microsoft.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index b54bcf68f2d..210f0f850b2 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -95,6 +95,20 @@ subtree[=<path>];;
 	is prefixed (or stripped from the beginning) to make the shape of
 	two trees to match.
 
+ort::
+	This is meant as a drop-in replacement for the `recursive`
+	algorithm (as reflected in its acronym -- "Ostensibly
+	Recursive's Twin"), and will likely replace it in the future.
+	It fixes corner cases that the `recursive` strategy handles
+	suboptimally, and is significantly faster in large
+	repositories -- especially when many renames are involved.
++
+The `ort` strategy takes all the same options as `recursive`.
+However, it ignores three of those options: `no-renames`,
+`patience` and `diff-algorithm`.  It always runs with rename
+detection (it handles it much faster than `recursive` does), and
+it specifically uses `diff-algorithm=histogram`.
+
 resolve::
 	This can only resolve two heads (i.e. the current branch
 	and another branch you pulled from) using a 3-way merge
-- 
gitgitgadget

