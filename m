Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15D4C433FE
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DFF6112F
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 18:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKJSix (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 13:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhKJSiv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 13:38:51 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4FC061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 10:36:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso5409227wmc.2
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 10:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EdErDXotOhIyTxxiEILufl9t2N50UPdIZWueaAabagk=;
        b=Oa0KmUiGYp/lUuREHvTvcePyuVQ/T3dihBpizxt984rbSIQYC9CydONWwvRQj8BnLt
         pPHKemRhPmCJ4nDpx/sSHjLnwCDrnEG56RQjEcb+GemLtos6JIsuH0yocVqdIMIGLGla
         J5TujwcWehtrcJ4tVyGvZxg3Kbkn/ZF+ZwlHKY4qQH/UX42YkUVnkpztZTQw8br7cv55
         KebmYYHl31HAppCNisk5babRyAW1mC/xemFLccwXHY4faEgSt/lsfgDsYgE3/Swh63BG
         w0oiWd+OzFK/pGY5yK0K4VHIw7+hFSo8HrTpSHD4sL5r+TMDDsZq8ajZTIJ4zds4Sxf3
         dm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EdErDXotOhIyTxxiEILufl9t2N50UPdIZWueaAabagk=;
        b=6QrgcQHcomsXEFreguIVAbc6cHqYagmknzgUZBNyf96YFYUSgi28xTLHZj+0xyKxy+
         YTiaGWjIPiN7UH/S1ekV+ZbQDy8rR3am3JbnbrREujWT6sCv23Lrin5x7xZij7VpNLpM
         qpwXIvXgHp4rPusSJDzOckDOTYGMiNTkKrPhaOsG6UUD9Xsc1mkCA8N1V7/R6KiQb7ar
         jgVYMObcU1j9BYHaGOiNWjw9nbo5WvTTmPvLwOf/ffbdWiR7tlFPZTekPtUFJ92MXwZY
         FjL4xuN3epc4dMuCJVxe2xFk6aNKHLWg/E4T/hbEpzD1LW/D/gmKfo98YLJnxP10Xd4S
         GQrw==
X-Gm-Message-State: AOAM532MGhjSUpQ1zVkhDDy2+eeKpFZfJGvbsGNf+US0Be9eTGGjXPzA
        5qM3NoBetHbaG+Mx5LS+E3y3bZMyr0Q=
X-Google-Smtp-Source: ABdhPJzy20dbA6SXVxX+qNI4e3mQb3oaIMHefZ2y/y/gfZD+HmQnVnMNek9YFyu/fEmucemwBB3JIA==
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr1353460wmr.159.1636569361171;
        Wed, 10 Nov 2021 10:36:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm6970246wmq.42.2021.11.10.10.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 10:36:00 -0800 (PST)
Message-Id: <pull.1075.git.1636569360002.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Nov 2021 18:35:59 +0000
Subject: [PATCH] maintenance: disable cron on macOS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In eba1ba9 (maintenance: `git maintenance run` learned
`--scheduler=<scheduler>`, 2021-09-04), we introduced the ability to
specify a scheduler explicitly. This led to some extra checks around
whether an alternative scheduler was available. This added the
functionality of removing background maintenance from schedulers other
than the one selected.

On macOS, cron is technically available, but running 'crontab' triggers
a UI prompt asking for special permissions. This is the major reason why
launchctl is used as the default scheduler. The is_crontab_available()
method triggers this UI prompt, causing user disruption.

Remove this disruption by using an #ifdef to prevent running crontab
this way on macOS. This has the unfortunate downside that if a user
manually selects cron via the '--scheduler' option, then adjusting the
scheduler later will not remove the schedule from cron. The
'--scheduler' option ignores the is_available checks, which is how we
can get into this situation.

Extract the new check_crontab_process() method to avoid making the
'child' variable unused on macOS. The method is marked MAYBE_UNUSED
because it has no callers on macOS.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    [For 2.34.0 Release] maintenance: disable cron on macOS
    
    This one is really tricky because we can't notice anything is wrong
    without running git maintenance start or git maintenance stop
    interactively on macOS. The tests pass just fine because the UI alert
    gets automatically ignored during the test suite.
    
    This is a bit of a half-fix: it avoids the UI alert, but has a corner
    case of not un-doing the cron schedule if a user manages to select it
    (under suitable permissions such that it succeeds). For the purpose of
    the timing of the release, I think this is an appropriate hedge.
    
    Thanks! -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1075%2Fderrickstolee%2Fmaintenance-cron-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1075/derrickstolee/maintenance-cron-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1075

 builtin/gc.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 26709311601..bcef6a4c8da 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1999,15 +1999,11 @@ static int schtasks_update_schedule(int run_maintenance, int fd)
 		return schtasks_remove_tasks();
 }
 
-static int is_crontab_available(void)
+MAYBE_UNUSED
+static int check_crontab_process(const char *cmd)
 {
-	const char *cmd = "crontab";
-	int is_available;
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	if (get_schedule_cmd(&cmd, &is_available))
-		return is_available;
-
 	strvec_split(&child.args, cmd);
 	strvec_push(&child.args, "-l");
 	child.no_stdin = 1;
@@ -2022,6 +2018,25 @@ static int is_crontab_available(void)
 	return 1;
 }
 
+static int is_crontab_available(void)
+{
+	const char *cmd = "crontab";
+	int is_available;
+
+	if (get_schedule_cmd(&cmd, &is_available))
+		return is_available;
+
+#ifdef __APPLE__
+	/*
+	 * macOS has cron, but it requires special permissions and will
+	 * create a UI alert when attempting to run this command.
+	 */
+	return 0;
+#else
+	return check_crontab_process(cmd);
+#endif
+}
+
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
 #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
 

base-commit: 6c220937e2b26d85920bf2d38ff2464a0d57fd6b
-- 
gitgitgadget
