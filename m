Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC2BC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1C720738
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpKVpSkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgH0IXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgH0IXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 04:23:09 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F06FC06121B
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:09 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e11so4150369ils.10
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4gpVE73A5R6mECafxyOesEw1tGc8KuzSNxwKiGFDLU=;
        b=bpKVpSkJDx7rx/IYwFYRPLy2C6P4FrEgJc5IdoiJRU0NHYNo7ORJjsNITEtlSXVjwr
         jSAbkgtIL6EyWLSUt5RK6Vok0swCsZk22e0nDxSMUStHArs2gSDkEA1KrROif72080o5
         SZIiP2IMVtmd280RDk0xUwz3SCpQDY1Y+g09vzvkaSx2MVcp8AtYm+9JOsxoNbl2FYOK
         MrMOLdNU9LYIMgjo1Msz5DedYpd+8QkYQMUkhl9FOaaNXZVsoscpWJ5f9qlPUgOwfXkM
         /9UClYnkXjSCK1+U+tUclSC27u39Wxz6tCnk896gdTUBWaa+XDAxzr+5XxBGscSCNVy2
         aBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=L4gpVE73A5R6mECafxyOesEw1tGc8KuzSNxwKiGFDLU=;
        b=QzIt9cFjxfqvlPd3t4KwPSM/V5GWOeK1e3RLyw3xM0Q39mTkfPrsEK0EPKllwgdvHB
         srGNK2eSbpIkhiFVJzUkHcuaIsNHROMbe36shbaPIK8ZVZNwh8xoceGKJp2DH/+VjJ83
         ANzbT4QyO6IGfm33+r7Ly+McWEJKdHZAYjILw4N9GypO8UJTO6j9RaNWdK6JZWm6KCoz
         /w+oSoktlVoppahZmzTv52YB5JHDkp3YKKJV4zlYbrqkgniJlSVQXknceeY6MToUNdd8
         4lsqf7ccEGu8wJIjztE5Z0d5y3tCCEnGe/xTBGst6RwLXTCNEGwFx7VTfcLt6gMY4IN7
         LmZw==
X-Gm-Message-State: AOAM530JaLWzVCSWZZllEG/t96it018juVmuAKfV80gB7yw0IzXKVewW
        81wlg8IVo1hwXSGPrJOtm4pBTNf60tM=
X-Google-Smtp-Source: ABdhPJwcLaAxgpM6Fste3fd+zek7ATFQnKk59YymTW4Bc/Ah3vnTkm6eWH6iDhp5kVe8A9WyUBT0Ug==
X-Received: by 2002:a05:6e02:f4e:: with SMTP id y14mr17097579ilj.255.1598516588082;
        Thu, 27 Aug 2020 01:23:08 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n15sm816553ioc.15.2020.08.27.01.23.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 01:23:07 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Henr=C3=A9=20Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/5] init: teach --separate-git-dir to repair linked worktrees
Date:   Thu, 27 Aug 2020 04:21:28 -0400
Message-Id: <20200827082129.56149-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.461.g40977abb40
In-Reply-To: <20200827082129.56149-1-sunshine@sunshineco.com>
References: <20200827082129.56149-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A linked worktree's .git file is a "gitlink" pointing at the
.git/worktrees/<id> directory within the repository. When `git init
--separate-git-dir=<path>` is used on an existing repository to relocate
the repository's .git/ directory to a different location, it neglects to
update the .git files of linked worktrees, thus breaking the worktrees
by making it impossible for them to locate the repository. Fix this by
teaching --separate-git-dir to repair the .git file of each linked
worktree to point at the new repository location.

Reported-by: Henré Botha <henrebotha@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/init-db.c |  2 ++
 t/t0001-init.sh   | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index bbc9bc78f9..7b915d88ab 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -9,6 +9,7 @@
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "parse-options.h"
+#include "worktree.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -364,6 +365,7 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 
 		if (rename(src, git_dir))
 			die_errno(_("unable to move %s to %s"), src, git_dir);
+		repair_worktrees(NULL, NULL);
 	}
 
 	write_file(git_link, "gitdir: %s", git_dir);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 50222a10c5..e489eb4ddb 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -405,6 +405,17 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	test_path_is_dir realgitdir/refs
 '
 
+test_expect_success 're-init to move gitdir with linked worktrees' '
+	test_when_finished "rm -rf mainwt linkwt seprepo" &&
+	git init mainwt &&
+	test_commit -C mainwt gumby &&
+	git -C mainwt worktree add --detach ../linkwt &&
+	git -C mainwt init --separate-git-dir ../seprepo &&
+	git -C mainwt rev-parse --git-common-dir >expect &&
+	git -C linkwt rev-parse --git-common-dir >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success MINGW '.git hidden' '
 	rm -rf newdir &&
 	(
-- 
2.28.0.461.g40977abb40

