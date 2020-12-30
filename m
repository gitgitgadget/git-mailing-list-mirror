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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F49C433E9
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F5022242
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgL3T2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgL3T2R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:28:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD29C0617A0
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:27:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y17so18295845wrr.10
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JVX1YwEI15ACXoHGSLfoBMSCsKP/lX3ZPnVK+ClcBPI=;
        b=J0DEGCcv5U5aKVXfywkx0shj82js1RRXDfy++uRHmDsEhP0+Y31EscY1ya1p/KtWud
         bjX1qNDBfhOaETNXCC38V+H/R3dIxN61TgQNqHeszJG1C6JTZLINHEDBUY4kEcgdPH1Y
         Hf/PbwwJUOwubysxlRhxBEaOxOv9VdKgDro0qKzgVRzQKEFRZSQ4FWc0zVlDSauZJ6hM
         EtFpYAIpXNP/voIxCKelMiMKbfIYSxzbQtyRcLrF3uBBDNJhUhcckhVUfYvwS/3t9vOy
         QB+yCslmhYN4I1zKmMSlhrZyCx9xjKwy0/5mfEyoB9SBVe+kocr/Si1GULBtXf3w6Seo
         5ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JVX1YwEI15ACXoHGSLfoBMSCsKP/lX3ZPnVK+ClcBPI=;
        b=CwHti6dQkWPCHigbiXBulx/gvrmXE/oqScWmQiRF8170lFa62DgKnRDWBVOAm1G8Pb
         LPk2W2XxLdrGUjdNtTwV9mPZgIOfXlm9lAymqDnYCH90I3psMfjxJWtBp5RlIEwhuRUO
         wWfeGNqBsL7kAZaqRWshgaJvhPjzL78lZ4RpG8KucYwGTnh68daMWKgKoA1YDUwdvRoR
         FEOP1obTKKf+Dpameu6zxQwhXh/2Joji/fAPc/vLITPTrx3VZOG0DuJlIwrWa/9L5TSX
         4brYNHNA29A1vQsaDf9lJb3BAVpPB+hNgnd0rRFx5M5WfTHkSOO7WgNI5gfWl9D+MgMi
         QIlQ==
X-Gm-Message-State: AOAM5322/An6DgAuHZ74J5sO7FBhImhivDHmOefxW3OyDuHy+lAqdJS1
        h2yyo4mp7/Pf85tm9pElol+KK+GjKK4=
X-Google-Smtp-Source: ABdhPJyEHBVTfxgOR8I77Q6G5EPZdvO1jOu5t993/doELieE+Oktkvj6xojTYaXrc5q2kMUOKY+mBg==
X-Received: by 2002:adf:9b9b:: with SMTP id d27mr62418141wrc.125.1609356420462;
        Wed, 30 Dec 2020 11:27:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm32597347wrh.78.2020.12.30.11.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 11:27:00 -0800 (PST)
Message-Id: <65fb9f722519c50419d29930aa92d8ae660bdf2b.1609356414.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.1609356413.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Dec 2020 19:26:52 +0000
Subject: [PATCH 7/8] index-format: discuss recursion of cached-tree better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The end of the cached tree index extension format trails off with
ellipses ever since 23fcc98 (doc: technical details about the index
file format, 2011-03-01). While an intuitive reader could gather what
this means, it could be better to use "and so on" instead.

Really, this is only justified because I also wanted to point out that
the number of subtrees in the index format is used to determine when the
recursive depth-first-search stack should be "popped." This should help
to add clarity to the format.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/index-format.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index c614e136e24..2ebe88b9d46 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -198,7 +198,8 @@ Git index format
   first entry represents the root level of the repository, followed by the
   first subtree--let's call this A--of the root level (with its name
   relative to the root level), followed by the first subtree of A (with
-  its name relative to A), ...
+  its name relative to A), and so on. The specified number of subtrees
+  indicates when the current level of the recursive stack is complete.
 
 === Resolve undo
 
-- 
gitgitgadget

