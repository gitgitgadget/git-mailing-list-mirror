Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC20DC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 14:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbhKVOYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 09:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbhKVOYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 09:24:07 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A8C061714
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:21:00 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u1so32990495wru.13
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4XVZAMqIqOH16y6McU/uuX4Y21yjewme90u7J9fesnI=;
        b=JNi2QWIfMZ7IszFSfiS6QCpg2fOGycEy3cnZGfuK8wUa/+xn4B1BtSpiTy2A7LmZtl
         CTtMYv1LAnwRP6RyoN+tQh+ZA+0NDa8scoke0agBCB1g1fl6cBS6eNneRBXHJqevAAal
         xVsLydLDE4LOiwqP2gYVKMEz08F9bv5Jur5xrwly7SZRcUx+4Rq44NuyGtkWcuz0nL8P
         +wlMd5eqtJuf8ioyQwOWgG8OY9D+fTjbMZQzvjl/B0lZsjBIQuv5hnjeZNdrnvk+p4ov
         gT99sW7xIhOIQbhLyOTmLRi1tqRQNBQrpFSQw9yiQcT6gcA2SAG87PNWyK729N1y+W9c
         0PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4XVZAMqIqOH16y6McU/uuX4Y21yjewme90u7J9fesnI=;
        b=YSTt3kybDNSql0sVM5raYn84TTu55IMnysn11L89EXWmK3xwtIt05J5bp1xaDSx6nQ
         TQyVuXklCP7iaTc2GO+AohgNW01RY/KZyCU1uH0dorSrCb7aq0lL3vzZWBvylh52NwQI
         4ToE2fF5YFe4/glVR2FX5PblDmuVQ/pLvkAS9WqEZVxFNqjcs7pufnK9Uw/ykcTmUCXU
         tBXWxKg/rHcEUuLC4WHF2NTsCxin/ESY8sS/0/LrleQQHEYs65bkK0Me4UggdDMtojs+
         y3ywOAGvHdqpJz1Ab71eWKrebmOmkoSilNqhiZbhlWqjwjUZJHM/ssnIbBBz5UJn3IHz
         1qxQ==
X-Gm-Message-State: AOAM530ukY7jChe0BfaPsXjGNiNAbfDs9ar2f+yJEizFiHlfwWDpII9Q
        kM4ApkXWOInYXGPRkU16YAWu8f4T5Ws=
X-Google-Smtp-Source: ABdhPJx8X5xjNonEixKvdILl43IN3RsnuSAuE15MnPfzO7tGBqWp/KD5DFZRHXg4Qfhmsdwsfq4cOw==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr38068781wrr.385.1637590858992;
        Mon, 22 Nov 2021 06:20:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q24sm11729444wmj.21.2021.11.22.06.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:20:58 -0800 (PST)
Message-Id: <4ba97a4e70aa437f9f710746fa7a8abad0732996.1637590855.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 14:20:55 +0000
Subject: [PATCH 4/4] t1400: use test-helper ref-store to inspect reflog
 contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This avoids inspecting the file system, which only works with the files ref
backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1400-update-ref.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 0d4f73acaa8..f91432e7a25 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -10,6 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 Z=$ZERO_OID
+TAB='	'
 
 m=refs/heads/main
 n_dir=refs/heads/gu
@@ -318,11 +319,12 @@ test_expect_success 'symref empty directory removal' '
 cat >expect <<EOF
 $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
-$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
+$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000$TAB
 EOF
 test_expect_success "verifying $m's log (logged by touch)" '
-	test_when_finished "rm -rf .git/$m .git/logs expect" &&
-	test_cmp expect .git/logs/$m
+	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
+	test-tool ref-store main for-each-reflog-ent $m > actual &&
+	test_cmp actual expect
 '
 
 test_expect_success "create $m (logged by config)" '
@@ -347,11 +349,12 @@ test_expect_success "set $m (logged by config)" '
 cat >expect <<EOF
 $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 +0000	Initial Creation
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
-$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
+$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000$TAB
 EOF
 test_expect_success "verifying $m's log (logged by config)" '
-	test_when_finished "rm -f .git/$m .git/logs/$m expect" &&
-	test_cmp expect .git/logs/$m
+	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
+	test-tool ref-store main for-each-reflog-ent $m > actual &&
+	test_cmp actual expect
 '
 
 test_expect_success 'set up for querying the reflog' '
@@ -467,7 +470,8 @@ $h_OTHER $h_FIXED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151040 +0000	co
 $h_FIXED $h_MERGED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151100 +0000	commit (merge): Merged initial commit and a later commit.
 EOF
 test_expect_success 'git commit logged updates' '
-	test_cmp expect .git/logs/$m
+	test-tool ref-store main for-each-reflog-ent $m >actual &&
+	test_cmp expect actual
 '
 unset h_TEST h_OTHER h_FIXED h_MERGED
 
-- 
gitgitgadget
