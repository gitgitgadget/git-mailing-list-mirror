Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E07CC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD83320738
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2MjG+Hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgHXPm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgHXPj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 11:39:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA90C061799
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:38:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u18so8795552wmc.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BHkZfIp3eJUJmbeT+kunhu5i+hXVqYxZSG+YbLVhMT8=;
        b=Z2MjG+Hqejh0M3CpDCGOyeOoOrWEuaCfTJedCjzhXiq59clTwIWwS+DEvtxUbs4I++
         Gl6CS2uTcin2yzWi/bb7jH+kkMTVSel9MUIA4+opP+7b0E7V/ebCAVVfS/xG4y7ma9ey
         htuYyMkMYS9w7cyEy2/E2ezdjFeUG2lsm5oreiobDghLS/3taxTyyf+YG2OdoOHirfLT
         boUesAwUKfZUaIXdm7Wn9nlRg6O5Sg5PKaJnUIsKrZo9j7HEPh8nuNr6DjNL4f7gaomq
         9s8dnb5TQWk0r+QGD3oS1hp+rpdz7J2n4/BgdJKzt1qA3v9lKbmbLeFtgpnKAxdjs28s
         cTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BHkZfIp3eJUJmbeT+kunhu5i+hXVqYxZSG+YbLVhMT8=;
        b=ZS8YvsW1Fh9nCJNaVAaQ0xMdUdC6wSfrgcdU0ULMbTBndtaEOqKAu6iBMrrCYGv9Qo
         sfX+56LwVqNPO0lrxCsYOSOvUcL+iMBEjH6Y0xe64MRjIhXH/pbCkFMdCL3Qx7iAqLB6
         g9LU/yAm+nKR6odukeH3iJpobgdKtnxjRrMUp2BKs+95T+T7H50FkqOCE5boxjbjPMhC
         lzK1I19tWFsfiaNyM4aNprzcuXMVt5h1KWbDVsCY6bZl8uwKCzzOJs66X9S4i1hZ9/mg
         BSFSuMm7F0i/CI949n16B7zxSPC1UQCSy47ZAPMvj6MWeKayCmSAeJUq0hyqOpAoavjz
         WBQw==
X-Gm-Message-State: AOAM530/xLLV/hWvMsRp6ZWjhZbsXt69988YUd6m8ruTZsjHQHl2dOab
        IiqDBcKPayjKl0+jgSPi37b7+B7yRNA=
X-Google-Smtp-Source: ABdhPJzYwR/bmbnDmK1SZktk9SMYg8iLlV+7wGvbXA1hCjUHE/18hQgs42S8HUru2kgGO5x87YP5iQ==
X-Received: by 2002:a1c:2045:: with SMTP id g66mr5837676wmg.184.1598283484909;
        Mon, 24 Aug 2020 08:38:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm24314769wro.84.2020.08.24.08.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:38:04 -0700 (PDT)
Message-Id: <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Aug 2020 15:38:00 +0000
Subject: [PATCH v2 3/3] ci: stop linking built-ins to the dashed versions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Originally, all of Git's subcommands were implemented in their own
executable/script, using the naming scheme `git-<command-name>`. When
more and more functionality was turned into built-in commands (i.e. the
`git` executable could run them without spawning a separate process),
for backwards-compatibility, we hard-link the `git` executable to
`git-<built-in>` for every built-in.

This backwards-compatibility was needed to support scripts that called
the dashed form, even if we deprecated that a _long_ time ago.

For that reason, we just introduced a Makefile knob to skip linking
them. TO make sure that this keeps working, teach the CI
(and PR) builds to skip generating those hard-links.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6c27b886b8..1df9402c3b 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
-make
+make SKIP_DASHED_BUILT_INS=YesPlease
 case "$jobname" in
 linux-gcc)
 	make test
-- 
gitgitgadget
