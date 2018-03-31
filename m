Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 159391F404
	for <e@80x24.org>; Sat, 31 Mar 2018 15:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeCaPOt (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 11:14:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54088 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeCaPOr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 11:14:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id p9so19234601wmc.3
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VIxryRWjgEcmMWUe+FP/+uM9Wygnoes353SHTOb9j8w=;
        b=HlmCaAxOA+eW/auYAMT9u7QM+7syTJluoztE4Bj+avxAkVhxgOhuogwV7wClE4MCF4
         IeveU5H6zbL5T7LVfxb8XqgQuNMNNibo2ZKMj/MiCXmT1aAF09z48OoyIXXV9cc/5Hr6
         zKBN7cWtny1CvjuraAFA5ek7A96lLs3+HtwTHAq/S05xfgl55QYKd1CWQ6QyaMKxMTqc
         9XO+brUekFe5Pxb0K/Y+qappes1E63SrQ4/h/fX2MRhMp6Tvo52EWeQCxJSldgqxYaRO
         p8NSGJEz4NBD0MpvXxH64QqRy9QDR0zDqevyodTflLrhfkvxgWw4HvmUHI6J6SPN4MsY
         2Qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VIxryRWjgEcmMWUe+FP/+uM9Wygnoes353SHTOb9j8w=;
        b=cmHB6x0uF/1I+17vauwbvix8mlaQEGh84fyBjGO1iG28+zHF0AO2uIvHPd6CFJwZDD
         Qifm/5YzdqrY2kX+xygWr3snIGPx3czW4prX+mqO2kcsp4AZiYqtH2t1qJ8WiCx+hCX1
         2w4eSpwQ5iihcLCYAFuTMqC4jBP7mnvlWIGreovmZ+l/BZ7snxG9h0boDxT7ntyireOg
         +XO3SR5FHudxbJ33alhh4xabGsj0i8eozLDDDccnm/YRSdcLVI9cGCbSVgbD2N6G2YCk
         JYjr/P/D7iZIxps5MpASg5iEi8e9krRxw5NSe9YUogcviKw4B3HJIAZYScZOMD3CfvDu
         CA7w==
X-Gm-Message-State: AElRT7G9+M/+ffguYG6v7ebox08tyG0KVl6mQ4zH7dhLWkBtgHmp9eaD
        HlXyAJvzVmGsfaHcKTLiiAoU52ou
X-Google-Smtp-Source: AIpwx48cTsCz6dkrHM9Dn3/Col9yDLg1tD20HG+PvHoc0PkUTX6mmKnzItVOAE75Agfy6grDfyAcXg==
X-Received: by 10.28.7.133 with SMTP id 127mr4502192wmh.74.1522509285379;
        Sat, 31 Mar 2018 08:14:45 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id s15sm11518423wrg.28.2018.03.31.08.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 08:14:44 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 1/6] worktree: remove extra members from struct add_opts
Date:   Sat, 31 Mar 2018 16:17:59 +0100
Message-Id: <20180331151804.30380-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.78.ga2082135d8
In-Reply-To: <20180331151804.30380-1-t.gummerer@gmail.com>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two members of 'struct add_opts', which are only used inside
the 'add()' function, but being part of 'struct add_opts' they are
needlessly also passed to the 'add_worktree' function.

Make them local to the 'add()' function to make it clearer where they
are used.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..4d96a21a45 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -27,8 +27,6 @@ struct add_opts {
 	int detach;
 	int checkout;
 	int keep_locked;
-	const char *new_branch;
-	int force_new_branch;
 };
 
 static int show_only;
@@ -363,10 +361,11 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *new_branch_force = NULL;
 	char *path;
 	const char *branch;
+	const char *new_branch = NULL;
 	const char *opt_track = NULL;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
-		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+		OPT_STRING('b', NULL, &new_branch, N_("branch"),
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
@@ -384,7 +383,7 @@ static int add(int ac, const char **av, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.checkout = 1;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
-	if (!!opts.detach + !!opts.new_branch + !!new_branch_force > 1)
+	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("-b, -B, and --detach are mutually exclusive"));
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
@@ -395,33 +394,32 @@ static int add(int ac, const char **av, const char *prefix)
 	if (!strcmp(branch, "-"))
 		branch = "@{-1}";
 
-	opts.force_new_branch = !!new_branch_force;
-	if (opts.force_new_branch) {
+	if (new_branch_force) {
 		struct strbuf symref = STRBUF_INIT;
 
-		opts.new_branch = new_branch_force;
+		new_branch = new_branch_force;
 
 		if (!opts.force &&
-		    !strbuf_check_branch_ref(&symref, opts.new_branch) &&
+		    !strbuf_check_branch_ref(&symref, new_branch) &&
 		    ref_exists(symref.buf))
 			die_if_checked_out(symref.buf, 0);
 		strbuf_release(&symref);
 	}
 
-	if (ac < 2 && !opts.new_branch && !opts.detach) {
+	if (ac < 2 && !new_branch && !opts.detach) {
 		int n;
 		const char *s = worktree_basename(path, &n);
-		opts.new_branch = xstrndup(s, n);
+		new_branch = xstrndup(s, n);
 		if (guess_remote) {
 			struct object_id oid;
 			const char *remote =
-				unique_tracking_name(opts.new_branch, &oid);
+				unique_tracking_name(new_branch, &oid);
 			if (remote)
 				branch = remote;
 		}
 	}
 
-	if (ac == 2 && !opts.new_branch && !opts.detach) {
+	if (ac == 2 && !new_branch && !opts.detach) {
 		struct object_id oid;
 		struct commit *commit;
 		const char *remote;
@@ -430,25 +428,25 @@ static int add(int ac, const char **av, const char *prefix)
 		if (!commit) {
 			remote = unique_tracking_name(branch, &oid);
 			if (remote) {
-				opts.new_branch = branch;
+				new_branch = branch;
 				branch = remote;
 			}
 		}
 	}
 
-	if (opts.new_branch) {
+	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
 		argv_array_push(&cp.args, "branch");
-		if (opts.force_new_branch)
+		if (new_branch_force)
 			argv_array_push(&cp.args, "--force");
-		argv_array_push(&cp.args, opts.new_branch);
+		argv_array_push(&cp.args, new_branch);
 		argv_array_push(&cp.args, branch);
 		if (opt_track)
 			argv_array_push(&cp.args, opt_track);
 		if (run_command(&cp))
 			return -1;
-		branch = opts.new_branch;
+		branch = new_branch;
 	} else if (opt_track) {
 		die(_("--[no-]track can only be used if a new branch is created"));
 	}
-- 
2.16.1.78.ga2082135d8

