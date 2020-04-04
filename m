Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5ABC43331
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E55D20731
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjmdPz6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDDBMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42701 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgDDBMM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id b10so2484136qtt.9
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2HKOVYzRAu8Mrh4ELprHup9MiSU2rtNWAsFcunWRz4=;
        b=KjmdPz6YvAY3wlIdlxZQ3oDgrGApIA2Zc41QYsYDhgaRJppX2CYVB4eHttpuIzTHtp
         VC1/IEnAqkGW+CU3h+fYSsldsCop/1ZT25M5tBGYgTPyh6U752vu5Tv5eBtdIroNzEmf
         Kob5ixEJDaD+pahKY+lK9T7otOYe5niAfT6MSSTripJjLjajr1WuitcU9nNVS6V+h7wL
         +aO99eReoWApx95Q2ZSORW0KYpcQrKk6LsjbSMTATesm/zKIR031YXdu2CNjLEQ1auSI
         nXJ6gzVlZJBHgrHFEhk6KNRSGWuKME3sf32xUE5vV0srfwT8uZcgnnChuNJbdz2tD69K
         0I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2HKOVYzRAu8Mrh4ELprHup9MiSU2rtNWAsFcunWRz4=;
        b=OJePEFmrH+UMBLXaRCdq/1u2712y6hsg5wPyaWVjKsDYJaDk7vg/iZFeWSt0Iockh8
         q0RmVpbgxg2BYOvPlHR+MqBvCFMFiR7UyxUutRRveUyv/3+V7JIOEP3sN3aNLYCRBY92
         5sZPD1RK8fhgQiQ8BbR4oxLdjLcjpbySubHPlhbRa0Myw5VTiQyQPGq4q/8S7pJYOWG/
         AtYtsvB/3c5BY3VcwEqAXCTjdg+CDr4Lhuc8z0guE5uZCcXGNE/gu2Ajok2ThA/2pc+x
         nCWFVngB1yY555/1cRXFRXp9AKT0XbpzMqegTbLq0dxFwJfJ3VNG2dUW/V4TVDccUicD
         321A==
X-Gm-Message-State: AGi0Pua3vfs0Y6LlBl7NHoDGTltqmMvaM/hTxaM6v2APICaXzRH+03+J
        HdeGD0iMwzyQC0S5glpMadPjdKQD
X-Google-Smtp-Source: APiQypKTS8UVQR/gJhrpATz9uLcTfxWQ+P3ZWIa3irS8ua1OXmN9DeZqkIbNxPzX6RRMq0dCz6BJSA==
X-Received: by 2002:ac8:2a0e:: with SMTP id k14mr11443367qtk.232.1585962731490;
        Fri, 03 Apr 2020 18:12:11 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:10 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 12/23] rebase: use apply_autostash() from sequencer.c
Date:   Fri,  3 Apr 2020 21:11:25 -0400
Message-Id: <389b17df334c3d9a8138b5db0ec15c81a8a6ce31.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
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
index 91873fa0b5..29745176cb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -707,51 +707,6 @@ static int rebase_write_basic_state(struct rebase_options *opts)
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
@@ -759,7 +714,7 @@ static int finish_rebase(struct rebase_options *opts)
 	int ret = 0;
 
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
-	apply_autostash(opts);
+	apply_autostash(state_dir_path("autostash", opts));
 	close_object_store(the_repository->objects);
 	/*
 	 * We ignore errors in 'gc --auto', since the
@@ -1204,7 +1159,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	} else if (status == 2) {
 		struct strbuf dir = STRBUF_INIT;
 
-		apply_autostash(opts);
+		apply_autostash(state_dir_path("autostash", opts));
 		strbuf_addstr(&dir, opts->state_dir);
 		remove_dir_recursively(&dir, 0);
 		strbuf_release(&dir);
diff --git a/sequencer.c b/sequencer.c
index 4b7985942d..dde1f6b30f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3649,7 +3649,7 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-static int apply_autostash(const char *path)
+int apply_autostash(const char *path)
 {
 	struct strbuf stash_oid = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
diff --git a/sequencer.h b/sequencer.h
index 1f6eda70b6..d6ba62a089 100644
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

