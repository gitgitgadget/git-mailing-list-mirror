Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C312C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F92C64EDD
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhBXT6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbhBXTyN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:54:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6BFC061A29
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c7so3040670wru.8
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6p1RT5Ao+Of/2Rv/23jaShVDQn9w7IowFj2B2kyprs=;
        b=GJ0CjYjm8NmDPnWUX8yxHEojnlwXJpcc1pICQUV7whWZcoo3KRFuegcaJa8Y9zAe8p
         MxDAmH6kYUulyBXdavN9jIycTvuzBrh5euU6SU56r29Ft1+ed0AJI/LFwke4/uZcGB7w
         IW+gWuzYj/u2M12CsNxk6xuDSID7OrUZaEs1n7JnzZZtItxPRQ5bzBOUymWKwTy8De7X
         GNIgXhNXLBG9chJFoOhr4RCDaH3yT1eN5qZBNEP4a8ZFWX1CZ4RXspRQMi+w5+I6SMOJ
         SzpzXwQR8LgBO5q/R/gPojxEUmpyisD+oICeYa7WK0vhVPgAKBcvyJnhumoVvbdF94Kj
         QZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6p1RT5Ao+Of/2Rv/23jaShVDQn9w7IowFj2B2kyprs=;
        b=AumFYb+xbPZHwIwVLhealRDILrYiMpeN7zpIFL+JMX0G4Ced1T0QmPefE5nAQe75n1
         oSRnfJhRsJt2oiykxyPYpHqU7lvp25rRtukm1X2OOiPWKvDuQvcqmSnwV3BXAHeH2fwD
         7yXN/PAgKK5tnZoyseOA8Wt/yJgeJI2rBZodOWQNdDQ+QYV0iIab378CKuybYW4AwQ/Y
         FO8hYGj0dapItzxWkxsr+ZN1DIAxBvu3ouykZPnIfXX8+TI3IfPd7RTgg1gTKJf7nQfL
         LFRGluadnOpVApz/Ep/ugIcx8rsk6d4VfdE//kQJPhWmoiH3Mnd2+RTBZpBq49CzH5Tc
         FakA==
X-Gm-Message-State: AOAM532/mJWTBbAJlv+xXRK/SMfN2OojQNj694TBkJGoj2ahQ8hqgI2a
        gjaheqVfU9R7im+I571JYbtO23MrafAEdg==
X-Google-Smtp-Source: ABdhPJySppLI6U1TX8X6M4XulRsScqJ9PD4u7PU2vAbsqMUREKWYMVqOcRn36mHRAbGDm86SZLuhrg==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr32860746wrn.20.1614196340792;
        Wed, 24 Feb 2021 11:52:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 33/35] userdiff golang: match multi-line "const" and "import"
Date:   Wed, 24 Feb 2021 20:51:27 +0100
Message-Id: <20210224195129.4004-34-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add matching rules for the very common pattern of having a multi-line
"import" or "const" declaration near the start of the "package"
line. Before this change we'd skip this and match whatever came before
it, e.g. the "package" line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/golang | 26 ++++++++++++++++++++++++++
 userdiff.c     |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/t/t4018/golang b/t/t4018/golang
index 38f254cd269..7f51fa02203 100644
--- a/t/t4018/golang
+++ b/t/t4018/golang
@@ -47,6 +47,32 @@ package camelCase
 import "fmt"
 // ChangeMe
 
+t4018 description: import (
+t4018 header: import (
+package somePackage
+
+import (
+	"os"
+	ChangeMe
+)
+
+t4018 description: const (
+t4018 header: const (
+package somePackage
+
+const (
+	Foo = 1
+	Bar = ChangeMe
+)
+
+t4018 description: const rule is selective
+t4018 header: package main
+package main
+
+const Foo = "Bar"
+
+// ChangeMe
+
 t4018 description: complex function
 t4018 header: func (t *Test) RIGHT(a Type) (Type, error) {
 type Test struct {
diff --git a/userdiff.c b/userdiff.c
index bbbbfa33e0a..c4a2bfaed70 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -132,6 +132,8 @@ PATTERNS("golang",
 	 "^(package[ \t][a-z][A-Za-z0-9_]+)[ \t]*\n"
 	 /* Functions */
 	 "^(func[ \t].*)\n"
+	 /* const & import */
+	 "^((import|const)[ \t]*\\([ \t]*)\n"
 	 /* Structs and interfaces */
 	 "^(type[ \t].*[ \t](struct|interface)[ \t].*)",
 	 /* -- */
-- 
2.30.0.284.gd98b1dd5eaa7

