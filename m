Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3640CC0015E
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 05:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjGGFna (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 01:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGGFn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 01:43:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839241FC6
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 22:43:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-668711086f4so1043291b3a.1
        for <git@vger.kernel.org>; Thu, 06 Jul 2023 22:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688708606; x=1691300606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhxgO4fqQlgqL3ynjcgsG/0LLib1Z+pwZcIx8EvKXjE=;
        b=eZGYVIGejNbZ+HMFIn1TJDpRjAkKidB4uGVCe2uq5Lv36SgucMKQLBeAtvWFmYMpnF
         zG4J+bufl8hLsxJKeFbiMM3dFQo15iioDTdiaVTwVgUWTNnwWcnd/JmTbwKMnwMzh8lx
         3HeEOe98KjIuZchKBH8unJily9z5fRHOWD5RF61ZitzW65Y6QCUfGp6qafQuPs3s05IJ
         SnTp40Zj2PRTkcPoE5Q7twWQjkRXv6yAqS1CcbE0C75JIbNpmXxIBuCo4wqDR1A/dLxx
         q7ZnNmswnXhbBC0i0dUsKsugKZEv7YPg37M/U3DEmM9jZeIq9CXpeidfjTt8LWoOPFf3
         55zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688708606; x=1691300606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhxgO4fqQlgqL3ynjcgsG/0LLib1Z+pwZcIx8EvKXjE=;
        b=NpZhQ5r1JwaXPDV9pqCV+4tm5wAmUIe+18uMRByp1GJWEDkXJbWxwo2KUTrpk0doaP
         tGQwhzKANGs+LBMCbQvwYY/6y0fgfSTohvjkUL6NTjumf3xljnqYUO9rqlxdN/zdEkVc
         AKL9lx/nYhv/gkZ8FLMTr/Dds0rioOj72XMcKAgDbrhO4gJowioek5SiT+ytpx0KU10C
         5Ddac3v4BE2/+LJyhjtOgmMLYpRPAenUrEoW9HOvGO5oMlNnJlQjX0+94EqB1gnFIdgR
         ZlehgWKI+k7L+1WgPCOoMtt2Dh9TEV4ombcxCfdVsTka1awf1Veo+O3CL+GW5J1Ma7Qi
         8E5A==
X-Gm-Message-State: ABy/qLZjdYg+FV7XmaOfXX5Iwmd5wg/+9dxSSh7HJQ4E5Wb16qkU7GjN
        3eiUTOlRsSH/zNji2ytdvoAcWM02GMs=
X-Google-Smtp-Source: APBJJlFH6pDWegKBxeMMAYxD5t+g7K0bgJfqyNvt0YNC3jTiCiH2Y/sOdVX7chsKc7JfloG2g7UwQA==
X-Received: by 2002:a05:6a00:1886:b0:668:7494:384a with SMTP id x6-20020a056a00188600b006687494384amr7081042pfh.12.1688708605407;
        Thu, 06 Jul 2023 22:43:25 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id r8-20020a635d08000000b00553dcfc2179sm2132568pgb.52.2023.07.06.22.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 22:43:24 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v4 1/2] remote: advise about force-pushing as an alternative to reconciliation
Date:   Thu,  6 Jul 2023 23:42:47 -0600
Message-ID: <20230707054257.3366355-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707054257.3366355-1-alexhenrie24@gmail.com>
References: <20230706040111.81110-1-alexhenrie24@gmail.com>
 <20230707054257.3366355-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also, don't imply that `git pull` is only for merging.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 remote.c          |   5 ++-
 t/t7508-status.sh | 110 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 92 insertions(+), 23 deletions(-)

diff --git a/remote.c b/remote.c
index a81f2e2f17..1fe86f8b23 100644
--- a/remote.c
+++ b/remote.c
@@ -2323,7 +2323,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			base, ours, theirs);
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
-				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
+				_("  (To reconcile your local changes with the work at the remote, you can\n"
+				  "  use 'git pull' and then 'git push'. To discard the work at the remote\n"
+				  "  and replace it with what you did (alone), you can use\n"
+				  "  'git push --force'.)\n"));
 	}
 	free(base);
 	return 1;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 36567708f5..2a17e84793 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -92,7 +92,10 @@ test_expect_success 'status --column' '
 # On branch main
 # Your branch and '\''upstream'\'' have diverged,
 # and have 1 and 2 different commits each, respectively.
-#   (use "git pull" to merge the remote branch into yours)
+#   (To reconcile your local changes with the work at the remote, you can
+#   use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+#   and replace it with what you did (alone), you can use
+#   '\''git push --force'\''.)
 #
 # Changes to be committed:
 #   (use "git restore --staged <file>..." to unstage)
@@ -123,7 +126,10 @@ cat >expect <<\EOF
 # On branch main
 # Your branch and 'upstream' have diverged,
 # and have 1 and 2 different commits each, respectively.
-#   (use "git pull" to merge the remote branch into yours)
+#   (To reconcile your local changes with the work at the remote, you can
+#   use 'git pull' and then 'git push'. To discard the work at the remote
+#   and replace it with what you did (alone), you can use
+#   'git push --force'.)
 #
 # Changes to be committed:
 #   (use "git restore --staged <file>..." to unstage)
@@ -270,7 +276,10 @@ test_expect_success 'status with gitignore' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -335,7 +344,10 @@ test_expect_success 'status with gitignore (nothing untracked)' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -405,7 +417,10 @@ test_expect_success 'status -uno' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -467,7 +482,10 @@ test_expect_success 'status -unormal' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -522,7 +540,10 @@ test_expect_success 'status -uall' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -582,7 +603,10 @@ test_expect_success 'status with relative paths' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -650,7 +674,10 @@ test_expect_success TTY 'status with color.ui' '
 On branch <GREEN>main<RESET>
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -773,7 +800,10 @@ test_expect_success 'status without relative paths' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -847,7 +877,10 @@ test_expect_success 'dry-run of partial commit excluding new file in index' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -901,7 +934,10 @@ test_expect_success 'status submodule summary is disabled by default' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -958,7 +994,10 @@ test_expect_success 'status submodule summary' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -1017,7 +1056,10 @@ test_expect_success 'status submodule summary (clean submodule): commit' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
@@ -1065,7 +1107,10 @@ test_expect_success 'commit --dry-run submodule summary (--amend)' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --source=HEAD^1 --staged <file>..." to unstage)
@@ -1117,7 +1162,10 @@ test_expect_success '--ignore-submodules=untracked suppresses submodules with un
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -1226,7 +1274,10 @@ test_expect_success "--ignore-submodules=untracked doesn't suppress submodules w
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -1283,7 +1334,10 @@ test_expect_success "--ignore-submodules=untracked doesn't suppress submodule su
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -1364,7 +1418,10 @@ cat > expect << EOF
 ; On branch main
 ; Your branch and 'upstream' have diverged,
 ; and have 2 and 2 different commits each, respectively.
-;   (use "git pull" to merge the remote branch into yours)
+;   (To reconcile your local changes with the work at the remote, you can
+;   use 'git pull' and then 'git push'. To discard the work at the remote
+;   and replace it with what you did (alone), you can use
+;   'git push --force'.)
 ;
 ; Changes to be committed:
 ;   (use "git restore --staged <file>..." to unstage)
@@ -1412,7 +1469,10 @@ test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
@@ -1438,7 +1498,10 @@ test_expect_success '.gitmodules ignore=all suppresses unstaged submodule summar
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -1558,7 +1621,10 @@ test_expect_success 'git commit --dry-run will show a staged but ignored submodu
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
+  (To reconcile your local changes with the work at the remote, you can
+  use '\''git pull'\'' and then '\''git push'\''. To discard the work at the remote
+  and replace it with what you did (alone), you can use
+  '\''git push --force'\''.)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
-- 
2.41.0

