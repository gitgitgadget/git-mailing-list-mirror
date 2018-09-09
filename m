Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A801F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeIINnq (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:46 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:44554 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeIINnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:45 -0400
Received: by mail-lj1-f181.google.com with SMTP id q127-v6so15380868ljq.11
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bC8ayET/N0NdU4XI2o2oyLXYbhW7piAshB/SkN9xtUU=;
        b=ANjttE6fhoQYCeC5vTiuFZT9TarhQhNUUrR3uWx9eFRP2y7udVu7R5w8YVT4HmtQUF
         j9rA7DkskgnW7kUR+ELOxSJOJMWC16CiehomLKiGxhffKObiG6WIBg6ocXD6cksOWSrM
         G2wLN6yHWe9ZhptVm+sHGWhp/OSy2GaHYE/CsYT7GBSDAQxCtfn5oNF1Sk4yS88QufZS
         C5EccCNr8mbuQeYRUHiyliohwx08n0i+t818xNUCSI1YmU7/rkDfT73Md3KLQBzBmFwP
         t1Z7qF1V/MzQ4nYEVh+I1lJ3lKiL6E850+LcXBlnQF39F+AHhkUzMN3oaZlqbHvo4EMU
         z3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bC8ayET/N0NdU4XI2o2oyLXYbhW7piAshB/SkN9xtUU=;
        b=IBQnT6KfhUgy6goEBwdbhV4scAjdhG7kUcCUhd+q8Q63O4CTKcGuJLSdBjqi9Ycnr0
         vmsm93bhJBdUNRK6EiGd2yHqw2EYd+5vP5s+RxB/ezBXgxmMuV4xMg+t57+qEZhJwks5
         CTFWWLXoR5NpxtY+pxbzS+JfJjPd9bCPwUWOKTxaWcqtfCjSPyiijlu+me8GiqqDrpYr
         cG+UwcLs3oa0q+8BfIlNGrvjgom4mTv8nIw9grkNp7T8NwCJRcCFgu/XBrjtpDk0Abpc
         oNa9hZL7d/NHMDkEo/mz9V5qNvM4eZCm4BYM14EdNR90GG1lOeUt4wzlEFgGllrKSwmZ
         RBnA==
X-Gm-Message-State: APzg51AwgTNVb6umYZv28N4lDh/CBF+aXWPcMdDCs9oeRPMPS8r5Wt1b
        pjrjh+FE3qsCVG72r19fFgU=
X-Google-Smtp-Source: ANB0VdZXV2xMsO6MGcw0P5MGG8ccib+OTswY7lVvx9AJ/BqmNHmRFRJjX/wObesDi//tJ17CUsLg1A==
X-Received: by 2002:a2e:5bd5:: with SMTP id m82-v6mr9851283lje.115.1536483286330;
        Sun, 09 Sep 2018 01:54:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/23] merge.c: remove implicit dependency on the_index
Date:   Sun,  9 Sep 2018 10:54:08 +0200
Message-Id: <20180909085418.31531-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/merge.c |  8 +++++---
 builtin/pull.c  |  7 +++++--
 cache.h         |  6 ++++--
 merge.c         | 20 +++++++++++---------
 sequencer.c     |  6 +++---
 5 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 592cb19caf..5f79fc5fd7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -728,8 +728,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
 	} else {
-		return try_merge_command(strategy, xopts_nr, xopts,
-						common, head_arg, remoteheads);
+		return try_merge_command(the_repository,
+					 strategy, xopts_nr, xopts,
+					 common, head_arg, remoteheads);
 	}
 }
 
@@ -1470,7 +1471,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			goto done;
 		}
 
-		if (checkout_fast_forward(&head_commit->object.oid,
+		if (checkout_fast_forward(the_repository,
+					  &head_commit->object.oid,
 					  &commit->object.oid,
 					  overwrite_ignore)) {
 			ret = 1;
diff --git a/builtin/pull.c b/builtin/pull.c
index 681c127a07..33b7100837 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -562,7 +562,9 @@ static int pull_into_void(const struct object_id *merge_head,
 	 * index/worktree changes that the user already made on the unborn
 	 * branch.
 	 */
-	if (checkout_fast_forward(the_hash_algo->empty_tree, merge_head, 0))
+	if (checkout_fast_forward(the_repository,
+				  the_hash_algo->empty_tree,
+				  merge_head, 0))
 		return 1;
 
 	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
@@ -915,7 +917,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"fast-forwarding your working tree from\n"
 			"commit %s."), oid_to_hex(&orig_head));
 
-		if (checkout_fast_forward(&orig_head, &curr_head, 0))
+		if (checkout_fast_forward(the_repository, &orig_head,
+					  &curr_head, 0))
 			die(_("Cannot fast-forward your working tree.\n"
 				"After making sure that you saved anything precious from\n"
 				"$ git diff %s\n"
diff --git a/cache.h b/cache.h
index 260e4ee44a..49fe83331c 100644
--- a/cache.h
+++ b/cache.h
@@ -1716,10 +1716,12 @@ extern struct startup_info *startup_info;
 
 /* merge.c */
 struct commit_list;
-int try_merge_command(const char *strategy, size_t xopts_nr,
+int try_merge_command(struct repository *r,
+		const char *strategy, size_t xopts_nr,
 		const char **xopts, struct commit_list *common,
 		const char *head_arg, struct commit_list *remotes);
-int checkout_fast_forward(const struct object_id *from,
+int checkout_fast_forward(struct repository *r,
+			  const struct object_id *from,
 			  const struct object_id *to,
 			  int overwrite_ignore);
 
diff --git a/merge.c b/merge.c
index e30e03fb84..91008f7602 100644
--- a/merge.c
+++ b/merge.c
@@ -14,7 +14,8 @@ static const char *merge_argument(struct commit *commit)
 	return oid_to_hex(commit ? &commit->object.oid : the_hash_algo->empty_tree);
 }
 
-int try_merge_command(const char *strategy, size_t xopts_nr,
+int try_merge_command(struct repository *r,
+		      const char *strategy, size_t xopts_nr,
 		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
 {
@@ -35,15 +36,16 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
 
-	discard_cache();
-	if (read_cache() < 0)
+	discard_index(r->index);
+	if (read_index(r->index) < 0)
 		die(_("failed to read the cache"));
-	resolve_undo_clear();
+	resolve_undo_clear_index(r->index);
 
 	return ret;
 }
 
-int checkout_fast_forward(const struct object_id *head,
+int checkout_fast_forward(struct repository *r,
+			  const struct object_id *head,
 			  const struct object_id *remote,
 			  int overwrite_ignore)
 {
@@ -54,7 +56,7 @@ int checkout_fast_forward(const struct object_id *head,
 	struct dir_struct dir;
 	struct lock_file lock_file = LOCK_INIT;
 
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 
 	if (hold_locked_index(&lock_file, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
@@ -86,8 +88,8 @@ int checkout_fast_forward(const struct object_id *head,
 	}
 
 	opts.head_idx = 1;
-	opts.src_index = &the_index;
-	opts.dst_index = &the_index;
+	opts.src_index = r->index;
+	opts.dst_index = r->index;
 	opts.update = 1;
 	opts.verbose_update = 1;
 	opts.merge = 1;
@@ -101,7 +103,7 @@ int checkout_fast_forward(const struct object_id *head,
 	}
 	clear_unpack_trees_porcelain(&opts);
 
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index 84bf598c3e..47d0e7b0bd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -470,8 +470,8 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
-	read_cache();
-	if (checkout_fast_forward(from, to, 1))
+	read_index(&the_index);
+	if (checkout_fast_forward(the_repository, from, to, 1))
 		return -1; /* the callee should have complained already */
 
 	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
@@ -1798,7 +1798,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(opts->strategy,
+		res |= try_merge_command(the_repository, opts->strategy,
 					 opts->xopts_nr, (const char **)opts->xopts,
 					common, oid_to_hex(&head), remotes);
 		free_commit_list(common);
-- 
2.19.0.rc0.337.ge906d732e7

