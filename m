Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E53C433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 11:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0742098B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 11:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwjHtdFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393735AbgJTLoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 07:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393732AbgJTLoP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 07:44:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D68C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 04:44:15 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t4so873990plq.13
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 04:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75002kI6Sz9A1VtaOvJzjIf/HZtevb9xw7ms9rpQt+o=;
        b=jwjHtdFJkhV/wdg4eVNawZweHMqSw2uFdsb+Zk/qzQWnd1IGjuYMSOyHrU6aO8SwWo
         NRCUf0zuiNv4v7owRdZmI8P9tmrih6u4IXiQ/PJNUt32UxVv9tL3lGrdxFuMVb95uabK
         hZhUjpl0LBUuuYehYQPty11xZ4Nc0LvYUwCWM4GGGarMD/ZHLa8WuHE9QPtj+PfUdI2h
         jHIGDLwFMBjc6ipBihu34DpMmDX6LLqL/6ve6JRjIlTgLcPzkc66BhhjeIiE/or0H7m7
         B/xZ/gpuw+Ks4w2N9AAWxnxd++cE669sU4pgVWo4an21OdjWGVXBE9AqYycQqMR1Tlhv
         +/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75002kI6Sz9A1VtaOvJzjIf/HZtevb9xw7ms9rpQt+o=;
        b=nsYKm8J2OFTOTldIrs39TxHZXHSmok78g6YCthRVwLqjaO+nui7+obirlKP59W+ZYl
         bNHzhb4WRdJhvfN0+Ke8GfpRyRhOsfM1ZLLoA/aVflDYo2dnxIN20lS8xQq/87TDt0IJ
         O+wC3zFOfZ6IHBNtNxYWbpq7L7NX1F71P4F7GTJtq3HywTeaFTez35QTWEmQ2EDZSxoA
         OLygfQ8yMXRVs7+8jjw75CJvYpzW6j7Rw+qDlrz9RXOWpAEOwEg6MVT+q8jLbESm9YvC
         OvhlRMeRp5EwUzyxfMcUAwge9QXWPC34c3j0uJZdQaS1vD4qhYOHhJi+5GOj17TchjR3
         FuYA==
X-Gm-Message-State: AOAM533upU7oZZp1Z0PeiFg31fAuHL+0lRlaWiF60zQIuqi6ouOo2JM9
        GBQI/bCVxboPrrP5JcKqim8Cxq4u4nYm8ZaQ
X-Google-Smtp-Source: ABdhPJzw7G3eCcmEaann9bSDSUo/nNifSJ+atLw4hEtXjr8apB2HpD8hZ3kLZfzuWyT8XIOF9u+p3Q==
X-Received: by 2002:a17:90b:710:: with SMTP id s16mr2560799pjz.138.1603194254770;
        Tue, 20 Oct 2020 04:44:14 -0700 (PDT)
Received: from localhost.localdomain ([106.215.55.55])
        by smtp.gmail.com with ESMTPSA id y22sm2204615pfr.62.2020.10.20.04.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 04:44:14 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, congdanhqx@gmail.com, me@ttaylorr.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v3 4/5][Outreachy] t7201: use 'git -C' to avoid subshell
Date:   Tue, 20 Oct 2020 17:13:18 +0530
Message-Id: <20201020114319.18245-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201020114319.18245-1-charvi077@gmail.com>
References: <20201017075455.9660-1-charvi077@gmail.com>
 <20201020114319.18245-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7201-co.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 74553f991b..5898182fd2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -339,10 +339,7 @@ test_expect_success 'switch branches while in subdirectory' '
 	git checkout master &&
 
 	mkdir subs &&
-	(
-		cd subs &&
-		git checkout side
-	) &&
+	git -C subs checkout side &&
 	! test -f subs/one &&
 	rm -fr subs
 '
@@ -357,10 +354,7 @@ test_expect_success 'checkout specific path while in subdirectory' '
 
 	git checkout master &&
 	mkdir -p subs &&
-	(
-		cd subs &&
-		git checkout side -- bero
-	) &&
+	git -C subs checkout side -- bero &&
 	test -f subs/bero
 '
 
-- 
2.29.0.rc1

