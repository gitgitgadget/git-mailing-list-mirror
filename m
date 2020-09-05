Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D423C433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5882074B
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9dvZMG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgIETIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgIETIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 15:08:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AEAC061245
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 12:08:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 31so6013569pgy.13
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xQI/6CNpU4SSYBeNcucHOniADlACfETmjQN7IYpwlBY=;
        b=K9dvZMG5JcusoezR1IVNvqHRlidxp8fVQyOHcVuY6cPL1llJd+Kvi9ddKHJ0CjnCVA
         FuwtLw2FqVaS7ovSqatxXAEPqfIzrjFu+Axk4WhIkyC3+f9Knbs3EmdHwjYPr+mwzJpo
         5nc5MJNS6EMuEkEyX3/KIbVS2w8tWRCHk9omjrbHKfB52Qyt+SpZ128cZ+HXgy2Lj4iA
         2TqMH4vRhxRhd1gC419EiD7i6opNpYN6jWo/yufoJtXC0LxNhQqoBkVQvvTpJokExq07
         8zDi/RmV4IHmvvFMcL2+0xSOpgYSqeX+QTburcFAPFLj3Ps2vgt5PyX/b2EDVR0EGyh+
         +ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQI/6CNpU4SSYBeNcucHOniADlACfETmjQN7IYpwlBY=;
        b=ARKMbGN++8ec1xUnhFEndlGbc+m0VcS6+vTH7NZBH4TRk+Mpw5SJD4ozuTAsW0NV+y
         njrwQhYQ41YAAhzHj97ifl6L0bhad283LhkhSSDeZrlY6cNMsvXEQ9/zpdZBbeHUvmEH
         4PLqiofsYnVyEs1KNfzuMnTy9H9yTspbF9oG6lK8aVdidgGRMzQ6+zWlKaKbBiHaNaKN
         fn7N//Dmdcki9b8Zr35SuZmU7EBB3hQGweNHWG+iNEbebQ9BbDuNV2M3dq0dAowqT9Zt
         UxyBPe3+1p/10g1jeDJZ+CRwOHAaOYQSziP+FuExi3YI7l/L4zown1PfZd6F9I3NeJBg
         mHqQ==
X-Gm-Message-State: AOAM530I1WPbxK29M7uma9U6qog6G1JHPjSpukJtua9/XuV5QMZqZCJp
        +dK5/FUnlm66sIJroDjwQpU0lLDPrvs=
X-Google-Smtp-Source: ABdhPJw+MYGrAud8wXy8OzNeaelB87nOoMJmu/fmmtC/CfJ8GJ1YraKdIMXjDVQBYGfKFxZ+HN1yNw==
X-Received: by 2002:a63:7b54:: with SMTP id k20mr11443058pgn.75.1599332917743;
        Sat, 05 Sep 2020 12:08:37 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id u5sm3045459pfh.215.2020.09.05.12.08.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 12:08:36 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/4] builtin/diff: parse --no-index using parse_options()
Date:   Sat,  5 Sep 2020 12:08:20 -0700
Message-Id: <ea6717e7b3a8b89fc3750505678321803cde78dc.1599332861.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.135.gc7877b767d
In-Reply-To: <cover.1599332861.git.liu.denton@gmail.com>
References: <cover.1599332861.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of parsing the `--no-index` option with a plain strcmp, use
parse_options() to parse options. This allows us to easily add more
options in a future commit.

As a result of this change, `--no-index` is removed from `argv` so, as a
result, we no longer need to handle it in diff_no_index().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/diff.c  | 33 ++++++++++++++++++++++-----------
 diff-no-index.c | 15 +++------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index cb98811c21..0e086ed7c4 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -373,6 +373,13 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int nongit = 0, no_index = 0;
 	int result = 0;
 	struct symdiff sdiff;
+	struct option options[] = {
+		OPT_SET_INT_F(0, "no-index", &no_index,
+			   N_("compare the given paths on the filesystem"),
+			   DIFF_NO_INDEX_EXPLICIT,
+			   PARSE_OPT_NONEG),
+		OPT_END(),
+	};
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -406,21 +413,25 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 * Other cases are errors.
 	 */
 
-	/* Were we asked to do --no-index explicitly? */
-	for (i = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
-			i++;
-			break;
-		}
-		if (!strcmp(argv[i], "--no-index"))
-			no_index = DIFF_NO_INDEX_EXPLICIT;
-		if (argv[i][0] != '-')
-			break;
-	}
+	argc = parse_options(argc, argv, prefix, options, NULL,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_NO_INTERNAL_HELP);
 
 	prefix = setup_git_directory_gently(&nongit);
 
 	if (!no_index) {
+		int i;
+		for (i = 1; i < argc; i++) {
+			if (!strcmp(argv[i], "--")) {
+				i++;
+				break;
+			}
+			if (argv[i][0] != '-')
+				break;
+		}
+
 		/*
 		 * Treat git diff with at least one path outside of the
 		 * repo the same as if the command would have been executed
diff --git a/diff-no-index.c b/diff-no-index.c
index 7814eabfe0..da82e2d090 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -243,28 +243,19 @@ int diff_no_index(struct rev_info *revs,
 		  int implicit_no_index,
 		  int argc, const char **argv)
 {
-	int i, no_index;
+	int i;
 	const char *paths[2];
 	struct strbuf replacement = STRBUF_INIT;
 	const char *prefix = revs->prefix;
-	struct option no_index_options[] = {
-		OPT_BOOL_F(0, "no-index", &no_index, "",
-			   PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
-		OPT_END(),
-	};
-	struct option *options;
 
-	options = parse_options_concat(no_index_options,
-				       revs->diffopt.parseopts);
-	argc = parse_options(argc, argv, revs->prefix, options,
+	argc = parse_options(argc, argv, revs->prefix, revs->diffopt.parseopts,
 			     diff_no_index_usage, 0);
 	if (argc != 2) {
 		if (implicit_no_index)
 			warning(_("Not a git repository. Use --no-index to "
 				  "compare two paths outside a working tree"));
-		usage_with_options(diff_no_index_usage, options);
+		usage_with_options(diff_no_index_usage, revs->diffopt.parseopts);
 	}
-	FREE_AND_NULL(options);
 	for (i = 0; i < 2; i++) {
 		const char *p = argv[argc - 2 + i];
 		if (!strcmp(p, "-"))
-- 
2.28.0.rc0.135.gc7877b767d

