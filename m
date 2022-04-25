Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DA8C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 20:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245412AbiDYUcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 16:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245394AbiDYUcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 16:32:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58118F17
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 13:29:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e2so16226566wrh.7
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0caz/MDsOIjPGMlnLvUwAXrtlZBPLjw0zGrg3JHbPM=;
        b=KXAAQhCevYR2en28gGXhqRQ/5o6hN7WGlptoAUSP65RKJudmjgi/yiYxQaTJtwdWXI
         DH4dCJeNgR6Kl5I/UoMmh64T9xMzwzQNrivz8hbYG2q4B7+pA0ly2X+YBXWECqeTdtuP
         sZGa5eqwPSSH9UB1DiUjTo5ap6At0J11u4s2kmD8qA4yFO/Zk8pB3xko/PWdpHVWsaAd
         cClHIggwINVAmj2RBS7tJTU+bBYaGJYf2CJaXxcqkL8Y/rA3z4Mvq+7MDDFEGrUmJNLb
         nERHx9wKwBWQTZ2+4UUdLDvggO0isfNbtIybviviAq+LfejeTNuE3nkQdhVaASBKU1zq
         Z9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0caz/MDsOIjPGMlnLvUwAXrtlZBPLjw0zGrg3JHbPM=;
        b=xxQ8jKkTGZKV0HKk/RujpLkANF6rHCKZ/xbUJINNkLz53iMzSf6+UeyJmk8GGiYfaf
         /ZRZuQUarNEEeX/2R+0ZU3hBkF7c8d1UGUJVKxJGGROhltQBVbSIU6bUhxRS8qa123NG
         Itc2lAboMfrGdJ9xTG8sQ66UCaUtNYKeT1dmCEav2r3e+Me4gVixCrM5F5Vd859fbvJe
         m1b5z1bV8oPoVTnBNHHEej/zaNK1jUHkwDEXPxXW2zaSkm4WDT6MdoWOYrOUOo6k5aWv
         /86AR1hLV/7Pu0vUo8N0KD90E6pV8Z+JlIW+BETePegl8cFywIs+qckthANPOoELP+4M
         VLZQ==
X-Gm-Message-State: AOAM533tkbO5KSRazFigMBxOmPBrvZsuLxxRhmLa+CEizPnCf9FsVwOp
        +dpp83ocAiAPn5M8lo1daSU=
X-Google-Smtp-Source: ABdhPJzoEcpiFcSYXVNLxvKviiSX700ejZ/IV50i9UPZyr/etg9jnBClfRsdhbD+foyd5roJCbgfuw==
X-Received: by 2002:a05:6000:1882:b0:20a:a22e:ac11 with SMTP id a2-20020a056000188200b0020aa22eac11mr15672220wri.30.1650918542963;
        Mon, 25 Apr 2022 13:29:02 -0700 (PDT)
Received: from localhost.localdomain (123.79.195.77.rev.sfr.net. [77.195.79.123])
        by smtp.gmail.com with ESMTPSA id h9-20020adfa4c9000000b0020ae2a771fdsm876256wrb.72.2022.04.25.13.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:29:02 -0700 (PDT)
From:   Jonathan <git.jonathan.bressat@gmail.com>
To:     gitster@pobox.com
Cc:     Jonathan.bressat@etu.univ-lyon1.fr, Matthieu.Moy@univ-lyon1.fr,
        cogoni.guillaume@gmail.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, guillaume.cogoni@gmail.com
Subject: [PATCH v1 1/2] t7615: test how merge behave when there is untracked file
Date:   Mon, 25 Apr 2022 22:27:20 +0200
Message-Id: <20220425202721.20066-2-git.jonathan.bressat@gmail.com>
X-Mailer: git-send-email 2.35.1.7.gc8609858e0.dirty
In-Reply-To: <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
References: <xmqqfsmg97ac.fsf@gitster.g>
 <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

when there is untracked file that has the same name than file in the
merged branch git refuse to proceed, even when the file has the same
content

t6436 test a similar thing but not especially with same content file

Signed-off-by: Jonathan <git.jonathan.bressat@gmail.com>
Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 t/t7615-merge-untracked.sh | 63 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 t/t7615-merge-untracked.sh

diff --git a/t/t7615-merge-untracked.sh b/t/t7615-merge-untracked.sh
new file mode 100755
index 0000000000..053e6b80ee
--- /dev/null
+++ b/t/t7615-merge-untracked.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='test when merge with untracked file'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit "init" README.md "content" &&
+	git checkout -b A
+'
+
+test_expect_success 'fastforward fail when untracked file has the same content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" &&
+	git checkout A &&
+	echo content >file &&
+	test_must_fail git merge B
+'
+
+test_expect_success 'fastforward fail when untracked file has different content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" &&
+	git switch A &&
+	echo other >file &&
+	test_must_fail git merge B
+'
+
+test_expect_success 'normal merge fail when untracked file has the same content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" fileB "content" &&
+	git switch A &&
+	test_commit --no-tag "exA" fileA "content" &&
+	echo content >file &&
+	test_must_fail git merge B
+'
+
+test_expect_success 'normal merge fail when untracked file has different content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" fileB "content" &&
+	git switch A &&
+	test_commit --no-tag "exA" fileA "content" &&
+	echo dif >file &&
+	test_must_fail git merge B
+'
+
+test_expect_success 'merge fail when tracked file modification is unstaged' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	test_commit --no-tag "unstaged" file "other" &&
+	git checkout -b B &&
+	test_commit --no-tag "staged" file "content" &&
+	git switch A &&
+	echo content >file &&
+	test_must_fail git merge B
+'
+
+test_done
-- 
2.35.1.7.gc8609858e0.dirty

