Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8546BC433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356936AbiASS4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 13:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiASS4F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 13:56:05 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5164C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 10:56:04 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay14-20020a05600c1e0e00b0034d7bef1b5dso9726617wmb.3
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 10:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=JfI4aodv7CK9qDyeGvhs24tmHnBPER84sQR6uua1igk=;
        b=HR56GGQ73LM1S8yByz1FkuLqxAu4Z88J+t658NrnnX7j9B4dFOU2PXstdfvxdGlT+v
         6B1vA9h0+UFUQGDZVLpTl2K9cc6Ll/WAa9NCfSZ7DraZ0O+Ugm7AiAvNWB1xoyiQf1cE
         Wge3P1O0pVuWQyk0LASs5sOcbvVm5Xm5DMZu7Qmwc3xf5/8J2+XMEG+5wYy+jd0UvXFq
         8mOPBcgngq3HgvZ6hkJXr9dAcfRpox+r0Cdu2l2vi9oGXAsoZNZLuEJYYMI0A3n8mEBK
         Y8C+YIMWyCykyHUNc515GKAvXBnvDvpS2o+NxQTGuGKBLmHHlK3Ap9mss1jMzeGpF1ZB
         sp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JfI4aodv7CK9qDyeGvhs24tmHnBPER84sQR6uua1igk=;
        b=lcUGKsUrb80XqbeVcymIOAfTsXeXa5p3PX/236b67nie0M38b4bOZDoYpiP554gbC5
         zCJRIoWuNsL4Bda3gqzeuH/lgWjkSuxWJn6aoYh+1XcGatBG319QpioE1nEVsXLM0ONz
         fYbjRAxL7ivem8Aso/xpiM8AqA03gSV7UFpe3qFq0TyzURHgoluzlHCCTgxKziZQBx3n
         jywMiyGBiAeNMUg3xPCIUb3AphwXpiygHjlfqD7LcU/1VNceppyLCkuZaxXZs8bhW8mo
         +Z+RIDWvLFF629W8rQe8YxTp/aR05dgNRFw4vD3vMNR2q9BUqGOSnx0fXB2QaGXJrq20
         QNvg==
X-Gm-Message-State: AOAM533U6GnNxCyAb0ry4uC0WHQZScP5ZaMPTkewRbakLTJ1U85TJiZ3
        Cl1KqLgW2n9/l2/W5YJPqPYAqlhKeOA=
X-Google-Smtp-Source: ABdhPJx7MxtdP18naLgIsV+VApgtKNivyPGpbcVPcd1UtA5w2TvOT2/76LaUAeDxqVlSbLij7gyw1g==
X-Received: by 2002:a5d:4e51:: with SMTP id r17mr30315718wrt.444.1642618563261;
        Wed, 19 Jan 2022 10:56:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm362786wmm.32.2022.01.19.10.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 10:56:02 -0800 (PST)
Message-Id: <pull.1120.git.1642618562012.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Jan 2022 18:56:01 +0000
Subject: [PATCH] getcwd(mingw): handle the case when there is no cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A recent upstream topic introduced checks for certain Git commands that
prevent them from deleting the current working directory, introducing
also a regression test that ensures that commands such as `git version`
_can_ run without a current working directory.

While technically not possible on Windows via the regular Win32 API, we
do run the regression tests in an MSYS2 Bash which uses a POSIX
emulation layer (the MSYS2/Cygwin runtime) where a really evil hack
_does_ allow to delete a directory even if it is the current working
directory.

Therefore, Git needs to be prepared for a missing working directory,
even on Windows.

This issue was not noticed in upstream Git because there was no caller
that tried to discover a Git directory with a deleted current working
directory in the test suite. But in the microsoft/git fork, we do want
to run `pre-command`/`post-command` hooks for every command, even for
`git version`, which means that we make precisely such a call. The bug
is not in that `pre-command`/`post-command` feature, though, but in
`mingw_getcwd()` and needs to be addressed there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    getcwd(mingw): handle the case when there is no current working
    directory
    
    The bug fixed by this topic was noticed due to test failures while
    rebasing Microsoft's fork of Git onto v2.35.0-rc1. It may not be
    desirable to take it into Git v2.35.0 this late in the -rc phase, even
    though I do plan on integrating it into Git for Windows v2.35.0
    [https://github.com/git-for-windows/git/pull/3641].

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1120%2Fdscho%2Fmingw-getcwd-without-cwd-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1120/dscho/mingw-getcwd-without-cwd-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1120

 compat/mingw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 640dcb11de0..03af369b2b9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1127,6 +1127,10 @@ char *mingw_getcwd(char *pointer, int len)
 	}
 	if (!ret || ret >= ARRAY_SIZE(wpointer))
 		return NULL;
+	if (GetFileAttributesW(wpointer) == INVALID_FILE_ATTRIBUTES) {
+		errno = ENOENT;
+		return NULL;
+	}
 	if (xwcstoutf(pointer, wpointer, len) < 0)
 		return NULL;
 	convert_slashes(pointer);

base-commit: af4e5f569bc89f356eb34a9373d7f82aca6faa8a
-- 
gitgitgadget
