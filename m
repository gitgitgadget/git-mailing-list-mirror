Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F5C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 20:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B4B6121F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 20:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhHUUAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhHUUAu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 16:00:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8138C061575
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 13:00:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l6so1740768wmq.5
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IKyI8QHzbJHtkeqr8kexFGucLHTGqynFWLVA6FWy8lo=;
        b=gpgvdfNKYKCbiNBTecJ95sg3LCX679EnrQ6N26zH3Iy5mIsaJtox+rLcSuTJ5MkgIa
         dCUnEZPYht3J/eo+zu2I8C5YEuu38hSeMOWpB/tTiuyyWMKyZuflQF7zjtkmseiwGCmY
         X0SZPT6QF2jYhzbL19oaDnr423grULU1mil0AiF11803icV9co5+y1Qo2qWYmAuz6bSI
         kSQlpwZCu5Hdqg+s5Uophw4Mgd/PdpH3uvcHFOAuLyOr93HNvw2R5Kx/o3tspokkrYhW
         o40VHn054XgcHY9TawjDKLh1033klQl7xG7KSnbioLTr/PIBPn6skULBHRHj382GyFhX
         Yu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IKyI8QHzbJHtkeqr8kexFGucLHTGqynFWLVA6FWy8lo=;
        b=TN4YiNusADInKccsJ3QXGaFGPuMg5xlxnfsF4A2lHyfExCQhx5e4oHyI10zgmtANPd
         RWuyx1cTILjmDuiO6dgoijzfPUd/DYrp0l++cLGjB1kvtJIYcASzrLHXK/WsR2nGjZKE
         LxO07GYqOjVnbXvO17r2rOOExhvhyU+AqGhkRMB9pfLazMe3mtKJMF8z07AQ4xdNqYLR
         jn7Aq/5EEGZfoIILEWwg3NYd2ezKRW/ZciPN+dcAg14V2AuOrj9KX3wdmvBBZWxifsL+
         L6hcqwmyrYo9XryegAN5n55QoURFpb5+4b6HL3/DVKXo9YaW/G5gNO8Xbn3RupKkkSOP
         MnkQ==
X-Gm-Message-State: AOAM5338b5q7GlJDzL+3ZCjfXqMs6RligxtTI1P52Z/e4w00xmwVo5Nu
        v+FEufCk/cnAVocHsn/tquHwqsWo6Vo=
X-Google-Smtp-Source: ABdhPJwh+rsCOoLp/S8jONXBUJyP0uri+Ifm5tbFdhhILN7HUSka8vsYg5unBn3UR4euc6kMlR1zAg==
X-Received: by 2002:a05:600c:198a:: with SMTP id t10mr9468988wmq.181.1629576008995;
        Sat, 21 Aug 2021 13:00:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm9875885wrv.84.2021.08.21.13.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 13:00:08 -0700 (PDT)
Message-Id: <pull.1069.git.git.1629576007891.gitgitgadget@gmail.com>
From:   "Rafael Santiago via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Aug 2021 20:00:07 +0000
Subject: [PATCH] Give support for hooks based on platform
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rafael Santiago <voidbrainvoid@tutanota.com>,
        rafael-santiago <voidbrainvoid@tutanota.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: rafael-santiago <voidbrainvoid@tutanota.com>

The idea behind this commit can be useful for teams
that share git-hooks into a custom directory and
dealing with projects that must be developed,
built, maintained on several different platforms.

This commit allows the execution of git hooks
based on the current operating system.
A "native hook" is defined in the form:
    hooks/hook-name_platform
Where platform must be equivalent to the
content returned in sysname field in utsname
struct when calling uname() [but all normalized
in lowercase].

On Windows, independent of version, flavor, SP,
whatever it is simply "windows".

When a native hook is not found the standard
hook (.git/hook/hook-name), if found is executed,
of course. In other words, the hook without a
platform postfix (_yyz) is the standard hook.
When native hook is not set as executable but
standard is set, the standard will be executed.

The main motivation of this extension is to
reduce dependency of scripting languages,
logical trinkets etc just to execute minor
tasks during scm events that could be done
natively but differently from a platform
to another. Less dependencies, cleaner
repos: a small step for a better world
for any software developer.

Signed-off-by: Rafael Santiago <voidbrainvoid@tutanota.com>
---
    Give support for hooks based on platform
    
    The idea behind this commit can be useful for teams that share git-hooks
    into a custom directory and dealing with projects that must be
    developed, built, maintained on several different platforms.
    
    This commit allows the execution of git hooks based on the current
    operating system. A "native hook" is defined in the form:
    hooks/hook-name_platform
    
    Where platform must be equivalent to the content returned in sysname
    field in utsname struct when calling uname() [but all normalized in
    lowercase].
    
    On Windows, independent of version, flavor, SP, whatever it is simply
    "windows".
    
    When a native hook is not found the standard hook (.git/hook/hook-name),
    if found is executed, of course. In other words, the hook without a
    platform postfix (_yyz) is the standard hook. When native hook is not
    set as executable but standard is set, the standard will be executed.
    
    The main motivation of this extension is to reduce dependency of
    scripting languages, logical trinkets etc just to execute minor tasks
    during scm events that could be done natively but differently from a
    platform to another. Less dependencies, cleaner repos: a small step for
    a better world for any software developer.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1069%2Frafael-santiago%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1069/rafael-santiago/master-v1
Pull-Request: https://github.com/git/git/pull/1069

 run-command.c                     | 41 ++++++++++++++++++++
 t/t7527-pre-commit-native-hook.sh | 63 +++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100755 t/t7527-pre-commit-native-hook.sh

diff --git a/run-command.c b/run-command.c
index f72e72cce73..973c1a3434b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1319,9 +1319,50 @@ int async_with_fork(void)
 #endif
 }
 
+static inline const char *platform_name(void)
+{
+	static const char *platform = NULL;
+#ifndef GIT_WINDOWS_NATIVE
+	static struct utsname un = { 0 };
+#endif
+	if (platform != NULL)
+		return platform;
+
+#ifndef GIT_WINDOWS_NATIVE
+	if (uname(&un) == 0) {
+		for (size_t s = 0; un.sysname[s] != 0; s++)
+			un.sysname[s] = tolower(un.sysname[s]);
+		platform = un.sysname;
+	}
+#else
+    platform = "windows";
+#endif
+
+    return platform;
+}
+
+static const char *find_native_hook(const char *name)
+{
+	char native_name[64] = "";
+	const char *platform = NULL;
+	if (name == NULL || strstr(name, "_") != NULL)
+		return NULL;
+
+	platform = platform_name();
+	if (platform == NULL)
+		return NULL;
+
+	if (snprintf(native_name, sizeof(native_name) - 1, "%s_%s", name, platform) >= sizeof(native_name) - 1)
+		return NULL;
+	return find_hook(native_name);
+}
+
 const char *find_hook(const char *name)
 {
+	const char *native_hook = find_native_hook(name);
 	static struct strbuf path = STRBUF_INIT;
+	if (native_hook != NULL)
+		return native_hook;
 
 	strbuf_reset(&path);
 	strbuf_git_path(&path, "hooks/%s", name);
diff --git a/t/t7527-pre-commit-native-hook.sh b/t/t7527-pre-commit-native-hook.sh
new file mode 100755
index 00000000000..f3835f943af
--- /dev/null
+++ b/t/t7527-pre-commit-native-hook.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='Test native hooks extension'
+
+. ./test-lib.sh
+
+expected_platform=$(uname -s | tr A-Z a-z)
+
+if [ $(expr substr $(uname -s | tr A-Z a-z) 1 5) == "mingw" ] ; then
+    expected_platform="windows"
+fi
+
+test_expect_success 'set standard and native pre-commit hooks' '
+	mkdir -p test-repo &&
+	cd test-repo &&
+	git init &&
+	mkdir -p .git/hooks &&
+	echo \#!/bin/sh > .git/hooks/pre-commit &&
+	echo echo Hello generic. >> .git/hooks/pre-commit &&
+	chmod u+x .git/hooks/pre-commit &&
+	echo \#!/bin/sh > .git/hooks/pre-commit_${expected_platform} &&
+	echo echo Hello ${expected_platform} >> .git/hooks/pre-commit_${expected_platform} &&
+	chmod u+x .git/hooks/pre-commit_${expected_platform} &&
+	echo test > README &&
+	git add README &&
+	git commit -am "1-2-3 this is a test." 2>out.txt &&
+	cat out.txt | grep Hello\ ${expected_platform}
+'
+
+if [ ${expected_platform} != "windows" ] ; then
+	# chmod does not work well on Windows.
+	test_expect_success 'set standard and native pre-commit hooks but let the native one not executable' '
+		mkdir -p test-repo &&
+		cd test-repo &&
+		git init &&
+		mkdir -p .git/hooks &&
+		echo \#!/bin/sh > .git/hooks/pre-commit &&
+		echo echo Hello generic. >> .git/hooks/pre-commit &&
+		chmod u+x .git/hooks/pre-commit &&
+		echo \#!/bin/sh > .git/hooks/pre-commit_${expected_platform} &&
+		echo echo Hello ${expected_platform} >> .git/hooks/pre-commit_${expected_platform} &&
+		echo test > README &&
+		git add README &&
+		git commit -am "1-2-3 this is a test." 2>out.txt &&
+		cat out.txt | grep Hello\ generic
+	'
+
+	test_expect_success 'set standard pre-commit hook only' '
+		mkdir -p test-repo &&
+		cd test-repo &&
+		git init &&
+		mkdir -p .git/hooks &&
+		echo \#!/bin/sh > .git/hooks/pre-commit &&
+		echo echo Hello standard hook. >> .git/hooks/pre-commit &&
+		chmod u+x .git/hooks/pre-commit &&
+		echo test > README &&
+		git add README &&
+		git commit -am "1-2-3 this is a test." 2>out.txt &&
+		cat out.txt | grep Hello\ standard\ hook
+	'
+fi
+
+test_done

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
gitgitgadget
