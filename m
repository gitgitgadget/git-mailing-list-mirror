Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D048AC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 16:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351597AbiBKQh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:37:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244029AbiBKQhY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 11:37:24 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3BBD66
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 08:37:22 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u16so11505539pfg.3
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyWTUz04uc9eqMjTAroEY6jsrHaVQJZzB8OrSXt0Gug=;
        b=ZpaA0WveKqtNps0LdG5/x/Gt7BLYDtm9MsZHuGQwH3P5hGOObvNqvFupL+rhBBYtPQ
         W8X5sOZ2LEswta5wCr4GId5u45ZMyOG0I4rO48FeomLno4o3IhgfsO/z5aWhwARlFVv0
         NT7qcZZS//JqPOOuIZJcvDLJ26/t1iZEKGvicIbfb0BngvmDw7yQn76e7JjkSOWMo25c
         Dx3/F0BVbMC5Rw3rUGP7LvJR9J2XS49lRdvEc6iAvE/mjX7G1IZ6tkheVzRBPrdsWNiI
         OHYbkZstz5TtIJDWn/Vsy2NapJstr9WOlWrvIh8LeiDdxrxpSBhSJTCL9UlFRIikw7V0
         CWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyWTUz04uc9eqMjTAroEY6jsrHaVQJZzB8OrSXt0Gug=;
        b=55fi1y2gce92zVPYcmEbOGhcHouKWaXe846ZRuppmhGz16nUSnMmLLa9dRkz0C0CAp
         mAuusAoGi/3mB457UR9EV/VS02T1Y5K/UAu+PbbC2oQtwBcU6YUiqK0pvKXi2eKcZQlL
         UBQqHb+E1h1DFaNnMLfUSKL++HdiYQWov41UJAxrBSE8Z8NbPDWguVytvodGS2N0Xu8q
         V14MohnYzUOkNqq9U2EtTDsPlcqRywbb+4kstHu7RuLfjph1jFAjkbeWq5OvsKsPQNnf
         7I4AZBIMnfQ8Yu/atX8b9UleWSg8dW5TWN3ZTLwuq6fYdaQFrfAi5EO7hPBPDEG2fxoQ
         Kybw==
X-Gm-Message-State: AOAM531YhVw+/IryM3XmqOq8nz/WjH3/Iv/wx36jU1Drhy1WfCLWCQP7
        a/NxVKb/oJknTY7bPtEk2t01hO56WKA=
X-Google-Smtp-Source: ABdhPJzEwYegHW0Wl1lQsHRUXU5A8t9EPGut606K/eGoBIr1miz5exLGCQP2+38FDhKUmcvKsCkiKA==
X-Received: by 2002:a63:f00b:: with SMTP id k11mr2021518pgh.469.1644597441628;
        Fri, 11 Feb 2022 08:37:21 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id l17sm27450568pfu.61.2022.02.11.08.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:37:21 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, paulus@ozlabs.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 2/4] log: add a --no-graph option
Date:   Fri, 11 Feb 2022 09:36:25 -0700
Message-Id: <20220211163627.598166-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211163627.598166-1-alexhenrie24@gmail.com>
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's useful to be able to countermand a previous --graph option, for
example if `git log --graph` is run via an alias.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v3: don't pass a regular expression with parentheses to grep, so that
the tests pass in all configurations on GitHub
---
 builtin/blame.c    |  1 +
 builtin/shortlog.c |  1 +
 revision.c         | 19 ++++++++++---
 revision.h         |  1 +
 t/t4202-log.sh     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 7fafeac408..ef831de5ac 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -934,6 +934,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
 	}
 parse_done:
+	revision_opts_finish(&revs);
 	no_whole_file_rename = !revs.diffopt.flags.follow_renames;
 	xdl_opts |= revs.diffopt.xdl_opts & XDF_INDENT_HEURISTIC;
 	revs.diffopt.flags.follow_renames = 0;
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index e7f7af5de3..228d782754 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -388,6 +388,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 		parse_revision_opt(&rev, &ctx, options, shortlog_usage);
 	}
 parse_done:
+	revision_opts_finish(&rev);
 	argc = parse_options_end(&ctx);
 
 	if (nongit && argc > 1) {
diff --git a/revision.c b/revision.c
index 816061f3d9..a39fd1c278 100644
--- a/revision.c
+++ b/revision.c
@@ -2424,10 +2424,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->pretty_given = 1;
 		revs->abbrev_commit = 1;
 	} else if (!strcmp(arg, "--graph")) {
-		revs->topo_order = 1;
-		revs->rewrite_parents = 1;
 		graph_clear(revs->graph);
 		revs->graph = graph_init(revs);
+	} else if (!strcmp(arg, "--no-graph")) {
+		graph_clear(revs->graph);
+		revs->graph = NULL;
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
@@ -2524,8 +2525,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			unkv[(*unkc)++] = arg;
 		return opts;
 	}
-	if (revs->graph && revs->track_linear)
-		die(_("options '%s' and '%s' cannot be used together"), "--show-linear-break", "--graph");
 
 	return 1;
 }
@@ -2544,6 +2543,17 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
+void revision_opts_finish(struct rev_info *revs)
+{
+	if (revs->graph && revs->track_linear)
+		die(_("options '%s' and '%s' cannot be used together"), "--show-linear-break", "--graph");
+
+	if (revs->graph) {
+		revs->topo_order = 1;
+		revs->rewrite_parents = 1;
+	}
+}
+
 static int for_each_bisect_ref(struct ref_store *refs, each_ref_fn fn,
 			       void *cb_data, const char *term)
 {
@@ -2786,6 +2796,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			break;
 		}
 	}
+	revision_opts_finish(revs);
 
 	if (prune_data.nr) {
 		/*
diff --git a/revision.h b/revision.h
index 3f66147bfd..5a507db202 100644
--- a/revision.h
+++ b/revision.h
@@ -372,6 +372,7 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 #define REVARG_COMMITTISH 02
 int handle_revision_arg(const char *arg, struct rev_info *revs,
 			int flags, unsigned revarg_opt);
+void revision_opts_finish(struct rev_info *revs);
 
 /**
  * Reset the flags used by the revision walking api. You can use this to do
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index dc884107de..a7d5edf720 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1671,6 +1671,75 @@ test_expect_success 'log --graph with --name-only' '
 	test_cmp_graph --name-only tangle..reach
 '
 
+test_expect_success '--no-graph countermands --graph' '
+	git log >expect &&
+	git log --graph --no-graph >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--graph countermands --no-graph' '
+	git log --graph >expect &&
+	git log --no-graph --graph >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-graph does not unset --topo-order' '
+	git log --topo-order >expect &&
+	git log --topo-order --no-graph >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-graph does not unset --parents' '
+	git log --parents >expect &&
+	git log --parents --no-graph >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--reverse and --graph conflict' '
+	test_must_fail git log --reverse --graph 2>stderr &&
+	test_i18ngrep "cannot be used together" stderr
+'
+
+test_expect_success '--reverse --graph --no-graph works' '
+	git log --reverse >expect &&
+	git log --reverse --graph --no-graph >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--show-linear-break and --graph conflict' '
+	test_must_fail git log --show-linear-break --graph 2>stderr &&
+	test_i18ngrep "cannot be used together" stderr
+'
+
+test_expect_success '--show-linear-break --graph --no-graph works' '
+	git log --show-linear-break >expect &&
+	git log --show-linear-break --graph --no-graph >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-walk and --graph conflict' '
+	test_must_fail git log --no-walk --graph 2>stderr &&
+	test_i18ngrep "cannot be used together" stderr
+'
+
+test_expect_success '--no-walk --graph --no-graph works' '
+	git log --no-walk >expect &&
+	git log --no-walk --graph --no-graph >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--walk-reflogs and --graph conflict' '
+	test_must_fail git log --walk-reflogs --graph 2>stderr &&
+	(test_i18ngrep "cannot combine" stderr ||
+		test_i18ngrep "cannot be used together" stderr)
+'
+
+test_expect_success '--walk-reflogs --graph --no-graph works' '
+	git log --walk-reflogs >expect &&
+	git log --walk-reflogs --graph --no-graph >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'dotdot is a parent directory' '
 	mkdir -p a/b &&
 	( echo sixth && echo fifth ) >expect &&
-- 
2.35.1

