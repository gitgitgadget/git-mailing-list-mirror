Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0B5C43460
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B84E611BD
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349615AbhESLuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352286AbhESLt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:49:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53028C061760
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h4so18676119lfv.0
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5WLGyQxJ+bSbUwGFcCKinvSLjoeHjsRBqjWo58Znlc=;
        b=OnwdB1o8Xph/i8+YE5RINyo3yiO1YyHImbSTL1kwbaATBnvAn1JR6BM5oyoG+WCdFO
         8yn5rHc7crE1U9i8+2/JQQQRFT85j9wkSQx6ojOXhjU1MAnTr2UHSpykwqU4nPAyKKju
         UuXD2jzN6TBi/5dWl4eyfZKDGfrpIkgVZvtw289j1Xfyx4iHub1T7v7VhBxuuPaWlkoq
         K51IxOBIbkONS1HDx7D47Im1fJJ+bUh/VNhBKpYAXMs7Z4WAVOCkRPVeXwAl5OZ4PnU9
         b+krctlglgb6ayAQhmYTeVAadoKfDfWNUsT1/TR1ptQCe0Wioh9HlnHLPyqGn/pSG24D
         rFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5WLGyQxJ+bSbUwGFcCKinvSLjoeHjsRBqjWo58Znlc=;
        b=Se2G1YRyUTK7fPl9rJddXuPYVQCo1YiDHzOlkTf4wFmOZ0mVqIVWMAMaHoh/v0H/nr
         jcV87Qu5O6XzwFFG2+5J5bjmeZJQDNR/dFPbEs+UU6c+bOfMRbhTxOem7APlTJ64pR6c
         DjpcXHTrlI85iLlFlDC+8/Qi3VFcOuqJrigvi8m2CzV18h7m6fh1fGNnhhGhIzVCPWRg
         gIOmuIs1eaSqncQQAvnBQW0rZgS8bgMYRkuJzfNnxmyDj640Hog511E0Lf+SjhHFsK6G
         8hvp6KdBiD8w/wi4VByo8UESwKOGZnVIcq6sZSzIHWEtngFeJ7SSLPdQBdCKm4lloWja
         Yuhg==
X-Gm-Message-State: AOAM533uTQQylNmob4igz1TjfIOYh418+XPd/dP+eevhrIqiKQh0QkiI
        dcrSVGNkAJMnNtif0AWJ/B4=
X-Google-Smtp-Source: ABdhPJwwAXc1jdBJUVxIfZzAGaoNjtxW6z+03rzFNRkYIRhS3U3UQGgVg8HtMDGBV4LzPfBjmvb85A==
X-Received: by 2002:a05:6512:128a:: with SMTP id u10mr2941836lfs.378.1621424917725;
        Wed, 19 May 2021 04:48:37 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o2sm1846470ljp.60.2021.05.19.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:48:37 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 5/9] diff-merges: move specific diff-index "-m" handling to diff-index
Date:   Wed, 19 May 2021 14:45:48 +0300
Message-Id: <20210519114552.4180-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519114552.4180-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210519114552.4180-1-sorganov@gmail.com>
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

To handle this, in addition to moving specific diff-index "-m" code
out of diff-merges, we introduce new

  diff_merges_suppress_options_parsing()

and call it before generic options processing in cmd_diff_index().

This new diff_merges_suppress_options_parsing() could then be reused
and called before invocations of setup_revisions() for other commands
that don't need --diff-merges options, but that's outside of the scope
of these patch series.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/diff-index.c |  9 +++++++++
 diff-merges.c        | 25 +++++++++++++------------
 diff-merges.h        |  2 ++
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 176fe7ff2b4e..cf09559e422d 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
+#include "diff-merges.h"
 #include "commit.h"
 #include "revision.h"
 #include "builtin.h"
@@ -27,6 +28,12 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	rev.abbrev = 0;
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
+	/*
+	 * We need no diff for merges options, and we need to avoid conflict
+	 * with our own meaning of "-m".
+	 */
+	diff_merges_suppress_options_parsing();
+
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -35,6 +42,8 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 			option |= DIFF_INDEX_CACHED;
 		else if (!strcmp(arg, "--merge-base"))
 			option |= DIFF_INDEX_MERGE_BASE;
+		else if (!strcmp(arg, "-m"))
+			rev.match_missing = 1;
 		else
 			usage(diff_cache_usage);
 	}
diff --git a/diff-merges.c b/diff-merges.c
index f3a9daed7e05..9ca00cdd0cc6 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -6,6 +6,7 @@ typedef void (*diff_merges_setup_func_t)(struct rev_info *);
 static void set_separate(struct rev_info *revs);
 
 static diff_merges_setup_func_t set_to_default = set_separate;
+static int suppress_parsing;
 
 static void suppress(struct rev_info *revs)
 {
@@ -30,17 +31,6 @@ static void set_first_parent(struct rev_info *revs)
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
@@ -101,14 +91,22 @@ int diff_merges_config(const char *value)
 	return 0;
 }
 
+void diff_merges_suppress_options_parsing(void)
+{
+	suppress_parsing = 1;
+}
+
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 {
 	int argcount = 1;
 	const char *optarg;
 	const char *arg = argv[0];
 
+	if (suppress_parsing)
+		return 0;
+
 	if (!strcmp(arg, "-m")) {
-		set_m(revs);
+		set_to_default(revs);
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->combined_imply_patch = 1;
@@ -155,6 +153,9 @@ void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
 
 void diff_merges_setup_revs(struct rev_info *revs)
 {
+	if (suppress_parsing)
+		return;
+
 	if (revs->combine_merges == 0)
 		revs->dense_combined_merges = 0;
 	if (revs->separate_merges == 0)
diff --git a/diff-merges.h b/diff-merges.h
index 09d9a6c9a4fb..b5d57f6563e3 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -11,6 +11,8 @@ struct rev_info;
 
 int diff_merges_config(const char *value);
 
+void diff_merges_suppress_options_parsing(void);
+
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
 void diff_merges_suppress(struct rev_info *revs);
-- 
2.25.1

