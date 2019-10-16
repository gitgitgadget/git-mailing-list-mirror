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
	by dcvr.yhbt.net (Postfix) with ESMTP id 20A2E1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 17:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbfJPR0f (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 13:26:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43503 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732755AbfJPR0d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 13:26:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so15134094pfo.10
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hAQkQ9aZCW2wfqvEjnnvopGc8cTOpMLvPfHQoMbd6l0=;
        b=Hsu/4hoLvIHzcmxkUUjfS02k+kauBGa8QZJ5sZg6rQFjg1lwHG9P1MCfuzeu9hNV15
         //bGpt6V8h4uRQKU5L1LspDHtz06LOUPfGa23Q/xYmTBvetdc0vl/su0WYlR1SIQaw+t
         U+UP2jDO5K88re1Vz3I00qJoOFGBgGEpP75TjJXHSuyxY0R7207EgFbXJEi7GkUCW+mC
         7XLCgzw+F719U5pGLPwN8kD4wMKhhSXzPTHwJtu4xQBj+VY5tD9Bwq7nvRvroBaGBBnD
         4IfKoz6Is9Z/3ejMx8uilvZ6ISPyr/BLC3fmE6O33arj+0s0FOsdp3BAI5g1qJJ7ZQ/g
         /Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hAQkQ9aZCW2wfqvEjnnvopGc8cTOpMLvPfHQoMbd6l0=;
        b=HL3raox49yfiAgRKCMYxugIYgwMzezhrH4+ElUNASmh+EB4BGRu8QydwIMvYp6h9xR
         mgJDxhCtUXdT2XP2PfCeoXGVp44BjgE52VvIPfwa89NLLWw1lK4gxT6uo/BkVEqV5g8j
         IokSvI8PRyOJR2RmohyGSAwrV+YytylbXDsl4622Er3bEvg6B5gVMqGBOQNz+NN5ke2l
         vsiC29sd/1Qi4pf/FuoPMoI/j+Pq/w0jDh8rmZff1IioeWTAjW3CibnQJUIJN/IFA0gb
         8+3M5tgRAy8/HA+qj3jOFuUycZMGjnMbdz8/6SFq9Bo6xyw+DXOTgRPyoJIGUxN+tjlZ
         DIGg==
X-Gm-Message-State: APjAAAXSWh2kfF01DwBD87hOFOAWQL2jEuDCoWdq0r15pVR+5GLNQx04
        RFdjD4qvweojB6+qCYSgjTMS5zio
X-Google-Smtp-Source: APXvYqx9RoDpj/NQfQiQLBfEICikCVYKL3tI/MFuPP6umsUkGtsnEXtrQLTX0LyAxWyz9HbGW36JJg==
X-Received: by 2002:aa7:8691:: with SMTP id d17mr46663531pfo.152.1571246792399;
        Wed, 16 Oct 2019 10:26:32 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id r21sm33939909pfc.27.2019.10.16.10.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:26:31 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:26:30 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 5/7] autostash: extract perform_autostash() from rebase
Message-ID: <0518b0b187245e807987457cd558a1ab38476c5c.1571246693.git.liu.denton@gmail.com>
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
 autostash.c      | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 autostash.h      |  1 +
 builtin/rebase.c | 44 +-------------------------------------------
 3 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/autostash.c b/autostash.c
index eb58e0c8a4..722cf78b12 100644
--- a/autostash.c
+++ b/autostash.c
@@ -12,6 +12,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "unpack-trees.h"
+#include "wt-status.h"
 
 int read_one(const char *path, struct strbuf *buf)
 {
@@ -150,6 +151,51 @@ int reset_head(struct object_id *oid, const char *action,
 	return ret;
 }
 
+void perform_autostash(const char *path)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct lock_file lock_file = LOCK_INIT;
+	int fd;
+
+	fd = hold_locked_index(&lock_file, 0);
+	refresh_cache(REFRESH_QUIET);
+	if (0 <= fd)
+		repo_update_index_if_able(the_repository, &lock_file);
+	rollback_lock_file(&lock_file);
+
+	if (has_unstaged_changes(the_repository, 1) ||
+	    has_uncommitted_changes(the_repository, 1)) {
+		struct child_process stash = CHILD_PROCESS_INIT;
+		struct object_id oid;
+
+		argv_array_pushl(&stash.args,
+				 "stash", "create", "autostash", NULL);
+		stash.git_cmd = 1;
+		stash.no_stdin = 1;
+		if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
+			die(_("Cannot autostash"));
+		strbuf_trim_trailing_newline(&buf);
+		if (get_oid(buf.buf, &oid))
+			die(_("Unexpected stash response: '%s'"),
+			    buf.buf);
+		strbuf_reset(&buf);
+		strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
+
+		if (safe_create_leading_directories_const(path))
+			die(_("Could not create directory for '%s'"),
+			    path);
+		write_file(path, "%s", oid_to_hex(&oid));
+		printf(_("Created autostash: %s\n"), buf.buf);
+		if (reset_head(NULL, "reset --hard",
+			       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
+			die(_("could not reset --hard"));
+
+		if (discard_index(the_repository->index) < 0 ||
+			repo_read_index(the_repository) < 0)
+			die(_("could not read index"));
+	}
+}
+
 int apply_autostash(const char *path)
 {
 	struct strbuf autostash = STRBUF_INIT;
diff --git a/autostash.h b/autostash.h
index 1406638166..e08ccb9881 100644
--- a/autostash.h
+++ b/autostash.h
@@ -18,6 +18,7 @@ int reset_head(struct object_id *oid, const char *action,
 	       const char *switch_to_branch, unsigned flags,
 	       const char *reflog_orig_head, const char *reflog_head);
 
+void perform_autostash(const char *path);
 int apply_autostash(const char *path);
 
 #endif
diff --git a/builtin/rebase.c b/builtin/rebase.c
index c3165896cc..c4decdfb5b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1797,49 +1797,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("could not read index"));
 
 	if (options.autostash) {
-		struct lock_file lock_file = LOCK_INIT;
-		int fd;
-
-		fd = hold_locked_index(&lock_file, 0);
-		refresh_cache(REFRESH_QUIET);
-		if (0 <= fd)
-			repo_update_index_if_able(the_repository, &lock_file);
-		rollback_lock_file(&lock_file);
-
-		if (has_unstaged_changes(the_repository, 1) ||
-		    has_uncommitted_changes(the_repository, 1)) {
-			const char *autostash =
-				state_dir_path("autostash", &options);
-			struct child_process stash = CHILD_PROCESS_INIT;
-			struct object_id oid;
-
-			argv_array_pushl(&stash.args,
-					 "stash", "create", "autostash", NULL);
-			stash.git_cmd = 1;
-			stash.no_stdin = 1;
-			strbuf_reset(&buf);
-			if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
-				die(_("Cannot autostash"));
-			strbuf_trim_trailing_newline(&buf);
-			if (get_oid(buf.buf, &oid))
-				die(_("Unexpected stash response: '%s'"),
-				    buf.buf);
-			strbuf_reset(&buf);
-			strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
-
-			if (safe_create_leading_directories_const(autostash))
-				die(_("Could not create directory for '%s'"),
-				    options.state_dir);
-			write_file(autostash, "%s", oid_to_hex(&oid));
-			printf(_("Created autostash: %s\n"), buf.buf);
-			if (reset_head(NULL, "reset --hard",
-				       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
-				die(_("could not reset --hard"));
-
-			if (discard_index(the_repository->index) < 0 ||
-				repo_read_index(the_repository) < 0)
-				die(_("could not read index"));
-		}
+		perform_autostash(state_dir_path("autostash", &options));
 	}
 
 	if (require_clean_work_tree(the_repository, "rebase",
-- 
2.23.0.897.g0a19638b1e

