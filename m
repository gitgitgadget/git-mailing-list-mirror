Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88862C4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E611206E3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUoo0VTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgKIAJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 19:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgKIAJa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 19:09:30 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E051FC0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 16:09:29 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 33so6927193wrl.7
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 16:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aDfPuk+7Osh3haffc1KnOAva1PGvlVM+3ARSieYjBqk=;
        b=KUoo0VTLOfYQI81t6vRlC5PgFK4DhYRZabIN/70f+Z1F0gSjsUZ59GoeapVqYDw8zd
         D07MPN6Ugc7u9GB2FK9umjhUzINZ4+J76XaMVEweZs133ySZc7jz5S2O8tNUWLTkhxI0
         PDuZpg2q/AmJzokBHUMeqJga4csIumtE3xwewvcOakP4sfNf40yst6s1VPpTGZyEIOPS
         uKyU2zU2GiTqvEcUl3vnvJGLnaGYWD6FCJzbImvzoCzDYSbE6gYgDa7Wa1FC2LwGz+fT
         D1vRIu0jHibG3InagUq1DmLeJR9BaXbRGYMRhoMMc8fnKgfoIZ/Cyr3hawWupSEm31os
         VWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aDfPuk+7Osh3haffc1KnOAva1PGvlVM+3ARSieYjBqk=;
        b=EYNgTG4+jCdeiMLI0IDCvlv7Q3HKKy99hfsHPQnOVpGC5AIC3JmV6+BBFs/PYh8Pm9
         EEOb6xG9MZMK6mIQwct8QudInN2aaV87VAqNpl5QP9Y/de2UeLPYpOAxIdnISVUcybnm
         p1XTmuPFD+PhvHmGJ3DvFNA3Iq9JWZ/LU+qtRfSgBNdIFu3HbwtrTbkFC+cB32QxJB/L
         MmH5an4MTVdWtrqI6W8Qr5LO35scO3bHk5zB6PGfcRINMjwPUHPHN8eKRSPtEdr3SBiK
         WjYhHCkiSXZ2fYih13WkDJ9OhmKdttab2Kertt52ukx146+vxwRGYE7i+jN/YnCuzMfT
         G+Ig==
X-Gm-Message-State: AOAM533GK2bKCXET+Gf1re1G0jEUn+973bx+9DJdbc/StBFmZ73SAq/N
        Xs2ve1fRywMi61ZuaBUEcZmXd2I1m4s=
X-Google-Smtp-Source: ABdhPJy9QP/u2kx0w2H+85EfQ+eLXkQdISE5KUuCgMaBlW8BLsPIvS9AdqdNPWb0BgJw/Sb29XViNg==
X-Received: by 2002:a05:6000:10e:: with SMTP id o14mr15186951wrx.225.1604880568168;
        Sun, 08 Nov 2020 16:09:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm4309530wmc.48.2020.11.08.16.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 16:09:27 -0800 (PST)
Message-Id: <1db6df30031bd13e3e01fe23a957c6841b9c1bf1.1604880565.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.784.git.1604880565.gitgitgadget@gmail.com>
References: <pull.784.git.1604880565.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Nov 2020 00:09:20 +0000
Subject: [PATCH 1/6] t1004: insert missing "branch" in a message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The message in question reads awkward with the name "master", but will
be even more confusing once that is renamed to "main". Let's adjust it
in advance of said rename.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1004-read-tree-m-u-wf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index c13578a635..181956b241 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -20,7 +20,7 @@ test_expect_success 'two-way setup' '
 	git branch side &&
 	git tag -f branch-point &&
 
-	echo file2 is not tracked on the master anymore &&
+	echo file2 is not tracked on the master branch anymore &&
 	rm -f file2 subdir/file2 &&
 	git update-index --remove file2 subdir/file2 &&
 	git commit -a -m "master removes file2 and subdir/file2"
-- 
gitgitgadget

