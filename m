Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5060C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbiBJQxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:53:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244864AbiBJQxK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:53:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4371FEE
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:53:10 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id qe15so5720787pjb.3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5cTBy+Zt5/IVt3hOad0zv4OHddqTTJdKy8ZSzxntfMo=;
        b=V7PznY69867IBFSNvXLKTEntq/J7gc8ageHOir2M5OjUmr46ewEsbBGkjhOBnnRRKU
         LQArImmozNTIKo0aLGkDACy9w+RLObLv5PkVj+i7ziCrTA0PkSgi2/tFC245OO3cCxAj
         z2PZoMmFUtMw6xoMTHrfka1/1bF4CaqclhdpDHJS+OtLi3QkU2jnEPNZeFtxvZKCgAHJ
         XE6ieJvMamPnh81QVox2rQHQEb+uyK37Gq/ftmCJOWVyUJRPpprs+CO1P6hZb5Db3jM5
         bVODAQ51gtzV36XQ3AIrUZVD+8cRlZCEIoa0soXM5Te7CBK0kG6BfL91eUsNNoCTPqKh
         q91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5cTBy+Zt5/IVt3hOad0zv4OHddqTTJdKy8ZSzxntfMo=;
        b=NgceYDFFuVe7xrtNnK0IHVSv3Vok7pqV4pCskocrWEsli193ddYINiVBOeUt/cmrg6
         CFDuFdpyq7UM+8Dra4nuFYkWzmfPQl/MkzwsUcNymPpT6+S0ar3h570R8wt3kPVUMzV3
         iQ4sa5yaMtHmVkVVuexqrZsjDTcmHfvcBwtW60Kj/jgifstfAQQ0EP6K44zMkKFxucqV
         KAzUq/V3MNO5m6vcXEDOqFiCwglggFUiARKkpk+UTey+LjbQnzRpn0yWxV0Mjf3ekzEX
         IemDVUhEzCC/4hDYgbnZ0GI3/5HlhjDnzQB9bH/4v5UIvx/GWyFBhfyB4RSLhENaSOuo
         clcA==
X-Gm-Message-State: AOAM530z6C0YEtR3zOEkgd0SoT0Qcc7/5BKxSc0fFbZ3mcR4U+D/LhxA
        MYJQFtFAwn34hDTGHyLxjw5XkNgqcDo=
X-Google-Smtp-Source: ABdhPJzBMhoJmLJrSFw8Dc7W3rdvn/eNuoSknBJylK9vr6Vf9kBy7kiwSfzgLOAhobqzl8WkFHmeEw==
X-Received: by 2002:a17:902:ea10:: with SMTP id s16mr8659053plg.111.1644511989379;
        Thu, 10 Feb 2022 08:53:09 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id c17sm25614840pfv.68.2022.02.10.08.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 08:53:08 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, paulus@ozlabs.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 3/4] log: add a log.graph config option
Date:   Thu, 10 Feb 2022 09:52:08 -0700
Message-Id: <20220210165209.310930-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0.2645.gc109162a1f
In-Reply-To: <20220210165209.310930-1-alexhenrie24@gmail.com>
References: <20220210165209.310930-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A coworker recently asked me how to turn on --graph by default in
`git log`. I googled it and found that several people have asked that
before on Stack Overflow, with no good solution:
https://stackoverflow.com/questions/43555256/how-do-i-make-git-log-graph-the-default

Add a log.graph option to turn on graph mode in the absence of any
incompatible options.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v2: ensure that --no-graph on the command line takes precedence over
log.graph=true in the config file
---
 Documentation/config/log.txt |  5 +++++
 Documentation/git-log.txt    |  5 +++++
 builtin/log.c                |  6 ++++++
 revision.c                   | 10 +++++++++
 revision.h                   |  2 ++
 t/t4202-log.sh               | 42 ++++++++++++++++++++++++++++++++++++
 6 files changed, 70 insertions(+)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 456eb07800..3e356cfce6 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -35,6 +35,11 @@ log.follow::
 	i.e. it cannot be used to follow multiple files and does not work well
 	on non-linear history.
 
+log.graph::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--graph` unless an incompatible
+	option is also specified.
+
 log.graphColors::
 	A list of colors, separated by commas, that can be used to draw
 	history lines in `git log --graph`.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 20e87cecf4..7e9e0f8afe 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -214,6 +214,11 @@ log.follow::
 	i.e. it cannot be used to follow multiple files and does not work well
 	on non-linear history.
 
+log.graph::
+	If `true`, `git log` and related commands will act as if the
+	`--graph` option was passed to them unless an incompatible option is
+	also specified.
+
 log.showRoot::
 	If `false`, `git log` and related commands will not treat the
 	initial commit as a big creation event.  Any root commits in
diff --git a/builtin/log.c b/builtin/log.c
index 4b493408cc..5eaefab046 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -48,6 +48,7 @@ static int default_show_root = 1;
 static int default_follow;
 static int default_show_signature;
 static int default_encode_email_headers = 1;
+static int default_graph;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config = 1;
@@ -156,6 +157,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->show_signature = default_show_signature;
 	rev->encode_email_headers = default_encode_email_headers;
 	rev->diffopt.flags.allow_textconv = 1;
+	rev->graph_default = default_graph;
 
 	if (default_date_mode)
 		parse_date_format(default_date_mode, &rev->date_mode);
@@ -519,6 +521,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_signature = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "log.graph")) {
+		default_graph = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (grep_config(var, value, cb) < 0)
 		return -1;
diff --git a/revision.c b/revision.c
index a39fd1c278..55e12cd401 100644
--- a/revision.c
+++ b/revision.c
@@ -2426,9 +2426,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--graph")) {
 		graph_clear(revs->graph);
 		revs->graph = graph_init(revs);
+		revs->graph_default = 0;
 	} else if (!strcmp(arg, "--no-graph")) {
 		graph_clear(revs->graph);
 		revs->graph = NULL;
+		revs->graph_default = 0;
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
@@ -2796,6 +2798,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			break;
 		}
 	}
+	if (revs->graph_default &&
+	    !revs->graph &&
+	    /* check for incompatible options */
+	    !revs->track_linear &&
+	    !revs->reverse &&
+	    !revs->reflog_info &&
+	    !revs->no_walk)
+		revs->graph = graph_init(revs);
 	revision_opts_finish(revs);
 
 	if (prune_data.nr) {
diff --git a/revision.h b/revision.h
index 5a507db202..62a0ef4c53 100644
--- a/revision.h
+++ b/revision.h
@@ -249,6 +249,8 @@ struct rev_info {
 
 	/* Display history graph */
 	struct git_graph *graph;
+	/* whether to initialize graph if it has not been initialized already */
+	int graph_default;
 
 	/* special limits */
 	int skip_count;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index f3f36a7e01..e9695510c3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1695,6 +1695,20 @@ test_expect_success '--no-graph does not unset --parents' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log.graph=true behaves like --graph' '
+	git log --graph >expect &&
+	test_config log.graph true &&
+	git log >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-graph countermands log.graph=true' '
+	git log >expect &&
+	test_config log.graph true &&
+	git log --no-graph >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--reverse and --graph conflict' '
 	test_must_fail git log --reverse --graph 2>stderr &&
 	test_i18ngrep "cannot be used together" stderr
@@ -1706,6 +1720,13 @@ test_expect_success '--reverse --graph --no-graph works' '
 	test_cmp expect actual
 '
 
+test_expect_success '--reverse ignores log.graph' '
+	git log --reverse >expect &&
+	test_config log.graph true &&
+	git log --reverse >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--show-linear-break and --graph conflict' '
 	test_must_fail git log --show-linear-break --graph 2>stderr &&
 	test_i18ngrep "cannot be used together" stderr
@@ -1717,6 +1738,13 @@ test_expect_success '--show-linear-break --graph --no-graph works' '
 	test_cmp expect actual
 '
 
+test_expect_success '--show-linear-break ignores log.graph' '
+	git log --show-linear-break >expect &&
+	test_config log.graph true &&
+	git log --show-linear-break >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--no-walk and --graph conflict' '
 	test_must_fail git log --no-walk --graph 2>stderr &&
 	test_i18ngrep "cannot be used together" stderr
@@ -1728,6 +1756,13 @@ test_expect_success '--no-walk --graph --no-graph works' '
 	test_cmp expect actual
 '
 
+test_expect_success '--no-walk ignores log.graph' '
+	git log --no-walk >expect &&
+	test_config log.graph true &&
+	git log --no-walk >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--walk-reflogs and --graph conflict' '
 	test_must_fail git log --walk-reflogs --graph 2>stderr &&
 	test_i18ngrep -E "(cannot combine|cannot be used together)" stderr
@@ -1739,6 +1774,13 @@ test_expect_success '--walk-reflogs --graph --no-graph works' '
 	test_cmp expect actual
 '
 
+test_expect_success '--walk-reflogs ignores log.graph' '
+	git log --walk-reflogs >expect &&
+	test_config log.graph true &&
+	git log --walk-reflogs >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'dotdot is a parent directory' '
 	mkdir -p a/b &&
 	( echo sixth && echo fifth ) >expect &&
-- 
2.32.0.2645.gc109162a1f

