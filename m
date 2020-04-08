Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15592C2BA2B
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF8320747
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY9J2u8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDHEGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:01 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:44524 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgDHEGB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:01 -0400
Received: by mail-pg1-f173.google.com with SMTP id n13so1312753pgp.11
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0vKyosLD4rHyW4R/Z7z7R7kmZFe4+LtnGU9TrWpGSc=;
        b=cY9J2u8ftpYhV+b70Xm4fzl74PqW8zOWQsXGVDexEtyV0FOWmQ040pdWU5Dtq2/Ztt
         donzZPCyJYlwmSDJIcpiPj1gRzSPfAYmLWmDV9275FGwTwQrRTHIrQYWR5H7DjvKViOS
         07HrbF6fLgph/HMr4l/0SmnCCx1KD8DXwUUZUodCbhDFpuI4wjXmkcRkSb04N5yVlket
         pkkfcx8yZrPErlEbsNWi2AbJ0laP++fgapRFvoXIc05NmwmtTEDmr6OyJANCx8idV80G
         vxoLaocmaaYElfUNWQ6L/K8aSiZWAeZ92suXIdinKcw+lSWFU1w4ZzGt/4PW/iuIrgJs
         odCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0vKyosLD4rHyW4R/Z7z7R7kmZFe4+LtnGU9TrWpGSc=;
        b=FissCpPCO5CezsbRD/tU80kv7ndYwzgDR5uYEJhek1HUJMwx9pLODU3NhweSiMXCly
         fwFhZ+Gc4vvBY0WsFvvwax9jaHia5OPPxFYw37ksb4hx9vkzLK/Tz7kWboMisUWWqj7q
         Vro5V8juSV+JImBfTTEuxJweGgqNWeMzn1pyS7FbxtAf52iKcgBv19t9EOoataFO5mxS
         IZhqHSAmfrySkpX0ORIr72KcB04GJs7TufpATyNvqltaxRen7+QilNom6UdyNhaeAKRe
         OzE9k/7uPwxz+U7zIsLb0N3WYdGsGKrfXKRy5kd6kdQOgTMdVBtW3D0h8TVZfDmlNmKV
         hQrQ==
X-Gm-Message-State: AGi0PubopvjKUdekdsromX/cMy9XK7ealYD5rCFGGL30ZQauvqK3pi5v
        IsyI31A25RfeybzLJzd0oBzPJH4ZTdE=
X-Google-Smtp-Source: APiQypLmZUi9KVOpHGHAHHzdvRkwdgp51RWIhVhvhUr6inRXffHUVXavcFUGm34Jrjm+OKt4/Gtd8Q==
X-Received: by 2002:a63:6246:: with SMTP id w67mr5351211pgb.212.1586318759899;
        Tue, 07 Apr 2020 21:05:59 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:05:59 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 01/12] ci/lib: if CI type is unknown, show the environment variables
Date:   Wed,  8 Apr 2020 11:05:32 +0700
Message-Id: <2219bf3db9e247f5f4fb5d518f22709909d57a1c.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com>
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

