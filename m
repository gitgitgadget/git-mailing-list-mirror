Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60AAC3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F0F20A8B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHUJgNLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgDTIzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726201AbgDTIzC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 04:55:02 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67949C061A41
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:55:02 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o10so7807716qtr.6
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JWl+maHKiHdh8fIgeXEeOMTDn85biUP5PyhN2YtyhGo=;
        b=vHUJgNLsI5vDBFcjH1128pI2mcbfby4Kiq7JHLJcDUj4BSFJa2w1kdQCXn9IoSc1jL
         xqY55OQSzGX+sR4GDe7gmLkKVVCPBCe+MBCvb9xUqxE+zSMRhy3/8Kx1GtSSWPZXpYre
         Gb95PXv7U66fETGbdFjAEKTBl45dWMX/7Qtu9x8W9PPC6e1f0fBqpuqQuxJjTbpu+gub
         rMjG53KZXgj5cQkBIZGll4yjkdO7O8G39ue58Qb994dk2PbAZILaxVbDg7fulVTXRSYc
         XFSuDYxwX0T9MYDhfJjjBX33p//O7b611Sex2DES9zJgyndSCPyFouKj6l7Qj5oOzREW
         XzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWl+maHKiHdh8fIgeXEeOMTDn85biUP5PyhN2YtyhGo=;
        b=Szqk89Ai4bJNIqpoKRmH5z505FKqP1gr6i9SA+/r2FnMRZ1nz9sStjl/bC5aYHzWf5
         YDpOkXlhWHy7q3LFVrCGlGOqUDbvtVyBBI21RTaLdEulJ8UsioLugtFlP0iOnOatTrYz
         +UXd90WZ9blrqiXXcfDhugLotZlvpkxRKzf3UDzdZKJjAEISyBnRjlvqssQYzxemLYX+
         SwkmdOyOsg29YKTHDM/0arPZqnE1JfhvaTsCUpoa0CVzmgiDuoiv91/HrcCBj3XkhAoV
         HwP2uB9cCrofpqxIjNwJMVFxdkpZ4YKPX6F/w8iEItxrGEo1VnKC5qn0/m09zMzISwZE
         g6Zg==
X-Gm-Message-State: AGi0PuZT2QLoU/F/sFa3jws+NDcCaw3SbDdfbzGyF37316Eb5QwacHWc
        3257y+eCvrqvxV64dv/TkUK6SlrG
X-Google-Smtp-Source: APiQypJH+dywFbb7/j0F89MOCGbCd/ZskfvzAmK8jUC05wVNeqeQN9rxUTUs+Bh3FnjUe5cqT98Cow==
X-Received: by 2002:ac8:568b:: with SMTP id h11mr15322170qta.197.1587372901460;
        Mon, 20 Apr 2020 01:55:01 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p25sm203222qkk.18.2020.04.20.01.55.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:55:01 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 8/8] t9902: don't use `test_must_fail __git_*`
Date:   Mon, 20 Apr 2020 04:54:46 -0400
Message-Id: <6cfa2c447e1196d6c4325aff9fac52434d10fda8.1587372771.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1587372771.git.liu.denton@gmail.com>
References: <cover.1587372771.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We should only use test_must_fail() to test git commands. Replace
`test_must_fail` with `!` so that we don't use test_must_fail() on the
completion functions.

This is done because test_must_fail() is used to except git exiting with
an expected error but it will still return an error if it detects
unexpected errors such as a segfault. In the case of these completion
functions, the return codes of the git commands aren't checked and, most
of the time, they will just explicitly return 1 or have an unrelated
command return 0. As a result, it doesn't really make sense to use
`test_must_fail` so use `!` instead.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t9902-completion.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5505e5aa24..320c755971 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -294,7 +294,7 @@ test_expect_success '__git_find_repo_path - "git -C" while .git directory in par
 test_expect_success '__git_find_repo_path - non-existing path in "git -C"' '
 	(
 		__git_C_args=(-C non-existing) &&
-		test_must_fail __git_find_repo_path &&
+		! __git_find_repo_path &&
 		printf "$__git_repo_path" >"$actual"
 	) &&
 	test_must_be_empty "$actual"
@@ -303,7 +303,7 @@ test_expect_success '__git_find_repo_path - non-existing path in "git -C"' '
 test_expect_success '__git_find_repo_path - non-existing path in $__git_dir' '
 	(
 		__git_dir="non-existing" &&
-		test_must_fail __git_find_repo_path &&
+		! __git_find_repo_path &&
 		printf "$__git_repo_path" >"$actual"
 	) &&
 	test_must_be_empty "$actual"
@@ -313,7 +313,7 @@ test_expect_success '__git_find_repo_path - non-existing $GIT_DIR' '
 	(
 		GIT_DIR="$ROOT/non-existing" &&
 		export GIT_DIR &&
-		test_must_fail __git_find_repo_path &&
+		! __git_find_repo_path &&
 		printf "$__git_repo_path" >"$actual"
 	) &&
 	test_must_be_empty "$actual"
@@ -362,7 +362,7 @@ test_expect_success '__git_find_repo_path - not a git repository' '
 		cd non-repo &&
 		GIT_CEILING_DIRECTORIES="$ROOT" &&
 		export GIT_CEILING_DIRECTORIES &&
-		test_must_fail __git_find_repo_path &&
+		! __git_find_repo_path &&
 		printf "$__git_repo_path" >"$actual"
 	) &&
 	test_must_be_empty "$actual"
@@ -381,7 +381,7 @@ test_expect_success '__gitdir - finds repo' '
 test_expect_success '__gitdir - returns error when cannot find repo' '
 	(
 		__git_dir="non-existing" &&
-		test_must_fail __gitdir >"$actual"
+		! __gitdir >"$actual"
 	) &&
 	test_must_be_empty "$actual"
 '
@@ -608,7 +608,7 @@ test_expect_success '__git_is_configured_remote' '
 	git remote add remote_2 git://remote_2 &&
 	(
 		verbose __git_is_configured_remote remote_2 &&
-		test_must_fail __git_is_configured_remote non-existent
+		! __git_is_configured_remote non-existent
 	)
 '
 
-- 
2.26.0.159.g23e2136ad0

