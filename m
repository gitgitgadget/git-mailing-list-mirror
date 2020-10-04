Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429CEC4363D
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED26320735
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 12:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjPSgwqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgJDMao (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 08:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgJDMan (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 08:30:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCFFC0613CF
        for <git@vger.kernel.org>; Sun,  4 Oct 2020 05:30:43 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m34so3944667pgl.9
        for <git@vger.kernel.org>; Sun, 04 Oct 2020 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U4n2v+dJHIiHGZtBxeT6+F0Xumd7zVgfX09RJlpl2GA=;
        b=OjPSgwqgenC7ZbOcrssXFQjWrBSRyawOxXq6GPyhyIFTWnhZ+GCzdF+IOjjjj3Xbzw
         gKTfrGORuzm7A+1mAvbz7D5vwibpxTbOAZ2PnMjbafJAFWOXhAeu4XN+RvISzaM6VjhW
         7+QbWP3UxZLM+BWozDpstlOFjyxZTXx66qLJ+rOUe2SaI3HH2kwLFGx8cCYj2Fg11/pi
         SvKBI1/ZdZ9EyJcERGDHOv0D5vRFvpnD5xunfk5VLQv9kTFbi2Be2/1KU42Dm5iKFkXJ
         D9aUEhyii3LgKhDXTlDpe5WY5nB3+VG5TKb9En1angblVNUVtW7HYY35YKFPiCSIUBJe
         SHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4n2v+dJHIiHGZtBxeT6+F0Xumd7zVgfX09RJlpl2GA=;
        b=uBO4Sv5yTf6dEROm+lvU+26W3BdOpSYBLUrmDXYH0qngEvAZemCGukN3ytOmZxvbxc
         5HvSPmU4DzmtO7bmOOJbQqDm8C72ug88/RJuttaU/v8+qT5P/NX/1RqsGql0q4B7Nh+3
         gRcryv4XR1Way8firUr9qMVk7jl0fura99+i9JQwZcFEQ26EDKiZAiKQZdJYll2ctfm7
         QAOqmDBNtx/7G12Hy1WmLTjOMECiA0xpKnZaSI1Hg2SUxNGkMhqOBlGTRoIueRsRCzWN
         ECNud8LZyvscRKdpZW+3P/JxpIXvNwnW1robnDtZXVjH9RLWE1fAo6J55dhJ+80bK0ar
         5t0w==
X-Gm-Message-State: AOAM530bdpOwfd0N77UYJ/CLAKGzo+D17hSQ1/YtCaCRWCaINcoja86w
        a+o4d6XrLnb6pG6w4GG9pkOSUxDTKRc=
X-Google-Smtp-Source: ABdhPJyACrqD+U66aQA3s/QD3VFCYNySkb51RcyX9hl5l0evfKA0NDN4UXOWBo1WTKLSobfzXtCFEw==
X-Received: by 2002:a63:ff1b:: with SMTP id k27mr9216499pgi.230.1601814643093;
        Sun, 04 Oct 2020 05:30:43 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e8sm7372299pgj.8.2020.10.04.05.30.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 05:30:42 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/2] Doc: document "A...B" form for <tree-ish> in checkout and switch
Date:   Sun,  4 Oct 2020 05:30:34 -0700
Message-Id: <75920c1a25d71899a98fa8c46091446306125842.1601814601.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1601814601.git.liu.denton@gmail.com>
References: <cover.1601814601.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using "A...B" has been supported for the <tree-ish> argument for a
while. However, its support has never been explicitly documented.

Explicitly document it so that users know that it is available.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-checkout.txt | 4 ++++
 Documentation/git-restore.txt  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index afa5c11fd3..6ae8bf8dee 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -351,6 +351,10 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 <tree-ish>::
 	Tree to checkout from (when paths are given). If not specified,
 	the index will be used.
++
+As a special case, you may use `"A...B"` as a shortcut for the
+merge base of `A` and `B` if there is exactly one merge base. You can
+leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 \--::
 	Do not interpret any more arguments as options.
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 84c6c40010..55bde91ef9 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -40,6 +40,10 @@ OPTIONS
 +
 If not specified, the contents are restored from `HEAD` if `--staged` is
 given, otherwise from the index.
++
+As a special case, you may use `"A...B"` as a shortcut for the
+merge base of `A` and `B` if there is exactly one merge base. You can
+leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 -p::
 --patch::
-- 
2.28.0.942.g77c4c6094c

