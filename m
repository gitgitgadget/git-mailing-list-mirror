Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5ACC4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83683208D6
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNGEjO5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgCSOAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:00:53 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53579 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgCSOAx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 10:00:53 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so1071964pjb.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jF3Kje4kuJfgfwDqUMVgVz8T304nkAZyoAQtmliVA7Q=;
        b=LNGEjO5U0BJo9R0Vm08gTHCD7d/Rz3+H4RMIcENpPVfEFKDqhzcNDt11y5VrahVIlq
         +r4ugBwCSMPOA74fdDD6kG0yQ63mPeNSVn8B9xe+nIEgo9q3ep+uZnv5Yg9IoydCN8+w
         Jmra6XOEhWX41iNlTE4FmAyySGHqZsnBwpA7H5m5Virns9Va2IHBFd5x+k2xPXaFDykS
         CpjgR0UTX/qIM5hWy3L4ThETKHb/xChE4gJZ93YCuZCChow5z7ZO3kXxnzY6xwgjxJTb
         z7LFX8PaMm7DMft7e/uzMmEvvtgfnBaps6UB0u9iPchlVUzHweZj8rYeZcZORDeaDMdC
         R1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jF3Kje4kuJfgfwDqUMVgVz8T304nkAZyoAQtmliVA7Q=;
        b=sAArIK6h+CZFpITGKI9GHu8zXqn80hg77V2diHLnC8oic9MThqnXEW9Z8MlaU5UAwI
         q9rfQr2kj6gq2Z6OiOOb+sM5HI5KwwrFJGOnTe3ADB6lKs3iijC6qunBco6Wm3/p5G/I
         a7pQXLjQorMKPtTGP08biTlyAmSFEOk2uTK+CmSCJjwRSaMKfiggBioVRxU8w7iGitpa
         Ct0hPfLfgTzX5sx2GwiTKGjS03WPTsC6lNqHCcmZvP5aOSPt53po50ISNz5HomBMtc+z
         YNtCYvL2sIB+H2RyT4QvuxNZyu/na3KiXzFsMtdSWuUFkXwx3dDZ1dvLn0eRopikHP+P
         AQcA==
X-Gm-Message-State: ANhLgQ2Su3qs8GLPctG/mAiRZwhQ1CSVDUfd0p6+OzWGDG3QoeBi25iw
        UyKLzXvwPogkRgKaQd+e5ubvx3sk
X-Google-Smtp-Source: ADFU+vuOnRLnH8ZjK1HFvlLYl8hBOjQWMBppB/sroOHSHCtndW+Sf9qxLgxqob7F0SDoKZ2ZkEV0GQ==
X-Received: by 2002:a17:902:6b84:: with SMTP id p4mr3548537plk.15.1584626451378;
        Thu, 19 Mar 2020 07:00:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id 189sm2654005pfg.170.2020.03.19.07.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:00:50 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 4/6] t5616: use rev-parse instead to get HEAD's object_id
Date:   Thu, 19 Mar 2020 21:00:05 +0700
Message-Id: <b9beadcc510301ba385f1b01b653024c8f369b49.1584625896.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.234.g969ad452ca
In-Reply-To: <cover.1584625896.git.congdanhqx@gmail.com>
References: <cover.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only HEAD's object_id is necessary, rev-list is an overkill.

Despite POSIX requires grep(1) treat single pattern with <newline>
as multiple patterns.
busybox's grep(1) (as of v1.31.1) haven't implemented it yet.

Use rev-parse to simplify the test and avoid busybox unimplemented
features.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t5616-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 77bb91e976..135187c5b5 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -49,7 +49,7 @@ test_expect_success 'do partial clone 1' '
 test_expect_success 'verify that .promisor file contains refs fetched' '
 	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&
-	git -C srv.bare rev-list HEAD >headhash &&
+	git -C srv.bare rev-parse HEAD >headhash &&
 	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
 	grep "$(cat headhash) refs/heads/master" $(cat promisorlist)
 '
-- 
2.26.0.rc2.234.g969ad452ca

