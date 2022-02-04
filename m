Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8151C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378110AbiBDXs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357383AbiBDXss (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6390BE009500
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w11so14053869wra.4
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kzZJabAOz3DHXIqAj2MP13q4GE+yZTiv+cr62TnVioc=;
        b=CnVqo2gbLpZ4P3vecIxkamBrmoE1awMB7c0/ECSQsibaX6JDEddgfoDrTEjuCs5QjK
         3PwftMh2w9fsMC0qZbljVif9j5VBOH1KinQj/l2DBN6Xn4LrXkZRLGLMlTtNKf+bRytF
         AYtdcGL/9MwMScgpLqvTsr8yn6Nr25Cxhj5tr75tzZx9Nv81Mf46KNbcfa//6Ltta0Aq
         ipY3YctBLbJtLmgS/O0eI82jbeEnjD70RT2A2L0rsmliEU7cagarElt2mgKTeIW3zjUh
         mT+jpVfnnynOeb7R88phm00z7ALprfS3AhMQcko16DJ/f07O9HG+ofVcBsCcltZKl4sq
         8Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzZJabAOz3DHXIqAj2MP13q4GE+yZTiv+cr62TnVioc=;
        b=lrj8k+UDZ0o2OoI588kOxvLzi/yZQa/k/9BifrpbQADYOa8nCEslp/tuVSA1OZDWBx
         BPKSPZntd64ZMFP3S30pYKhjIwcIb9t5ZVpD4ShNaUoEtyp69lYY2zQDEstCTFxTphZU
         eQ177vxQxCjwNZEGB+XtRLWXddbT8rWURD8v0nwufX2S3lAqgZBf/UhDE3FDHmFzxC56
         kcgeBxY4NRmQV279r53TzMQXrrtbeoLAwyDGXfaj9GA0g9fxpYDUyoiqv9oRIjVNBs0E
         jNQD5dOyIVQbJeN54jaw9js7b9iS0z8JkdSFudK3Z74FnioFsbX46Y0E5l7ocl+DKGlj
         FsnA==
X-Gm-Message-State: AOAM530Yfg2sTCzFMMaFPD6ZO5BAbMi60oIWJ3Rr2sxFayt1Ia/go4XC
        Ba1pr7aPcNsNSfQ51WUAxWnaBv2luF651g==
X-Google-Smtp-Source: ABdhPJwOhLoC87vYF98sOTTJgMcSR/9hjVo/OUsEqv+N1cb8ekxB1WEN7tX4yI2komoIdJwP0wLKlg==
X-Received: by 2002:a05:6000:144f:: with SMTP id v15mr975632wrx.407.1644018525782;
        Fri, 04 Feb 2022 15:48:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/12] object API docs: move check_object_signature() docs to cache.h
Date:   Sat,  5 Feb 2022 00:48:28 +0100
Message-Id: <patch-v3-06.12-bdddaa3648f-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the API documentation for check_object_signature() to cache.h,
where its prototype is declared. This is in preparation for adding a
companion function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h       | 6 ++++++
 object-file.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 281f00ab1b1..98d1ef08579 100644
--- a/cache.h
+++ b/cache.h
@@ -1319,6 +1319,12 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
+/**
+ * With in-core object data in "buf", rehash it to make sure the
+ * object name actually matches "oid" to detect object corruption.
+ * With "buf" == NULL, try reading the object named with "oid" using
+ * the streaming interface and rehash it to do the same.
+ */
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type,
 			   struct object_id *real_oidp);
diff --git a/object-file.c b/object-file.c
index 271acf4dd15..44e0b32d71a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1066,12 +1066,6 @@ int format_object_header(char *str, size_t size, enum object_type type,
 	return format_object_header_literally(str, size, name, objsize);
 }
 
-/*
- * With in-core object data in "buf", rehash it to make sure the
- * object name actually matches "oid" to detect object corruption.
- * With "buf" == NULL, try reading the object named with "oid" using
- * the streaming interface and rehash it to do the same.
- */
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type,
 			   struct object_id *real_oidp)
-- 
2.35.1.940.ge7a5b4b05f2

