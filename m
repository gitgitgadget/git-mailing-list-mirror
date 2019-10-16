Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381321F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 17:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbfJPR0b (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 13:26:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35453 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfJPR0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 13:26:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so15162035pfw.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KZBL1oOdYtK3WGeF8pjAVUpb6IvoeWgeD3f+WKU0wNc=;
        b=hsNxLLNIf76yot02B+daM7xK8M2EETMv8dxwonOhB0PwC0VjGQFdOEbU/AL6HkQd+2
         +vnyOn/37qcdiKR4+vw2ZZsuKawdQ+sp4sx//phZWWE79neSimcEfatBoqTmwUu2vLOu
         Yhanc5VtbarcT1eh8Gn2hHpY3I4j5nIbAVl/LMyeyB2+Jt+2AzNvwEpRqNqchwiZBODB
         btFgiBRM05pbN87p6XNsZcx+bunToWH5yg4dmohq12Zs8A6gghwwsZ/UFaov0YGDz2yd
         ozQitmLuq7+ExxJpAgQ5JpgOz2vdenRWZsSYspXw3tgRrEMHla+8uh90/XttzWlWzyj5
         0cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZBL1oOdYtK3WGeF8pjAVUpb6IvoeWgeD3f+WKU0wNc=;
        b=MBtyeRav3BhgfrxoZss4tDuZj3Ko8ZCZiEAa0A0x05OAMHAei7YRuZzDWcC5P5oVEb
         PjVgywj2ibgAuJIMpD+VXh+ntPvVujrtbnbLwQhUM8Sbm2yzJazQWyjHndrAwG4F18cz
         2P1PX9FeyLvmUIkKbYDhmgamUPfZS1/tbYgGvmWIkimwqnPWxKgqr1U3g20SfzEya0Vs
         LEW2ZuC35Ja9s6xVIqUyMFjVHhEoGcx4+XAdIEtd71dCVi67tnu9JnSAmRkpPZ8C7BQ7
         K6h2PnconbFZW65/ohZMkKAeRn8j+0QIiNJIG4grsUC7VjrxIWww1q1Roz9acekQF6hz
         z7NA==
X-Gm-Message-State: APjAAAUctRn4yQAdg/NgvTTDjTQ9vAf8E2ol5iRrYwWLfCklqhlWhU98
        NqiTam5NqSjpY5q/EjwV3oqqnNaB
X-Google-Smtp-Source: APXvYqxOGVRJ/urCXvvyCGyjzOJ93Y7rdslUOfSvDk5apni7JtF4SnmOeIR03dBkRL5ECJmrc+Y5BA==
X-Received: by 2002:a17:90a:28a2:: with SMTP id f31mr6339373pjd.125.1571246787754;
        Wed, 16 Oct 2019 10:26:27 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id l11sm13237811pgf.73.2019.10.16.10.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:26:27 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:26:25 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 3/7] autostash: extract apply_autostash() from rebase
Message-ID: <0f2f22ad2147b5a8649f351fbde40b22b6dbc46a.1571246693.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571246693.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the process of lib-ifying the autostash code. In a future
commit, this will be used to implement `--autostash` in other builtins.

This patch is best viewed with `--color-moved` and
`--color-moved-ws=allow-indentation-change`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 autostash.c      | 46 +++++++++++++++++++++++++++++++++++++++++++++
 autostash.h      |  2 ++
 builtin/rebase.c | 49 ++----------------------------------------------
 3 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/autostash.c b/autostash.c
index a6898e0fda..62ec7a7c80 100644
--- a/autostash.c
+++ b/autostash.c
@@ -1,6 +1,8 @@
 #include "git-compat-util.h"
 #include "autostash.h"
+#include "dir.h"
 #include "gettext.h"
+#include "run-command.h"
 #include "strbuf.h"
 
 int read_one(const char *path, struct strbuf *buf)
@@ -10,3 +12,47 @@ int read_one(const char *path, struct strbuf *buf)
 	strbuf_trim_trailing_newline(buf);
 	return 0;
 }
+
+int apply_autostash(const char *path)
+{
+	struct strbuf autostash = STRBUF_INIT;
+	struct child_process stash_apply = CHILD_PROCESS_INIT;
+
+	if (!file_exists(path))
+		return 0;
+
+	if (read_one(path, &autostash))
+		return error(_("Could not read '%s'"), path);
+	/* Ensure that the hash is not mistaken for a number */
+	strbuf_addstr(&autostash, "^0");
+	argv_array_pushl(&stash_apply.args,
+			 "stash", "apply", autostash.buf, NULL);
+	stash_apply.git_cmd = 1;
+	stash_apply.no_stderr = stash_apply.no_stdout =
+		stash_apply.no_stdin = 1;
+	if (!run_command(&stash_apply))
+		printf(_("Applied autostash.\n"));
+	else {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		int res = 0;
+
+		argv_array_pushl(&args,
+				 "stash", "store", "-m", "autostash", "-q",
+				 autostash.buf, NULL);
+		if (run_command_v_opt(args.argv, RUN_GIT_CMD))
+			res = error(_("Cannot store %s"), autostash.buf);
+		argv_array_clear(&args);
+		strbuf_release(&autostash);
+		if (res)
+			return res;
+
+		fprintf(stderr,
+			_("Applying autostash resulted in conflicts.\n"
+			  "Your changes are safe in the stash.\n"
+			  "You can run \"git stash pop\" or \"git stash drop\" "
+			  "at any time.\n"));
+	}
+
+	strbuf_release(&autostash);
+	return 0;
+}
diff --git a/autostash.h b/autostash.h
index 4a8f504f12..5f4e4bd22c 100644
--- a/autostash.h
+++ b/autostash.h
@@ -6,4 +6,6 @@
 /* Read one file, then strip line endings */
 int read_one(const char *path, struct strbuf *buf);
 
+int apply_autostash(const char *path);
+
 #endif
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 9fd7de6b2f..661928d427 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -682,51 +682,6 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 	return 0;
 }
 
-static int apply_autostash(struct rebase_options *opts)
-{
-	const char *path = state_dir_path("autostash", opts);
-	struct strbuf autostash = STRBUF_INIT;
-	struct child_process stash_apply = CHILD_PROCESS_INIT;
-
-	if (!file_exists(path))
-		return 0;
-
-	if (read_one(path, &autostash))
-		return error(_("Could not read '%s'"), path);
-	/* Ensure that the hash is not mistaken for a number */
-	strbuf_addstr(&autostash, "^0");
-	argv_array_pushl(&stash_apply.args,
-			 "stash", "apply", autostash.buf, NULL);
-	stash_apply.git_cmd = 1;
-	stash_apply.no_stderr = stash_apply.no_stdout =
-		stash_apply.no_stdin = 1;
-	if (!run_command(&stash_apply))
-		printf(_("Applied autostash.\n"));
-	else {
-		struct argv_array args = ARGV_ARRAY_INIT;
-		int res = 0;
-
-		argv_array_pushl(&args,
-				 "stash", "store", "-m", "autostash", "-q",
-				 autostash.buf, NULL);
-		if (run_command_v_opt(args.argv, RUN_GIT_CMD))
-			res = error(_("Cannot store %s"), autostash.buf);
-		argv_array_clear(&args);
-		strbuf_release(&autostash);
-		if (res)
-			return res;
-
-		fprintf(stderr,
-			_("Applying autostash resulted in conflicts.\n"
-			  "Your changes are safe in the stash.\n"
-			  "You can run \"git stash pop\" or \"git stash drop\" "
-			  "at any time.\n"));
-	}
-
-	strbuf_release(&autostash);
-	return 0;
-}
-
 static int finish_rebase(struct rebase_options *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
@@ -734,7 +689,7 @@ static int finish_rebase(struct rebase_options *opts)
 	int ret = 0;
 
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
-	apply_autostash(opts);
+	apply_autostash(state_dir_path("autostash", opts));
 	close_object_store(the_repository->objects);
 	/*
 	 * We ignore errors in 'gc --auto', since the
@@ -1181,7 +1136,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	} else if (status == 2) {
 		struct strbuf dir = STRBUF_INIT;
 
-		apply_autostash(opts);
+		apply_autostash(state_dir_path("autostash", opts));
 		strbuf_addstr(&dir, opts->state_dir);
 		remove_dir_recursively(&dir, 0);
 		strbuf_release(&dir);
-- 
2.23.0.897.g0a19638b1e

