Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B783C433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 22:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0741E206C3
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 22:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtRNsXMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHIWyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 18:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgHIWyL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 18:54:11 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF706C061756
        for <git@vger.kernel.org>; Sun,  9 Aug 2020 15:54:10 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id l7so1648194ils.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2020 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ybHGwOpwAgHHaUbfG7CPfyhnImpyxC70HuNjLhkJWhg=;
        b=PtRNsXMKrzCh40OnqNn1pJXxcBe79KbOTGXJLsqcwrvnqNrXXJg5UXBj0sFzrHS8Cf
         OG0kEUZLfrNzgvgus+0cyu3WPzMmVrKeL+VJ/xic0pfjvrjf/fi524XfLFtVAfDw545c
         LWDQuDZGk6niCNx9kxAiGw3rxEvwSaS2YeSQZWXUJUJNjvyKGlT085rQyuXwNJpjbiLn
         aBalfQuQxeQ5TFRV+C71dVZ272wS74BYwS2srcKzFvLth6XWnd1fwcpB6QUtz5S98fsa
         am0tZ+b/TChgNN4POI9f0vKP7+Miztd6qRLwfXkehvFri+yB5YSLVZswyfQ/UYHuBoYe
         twtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ybHGwOpwAgHHaUbfG7CPfyhnImpyxC70HuNjLhkJWhg=;
        b=YQVG6p1GemLfYkGtrXZOqze3dbDluhZyBBZzsCsLCU4X5lh58a/Xa7JaJ0/IsGLhga
         Lut4mJiPHegsXrl8mCblirkoiOw7WV/3Wpv8NofIgtBNLXDE1mv9V3zBFzz3eKQkPIkO
         LtImHDeGz22PBhq4f/KT8xEuI1q2VvlhM3Luu6PANctZk6pfcIo86QE2CeU9Oij56s31
         Zp8lf2XX80haQerI970kuI8qScOQJc28KXufnA2YsmUQLHNbqm8flElZ02vXaIvTOMku
         JmCtnezSXbBhd0tMl5ry629R7gwmkLLwsAGT6+Zq7Rq0dBSmppKY+HeJpfTDskK1073o
         llDg==
X-Gm-Message-State: AOAM530CZ0icz8TUl/wZqayEzagwOiUwnREVVBjVPMEv0wXp5z0QWfe9
        pDq5Q8u6VAOhNYnWXi+tRL6YRdIw
X-Google-Smtp-Source: ABdhPJxyJkuKvMpJq179fNpO41IZiOP6BjCZs/c0sDQ4Z9hDErgk5YgvnuRa/xXeajDfe2SXQVaANw==
X-Received: by 2002:a92:9118:: with SMTP id t24mr14727002ild.220.1597013649562;
        Sun, 09 Aug 2020 15:54:09 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r2sm11031888ilc.58.2020.08.09.15.54.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2020 15:54:08 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] init: disallow --separate-git-dir with bare repository
Date:   Sun,  9 Aug 2020 18:53:16 -0400
Message-Id: <20200809225316.19503-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of "git init --separate-git-dir" is to separate the
repository from the worktree. This is true even when --separate-git-dir
is used on an existing worktree, in which case, it moves the .git/
subdirectory to a new location outside the worktree.

However, an outright bare repository (such as one created by "git init
--bare"), has no worktree, so using --separate-git-dir to separate it
from its non-existent worktree is nonsensical. Therefore, make it an
error to use --separate-git-dir on a bare repository.

Implementation note: "git init" considers a repository bare if told so
explicitly via --bare or if it guesses it to be so based upon
heuristics. In the explicit --bare case, a conflict with
--separate-git-dir is easy to detect early. In the guessed case,
however, the conflict can only be detected once "bareness" is guessed,
which happens after "git init" has begun creating the repository.
Technically, we can get by with a single late check which would cover
both cases, however, erroring out early, when possible, without leaving
detritus provides a better user experience.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    I ran across this while working on a worktree-related topic dealing
    with --separate-git-dir. Closing this loophole eliminates some
    potentially strange and unworkable cases that the other topic might
    otherwise encounter. Even though this change is tangentially related
    to the other topic, it's also sufficiently standalone to post
    separately; plus, I want to get feedback on it early since I'm not
    100% happy with checking for the conflict between --separate-git-dir
    and a bare repository in two separate places (though, I can live
    with it).

 builtin/init-db.c |  5 +++++
 t/t0001-init.sh   | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index cee64823cb..60e5c14169 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -568,6 +568,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
+	if (real_git_dir && is_bare_repository_cfg == 1)
+		die(_("--separate-git-dir and --bare are mutually exclusive"));
+
 	if (real_git_dir && !is_absolute_path(real_git_dir))
 		real_git_dir = real_pathdup(real_git_dir, 1);
 
@@ -663,6 +666,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 				   get_git_work_tree());
 	}
 	else {
+		if (real_git_dir)
+			die(_("--separate-git-dir incompatible with bare repository"));
 		if (work_tree)
 			set_git_work_tree(work_tree);
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 6d2467995e..5c585f7fcb 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -316,6 +316,19 @@ test_expect_success 'init with separate gitdir' '
 	test_path_is_dir realgitdir/refs
 '
 
+test_expect_success 'explicit bare & --separate-git-dir incompatible' '
+	test_must_fail git init --bare --separate-git-dir goop.git bare.git 2>err &&
+	test_i18ngrep "mutually exclusive" err
+'
+
+test_expect_success 'implicit bare & --separate-git-dir incompatible' '
+	test_when_finished "rm -rf bare.git" &&
+	mkdir -p bare.git &&
+	test_must_fail env GIT_DIR=. \
+		git -C bare.git init --separate-git-dir goop.git 2>err &&
+	test_i18ngrep "incompatible" err
+'
+
 test_lazy_prereq GETCWD_IGNORES_PERMS '
 	base=GETCWD_TEST_BASE_DIR &&
 	mkdir -p $base/dir &&
-- 
2.28.0.220.ged08abb693

