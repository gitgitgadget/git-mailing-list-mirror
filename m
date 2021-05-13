Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BA5C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9296143C
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhEMSTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 14:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhEMSTS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 14:19:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FD4C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id h4so39830508lfv.0
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3JAUGaZY4L+xcoHGe7pjA6xDeg513QnrOLk3TH/OpgY=;
        b=KgBrMQh49nOAC0YlXGHGu5FIbt0wzyYZvH/O/WcBCiUkCHycK0Co+MUUN5sKLtNnBu
         x8Y0D40+TGBn6GaH+zBiYRpqs/KZFEmVZu/7ARjt2+ZDNBVkJ93uNK7mP5WtbnPWjY2j
         xbkO/Fku5EDDQEePA3uR4kCcaNB5CxS9FuzxKNhqHZkTsqH/hGkEYGd0jsQ9843roJyl
         WNHpzg2uptpM4H+QoHuTae7uagFFXvlDg/Z0zxDsTpflCSziYyCAa/QLwuPYBbIOLIbM
         RBvQpm/SqWnDm/0xpukhiuORKDA6/EXpzRuovoCEN8Ww/QK9uz9ZPdClReg3UHcpOLF/
         Ya5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JAUGaZY4L+xcoHGe7pjA6xDeg513QnrOLk3TH/OpgY=;
        b=kUnBGpJXjjp4mLWCSCWi1PqRhvsK9lzPr6L0daB/85RPshBl8oqQE7SJ26l+jhWK7b
         wxM7iwBlDX6cqkOjXbl1YjtLNUMrmi5j3bf/v3hk8XvKlHVFK4CDsI6/MzBns0gqQkaf
         nsnKLv3etEKXXfG2mFjLmbI25eIozKCn+JYH0VDD71JF/aH/pHL1/8ZAzYzNqY6LY6JD
         +TXfu61bDtk5VZlD5l+3E2lqvoG4ozgcejTgRh6greU+MlB0bH2ZxmI9BKiCIdTLEd90
         vaFZgmwGqFF+cJyPyxBAQ6L/zlglFSnyA1IOlEYBAq/AQb9DPY4ALYG/O9Csw6F+R3R5
         9MlQ==
X-Gm-Message-State: AOAM530g/Fna+rV/xoFQUKuvPXBeTpopR8M0uotdpA9Mcyfvd/ufNjxz
        NyUbckDeS7AQGMEYhQkNSZmMO1aVRsE=
X-Google-Smtp-Source: ABdhPJymW7vx2827cKnQIPpqHW8A0D1wecxZq8U7yMS6mKgEWsHQNGipTB9dzHCZ68Iz0NA9ZdwQyA==
X-Received: by 2002:ac2:592b:: with SMTP id v11mr746170lfi.296.1620929886367;
        Thu, 13 May 2021 11:18:06 -0700 (PDT)
Received: from localhost.localdomain (81-231-136-235-no600.tbcn.telia.com. [81.231.136.235])
        by smtp.gmail.com with ESMTPSA id v8sm554153ljn.17.2021.05.13.11.18.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:18:05 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] git-range-diff.txt: avoid single quotes
Date:   Thu, 13 May 2021 20:17:41 +0200
Message-Id: <187b7290cfb516b957762e82538e64abda255cd3.1620928059.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
In-Reply-To: <cover.1620928059.git.martin.agren@gmail.com>
References: <cover.1620928059.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the previous commit, the use of backticks for monospacing and
a single quote as an apostrophe trip up AsciiDoc in two places which
render as follows:

    `git range-diff ... diffs' coloring

    ‘1` is ... commits' patches

Reword slighly to avoid those last single quotes.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-range-diff.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index fe350d7f40..6e9a0ea6b6 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -45,7 +45,7 @@ OPTIONS
 -------
 --no-dual-color::
 	When the commit diffs differ, `git range-diff` recreates the
-	original diffs' coloring, and adds outer -/+ diff markers with
+	coloring of the original diffs, and adds outer -/+ diff markers with
 	the *background* being red/green to make it easier to see e.g.
 	when there was a change in what exact lines were added.
 +
@@ -239,8 +239,8 @@ because of the modification:
 In mathematical terms, what we are looking for is some sort of a minimum
 cost bipartite matching; `1` is matched to `C` at some cost, etc. The
 underlying graph is in fact a complete bipartite graph; the cost we
-associate with every edge is the size of the diff between the two
-commits' patches. To explain also new commits, we introduce dummy nodes
+associate with every edge is the size of the diff between the patches of
+the two commits. To explain also new commits, we introduce dummy nodes
 on both sides:
 
 ------------
-- 
2.31.1.751.gd2f1c929bd

