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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD94C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E9A61004
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348926AbhESLt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346288AbhESLt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:49:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B424BC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h4so18675922lfv.0
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhQE+4C3s4dZyEuryZBTEMAFU+w/YgzcSN8Qkvty+LQ=;
        b=igCuTNhSbqHpBVP1sxw6ySd6OcZxsee38ZOOmRtZ2m7fSJ856AOtfvwRAC3WimPck0
         8c5F+drRLiF4n+M/WO8nz73ZMgADPe4Ej05+p3pivTxFPZ1mJGEc9QA4V0sdBGpG/a/e
         TmWoMhQkzLtAfrg2yBasdz/ZG0fNWILrpPCNizixoSqwQZEQaY2qzIGlD1ILI/R1B7Gd
         gaHbS83myuraI1UfFBO0RELQw5jOLCDRnNllv9Ulu3XFOXveS6GEVHeykpMy++Hjr0q0
         cj2BiXIxXuw5ddx/njhaiGCF+gTsBfFb1s4bVzCKnnN+Ener8RJtI+bfV2cQ9/YT3kM5
         kg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhQE+4C3s4dZyEuryZBTEMAFU+w/YgzcSN8Qkvty+LQ=;
        b=qZEzlFL/OJo2kxd6NHfhShOTaEP2kfFoelUtRW74csq5WbVCfTrmZ44HP1qKcFFkf6
         paxrz5wse6B4gsKVX91PxmqjURKNVXTSRq8/+SxwYIlWcYYQkaDKWrn+r2Y3iFuqetza
         uYWuBG1gr/RoBdaFlP4pHX6E35inofK/7ZAuFcQHYWyt9S4gynDS2g8EHWaLjbBK5u07
         IrJuW7WYViE/JyYpj7qwXX0ELJmtXuMJFTZhz7sC7UuP3NutsR155yoQrnK0WMWkNowf
         bDuRH+4nGJ0Lz0xrnvUDlMEoW0qUqE4ww3QISyG4B3md57g8FMvrWgswYWzabYSKXUWA
         t0FQ==
X-Gm-Message-State: AOAM531lb4xiSfSIaA04sjs3fIojEX64pAX+GjiO7cw8K32SYDIFurUY
        l+4ByS8bbzK5it7YO50Gixw=
X-Google-Smtp-Source: ABdhPJzsWqi/Vr1J8WGlfSfi6x6FDLK2Vm+PURw9jRD/rQLq9Cz1BgIyVkZYAQgUvlmwPTJxZ6jjQA==
X-Received: by 2002:a05:6512:c21:: with SMTP id z33mr5871422lfu.539.1621424915111;
        Wed, 19 May 2021 04:48:35 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o2sm1846470ljp.60.2021.05.19.04.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:48:34 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 2/9] t4013: test "git log -m --raw"
Date:   Wed, 19 May 2021 14:45:45 +0300
Message-Id: <20210519114552.4180-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519114552.4180-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210519114552.4180-1-sorganov@gmail.com>
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

