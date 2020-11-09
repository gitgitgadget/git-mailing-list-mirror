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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C38C4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C715A206E3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9/mcvsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgKIAJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 19:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKIAJa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 19:09:30 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237C9C0613D2
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 16:09:30 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so6929467wrc.8
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xCSBChLKhDbQVTFUHVfwWDOOo7f83sXWJgg86q6WVBM=;
        b=H9/mcvsjUcrKTt62uMmdwlhboqj47fyxQ4ECWFStQYeyOUOSU/hvz0mWJc6UtHswXb
         /BWrgSXB9gWRLKoAQzts6IUfM32WTMUlqP91dUi3dpZkMubpMHAE7wZ8BJrKg8Q5axJN
         DrcOA4TsVpASFcAyclSgh8v6WAtbz2u3xNDB9RhKofkH/ZSJjt3S2cAiwAglF3HdGhpT
         YtAoOEomCEphmHhYzQjRKJPJh4g9LPBcpSAxTQ3UIs+NUlMJAW1J/pgT2vGxyeGIACQw
         PXoKQ2cC7Cha4BHjnMuNI5j32JjjbbxjSu6xeqb/cnD9ChwplE783yCv3d4+w2+7DX1J
         OFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xCSBChLKhDbQVTFUHVfwWDOOo7f83sXWJgg86q6WVBM=;
        b=JCH0d2UGo9CvI3AxjLKjhtf37bKTw+nYK1NpvATXfQSPAxCj3oaf0El61mBjWX9UQj
         e38Bxwgjc1vccEHUXddm2jZ/KWK8nyMCu0l9+HKOYq0Bq+QrfLA7IVl2h+l8Ag+MGMNx
         zCo0iHisQAAknDWOY6rO5lkCK4cbgtmTyeucPER0ovz3PljWXIn3Hq34pSBfeHAaO/RS
         XbfbBsRNaOQb9tU27ulHqmZIAhk0KvKcISm1hmr+4eLzwykBgG/8WA892k6YRWFLr8Xa
         DYOMTuWNtsCAYDav9OMNHHLtiCnL/FxTy7ejz4w7NZ33BsyrT1IPBZAbJT4Q+IRlsknY
         FanQ==
X-Gm-Message-State: AOAM533V71PYIPVtqLySoX7CCDID0QqRfK/5p9PHRRXowNmgkkhcx/6k
        ufTxaBiCxdmT7O5XTHbaV5OQV8RfTOQ=
X-Google-Smtp-Source: ABdhPJxX9kn1jYR8/sZBHyEdFlr8rsGu2+SZMPM61nItqWLugcnGh8jEy6Yg7lse9SYC2TJvvnXSVA==
X-Received: by 2002:adf:93e5:: with SMTP id 92mr15100209wrp.421.1604880568820;
        Sun, 08 Nov 2020 16:09:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w1sm11330456wro.44.2020.11.08.16.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 16:09:28 -0800 (PST)
Message-Id: <edf42c4df7a94d16234cb6c19765d0eba9f5049c.1604880565.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.784.git.1604880565.gitgitgadget@gmail.com>
References: <pull.784.git.1604880565.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Nov 2020 00:09:21 +0000
Subject: [PATCH 2/6] t3406: indent with tabs, not spaces
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3406-rebase-message.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 927a4f4a4e..4afc528165 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -46,22 +46,22 @@ test_expect_success 'rebase fast-forward to master' '
 
 test_expect_success 'rebase --stat' '
 	git reset --hard start &&
-        git rebase --stat master >diffstat.txt &&
-        grep "^ fileX |  *1 +$" diffstat.txt
+	git rebase --stat master >diffstat.txt &&
+	grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase w/config rebase.stat' '
 	git reset --hard start &&
-        git config rebase.stat true &&
-        git rebase master >diffstat.txt &&
-        grep "^ fileX |  *1 +$" diffstat.txt
+	git config rebase.stat true &&
+	git rebase master >diffstat.txt &&
+	grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase -n overrides config rebase.stat config' '
 	git reset --hard start &&
-        git config rebase.stat true &&
-        git rebase -n master >diffstat.txt &&
-        ! grep "^ fileX |  *1 +$" diffstat.txt
+	git config rebase.stat true &&
+	git rebase -n master >diffstat.txt &&
+	! grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 # Output to stderr:
-- 
gitgitgadget

