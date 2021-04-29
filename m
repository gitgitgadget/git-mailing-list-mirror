Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872A4C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 20:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535C1613B3
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 20:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbhD2UNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhD2UNR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 16:13:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FEAC06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 13:12:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l189-20020a1cbbc60000b0290140319ad207so499042wmf.2
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/lNIcHhWPRYnLvaq6HFoSbvcYrdxQYpSJIgp/ge+fA=;
        b=mGunAhc03NcTVFMSmAY2SqMy6wgN8bN9R+b47IbVdgxsXGjODAvYZA/FlJeP/KT2OL
         ZN3ApjmwyD6up9D4rUitoGA4QDx4zXUJMeGfmVT9UpTACc8LmgjrobaoJKDFZu9zELMy
         QuchA6AehfuxuVvIHApeML00rt20OAVhCFAGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/lNIcHhWPRYnLvaq6HFoSbvcYrdxQYpSJIgp/ge+fA=;
        b=c+85r8xCTXLL9JelPQyqheN/b5wvJbi9+tmB65NeqzNdxyExeTfrU3c/oXKcPzNgv3
         DWqrMGfwIqrOaiVErhCoBcgSRM5+pkA8y1Nd+fE+cykJUCG1Tnu0Cy7Iq24jt8dNTBoQ
         2upA5Lm1doDEjLCR6Mi9JWIlLsUh4S67lLuHBo6nrzxMIvcF712K7ISntwAPRwOV48Fs
         UmzPe7Fid2aBKugg4pa1JVAaD347qlCVQR0f4QbIS1pjI1gQhyEI4DkmOBskj/0gWrW7
         qWyG6zVwndS37NwnxFg09SfZIt/xyRNpZIlYlRqvUH6K5q6WXIejH0zxgRd2CLjUxL3a
         xgsQ==
X-Gm-Message-State: AOAM532UfZxRvvYG9tyY+Kghgthw21mmUA/S2oYWeFn5gKQ+sr7+RyrC
        UtXytVUf8Evn33eIvkgELrjTuW32cyX1RA==
X-Google-Smtp-Source: ABdhPJxdHSXq4IAEXQpjFBWoUab6YMgKpPAZHEq8vvbBlOKPSF9vYXzI54Kd5u+dO5J4VSqJ9rypdQ==
X-Received: by 2002:a05:600c:3545:: with SMTP id i5mr1978199wmq.121.1619727147398;
        Thu, 29 Apr 2021 13:12:27 -0700 (PDT)
Received: from localhost.localdomain (5.7.2.e.4.d.4.e.9.f.6.0.2.1.8.b.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:de15:20ad:b812:6f9:e4d4:e275])
        by smtp.gmail.com with ESMTPSA id g5sm6154377wrq.30.2021.04.29.13.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 13:12:26 -0700 (PDT)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     RyotaK <security@ryotak.me>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] cygwin: disallow backslashes in file names
Date:   Thu, 29 Apr 2021 21:11:44 +0100
Message-Id: <20210429201144.8936-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210424212117.6165-1-adam@dinwoodie.org>
References: <20210424212117.6165-1-adam@dinwoodie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The backslash character is not a valid part of a file name on Windows.
If, in Windows, Git attempts to write a file that has a backslash
character in the filename, it will be incorrectly interpreted as a
directory separator.

This caused CVE-2019-1354 in MinGW, as this behaviour can be manipulated
to cause the checkout to write to files it ought not write to, such as
adding code to the .git/hooks directory.  This was fixed by e1d911dd4c
(mingw: disallow backslash characters in tree objects' file names,
2019-09-12).  However, the vulnerability also exists in Cygwin: while
Cygwin mostly provides a POSIX-like path system, it will still interpret
a backslash as a directory separator.

To avoid this vulnerability, CVE-2021-29468, extend the previous fix to
also apply to Cygwin.

Similarly, extend the test case added by the previous version of the
commit.  The test suite doesn't have an easy way to say "run this test
if in MinGW or Cygwin", so add a new test prerequisite that covers both.

As well as checking behaviour in the presence of paths containing
backslashes, the existing test also checks behaviour in the presence of
paths that differ only by the presence of a trailing ".".  MinGW follows
normal Windows application behaviour and treats them as the same path,
but Cygwin more closely emulates *nix systems (at the expense of
compatibility with native Windows applications) and will create and
distinguish between such paths.  Gate the relevant bit of that test
accordingly.

Reported-by: RyotaK <security@ryotak.me>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 read-cache.c               |  2 +-
 t/test-lib.sh              |  2 ++
 t/t7415-submodule-names.sh | 13 ++++++++-----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 5a907af2fb..b6c13bc04e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -985,7 +985,7 @@ int verify_path(const char *path, unsigned mode)
 				}
 			}
 			if (protect_ntfs) {
-#ifdef GIT_WINDOWS_NATIVE
+#if defined GIT_WINDOWS_NATIVE || defined __CYGWIN__
 				if (c == '\\')
 					return 0;
 #endif
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d3f6af6a65..e84b8c87f9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1457,14 +1457,16 @@ case $uname_s in
 	test_set_prereq NATIVE_CRLF
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
+	test_set_prereq WINDOWS
 	GIT_TEST_CMP=mingw_test_cmp
 	;;
 *CYGWIN*)
 	test_set_prereq POSIXPERM
 	test_set_prereq EXECKEEPSPID
 	test_set_prereq CYGWIN
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
+	test_set_prereq WINDOWS
 	;;
 *)
 	test_set_prereq POSIXPERM
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index f70368bc2e..6bf098a6be 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -191,7 +191,7 @@ test_expect_success 'fsck detects corrupt .gitmodules' '
 	)
 '
 
-test_expect_success MINGW 'prevent git~1 squatting on Windows' '
+test_expect_success WINDOWS 'prevent git~1 squatting on Windows' '
 	git init squatting &&
 	(
 		cd squatting &&
@@ -219,10 +219,13 @@ test_expect_success MINGW 'prevent git~1 squatting on Windows' '
 		test_tick &&
 		git -c core.protectNTFS=false commit -m "module"
 	) &&
-	test_must_fail git -c core.protectNTFS=false \
-		clone --recurse-submodules squatting squatting-clone 2>err &&
-	test_i18ngrep -e "directory not empty" -e "not an empty directory" err &&
-	! grep gitdir squatting-clone/d/a/git~2
+	if test_have_prereq MINGW
+	then
+		test_must_fail git -c core.protectNTFS=false \
+			clone --recurse-submodules squatting squatting-clone 2>err &&
+		test_i18ngrep -e "directory not empty" -e "not an empty directory" err &&
+		! grep gitdir squatting-clone/d/a/git~2
+	fi
 '
 
 test_expect_success 'git dirs of sibling submodules must not be nested' '
-- 
2.31.1

