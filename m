Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0399C433E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF4322B40
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp5fQVfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbgGaP1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgGaP10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7EAC06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so25403283wrx.9
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=irOt7y6AT39qsvA7fyk+3IKqDdQseakdpBTiMfo44QY=;
        b=Lp5fQVfycXuFMC4CKxJm6n7gEhY3lSnCVPbMCdJ/86z/MANb5ibZCmt2GH1XrOnzw/
         yoyv6+6ZkErIBHzy2yxYE4MChE8WubbLIRcjnaxYQUbBghdakPaYxQ5PFlLK6wk21/1S
         vPwtGm62S/I7SGLYTNsCBQll8PKbixVIWPh7MrdyK2xN9ckMyLhkW8B27t6TO9M66+M6
         sxpViITCeVsgDpdbUbo+Wi0+qwGpx+IRHWmh75HZigV40AZXfMV6ZIj+xyxJ+XDCFm6h
         fs8jtbe1XtGQre9HPZhh71fwMww8CZQL1DH8tbUCtXinsYlRjWsvFFhxIpgBRszWtKWa
         /jWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=irOt7y6AT39qsvA7fyk+3IKqDdQseakdpBTiMfo44QY=;
        b=Y0/6K6AkNGzTWHE4ml7zpAe1bkr+BZRslyfOZD6qWYLACZcKkMdW+eTtJ663HgX17H
         wIURd1ComnbKVbq/jLvkFFCTpo/eOEuQ8w2676HY4+yj03OBRqiv+f0siNhMmCzh/Vyd
         8TuiUdqM9Mf5bcdbu+Om8l2SDVwKZGkJSecTDCwuxFX941eIl2Ua5S1Wg0o/xUjuq+oM
         aeY0n1FZM+qcZ909hkoAx/xPt9866TDXNGDmTpYOSUbXM+ADl6YbiE/b343kMJ/KAyBk
         qSswN4VPy/PC+mdTBONQc2BZBA/GXY9IUpKTF899V2gLp2hBCRas/TPAV7BgOQFLZEcH
         Ygiw==
X-Gm-Message-State: AOAM5336litxWZGr51FxR69OJQMWXwVmnM0ijkU1t3xTrWNNt5W+IrXc
        BwXbTgrwKQsgBgeq4JlY1wytayKq
X-Google-Smtp-Source: ABdhPJwNWYc3LPtUb2YBN8BDwzdzhkdIminNywkJHwXzTh83fcAeHc1cI+a3mS0Yh8dNUvXsz7z1mQ==
X-Received: by 2002:adf:f812:: with SMTP id s18mr4133706wrp.96.1596209244743;
        Fri, 31 Jul 2020 08:27:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm13964893wru.3.2020.07.31.08.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:24 -0700 (PDT)
Message-Id: <e9df96925bc0a00a8fc5244402eaf82ccf04901e.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:01 +0000
Subject: [PATCH v20 05/21] Make HEAD a PSEUDOREF rather than PER_WORKTREE.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is consistent with the definition of REF_TYPE_PSEUDOREF
(uppercase in the root ref namespace).

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 5c25821ad5..947b51f781 100644
--- a/refs.c
+++ b/refs.c
@@ -708,10 +708,9 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 
 static int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/worktree/") ||
-		starts_with(refname, "refs/bisect/") ||
-		starts_with(refname, "refs/rewritten/");
+	return starts_with(refname, "refs/worktree/") ||
+	       starts_with(refname, "refs/bisect/") ||
+	       starts_with(refname, "refs/rewritten/");
 }
 
 static int is_pseudoref_syntax(const char *refname)
-- 
gitgitgadget

