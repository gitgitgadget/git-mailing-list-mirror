Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F7AC2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF53720B1F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ty+Cs7HK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgKATed (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgKATe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B688C0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:26 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id i6so14670418lfd.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEpf1BvZDlnmGQIdDIY7sWIcaQ1X1Jpqt7apLJCnNBQ=;
        b=ty+Cs7HKSGMk7Gm/kadWjEsd1/7lL2xaIhqanEpbYyPoGJlZN4IGkt1+ArqxwdKxuo
         c7FrIsmJE0siFrbhuMHkvSD+QFF4T7wiDAkTxBMJhRWFBx2ZpK13wkjwkMDPCG/HCYtG
         0IYa6Dp/AH1WVEqAQcjX6FQJMWqzl9jyi5GrHjWXAIstAiY797QP2p88xobCW091xOFk
         vjiQHednXRY1tWNZdiHn8rdaQ0lf9KloXcTVWlsNBk3bGQgNmfKNBByQM5TMj10OWLk7
         xRnDhv/csI9aX/uZMQk3br1AYo8AtsfO+jL3pHEgEVG1Ih84G+T/NyoNQaMrwStj4AWT
         bS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEpf1BvZDlnmGQIdDIY7sWIcaQ1X1Jpqt7apLJCnNBQ=;
        b=CPd7ae+EkfTX87tRqHpJaXh8x5MKU8XD6vGnCdzRAyl36vFtL9FXkt3whCWJ8NpFWg
         b0wtCndshMoh7KRd+6x8BCy3PuoRw2cDDfPtolzGYwihLpjZkQ2vhxmrw86WsrOv2y6/
         gphT8YAoXb+J4p0HxiAt7E+65jr33djCmkUMsMtjYU8zKL69K5Frp5jVoAzBg9HFfalN
         EKbgfjS1v5yUs0cZ6z5sIj29p7OQMRQytJ8Opg0PJcrpO0Mg0Hdn5kWUEK8lMAxgC0p5
         4QVi8yB8YKONuGf1vnJswU2PMEqgF11mBY7NxinaCSCDEPFjvrYHNvwVE7Kmm9oHRzMS
         8Y/g==
X-Gm-Message-State: AOAM5323kaL8vCCxp9/GAQvMZRsL62n0PCsSpGodGyCqXBwgkiNJ70A/
        weeVrN/Nb/vw7XXu3TLNBt0=
X-Google-Smtp-Source: ABdhPJxr8SgQtv2ZIx0bmtWi0lXP5yg7yD15p3xWdQg9mM5BZTB5VQP+rqN5MvfDrL7e2sp5vbg7ng==
X-Received: by 2002:ac2:5207:: with SMTP id a7mr4264377lfl.56.1604259265020;
        Sun, 01 Nov 2020 11:34:25 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:24 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 23/26] t4013: add test for --diff-merges=first-parent
Date:   Sun,  1 Nov 2020 22:33:27 +0300
Message-Id: <20201101193330.24775-24-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new option provides essential new functionality, changing diff
output to first parent only without changing history traversal mode,
so it deserves its own test.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh                       |   1 +
 ...f.log_-p_--diff-merges=first-parent_master | 137 ++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 t/t4013/diff.log_-p_--diff-merges=first-parent_master

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8d8178a8a616..ce56a9349d1c 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -327,6 +327,7 @@ log --no-diff-merges -p --first-parent master
 log --diff-merges=off -p --first-parent master
 log --first-parent --diff-merges=off -p master
 log -p --first-parent master
+log -p --diff-merges=first-parent master
 log -m -p --first-parent master
 log -m -p master
 log --cc -m -p master
diff --git a/t/t4013/diff.log_-p_--diff-merges=first-parent_master b/t/t4013/diff.log_-p_--diff-merges=first-parent_master
new file mode 100644
index 000000000000..9538a2751123
--- /dev/null
+++ b/t/t4013/diff.log_-p_--diff-merges=first-parent_master
@@ -0,0 +1,137 @@
+$ git log -p --diff-merges=first-parent master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
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

