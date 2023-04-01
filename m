Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC67C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDAIrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDAIrD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:03 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6542921A84
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:48 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y184so18416758oiy.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv/84jJ95LUJtgSdw6cyvY019USNM/pNv0RPs8c5eMI=;
        b=pJHxTspIpIJM8kYcdlNN5r8FdKswgv02OR544aZgywkYQKUAxtCZmzDDzzJUHAf0FY
         4/V4DrNmrqPZgvajdpY2DipIQRTU1cneZHX2h1JDsze8tBDFtB8S+28YmB3ZkxoIgsKX
         LE4ECC3aKawMz2YLsLrXAEQokRcu5IyCRNMb0pwbnLTfpRT5RpEG7p4xKNxjc+lG5X7n
         ORECnvvG+ntlNqVqTzQIRMx9CghYcAy1P3Q41Kx899JyuSS6mbhtAyk1nHIsL/RvG7Nh
         5imPXNFHYWxCG6Q6YKIcsAZv9ZbcIdRjon3de+sPC0YqXgsMIjekcm6isvclPtTGAnn/
         iI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uv/84jJ95LUJtgSdw6cyvY019USNM/pNv0RPs8c5eMI=;
        b=vRYcNBvhxjKmk0Bkcm6MaC0BOX+gNuWX2kry5YICmBtF+7gPz7wIRRXOAjBhNdElmw
         /IppvuwerW3Jxv4LDEXl0CxMEP3nGQt18zJV+JG/KrTpwD+uGtxwCbG4MqZrHxU5T+vy
         UiOWAhkIGy0duGqe17cXp7yGUJZZ0S5gQH4ePUebcidIpx5OCCSoBoO6A18//AUChnCm
         sYMYhNtpTxl1OsdOoUAkZH1mLUODJcdDJKn0HMsYQq6BfMpyz2fmJTFCrXK5QY7n8hPi
         Jt1jPhZeOEOvBxGLsJSXcjVBFv7ZxnDP0TqpGrIOWL04sZtiJ1z6y3Zr0eiAbXE1ruyt
         Bx8w==
X-Gm-Message-State: AO0yUKVWPsgvMuAP11ucVGkBxsZkyI3EA05AEXDsIA67999cXCLEWsgC
        YPAvnMc/rdAWA/QZpJGXONBhxlE9WYQ=
X-Google-Smtp-Source: AK7set/dreFN8P2iCipGEEUdXm+Hyq4TLxOJhWy0ocA1q2x2fbAnOeuzldzc5oZMs29qbitR9RD/HQ==
X-Received: by 2002:a05:6808:1443:b0:386:9c8a:ed74 with SMTP id x3-20020a056808144300b003869c8aed74mr13105005oiv.38.1680338807349;
        Sat, 01 Apr 2023 01:46:47 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o47-20020a4a95b2000000b00524f47b4682sm1780295ooi.10.2023.04.01.01.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 14/49] test: completion: switch __gitcomp_nl prefix test
Date:   Sat,  1 Apr 2023 02:45:51 -0600
Message-Id: <20230401084626.304356-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default COMP_WORDBREAKS includes =, so it's not realistic to test for
a prefix that almost never will be there.

In bash there are no functional changes, but in zsh this makes the test
pass.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh     | 6 +++---
 t/t9904-completion-zsh.sh | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index bfd8570885..9d973f21ce 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -565,9 +565,9 @@ test_expect_success '__gitcomp_nl - trailing space' '
 '
 
 test_expect_success '__gitcomp_nl - prefix' '
-	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
-	--fixup=main Z
-	--fixup=maint Z
+	test_gitcomp_nl "branch.m" "$refs" "branch." "m" <<-EOF
+	branch.main Z
+	branch.maint Z
 	EOF
 '
 
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index 9221539296..ee8cbe3320 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -199,10 +199,10 @@ test_expect_success '__gitcomp_nl - trailing space' '
 	EOF
 '
 
-test_expect_failure '__gitcomp_nl - prefix' '
-	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
-	--fixup=main Z
-	--fixup=maint Z
+test_expect_success '__gitcomp_nl - prefix' '
+	test_gitcomp_nl "branch.m" "$refs" "branch." "m" <<-EOF
+	branch.main Z
+	branch.maint Z
 	EOF
 '
 
-- 
2.33.0

