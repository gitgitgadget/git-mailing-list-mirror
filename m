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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80218C388F9
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27646206E3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPEGSd/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgKIAJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 19:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKIAJb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 19:09:31 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0442C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 16:09:30 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v5so6468219wmh.1
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ygeWu2tMnyx/kWndfQ7auYIYsgjr2fB0FuQj+dvcbRs=;
        b=YPEGSd/BySAdcqLAqPRhVA/SpEkgqqrZPV5K5MYvHmBXiLo5ewX5Cd+kS5NVYSzPRN
         TiwGO5UaEusdPWLk+FyfH4kda+xv0SU4VOoXeTXxzqLrD2uRlWrjX2DeZgV4ymLNHTOk
         zu0EdUiBRWkrT8FuW1/9cfN7HeNsopqdvOfdz821yRw7B5iQLoITO0jAB3tP6a4g0ZUV
         tWZQaz00qnLGRQ8okggsyGoTnhTPEH8n3HZJj8KRefxv2yxoJ+dBLzIxe3k3J3UJi06+
         j7fX2uh5sjRogX4o0mLLafLQEls3dEJ8W2Uu3WVpxJLngGhNcCfPL2VQydSSUT3Fa30a
         Uyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ygeWu2tMnyx/kWndfQ7auYIYsgjr2fB0FuQj+dvcbRs=;
        b=sTlZNnhIBGU/9wenI4jPEA8WPy59LvMfd8KtG2ZhXyfo6vQZHJWIDKWYvUl0QCLxDm
         UWaVqc/rJO87wUEPXPYzonmD6FVTXggIkceMDbTofInOoHJ9v5++n86HH87ST0+OodCH
         C+eKhITXD6Tn3KuJJczCKoymMIxAR3pEzlA6Bjrln+OWband8qWvaRGRf/JychBhY1VV
         5kKGPutGyEGB9mlcRBqdUv+eIm6zT5dKQeXe2dwv1OMG//Cra/EjMivz3pvX1lM5lqTu
         jDpwWP1StuYBpql/0u59Bj3qzC8d9Dq7ARn2u/g72ghc8a19OvNqEhPnioLWoJK7qsVS
         /bfQ==
X-Gm-Message-State: AOAM5324G20HmP0EURAl5Hh/begZ5Woe7UvlkYn18qKceZNdFGhUnYRh
        +Gzi661InCU9aqYBNhJLSPQtpxctrtA=
X-Google-Smtp-Source: ABdhPJz8tdM6U4Umr8H/3L4vPTFudHax0wYHq6NI+7gmoAXLPv5whdHr1AgbRGucPZZzqaPygzbdHQ==
X-Received: by 2002:a1c:b0c8:: with SMTP id z191mr10991029wme.99.1604880569479;
        Sun, 08 Nov 2020 16:09:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm11465673wrj.60.2020.11.08.16.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 16:09:29 -0800 (PST)
Message-Id: <1340feb2dfceaf9215495af2fd970d30866f7a76.1604880565.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.784.git.1604880565.gitgitgadget@gmail.com>
References: <pull.784.git.1604880565.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Nov 2020 00:09:22 +0000
Subject: [PATCH 3/6] t3427: adjust stale comment
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

In b6211b89eb3 (tests: avoid variations of the `master` branch name,
2020-09-26), the `master[123]` branch names were renamed to
`topic_[123]`. A non-literal mention of the corresponding files was
missed in that commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 2a7d958ea7..5839719ba1 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -19,7 +19,7 @@ commit_message() {
 #                             \
 # README ---------------------- Add subproject master - topic_4 - files_subtree/topic_5
 #
-# Where the merge moves the files master[123].t into the subdirectory
+# Where the merge moves the files topic_[123].t into the subdirectory
 # files_subtree/ and topic_4 as well as files_subtree/topic_5 add files to that
 # directory directly.
 #
-- 
gitgitgadget

