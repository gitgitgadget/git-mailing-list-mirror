Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15161C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B0D611BE
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhEJPg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhEJPgD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:36:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93AFC061763
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:34:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w4so21330689ljw.9
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=medm5K5YgE98JyAJycFftqpZEphBadJa1CFbnqGlNVk=;
        b=N9m/LbviH1fMASAhStmGCTgz7YSUfQoyS1SF74BmSvOZ7P1tT9MGualUoCvlugTsqp
         w1MLVMCeNrjiPwLiePkIRhyO72fDg2+RD/72tVjVupo66sIWZWyLubthLyhXegJStQSk
         iMZVzifi+SETVN8crulRGw/vY12rSKEhWzak30NGGQKhKleSGOs7jfb0s52taqb3MUCl
         NItqJmXXBUH3VD9fv/u276ifpR9Z9gQWf5kZ6N+3+9iB/LhjiP26li6SP+bVuGjbiosR
         hJ1erg7/Qdvrm8lrJ7gfu/zU1PNgXFSR8RI0wbAISFIBVaRBZahG3Dm5lKRDcgCkzFHf
         7EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=medm5K5YgE98JyAJycFftqpZEphBadJa1CFbnqGlNVk=;
        b=nGHo0FGvZr80Zg8PEet/lTsUo9rMfvKpMdzQAnKkMZEujlwhz9Bo0O0AiOFYU51BQz
         GAKXUwZ4wQ9w5R2yY2P7VyxvD5S+o5jbRrwDczu3r76Curl/e2wJgzZEMYhrejJAQ/ha
         P5Gea7yTMaXN5i5tB99lvqIzn1wuyVlEHQeLXVYem+mZaHogFmS50vMsuOedXhtwxJUE
         C605H8kEzmshcUkmQFSiWNV07odlkO5Kxhi+wgS8HZ9cJYU7Sjx/gx0reca0jEOzpQS7
         6PIioOYsLBJ8Dt7kFjbi5vemz8m9lP9vf+uzN/FHiAtiw0yWWMISLksqg/UmaPJsRvTD
         30Mw==
X-Gm-Message-State: AOAM532TFI4teplAY0NUP/GHihM+YrGcRGKmfQ+6SlEMl8rwGSsdPWjt
        1M6v1805CAreBQHSACrvLEM=
X-Google-Smtp-Source: ABdhPJyvS6Im5WcMkL0WmyUdqMjbu+s0gcfAjz0ajSpVPnNGObwdn5syOxfFYTJMB8TGgrmLGq+Wjg==
X-Received: by 2002:a2e:8e21:: with SMTP id r1mr20582559ljk.166.1620660896259;
        Mon, 10 May 2021 08:34:56 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p8sm1525840lfe.224.2021.05.10.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:34:55 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 2/6] diff-merges: move specific diff-index "-m" handling to diff-index
Date:   Mon, 10 May 2021 18:34:47 +0300
Message-Id: <20210510153451.15090-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510153451.15090-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move specific handling of "-m" for diff-index to diff-index.c, so
diff-merges is left to handle only diff for merges options.

Being a better design by itself, this is especially essential in
preparation for letting -m imply -p, as "diff-index -m" obviously
should not imply -p, as it's entirely unrelated.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/diff-index.c | 45 ++++++++++++++++++++++++++++++++++----------
 diff-merges.c        | 13 +------------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 176fe7ff2b4e..28bc51d0d8f4 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -12,11 +12,37 @@ static const char diff_cache_usage[] =
 "[<common-diff-options>] <tree-ish> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
+static int parse_distinct_options(int argc, const char **argv,
+				  struct rev_info *revs, unsigned int *options)
+{
+	int i, left;
+
+	for (i = left = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		int leave = 0;
+
+		if (!strcmp(arg, "--cached"))
+			*options |= DIFF_INDEX_CACHED;
+		else if (!strcmp(arg, "--merge-base"))
+			*options |= DIFF_INDEX_MERGE_BASE;
+		else if (!strcmp(arg, "-m"))
+			revs->match_missing = 1;
+		else
+			leave = 1;
+
+		if (leave)
+			argv[left++] = arg;
+	}
+
+	argv[left] = NULL;
+
+	return left;
+}
+
 int cmd_diff_index(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 	unsigned int option = 0;
-	int i;
 	int result;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -27,17 +53,16 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	rev.abbrev = 0;
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
+	/*
+	 * It's essential to parse our distinct options before calling
+	 * setup_revisions(), for the latter not to see "-m".
+	 */
+	argc = parse_distinct_options(argc, argv, &rev, &option);
 	argc = setup_revisions(argc, argv, &rev, NULL);
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
 
-		if (!strcmp(arg, "--cached"))
-			option |= DIFF_INDEX_CACHED;
-		else if (!strcmp(arg, "--merge-base"))
-			option |= DIFF_INDEX_MERGE_BASE;
-		else
-			usage(diff_cache_usage);
-	}
+	if (argc > 1)
+		usage(diff_cache_usage);
+
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 
diff --git a/diff-merges.c b/diff-merges.c
index f3a9daed7e05..4016800c422c 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -30,17 +30,6 @@ static void set_first_parent(struct rev_info *revs)
 	revs->first_parent_merges = 1;
 }
 
-static void set_m(struct rev_info *revs)
-{
-	/*
-	 * To "diff-index", "-m" means "match missing", and to the "log"
-	 * family of commands, it means "show default diff for merges". Set
-	 * both fields appropriately.
-	 */
-	set_to_default(revs);
-	revs->match_missing = 1;
-}
-
 static void set_combined(struct rev_info *revs)
 {
 	suppress(revs);
@@ -108,7 +97,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	const char *arg = argv[0];
 
 	if (!strcmp(arg, "-m")) {
-		set_m(revs);
+		set_to_default(revs);
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->combined_imply_patch = 1;
-- 
2.25.1

