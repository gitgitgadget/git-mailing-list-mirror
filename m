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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF43C2BBCD
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8F823432
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbgLPSwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732300AbgLPSwb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:31 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447D8C0619DF
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:51:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h205so7476295lfd.5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+Hn9/z7jtos5YDGkqDtmMK1/VUsxAr7Rhg4uqj30Sk=;
        b=FETr/jAnSKt2HEaOrvRCqLb9bWofKSx0NZuzheEDPcwwEBn9CCde6D+BQ1WjBz20At
         CdMLvbMEM38Uqh2iVC4GQRHoY15m5J9FwCDe5nBHuq7TP+u4bm8/F2eux1Wp6rhlYX/h
         H8a6VnDM6dMH4MjLrbpefq2DEUOVj9YxWD8zwoL58M6eZ2v5BA18MGwFwNGzZUT9ph/4
         VcW52HAOhv3iZqCuKU6z29fBkd7W5X0XyE6sEwPM7V4rO+8/gEOLQtAIF/NgExpRJka2
         ZUiCuKjA/ML2jsf+rLGpe87JXtkfkSVq90pKv2ajK0Cvk2rglzP8GsFNtulUvzXNfih8
         PhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+Hn9/z7jtos5YDGkqDtmMK1/VUsxAr7Rhg4uqj30Sk=;
        b=CYd66CL/R3ILEVThliAnfz1XVFcKnf7FSIzCkYhowQ1gY+2ZULnSR+lFKg8STo0ee1
         G7uNJSRSscjBSkmR6BQUSyCsffFF6Lr2Mfv09H+KIZb0bwav8hoL5Te/VAPUPKG+YseB
         b9wGALYsgwdw7XAWd66vZNqWh2IgJABfc7pqqjafB6Crmy8Dwwmw69SRpfu6xcFCg4d5
         03LHmQWeGzuWOXgBgbtUPqQ05vHPdlAZWIl3xL0cEJG1OPNERI40MF6OcIkCtArjLNbH
         eNZvvKqaWxKQk9Jw1BQRjC6NigZbTP0jgD1XfkJRGp/mNnI0ZIHADA0tihz736XVxUts
         crCA==
X-Gm-Message-State: AOAM533w3L7oDTQE/SYLE1fCx0t+q6aCti8r4dD+mCPiH7pqTjPsM1uh
        cnxanCdwnvqZQIUJFZxIqko=
X-Google-Smtp-Source: ABdhPJz6PhmsKvCeCKST+9TYF5CAG3l+OvSpyutVFI85iggiFOcdcDc8/8DveeD3TVMiY0f3+dtx4w==
X-Received: by 2002:a2e:984c:: with SMTP id e12mr10669033ljj.71.1608144664029;
        Wed, 16 Dec 2020 10:51:04 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:51:03 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 33/33] t4013: add tests for --diff-merges=first-parent
Date:   Wed, 16 Dec 2020 21:49:29 +0300
Message-Id: <20201216184929.3924-34-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new option provides essential new functionality, changing diff
output to first parent only, without changing history traversal mode,
so it deserves its own test.

As we do it, add additional test that --diff-merges=first-parent by
itself doesn't imply -p and only outputs diffs for merge commits.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh                       |   2 +
 ...diff.log_--diff-merges=first-parent_master |  56 +++++++
 ...f.log_-p_--diff-merges=first-parent_master | 137 ++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 t/t4013/diff.log_--diff-merges=first-parent_master
 create mode 100644 t/t4013/diff.log_-p_--diff-merges=first-parent_master

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8d8178a8a616..fa82b5a8eed4 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -327,6 +327,8 @@ log --no-diff-merges -p --first-parent master
 log --diff-merges=off -p --first-parent master
 log --first-parent --diff-merges=off -p master
 log -p --first-parent master
+log -p --diff-merges=first-parent master
+log --diff-merges=first-parent master
 log -m -p --first-parent master
 log -m -p master
 log --cc -m -p master
diff --git a/t/t4013/diff.log_--diff-merges=first-parent_master b/t/t4013/diff.log_--diff-merges=first-parent_master
new file mode 100644
index 000000000000..fa63a557dd18
--- /dev/null
+++ b/t/t4013/diff.log_--diff-merges=first-parent_master
@@ -0,0 +1,56 @@
+$ git log --diff-merges=first-parent master
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
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
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

