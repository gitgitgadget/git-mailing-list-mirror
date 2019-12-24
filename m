Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C1C2D0D0
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890E520706
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlPej5oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfLXLF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:05:56 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46037 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfLXLFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:55 -0500
Received: by mail-qt1-f196.google.com with SMTP id l12so17838809qtq.12
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBMHWZJ9hO7pdb+IpMcFoxe2MgW66NHF+kCOzu/bud4=;
        b=MlPej5ojiFg9bvAlVrR6jFqbyTH9s7sneBeITVE2gi6fCfVPFqeMrAxuDlh8uko6uA
         FPGJvFDi12H/x8Vo4Shaly3VZQic9B7MvhnWv98SVcTvpUwLIKZWwHF8+Pe4ixTswGPr
         Y6jwuBZq0MjGQLIJ6d4Q3EbKmlNvr9f1xi0YsfAjH/wBzzIeswj8M96w4g5dZW1wncjS
         UNyEe0IH9MK3kA54QPTFp3ETN9cd/Lr05NGa4SABOdsGLPzhZxqh2JJzvu31ujjGyLc6
         11yljr2ooZcXk9Dax4Yf99rvLe6Oy6SxGF7odialtdbHqQGDsKOIgQxtDjrYIB7KxyGx
         IGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBMHWZJ9hO7pdb+IpMcFoxe2MgW66NHF+kCOzu/bud4=;
        b=kSNXscm+guDfu2XfwzbEw6z19WmT80D4KcXSMyellFhiMAQXL9ra+uZzJ6yprJbcyc
         QrI4MJjXg5JZuGZJ5MREqj3ZjuFsb0k9xfF8iLxoVm+OiLVUB8DnpaLwsEfdHPQBZ+DZ
         Q0sEYNuQvEMCUiLuLA3T4JOZUdDcPbJg7pdEndU8wGzbRZZyw/vD0R7jtGGyvmgxIKLq
         mlNbQHVd/6oVN6hLGvVZ1+vTBrx3ic8tkT5YpP2KIbA+duK/bAloY+LnJZcL7+cWinlp
         u6UQv0C2rf/6RCNF/qkKLCQOokm3lgRVZ6WomITR6P0Mb9aRKpiKEwa0dCu4HE+lF6/+
         1drA==
X-Gm-Message-State: APjAAAVV8Io2VDsJF66+DYpwZKC1vhu5onyfh0QNavEQHWDlnvV37fum
        MgvBiLxfAwnL53ySIUeLYcKas7Fm
X-Google-Smtp-Source: APXvYqwCYLzM6CwqV5LkCK0dwl00V5sUfJY76Eh4g7dMaVKOmKPj9jL2X+80q5Pwhm9Tb81VbqFHng==
X-Received: by 2002:aed:33c5:: with SMTP id v63mr21478443qtd.298.1577185554206;
        Tue, 24 Dec 2019 03:05:54 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:53 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 08/17] rebase: use apply_autostash() from sequencer.c
Date:   Tue, 24 Dec 2019 06:05:05 -0500
Message-Id: <893a2f9825f8a9640b747048f1c7de37c8c12cce.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
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
index 68bedccb95..07674a16d8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -700,51 +700,6 @@ static int rebase_write_basic_state(struct rebase_options *opts)
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
-	if (!read_oneliner(&autostash, path, 0, 1))
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
@@ -752,7 +707,7 @@ static int finish_rebase(struct rebase_options *opts)
 	int ret = 0;
 
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
-	apply_autostash(opts);
+	apply_autostash(state_dir_path("autostash", opts));
 	close_object_store(the_repository->objects);
 	/*
 	 * We ignore errors in 'gc --auto', since the
@@ -1206,7 +1161,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	} else if (status == 2) {
 		struct strbuf dir = STRBUF_INIT;
 
-		apply_autostash(opts);
+		apply_autostash(state_dir_path("autostash", opts));
 		strbuf_addstr(&dir, opts->state_dir);
 		remove_dir_recursively(&dir, 0);
 		strbuf_release(&dir);
diff --git a/sequencer.c b/sequencer.c
index e1b7cb461c..98e08dbbe0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3744,7 +3744,7 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-static int apply_autostash(const char *path)
+int apply_autostash(const char *path)
 {
 	struct strbuf stash_sha1 = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
diff --git a/sequencer.h b/sequencer.h
index 56cea80dd8..ecef2c144c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -195,6 +195,8 @@ void commit_post_rewrite(struct repository *r,
 int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
 				 const char *commit);
 
+int apply_autostash(const char *path);
+
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(struct repository *repo,
-- 
2.24.1.810.g65a2f617f4

