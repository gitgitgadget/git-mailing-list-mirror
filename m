Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E7BC4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA81560F22
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhHQIQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhHQIQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:16:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF06C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so1549991wmb.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tYA7Qwc1dr+O2HZdbGQKjwxjIahfbtOq5Fi73CzrHY=;
        b=LeqQKgEyZFc4WMrRS3LZxF+dWbAeyHF4W5gyPJuO15RZYK164GHBO5Dq99wa8ULMUC
         +9Vh72XeXMgIWPQJjhvOF3NujaGi2rs7G9q3Z6VpBmSCdj6o0Q+HGBUUwpfsl0FxTh4Z
         U1DT5MlpFSBhrkmJVwQl9kGI9nkTrVAgUYJxPh4oh1HFYqFQhPMdGNi2l1Kv2bgiFz+Z
         bMYcR7ZjgntBJv6MAdNPm4vT4L+cM2R+PnA+ZTi4UOgFVNDFAG04d9Bnmn64A8C3VkN3
         spta4/jLmZA5fQpOEUGLoYastyLT+slvVNYR5TLyub0pjasyKlnRPHnNRfn6l7byFc0U
         OnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tYA7Qwc1dr+O2HZdbGQKjwxjIahfbtOq5Fi73CzrHY=;
        b=J1R6pFO7LLr2Ztf7X9jFUF1iizyS/4J4ciXQFF27SoPI4bDsd9hjuUZT+M8zvv6utW
         drknYtkZsEl2SJY7UCfz8+Bdg4m2NbOtSLbvmNOLPztbpM5y49LsjlfTtaGqagOQqmHM
         WkwNSgUCz2hREA51gsEVvZ0iylXr/lTYebCLlwZoVI5WdR//CYx166j+lb/x6V6qTLyI
         61vNytdKooWwr6tp9Nttpu0QJAP6cShmB2exOSuLA80b/VeaDX2qjSk+BesemloHE0nt
         Jtgvzca4RGp5gM2+sWy21NcpdPKaXmArBSR5Oqg9ISBELaLWEN3fKCtUss20AkeJ8jEA
         6M0A==
X-Gm-Message-State: AOAM533yvdgfHhixwGGHOefKJeZD4sn36+ZJLZi5652IoOxvdZu9tq2g
        jSB7huwc5ulavsvNGtLUQOq8GF0dcA0=
X-Google-Smtp-Source: ABdhPJzhEBPHI+gi9qDiRV6kjv3FsZwMuIThSo2G8Ot4hxVODOAhB8wf47h4kXr3OQER8ozz1BK6aQ==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr2099199wml.162.1629188153827;
        Tue, 17 Aug 2021 01:15:53 -0700 (PDT)
Received: from localhost.localdomain ([178.237.233.111])
        by smtp.gmail.com with ESMTPSA id l21sm1256238wmh.31.2021.08.17.01.15.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 01:15:53 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 2/6] t6030-bisect-porcelain: add test for bisect visualize
Date:   Tue, 17 Aug 2021 10:14:54 +0200
Message-Id: <20210817081458.53136-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210817081458.53136-1-mirucam@gmail.com>
References: <20210817081458.53136-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to control breakages in bisect visualize command.

Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index f41453cc97..99b7517400 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -976,4 +976,11 @@ test_expect_success 'bisect run fails with exit code smaller than 0' '
 	test_must_fail git bisect run ./test_script.sh > my_bisect_log.txt
 '
 
+test_expect_success 'bisect visualize with a filename with dash and space' '
+	echo "My test line" >> -hello\ 2 &&
+	git add -- -hello\ 2 &&
+	git commit --quiet -m "Add test line" -- -hello\ 2 &&
+	git bisect visualize -p -- -hello\ 2 > my_bisect_log.txt
+'
+
 test_done
-- 
2.29.2

