Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D77DC43470
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2378961184
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbhEQQos (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbhEQQoo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:44:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884FC026CFB
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r5so9567888lfr.5
        for <git@vger.kernel.org>; Mon, 17 May 2021 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvGN4I9Mq2UfuOMTLnmwVYNfl7ipfkTomAHZoFPm8cE=;
        b=lkZfZ4GYsUp+lT5f3GuRPT1QUKkJ2RfSEaBQacUgWrcKXltUs8PZ6fMTH9ESQ6tMGC
         GGxxs66eIMGl5yhwCbW0aqXOAUCEhcVzputwjZm7hRk9eNzBLVt4QDlaOaiqFdCZRt+G
         LlcP25yzMiUItJSCCxjnEX6Q35wO9Mb5jtXZMelqrwXkdaBBPzlcX9r0rFH1o3bWO+Pu
         fu2/ASyMWUouk9GRqtb2IWUiHuAh6nb9+9wNtUmBo9qGUduWp3PXc7gwkCKx30VzDVpq
         PrXJ0+l1kewkiRxqcN1CdGxI1dW9QdtlmnsP8K18BEx7++vmEs+TQChz/l2weB1vH/Ph
         Wk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvGN4I9Mq2UfuOMTLnmwVYNfl7ipfkTomAHZoFPm8cE=;
        b=eSRGdLLSBnWO5kJSFK5crt8M+k67LdvG7DKhYq//nViFS54I76n7mQKtWa0Pd131hx
         GgGr6jWySK0eJ0oPhJMFunjeUSHWzJFInWB31F4sYr18amvS6t2HorUfWxBN0NvCWpEx
         0HMNpi815UZSiDqabQBgkKZhaFfUzKh+kc/wDV/vNzDN16RpCDv8NXh/ZpHDrPAsqefh
         +7dfZzuEK6DQU1nChYacwm5NbHOFImUNtWOZ08pTwBfUhM7Yvy8Ea8r4QYplvEMmLgcp
         IIbNqDffNQRSawJI2fjo47K25wWOQjlqgdZpyH6XXyVvtuPhCaqRVQ2Z/mskYnIKvzbS
         nDUw==
X-Gm-Message-State: AOAM532faxZf15Wr3M74JRXyZL224hBvaahaAqJ6KgnbP54ayjH2ncTw
        Xq9+VhZvX8TqX5dE2imn9bM=
X-Google-Smtp-Source: ABdhPJwKv1jgXiasWm5hpd7sB/UUJvLbhDYPvrSMWafnjGfnrUMjuzaG1eRO8ywIW3zpZ9QZZCG3jA==
X-Received: by 2002:a05:6512:acf:: with SMTP id n15mr379970lfu.518.1621267120910;
        Mon, 17 May 2021 08:58:40 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i8sm1996834lfd.12.2021.05.17.08.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:58:40 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 3/9] t4013: test "git -m --stat"
Date:   Mon, 17 May 2021 18:58:12 +0300
Message-Id: <20210517155818.32224-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517155818.32224-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210517155818.32224-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is to ensure we won't break different diff formats when we start
to imply "-p" by "-m".

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh           |  1 +
 t/t4013/diff.log_-m_--stat_master | 66 +++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 t/t4013/diff.log_-m_--stat_master

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 1809355f9bb1..e53ca7aa503f 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -338,6 +338,7 @@ log -m -p master
 log --cc -m -p master
 log -c -m -p master
 log -m --raw master
+log -m --stat master
 log -SF master
 log -S F master
 log -SF -p master
diff --git a/t/t4013/diff.log_-m_--stat_master b/t/t4013/diff.log_-m_--stat_master
new file mode 100644
index 000000000000..c7db084fd905
--- /dev/null
+++ b/t/t4013/diff.log_-m_--stat_master
@@ -0,0 +1,66 @@
+$ git log -m --stat master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+ dir/sub | 2 ++
+ file0   | 3 +++
+ 2 files changed, 5 insertions(+)
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+ dir/sub | 4 ++++
+ file0   | 3 +++
+ file1   | 3 +++
+ file2   | 3 ---
+ file3   | 4 ----
+ 5 files changed, 10 insertions(+), 7 deletions(-)
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file3   | 4 ++++
+ 3 files changed, 9 insertions(+)
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+ dir/sub | 2 ++
+ file1   | 3 +++
+ 2 files changed, 5 insertions(+)
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+ dir/sub | 2 ++
+ file0   | 3 +++
+ file2   | 3 ---
+ 3 files changed, 5 insertions(+), 3 deletions(-)
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
-- 
2.25.1

