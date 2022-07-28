Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941B7C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 23:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiG1XCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiG1XCg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 19:02:36 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D4683D4
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:35 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y10-20020a056a00180a00b0052b10093100so1180592pfa.4
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=jlTnupl35I9fmuYEA7tGsHTPwOQI5Bgd8GE8asFb/sI=;
        b=RWvxtadryD31u+L/j5p+yXmqHUvOIbtsVqpXYGK2RgqIiqP5Kp6vUYiawxfy1KL4/V
         XdzPh5xar+drgFesGCERKxhNfGnBfYSZ1/nMh0OXDYMMBqMrhJkZ+CniBFIS/vCHByIm
         dlgcagdKLEwmKK22bB/M4ZH5Rp+uyAQDinPhfZz1x3HXUMnvwPKzt1s7OvkaaYzdBW+4
         lICxfwF6yqytFqurT9/4hOSZzTX3v3KRJt6Urwwa7eSTLzEBNYy/OOTeLD9MASshTqjt
         Z5Pxhc1tQ2pqMMyhfwerek5tz/qS7wUAnGLMfU+mUDSeSUyUYBatC1JSfBXCP6C4urf2
         Zn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=jlTnupl35I9fmuYEA7tGsHTPwOQI5Bgd8GE8asFb/sI=;
        b=Dg4FhTMpKabdBlk/dU3QzdaQEqnlUkMX1I82ce/iT+qOLXPacYWGuwmX7c8nv7QV/k
         DFGnVlDa5GqD92NwKGFxJMQUHL9F1s1RvftoZJ/Qf1sr9brPYlVyx7Nqsi6v89xpbEGD
         ZiZP8YpLIpPTxZr+sjAPJBlkhmbixSV5mXLxCi8uUDvi7aCLIwSGhOxIfhF0g4W3RSL2
         we8HdqJ7+TXxN+qAhmuaQQ1ay97O9dj00JzCgMZDAdqVLxpnZJgtFVvw0KLBgMzIY8RL
         zdN6VFxUlmHPhOq56BQe700iQ9XGHMtf4Rw9hbo7A6vCiQFEfkUcjhgAs4bybAexIC4o
         ZJEQ==
X-Gm-Message-State: AJIora8e8eoKZTT7wExBPDvkaKSzcuz41f+tbMSTWRk1PMr7cNRw8E52
        kCFYLd4V1Yd/4GTaJ7pYDbQJwhIHTljXZ4GG866CrCK8iMEo6HGTCOEKfAyjxmpruG6WaYisq2B
        oQaA4jfeJ+K3mqCYf68bk/BR8bv/eu7UukJRrBSd7dqmp8luuqTYepOLZja5nXm+qjw==
X-Google-Smtp-Source: AGRyM1sJt1sZkfQPAKD+l2DCMJiE5BT8IUmXHt5hrNCt3d4eIy+S+rEaeVWxjGnlDlOJPP+XgHbeOeubujarCoM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:1c53:b0:528:cdf9:99fb with SMTP
 id s19-20020a056a001c5300b00528cdf999fbmr743661pfw.30.1659049354874; Thu, 28
 Jul 2022 16:02:34 -0700 (PDT)
Date:   Thu, 28 Jul 2022 23:02:08 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220728230210.2952731-5-calvinwan@google.com>
Mime-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v5 4/6] serve: advertise object-info feature
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This will allow a
client to decide whether to query the server for object-info or fetch as
a fallback.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
---
 serve.c                      | 10 +++++++++-
 t/t5555-http-smart-common.sh |  2 +-
 t/t5701-git-serve.sh         |  2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/serve.c b/serve.c
index 733347f602..1adf9df4a8 100644
--- a/serve.c
+++ b/serve.c
@@ -56,6 +56,14 @@ static int session_id_advertise(struct repository *r, struct strbuf *value)
 	return 1;
 }
 
+static int object_info_advertise(struct repository *r,
+				   struct strbuf *value)
+{
+	if (value)
+		strbuf_addstr(value, "size");
+	return 1;
+}
+
 static void session_id_receive(struct repository *r,
 			       const char *client_sid)
 {
@@ -132,7 +140,7 @@ static struct protocol_capability capabilities[] = {
 	},
 	{
 		.name = "object-info",
-		.advertise = always_advertise,
+		.advertise = object_info_advertise,
 		.command = cap_object_info,
 	},
 };
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index b1cfe8b7db..5a16d4259a 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -131,7 +131,7 @@ test_expect_success 'git upload-pack --advertise-refs: v2' '
 	fetch=shallow wait-for-done
 	server-option
 	object-format=$(test_oid algo)
-	object-info
+	object-info=size
 	0000
 	EOF
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 1896f671cb..ebb32644e3 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -20,7 +20,7 @@ test_expect_success 'test capability advertisement' '
 	fetch=shallow wait-for-done
 	server-option
 	object-format=$(test_oid algo)
-	object-info
+	object-info=size
 	0000
 	EOF
 
-- 
2.37.1.455.g008518b4e5-goog

