Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B9B1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbdGYVkq (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:40:46 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33656 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdGYVjm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:42 -0400
Received: by mail-pg0-f41.google.com with SMTP id g14so26442955pgu.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UT781v3ql14wdZVHERNlCDknzbUPznzQ4jyM27niSME=;
        b=nhd9bj432oiXB/S6Vsu3XRfZVHuEzsY6mCibB7UgVak7DYYBlumr6o8fD8xfKEMkxi
         6cPd39Ju+p2UVs6L3f76rOdaXyESP6DG8JLMzx8mzg4poeDggPq+OUyTF4NycvhH3Lxp
         T667Pl+zGck+5h6A3JVb+wgYw2KwcztgfxgekCnDqq4aoNIJLK/MxJmmkV1gjLHbqxUt
         49x+R/sJKX78g9LOnlB03NPiu7C/fzlCAEf/PufExrCd0gcYseyRFyzyRN4UaM4LHOVC
         iT0aJPO6N/2BsB1W0MHxTH+dwzdtycymdpEmt1ltlciutMxG+pAxCSRat51NhvT9t6Yr
         PcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UT781v3ql14wdZVHERNlCDknzbUPznzQ4jyM27niSME=;
        b=j6o14al1Hh4I040rIkJMvojWzNzbOOYWM/2w0O56InxqpvMK5FIUre9Qi5dPI4dVzu
         6MVx+z4vgjAgpTVAbfEMZf9wvuv27jw9zrShNhflAXLx0w89bBU4er7qXEGogGQ54Jqd
         S2aJ6z2OuqOPCn+VbYmpss9BEMeZL24mUDnBUgsZ5DfbDLFi1eh3uxN3zdfbkCbIz1RQ
         g7cp/rB7/2iQx9pmErnWIuf+puirBmrae0TCfz+1ucuP7Ra/AZU1xu8aFTb6L4/Iedha
         TlbNYG1U1B0iTTerJqFlogFNxovflhoHCDvf2yZIAYnFdv9LYH5K6JpDtIoMPHqLlORo
         j1Fg==
X-Gm-Message-State: AIVw111zNM69LTdHX3R5nWIiZJ7AB22oIA1zeletr1orvJNvx9W4Rzpc
        qaM6AgkwtMIt3v652DVaBg==
X-Received: by 10.84.217.145 with SMTP id p17mr22782599pli.13.1501018781753;
        Tue, 25 Jul 2017 14:39:41 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:40 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 01/15] t7411: check configuration parsing errors
Date:   Tue, 25 Jul 2017 14:39:14 -0700
Message-Id: <20170725213928.125998-2-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
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
2.14.0.rc0.400.g1c36432dff-goog

