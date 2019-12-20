Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB33C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78A02082E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7KqUCMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLTSOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45176 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfLTSOj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so5303845pgk.12
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ttleWsc2r7j1vRbYriqwoN83seuUddyDy7i7ATQAyS8=;
        b=P7KqUCMtpYJ+0/q/EFkO9LxnyFjXblxyOf/2A/HrXJvHwnq9VSX02TFg99PHhDgkEF
         /CO/y11V/I1Q5m/D9L0/mm5rBTSU1p2pCtXiEzUM9qI8t39lcveIcz2+P4sttC/3mIJM
         cvPTKHrlR+gwCYPEz+xG6Je2I/6T9o/qMn5bO2sKKRfR6KtUalzGZxK6v+/cQREaNJfe
         MAZCbVgE+8xQtKCtVL6hrBd07caBaiZNhmFem/XAaEzkSEMvkcofrQP7aYbOOm4WL+Rq
         GvofQuDG2+X1GsX4dR9jBFOL4x91sO9u7NJwCDyHoUbE0cDWQzwkprQxNWRn7HLqB3DJ
         1bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ttleWsc2r7j1vRbYriqwoN83seuUddyDy7i7ATQAyS8=;
        b=C266zf2QlKpBTYJ2QTVWKxQV+Gy/aTo9O6Re+mWuLJW7zIfSDCSHlaqspZkzU0+bah
         9VZOCi24Sf8yYieLf1KXPU7wBAXFNKp/0MPIPrlO5nKbBHFP+xv7ux276lm4NPDjOL8k
         ucGEplx+hPgz2W1qdpYfCWY21A8EAmz/cHp8+rIIIPraJWXz17k1DEDeqlqnkwEgxhlJ
         ZMuZA7G4q4xYSagrFTbJCOhRnJjAtQdWAD7Mi+d0g/GtN8krjXajh11/89P+IosC3XSZ
         2fYShirjCN55Zh7rt8kcnlqO2lcDEWtHwVxkn2WeRuc/oI8wFASyWoBuMquG7b3s7fDb
         H1YA==
X-Gm-Message-State: APjAAAULUKLVmAEQYp6ZhQsY/8+VTebMlTacau6J0QGUDxMjKmyNT1Rk
        x5cLObgA/rUUYVetZXLjqueVV3O3
X-Google-Smtp-Source: APXvYqx3uymzA/M3Eu4KWdrhSRMFIae3igi2xmK4liTQgHjOnqKbuI06TA5ZwCRA499VPYgHucwcTw==
X-Received: by 2002:a63:c20c:: with SMTP id b12mr15882186pgd.407.1576865678355;
        Fri, 20 Dec 2019 10:14:38 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:37 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/15] t0003: don't use `test_must_fail attr_check`
Date:   Fri, 20 Dec 2019 10:15:52 -0800
Message-Id: <b725d53dbec9cfce5954eb00c8728fe0c1f2e3f9.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
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

