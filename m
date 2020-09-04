Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F080FC433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 07:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE58C206D4
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 07:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HODFVf4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgIDHIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgIDHIo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 03:08:44 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A615DC061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 00:08:43 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x2so5519339ilm.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7edZzxRMYWOYMK4RX7tgA1J0yGQOgeOuW3LE5RNHKM=;
        b=HODFVf4cudO70vuc1p8ljOLI0TZgai1mQj4XITS83DpcrHcw/GnjMWdSPJclqoBgee
         S5X6JenIh3X9esQX8WfWOeGY40rRuhQNIrbdao90zu8B4020SJjoyFPcasXoluHhHqh8
         YKn0VOlCZczPjmFu2ZwBh6on2+J92hsapHCdjYj6n7V8Xr06N0pICMYjGddNx67OckbO
         ZlPP+66BHnhgIwgTqehPFIaU9uMHDzppS1foUgDzlKULWQABDnvD+SqZ5KGDvZJrXXE2
         /BsOGM1I8zEbNvIRXn/lipvdJYUDeouiWPnJSNxg52bUakUXqBqkC7PuPEZOfLUO7dNC
         wfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=y7edZzxRMYWOYMK4RX7tgA1J0yGQOgeOuW3LE5RNHKM=;
        b=YmTbFzfoZy8iyHsJvR26ox/cRC3fEZi3vIdEh+PEH9o+UmzSc+GwI41/cBJcLT45gP
         PndmE+WooD94wayUJXtg98Uu7TFE4Ew4V+D57qNtjzbBvm4FaKE6e1nN7HnO4N1+VKNt
         DydIVTTFn2SEB5gIWDnVz2Hs35pcvgdiPKGSFDMlS9o7+7HFhzHVqppvMFJURQOO7Ima
         8kF0O7xrm7W5Z/DgT7/OFLkcDSqe5bhSNY9KbfEJh65Nz7AaNViZ4LNnBRFzarEA5nxT
         fBVcqCuMUrrybqPhhQURJNwaf+/JLumdH+Kd/YvgOumdEO3ixiuKrOZsCXuicWkRTGHg
         LYMA==
X-Gm-Message-State: AOAM5301AQS9PEZ9ahSmIqxsbVCek5hOJfgPM7B+K9Wge5v6f5nSaNch
        tD7EmuzsgnMifjcQjv/sajdqSjkwt+s=
X-Google-Smtp-Source: ABdhPJwSqSMi/JWGBcMShJLBEVjA6zxUrLf2vwIaU3GCM/ZEKm4WMUKzoYNOFm18c8AZqfhKtxYeBQ==
X-Received: by 2002:a05:6e02:1303:: with SMTP id g3mr3541333ilr.218.1599203322685;
        Fri, 04 Sep 2020 00:08:42 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n62sm2881950ild.36.2020.09.04.00.08.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 00:08:42 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] worktree: add -d short option for --detach
Date:   Fri,  4 Sep 2020 03:07:02 -0400
Message-Id: <20200904070703.47898-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <20200904070703.47898-1-sunshine@sunshineco.com>
References: <20200904070703.47898-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like git-switch and git-checkout, git-worktree can check out a branch or
set up a detached HEAD. However, unlike git-switch and git-checkout,
git-worktree does not understand -d as shorthand for --detach, which may
confound users accustomed to using -d for this purpose. Address this
shortcoming by adding -d as shorthand for --detach in order to bring
git-worktree in line with the other commands.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 1 +
 builtin/worktree.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 6ee6ec7982..d252b6873b 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -143,6 +143,7 @@ To remove a locked working tree, specify `--force` twice.
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<commit-ish>`.
 
+-d::
 --detach::
 	With `add`, detach `HEAD` in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 378f332b5d..1737165d2d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -555,7 +555,7 @@ static int add(int ac, const char **av, const char *prefix)
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
-		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
+		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
-- 
2.28.0.618.gf4bc123cb7

