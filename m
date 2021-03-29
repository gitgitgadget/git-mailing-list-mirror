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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98E2C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A900C61554
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhC2NnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhC2NnI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:43:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2FAC061756
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:43:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so12922139wrt.6
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7fuVxfNtRStEyYCFyGEuPnSziqU+0P11cQP1FmgzHdU=;
        b=ssdrsUxMmbmDNeGvGso90NgilzFRR5Rv1XLFjCVGIHb9W9FFKjjqvF/sScvQZPv6ER
         H+fj6UleISjgG8g7rvqLCIr+t0fZ742r5JUOG7wgFKSVL6JX/AxH6Btzh+E/6yvNtjqs
         ucIzuqMgvUD75cEI9v78JOrSidXlzrRKI1GLxJc+fTl7zGRtLkf8z/FCNUXN/XSa0/PC
         CuW2cst/Q/quVCuey2MkD3G2aCVINpgaq5QkPwby3jrNL+SnBVONadKqNwsF7OnoKIqn
         ak34pbhx+gDSu8WR/3C5sgWGhtm1uL24m9rIxcF9UKbgpwAuf1JLbWG9/sxtVPgc7vez
         zldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7fuVxfNtRStEyYCFyGEuPnSziqU+0P11cQP1FmgzHdU=;
        b=UQbl39vs3sJKCmkKBFSQZcBJcTrU8sBH0Ox7tInWcQIt7p/4xaCaIMB+UqyvDTltHJ
         IvwBDDeLqUbLNMTu7om1QKhFRyQrDR+n6yuHtJetYiH2tYsfjWzYv+n9D5pkODTYyXDt
         f3YrLhF1PGdfLTEKViTGtXOrzeAjm+IHEJY2EmIp08nLRcXWK+1pPcmXbnO3jAj6q4I4
         9p6IsNKVxCazGXiBMvwTod91ZgKk6YAOsMnB9MbaxR5oLBzFywx0+EUZzcsPv+oTCENX
         N6KiBajR0ryLEHAg4LJIxGW8LkpGz5SM1JPQiqD/ZCFDJG+3cv4/KQ4V7mQct3GgwDJp
         Fq5g==
X-Gm-Message-State: AOAM5313DkNhBJZ6FffL7doCKbnGujX5EtTUj4Fj216VS/BerGVqf9Dl
        MqbD28Sz1spjSCSLaHlk20g1peoAlRA=
X-Google-Smtp-Source: ABdhPJwrostEuIppeN1mdYhMu/0o2HsvxZIUPIFTRHdMorUz/Xzv0psUi9xjtHxDKbjOP7iI3xVVag==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr29937519wrn.338.1617025387139;
        Mon, 29 Mar 2021 06:43:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm30898113wro.23.2021.03.29.06.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:43:06 -0700 (PDT)
Message-Id: <3f5d866de1954cce0b12b83d99f5a5f814998db5.1617025385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.917.v2.git.1617025385.gitgitgadget@gmail.com>
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
        <pull.917.v2.git.1617025385.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 13:43:03 +0000
Subject: [PATCH v2 1/2] SECURITY: describe how to report vulnerabilities
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 000000000000..c720c2ae7f95
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
+  only affect setups with case-sensitive file systems, for
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

