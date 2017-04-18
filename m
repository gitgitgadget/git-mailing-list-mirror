Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815EA207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757950AbdDRXSW (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:22 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34961 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757455AbdDRXSO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:14 -0400
Received: by mail-pg0-f46.google.com with SMTP id 72so3581529pge.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z8ky8XY2wO7uic6xFRiTyPdU01JeK27Y5xgdKJWURJo=;
        b=Hj6wWnbeeoMeijfVIj9gdhcZ3FH8UTWMoKWiQVK4zwAZsQ3GcoJdo+c8ZGAFKL+uNt
         1mSYjsD6rxrlkxd2pSY0GY/J0PYq8qInUb0IlSGCQ+g3arqgkPfIezLdLZUwXa3OYqK9
         DrVGdQo4VTV3Koalg8z42gPe1mJuGBx6zzKWAwCc8F2Lbep+say2AjNeKHb4Ysb2glci
         7ndFlBYIkdCC3Xc5PT/7GvFCtXrjpM5BvwoHZeRHWoiVJiGAdNkSlrRVI1S03R7fJG53
         PygVZMOKjpyvEO98CuwwIZ2FARy1UT/z8tht3o8YrS8pEtWakd0fBoM67L70F897Hv4h
         e1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z8ky8XY2wO7uic6xFRiTyPdU01JeK27Y5xgdKJWURJo=;
        b=qHQhZugTxr6RLSJDO7liPOvEtV9b1Ikp0DQsGw9XFG+kq1V1sAhYSH1wXbvWNYPGcR
         aNxchXlVUNt0idRUfn/00+iwm6DmitLmTQOEsdKHRFsxIe5iHFPGrt2W8dr3ZuiV0L4N
         B5eDeTobwt4MjMde5pradeBrsfDTf2zeaHIaeEfrjabm+TF07nrdUI7vf1rG4tpS3wf/
         Rw1PrzOmcW3s1LYzeboOV+m0uULY2k5M+8DNxG6ZhkWGyQ95ndWpGbQDpplRaPbC/ZI3
         w6Yaj4agv6FcVLxiaXnXMT/xAEb1i6fE74ycUIH44zikDw9WhBjRV+SbHH14hTLvLEly
         pfxQ==
X-Gm-Message-State: AN3rC/7MDph3V6dP5Pi8swtHO7ThVE7qLJ75OOXYmD84oirVUBzyfers
        VEzMRMqJWXHKAIuq
X-Received: by 10.84.222.8 with SMTP id w8mr26446821pls.103.1492557493937;
        Tue, 18 Apr 2017 16:18:13 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:12 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, e@80x24.org,
        jrnieder@gmail.com
Subject: [PATCH v5 02/11] t0061: run_command executes scripts without a #! line
Date:   Tue, 18 Apr 2017 16:17:56 -0700
Message-Id: <20170418231805.61835-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
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
2.12.2.816.g2cccc81164-goog

