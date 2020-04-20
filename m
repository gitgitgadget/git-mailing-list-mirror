Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1528C54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA4220A8B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2zxX5fD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDTIy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgDTIy5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 04:54:57 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78078C061A0F
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:57 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id q2so1300819qvd.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NatCiaTlvegILyTVVpufX4IvCZVvj9x3yF5270PzODI=;
        b=M2zxX5fD4WuG8h8nb66ZYCStP77js/Drrrl5Qmldp9AT0xsj0bTfO3oOqJ9HaCKFlT
         Mt3XfDHfaq8Pt31XhjcZptswPokSGUUeEayCgt555NajgSmR++Hzyz01ZVTHIKh8vla6
         pZabFtzvzqEdUi2HeLRloWBy+nzQTKu6D9UWjBXymuqO6uq4duY0OvhPl2rGEpyBgITT
         C2jJ6GQwoBWB5ejpmWpfD5qeQRdYB5CyIhoML5S256OhAvVdkbsEDfP5cCPKM+vlqBOy
         gXCid3Cr4MRGJXPqrwbw6p9HfcPdDhX/pPbiI9TFIN8rTFtoDz10CKeSkf4xg4gatLbB
         tgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NatCiaTlvegILyTVVpufX4IvCZVvj9x3yF5270PzODI=;
        b=aNjplcbLO9F8cRHmM+trl9O8RuDSyZK3azzRIOqDL6P8OFVEDNViF8eV1u0Kn03Cgy
         RyijvP10MfNLIiVutdmPasJM3dxKTVMUS2+DTIMluMrG8CCCPkXUVdQ5jz2xXlOCQlS6
         d3NDCLRf6BSvhg3ZfzDjVh0L5oQvrG6MvAyyOCeGlwE8AZj7cGA6ujf/AcvXbQAs6AGL
         Ho3t6NL7H13K4gmVhj1gVxIm7TruPyvRBS/5eazVNEweErB5TuwfD5tk2aOOvyYA9+UI
         RELl5BXcpHktGzLUjNg3D/z2MLyhrlRY4t3Cz6BeGOV6ajWuO07T15dQvsoTrwsBLZmp
         1G9w==
X-Gm-Message-State: AGi0PuZ9XTr2Ur4tDe0QuW48iAO2XUj+RvwiWQQxNjSQrxlU9HIoTAsd
        gfutkDvuC/jnkaZ3xcIOX2Il4N0K
X-Google-Smtp-Source: APiQypIoMF8fBpZnjbum9RM0gQ9jJD+TMu0qmBCF3vVDqEo8ogi3GZmi9vf+/5vchhPMc9mVbdOYNw==
X-Received: by 2002:a05:6214:1812:: with SMTP id o18mr14207076qvw.64.1587372896541;
        Mon, 20 Apr 2020 01:54:56 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p25sm203222qkk.18.2020.04.20.01.54.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:54:56 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/8] t7508: don't use `test_must_fail test_cmp`
Date:   Mon, 20 Apr 2020 04:54:41 -0400
Message-Id: <fd79ade3527e6be6b97f07d798a0ea38507f24c0.1587372771.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1587372771.git.liu.denton@gmail.com>
References: <cover.1587372771.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we assume that external commands work sanely. Since test_cmp() just
wraps an external command, replace `test_must_fail test_cmp` with
`! test_cmp`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7508-status.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 482ce3510e..8e969f3e36 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1471,7 +1471,7 @@ test_expect_success '"status.branch=true" same as "-b"' '
 test_expect_success '"status.branch=true" different from "--no-branch"' '
 	git status -s --no-branch  >expected_nobranch &&
 	git -c status.branch=true status -s >actual &&
-	test_must_fail test_cmp expected_nobranch actual
+	! test_cmp expected_nobranch actual
 '
 
 test_expect_success '"status.branch=true" weaker than "--no-branch"' '
-- 
2.26.0.159.g23e2136ad0

