Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33727C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CE060FEE
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhETVsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhETVsm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:48:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2480C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q7so25298437lfr.6
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhQE+4C3s4dZyEuryZBTEMAFU+w/YgzcSN8Qkvty+LQ=;
        b=sMcR2NdELSpXUqduQBnS99H/ajuRU5TqQirD7zCeznIYl/oUCTTtxizgimDauX15LD
         //Mhj5yM1q4uY+Q8vkkgyJdzDlhwLdT+O9hQvjnl39CEHD9Pep3SzuVsdeZsKUYiDOlD
         58LdBie4RuLJUAFDNrlmpqoS2JVKV0WyAxOM1DmiTW5uDYvTylxNHWdgh6Q2gmThSYeI
         /IrUOIBmJ5iWqqJWqkZFuuOyYq2rFIuu+iw+t8GS5n7e11ROL9BhTq7giZfEiChmZNmG
         fPi+L9ILz7W196bY6VppHapGZ05D0L7UUmb6xgGxOQUiCYqNaQ5U/aL0CAWLMYBZL0fI
         SBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhQE+4C3s4dZyEuryZBTEMAFU+w/YgzcSN8Qkvty+LQ=;
        b=PqjoVUH42y3ipKWbE8jplag0qkSME6CR8VB+IuhCKebRFRUI8tZ49MAbr1EZ5IMHhf
         jK0fOg1/Chd5M7qic8j86Z/GNGF4eowuribeh9UBo/VvLthGLTYqkWeTObGa7v32BRBk
         u92+bZSTKVHDDcmPLv7dRTg1Jc7GOL9srvVeRP/HDs2haWUX/8mYZ4gXq7joZwl824Cb
         MldEnZ2sMBD+FGQZf8viJ37HMnjqSUpcATVRTzAnDlnAQz3mFQRYt/3eGPYv4gGuK++b
         wZt7Vv4YGrX8yFoVNh4Db7t3rQbfWogIyxT+CR/K5dTj1AnoqaDHAnG0rngkHxlta0V2
         +fiQ==
X-Gm-Message-State: AOAM530MxkYMmGMv77qmHI1a3z3rEm14zl2W2+iuc0sm7pCQIddLBp4q
        Q9OTgkTNSqE/j1XLZ+9E1to=
X-Google-Smtp-Source: ABdhPJzwzCNxeZs0Tx54nfY1M/iw93AgkLZpx8deAJTZJVOtsBF7M9qAKwWwxzSJb3Ht8kSZUvy3sw==
X-Received: by 2002:a05:6512:b26:: with SMTP id w38mr4646816lfu.152.1621547238320;
        Thu, 20 May 2021 14:47:18 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p2sm408414lfh.31.2021.05.20.14.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:47:17 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 02/10] t4013: test "git log -m --raw"
Date:   Fri, 21 May 2021 00:46:55 +0300
Message-Id: <20210520214703.27323-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520214703.27323-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is to ensure we won't break different diff formats when we start
to imply "-p" by "-m".

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh          |  1 +
 t/t4013/diff.log_-m_--raw_master | 61 ++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 t/t4013/diff.log_-m_--raw_master

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index e9f67cd24351..1809355f9bb1 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -337,6 +337,7 @@ log -m -p --first-parent master
 log -m -p master
 log --cc -m -p master
 log -c -m -p master
+log -m --raw master
 log -SF master
 log -S F master
 log -SF -p master
diff --git a/t/t4013/diff.log_-m_--raw_master b/t/t4013/diff.log_-m_--raw_master
new file mode 100644
index 000000000000..cd2ecc462832
--- /dev/null
+++ b/t/t4013/diff.log_-m_--raw_master
@@ -0,0 +1,61 @@
+$ git log -m --raw master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+:100644 100644 cead32e... 992913c... M	dir/sub
+:100644 100644 b414108... 10a8a9f... M	file0
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+:100644 100644 7289e35... 992913c... M	dir/sub
+:100644 100644 f4615da... 10a8a9f... M	file0
+:000000 100644 0000000... b1e6722... A	file1
+:100644 000000 01e79c3... 0000000... D	file2
+:100644 000000 7289e35... 0000000... D	file3
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+:100644 100644 35d242b... 7289e35... M	dir/sub
+:100644 100644 01e79c3... f4615da... M	file0
+:000000 100644 0000000... 7289e35... A	file3
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+:100644 100644 8422d40... cead32e... M	dir/sub
+:000000 100644 0000000... b1e6722... A	file1
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+:100644 100644 35d242b... 8422d40... M	dir/sub
+:100644 100644 01e79c3... b414108... M	file0
+:100644 000000 01e79c3... 0000000... D	file2
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
-- 
2.25.1

