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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA83BC4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A098206E3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfKvXDAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgKIAJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 19:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbgKIAJd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 19:09:33 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E15C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 16:09:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id h2so6465353wmm.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 16:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e+P8QtsE0WM2oN3AdRdV0QxVBvrikAj4f06yxaLtYR0=;
        b=CfKvXDAhukdJUe+RKVNBTZeQkgFM549Ftx5vj7r+gJMJk/1RS1ID6yJs/oFEXCUNjt
         vQQsHcAG6QNCX1V8LhiQergLFzTM8e7Yf1yEj4WQPa67Q6n8tXYCOnIOx0kMh+0BcQe5
         dcxBKelJDOVcaiQqMNUprZ4ME0Ebo+bZPHgOE7VMd6BvjOsZwQsUhqZ2PyuVgyXZvbx5
         bdX5YCqtrPgUqYZAN4OaAJBkEfSgR6FzxOPWX9q3XK03TGgmbITJlKaI9yexiZ7AHrVZ
         DLaKx1blOEHjHzv15z7Y41xdPJy3xftdSTPkpXdfERmas84QzxzNJa7AhOzuY/wbQcQT
         1f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e+P8QtsE0WM2oN3AdRdV0QxVBvrikAj4f06yxaLtYR0=;
        b=QaXV6QbFmubCzrWXgnFeH8GFuQxwtX0jwAhRziX1Lz0oARkOW2WEmNmWcXb9MhUWLS
         Za5h/q5UUQ0vl10XceUYE7Ez0zhF/RqvpuArx4Qd+FZU57LxfVZ5mO0Jtt9lxkK8Gy3O
         HZvA2d5pfWbMuPFslMcLxasK8gLnjgPyrwJ2RG4AafGPWULm6lh1XRpee92/bH3MHwpE
         FOUMqmyWJem2UsBDPtTTEkSC715sEe74+ZdBa9GWWPi06FMrBclz6qInaMnju3cfs0Cq
         BYuwfbElm9ZWl/Zo9TVus9aXcDRFp1PX9YlLzPfbH0xW+8ZjnZ46WQRB/SsrTD+Z8UvQ
         goQQ==
X-Gm-Message-State: AOAM530C14CNvirDwpqyt8S8hyI3DHL8urKtaAqQBoJO4YufqNHo5w75
        XJ/ztqYPWcb/WYk3Yxu+aHzvry51yQw=
X-Google-Smtp-Source: ABdhPJyZHBodLVUZrupJTIUa/HHZCpxvrhiEilAAAI7qyOQn8HhsRTbl/NmJulyNoM5Zpi23f/pybw==
X-Received: by 2002:a1c:c2c3:: with SMTP id s186mr11868354wmf.160.1604880571819;
        Sun, 08 Nov 2020 16:09:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k81sm12906568wma.2.2020.11.08.16.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 16:09:31 -0800 (PST)
Message-Id: <36ed176a4e0ca19a38f1fb968ac8bac83a288fd4.1604880566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.784.git.1604880565.gitgitgadget@gmail.com>
References: <pull.784.git.1604880565.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Nov 2020 00:09:25 +0000
Subject: [PATCH 6/6] t9603: use tabs for indentation
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

This patch will let the new `check-whitespace` GitHub workflow be happy
with the upcoming patch series that wants to search-and-replace `master`
with `main` in t9603 and some other test scripts.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9603-cvsimport-patchsets.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index 3e64b11eac..e7a91611dc 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -17,23 +17,23 @@ test_description='git cvsimport testing for correct patchset estimation'
 setup_cvs_test_repository t9603
 
 test_expect_failure PERL 'import with criss cross times on revisions' '
-
-    git cvsimport -p"-x" -C module-git module &&
-    (cd module-git &&
-        git log --pretty=format:%s > ../actual-master &&
-        git log A~2..A --pretty="format:%s %ad" -- > ../actual-A &&
-        echo "" >> ../actual-master &&
-	echo "" >> ../actual-A
-    ) &&
-    echo "Rev 4
+	git cvsimport -p"-x" -C module-git module &&
+	(
+		cd module-git &&
+		git log --pretty=format:%s > ../actual-master &&
+		git log A~2..A --pretty="format:%s %ad" -- > ../actual-A &&
+		echo "" >> ../actual-master &&
+		echo "" >> ../actual-A
+	) &&
+	echo "Rev 4
 Rev 3
 Rev 2
 Rev 1" > expect-master &&
-    test_cmp expect-master actual-master &&
+	test_cmp expect-master actual-master &&
 
-    echo "Rev 5 Branch A Wed Mar 11 19:09:10 2009 +0000
+	echo "Rev 5 Branch A Wed Mar 11 19:09:10 2009 +0000
 Rev 4 Branch A Wed Mar 11 19:03:52 2009 +0000" > expect-A &&
-    test_cmp expect-A actual-A
+	test_cmp expect-A actual-A
 '
 
 test_done
-- 
gitgitgadget
