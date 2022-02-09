Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D583EC433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 16:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiBIQYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiBIQYC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 11:24:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FC7C0613C9
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 08:24:05 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id on2so2567036pjb.4
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 08:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Psg6c9s8gXU5l8z4SXVEaZFyI9cIcizaKBN76jLVopw=;
        b=CC6QhXjhhxhZ/8RdNF+oh3VUf/QW9qsoh/nlm01Ncou3A0PKFbHyjAw8dpLaT6rUy1
         2fSpakjj1plE6kvDyMu7mWLV2RcqOA5VcL4iYb/bQFk4ATjz3+Ve9UuaiGmvhjR3pehm
         wup2YfPbV1mf7OpVayup26Gucgap47r6ltNhwKXXbf8Zc18zWV3/Idzb9Luhwh5PKBtY
         8AI1Caxheq27X0C+U5ZQWpY92yeCqeizR8l41mcNEor6bHrOXob60L9+tyS7EtjoPcu0
         pquQPF7hWqmbUhCha/7Ha3C4gRS3KMlQ9bJ5AoTZ+/5g9MpHiwCCvIzyFcwiHp7NGtXX
         Nlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Psg6c9s8gXU5l8z4SXVEaZFyI9cIcizaKBN76jLVopw=;
        b=COXq9fPQbpqXj3BZKp82mLDTA3KN4MNNzzpVKXrBs1JQkYYpAzMhtHAFkr2NtvMoDJ
         1GRi301v7hlvg1M29eTpsBHLwEa27+i3+n84LGZXantccK+T11qnER0pq0tXPzZ1ncKF
         cJtxkHRsXAMZLKuRfUlIyN5LJ89T9EakWsH9VcV5bFuqqE2QI3ugqzDVbapSucgyk9rc
         nOkQgOHnAbrZAf0UBcCEx6pLr3cujVmysxrYBTuEUHkHYXWGwfVO/cMR8cqw1kbuTk7C
         ZX8apBsZjlFvMfc0GfqOaRTwra/T6RhqtJMpEvH1iMRIWJ5ZdBKV+Qd4LXtGak7XWBcH
         kTIQ==
X-Gm-Message-State: AOAM531W8nVyQxb6OY4NdxVI9IeESFpIOb//NYJ8MqOdTBFxKXuGe/LT
        VkXnEf0P+McD9SaFJFUVJVEgeHEO708=
X-Google-Smtp-Source: ABdhPJw3ILN/E4wnBpiM5JNIjdVhW8bigxb+eIf1AHY9NqBSPGdtuzKZ+3I0fxQ2KE2ytysvTEdYvw==
X-Received: by 2002:a17:903:32c5:: with SMTP id i5mr3071798plr.57.1644423844535;
        Wed, 09 Feb 2022 08:24:04 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id u12sm21504246pfk.220.2022.02.09.08.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:24:04 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, paulus@ozlabs.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 2/3] log: add a config option for --graph
Date:   Wed,  9 Feb 2022 09:23:48 -0700
Message-Id: <20220209162350.169971-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0.2645.gc109162a1f
In-Reply-To: <20220209162350.169971-1-alexhenrie24@gmail.com>
References: <20220209162350.169971-1-alexhenrie24@gmail.com>
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

It would be nice to have a --no-graph command line option to countermand
log.graph=true, but it's not clear how that would work with topo_order
and rewrite_parents, which can be set by other options. In any case, it
is still possible to countermand log.graph=true per invocation with
`git -c log.graph=false log`.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/config/log.txt |  5 +++++
 Documentation/git-log.txt    |  5 +++++
 builtin/log.c                | 17 +++++++++++++++++
 t/t4202-log.sh               | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)

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
index 4b493408cc..1f0db54c84 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -35,6 +35,7 @@
 #include "repository.h"
 #include "commit-reach.h"
 #include "range-diff.h"
+#include "graph.h"
 
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
@@ -48,6 +49,7 @@ static int default_show_root = 1;
 static int default_follow;
 static int default_show_signature;
 static int default_encode_email_headers = 1;
+static int default_graph;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config = 1;
@@ -234,6 +236,17 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		read_mailmap(rev->mailmap);
 	}
 
+	if (default_graph &&
+	    !rev->graph &&
+	    !rev->track_linear &&
+	    !rev->reverse &&
+	    !rev->reflog_info &&
+	    !rev->no_walk) {
+		rev->topo_order = 1;
+		rev->rewrite_parents = 1;
+		rev->graph = graph_init(rev);
+	}
+
 	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
 		/*
 		 * "log --pretty=raw" is special; ignore UI oriented
@@ -519,6 +532,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_signature = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "log.graph")) {
+		default_graph = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (grep_config(var, value, cb) < 0)
 		return -1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 5049559861..3b6f7aff23 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1671,6 +1671,41 @@ test_expect_success 'log --graph with --name-only' '
 	test_cmp_graph --name-only tangle..reach
 '
 
+test_expect_success 'log.graph=true behaves like --graph' '
+	git log --graph >expect &&
+	test_config log.graph true &&
+	git log >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--show-linear-break ignores log.graph' '
+	git log --show-linear-break >expect &&
+	test_config log.graph true &&
+	git log --show-linear-break >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--reverse ignores log.graph' '
+	git log --reverse >expect &&
+	test_config log.graph true &&
+	git log --reverse >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--walk-reflogs ignores log.graph' '
+	git log --walk-reflogs >expect &&
+	test_config log.graph true &&
+	git log --walk-reflogs >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-walk ignores log.graph' '
+	git log --no-walk >expect &&
+	test_config log.graph true &&
+	git log --no-walk >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'dotdot is a parent directory' '
 	mkdir -p a/b &&
 	( echo sixth && echo fifth ) >expect &&
-- 
2.32.0.2645.gc109162a1f

