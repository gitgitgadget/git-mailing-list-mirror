Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B48C0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 04:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjGMEmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 00:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjGMEmq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 00:42:46 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E388CCF
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 21:42:44 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-55e1ae72dceso274609eaf.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 21:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689223363; x=1691815363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eaz1tOskdVqgLMCi5RUt9XvUArhwYbWUWPyNYXARWDg=;
        b=iF/yXdrHdD9FvjXe+mOn8LBILOQexbD7/XzRKZxfhMUhOT0MhmaejS4QtlrTz4zmwT
         S2Zg3QGZVYaukpz1FX2EXm8t6RoNncPFDz7syCVtW3KuTNoVKZSr4tIWBioXpTBmH+HC
         wUF/y5s9cLw+ORJSKR5N7rdXqvV+iJFxT2kbuxvGKC8BszLWFhhPCYsFDMyLmgE8o+1v
         65JkCeLYGBTljUrQWYUYpIzWzhobL9AyoXjNJvsVad3aJcBXRrhAVKPLSfqEoyVtj7Wb
         u2scp2TPBmHs9MCm4EOCP2tiwVUAKTcc8Q0a5/3zm0AkWIF9bmtnTD6rpRkktw4dqq7W
         PbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689223363; x=1691815363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eaz1tOskdVqgLMCi5RUt9XvUArhwYbWUWPyNYXARWDg=;
        b=HVnhYJ55hRFN/K7Etx8s2oC5XW/bLvZmopRjiCVU9IriKRF3VzdQG7jCcvN3zzTUCM
         O69fditjlAuM6gPZhPtTbSV6SokYhqvMyOWIkgXhKiRh/Rhr3v17rH1HDtiWDvhpyF1w
         bpBcuJjN69cjlSbHgtvhXmnnX/jfN8+DIfK/hqCHDJhzyNvsqqagpDNiGPAI90yQBXtx
         bRCTD9n/aM02C5E/DnOnwMNaS67N1HcQO6lBQq7O6S6VcOTbmoFcx7mLx7dYpp+s0GSL
         7XLbqXIEyt+XFT9c1AitnfrC1wK4vcD6/iDpMmEglrDVc2Bq1EXBkkRR5J0eOIyhXAwQ
         CY0w==
X-Gm-Message-State: ABy/qLYX9WeIkQ0ACK5rxN/5aMOM4XToH583nx9mCxFZ+OUjSNQHbmFy
        lHqLe2h4MkccjFk2AQX+9M+tk3y7HA4=
X-Google-Smtp-Source: APBJJlEdTRq+gluPcJbDeyBSskMmVRKsXm7Sr4pTpJcEqO4bgtcO+JEeHajjvULz1FGVZjB6un3D0g==
X-Received: by 2002:a05:6358:8a1:b0:135:258f:cd86 with SMTP id m33-20020a05635808a100b00135258fcd86mr1240696rwj.6.1689223363285;
        Wed, 12 Jul 2023 21:42:43 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902cd0d00b001ae5d21f760sm4843040ply.146.2023.07.12.21.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:42:41 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5 2/3] remote: don't imply that integration is always required before pushing
Date:   Wed, 12 Jul 2023 22:41:14 -0600
Message-ID: <20230713044128.3771818-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713044128.3771818-1-alexhenrie24@gmail.com>
References: <20230707054257.3366355-1-alexhenrie24@gmail.com>
 <20230713044128.3771818-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a narrow but common case, the user is the only author of a branch and
doesn't mind overwriting the corresponding branch on the remote. This
workflow is especially common on GitHub, GitLab, and Gerrit, which keep
a permanent record of every version of a branch that is pushed while a
pull request is open for that branch. On those platforms, force-pushing
is encouraged and is analogous to emailing a new version of a patchset.

When giving advice about divergent branches, tell the user about
`git pull`, but don't unconditionally instruct the user to do it. A less
prescriptive message will help prevent users from thinking that they are
required to create an integrated history instead of simply replacing the
previous history. Likewise, don't imply that `git pull` is only for
merging.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 remote.c          |  2 +-
 t/t7508-status.sh | 38 +++++++++++++++++++-------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/remote.c b/remote.c
index d79aae0d76..71019564d5 100644
--- a/remote.c
+++ b/remote.c
@@ -2325,7 +2325,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (show_divergence_advice &&
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
-				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
+				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
 	free(base);
 	return 1;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 845af287d7..6928fd89f5 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -92,7 +92,7 @@ test_expect_success 'status --column' '
 # On branch main
 # Your branch and '\''upstream'\'' have diverged,
 # and have 1 and 2 different commits each, respectively.
-#   (use "git pull" to merge the remote branch into yours)
+#   (use "git pull" if you want to integrate the remote branch with yours)
 #
 # Changes to be committed:
 #   (use "git restore --staged <file>..." to unstage)
@@ -123,7 +123,7 @@ cat >expect <<\EOF
 # On branch main
 # Your branch and 'upstream' have diverged,
 # and have 1 and 2 different commits each, respectively.
-#   (use "git pull" to merge the remote branch into yours)
+#   (use "git pull" if you want to integrate the remote branch with yours)
 #
 # Changes to be committed:
 #   (use "git restore --staged <file>..." to unstage)
@@ -270,7 +270,7 @@ test_expect_success 'status with gitignore' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -335,7 +335,7 @@ test_expect_success 'status with gitignore (nothing untracked)' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -405,7 +405,7 @@ test_expect_success 'status -uno' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -467,7 +467,7 @@ test_expect_success 'status -unormal' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -522,7 +522,7 @@ test_expect_success 'status -uall' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -582,7 +582,7 @@ test_expect_success 'status with relative paths' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -650,7 +650,7 @@ test_expect_success TTY 'status with color.ui' '
 On branch <GREEN>main<RESET>
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -773,7 +773,7 @@ test_expect_success 'status without relative paths' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -900,7 +900,7 @@ test_expect_success 'status submodule summary is disabled by default' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -957,7 +957,7 @@ test_expect_success 'status submodule summary' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -1016,7 +1016,7 @@ test_expect_success 'status submodule summary (clean submodule): commit' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
@@ -1116,7 +1116,7 @@ test_expect_success '--ignore-submodules=untracked suppresses submodules with un
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -1225,7 +1225,7 @@ test_expect_success "--ignore-submodules=untracked doesn't suppress submodules w
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -1282,7 +1282,7 @@ test_expect_success "--ignore-submodules=untracked doesn't suppress submodule su
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -1363,7 +1363,7 @@ cat > expect << EOF
 ; On branch main
 ; Your branch and 'upstream' have diverged,
 ; and have 2 and 2 different commits each, respectively.
-;   (use "git pull" to merge the remote branch into yours)
+;   (use "git pull" if you want to integrate the remote branch with yours)
 ;
 ; Changes to be committed:
 ;   (use "git restore --staged <file>..." to unstage)
@@ -1411,7 +1411,7 @@ test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
@@ -1437,7 +1437,7 @@ test_expect_success '.gitmodules ignore=all suppresses unstaged submodule summar
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (use "git pull" if you want to integrate the remote branch with yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
-- 
2.41.0

