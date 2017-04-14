Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B41D209FB
	for <e@80x24.org>; Fri, 14 Apr 2017 16:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbdDNQ7T (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:59:19 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35910 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbdDNQ7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:59:13 -0400
Received: by mail-pf0-f174.google.com with SMTP id 194so3444554pfv.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GByRXP7CBhvXT9I59jWtqNNr04lfykAx+Us0S0Xtm3U=;
        b=bLq9wCrckuJXRn7f+tQXktuYe2mIfTlsXbdX6Ic2hq/heV13OA2N6KZtXDVUQVqr2X
         +uWWWgHNBM+LOBMDzm8Q+ZEHoZnaTUxrVMPAKFGeX6qrZ/lafMW6V3mzbVKowafre6SO
         DDngkk+XIILwWHVG+7VWuLCnABorZLbtGORPoMXR9L1MwaBOaWi+NR1GB+KhmRfCFgIm
         7swKy2J4C36Zwsy7nMIJOu8/T/RFRPOPLIUtS1iO7azZsR5BBrJ6YqDr1MUd40TllTx/
         rrL+o+d0r0FeLp26yGihvlo1Mp8LvdmCGmRCTjkxFdfzFXYtt5mt6ZUPfQYsElHE6hmY
         aW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GByRXP7CBhvXT9I59jWtqNNr04lfykAx+Us0S0Xtm3U=;
        b=GE+B76mp6Hz3afieo2S0WIsmMXN3KR29uBi4j+v2vpwTl16NcmxgcDfZqTXNS45YAk
         17VwmRF6N6eP6RtSlkhzZkNqij79jm3/hHG/Oyohy2OPeW9z4eopxg/aSxSkIHig5rBh
         BzvuXMBM2WAhB0awSyc8XxG3qHCOt4Z+FR7n09z6gm4444v+pb9IQgsvVhM+CbRoUKNN
         0D8Ue0G+QdSQzigOy9Aj6YhRfWZ/zZuaklhRhagPQCjznsYu7lgJO+8klOt9XiSIiiUB
         JOjoqQsLBJWLCdRI3jTkOo9HF06b+ysOvs7JZiCe4y0pw7myHHzZiP+JuHh5gnaM/pj6
         IYtQ==
X-Gm-Message-State: AN3rC/5jzeM2YMGk77NDi8G0CdLsUI4oXD6BEClrIy33e8RIf4GfJo5G
        Nj9jLtjMd/X5NxoF
X-Received: by 10.99.114.16 with SMTP id n16mr8063964pgc.230.1492189152657;
        Fri, 14 Apr 2017 09:59:12 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm4276591pgj.23.2017.04.14.09.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Apr 2017 09:59:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v3 02/10] t0061: run_command executes scripts without a #! line
Date:   Fri, 14 Apr 2017 09:58:54 -0700
Message-Id: <20170414165902.174167-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170414165902.174167-1-bmwill@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to 't0061-run-command.sh' to ensure that run_command can
continue to execute scripts which don't include a '#!' line.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/t0061-run-command.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 12228b4aa..1a7490e29 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -26,6 +26,17 @@ test_expect_success 'run_command can run a command' '
 	test_cmp empty err
 '
 
+test_expect_success 'run_command can run a script without a #! line' '
+	cat >hello <<-\EOF &&
+	cat hello-script
+	EOF
+	chmod +x hello &&
+	test-run-command run-command ./hello >actual 2>err &&
+
+	test_cmp hello-script actual &&
+	test_cmp empty err
+'
+
 test_expect_success POSIXPERM 'run_command reports EACCES' '
 	cat hello-script >hello.sh &&
 	chmod -x hello.sh &&
-- 
2.12.2.762.g0e3151a226-goog

