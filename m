Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E45C2BB86
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE832145D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQKpOV35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDJRSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:18:24 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:34647 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgDJRSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:23 -0400
Received: by mail-pl1-f178.google.com with SMTP id a23so861980plm.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0vKyosLD4rHyW4R/Z7z7R7kmZFe4+LtnGU9TrWpGSc=;
        b=lQKpOV35E9S+z8D9n0GuQapQotOKLLSJdLGfJ2bZ+RiiVdCEM9zx6XObCrGBDMnqow
         as3p5FjUue+VSmJKadl1CO6xkrnHICDfQzHE14slwb2UiOGX/fveoz5osMkFXRFVXfB1
         0O1opI7W/OXBbPZ93ai49BiwAX3L/0jU+uyaH0nsZ7xmSHREuvNZVSEG8wWo9LxlOZhS
         L7EF6C9jrcsF6fzlqidpWHAt3srVXx8THEZisG0jV9eGivB/4ZbRm80Sb9Pj9nFVzjYz
         zxFJulamnzkxQmoBHyl1jN0rlyvEK0op1jLew2+vP1WvUlaO2MC319YdYjcjvWeYXFEk
         l8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0vKyosLD4rHyW4R/Z7z7R7kmZFe4+LtnGU9TrWpGSc=;
        b=PgzZMA3yjqeq65M9sUaTkzs/TpUTiL3UFAarMIWmSGCMBvqIk5/TPP+k3CfAH+L1Nk
         UBGnZ341r0OUcqwJ+W36tYZuorW2YeYJa+Tk152dcXS1n87Ppl89K424vCIe57xFqJrp
         R7ACpcJer88dCaMIBW+wGxGyni7oOGdLvSSILeCq/jUK7J0f6ffi/PUiuJ4CAKR+xd8P
         yZMwEiTvTf+gcnPymV3XyT3ktNh7wjN9x630wb09n4H4QLKeNP7NYk+7Xx+vmy/edCnV
         8rJeNBYskx2aXBi0O+B9Uxol0dcs+rLcQJZBWEH6qJi/oJ6X/CaFDhfBpwaGyiE8jdyj
         UC4A==
X-Gm-Message-State: AGi0PuZb3ceEeHfd6HRe/xLeLzfU6TmFnw5+p280EM5xP8HoTpv2NvC0
        JKRDT8F0FdjwlOQIajHR+NAQ/0nc
X-Google-Smtp-Source: APiQypKK6mJuZk6g7YdnQE2qH/E289NTul7cFg2p8vmaChtc7AEu0KsBe3Bhr/lJyBw5VRv+9kqDWA==
X-Received: by 2002:a17:90a:290a:: with SMTP id g10mr6451777pjd.81.1586539103043;
        Fri, 10 Apr 2020 10:18:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s125sm1972897pgc.12.2020.04.10.10.18.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 10:18:22 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 01/12] ci/lib: if CI type is unknown, show the environment variables
Date:   Sat, 11 Apr 2020 00:18:03 +0700
Message-Id: <2219bf3db9e247f5f4fb5d518f22709909d57a1c.1586538752.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586538752.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586538752.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This should help with adding new CI-specific if-else arms.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index e9a5c51425..05fbcf681a 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -138,6 +138,7 @@ then
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
 	echo "Could not identify CI type" >&2
+	env >&2
 	exit 1
 fi
 
-- 
2.26.0.334.g6536db25bb

