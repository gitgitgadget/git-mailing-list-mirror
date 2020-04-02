Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1AFC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41D420719
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5UwrtEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbgDBNR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:17:29 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41311 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbgDBNR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:17:28 -0400
Received: by mail-pf1-f180.google.com with SMTP id a24so1730199pfc.8
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n77DzuaAwDbvPneZ1mVTrwO5eaYfIQGdf0jbE+9yFcs=;
        b=f5UwrtECffJIoFcuavZs0k78XLfFri6x7hk+JW2tGkZjNXfsDiLExTVqLw7Qv5a9Qb
         9EJGcICWJ4X/WnJlUYftPA+rQJ5u/d/NK8EfhcOw+aSFJ0fVMsktQ00S6wSEDzuKedFJ
         uLBuPG5PplINDPJX0QNa42W3FEs4+jTPnpN425E1mKFXhJQeddOBQzfhEz3htVZPH5av
         3JUg56i4vXdp0bjKoBwJsqLN+O5lXqMM7ufEt1TCcmnLiSDImf6WGuYHRX4fuvOkAZwu
         Y/XpgwVmyxCM3b3Krwvn8eAcPJlMJqe9R2GrqZj7s6B1GP3bh4b0XYhWCL/ixYeoIHYQ
         YDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n77DzuaAwDbvPneZ1mVTrwO5eaYfIQGdf0jbE+9yFcs=;
        b=CXVCEpuxYGMBQwJpspnR3H/5c5tjfyuzV1ks2GOYS8L/tl9J+6nxTe4WKipOHbubux
         4RHNpy9tJdTOwBWwtC/hz78trIXjLHrr3yB7o0D8kPBacr5FfY/K2V164x2Cz5cGatqH
         UMquhcLf2J0d+Pf1zOff1EyEd4ezxZrLt9LdCLpgMR05NXy7AjsigzsosioHcdYzBhoy
         zNSg6tt1iwSrvLgekm+dXKBuFJWezrDrFP2giwUKD+VGDpoZDi+aMmYPLiEyzd9/L5Hz
         QfOBcnrpPfE7S/0+OwNsUeN27XE2+MSp4REiKLfZIZcLtWPO+mF/glSG2EjB62tQmh3S
         WHXg==
X-Gm-Message-State: AGi0PubCloVpLEyaxxz6Fs+J7etAvmsdj2bVV4/maxixHKw1IOqnidIi
        Mos3IKTFv76nODvBzW0zko53VuQW
X-Google-Smtp-Source: APiQypKpI1/WrrxXWM6JlDZRjPr0BI7xGxTBk5EVSNaNLE/iFN1EN976z5Idq2O0yykbMwfV5+H42A==
X-Received: by 2002:a65:6816:: with SMTP id l22mr3243124pgt.420.1585833447389;
        Thu, 02 Apr 2020 06:17:27 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id g18sm3350711pgh.42.2020.04.02.06.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:17:26 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 1/6] ci/lib: if CI type is unknown, show the environment variables
Date:   Thu,  2 Apr 2020 20:16:55 +0700
Message-Id: <3f9f1c6335d95cc8120697cf7293a7a755b1abb1.1585832999.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585832999.git.congdanhqx@gmail.com>
References: <cover.1585756350.git.congdanhqx@gmail.com> <cover.1585832999.git.congdanhqx@gmail.com>
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
index 87cd29bab6..bda746df68 100755
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

