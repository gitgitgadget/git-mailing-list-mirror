Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86967C433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiBXJeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiBXJdu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A456A279922
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n14so1620638wrq.7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGak4HACwxaq5OfHBtQAyyyhekDg+vEAzJg30id1xUM=;
        b=mo8SPTBkGaF7uKa5+gAbM/0iSTexdeoSVWTtTD5LxL7k8oEwZkFr3CzvlD/1VKIQzx
         h5tJ4n19DzH6a0wm5+p56oVRS7/3GMDx60bdGck/j4t8pul9mFf8yZLPhcsgSr6AqK0L
         M4XLwoqnXlzYDVl0K87npVbiBD8m9/6vJetpFiMVavNgU7C3523WecTFLJnt/xNmHkvt
         ogMWN4UHQae3Yzz3ai6XoE7J48+vuLSJax+xLg+IP4SGv5MexswoTe307g+suTTNMGw1
         JhDi+ilz/c0cwj5nCSTCjkVd7iJnGO0sh0YrwXh/mLDLX077Tp+kNmbFs27QlK4g4vY/
         A47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGak4HACwxaq5OfHBtQAyyyhekDg+vEAzJg30id1xUM=;
        b=dUkWb/a7lBMikx4xLuGE8rqQ4zfs/snFMVD910/y5gCj4uqUQKnfBvjPumztYAdX+d
         QnaBWgx79s7kl5RX2bTIqBqgTo4XzecljJBAU4fESy6YbUgPM/yj6POBTgEQ8y06HREx
         jJBYEHdxMu/Z5qaobEWyMPD40mP8APA0QuAqxi+b7lKqdeVqTmbPKr0xOKZ+3UWS8y3k
         sV5sah0qdSnaZnEJEcB79z9UwaCFBJC6sjuj0DTPU0wcnctvKcH1Hf3BTo87qQkfvfZj
         4VLsOSTa2Xx31Z8srxU+/dW/LyIv4Ubdw35024jOiTNCwNHWzHj5TPgbWJhyoc8mRrbp
         LTXQ==
X-Gm-Message-State: AOAM530VOzPEW8dBd4TvhIQoXkmqshgQrTHkNIr8rOuXIKeDrsOJAo5p
        lR6J+aE3AGNZZxAoSI/TN9o9GcvG2njQmA==
X-Google-Smtp-Source: ABdhPJzN4IdU9ttvcVv304vObE/JcZGy6OhIyft9DaGNbqof0Up7Q++a0i9uAFs76qclwv6rTDN+eQ==
X-Received: by 2002:adf:d852:0:b0:1ed:9eaa:bd8 with SMTP id k18-20020adfd852000000b001ed9eaa0bd8mr1462651wrl.399.1645695197959;
        Thu, 24 Feb 2022 01:33:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/12] userdiff.c: use designated initializers for "struct userdiff_driver"
Date:   Thu, 24 Feb 2022 10:33:03 +0100
Message-Id: <patch-08.12-9becff4bae7-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "struct userdiff_driver" assignmentns to use designated
initializers, but let's keep the PATTERNS() and IPATTERN() convenience
macros to avoid churn, but have them defined in terms of designated
initializers.

For the "driver_true" and "driver_false" let's have the compiler
implicitly initialize most of the fields, but let's leave a redundant
".binary = 0" for "driver_true" to make it obvious that it's the
opposite of the the ".binary = 1" for "driver_false".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 userdiff.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 8578cb0d12e..2d9eb99bf28 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -7,12 +7,24 @@ static struct userdiff_driver *drivers;
 static int ndrivers;
 static int drivers_alloc;
 
-#define PATTERNS(name, pattern, word_regex)			\
-	{ name, NULL, -1, { pattern, REG_EXTENDED },		\
-	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
-#define IPATTERN(name, pattern, word_regex)			\
-	{ name, NULL, -1, { pattern, REG_EXTENDED | REG_ICASE }, \
-	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
+#define PATTERNS(lang, rx, wrx) { \
+	.name = lang, \
+	.binary = -1, \
+	.funcname = { \
+		.pattern = rx, \
+		.cflags = REG_EXTENDED, \
+	}, \
+	.word_regex = wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
+}
+#define IPATTERN(lang, rx, wrx) { \
+	.name = lang, \
+	.binary = -1, \
+	.funcname = { \
+		.pattern = rx, \
+		.cflags = REG_EXTENDED | REG_ICASE, \
+	}, \
+	.word_regex = wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
+}
 
 /*
  * Built-in drivers for various languages, sorted by their names
@@ -275,17 +287,13 @@ PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 #undef IPATTERN
 
 static struct userdiff_driver driver_true = {
-	"diff=true",
-	NULL,
-	0,
-	{ NULL, 0 }
+	.name = "diff=true",
+	.binary = 0,
 };
 
 static struct userdiff_driver driver_false = {
-	"!diff",
-	NULL,
-	1,
-	{ NULL, 0 }
+	.name = "!diff",
+	.binary = 1,
 };
 
 struct find_by_namelen_data {
-- 
2.35.1.1157.g524e2d5a0db

