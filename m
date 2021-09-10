Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D447AC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA126610C8
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhIJKbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhIJKbM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 06:31:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF8C061756
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:30:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso1069134wme.4
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0LmohMfouGdB2NCNLz3WLi/5aCYIhDj2HxF1qAfVDBc=;
        b=WWJpwi0XQfF4COhCBbT7TS0mcYOEvVGaQJMg23eCwT2wNys6vEEFatNvLC+/vt0V8J
         FFbS7bmI9i0GnytC2rhipnsey/0njUKToWrBZCV83m9s5GsrPjcTQCeKLGdUeh8yn3Hv
         sfWaKHoJrAXxTPKgDEMXZBUVcmGs8g3DhzH5XZtpE4yepRJDrMkgexvQGjI/c6a0IosL
         ZIc/+Ex3Mye6O1TnevpfahI0UQ2H+Of3ZWp596F5EoOGjw3RiV3UDKncuGRbIdIWol0Z
         aYL/CAabN910w37WnBgV9ekuY/sLZVV6LZCpAfmCNe5a7aFpiCZlUEUVu6zJlkssSrY/
         F6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0LmohMfouGdB2NCNLz3WLi/5aCYIhDj2HxF1qAfVDBc=;
        b=Y6Bz4PbwLTzkb7gu/3JUqSyCojSoH7TxFDhTqumUXC9ZhoaT5rM71VqUfKIiOq+7qn
         3ul1z4196r+F2GUjKPD9vs+wvxhAwRrcSzFaBOLLWSDwFQULu/iF5bvHlJ/iHEU3Ofww
         O4drc2Z+1qhPiixMKXP/RWZkDMPwtv6/EPK37i7w0NIqVTDPTR3cIIUUpar/T5zdEbDf
         nZlhgBpU5ywCD/p3E562VSwlVxjc+9kltqZ2V/XZyTY/tj/ag6+nVJF8j6VGH9F0E2qh
         zFI4xkFr09qAqLgrmeExfiqoZ2Qq8DHySmYv2bK3JsOYNmH3HjiNUth9cdos02o4fW1+
         xPSA==
X-Gm-Message-State: AOAM530K1obQhRgkziZ9iHTvF89A55da63kZie9plQDFMtd06qiXxZUE
        wyJLqJx3mvu+9JdbhGXO0dl2dbcSbh0=
X-Google-Smtp-Source: ABdhPJziFMJQcaOMFGCAGTrQV1G3ARq0rAZ+16syzPEw1alYA0LW7VA6VYYLnE+ASYAuoPnoe3yD2A==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr7579805wmk.97.1631269800016;
        Fri, 10 Sep 2021 03:30:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm4257251wrc.55.2021.09.10.03.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 03:29:59 -0700 (PDT)
Message-Id: <6254938948c0db856ffeb4f1c4629c79c6d72197.1631269796.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1086.v2.git.git.1631269796.gitgitgadget@gmail.com>
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
        <pull.1086.v2.git.git.1631269796.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 10:29:56 +0000
Subject: [PATCH v2 3/3] stash: restore untracked files AFTER restoring tracked
 files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If a user deletes a file and places a directory of untracked files
there, then stashes all these changes, the untracked directory of files
cannot be restored until after the corresponding file in the way is
removed.  So, restore changes to tracked files before restoring
untracked files.

There is no counterpart problem to worry about with the user deleting an
untracked file and then add a tracked one in its place.  Git does not
track untracked files, and so will not know the untracked file was
deleted, and thus won't be able to stash the removal of that file.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c  | 6 +++---
 t/t3903-stash.sh | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 9ad2940f87a..5512f4942cd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -535,9 +535,6 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		}
 	}
 
-	if (info->has_u && restore_untracked(&info->u_tree))
-		return error(_("could not restore untracked files from stash"));
-
 	init_merge_options(&o, the_repository);
 
 	o.branch1 = "Updated upstream";
@@ -572,6 +569,9 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		unstage_changes_unless_new(&c_tree);
 	}
 
+	if (info->has_u && restore_untracked(&info->u_tree))
+		return error(_("could not restore untracked files from stash"));
+
 	if (!quiet) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 34d1ad9837f..f0a82be9de7 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1324,7 +1324,7 @@ test_expect_success 'git stash succeeds despite directory/file change' '
 	)
 '
 
-test_expect_failure 'git stash can pop file -> directory saved changes' '
+test_expect_success 'git stash can pop file -> directory saved changes' '
 	test_create_repo directory_file_switch_v2 &&
 	(
 		cd directory_file_switch_v2 &&
@@ -1344,7 +1344,7 @@ test_expect_failure 'git stash can pop file -> directory saved changes' '
 	)
 '
 
-test_expect_failure 'git stash can pop directory -> file saved changes' '
+test_expect_success 'git stash can pop directory -> file saved changes' '
 	test_create_repo directory_file_switch_v3 &&
 	(
 		cd directory_file_switch_v3 &&
-- 
gitgitgadget
