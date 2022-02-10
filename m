Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404B9C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244884AbiBJQxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:53:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbiBJQxI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:53:08 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222E8D4
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:53:09 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so6147421pjm.2
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TQ+q/fC3vf+dCK8C98SVJF0fZxrCUt9IlVQwuu3+0o=;
        b=Zxailbtlt269/ETtUVcJIecwdsrZ7LHMxSOqScYPpPqjFTEyVy+FP8K3lZSQoqugan
         IZNYUUgVlUyKKNhY3NKR6m9rxaS84llp3FBh7cLEmwtouefB0W/XKDu9bRwJbHbEqah5
         kPUlbNWvDx/PoICVML8N4KIgSbVsmvzIbgeRUAz3BYYrn13ijiSmD670uqIPtkM61PRt
         /FDRbwt+ZSvDj2zUyC5PchTwA0KOikTkS3CsItV3+m7YLsXqqsAwq31v+bmV09nZjun8
         TISf+2wgoj1K22eg0j18MsTEHtjRQk+Crl8zHDrBOuZHPVECWiFqg97uxjTPh3O1Hegq
         FSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TQ+q/fC3vf+dCK8C98SVJF0fZxrCUt9IlVQwuu3+0o=;
        b=i7xP4pPgKDOWGy0caIyoV5L44erH+4ErpnE4Kq6Jy1qJS0tuxlN1KMvGupDeKtHgNn
         aiJuedXs0dOKZBfpKHot89nl0S+hB03IRoXyagXWylO/NQ02bEDfAhymYG/aZT2gi3aq
         FA4o7NxWh8am+1dQ3g3WGTMdPOXi2+XmDCQDZXQW+/Z5yU0Z0I2zCcnW7wjeFmjGWedG
         HXCLZ+NiFqLT6dQcL39wt92NWKfaGMCbddqNQs5ysobmRtZ2W2/4IJOdeU6+8oPx5O36
         iyHC4D0Zq0742JPt9aBkakOQ3A6eB2FNpVzAlPy0GYxbKHpuJUBNr42PNAPSx2vh+IL3
         WxKg==
X-Gm-Message-State: AOAM533znFr/pS8bGewvdKyhd5UoFHB1B9rV7IGAkoG13QkKWTXW85tJ
        1/oSxF90d2ZMbebWpcoKfWNzidxk4vE=
X-Google-Smtp-Source: ABdhPJwWSBDNosFyORvmP+Y8hVmYAAJdjn2h62vYBz5SXnTPXkizV2ZJfAWKE3FQdu8ql+KqmFP7Ug==
X-Received: by 2002:a17:902:f543:: with SMTP id h3mr6446645plf.70.1644511987945;
        Thu, 10 Feb 2022 08:53:07 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id c17sm25614840pfv.68.2022.02.10.08.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 08:53:07 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, paulus@ozlabs.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 2/4] log: add a --no-graph option
Date:   Thu, 10 Feb 2022 09:52:07 -0700
Message-Id: <20220210165209.310930-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0.2645.gc109162a1f
In-Reply-To: <20220210165209.310930-1-alexhenrie24@gmail.com>
References: <20220210165209.310930-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's useful to be able to countermand a previous --graph option, for
example if `git log --graph` is run via an alias.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v2: new patch
---
 builtin/blame.c    |  1 +
 builtin/shortlog.c |  1 +
 revision.c         | 19 ++++++++++---
 revision.h         |  1 +
 t/t4202-log.sh     | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 4 deletions(-)

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
index dc884107de..f3f36a7e01 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1671,6 +1671,74 @@ test_expect_success 'log --graph with --name-only' '
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
+	test_i18ngrep -E "(cannot combine|cannot be used together)" stderr
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
2.32.0.2645.gc109162a1f

