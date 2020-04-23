Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B58C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE4820728
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UldrMsPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgDWNsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728458AbgDWNsM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:48:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB32C08E934
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a7so2526145pju.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VOUgvKNu1KMx+CMgWGYhfRw9FoZU/PdCS5jVeb8Itec=;
        b=UldrMsPqpFEoqd+1+2sOVLO0KmcAskn4ABqWQAGTMN6qvTnfhwCZ/RM3HjRxz28c49
         eSmElatOLOUvM/NrZ7JQMvlOG34lC6xkHqnugs2X6hp1tzshZYPXD/PWv+/Sk7hbjyoy
         2gUZ51O4lIMtpfkEffXCfxREnTmxi2X44IkLKBFSFg1LFP1TCstle6953mZnFdM8UsWn
         aRfCweeZODmKebmTAwS+37TWGUsUluqmKTAwKEIgNTPEevt+jwmLPpKFc0w9O6C6dvNf
         7jgV3laUMpXcnv2HhVvWhF8PIGRvqP50i/plnMqxccAfQko4KSk1iE+eyMMTK3KY7rP3
         fIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VOUgvKNu1KMx+CMgWGYhfRw9FoZU/PdCS5jVeb8Itec=;
        b=aVfvEnT5ArGecKqchOrNQFoXeGGUIe6UvuGvXORw1YuSzL3J8Vnmw6YL8tEX0OUrFQ
         A88VOyEU3W2TeOuwwpA3nFRAQZbueHHu+eVXYCXZDaphBmAXrl2P8BTBWzyDVgy4F5sq
         hlSyn+mm1ZkXe0dX/WZLxofibdrFdp/QFxnl7wYAb94PuNXuheTnRBn96hV7fqpho9uY
         a0Cv5oqYcLM8y0viIZZvcO4GhLazDSyDZGSRBxqZupYeCMDpud7LLvG0o3Z9j2oKJyJV
         17pclsyErscz1+bwcXhU7rNNZSYOyyz6ToIa4pRA90NUGrSHM9wdITVn9AC9qNlNpjle
         QVUg==
X-Gm-Message-State: AGi0PuY4BNRTjKgpyI0CDIqLpgyRwQZkdAyGOJGAa8TjOXxw8Af4gYJQ
        A6QWE+taQXyTOXxOlzqxOukOKlz5
X-Google-Smtp-Source: APiQypLM1lkRCZoLO8YMgGURSj+goCLmNu0mgKrR9KfT6d1qCvkjcjikxc1qOfC4C4ZzQV9pZnjuBw==
X-Received: by 2002:a17:90a:f194:: with SMTP id bv20mr755176pjb.27.1587649690894;
        Thu, 23 Apr 2020 06:48:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id z23sm2635958pfr.136.2020.04.23.06.48.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:48:10 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 4/4] progress.c: silence cgcc suggestion about internal linkage
Date:   Thu, 23 Apr 2020 20:47:56 +0700
Message-Id: <dddf2d402702a616e04e7e446e31e0c6697d8c49.1587648870.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587648870.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 progress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/progress.c b/progress.c
index 19805ac646..fb53a2ec0c 100644
--- a/progress.c
+++ b/progress.c
@@ -50,7 +50,9 @@ static volatile sig_atomic_t progress_update;
  * These are only intended for testing the progress output, i.e. exclusively
  * for 'test-tool progress'.
  */
+extern int progress_testing; /* to silence sparse: internal linkage */
 int progress_testing;
+extern uint64_t progress_test_ns; /* to silence sparse: internal linkage */
 uint64_t progress_test_ns = 0;
 void progress_test_force_update(void); /* To silence -Wmissing-prototypes */
 void progress_test_force_update(void)
-- 
2.26.2.384.g435bf60bd5

