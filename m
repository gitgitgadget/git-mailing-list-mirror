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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAD9C4161F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A1A6521F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhCHPHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhCHPH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042D0C06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso4008028wmi.0
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BpFPlFlIgNAfFpcUypYtSrDBnDDqPXCmux7wqklUOjw=;
        b=oArmSk9TBlEU6Qafbf0hlR/JTtSoK3sCF5eUHI3iDE+IBGUsfiUnw/GN/56ZJ2dset
         RYL6wbAIiaa3VXEtdQf34110iozSFB3Re4uzczl2dTHzZ5OIPUXnczRfeZLPHEWhE88q
         B9jgCZo5WNpksLPusXuSaieQTcQh1bpF2dOmg+m1HZ/LRwJXmIliDPEkZaiD0FFswgAN
         uAl3yd1hmMInhIpDOxpz/hi+3jPbdPOFBmgEuNXW8CvXQe0m5NNVOpEW396BgPxlSScw
         PHfAdXvhTzJOS/ZnIzqNRsMJy5kLhMvq6RwiMXWbL1s8bBrl0WkAQFw5HyZAr9f6kgzO
         eDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BpFPlFlIgNAfFpcUypYtSrDBnDDqPXCmux7wqklUOjw=;
        b=otxWf97gASFUcdKJGRmb+vzuVW0hRngbPvmlTOsl3ZdBh91FoaP6iRr3bI8hK4Z2Fg
         GOgGQLmwRopWCBaBRtuqpCLnoHbIJaDCLjsLJ5ICYmZFYcLziTCVw8O02bUf/lQodmzh
         8e0kzVvtDBDOpwHktmJtQVCDmcmmc/H96+h5IVnxpdVadeDTIX3xTpLPYfMxCaplkbS5
         FdFqBUrDcbKoggrI9EYKl3fissgjizZNiW/2V0woLB2TfqA66Jed80EqcBf2u44FY2c+
         gsKxSZJ+cwhDoONCQ94UxZcLOFbr9FbeAdtOBcd1dC8Cz3GULrNKlZs5K3152JUb+j2X
         oi+A==
X-Gm-Message-State: AOAM53369621Hy0qitidHGCcXkpR6cvGvLcVxv+TdnNab2qVsR6UuCSQ
        2o3cw0pMHohqHX1L6/hPS07QtJV+Qh2LIQ==
X-Google-Smtp-Source: ABdhPJxW72ZSTmLtxZiwXDxkFRsPqhV3Y57wuZjzdh+MahhMcl56dlZkGbCOGGlKHtbP1AUa3TeC1A==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr22226269wmf.99.1615216046520;
        Mon, 08 Mar 2021 07:07:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 21/30] tree-walk.h API users: use "tmp" for mode in shift_tree_by()
Date:   Mon,  8 Mar 2021 16:06:41 +0100
Message-Id: <20210308150650.18626-22-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code added in 85e51b783c3 (Make "subtree" part more
orthogonal to the rest of merge-recursive., 2008-06-30) to make it
obvious that we don't care about the "mode" here outside of the if
statement it appears in.

That's opposed to the sub1 & sub2 variables, where we use the two
object ids later in this function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 match-trees.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index ba4aabf39d1..4f02768c01e 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -317,17 +317,17 @@ void shift_tree_by(struct repository *r,
 		   const char *shift_prefix)
 {
 	struct object_id sub1, sub2;
-	unsigned short mode1, mode2;
+	unsigned short tmp;
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
-	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &mode1) &&
-	    S_ISDIR(mode1))
+	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &tmp) &&
+	    S_ISDIR(tmp))
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &mode2) &&
-	    S_ISDIR(mode2))
+	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &tmp) &&
+	    S_ISDIR(tmp))
 		candidate |= 2;
 
 	if (candidate == 3) {
-- 
2.31.0.rc0.126.g04f22c5b82

