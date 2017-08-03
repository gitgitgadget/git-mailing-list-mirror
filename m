Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B70208B4
	for <e@80x24.org>; Thu,  3 Aug 2017 18:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbdHCSVz (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:21:55 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35622 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbdHCSUI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:08 -0400
Received: by mail-pf0-f182.google.com with SMTP id t86so9378560pfe.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6pVmb4LroRpVB94LQnrFr1qcCyLXw6sHizRxe+w5kpo=;
        b=D8ifpDKSNOEpvzpTV9wrRhXBYmPkAuZEDH3Sz7pq8W2yE/7iqVaT0xyoZiqIgcyuDI
         Fhdg/XYQUuGpkuBwa4tTolYTUw+cEaiZOyeEMXvgwCPXtQpWz75REIleX/6lhZ8zo2sB
         YziMSCoBBOZJPCjtCY0mG8RiZ2LA3FPIXYVftaaUWOP2+foSX4RBdbQLiZ1twON5mRnV
         XatAtZplgXtMN5M4XIkPow6z+1aLnk4JsIyr86r8sgWYTYS8B3aiVybcoeOZ3XoQrM1F
         8rlw6GWv2bcc5zgOp/eyiqDdbSX+PP2i6mw7CiGx04L+vby1kS71+bE9aiK4qAjYsblZ
         gjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6pVmb4LroRpVB94LQnrFr1qcCyLXw6sHizRxe+w5kpo=;
        b=jj8NGe+KhaZ5FcYToWw4sT6DSB7G0PQPOV2d1Hn35hrx8bVmoS8mIhMf7VXj/JsP6O
         EKr5SaDMivVKUwUU2iar885mzLWtg6oebE1COOEsPlJjfArgoJ9rjuhdNioT5VDJEVdL
         71UaewNhvGPo9fH8+XViHkNubVElz7FyBraDT2U9GgPcHvT4PDJt8kWeYZRv27Lw06NZ
         JWlHgbUp22JCJ5u4bOJzB0S3m7V1Ana5Cup1syfVKTpCwVh1gD4BIPYEgIEJPNtWTgZo
         EWcpfZ1R9v/I6ikppCM0HunTunaMyRSeD2skWROPYoSfwSsK2yKDhpb8ZqSWGOPkByaT
         m2GQ==
X-Gm-Message-State: AIVw113n91oAsyFZe6ukaSAeRkogqze9ANAJEIt1WuBpjAp/R+C0QA5b
        EwvVGO0lutU8N6/8Qrp/gw==
X-Received: by 10.84.169.227 with SMTP id h90mr2841193plb.145.1501784407478;
        Thu, 03 Aug 2017 11:20:07 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:06 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 01/15] t7411: check configuration parsing errors
Date:   Thu,  3 Aug 2017 11:19:46 -0700
Message-Id: <20170803182000.179328-2-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Check for configuration parsing errors in '.gitmodules' in t7411, which
is explicitly testing the submodule-config subsystem, instead of in
t7400.  Also explicitly use the test helper instead of relying on the
gitmodules file from being read in status.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/t7400-submodule-basic.sh  | 10 ----------
 t/t7411-submodule-config.sh | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index dcac364c5..717447526 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -46,16 +46,6 @@ test_expect_success 'submodule update aborts on missing gitmodules url' '
 	test_must_fail git submodule init
 '
 
-test_expect_success 'configuration parsing' '
-	test_when_finished "rm -f .gitmodules" &&
-	cat >.gitmodules <<-\EOF &&
-	[submodule "s"]
-		path
-		ignore
-	EOF
-	test_must_fail git status
-'
-
 test_expect_success 'setup - repository in init subdirectory' '
 	mkdir init &&
 	(
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index eea36f1db..7d6b25ba2 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -31,6 +31,21 @@ test_expect_success 'submodule config cache setup' '
 	)
 '
 
+test_expect_success 'configuration parsing with error' '
+	test_when_finished "rm -rf repo" &&
+	test_create_repo repo &&
+	cat >repo/.gitmodules <<-\EOF &&
+	[submodule "s"]
+		path
+		ignore
+	EOF
+	(
+		cd repo &&
+		test_must_fail test-submodule-config "" s 2>actual &&
+		test_i18ngrep "bad config" actual
+	)
+'
+
 cat >super/expect <<EOF
 Submodule name: 'a' for path 'a'
 Submodule name: 'a' for path 'b'
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

