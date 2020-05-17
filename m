Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18092C433E1
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED691207F9
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDqSCfTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgEQSwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 14:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgEQSwj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 14:52:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A627C05BD09
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g4so7510679ljl.2
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Er+dHkjc6+xU4AZGe2v6wWOdFj2LQijbrsg2btGs4tU=;
        b=WDqSCfTpCxoIP20kLm5fqczuyTwuCy3AAT19A10GEvhu1n9LvGAlt7l5xNoxiO3tGM
         bKv3Iy0TC2fe0P6tVpYlSOGGo5fvJNWKcL0Ys5VxzmPBvTEa/cRYGa2IdgutS2enpsNF
         rxOui04GajP49Vl8PCu7+LRiXT4UXGshsj3F7Ut4ajWXXrHBCiEiZ23ZdeuQM7ht/gCG
         Sm+1656mq8k2aJi2tis6rd4BZI95Njy8rdz706OCGY+UCZ6HpwoMDspkG8Pq4eofiS8Z
         gMfFTi6dUxIBSgLiy9bFvQrzWq4cG5AwaNMK2GO7/F6ChTQrP5x0Fi2iY2HkzjlrP10a
         aKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Er+dHkjc6+xU4AZGe2v6wWOdFj2LQijbrsg2btGs4tU=;
        b=tFJvqGAvN+5DopHtAmbAPSDiVLqVeGXkTYh86nTjhUkrkQwBeqKSPvdz2iRL+NkWm+
         ZLE4NQG8HhnRk84+hHbn/7hkqOXAS75P0UlfPR4bOSE7qZEPwHelQ5XRj2hyGE4+BSsh
         giB7Ghf3yORcswIpSICYtP7nNRk2xT/vCjyWe56foFjXVni2Vd8rWuBOjQQqS9zLLHMb
         giX6tPK+ATfu9UeSr4wn4rJWHfehww6CPjuU8TEzUoPoNjKznrRrFqYdCgUNi/+1yQpy
         eudDXfEzE1ZXlzvE7XmsMoju4LUByFc8ZluUcXvNaCGPDkYTfSYwXisKHX/JNWJFIn45
         ApRQ==
X-Gm-Message-State: AOAM53240r/aR4e+6hbJq4gMmOIcMDk4xJ38ISK+If0oqK+BRgcum3MO
        Cv7NnfjTYW87XphN5QDNdFOtYpiz
X-Google-Smtp-Source: ABdhPJxZfY1OexONkAwIJcIOLOkLnMA5vd3Y/9D47GTCrV7s/4pMdXd2TGtsZ5W6zyDOd0o0KvzZWA==
X-Received: by 2002:a05:651c:1035:: with SMTP id w21mr8198248ljm.278.1589741557719;
        Sun, 17 May 2020 11:52:37 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a12sm4513938ljj.64.2020.05.17.11.52.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 11:52:37 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/7] git-commit-graph.txt: fix list rendering
Date:   Sun, 17 May 2020 20:52:19 +0200
Message-Id: <8203fc4c118eb3bd18e0632ffb9e1a618ae383c7.1589739920.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <cover.1589739920.git.martin.agren@gmail.com>
References: <cover.1589739920.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first list item follows immediately on the paragraph where we
introduce the list. This makes the "*" render literally as part of one
huge paragraph. (With AsciiDoc, everything is fine after that, but with
Asciidoctor, we get some minor follow-on errors.) Add an empty line --
with a list continuation ("+") -- to make the first list item render ok.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-commit-graph.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 258bf66e46..a3d996787b 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -68,6 +68,7 @@ chain of multiple commit-graph files stored in
 strategy and other splitting options. The new commits not already in the
 commit-graph are added in a new "tip" file. This file is merged with the
 existing file if the following merge conditions are met:
++
 * If `--split=no-merge` is specified, a merge is never performed, and
 the remaining options are ignored. `--split=replace` overwrites the
 existing chain with a new one. A bare `--split` defers to the remaining
-- 
2.27.0.rc0

