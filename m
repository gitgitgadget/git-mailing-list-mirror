Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02931C2BB55
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB05A207FF
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDdVcJNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgDGO2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37732 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgDGO2e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id 130so1802138qke.4
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7rob1mWGcVE1KDjaw3ZNwh6mElGTNX1Hs/jI6OLoJQ=;
        b=lDdVcJNrxY3pWcfwJTP7mCY2PzBGH2OETVAcMskQ6TB3iSraYMg5rA7ZP3F440d5tW
         gFbSWWngU/JLnYAxxfkzPM6EyESHvFcaCzPpvWLnDjIk88Izi6KFZtYbIsZrdoRXzito
         XXcJA6kgHu+4w3JyrfWtEz/ZN+uiPTcwdQnsXYHnFEV+1PbKyAnq95CBkXC5IMIMp+m/
         fW7xDOTzI0CAQfxk2Ahq94PjvkFI0h6QFUuEPwqVBJp1S16RxuD+TpSZZxLMiZtymF7M
         q5DQvPKXxvrVuqykLp4Pj++sW7q3qMlsN6KvVvV+krjlDZF8nKKaX9tBxZfYj35qKI7A
         v/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7rob1mWGcVE1KDjaw3ZNwh6mElGTNX1Hs/jI6OLoJQ=;
        b=lcsM6inGqGEA3wxj+AVKsecLqqdFE5+1H0uDwAk+u6qz4Ph2WnhoZwWWCYcMlHsV4J
         Zx6Y3IeN+GvuDubAVVtZTM43imXT02Zo/wOhbHQHIaL54ADLP5mdojM1enyv+W5OxN/q
         OW6Em+9Devl/fp7UnCpzWQ3WsEnAkwPfZYO2F2XlXt2og2e2rynfqeydXddqHCoKR7ux
         /Ssf8mFislcfakQwTB9olduiPsCTxOF+xlU+y+JKe1O9C+GRKvWmcQVwrC4PM2s1HIkV
         ohGwCxMw52oINiuQcqZ11p11P7M2xSJftuZjfVQfamj6RVyA87h6hGiI0cIVkSSIgpOH
         d4fA==
X-Gm-Message-State: AGi0PuZQA8HKCPZmynmMTSWIzZcnmW0EAW4KoQIJcKeW+g6PYPgl9/R0
        Tkcvey1cII6qKPQzqJ+5UMpB0Qwp
X-Google-Smtp-Source: APiQypLqby+Z9XYaeLflzLZ11BzlzuOTaS5iwUS7giVjm+Af27nwvWaWgmxPvU82MPA/2G1PZuO73w==
X-Received: by 2002:a37:67c4:: with SMTP id b187mr2488584qkc.209.1586269712300;
        Tue, 07 Apr 2020 07:28:32 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:31 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 11/22] rebase: use apply_autostash() from sequencer.c
Date:   Tue,  7 Apr 2020 10:27:58 -0400
Message-Id: <98a7f5280c12a3244d0c5d92d1b65d6de7be3cb5.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The apply_autostash() function in builtin/rebase.c is similar enough to
the apply_autostash() function in sequencer.c that they are almost
interchangeable, except for the type of arg they accept. Make the
sequencer.c version extern and use it in rebase.

The rebase version was introduced in 6defce2b02 (builtin rebase: support
`--autostash` option, 2018-09-04) as part of the shell to C conversion.
It opted to duplicate the function because, at the time, there was
another in-progress project converting interactive rebase from shell to
C as well and they did not want to clash with them by refactoring
sequencer.c version of apply_autostash(). Since both efforts are long
done, we can freely combine them together now.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 49 ++----------------------------------------------
 sequencer.c      |  2 +-
 sequencer.h      |  2 ++
 3 files changed, 5 insertions(+), 48 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 57dbfd2a4f..cb0bdfc3e4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -712,51 +712,6 @@ static int rebase_write_basic_state(struct rebase_options *opts)
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
-	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_MISSING))
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
@@ -764,7 +719,7 @@ static int finish_rebase(struct rebase_options *opts)
 	int ret = 0;
 
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
-	apply_autostash(opts);
+	apply_autostash(state_dir_path("autostash", opts));
 	close_object_store(the_repository->objects);
 	/*
 	 * We ignore errors in 'gc --auto', since the
@@ -1209,7 +1164,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	} else if (status == 2) {
 		struct strbuf dir = STRBUF_INIT;
 
-		apply_autostash(opts);
+		apply_autostash(state_dir_path("autostash", opts));
 		strbuf_addstr(&dir, opts->state_dir);
 		remove_dir_recursively(&dir, 0);
 		strbuf_release(&dir);
diff --git a/sequencer.c b/sequencer.c
index 4a6812e90e..f5bb1cc1fb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3657,7 +3657,7 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-static int apply_autostash(const char *path)
+int apply_autostash(const char *path)
 {
 	struct strbuf stash_oid = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
diff --git a/sequencer.h b/sequencer.h
index ab43717fd6..ab686146d1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -191,6 +191,8 @@ void commit_post_rewrite(struct repository *r,
 			 const struct commit *current_head,
 			 const struct object_id *new_head);
 
+int apply_autostash(const char *path);
+
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(struct repository *repo,
-- 
2.26.0.159.g23e2136ad0

