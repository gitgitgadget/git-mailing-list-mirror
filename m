Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FED5C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 16:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351598AbiBKQh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:37:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351594AbiBKQhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 11:37:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236BDD6A
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 08:37:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u12so5083461plf.13
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 08:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dPmgpdjLP/MggR30+L3byWkr3JrUdgjLVfTV0A0GHPI=;
        b=B4Z79dj1lgpIRTMUfgtefXwHLdNIHi39OcIoNlMDtGgv7J2yi0ZJT+e/xtNYVRcdpF
         a8hrIpVsbpEKZ9zKpGn3yZlCgoiJcXBMWehevDxn5dEXDNWft74SIZyLiTBUvwnFhFvF
         5LcwyP6n9oJ6N4kv6erI0uSgIa4jOFKCymxGwUK/Vbq70ClKcLAgTP8i+/w/Hm+7AUn8
         yi1D7XjT20JjxNuGPXGv2Skd+rDTMO91dnKAMNPQT/BBAzYOzkWXyLzofSpByM5tHDnb
         Epf3sIb+TG/oGGbkGKJy4Kc7KEQMYyDjIyTSpeeno3ncWZIu0E0lnpOnFj0DXTEdIJxS
         YRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPmgpdjLP/MggR30+L3byWkr3JrUdgjLVfTV0A0GHPI=;
        b=vmf2FeG14U5Rcs/iHb/4IWsYYWT0iRfisHcAaZgXk+eaGKr4zGPvLgaoIKBqBqn9EA
         vVIoeKMNhSDV+0XWguhSVnn+gv5AWIeG4xdqYdJ2yzNmkM685gDUTHUaGkOyjhB1KyV4
         bnR6xcuRXP/3j4VswGGjk1UP78XBEX8rQkaLZ8P6kRzMo4s36bThMP/L3dEkmgeehWyg
         KybGHUqGUdQzdFZ15chdL7Hsn628VgkihcWgHoZ4lG5agSwO+fSob1Uvv+jfyk44YBtN
         sJzpq+bvKRvdGJjiR8mrRX3GqH2Vxc2OjuAJs3kxUMgf/cfj3xSZzWGeuss4RUr4AqIq
         9mNw==
X-Gm-Message-State: AOAM533DxG0dXNb03C7rD3G1Ac3xJyNg76U7I8RzBnOtXiwsYmYJUOiA
        95Ijys7R1N92bP4tK74UM6QGQJz8i2M=
X-Google-Smtp-Source: ABdhPJxFu/ils6p3165nqDXRS9Bxmy2AdI9yStu5QOILJGznttUjULW5R1k7spySoSyEHnNaZ5tuNw==
X-Received: by 2002:a17:902:ce84:: with SMTP id f4mr2326963plg.66.1644597443180;
        Fri, 11 Feb 2022 08:37:23 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id l17sm27450568pfu.61.2022.02.11.08.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:37:22 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, paulus@ozlabs.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 3/4] log: add a log.graph config option
Date:   Fri, 11 Feb 2022 09:36:26 -0700
Message-Id: <20220211163627.598166-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211163627.598166-1-alexhenrie24@gmail.com>
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
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
v3: no changes
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
index a7d5edf720..9f052ccce6 100755
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
 	(test_i18ngrep "cannot combine" stderr ||
@@ -1740,6 +1775,13 @@ test_expect_success '--walk-reflogs --graph --no-graph works' '
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
2.35.1

