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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C6CC43462
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2126135C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhETVso (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhETVso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:48:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF9CC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:20 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id v8so21657475lft.8
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvGN4I9Mq2UfuOMTLnmwVYNfl7ipfkTomAHZoFPm8cE=;
        b=G//gmsNsrtjKqpYbqBlqtodEx5/b2HHPvmMpSdkKTsHbFAPKHienkG6i1wFViN2b8O
         EIqMHyiP0su2/KQlViOcT7AsLpUcB3C5FnOhUVHY2CHUKOHnIKS9RgUykVC+h9+bfsP+
         smVbB625xV2H95Y7kL9Y0Kvr956hoIRYCOOkLziVPGluZHChZ33isVJ6G9vygRYZblhR
         GKidq9eg4wORUoK648FUi0w1VW9nrcWPlZR0VFvBB3/qUSWuU1EtcD8Wn4HZojF9ActR
         nLW61TQy17I0RkX8t5MmSEiY8Nz4kv29y6eR3tTWg0fgqAGeoZy/pICyICMmdCUOUKbH
         7jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvGN4I9Mq2UfuOMTLnmwVYNfl7ipfkTomAHZoFPm8cE=;
        b=PEp94C6bmXgvfqO9bLemDZ+NyPK9uJbF0CooBdLRC6Ms7eynZkPxz0i0FBKdfdEYnw
         nl3G+5vQ7mG+m/ufKbh90z7ue7wyPmwGXOI1Q4Z2JwXYUs+O8IJ55lsnA3tsMF0KZZ0P
         Yhsi8RWKefCypwSixzqerp9s+Xjgv1rni2YZ1W+OWEat8yjJyeTr3aODl2h2m2dbHKZ3
         fHO9HedLGwVMxhk/w0r9ygZ1o71ztYCEJZHcMJXf65qt8/g/Ki5N+EhSB3e7z4f3akKk
         MIZN0d2iUvcnw6HYc6261mzi+VhZO+/RePwL2mHZsUuswhloHYe3XPWv+FJCK45oQwDn
         FDxQ==
X-Gm-Message-State: AOAM53271+2CIAMBS+r55O9SKkuYt6NacToQ4IKjm5v4yJPH3H9kw/U4
        /RrmrxCFk5pBs7kxiAUIyTM=
X-Google-Smtp-Source: ABdhPJyioldWQcQZiDgJMw1oUJ1458jDQ849rPA1RR/uoJU+KFVwGEAHTeFhxTf7ADHYk4IpzPMQTQ==
X-Received: by 2002:ac2:5977:: with SMTP id h23mr4371053lfp.596.1621547239247;
        Thu, 20 May 2021 14:47:19 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p2sm408414lfh.31.2021.05.20.14.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:47:18 -0700 (PDT)
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
Subject: [PATCH v3 03/10] t4013: test "git log -m --stat"
Date:   Fri, 21 May 2021 00:46:56 +0300
Message-Id: <20210520214703.27323-4-sorganov@gmail.com>
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

