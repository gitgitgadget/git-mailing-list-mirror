Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EE7C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjAQRMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjAQRLg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C487333454
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 18so46001525edw.7
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71wWR4oI+uI7PeBtosyK068X2Y/5k09NgdPyFYwT9tk=;
        b=NrsxgaC+NtrS9ZaAj85RLdSH/56f77GOSLd28awE/By1weTjSNL/fQ/kr1VL7mN/C+
         b0CDj/2RIJjB4OtprwMxR93jiC94LwaPO0ybsEmFDGslqmY7w9NpnT4q4s+JzdflFZok
         oZgee6hlgagCmF5B4x7gTY1qV5xkbO7x5X4UjM9c0b/g6wauE4uiM6Ii3Ja6OzZNobpS
         X4+jW4gHDz8PWNIWLJiBGz6ZGMHcnhfb86u4Rht5dHZ8c7nuIX8mUd9T2MBLu23hwDH3
         vehWCsz/6a3BQFA+iq4xZ5k7KSLTRjHcfUs+atS9JRr6EJ2RIjdL36Po7yh4UyAC/Dlv
         y67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71wWR4oI+uI7PeBtosyK068X2Y/5k09NgdPyFYwT9tk=;
        b=SH9m7WwHZNrQ5UKOFzkSYFBbT4cSC1DG6WJezso0IBPXPIyXJGm9fpjjXPtqwrVRg8
         CrsIR1nd3A2uFH5NqpSjWUwSbOUlHc54VQmZToyYoSfb2nBOK95ecODhJmTUQ2bl1T9N
         625CnaMducldcGbMB7ThNq43k6AMp43gncqpbHQXDB4HyHoYyZxZvJx3W6SyE+WEOthb
         pOAEARVLU/1b9MgnZ+yEWnXv7A7NbsXdllBNtscoMjYoj71TASel9XZle7rJQMlOxmNi
         zQanNfpmSZhchgO+4yqJJ5xP78xhAge0V/tqelotDjMCt+f4+xBvtzS0jQDtL8ksajcs
         T+bw==
X-Gm-Message-State: AFqh2krSiG6NOIybobn4SLsmWBv9tqibAJ+j9KQsnDx2PfCVMFVst1p/
        byLeJUkeSp25fABjB33dcd7rvkC/KKZtAg==
X-Google-Smtp-Source: AMrXdXtyWhO1CfyrOajVc4f1J2CWhb9/uXwXbRKm95iOqSxguJtyI06x2JckcWvWTIRS51CUgFdWVw==
X-Received: by 2002:a05:6402:1009:b0:479:8313:3008 with SMTP id c9-20020a056402100900b0047983133008mr3403031edu.0.1673975492946;
        Tue, 17 Jan 2023 09:11:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/19] worktree: fix a trivial leak in prune_worktrees()
Date:   Tue, 17 Jan 2023 18:11:13 +0100
Message-Id: <patch-v4-08.19-1fe25bc6981-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were leaking both the "struct strbuf" in prune_worktrees(), as well
as the "path" we got from should_prune_worktree(). Since these were
the only two uses of the "struct string_list" let's change it to a
"DUP" and push these to it with "string_list_append_nodup()".

For the string_list_append_nodup() we could also string_list_append()
the main_path.buf, and then strbuf_release(&main_path) right away. But
doing it this way avoids an allocation, as we already have the "struct
strbuf" prepared for appending to "kept".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/worktree.c         | 6 +++---
 t/t2401-worktree-prune.sh  | 1 +
 t/t2406-worktree-repair.sh | 1 +
 t/t3203-branch-output.sh   | 2 ++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 591d659faea..865ce9be22b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -173,7 +173,7 @@ static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
 	struct strbuf main_path = STRBUF_INIT;
-	struct string_list kept = STRING_LIST_INIT_NODUP;
+	struct string_list kept = STRING_LIST_INIT_DUP;
 	DIR *dir = opendir(git_path("worktrees"));
 	struct dirent *d;
 	if (!dir)
@@ -184,14 +184,14 @@ static void prune_worktrees(void)
 		if (should_prune_worktree(d->d_name, &reason, &path, expire))
 			prune_worktree(d->d_name, reason.buf);
 		else if (path)
-			string_list_append(&kept, path)->util = xstrdup(d->d_name);
+			string_list_append_nodup(&kept, path)->util = xstrdup(d->d_name);
 	}
 	closedir(dir);
 
 	strbuf_add_absolute_path(&main_path, get_git_common_dir());
 	/* massage main worktree absolute path to match 'gitdir' content */
 	strbuf_strip_suffix(&main_path, "/.");
-	string_list_append(&kept, strbuf_detach(&main_path, NULL));
+	string_list_append_nodup(&kept, strbuf_detach(&main_path, NULL));
 	prune_dups(&kept);
 	string_list_clear(&kept, 1);
 
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 3d28c7f06b2..568a47ec426 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -5,6 +5,7 @@ test_description='prune $GIT_DIR/worktrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success initialize '
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 5c44453e1c1..8970780efcc 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -2,6 +2,7 @@
 
 test_description='test git worktree repair'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index d34d77f8934..ba8d929d189 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git branch display tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-- 
2.39.0.1225.g30a3d88132d

