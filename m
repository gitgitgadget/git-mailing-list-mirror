Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9060DC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 11:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbiBWLy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 06:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiBWLy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 06:54:56 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B7997BB0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 03:54:29 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o8so868977pgf.9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 03:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVpzyILp2ztbDvGrYEwfKevqRYLP/6IZT6miX11WaY0=;
        b=Tzijb2Qlxw+yMnLpO6HVRHSap/zOORDUv7tXyHEGSUs3FbnFZy/jgjVuOZeisHtyk8
         ja5+wOC3vo6e6Vu0lKsVZJVi8DKIdhYiK5bxHeZNOzyO2bbJwh8AqqDVobZDGhdUCctQ
         +b4hjxvpE5/qU1xvclm/fo4HVAv1oWvGl9osjwLkL4ORL+TV8zWdub4Cfpq9EJo6P8bi
         LXcEt6ELB+vtZnxvY6LY/yRwoRhrVG/b1CV8jLgrnUM54vUsnvrOzxCZ973yC80vZaIr
         sDZM6yy5IXqSveAM4LKdBcVtbkdv+nrYe1qQOHoQb5katm4wRA21iYZF7WX1HSfvXFdF
         NxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVpzyILp2ztbDvGrYEwfKevqRYLP/6IZT6miX11WaY0=;
        b=axw1ZzC4mXLB4PIWqIXokgNfTeazCk2S1GxKhO5Tnqe02Y6H4IWEfh8wHxQkUjP0Rs
         MowPr7eiSkvlM7TI+ou1laeqmKeUVkgeevi2VEhR3doKCUhyXnwskfJq/cGgsR9d2iA3
         TAlGK36zuIYsnWgm7MQHB6iYKGRthB/cRUp0o7eWOpb9Rg/GbgZbLpzmjYN5Bd11tr7W
         Yrk4TST3a8jWimx4yl3Wc4MtPyjuvw64aqIwkKGPmnZV+owtx/f/3XoMPPShyHTtTm2M
         aN4YnCsMHio3F0pLKrHu6frfDIyAsyvWIi1/fr1eKLC1VBTamjHvbeIIhRA4LtYxYVu9
         1voA==
X-Gm-Message-State: AOAM533g3uBXSWwWtOJwQDFWxd03fSW1VW0TxsnCHIwz4ZslO7sfftMp
        mpEcovRa5VFbnKYqvpdKDVCpIm3C0WoFeP9q55U=
X-Google-Smtp-Source: ABdhPJwS8hmhmyaX696bL492XegNiWFKYl+jzw0nIxSpDAVg6HHmbGuJLFEBC2VhgGH2ib4G9BVhWQ==
X-Received: by 2002:a63:eb46:0:b0:373:3d44:4e7c with SMTP id b6-20020a63eb46000000b003733d444e7cmr23333872pgk.496.1645617268907;
        Wed, 23 Feb 2022 03:54:28 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.99])
        by smtp.gmail.com with ESMTPSA id rm6sm2728578pjb.52.2022.02.23.03.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 03:54:28 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, derrickstolee@github.com, avarab@gmail.com,
        Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH v2 1/2] t0001: avoid pipes with Git on LHS
Date:   Wed, 23 Feb 2022 17:23:46 +0530
Message-Id: <20220223115347.3083-2-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223115347.3083-1-shivam828787@gmail.com>
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220223115347.3083-1-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pipes ignore error codes of LHS command and thu`s we should not use
them with Git in tests. As an alternative, use a 'tmp' file to write
the Git output so we can test the exit code.

Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
---
 t/t0001-init.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 3235ab4d53..c7dd91cb80 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -489,11 +489,13 @@ test_expect_success 're-init from a linked worktree' '
 		git worktree add ../linked-worktree &&
 		mv .git/info/exclude expected-exclude &&
 		cp .git/config expected-config &&
-		find .git/worktrees -print | sort >expected &&
+		find .git/worktrees -print >tmp &&
+		sort tmp >expected &&
 		git -C ../linked-worktree init &&
 		test_cmp expected-exclude .git/info/exclude &&
 		test_cmp expected-config .git/config &&
-		find .git/worktrees -print | sort >actual &&
+		find .git/worktrees -print >tmp &&
+		sort tmp >actual &&
 		test_cmp expected actual
 	)
 '
-- 
2.25.1

