Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EECC6FD1C
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 17:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCZRcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 13:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZRcC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 13:32:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBC749D1
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 10:32:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t4so1132170wra.7
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679851919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olZu6IMmc0/OGxL3h4OFGdiyJ+dXuW69JoejaNfz9uY=;
        b=n/qcb7BJdGEYQtXukkFqiFUMX30uSIEEP0PtvDk3ooKO/zxbQ+8g/ofwALB+G0ZvLI
         nWqf58LduNlw1svDWsD5OjumRdyBknc7U7LIU3jAKvlbVECi9O0qIB3admmZsXPynvW7
         xGt/9CwQuH4S5cWWvYRrl867gXi2yfDxx4ZoSgFlpw2mCPj6gqlLYzt/55WEvFHRYMbU
         hrcy0ukAa0u9waDvH9i1LhDnFMHMfKxaz+UYMxYDtB+QhXWesKnhGz2aHFV4eTQqiPZJ
         EuxkHgOrphP3Ns8BlTp3w3zt95xlzbnP/mrMr/VuGUGT+/S+XYK9CpqXaUsNzSZhzMeU
         jInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679851919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olZu6IMmc0/OGxL3h4OFGdiyJ+dXuW69JoejaNfz9uY=;
        b=ZXj0+RqXhT+dssYFaMjhE6R77IEL1WdQXdHVGFveY8KORXG7PLB6YqsUGKT9Ip9HiU
         EGM7pJOSUg9a8VcQOVyyiayPhoIXnp1G/WcPAMo1PPRpDyw+zG6tlTrVpWS0Qt/1QVqK
         x9M3o3Yn4vPYrqrR+YquPigahSA1fxdcphz6CnGWiK6a8WfzJ7E5zdgndzSMFJogz4Gv
         2jj0un8tQzmba3l+AZOo9/Qc3PpHmG97f2FTTLCE2i3TFLCBGr4P61Ok9wiHhHm9MjB+
         u+O2x8lloQSSay0S3d2UGLwFyjUJiqd8XDByZQOZq6e8BRh8Q1fFJgs7uLefhE85f670
         eX5g==
X-Gm-Message-State: AAQBX9eiRQTCGJnhO6YBptsN8CkUnD32GDncbw6CqQDbdU3Fm16KAV79
        jB+8Jp5ZZK+Me2H6MzxGeeORHKxSKJV2Zlw6
X-Google-Smtp-Source: AKy350ZyYuSCUgRq5XzpugpaB/BXO+/yM/A+OtsA3EO6RxCm7kCgQQi5AhIkX928rmQ/u+InxpDBew==
X-Received: by 2002:adf:ec82:0:b0:2d7:e4a2:4b3d with SMTP id z2-20020adfec82000000b002d7e4a24b3dmr7389034wrn.26.1679851919105;
        Sun, 26 Mar 2023 10:31:59 -0700 (PDT)
Received: from localhost.localdomain ([2a0c:5bc0:40:2e25:76c6:3bff:fe8a:46ba])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003eb5ce1b734sm11103919wmk.7.2023.03.26.10.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 10:31:58 -0700 (PDT)
From:   Edwin Fernando <edwinfernando734@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.org, Edwin Fernando <edwinfernando734@gmail.com>
Subject: [GSOC][PATCH 1/1] t3701: Avoid suppression of exit status of git
Date:   Sun, 26 Mar 2023 18:31:47 +0100
Message-Id: <20230326173147.39626-2-edwinfernando734@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230326173147.39626-1-edwinfernando734@gmail.com>
References: <20230326173147.39626-1-edwinfernando734@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pipes and command substitution in bash suppress the exit codes of the
first executed command. In the test scripts errors when running git
should be exposed. Remove all such suppressions of git by writing
output to files, chaining commands with &&, or other means.

Signed-off-by: Edwin Fernando <edwinfernando734@gmail.com>
---
 t/t3701-add-interactive.sh | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 3a99837d9b..80446b311d 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -292,8 +292,10 @@ test_expect_success FILEMODE 'patch does not affect mode' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "n\\ny\\n" | git add -p &&
-	git show :file | grep content &&
-	git diff file | grep "new mode"
+	git show :file > show_file &&
+	grep content show_file &&
+	git diff file > diff_file &&
+	grep "new mode" diff_file
 '
 
 test_expect_success FILEMODE 'stage mode but not hunk' '
@@ -301,8 +303,10 @@ test_expect_success FILEMODE 'stage mode but not hunk' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "y\\nn\\n" | git add -p &&
-	git diff --cached file | grep "new mode" &&
-	git diff          file | grep "+content"
+	git diff --cached file > diff_file &&
+	grep "new mode" diff_file &&
+	git diff file > diff_file &&
+	grep "+content" diff_file
 '
 
 
@@ -311,9 +315,12 @@ test_expect_success FILEMODE 'stage mode and hunk' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "y\\ny\\n" | git add -p &&
-	git diff --cached file | grep "new mode" &&
-	git diff --cached file | grep "+content" &&
-	test -z "$(git diff file)"
+	git diff --cached file > diff_file &&
+	grep "new mode" diff_file &&
+	git diff --cached file diff_file &&
+	grep "+content" diff_file &&
+	git diff file > diff_file &&
+	test -z $(cat diff_file)
 '
 
 # end of tests disabled when filemode is not usable
@@ -970,8 +977,8 @@ test_expect_success 'handle submodules' '
 
 	force_color git -C for-submodules add -p dirty-head >output 2>&1 <y &&
 	git -C for-submodules ls-files --stage dirty-head >actual &&
-	rev="$(git -C for-submodules/dirty-head rev-parse HEAD)" &&
-	grep "$rev" actual
+	git -C for-submodules/dirty-head rev-parse HEAD > rev &&
+	grep -f rev actual
 '
 
 test_expect_success 'set up pathological context' '
-- 
2.40.0

