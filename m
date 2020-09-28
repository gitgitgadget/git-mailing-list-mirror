Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACB3C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 15:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29512158C
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 15:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkgtKEXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgI1PuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 11:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1PuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 11:50:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55392C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 08:50:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so1660849wmj.5
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 08:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItmvDIIPqoTfFUwSERe7U/2FdhqeqEhouUf+FCuKXEs=;
        b=pkgtKEXIBI0NqnGr5Lw3Sym0JCTho59S7FPW98O3XRHNgAguttfBEw3hk2ItZK1yb9
         axbXa8sW6fgmpiicRIfV1TBGA58mz7wd+m64942y45Veqwyy0VvhjP0gGq75IWAFtfj7
         vdSFkMBW/L7Y+DkrwE04VRed05bCFtEkOugpi9/HdqhyqSz6A8Pi1+04XoqDDIubL+KP
         GDdwaJQ12rSTdaT/9ZCv5ivdwkiNWE2o3CHocxlVQsyVzO5ww+piJ8zjIZRFMK1nfzEh
         CqCNsBV//byuZkuxfCBw4BQqL4Ks1z7/cpFRbkiDKk+/jnN5UwiOGLm+2aUZGUBa8wW+
         DaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItmvDIIPqoTfFUwSERe7U/2FdhqeqEhouUf+FCuKXEs=;
        b=lt+nsMybSw8GxS+gGXG67rCHJguRrxVpbZuNwTNv2CypHZkpNAGn7FZgy1IZ5cfKQN
         0PYSFl0zCNqenxmMPokJLsF2LelW36AetFRXS5KkJB55cCtSJ69IOCvslifTaExBXACz
         pVX5wDtaLQSqOgEnYNeacb59sMH6K1XnuFQjRkzcFSQKMAotWPvsqjz7dHvoo9tYMZHK
         qME8eQSDcRkhgr7+DHnsXjxi9ZK/+rRlvpe/0vqcy4NtGZPnCep6F+C/lmvc86R0pjmP
         rPkMDNYTIK0us5ZEoi93jmXpRNHlq7hILYthYweoo/IMD0Kap0HiGP5CQ8JWoZ+0V3vY
         HPcw==
X-Gm-Message-State: AOAM531Q6Ti7qkoQAoSu+WwKZIwMQwewUYVSTuPW3AbtJSmNeXmzABXa
        BNT3CA+uXwcCHtEZ1D/nGtobRMK7Ww4=
X-Google-Smtp-Source: ABdhPJx0WwfCqQZR36Gc8QXjKpJ9i+4cwjr8TdPiXWPjEY49jVa5I8SN2IxnSXotFngPk/WoCEXf9A==
X-Received: by 2002:a05:600c:1293:: with SMTP id t19mr2379499wmd.34.1601308221697;
        Mon, 28 Sep 2020 08:50:21 -0700 (PDT)
Received: from contrib-buster.auto1.local ([79.140.115.160])
        by smtp.gmail.com with ESMTPSA id o15sm1717067wmh.29.2020.09.28.08.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 08:50:21 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [RFC PATCH 2/2] t2402: add test to locked linked worktree marker
Date:   Mon, 28 Sep 2020 15:49:53 +0000
Message-Id: <20200928154953.30396-3-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.28.0.856.g4762557030
In-Reply-To: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the output of the `worktree list` command to show when
a linked worktree is locked and test to not mistakenly
mark main or unlocked worktrees.

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 t/t2402-worktree-list.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 52585ec2aa..07bd9a3350 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -61,6 +61,19 @@ test_expect_success '"list" all worktrees --porcelain' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show locked worktree with (locked)' '
+	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
+	test_when_finished "rm -rf locked unlocked out actual expect && git worktree prune" &&
+	git worktree add --detach locked master &&
+	git worktree add --detach unlocked master &&
+	git worktree lock locked &&
+	echo "$(git -C locked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD) (locked)" >>expect &&
+	echo "$(git -C unlocked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
+	git worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bare repo setup' '
 	git init --bare bare1 &&
 	echo "data" >file1 &&
-- 
2.28.0.763.ge7086f1eef

