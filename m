Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300CAC4332F
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbiBOQAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241133AbiBOQAM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 11:00:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731C5BDE62
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:50 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s10so19371701wrb.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=loaJkqv8AAh0TwehIgIIWjp9ODA9lqvvgmtTriOysSs=;
        b=Hiaj5jf9owpQcIA0CYVSm9idI/CT7BoMeoAcWPZkrwF6kvf4pWQGgRo1ryN2AG8zL1
         njNt5eNE6tAtCB3tvy0YkUlLlcjpylpfNDkV0uH0X4TA9hBpH/oQRdMPLaE+i87JuLZD
         0HtGALBMj+dZn5Cq+wwKfhSind6mJmUkNL7kIMEuvytyczX31jBQAJn7HoHA3Hyoc3Rz
         0Qk1iDq85KOJ+jqcV5oixiDZriwe7RZjeDidRsuF+vKQh9bDXZLQVTBSh0OUoMN+/2VN
         C4wleNXHSeidetle9QO5+w0HMn+o62yhnh1fHt9XBmoS5rfDDb6rxaAN6TOnhJ1luh7W
         2Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=loaJkqv8AAh0TwehIgIIWjp9ODA9lqvvgmtTriOysSs=;
        b=UYLsDJdiDFSiYUoCEvFTM6ROv6Ya20cES01tsx3Z6RdYixYfC+xXoMFxV3t/dnhIoU
         8lMdacadQIwwqwlORT3lVLIt+YaLL56sII3inK+rz1s5YHRh4t9kF+UYylbhT1wlFyYP
         rgtTV8A6/So+lamsKk8h7m61XerYOZVfhKClk44zxvSakMrhNtWJ414l1HXDkxlnDe28
         xd2RPVi1KeYuTYKsrGuW+HNw2Pz+z+MqS2dPmX07Y+DXl1MMWihBYqhGiwQung4+uvDc
         n1Y1iKc4cxnnyH9+gEyVKgpoH3jNMvK9SaoFFfiZ/7vPnM9oVSDjOQeTmQT+NzJzMMp/
         WbcA==
X-Gm-Message-State: AOAM532j96zHK413rrtnmTyCU+qtJ+DqW1qqupYWK07MB/ADFBk6uLcV
        VP6GuZdTCmtwg4MAIohv9HsolRqVBUI=
X-Google-Smtp-Source: ABdhPJzfQv4luiu3qB+2f6sc6sL5av2u4oisuBA0Ln7owu1J0DeoxvexJXKv44t9XOa1vF8VgBV3aQ==
X-Received: by 2002:adf:e0c9:: with SMTP id m9mr3951190wri.435.1644940788815;
        Tue, 15 Feb 2022 07:59:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba14sm10735153wrb.56.2022.02.15.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:48 -0800 (PST)
Message-Id: <f19671f7defef336bdc567ae06da9d2e46c805b8.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:23 +0000
Subject: [PATCH 13/23] fsmonitor--daemon: print start message only if
 fsmonitor.announceStartup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fsmonitor--daemon to print a startup message only when
`fsmonitor.announceStartup` is true.  This setting is false by default
so that the output of client commands, like `git status`, is not
changed if the daemon is implicitly started.

The message is conditionally printed by "run" and "start" subcommands
and is sent to stderr.  It contains the path to the work tree root.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 899355c55aa..dd0561cfc51 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -27,6 +27,9 @@ static int fsmonitor__ipc_threads = 8;
 #define FSMONITOR__START_TIMEOUT "fsmonitor.starttimeout"
 static int fsmonitor__start_timeout_sec = 60;
 
+#define FSMONITOR__ANNOUNCE_STARTUP "fsmonitor.announcestartup"
+static int fsmonitor__announce_startup = 0;
+
 static int fsmonitor_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
@@ -47,6 +50,16 @@ static int fsmonitor_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, FSMONITOR__ANNOUNCE_STARTUP)) {
+		int is_bool;
+		int i = git_config_bool_or_int(var, value, &is_bool);
+		if (i < 0)
+			return error(_("value of '%s' not bool or int: %d"),
+				     var, i);
+		fsmonitor__announce_startup = i;
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -1307,9 +1320,11 @@ static int try_to_run_foreground_daemon(int free_console)
 		die("fsmonitor--daemon is already running '%s'",
 		    the_repository->worktree);
 
-	printf(_("running fsmonitor-daemon in '%s'\n"),
-	       the_repository->worktree);
-	fflush(stdout);
+	if (fsmonitor__announce_startup) {
+		fprintf(stderr, _("running fsmonitor-daemon in '%s'\n"),
+			the_repository->worktree);
+		fflush(stderr);
+	}
 
 #ifdef GIT_WINDOWS_NATIVE
 	if (free_console)
@@ -1360,9 +1375,11 @@ static int try_to_start_background_daemon(void)
 		die("fsmonitor--daemon is already running '%s'",
 		    the_repository->worktree);
 
-	printf(_("starting fsmonitor-daemon in '%s'\n"),
-	       the_repository->worktree);
-	fflush(stdout);
+	if (fsmonitor__announce_startup) {
+		fprintf(stderr, _("starting fsmonitor-daemon in '%s'\n"),
+			the_repository->worktree);
+		fflush(stderr);
+	}
 
 	cp.git_cmd = 1;
 
-- 
gitgitgadget

