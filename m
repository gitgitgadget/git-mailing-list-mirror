Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7D3C5519F
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 04:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEF720663
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 04:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FliLTo2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgK3EoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 23:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgK3EoM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 23:44:12 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5184EC0613D3
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 20:43:32 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id y9so10058551ilb.0
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 20:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSBxeYQc6G+9cjtf2oMnEXtouJnD0TkJkn6VAe/HxZ8=;
        b=FliLTo2r0yDaVa+4jFcqJO90CEpC+Pl79hylIl74r1N7kTDgsak4uUs5OJD7xcgKE5
         NaP+N7hTPcSbco2wdu6unAjaV1bSFpqegdRSe1SVw9x88FuPyv1e5Q0cSH6lbJMhp7bY
         PAVX8syizx54aO0gbjCCy6U3uPM6jDfLJTDodTvcx6U/1S8ugWNDrIdMWtKPQgRGhd3J
         yDLqyGKx5n+uu3NNE2GSxvei/uzGr9el5SHoJOP6mYARLWtsgQHEOrE9hlkDxUEG4rDn
         j6mYNYKg4lF4V33ZZ6/Op+LbkDyO9Zcg9UjnSI5CCRJwU6Vc7jrR0TVlH0ZuAj8VfyRq
         +M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FSBxeYQc6G+9cjtf2oMnEXtouJnD0TkJkn6VAe/HxZ8=;
        b=VSSQrlEG2hWkdEW1++LNqJg6rLTFyVq7DJpGq7SLlAN5lJ5mNvR2OucYwzfctjnN+n
         beHL762dHkSaqSElzFnxf1+9RPWxd8Gp/egW7NxiRI3Wd3lHsTqGzctdZ5QWBPyKK3k5
         1I9Y7HOcf3pnojr2wv/HM7wX926rinA1h1MAPTiqn9J0gd4dFRTmssYfESZLR8WScSLF
         hi7mjmZd4fc5MAbM7W+M8g/OIq77F3+7jVWKLRb4FeuhySV3tn7bleVqh0ic47NsalmD
         KMN07SbDFp06ErbB1SY+L83oyKMXIRFNcgJFM/uCZbgFMFjzCMxfVjbBOdJozHo1pVEC
         l7hQ==
X-Gm-Message-State: AOAM533eECF2PuTYQS3smTeiwkXUiH7Ahl99V/sNosmM/0FN3YmaLhW4
        XVWpvy034WdsDBbgBa4DN9V+0F3o7ao=
X-Google-Smtp-Source: ABdhPJxuBpwAIKQOUeegjeu2vBJupVKpqYI1nYCgSQEGj3uC2OX/MNzbWcrYGw188/x7E6udaFTMEA==
X-Received: by 2002:a92:2005:: with SMTP id j5mr12196368ile.271.1606711409527;
        Sun, 29 Nov 2020 20:43:29 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id h16sm9754285ile.14.2020.11.29.20.43.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 20:43:28 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/2] t7900: make macOS-specific test work on Windows
Date:   Sun, 29 Nov 2020 23:42:24 -0500
Message-Id: <20201130044224.12298-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84
In-Reply-To: <20201130044224.12298-1-sunshine@sunshineco.com>
References: <20201130044224.12298-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `git maintenance start` and `git maintenance stop` necessarily
invoke platform-specific scheduling utilities, their related tests have
been carefully crafted -- with one minor exception -- to work correctly
on any platform, thus improving overall coverage. The exception is that
the macOS-specific test fails on Windows due to non-portable use of
`$(id -u)` and comparison involving the value of $HOME.

In particular, on Windows, the value of getuid() called by the C code is
not guaranteed to be the same as `$(id -u)` invoked by the test. This is
because `git.exe` is a native Windows program, whereas the utility
programs run by the test script mostly utilize the MSYS2 runtime, which
emulates a POSIX-like environment. Since the purpose of the test is to
check that the input to the hook is well-formed, the actual user ID is
immaterial, thus we can work around the problem by making the the test
UID-agnostic.

As for comparison of $HOME, it suffers from the typical shortcoming on
Windows in which the same path may be represented two different ways
depending upon its source (i.e. as a Windows path
`C:/git-sdk-64/usr/src/git/foo` versus as a Unix path
`/usr/src/git/foo`).

Fix both problems and drop the !MINGW prerequisite from the
macOS-specific test, thus allowing the test to run on Windows, as well.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7900-maintenance.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ef3aec3253..514977a838 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -408,11 +408,12 @@ test_expect_success 'start preserves existing schedule' '
 	grep "Important information!" cron.txt
 '
 
-test_expect_success !MINGW 'start and stop macOS maintenance' '
-	uid=$(id -u) &&
+test_expect_success 'start and stop macOS maintenance' '
+	# ensure $HOME can be compared against hook arguments on all platforms
+	pfx=$(cd "$HOME" && pwd) &&
 
 	write_script print-args <<-\EOF &&
-	echo $* >>args
+	echo $* | sed "s:gui/[0-9][0-9]*:gui/[UID]:" >>args
 	EOF
 
 	rm -f args &&
@@ -432,11 +433,11 @@ test_expect_success !MINGW 'start and stop macOS maintenance' '
 	rm -f expect &&
 	for frequency in hourly daily weekly
 	do
-		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
+		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
 		test_xmllint "$PLIST" &&
 		grep schedule=$frequency "$PLIST" &&
-		echo "bootout gui/$uid $PLIST" >>expect &&
-		echo "bootstrap gui/$uid $PLIST" >>expect || return 1
+		echo "bootout gui/[UID] $PLIST" >>expect &&
+		echo "bootstrap gui/[UID] $PLIST" >>expect || return 1
 	done &&
 	test_cmp expect args &&
 
@@ -446,7 +447,7 @@ test_expect_success !MINGW 'start and stop macOS maintenance' '
 	# stop does not unregister the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
 
-	printf "bootout gui/$uid $HOME/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
+	printf "bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
 		hourly daily weekly >expect &&
 	test_cmp expect args &&
 	ls "$HOME/Library/LaunchAgents" >actual &&
-- 
2.29.2.576.ga3fc446d84

