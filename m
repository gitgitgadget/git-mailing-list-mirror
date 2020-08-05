Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C8AC433E3
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B273420786
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUsibCGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHEWI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgHEWIy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:08:54 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B50C06179E
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 15:08:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id i10so14703629ljn.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 15:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yj5I0SsdzHIpWzh2f4MnCrC9xXyRxl6HWxWJ1joniVE=;
        b=gUsibCGB8/A76dDJLJpVsFJYjAbNR6MOlSKlDaM1ozJuHojwJvNlb742Vc/AuzwcDY
         ywkQAJW2dfNmNMOOa7iEvBHs6kSHYIkHQUXE+rdVei27HtJ5W962+MrBzRZEMgN2Gw5a
         QamNB5WEWrUz6CbCImMXWdUFFE7M8QAMYuq6iY3vltg2XO33owCL1ibMwKc81kAttrp1
         mxYiWM9ym0BgtjUsJDB9rkHArA6Dbv7YR8vvwTJ9+ZfbPBPXtEh6pSOgvjOokHVZ96Z/
         nxZdoloRYfTV1oGkgQwiEHx864Pih9UBRyhpaI+2J2bfiqH7Ihl4xZ0rpdrhoGGjDB5M
         lhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yj5I0SsdzHIpWzh2f4MnCrC9xXyRxl6HWxWJ1joniVE=;
        b=QOBJXVUwd5E4bPDInJkh89cYxQ+cMaOYzZLWkZhNddbrZPu+FoCPfStiTWMpOqzt8v
         eatcqovabQTjXYKfmsScImJPpANeTGUPWeS/+FuLdOszdB1kHvbcLU14QT8gHvc1yjGg
         NupwVfdfHZNyYEIBzU+CT9eiujuhl79kOLblXb0PQCCrvXENy9qeyxOnPI8WwB++Rp5i
         zR+tY8/e5bnCL1Ccqj5tIIYk9ONGPpdZg2SfRIlPbX8FkRPGqWOM54OnlOljRUknpub3
         iTxW4BTced2EXipO5f/j/WXjU2V3udfHO66ehnFcyw7ranrMYjNXPsVxB1vYAu4jL3eD
         Ld7g==
X-Gm-Message-State: AOAM533wUVczBSu8fen4GzFZJwvXqXGCvp9QX8aYq6HPKOJH3A6ib+fg
        HWyMfs+IS3Nyj9Qwv9jFhor395US
X-Google-Smtp-Source: ABdhPJyZERWUfnYkdJkanGev6JDwgAMIsgn1/5NM5GLvkILlFCfda9965/7I3ha6/OVmyymtfyHPxA==
X-Received: by 2002:a2e:b5a5:: with SMTP id f5mr2560943ljn.114.1596665331034;
        Wed, 05 Aug 2020 15:08:51 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g18sm1544183ljk.27.2020.08.05.15.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 15:08:50 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH  3/3] t/t4013: add test for --diff-merges=off
Date:   Thu,  6 Aug 2020 01:08:32 +0300
Message-Id: <20200805220832.3800-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200805220832.3800-1-sorganov@gmail.com>
References: <20200805220832.3800-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh                       |  1 +
 ...--diff-merges=off_-p_--first-parent_master | 78 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 40e222c94520..86fb11cecc61 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -298,6 +298,7 @@ log --root -c --patch-with-stat --summary master
 # improved by Timo's patch
 log --root --cc --patch-with-stat --summary master
 log --no-diff-merges -p --first-parent master
+log --diff-merges=off -p --first-parent master
 log -p --first-parent master
 log -m -p --first-parent master
 log -m -p master
diff --git a/t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master b/t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master
new file mode 100644
index 000000000000..c878f13c9519
--- /dev/null
+++ b/t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master
@@ -0,0 +1,78 @@
+$ git log --diff-merges=off -p --first-parent master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side' into master
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
2.20.1

