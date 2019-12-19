Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C971EC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973A024672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPxFKNPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfLSWVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41037 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSWVl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id bd4so3202890plb.8
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ttleWsc2r7j1vRbYriqwoN83seuUddyDy7i7ATQAyS8=;
        b=vPxFKNPJsIBPS1yAt0E0zlO4Pb1aSPSG93XW2pPUWdXSBaqYz86hhPWpj1y0INSn2B
         AqyAtcwiFGMJ3OrrrHUJ1RwsBvPqvTcotafphWVnQ8JWaHdCZYvl5RpRCbfxFUHTk8cx
         Usy3uVXOJPW6x+ktD5/QlPLOO1Ltd+Q+VRJz6Q2y170tgcKYTqDAAIg/Iz4kKQffl5uv
         Zgn8pfhSCkbXq54yYA1xoG4ShPolV5afd5o4oOcNMFxfE1dP0ghvEb0gPCvMmpE79a/q
         XR48kiTlB+Be3UvAhrkcfPROTGzFHa1VIyPMHiEUFbZfW4tIhRvACdKR+pEeONuFv/z6
         6sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ttleWsc2r7j1vRbYriqwoN83seuUddyDy7i7ATQAyS8=;
        b=ZmXQL/rLJKPLXdOHG7b3pdufJ/pPcUpi0lB42z1UVdRo5MSJYYLEu+PQBDKpMmQKh7
         wUgJLvo/DY2mueyzsA/t9FLDXCePoFDrS1vj1HSrpqYfRrDjRwjUnXUCzjxdJZA+M0r7
         oqnWVFvlYBdjBtnMMzs1nY6k7Td8KmG6GiZ00QkPdG11tcKPO5/jWXEtmHVmTAx15LRd
         wWt0KuRenmlTfIUAumQOBg26DPgUnJpS/vO8JGPhZ4eN5bNXmNNb+SK2z2VIPr1wfHCn
         cQKzLDbgNHnDcO+LJyo116M4/zw9RLw5qB1dfcpgDZftPQ599UmfZqsTm/LcbgAnmx8B
         niQQ==
X-Gm-Message-State: APjAAAXBPmVs/3UCEiLCEjSlgPXpmLEFDiEefP/+vC9PC6bRAPL6BpE5
        K6TU39lKfwQyqkNLS1zpsxwQBeDR
X-Google-Smtp-Source: APXvYqxychOTGXy+8fj4TgeRVKr+FSUqXDxZsTnwZCAyqKuCKwZGZxJFjATxKCWnjzYIhvZLMPKOuA==
X-Received: by 2002:a17:902:be10:: with SMTP id r16mr11699789pls.169.1576794100603;
        Thu, 19 Dec 2019 14:21:40 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:40 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/16] t0003: don't use `test_must_fail attr_check`
Date:   Thu, 19 Dec 2019 14:22:41 -0800
Message-Id: <219011f983e759338d41b661f480b1880bdec6ff.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an effort to remove test_must_fail for all invocations not related to
git or test-tool, replace invocations of `test_must_fail attr_check`
with a plain attr_check call with the $expect argument set to the
actual value output by git.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0003-attributes.sh | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index c30c736d3f..b660593c20 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -24,7 +24,7 @@ attr_check_quote () {
 
 test_expect_success 'open-quoted pathname' '
 	echo "\"a test=a" >.gitattributes &&
-	test_must_fail attr_check a a
+	attr_check a unspecified
 '
 
 
@@ -109,20 +109,20 @@ test_expect_success 'attribute test' '
 
 test_expect_success 'attribute matching is case sensitive when core.ignorecase=0' '
 
-	test_must_fail attr_check F f "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/F f "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/c/F f "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/G a/g "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/B/g a/b/g "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/b/G a/b/g "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/b/H a/b/h "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/b/D/g "a/b/d/*" "-c core.ignorecase=0" &&
-	test_must_fail attr_check oNoFf unset "-c core.ignorecase=0" &&
-	test_must_fail attr_check oFfOn set "-c core.ignorecase=0" &&
+	attr_check F unspecified "-c core.ignorecase=0" &&
+	attr_check a/F unspecified "-c core.ignorecase=0" &&
+	attr_check a/c/F unspecified "-c core.ignorecase=0" &&
+	attr_check a/G unspecified "-c core.ignorecase=0" &&
+	attr_check a/B/g a/g "-c core.ignorecase=0" &&
+	attr_check a/b/G unspecified "-c core.ignorecase=0" &&
+	attr_check a/b/H unspecified "-c core.ignorecase=0" &&
+	attr_check a/b/D/g a/g "-c core.ignorecase=0" &&
+	attr_check oNoFf unspecified "-c core.ignorecase=0" &&
+	attr_check oFfOn unspecified "-c core.ignorecase=0" &&
 	attr_check NO unspecified "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/b/D/NO "a/b/d/*" "-c core.ignorecase=0" &&
+	attr_check a/b/D/NO unspecified "-c core.ignorecase=0" &&
 	attr_check a/b/d/YES a/b/d/* "-c core.ignorecase=0" &&
-	test_must_fail attr_check a/E/f "A/e/F" "-c core.ignorecase=0"
+	attr_check a/E/f f "-c core.ignorecase=0"
 
 '
 
@@ -146,8 +146,8 @@ test_expect_success 'attribute matching is case insensitive when core.ignorecase
 '
 
 test_expect_success CASE_INSENSITIVE_FS 'additional case insensitivity tests' '
-	test_must_fail attr_check a/B/D/g "a/b/d/*" "-c core.ignorecase=0" &&
-	test_must_fail attr_check A/B/D/NO "a/b/d/*" "-c core.ignorecase=0" &&
+	attr_check a/B/D/g a/g "-c core.ignorecase=0" &&
+	attr_check A/B/D/NO unspecified "-c core.ignorecase=0" &&
 	attr_check A/b/h a/b/h "-c core.ignorecase=1" &&
 	attr_check a/B/D/g "a/b/d/*" "-c core.ignorecase=1" &&
 	attr_check A/B/D/NO "a/b/d/*" "-c core.ignorecase=1"
-- 
2.24.1.703.g2f499f1283

