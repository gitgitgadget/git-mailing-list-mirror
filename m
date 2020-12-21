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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CDBC433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0A7229C5
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgLUTNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgLUTNA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:13:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AFEC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:12:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q18so12231605wrn.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKn1seWiuDxvDzpbdQ3cyCw4XIrHg3bGLKppLhoSqI0=;
        b=aMYsC4stopwZdB/pgz2rSabzw6+4+MKE8LIVqB/yPjfEdXU/n2BaTJWLpRBoKhwjIC
         Tjn/Xg47UTma24NPG7CZpzPC+kr8WUEA9zONwEIRypnLPZwwGBO69FjfjeT1XinhEBMW
         gor1Ce8Li0TAepzVJwaD0qFLk1odVg6Nbc6lJpI0za18nfEh7v+88a80zMMN5eIfG8zk
         fCX501Lt5UJA4QAFzykiH7c2d+gyBVg3qgcyxoxspaMpQDTmA2t0J3EOJabMCJncKofo
         LGHkghUaZKP3pPChQwjV48iLl4FCmXhNFlpNmm4yTwPqRmHYIIT8ACvmW7LQSdVh1Phr
         raKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKn1seWiuDxvDzpbdQ3cyCw4XIrHg3bGLKppLhoSqI0=;
        b=gldUVHah6I9m4QM8U6Q7YJ/BuSVgz420KOLN7FHKLl2apDAOkKEhrdC4Ah+t8eVVH4
         EM+yrcEPIBXz4fOl9dZJw2ZsLYeR3abQKeK8gSMzHlx0DvdSIhgVLUH1Yk6xwL8wFJHK
         Jr1qAEuZ3lEKdtqg1iOjPuKwP6zwHIC4WCL/PRZLMTl5t2FwnGe+S/xWjH9uNK57pyf3
         odT4M9VVT6LFXHUti4vxllDcLSlRaQWqFA91yeUJ0erlfbFgHU0lWGBGHkHtqjGywxpI
         FUVfU3Fo61wlvNwC0b44egkBWsI95G638eksoQZEnjoPC0HbsVCGBZv2+iftduhGMpX4
         CAIQ==
X-Gm-Message-State: AOAM531IgESVZloVbyMhxpemVV9Rpj2iT9AacBvdwgSSfHKmCk+3Vocn
        hNB/at15xvoOPQpF6K77t2aEJNWW9Uw=
X-Google-Smtp-Source: ABdhPJyt99uWK9PYezTo/ygKXeLo+5CBe6VGi+vGkXtlY/dCk5DLmdY+hqgp/Xnr1libztVO1luuyg==
X-Received: by 2002:a2e:b1d4:: with SMTP id e20mr7315351lja.304.1608564052206;
        Mon, 21 Dec 2020 07:20:52 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:51 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 16/32] t4013: add tests for -m failing to override -c/--cc
Date:   Mon, 21 Dec 2020 18:19:44 +0300
Message-Id: <20201221152000.13134-17-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Logically, -m, -c, --cc specify 3 different formats for representing
merge commits, yet -m doesn't in fact override -c or --cc, that makes
no sense.

Add 2 expected to fail tests that demonstrate the problem.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh            |   2 +
 t/t4013/diff.log_--cc_-m_-p_master | 200 +++++++++++++++++++++++++++++
 t/t4013/diff.log_-c_-m_-p_master   | 200 +++++++++++++++++++++++++++++
 3 files changed, 402 insertions(+)
 create mode 100644 t/t4013/diff.log_--cc_-m_-p_master
 create mode 100644 t/t4013/diff.log_-c_-m_-p_master

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 935d10ac0572..64d9fce44614 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -329,6 +329,8 @@ log --first-parent --diff-merges=off -p master
 log -p --first-parent master
 log -m -p --first-parent master
 log -m -p master
+:failure log --cc -m -p master
+:failure log -c -m -p master
 log -SF master
 log -S F master
 log -SF -p master
diff --git a/t/t4013/diff.log_--cc_-m_-p_master b/t/t4013/diff.log_--cc_-m_-p_master
new file mode 100644
index 000000000000..7c217cf348c7
--- /dev/null
+++ b/t/t4013/diff.log_--cc_-m_-p_master
@@ -0,0 +1,200 @@
+$ git log --cc -m -p master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+diff --git a/dir/sub b/dir/sub
+index cead32e..992913c 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -4,3 +4,5 @@ C
+ D
+ E
+ F
++1
++2
+diff --git a/file0 b/file0
+index b414108..10a8a9f 100644
+--- a/file0
++++ b/file0
+@@ -4,3 +4,6 @@
+ 4
+ 5
+ 6
++A
++B
++C
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+diff --git a/dir/sub b/dir/sub
+index 7289e35..992913c 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,4 +1,8 @@
+ A
+ B
++C
++D
++E
++F
+ 1
+ 2
+diff --git a/file0 b/file0
+index f4615da..10a8a9f 100644
+--- a/file0
++++ b/file0
+@@ -1,6 +1,9 @@
+ 1
+ 2
+ 3
++4
++5
++6
+ A
+ B
+ C
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+diff --git a/file3 b/file3
+deleted file mode 100644
+index 7289e35..0000000
+--- a/file3
++++ /dev/null
+@@ -1,4 +0,0 @@
+-A
+-B
+-1
+-2
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+diff --git a/dir/sub b/dir/sub
+index 8422d40..cead32e 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -2,3 +2,5 @@ A
+ B
+ C
+ D
++E
++F
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..8422d40 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++C
++D
+diff --git a/file0 b/file0
+index 01e79c3..b414108 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++4
++5
++6
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
diff --git a/t/t4013/diff.log_-c_-m_-p_master b/t/t4013/diff.log_-c_-m_-p_master
new file mode 100644
index 000000000000..b660f3d5f28e
--- /dev/null
+++ b/t/t4013/diff.log_-c_-m_-p_master
@@ -0,0 +1,200 @@
+$ git log -c -m -p master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+diff --git a/dir/sub b/dir/sub
+index cead32e..992913c 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -4,3 +4,5 @@ C
+ D
+ E
+ F
++1
++2
+diff --git a/file0 b/file0
+index b414108..10a8a9f 100644
+--- a/file0
++++ b/file0
+@@ -4,3 +4,6 @@
+ 4
+ 5
+ 6
++A
++B
++C
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+diff --git a/dir/sub b/dir/sub
+index 7289e35..992913c 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,4 +1,8 @@
+ A
+ B
++C
++D
++E
++F
+ 1
+ 2
+diff --git a/file0 b/file0
+index f4615da..10a8a9f 100644
+--- a/file0
++++ b/file0
+@@ -1,6 +1,9 @@
+ 1
+ 2
+ 3
++4
++5
++6
+ A
+ B
+ C
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+diff --git a/file3 b/file3
+deleted file mode 100644
+index 7289e35..0000000
+--- a/file3
++++ /dev/null
+@@ -1,4 +0,0 @@
+-A
+-B
+-1
+-2
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+diff --git a/dir/sub b/dir/sub
+index 8422d40..cead32e 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -2,3 +2,5 @@ A
+ B
+ C
+ D
++E
++F
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..8422d40 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++C
++D
+diff --git a/file0 b/file0
+index 01e79c3..b414108 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++4
++5
++6
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
-- 
2.25.1

