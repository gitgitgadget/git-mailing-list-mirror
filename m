Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E40C4727E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3397423A65
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8G0vlk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgIUW2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgIUW2X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:28:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCB5C0613CF
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:28:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so1170290wmm.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N1aKWXY0SAWuJiMsJidrglqsDE4gYGStmnyHDHPLyVg=;
        b=S8G0vlk+T4rQUlkxwRzBksBp6sCEMgMSnRd4vDfxOQsYL+DyEFzbChsEU2G9ubhG9T
         bk3Ug2f5YM3x6Y+fZXqC5p46Yp1NRp9x0CqeycN6zoliUfgvM5Z5GpbxiblfLvyU7Zlk
         nz1lNrl7m5tMNnw0uoJmQGROOqw2+RKfFxOzoU5/YAZSBbg7ztzUGsZt8DHOQs8t9YH2
         a/1EDfzkWXzRuWAeZ7aiCP3Kdh9zfhyF3QhQtfOSOgVpAQuFZXC29a/aTlw8RVOx5KxA
         L+xHKyCL/BKjXEt1Z5qQEHKTBZYrvKV1C4k36WPuSWOAzG6UKEIoURH3sWN5VZcu1d0N
         a2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N1aKWXY0SAWuJiMsJidrglqsDE4gYGStmnyHDHPLyVg=;
        b=I/fo1stGBsBAosjGOQrqzflLFFio4nyOlMJpiR4/q1+M47CJzc21Th+RmeitHJRn2g
         TbP3RXBX+QTmyokEa1kIGoNfLRthx+mTLYsUhO/cbJfV+ZHshQU/zVYnOIhSKgES3wQy
         sDZ5H74aOwiow7lv1GK2IOl/D249pDTrbYxzIeznNn+7Xg/M+S8HWdOAsyf/EGgsInQn
         CgDubSz+Be5AZL55+emqn9ihNDXHfFnW8ja/DDdDl29vP3yNqzcOZjS5/Y7hHkNLKsSL
         3EnKDjhTcVrekHgiuUm9ImTyesdAIp1YZEJqIe+ejgqxFzM1kONPMq47CFYMTZngJSzJ
         QMeg==
X-Gm-Message-State: AOAM531rRpg+6pq2BSX2/Q7d23mm97AohNUK+xVttsj2/4NqL5sjcH5d
        P1GOKb0C3oIz2vnkREPAUdlrV9lQ4Ew=
X-Google-Smtp-Source: ABdhPJxuLHg68Yi5h37jDBgzvXLiaRU+PEe5IqnHRJtcxoHp6uDJEVpk8wZWzM3gvBifL7zoDZy9og==
X-Received: by 2002:a1c:544c:: with SMTP id p12mr1379951wmi.170.1600727301770;
        Mon, 21 Sep 2020 15:28:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm23948265wrp.85.2020.09.21.15.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:28:21 -0700 (PDT)
Message-Id: <1fdf24af368ccb263ade2af2e482221280a3eb06.1600727298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.v4.git.1600727297.gitgitgadget@gmail.com>
References: <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
        <pull.411.v4.git.1600727297.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 22:28:17 +0000
Subject: [PATCH v4 3/3] ci: stop linking built-ins to the dashed versions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since e4597aae6590 (run test suite without dashed git-commands in PATH,
2009-12-02), we stopped running our tests with `git-foo` binaries found
at the top-level directory of a freshly built source tree; instead we
have placed only `git` and selected `git-foo` commands that must be on
`$PATH` in `bin-wrappers/` and prepended that `bin-wrappers/` to the
`PATH` used in the test suite. We did that to catch the tests and
scripted Git commands that still try to use the dashed form.

Since CI jobs will not install the built Git to anywhere, and the
hardlinks we make at the top-level of the source tree for `git-add` and
friends are not even used during tests, they are pure waste of resources
these days.

Thanks to the newly invented `SKIP_DASHED_BUILT_INS` knob, we can now
skip creating these links in the source tree. So let's do that.

Note that this change introduces a subtle change of behavior: when Git's
`cmd_main()` calls `setup_path()`, it inserts the value of
`GIT_EXEC_PATH` (defaulting to `<prefix>/libexec/git-core`) at the
beginning of the environment variable `PATH`. This is necessary to find
e.g. scripted commands that are installed in that location. For the
purposes of Git's test suite, the `bin-wrappers/` scripts override
`GIT_EXEC_PATH` to point to the top-level directory of the source code.

In other words, if a scripted command had used a dashed invocation of a
built-in Git command, it would not have been caught previously, which is
fixed by this change.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 3eefec500d..821e3660d6 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -178,6 +178,7 @@ fi
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
+export SKIP_DASHED_BUILT_INS=YesPlease
 
 case "$jobname" in
 linux-clang|linux-gcc)
-- 
gitgitgadget
