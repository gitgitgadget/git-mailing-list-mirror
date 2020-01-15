Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39825C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1269C2187F
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgdr76QM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgAOSHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:07:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54950 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgAOSHS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 13:07:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so935433wmj.4
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 10:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcQaygpDMrjoj9SdPfm5AKu2wrSIyemgZNNZgronOic=;
        b=Dgdr76QMCVDdz06RJS/HUXGy/QlWVU4fqx1e3dSOu2kAAHLsSXQn/YKKUFh2DAEFMP
         e9XMis4yCLN24KMHrN70jxuYapGiKr1nRaqdsaPjUOYh1EUUD3rwKNRoykEgYiFMB/N3
         4V53k2R4AgpbcvttzL6SAHu19mPJ2EzlgiKYgvipO/B/OIhmjG3gQGIQp2SzXKj8haCn
         VfDf9lWvd4OXzp4KVVtslvX6nOZNVDswpweb1b0sT+HH3E1G2MuxrICOkzajrexYvqUB
         Zq6m7LiSl7+5KSRPX/pcRi66iP06wboE7bFOAgOUXVj12U7rWS6KB2QTiMxl6bUnjsyn
         cW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcQaygpDMrjoj9SdPfm5AKu2wrSIyemgZNNZgronOic=;
        b=AyOCWQ5yJRNYpy+OKeW58YFbfCtAZgLXqQXfl6B1AteHDI0ZZQ22fL7U46JgeePCkH
         HH3IxiWKOiAmWDcn5uys2d+V1xLt4GrT9Pmh5oqLj6vBdGwEgiQ1smnNdKRmoDCPP/C0
         xEHqozMitweeuG2ttmjb2MLT6ijNnDDtHmlqcVaUL5E3zgW/Ujj7WO4olnb3BtNpBAol
         d0FnNTkK7hYOnvG2IhfIIffaHXJUpbjufQ1MOKeEbD6Q5W93RXN4aoy4YbbZPJA7lFhk
         xTc8Xu3AqwxFSrmgZqnobMaKnHXC6j2PNMqf6Sq1kt9XondbmtBgC5C71KUbVf8Kin81
         iJDA==
X-Gm-Message-State: APjAAAWrDmIEGi5vcdvWqg7Yg5wmveeiNF/Y44NGlH1RgI6wm63aHQeN
        PWRSq1+Qr7omG6jgEenTwZzQQ/2xQ2I=
X-Google-Smtp-Source: APXvYqzL+c4cLybjKcFxa4RVKaGmgxH21yiajsqTxgkjcQJ40fSK9Nleg45jZwJ9I90BtUWWYiOVEw==
X-Received: by 2002:a05:600c:251:: with SMTP id 17mr1176806wmj.88.1579111635580;
        Wed, 15 Jan 2020 10:07:15 -0800 (PST)
Received: from localhost (p200300DF4F0D39EBA4431EF49EB624BC.dip0.t-ipconnect.de. [2003:df:4f0d:39eb:a443:1ef4:9eb6:24bc])
        by smtp.gmail.com with ESMTPSA id v17sm25438935wrt.91.2020.01.15.10.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 10:07:14 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] submodule.c: mark more strings for translation
Date:   Wed, 15 Jan 2020 19:07:01 +0100
Message-Id: <20200115180701.14657-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 submodule.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/submodule.c b/submodule.c
index 9da7181321..9430db8ffc 100644
--- a/submodule.c
+++ b/submodule.c
@@ -431,7 +431,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 	else if (!strcmp(arg, "dirty"))
 		diffopt->flags.ignore_dirty_submodules = 1;
 	else if (strcmp(arg, "none"))
-		die("bad --ignore-submodules argument: %s", arg);
+		die(_("bad --ignore-submodules argument: %s"), arg);
 	/*
 	 * Please update _git_status() in git-completion.bash when you
 	 * add new options
@@ -812,9 +812,9 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 				submodule = submodule_from_name(me->repo,
 								commit_oid, name);
 			if (submodule) {
-				warning("Submodule in commit %s at path: "
+				warning(_("Submodule in commit %s at path: "
 					"'%s' collides with a submodule named "
-					"the same. Skipping it.",
+					"the same. Skipping it."),
 					oid_to_hex(commit_oid), p->two->path);
 				name = NULL;
 			}
@@ -844,7 +844,7 @@ static void collect_changed_submodules(struct repository *r,
 	repo_init_revisions(r, &rev, NULL);
 	setup_revisions(argv->argc, argv->argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 
 	while ((commit = get_revision(&rev))) {
 		struct rev_info diff_rev;
@@ -992,7 +992,7 @@ static int submodule_needs_pushing(struct repository *r,
 		cp.out = -1;
 		cp.dir = path;
 		if (start_command(&cp))
-			die("Could not run 'git rev-list <commits> --not --remotes -n 1' command in submodule %s",
+			die(_("Could not run 'git rev-list <commits> --not --remotes -n 1' command in submodule %s"),
 					path);
 		if (strbuf_read(&buf, cp.out, the_hash_algo->hexsz + 1))
 			needs_pushing = 1;
@@ -1115,7 +1115,7 @@ static void submodule_push_check(const char *path, const char *head,
 	 * child process.
 	 */
 	if (run_command(&cp))
-		die("process for submodule '%s' failed", path);
+		die(_("process for submodule '%s' failed"), path);
 }
 
 int push_unpushed_submodules(struct repository *r,
@@ -1155,10 +1155,10 @@ int push_unpushed_submodules(struct repository *r,
 	/* Actually push the submodules */
 	for (i = 0; i < needs_pushing.nr; i++) {
 		const char *path = needs_pushing.items[i].string;
-		fprintf(stderr, "Pushing submodule '%s'\n", path);
+		fprintf(stderr, _("Pushing submodule '%s'\n"), path);
 		if (!push_submodule(path, remote, rs,
 				    push_options, dry_run)) {
-			fprintf(stderr, "Unable to push submodule '%s'\n", path);
+			fprintf(stderr, _("Unable to push submodule '%s'\n"), path);
 			ret = 0;
 		}
 	}
@@ -1448,7 +1448,7 @@ static int get_next_submodule(struct child_process *cp,
 			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
-				strbuf_addf(err, "Fetching submodule %s%s\n",
+				strbuf_addf(err, _("Fetching submodule %s%s\n"),
 					    spf->prefix, ce->name);
 			argv_array_init(&cp->args);
 			argv_array_pushv(&cp->args, spf->args.argv);
@@ -1610,7 +1610,7 @@ int fetch_populated_submodules(struct repository *r,
 		goto out;
 
 	if (repo_read_index(r) < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
 
 	argv_array_push(&spf.args, "fetch");
 	for (i = 0; i < options->argc; i++)
@@ -1665,7 +1665,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	cp.out = -1;
 	cp.dir = path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain=2' in submodule %s", path);
+		die(_("Could not run 'git status --porcelain=2' in submodule %s"), path);
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
@@ -1706,7 +1706,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	fclose(fp);
 
 	if (finish_command(&cp) && !ignore_cp_exit_code)
-		die("'git status --porcelain=2' failed in submodule %s", path);
+		die(_("'git status --porcelain=2' failed in submodule %s"), path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
@@ -1841,7 +1841,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 	cp.no_stdout = 1;
 	cp.dir = sub->path;
 	if (start_command(&cp))
-		die("could not recurse into submodule '%s'", sub->path);
+		die(_("could not recurse into submodule '%s'"), sub->path);
 
 	return finish_command(&cp);
 }
@@ -1862,7 +1862,7 @@ static void submodule_reset_index(const char *path)
 	argv_array_push(&cp.args, empty_tree_oid_hex());
 
 	if (run_command(&cp))
-		die("could not reset submodule index");
+		die(_("could not reset submodule index"));
 }
 
 /**
-- 
2.25.0.341.g760bfbb309

