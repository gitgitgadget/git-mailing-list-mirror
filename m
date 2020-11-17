Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E47C63798
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 04:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E9324695
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 04:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHFsIfOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgKQEtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 23:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgKQEtj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 23:49:39 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3FC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 20:49:39 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 79so18236934otc.7
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 20:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RwPMoibEvv570TWTo9hX3p8pPMU4VfLBGzYtOpNvgCY=;
        b=WHFsIfOkwcSfUhmqXJv0ZiV1CMsfIGVz4caiJrLUK6oOXj8pxc0auxCadzptVAhWq0
         YJgHsk0dj4nkD7y61Amaq14GJ7qMakl0CUfv2kVKf2sBpS9rYxJsvJnD19tLj83VcpfL
         4dwA4EXz1N01b3wvYO/mtrNlbZrU/irfehDpVneG0Pa9Dg9Ec315lmRqRtQuTBHrnMA9
         6gaV8mpA9VINbvkWWIQKgKuityIAKpa/kvE9qRNzb6fAIhivt4qk96B83iM0p0Hxtt+o
         c1nWAWainfF6QYQSoAqQUl2kTYTA6ZGDmWHpk/fckjDwiDRDBPy4JFXjfqa0KuUEHskY
         BRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RwPMoibEvv570TWTo9hX3p8pPMU4VfLBGzYtOpNvgCY=;
        b=omwjYlF3uOlm64bC5Bt0sAH9vrX7XGE2Kbv/8+DrlMLIQN+aQVxRblMyvw6lRw+A+b
         ufCppM+RAiV7guJh4M+iYw9MBmXQIWTYQjsb+rPYGcV3bswznOYQ61SD2rsXr2dXkFLU
         SdPjRaCLQxq/Rm/k8NU1mn9dUG7zd0/OG9lHORbAd0avwPnSYYXs5kaSRM6xDTxuh3AP
         wXaNF6XW4CBYb7bXOlYkxChhk3cw4PI4cSeBRa4YKyg6WAjd69W7V0L57k8ka1YSEYQ7
         8WVMTADRP4m4WOvLiQeotexKUCztFKIbX2ch2t/6t55A71g+1kRhH1RXlsRyKyJw5zN6
         +s3A==
X-Gm-Message-State: AOAM530A+T9XGa20D5sqAU/c0qRotmaa1Ij+UePXujItSwLj9opdlvYM
        xd3JoaU66josChcZZqpJ7m0=
X-Google-Smtp-Source: ABdhPJxWMUV2xTBUWYh2F5UpP20COqFG0vr+MoJ7AZy8ZKtd9WDUnt/tTt9hhj87cbPJPBjHQ4CmqQ==
X-Received: by 2002:a05:6830:1dab:: with SMTP id z11mr1739236oti.247.1605588578388;
        Mon, 16 Nov 2020 20:49:38 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id r206sm5589694oih.14.2020.11.16.20.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 20:49:37 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] chdir-notify: UNLEAK registrated callback entries
Date:   Mon, 16 Nov 2020 20:49:23 -0800
Message-Id: <20201117044923.3703483-1-newren@gmail.com>
X-Mailer: git-send-email 2.29.2.529.gc090dab8c5
In-Reply-To: <58f36a04-afa7-3cf3-ce0a-ad53004dd774@web.de>
References: <58f36a04-afa7-3cf3-ce0a-ad53004dd774@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Nov 14, 2020 at 1:55 PM René Scharfe <l.s.r@web.de> wrote:
>
> Am 14.11.20 um 22:40 schrieb René Scharfe:
> > chdir_notify_register() allows registering functions to notify when
> > chdir() is called.  There is no way to unsubscribe or shut this
> > mechanism down, so these entries are present until the program ends.
> >
> > Valgrind reports allocations for these registrations as "possibly lost",
> > probably because it doesn't see through list.h's offsetof tricks.
>
> Right, avoiding list.h like below lets Valgrind classify the memory as
> "still reachable", without UNLEAK.  Not sure if it's worth it, though.
>
> Note my somewhat concerning knee-jerk reaction to write some macros. ;)

I've got a local patch that changes these to actually be freed as yet
another route we could go.  It's mixed with a few (half-baked)
revision-related memory cleanups that should be separated, and I'm
unsure if there are other places that would need a finalize_globals()
call too, but it's another approach to consider...


-- >8 --
Subject: [RFC PATCH] Make merge-ort run leak check free

Tweaks to revision walking, adding a chdir_deregister_all() (so that all
watchers can be cleared as well as free'ing their associated memory),
and maybe other stuff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-rebase.c |  2 ++
 cache.h               |  3 +++
 chdir-notify.c        | 15 +++++++++++++++
 chdir-notify.h        |  5 +++++
 git.c                 | 10 ++++++++--
 revision.c            | 11 +++++++++++
 revision.h            |  6 ++++++
 setup.c               |  5 +++++
 8 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-rebase.c b/builtin/fast-rebase.c
index 19333ca42d..32cab36ad3 100644
--- a/builtin/fast-rebase.c
+++ b/builtin/fast-rebase.c
@@ -173,6 +173,8 @@ int cmd_fast_rebase(int argc, const char **argv, const char *prefix)
 		last_commit = create_commit(result.tree, commit, last_commit);
 	}
 	fprintf(stderr, "\nDone.\n");
+	rev_info_free(&revs);
+	memset(&revs, 0, sizeof(revs));
 
 	merge_switch_to_result(&merge_opt, head_tree, &result, 1, !result.clean);
 
diff --git a/cache.h b/cache.h
index c0072d43b1..b9b543f75b 100644
--- a/cache.h
+++ b/cache.h
@@ -604,6 +604,9 @@ const char *setup_git_directory(void);
 char *prefix_path(const char *prefix, int len, const char *path);
 char *prefix_path_gently(const char *prefix, int len, int *remaining, const char *path);
 
+/* Release resources related to global config. */
+void finalize_globals(void);
+
 /*
  * Concatenate "prefix" (if len is non-zero) and "path", with no
  * connecting characters (so "prefix" should end with a "/").
diff --git a/chdir-notify.c b/chdir-notify.c
index 5f7f2c2ac2..ea7e52cfea 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -91,3 +91,18 @@ char *reparent_relative_path(const char *old_cwd,
 
 	return ret;
 }
+
+void chdir_deregister_all(void)
+{
+	struct list_head *pos, *tmp;
+
+	if (list_empty(&chdir_notify_entries))
+		return;
+
+	list_for_each_safe(pos, tmp, &chdir_notify_entries) {
+		struct chdir_notify_entry *e =
+			list_entry(pos, struct chdir_notify_entry, list);
+		free(e);
+	}
+	memset(&chdir_notify_entries, 0, sizeof(chdir_notify_entries));
+}
diff --git a/chdir-notify.h b/chdir-notify.h
index 366e4c1ee9..0cd3e1f633 100644
--- a/chdir-notify.h
+++ b/chdir-notify.h
@@ -70,4 +70,9 @@ char *reparent_relative_path(const char *old_cwd,
 			     const char *new_cwd,
 			     const char *path);
 
+/*
+ * Deregister all subscribers and free any associated memory.
+ */
+void chdir_deregister_all(void);
+
 #endif /* CHDIR_NOTIFY_H */
diff --git a/git.c b/git.c
index af84f11e69..4b04988909 100644
--- a/git.c
+++ b/git.c
@@ -358,6 +358,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			trace2_cmd_name("_run_shell_alias_");
 
 			ret = run_command(&child);
+			finalize_globals();
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
 
@@ -697,8 +698,11 @@ static void handle_builtin(int argc, const char **argv)
 	}
 
 	builtin = get_builtin(cmd);
-	if (builtin)
-		exit(run_builtin(builtin, argc, argv));
+	if (builtin) {
+		int result = run_builtin(builtin, argc, argv);
+		finalize_globals();
+		exit(result);
+	}
 	strvec_clear(&args);
 }
 
@@ -742,6 +746,7 @@ static void execv_dashed_external(const char **argv)
 	 * generic string as our trace2 command verb to indicate that we
 	 * launched a dashed command.
 	 */
+	finalize_globals();
 	if (status >= 0)
 		exit(status);
 	else if (errno != ENOENT)
@@ -796,6 +801,7 @@ static int run_argv(int *argcp, const char ***argv)
 			 */
 			i = run_command_v_opt_tr2(args.v, RUN_SILENT_EXEC_FAILURE |
 						  RUN_CLEAN_ON_EXIT | RUN_WAIT_AFTER_CLEAN, "git_alias");
+			finalize_globals();
 			if (i >= 0 || errno != ENOENT)
 				exit(i);
 			die("could not execute builtin %s", **argv);
diff --git a/revision.c b/revision.c
index c6e169e3eb..b4f276d854 100644
--- a/revision.c
+++ b/revision.c
@@ -1419,6 +1419,8 @@ static int limit_list(struct rev_info *revs)
 			slop = still_interesting(list, date, slop, &interesting_cache);
 			if (slop)
 				continue;
+			free_commit_list(list);
+			revs->commits = NULL;
 			break;
 		}
 		if (revs->min_age != -1 && (commit->date > revs->min_age) &&
@@ -3281,6 +3283,15 @@ static void set_children(struct rev_info *revs)
 	}
 }
 
+void rev_info_free(struct rev_info *revs)
+{
+	int i;
+
+	for (i = 0; i < revs->cmdline.nr; i++)
+		free((char*)revs->cmdline.rev[i].name);
+	free(revs->cmdline.rev);
+}
+
 void reset_revision_walk(void)
 {
 	clear_object_flags(SEEN | ADDED | SHOWN | TOPO_WALK_EXPLORED | TOPO_WALK_INDEGREE);
diff --git a/revision.h b/revision.h
index f6bf860d19..5dd98f2f6d 100644
--- a/revision.h
+++ b/revision.h
@@ -362,6 +362,12 @@ void repo_init_revisions(struct repository *r,
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
 
+/**
+ * Free information associated with a rev_info once no longer needed.
+ * Will not free revs itself.
+ */
+void rev_info_free(struct rev_info *revs);
+
 void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const struct option *options,
 			const char * const usagestr[]);
diff --git a/setup.c b/setup.c
index c04cd25a30..cd958f5f5c 100644
--- a/setup.c
+++ b/setup.c
@@ -1411,6 +1411,11 @@ void sanitize_stdfds(void)
 		close(fd);
 }
 
+void finalize_globals(void)
+{
+	chdir_deregister_all();
+}
+
 int daemonize(void)
 {
 #ifdef NO_POSIX_GOODIES
-- 
2.29.2.529.gc090dab8c5

