Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3AEC433E3
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B782F22B4D
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO79CnNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgH0IXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgH0IXH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 04:23:07 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53FCC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:05 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so4199159iln.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4JoCXCRsSvzIaTgT75qtm8Z0zOuz8gugrqn6+iKtzY0=;
        b=HO79CnNCgEoAE7VzW2CqA1BCBciebvl8timnUN6LJUeZ30TkNUxpMqT4Ttz8OQCVbE
         xfNxFuK5PWK5qv954PNtaYNfNdiIIfn2G16Ds3CPvsJGWiSnX1RsbS10a41cOYJlBYyx
         0Ztg6ZH8Ppl0ByDMSDLw6QQ/x1n7LHBsUVrVG9xi5FHxPSIgIGE+6XiNmuvRTa/RkGWv
         0jYHFZuzcG772g9NDfFUCwRmW6XatPufjZ8kxY+3dVTi3EaaJqtQHC3Xnn53lh6eFvGD
         t0aChAi9WZgDkX/rmcjvoMvbiOFj05DvaWKLI4ozBPHzLiqyjJFg2f7Y0ZB/8f6iq/fw
         8jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4JoCXCRsSvzIaTgT75qtm8Z0zOuz8gugrqn6+iKtzY0=;
        b=Gp5AW8yOClBcn5BES/FYt8qunHuHl3QU3XQtIZGr2mi5RM88aQuaX1pVHNO4w34iSz
         k9cilJr9gu9hUjeRNTeDYIb8O/zThlkl0RYIT87xiwlw+XO6LKlnqkmfJnvsm6kZcO9x
         d1IpO221JEuFK0DA9XHpniiePaagIV7vIHfO2g+ORCwWiyQMY3m+UqE+x8GoVwBgk8mh
         w/NbvBRhJxq7AejHoDtuDbXxtldSQxs5fExg/udb/55Y9Ez68FbLVbw1Jqas3ypnW3R5
         OEYSNrUtyascUrHUrl3rB56N4PdpPFAetHNq9+z0pKeDN90pA0k6CWaUApCJ1SL+TdjG
         zCLA==
X-Gm-Message-State: AOAM531QCD3tnYpTN/ldy6UquGkQBdw/1pKz2VhGKstLersc8oybxq1O
        Hyi4R7O4NH/t/0XiN9Byae8pWTZU0Bg=
X-Google-Smtp-Source: ABdhPJwnqj6nnpOY2xPjNZkGa/NezZDIsj+vKRifpMYUb5B5sWROHORez8toKuP614thf3W14Y7Tnw==
X-Received: by 2002:a92:a119:: with SMTP id v25mr17096574ili.77.1598516584939;
        Thu, 27 Aug 2020 01:23:04 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n15sm816553ioc.15.2020.08.27.01.23.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 01:23:04 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/5] worktree: add skeleton "repair" command
Date:   Thu, 27 Aug 2020 04:21:25 -0400
Message-Id: <20200827082129.56149-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.461.g40977abb40
In-Reply-To: <20200827082129.56149-1-sunshine@sunshineco.com>
References: <20200827082129.56149-1-sunshine@sunshineco.com>
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
2.28.0.461.g40977abb40

