Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76547207BF
	for <e@80x24.org>; Wed, 19 Apr 2017 23:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940292AbdDSXNp (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 19:13:45 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33845 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940288AbdDSXNm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 19:13:42 -0400
Received: by mail-io0-f169.google.com with SMTP id a103so42685096ioj.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 16:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BiLIm1u/rwzcVEVjyff6Do09v7dfkcHd4jKEdGBHdD4=;
        b=mkcBEes8brGYNqUr9s/73nB0WwSMJ7AiaXwjZUoys1+X1lK2q4em5FRiZ/OZmxb5LQ
         C5qUrtcddodOXaEqVq+1hydXMhgItvSkbtHYXPC+nXwHO+tSnD1cZ7c2XgGuwJfZJGmL
         Ec/DPbpNusVMI8BF2By/LCcWoO33DhLwckAzXjKInCGZY4ydBdjHnTX3pv2AvkPkZnUw
         DMNcRPqCjvo4yCOWU+Hx+l2fWtuz3nFhl29nB/wzYTRxyn40EkT3QeL5TYlycnCOlBRz
         tPUiqWxjdpdkw/Z/8igXGVLtwGLocNVlmhyNW0SOWe+O+uEO7Zpf3DccuAa4WPnBaPPV
         Ossw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BiLIm1u/rwzcVEVjyff6Do09v7dfkcHd4jKEdGBHdD4=;
        b=gB5L2WoiyfQoF6qQn4puCrWu4RC7MlpuB/ck4SqLyfKpqukEuDqHz1En0AXD8+dUIp
         qDrx9qFVUuQJ5ySNHi7ZkA/XVN6lhESxmHPchqdsSqWWIXMClZB+QTQWOANlQkl333lu
         up5GaB5Eaubfsp6MWgY81KDLZyUsNuiFgjVFOnkNZ7Q6tf/k9Ev+8xkFw9GiKq1FmZJG
         PiP2hTZwe/rtAh/Qq/xXnIOcSEbuNeUW3EbugJS3xAD7hwGlycidwVLbjDDlcbNaKEn9
         skW/j/Y1z4Xt6y2JA7LV2EIzAqaMXFAecmwaaPrH61Q68uAbpW2ZprUwVqR15xbm4mhg
         Y1nw==
X-Gm-Message-State: AN3rC/6GtD6aTUEwupgzdGOV1EHFrUNxwqvDYFnFCitY4dOHLSS8v26p
        hi4OVGM3TYL7THa3
X-Received: by 10.99.119.4 with SMTP id s4mr5200605pgc.71.1492643617885;
        Wed, 19 Apr 2017 16:13:37 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s10sm6433798pfe.28.2017.04.19.16.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 16:13:36 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: [PATCH v6 02/11] t0061: run_command executes scripts without a #! line
Date:   Wed, 19 Apr 2017 16:13:18 -0700
Message-Id: <20170419231327.49895-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170419231327.49895-1-bmwill@google.com>
References: <20170418231805.61835-1-bmwill@google.com>
 <20170419231327.49895-1-bmwill@google.com>
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
index 12228b4aa..98c09dd98 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -26,6 +26,17 @@ test_expect_success 'run_command can run a command' '
 	test_cmp empty err
 '
 
+test_expect_success !MINGW 'run_command can run a script without a #! line' '
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
2.12.2.816.g2cccc81164-goog

