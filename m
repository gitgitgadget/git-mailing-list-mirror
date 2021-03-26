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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE940C433E6
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 22:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB49B6196C
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 22:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhCZWNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 18:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCZWMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 18:12:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45480C0613B2
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 15:12:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c8so6986718wrq.11
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 15:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M8BP4QA8sVk0c234JQx/o5hVe3DSEPRt7LxdrbCSeLY=;
        b=LdWU3k3Wy7L3coDfjDfQ0PLdI6SwMiuQmAgHe9+psZX+1Epm/EOvCIv1e6ReN4l2NR
         hHccankLSAZmS4J5nJ8HJvZLDyDMBNGjpaLi2gL/MLe9AXscRcq9RsEpSyhKqYv+rpCe
         kBp1TpL8S+TxXE3uBccD6xw2WqaVk0bKyuNOwJRKLl+f4emfjFvXR+0o4CEC+bZ4lZ3k
         FEKhx4Wbq6YwaJ5JHNg0pElvkffRbOjkXE7S2el7xq4lLKe+IOxUcQGhfO4/8mYeBK3D
         LP6HNsNm7yk/U+fFYVSP8krWQWKkxJPrC0FeCT2UT3GZu7CDOrNIvxHI5t3Pa6m5mC2n
         Xa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M8BP4QA8sVk0c234JQx/o5hVe3DSEPRt7LxdrbCSeLY=;
        b=TsrF9ZOSHTOiHj2SwHQJ9AhR54V50i6NnxnZfZrOJXpdRj+yLrgTOS7xSC5N9ErAR2
         VuFmLqQMllys/fBggoJwQ/IU6XJ7mLbXGO4ETLVHGmpdDt/iU2utQSRrB1nS5g/P8NeY
         3N2Twtv14NUaqurSGkAheREbVWTASK0ZuiGlFuUR/JekTM5kpd1mFooop68R26VBXtFH
         6YimyVP6CkYiy/j/xJS2AMEDGJtv4R+JJ32jw8kMZ3dAcgMqtx8copekqdubyTZygxsF
         ZShw76//sgGXTbEZAlOTwiEvRnaDhXXA1oHGriiM3oQ9X4YNdPgk2P6pF02PpvjAqWTt
         61CA==
X-Gm-Message-State: AOAM530h10Fvvtwvbhjh+6x66Y0/QK0thUV4JhZnVosI0gzsQCGrIxzJ
        nHn5QBNye5Mtaf8NnPpae64AYfuLALw=
X-Google-Smtp-Source: ABdhPJy/RwC7YzYiHKF5h4hYjDJqSMO1Jrxodt7WW5ZYfwZsWl1cuP56HqpXqDrORUTnz+l5vFKvPg==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr16514485wrz.211.1616796769097;
        Fri, 26 Mar 2021 15:12:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm14860787wrm.26.2021.03.26.15.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 15:12:48 -0700 (PDT)
Message-Id: <2c9f5725d96fe45aa5d1a6bbc522f9ed6161173c.1616796767.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.917.git.1616796767.gitgitgadget@gmail.com>
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 22:12:45 +0000
Subject: [PATCH 1/2] SECURITY: describe how to report vulnerabilities
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the same document, describe that Git does not have Long Term Support
(LTS) release trains, although security fixes are always applied to a
few of the most recent release trains.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 SECURITY.md | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 000000000000..282790164e78
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,51 @@
+# Security Policy
+
+## Reporting a vulnerability
+
+Please send a detailed mail to git-security@googlegroups.com to
+report vulnerabilities in Git.
+
+Even when unsure whether the bug in question is an exploitable
+vulnerability, it is recommended to send the report to
+git-security@googlegroups.com (and obviously not to discuss the
+issue anywhere else).
+
+Vulnerabilities are expected to be discussed _only_ on that
+list, and not in public, until the official announcement on the
+Git mailing list on the release date.
+
+Examples for details to include:
+
+- Ideally a short description (or a script) to demonstrate an
+  exploit.
+- The affected platforms and scenarios (the vulnerability might
+  only affect setups with case-sensitiv file systems, for
+  example).
+- The name and affiliation of the security researchers who are
+  involved in the discovery, if any.
+- Whether the vulnerability has already been disclosed.
+- How long an embargo would be required to be safe.
+
+## Supported Versions
+
+There are no official "Long Term Support" versions in Git.
+Instead, the maintenance track (i.e. the versions based on the
+most recently published feature release, also known as ".0"
+version) sees occasional updates with bug fixes.
+
+Fixes to vulnerabilities are made for the maintenance track for
+the latest feature release and merged up to the in-development
+branches. The Git project makes no formal guarantee for any
+older maintenance tracks to receive updates. In practice,
+though, critical vulnerability fixes are applied not only to the
+most recent track, but to at least a couple more maintenance
+tracks.
+
+This is typically done by making the fix on the oldest and still
+relevant maintenance track, and merging it upwards to newer and
+newer maintenance tracks.
+
+For example, v2.24.1 was released to address a couple of
+[CVEs](https://cve.mitre.org/), and at the same time v2.14.6,
+v2.15.4, v2.16.6, v2.17.3, v2.18.2, v2.19.3, v2.20.2, v2.21.1,
+v2.22.2 and v2.23.1 were released.
-- 
gitgitgadget

