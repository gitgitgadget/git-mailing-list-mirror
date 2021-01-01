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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E63C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180A5207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbhAACRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbhAACRf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:35 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EF2C0617A6
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:16 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id j20so19300719otq.5
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o5Oip2+6DH0lsj+ofc4/93A+XGMaqQCC2cCa5GS2QQ4=;
        b=ewctsCf6fzdXCaKGt9t7HuGVKCySRj0KfIFyquy6/wu5h0otRY5wQfs4pPcnq0S/4V
         VMJb0usSFgz2PINMEU/56O3WZr+dV8BBVKr00zV/yN0i3mSfOrRMQrHZtj8TKikfbqB+
         7kbmX3K7HtQcVaKmtl3WopEZUOPJOjAtV/HNwOLp3W2skvyEHjj1PDhe+9xURMY1vc2Q
         1HtiWyTPS39VvY3nmfq9E6MGhbNOzY0QqHCKN+ezBVXMNLjhxnlING64/GeFt4is7hiq
         xJRGaEQvdj+GqAiP0zSbBkz6r+gDB5XuXNZ72r9VC1VLbVHVWJ02mVlocF+KMnqYAxCW
         C1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o5Oip2+6DH0lsj+ofc4/93A+XGMaqQCC2cCa5GS2QQ4=;
        b=W6h7dhgu/m83UQa8WDId5LGV58yCChYbavrd3SltOyUxc+wUfwUxnt88jx1bxdkCx8
         L4j3EP2IiVkp7lcqkuh9aevI6DGO68J5iXV4K5PZ1IqC52ElA5eKnZnTa0Q5X16xyCOZ
         5NWpYKajLNP829fpBnFsAWdjnqJJDvB4n9cgK79jwMtnaoitDXRIB69UII261H+iCE3Z
         OTJcAtyGxGzAtn5/PybTX8DlZP+i6aJ6NZjEAa3WQph0zqOcpc5UQhOqFrgslxje2NOH
         Egl5j42YNqMh9hiHFB0gAMlv/ye6O4E5Lw/DTAFTGFzJwh7Yk07En5Fjp2L5rY5dOZ+Y
         5+Yg==
X-Gm-Message-State: AOAM5304RKv/744wlGrywwlZ1TEQexGv250gM3ilYi3MLdcxS9oJr+lu
        LrJ/XsLFO/qNbL54ufvOuRXSqpmHTBx/vA==
X-Google-Smtp-Source: ABdhPJyWFuiUZIwUar1VYImDbjhpaIhhfoGGG1ZYh4DPP7n6RFRM367aD3/lWyEzwfNs/J1i2uy7kw==
X-Received: by 2002:a05:6830:916:: with SMTP id v22mr44803085ott.257.1609467435330;
        Thu, 31 Dec 2020 18:17:15 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v38sm11407979ott.52.2020.12.31.18.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:14 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 32/47] completion: zsh: simplify __gitcomp_direct
Date:   Thu, 31 Dec 2020 20:16:07 -0600
Message-Id: <20210101021622.798041-33-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not much different from __gitcomp_nl.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d5ec8a1417..6afcf1810b 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -89,9 +89,7 @@ __gitcomp_opts ()
 
 __gitcomp_direct ()
 {
-	emulate -L zsh
-
-	compadd -Q -S '' -- ${(f)1} && _ret=0
+	__gitcomp_nl "$1" "" "" ""
 }
 
 __gitcomp_nl ()
-- 
2.30.0

