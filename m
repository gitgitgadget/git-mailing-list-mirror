Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C27C761AF
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjC1N7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjC1N71 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7AF8A43
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so4180185wmq.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWHT2kh3ZFpi/r4bvNNzwpJ/TtB6ZvkE8GU/A2YxOyU=;
        b=GF6lW0h7/5u5GszGYRRc3QiaalECKrrQmHrJXVjevFMSWODhr8eGsKG1yLk0pNMLoD
         3kuUvVlOwfbrQ2tbr6bjF+W17ywX/VS0Fc2oCd8OWWG2ITqNmxq++9Qs/w4FYl97cxyF
         WYrUeIl8hO59bZfZQXuqhior2yFK08xyy7NwCn184Zom6s9vt22PynfMWkysJixcp+Ip
         dwoxIxAerIU9WSW78+nO3JFyNPaizsiVX6jn/rDFomOFew3j0R8rVAdoOM/nWtvwWme+
         8zW+hhxLVl3YcVmpHPNhFgqmPUBv08m4XbKIOMYVad2EQbgUlRncumeE1Y8czBtiNfMC
         j9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWHT2kh3ZFpi/r4bvNNzwpJ/TtB6ZvkE8GU/A2YxOyU=;
        b=baIXMJs/V1q3WBsd8kPqaVeHFzyeGOeUjyrxhCtrnblKiHTSFfVg/w3aLOfXaUxY0b
         oEFAkpzCvE8u+TQbH8/4uaxXsxAVSfQxdMo+sdasMy5vUEd9/NitKcKwHCrFsq5ilhf4
         lpMihXACaJSUS3yhVOPIQnqpBA7kjWfPuyUdakam+l11PTgOax9H+hbbmPa5qT9F4fXm
         p6Bb4C0RVxA/2GZ085PmQJ2ZrIueBjgIipqwcjiaAMkHubk4xTM3mg0bcoLsAeSrU1Dv
         S4gQahIthoAo43wh3m+phWKGh3qmD/93Qdz3g48QSJVB2o+u9k38jgTjddaM+m+XUgdy
         hdhA==
X-Gm-Message-State: AO0yUKV4ogJHJ668WbARVYm4tGLfc0PNgbo43rJbaCsLgPMfzy3JXosN
        Xgkd/R9Vjtai1/MWsC5ui8pEZVJPRfwsag==
X-Google-Smtp-Source: AK7set94AVqM97O8ODtsR5tjMAI0s0BzwaJp9fwUm7ZOaoNQreVW3tVeXjP2DznCL2900TAB26SpHQ==
X-Received: by 2002:a05:600c:5251:b0:3ee:9652:932 with SMTP id fc17-20020a05600c525100b003ee96520932mr13675884wmb.12.1680011956242;
        Tue, 28 Mar 2023 06:59:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/17] cocci: apply the "diff.h" part of "the_repository.pending"
Date:   Tue, 28 Mar 2023 15:58:49 +0200
Message-Id: <patch-v2-08.17-f442e7b9acc-20230328T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"diff.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c                                   | 2 +-
 builtin/rebase.c                                | 2 +-
 builtin/stash.c                                 | 2 +-
 contrib/coccinelle/the_repository.cocci         | 4 ++++
 contrib/coccinelle/the_repository.pending.cocci | 4 ----
 diff.h                                          | 3 ---
 log-tree.c                                      | 2 +-
 range-diff.c                                    | 2 +-
 8 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a55325025a4..11ba99d6b48 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1385,7 +1385,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			.other_arg = &other_arg
 		};
 
-		diff_setup(&opts);
+		repo_diff_setup(the_repository, &opts);
 		opts.file = rev->diffopt.file;
 		opts.use_color = rev->diffopt.use_color;
 		diff_setup_done(&opts);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 3e2cdabfda5..80a5b7486f8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1787,7 +1787,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 
 		/* We want color (if set), but no pager */
-		diff_setup(&opts);
+		repo_diff_setup(the_repository, &opts);
 		opts.stat_width = -1; /* use full terminal width */
 		opts.stat_graph_width = -1; /* respect statGraphWidth config */
 		opts.output_format |=
diff --git a/builtin/stash.c b/builtin/stash.c
index dd5f67e7e6e..447c3b678f3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -428,7 +428,7 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 	 * to the index before a merge was run) and the current index
 	 * (reflecting the changes brought in by the merge).
 	 */
-	diff_setup(&diff_opts);
+	repo_diff_setup(the_repository, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = 0;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 0cdf3f46304..3c0bd8781e7 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -73,6 +73,10 @@
 |
 - get_commit_tree
 + repo_get_commit_tree
+// diff.h
+|
+- diff_setup
++ repo_diff_setup
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index bf19e6a2487..00461ee86b3 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,11 +5,7 @@
 @@
 @@
 (
-// diff.h
-- diff_setup
-+ repo_diff_setup
 // object-store.h
-|
 - read_object_file
 + repo_read_object_file
 |
diff --git a/diff.h b/diff.h
index 09627f6e84a..c759bedc269 100644
--- a/diff.h
+++ b/diff.h
@@ -536,9 +536,6 @@ int git_diff_basic_config(const char *var, const char *value, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
 int git_diff_ui_config(const char *var, const char *value, void *cb);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
-#endif
 void repo_diff_setup(struct repository *, struct diff_options *);
 struct option *add_diff_options(const struct option *, struct diff_options *);
 int diff_opt_parse(struct diff_options *, const char **, int, const char *);
diff --git a/log-tree.c b/log-tree.c
index 97d374c76d6..5c97bc403fb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -852,7 +852,7 @@ void show_log(struct rev_info *opt)
 		 * Pass minimum required diff-options to range-diff; others
 		 * can be added later if deemed desirable.
 		 */
-		diff_setup(&opts);
+		repo_diff_setup(the_repository, &opts);
 		opts.file = opt->diffopt.file;
 		opts.use_color = opt->diffopt.use_color;
 		diff_setup_done(&opts);
diff --git a/range-diff.c b/range-diff.c
index 5bcf966f6c5..15d0bc35a87 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -485,7 +485,7 @@ static void output(struct string_list *a, struct string_list *b,
 	if (range_diff_opts->diffopt)
 		memcpy(&opts, range_diff_opts->diffopt, sizeof(opts));
 	else
-		diff_setup(&opts);
+		repo_diff_setup(the_repository, &opts);
 
 	opts.no_free = 1;
 	if (!opts.output_format)
-- 
2.40.0.rc1.1034.g5867a1b10c5

