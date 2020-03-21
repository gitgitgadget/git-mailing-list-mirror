Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1AFC4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A882070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxky0aZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgCUJW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:27 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37753 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgCUJW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:27 -0400
Received: by mail-qv1-f65.google.com with SMTP id n1so4460933qvz.4
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YvtwJLP5tteu5dpCHs0ngn7N49g0vhrSuG1WRaxIPBk=;
        b=jxky0aZZgTk7OMfJDi/1r0wCZIV6kvXxridI+Z0u5sasniqoIQ8uhogvL4w2Yxsi0N
         GW7J2sYPnCiXnQdsyyZqiQyxXhwkCSpRH1D/C+LaxlMjGgqgsvin6Bwmg1daaFMXVBtA
         cgv0oALaqYUJHkBuomlOqrtTSVWGZvudVZwyqknjfd1Zg/D0g/xUDQ8yndhUj36u9Vla
         cr43WspDUlLRxXU+dy4tHO/gKckt27TkicwtAZoqZvPoH/crwlDsDld5ANbl8MnyYf+z
         WBm8K74J8WDiSGrn+0lk8uaVPc3rY5fXtXu5ar3Fih/LiphbFsh6N3SBYJ9+7P0xdCEP
         E0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YvtwJLP5tteu5dpCHs0ngn7N49g0vhrSuG1WRaxIPBk=;
        b=SZsxldqGRpKnkSjYCDjMlaJZeXFIgdwmyDvYl8pFgwQohARHQApfI2ygl/nl3mLITI
         zBhiG5nQFNuWywqwG0K/BShbGaS7IsevPRql/ng16J19NJIDKKVsRz8BWwlm+sWpejhb
         Q0KWkyrK0Z1n7rUWUD9anYMkezvX1z+se6sITRWHNBbKYoBBMrWBo43nXC91FKdnuhIB
         WPfrf2sy1aucGtHdoyYotWHHF3lSZWzkRLlaWP2CzJStL793KwXz8dXK7d5TVzBRJjGg
         o429vAdu+EoFy4dvIpOpO3jG8HZUcXKk7SQ6yHBG/O+YdKY+QSvsInh6Qao647jWE9LR
         L0lA==
X-Gm-Message-State: ANhLgQ0FZsbh/ahylthKJ8bO50Af2VFtsLeauPglbO5n4N2E9krr9SVg
        ntG3wQpC6DHfJ6Hx8Evtafu0/uk3
X-Google-Smtp-Source: ADFU+vvfqUGCMcYeF+yIA3+SsFBuFFvzxC3+XQTf1lZdZOK77AYe4EOnigZxjsHjxqeNu+UVn3LzRA==
X-Received: by 2002:a05:6214:68f:: with SMTP id r15mr11824750qvz.96.1584782545191;
        Sat, 21 Mar 2020 02:22:25 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:24 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 09/19] rebase: use apply_autostash() from sequencer.c
Date:   Sat, 21 Mar 2020 05:21:28 -0400
Message-Id: <03bdaeebc993058bf14a0d196f5a1a68800e538e.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The apply_autostash() function in builtin/rebase.c is similar enough to
the apply_autostash() function in sequencer.c that they are almost
interchangeable. Make the sequencer.c version extern and use it in
rebase.

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
index 1146463099..ceb115247a 100644
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
-	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_NON_EXISTENCE))
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
index ad40a8b3fc..b52668f8de 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3655,7 +3655,7 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-static int apply_autostash(const char *path)
+int apply_autostash(const char *path)
 {
 	struct strbuf stash_sha1 = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
diff --git a/sequencer.h b/sequencer.h
index 5c9662a60a..bab910f012 100644
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
2.25.0.114.g5b0ca878e0

