Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72624C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbhK3VmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344249AbhK3VmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:42:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D401C06175E
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:29 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o13so47334722wrs.12
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1toHONEK16LBgCnu8vhMrQcFwTgpK8KEj4GJ37b9cJc=;
        b=XCMU27adlsqteS1ZBsOUZHxl15QcNZH5TsrvSAcdb/cbMDIex//k3bei5M86o4guZ7
         9R+jCrJp6+q5gnkVEU+WjEgHUPFlkf7sqhLAYTUSKFKFHr5ABTcFWZtJtBnm9Mp/GpWb
         8LzDGUJomh0ofZxvtpUB/BcNHW1CR+ZU0PX+Kbe9bvxn/4IVwJgGM0w8wdGhYSQUKYz0
         UaHQbhqWgF3cIvTR6PR6EP1WXOAR96u90HxDUSU7xHBMCS+KJg5RIdxIxsDxb2+UYx3b
         FbqOMA/xqMXA2D4aRWzha8HVq4WKsuZagO2DGw+EFj+FgSul37qFoUFsqC0l37xZvW1h
         I/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1toHONEK16LBgCnu8vhMrQcFwTgpK8KEj4GJ37b9cJc=;
        b=SqY6UCfyW2gT0iHRkGWvJcoCHZpwGigR/7qbUtBQFqIx5MgpydKbcea9CWWMqFmO4b
         eWl3hxYWpX1l4pVbcHRv9YZmCi84gtoSdE5RBgeoX/QBsyaH3gNGJpBiw52E2vNQlZsc
         z/9vbWMNAetoIB38DtvxO5hSx6mxlW6PW9Jg2H04ynBecT++SynPFNALwTFlIHA981uT
         ZrVU1MNiOo62bL1QhY5V0NdKjQ1yJNZvB3oapXtRT9ZQ1DMgBy68HZ1YoIyWXxK+FYTB
         yEzY0MpByBdM7nthRFeYNtlnr+lZDNG8wNVtM4yMFbp9l23/zJimHOJ8pA0ovaaMQ8N0
         lRMQ==
X-Gm-Message-State: AOAM533eQnaF58F3OzVjks1+LLnb/3bhUbb++8qgU0DMjV+o2+hv0fZx
        NJf+xrF/7fkXIm0iD7c3jGSwYMGFUjSP3Q==
X-Google-Smtp-Source: ABdhPJyT4KxJDEqdw1ke0fRTGyjeZy5Uthi95eK6YFgxZfz8UOYhkS4wALnZyauw5Nr1k1cXHJtNxw==
X-Received: by 2002:a5d:47c7:: with SMTP id o7mr1711787wrc.204.1638308307809;
        Tue, 30 Nov 2021 13:38:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:38:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/12] reflog expire: add progress output on --stale-fix
Date:   Tue, 30 Nov 2021 22:38:12 +0100
Message-Id: <patch-10.12-f54dee1f1cc-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add progress output when the "git reflog expire --stale-fix" option is
used. This output was previously only emitted under --verbose, but we
shouldn't treat it the same way as the actually verbose "--verbose"
output emitted in should_expire_reflog_ent().

Note that this code isn't going to be affected by the sort of bug we
had to fix in 6b89a34c89f (gc: fix regression in 7b0f229222 impacting
--quiet, 2018-09-19). I.e. "git gc" won't call it with the
"--stale-fix" flag, that option is purely used as a one-off.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-reflog.txt |  8 ++++++++
 builtin/reflog.c             | 18 +++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index ff487ff77d3..1735bbea9fb 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -69,6 +69,14 @@ Options for `show`
 Options for `expire`
 ~~~~~~~~~~~~~~~~~~~~
 
+--progress::
+--no-progress::
+	Progress status is reported on the standard error stream by
+	default when it is attached to a terminal. The `--progress
+	flag enables progress reporting even if not attached to a
+	terminal. Supplying `--no-progress` will suppress all progress
+	output.
+
 --all::
 	Process the reflogs of all references.
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index a77c0d96dce..cf0ef68d82d 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -11,6 +11,7 @@
 #include "revision.h"
 #include "reachable.h"
 #include "worktree.h"
+#include "progress.h"
 
 /* NEEDSWORK: switch to using parse_options */
 static const char reflog_expire_usage[] =
@@ -551,6 +552,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	int explicit_expiry = 0;
 	unsigned int flags = 0;
 	int verbose = 0;
+	int show_progress = -1;
 
 	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
 	default_reflog_expire = now - 90 * 24 * 3600;
@@ -579,6 +581,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		}
 		else if (!strcmp(arg, "--stale-fix"))
 			cmd.stalefix = 1;
+		else if (!strcmp(arg, "--progress"))
+			show_progress = 1;
+		else if (!strcmp(arg, "--no-progress"))
+			show_progress = 0;
 		else if (!strcmp(arg, "--rewrite"))
 			flags |= EXPIRE_REFLOGS_REWRITE;
 		else if (!strcmp(arg, "--updateref"))
@@ -598,6 +604,8 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else
 			break;
 	}
+	if (show_progress == -1)
+		show_progress = isatty(2);
 
 	/*
 	 * We can trust the commits and objects reachable from refs
@@ -606,16 +614,16 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	 */
 	if (cmd.stalefix) {
 		struct rev_info revs;
+		struct progress *progress = NULL;
 
+		if (show_progress)
+			progress = start_delayed_progress(_("Marking reachable objects"), 0);
 		repo_init_revisions(the_repository, &revs, prefix);
 		revs.do_not_die_on_missing_tree = 1;
 		revs.ignore_missing = 1;
 		revs.ignore_missing_links = 1;
-		if (verbose)
-			printf(_("Marking reachable objects..."));
-		mark_reachable_objects(&revs, 0, 0, NULL);
-		if (verbose)
-			putchar('\n');
+		mark_reachable_objects(&revs, 0, 0, progress);
+		stop_progress(&progress);
 	}
 
 	if (do_all) {
-- 
2.34.1.877.g7d5b0a3b8a6

