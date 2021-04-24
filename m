Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DC9C433B4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 21:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25712613DB
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhDXVWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 17:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhDXVWS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 17:22:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DE4C061574
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 14:21:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y204so26503426wmg.2
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8LHANjFSkTtEfFeupJMQQkowgfeubKNgNuz07c75MY=;
        b=CLapS4KfhEgAFNqGTp5J8Jn1fu8NrjmXkc7SiSpSwzMs/7WVNYpoVmelZQYztmnv3b
         S+uVbvMfpKO7fhiv3Q5W8THPstR0T5fir82Z53L12bdiFLVDx8N1EGWgPXMmj57E/vwA
         VAUu3lrJFqO3woGd/yQ8OO1up/4kPnmyQ5kbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8LHANjFSkTtEfFeupJMQQkowgfeubKNgNuz07c75MY=;
        b=Slb06IvbAVKlEj0xmPsBjc5TaH7lu0GKvqMsrVamK2gbGl5NJcl1xZ/wYXwhmplkeT
         Y5WQKg0s8i55wiVd4iTmurmCthuUvNRACkvZY1LSJnuWANJpUZzA58PiI1VbHS4nLled
         xyIxBP3B83z1tzvBVKHTPAzxQmPCFTlpacQ5v5ztRwfEPD2GMN4UB2gidBycxfV7k9Jg
         8fOd/kl18PGJYAi5F4UDeHZSvLT+v7uh5qDSX66kOrEwAhu38lkPkCmADxWVAzQQxDV3
         pu24Wx6Xd6DY0nQa1OG/P7UJkrT41ixwCatctFbVBXoKqB+5A6uWUDSDDNvXjDt3GzQu
         MDiQ==
X-Gm-Message-State: AOAM5332O+zx6y/1XJF8vDO5WcB43CgrdBJhZKBngaIckdksDpU7h8Lk
        QQ/i6809xMDW87NxQ9VkAoDezxEqxSfsYA==
X-Google-Smtp-Source: ABdhPJwEIePyzZysHpWhm/NknAd1oTxaDCrgaElOlIOby+5QBSgWBiHFe/Mr/RMG75dPZnoO61t2bw==
X-Received: by 2002:a1c:f708:: with SMTP id v8mr12631380wmh.133.1619299298354;
        Sat, 24 Apr 2021 14:21:38 -0700 (PDT)
Received: from localhost.localdomain (2.2.6.f.a.a.a.9.7.c.e.6.6.c.4.e.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:de15:20ad:e4c6:6ec7:9aaa:f622])
        by smtp.gmail.com with ESMTPSA id u2sm14164082wmc.22.2021.04.24.14.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 14:21:37 -0700 (PDT)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     RyotaK <security@ryotak.me>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH] cygwin: disallow backslashes in file names
Date:   Sat, 24 Apr 2021 22:21:17 +0100
Message-Id: <20210424212117.6165-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The backslash character is not a valid part of a file name on Windows,
so it should not be possible to write files that were unpacked from tree
objects where the stored filename contains a backslash character, as it
will be interpreted as a directory separator.

This caused CVE-2019-1354 in mingw, which was fixed by e1d911dd4c
("mingw: disallow backslash characters in tree objects' file names",
2019-09-12), however the vulnerability also exists in Cygwin, as while
Cygwin mostly provides a POSIX-like path system, it will also interpret
a backslash as a directory separator in the name of compatibility.

To avoid the vulnerability, extend the fix for mingw to also apply to
Cygwin.

Reported-by: RyotaK <security@ryotak.me>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---

Notes:
    The patch to read-cache.c is the one I've applied downstream as the Cygwin Git
    maintainer to resolve this vulnerability, and I've manually tested that it
    resolves the vulnerability, so that's the change I'd recommend anyone who needs
    to build Git on Cygwin themselves take until there's something officially in
    the Git source code.
    
    I'm much less convinced by my approach for the test script.  I definitely think
    it's worth having a test here, but the test as written still fails, as the test
    seems to be looking for the error message "directory not empty", but running
    the test on Cygwin produces the error "cannot create submodule directory d\a".
    I'm not sure why that difference exists, and whether the correct approach would
    be to (a) ensure the error messages are consistent across platforms or (b) to
    change the test to expect the appropriate error on the appropriate platform.
    
    I'm also not convinced by my approach of adding a "WINDOWS" prerequisite to
    test-lib.sh. I went with this as I couldn't immediately see a way to pass
    prerequisites on an "any" rather than "all" basis to test_expect_success, and
    this would allow us to simplify all the tests that currently have
    "!MINGW,!CYGWIN" as prerequisites, but it still feels a bit clunky to me.

 read-cache.c               | 2 +-
 t/t7415-submodule-names.sh | 2 +-
 t/test-lib.sh              | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

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
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index f70368bc2e..6505bc2085 100755
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
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3dec266221..adaa2db601 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1459,14 +1459,16 @@ case $uname_s in
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
-- 
2.31.1

