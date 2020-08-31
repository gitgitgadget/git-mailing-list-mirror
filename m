Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F966C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1CE2072D
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 06:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3igeYjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHaG7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaG7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 02:59:06 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8B2C061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:04 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h10so4799722ioq.6
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 23:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+1oJBhMqB6No61lU1+MpTpY2WNpKWz2IVTiODSFM1M=;
        b=K3igeYjzOslhYcis+qL3Nehl+EQTqBOD7ovAX4Jr6P5JpC5ENjxvrHxPwGx1Kx/l/n
         zGYUbxdlGs+QNIsUwzSlerl/TKnpKrRLmqWPSbJ4xEtHZNWL9g96z3vLejSDLFMpaFjG
         62pgyQT/QkSyBwV4g5Jy9P7FH34pb1+JHIlafZvDkCCoB2wTYHEw1aiqkAjeC8ROtiyN
         mUi1tsjFeJD1LSLqGbRdt+NyrNuU/Ko8Dl/6Z2WAXq2S3fFPF/lNvjLuWuBPowb38wkZ
         tJztgF2luopWsuAF8Laadiqb2V09U3O4JWqqqKIQy5LByaMl3i091RxrZPTcZtKqA9K4
         fxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6+1oJBhMqB6No61lU1+MpTpY2WNpKWz2IVTiODSFM1M=;
        b=dmneD4pBayd/6k7Ve+DQKTqSiFi1EZD6zIhNF3nVmn52dSk8mpTAK6K6vluqR+zvdo
         qjM5eOmEcCRJUc1CziemI7nGNXPspm2khz8aKeH7b8NmOViyMMHybWSgVJxaY8Yr7V6I
         sIA9H4kVOkzhr2CpLHGs6ynpo7EmwiSA7FoPaXj/sCcxnQQ9PHPBUC1VK9TQLTSXHJGW
         f+9fumSS+gmcw0rnbZhPSF7b/7cYYK5IALGUdo+1x4Js0pxDrTVGa1sPp4xiZGhQsGdY
         uJLRcEiFJxx49o5xAwTYOzSnfEj5z+U6BiJ/c9JuhXywH7wMJnMmoMiJnOqVKO+6Z6Au
         tFdg==
X-Gm-Message-State: AOAM531Rd2VnfdDxGOz0i71LP+2Ozj4uWj6F3s83PhKBrSHqvrYiSEwK
        mZRhfs+MUddmYM8yzlD2SAK9zgPcVVQ=
X-Google-Smtp-Source: ABdhPJw/5XU+ruPq02Lec2PkC4XXrjv8sz8L6qnlbFmr7SUZVD0y/YeTEHbNlDCBX0twZ/ZY8+Dt0Q==
X-Received: by 2002:a02:8286:: with SMTP id t6mr13329jag.87.1598857143153;
        Sun, 30 Aug 2020 23:59:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id x1sm1878615ilo.50.2020.08.30.23.59.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 23:59:02 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/5] worktree: add skeleton "repair" command
Date:   Mon, 31 Aug 2020 02:57:56 -0400
Message-Id: <20200831065800.62502-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.531.g41c3d8a546
In-Reply-To: <20200831065800.62502-1-sunshine@sunshineco.com>
References: <20200827082129.56149-1-sunshine@sunshineco.com>
 <20200831065800.62502-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Worktree administrative files can become corrupted or outdated due to
external factors. Although, it is often possible to recover from such
situations by hand-tweaking these files, doing so requires intimate
knowledge of worktree internals. While information necessary to make
such repairs manually can be obtained from git-worktree.txt and
gitrepository-layout.txt, we can assist users more directly by teaching
git-worktree how to repair its administrative files itself (at least to
some extent). Therefore, add a "git worktree repair" command which
attempts to correct common problems which may arise due to factors
beyond Git's control.

At this stage, the "repair" command is a mere skeleton; subsequent
commits will flesh out the functionality.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt |  6 ++++++
 builtin/worktree.c             | 15 +++++++++++++++
 t/t2406-worktree-repair.sh     | 11 +++++++++++
 3 files changed, 32 insertions(+)
 create mode 100755 t/t2406-worktree-repair.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 6ee6ec7982..ae432d39a8 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 'git worktree remove' [-f] <worktree>
+'git worktree repair'
 'git worktree unlock' <worktree>
 
 DESCRIPTION
@@ -110,6 +111,11 @@ and no modification in tracked files) can be removed. Unclean working
 trees or ones with submodules can be removed with `--force`. The main
 working tree cannot be removed.
 
+repair::
+
+Repair working tree administrative files, if possible, if they have
+become corrupted or outdated due to external factors.
+
 unlock::
 
 Unlock a working tree, allowing it to be pruned, moved or deleted.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 378f332b5d..88af412d4f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1030,6 +1030,19 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static int repair(int ac, const char **av, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	int rc = 0;
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac)
+		usage_with_options(worktree_usage, options);
+	return rc;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -1056,5 +1069,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return move_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "remove"))
 		return remove_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "repair"))
+		return repair(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
new file mode 100755
index 0000000000..cc679e1a21
--- /dev/null
+++ b/t/t2406-worktree-repair.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+test_description='test git worktree repair'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit init
+'
+
+test_done
-- 
2.28.0.531.g41c3d8a546

