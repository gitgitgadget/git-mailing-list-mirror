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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48FFC0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE882342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbgLPSvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732193AbgLPSvG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:06 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7302C06179C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:25 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m12so51018290lfo.7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FY7eGwDY58mSyshvP5xYmwpKGCQ8L33LWg6ZcfBc4I4=;
        b=g93X1sa2qTIBWXLAQHZXAeLjC+FFKLqrVX+LvBZ+9Eo6M3sfBvHMw0Y6Dw+R8pqGVN
         8JhzXGuMnGHM6CzHzHkFj9V2uKt/rqrFOJM7dA3QBcjrprR7FsP/f14nZYOJt6qUoPh1
         0VzuOpJPJNputmZ9ucRgi49Sg93IFNKDJncicYVAZ/Yhe5Gs9NRRywib6Wo75tbFmvWv
         8hSb6ZT44n18q1y9MGdgYQ6xI8eLprfuwrlNMzNK9bQm81p3gOZ+WQaoIkwj0dZ8pPyz
         o5v+eueKy32ZA8mIeUmSppftdOWLcXk9ZYB+khWBPZ8s/8eeCfykjVQ5gREmdQCfl+JI
         Hmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FY7eGwDY58mSyshvP5xYmwpKGCQ8L33LWg6ZcfBc4I4=;
        b=d5P0yiMJvMqSY1iuMcOOms5jHoZyC/CnXUFW0vtSmP7KPakC8VpnISq21Cl2KSTaRr
         0m78svlivmo4nxq+SSaC8WAH+i9i4dCkQjRRPEBfopn4M4ybWV+GhL2MW7SpssO8tlha
         vnTFE1ziBfblEAlrAMKgQP3A/nyug9ljIHflrsxY4R8iTR6ZUDVaezjwcmX9xBZdk1O4
         AvfAxFUwb6O4LVk266HI65st+ncQrL4Z/X5GFStojFB+wK+CbWopielrVdLuQX/U97zt
         gQB6vN3v7TrcFi1K4RnFuQ4rUZW/Y/jhzw2PBRmK5+FJep8wCzP1MYiRGDlYbGpDM7Fc
         9b9g==
X-Gm-Message-State: AOAM532WsLZ36BK6yz3yd5PPCTX8Um+TSvmjG3sm3qwl2R+kHi9fQdGp
        fXfN0D2vEffC38RgG7vwGeX3t77WHMo=
X-Google-Smtp-Source: ABdhPJyWuEdXeRC+P3dt09wqzptY8qLDbvMYq546Ya47sN2UPbaynlnp29gSp/hGmuZ+TQLFUQmzkA==
X-Received: by 2002:ac2:548b:: with SMTP id t11mr14267634lfk.181.1608144623338;
        Wed, 16 Dec 2020 10:50:23 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:22 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 01/33] revision: factor out parsing of diff-merge related options
Date:   Wed, 16 Dec 2020 21:48:57 +0300
Message-Id: <20201216184929.3924-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move all the parsing code related to diffing merges into new
parse_diff_merge_opts() function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 66 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/revision.c b/revision.c
index aa6221204081..917b14e6ad5b 100644
--- a/revision.c
+++ b/revision.c
@@ -2153,6 +2153,44 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
+static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
+	int argcount = 1;
+	const char *optarg;
+	const char *arg = argv[0];
+
+	if (!strcmp(arg, "-m")) {
+		/*
+		 * To "diff-index", "-m" means "match missing", and to the "log"
+		 * family of commands, it means "show full diff for merges". Set
+		 * both fields appropriately.
+		 */
+		revs->ignore_merges = 0;
+		revs->match_missing = 1;
+	} else if (!strcmp(arg, "-c")) {
+		revs->diff = 1;
+		revs->dense_combined_merges = 0;
+		revs->combine_merges = 1;
+	} else if (!strcmp(arg, "--cc")) {
+		revs->diff = 1;
+		revs->dense_combined_merges = 1;
+		revs->combine_merges = 1;
+	} else if (!strcmp(arg, "--no-diff-merges")) {
+		revs->ignore_merges = 1;
+	} else if (!strcmp(arg, "--combined-all-paths")) {
+		revs->diff = 1;
+		revs->combined_all_paths = 1;
+	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
+		if (!strcmp(optarg, "off")) {
+			revs->ignore_merges = 1;
+		} else {
+			die(_("unknown value for --diff-merges: %s"), optarg);
+		}
+	} else
+		argcount = 0;
+
+	return argcount;
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
@@ -2349,34 +2387,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
 		revs->diffopt.flags.tree_in_recursive = 1;
-	} else if (!strcmp(arg, "-m")) {
-		/*
-		 * To "diff-index", "-m" means "match missing", and to the "log"
-		 * family of commands, it means "show full diff for merges". Set
-		 * both fields appropriately.
-		 */
-		revs->ignore_merges = 0;
-		revs->match_missing = 1;
-	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
-		if (!strcmp(optarg, "off")) {
-			revs->ignore_merges = 1;
-		} else {
-			die(_("unknown value for --diff-merges: %s"), optarg);
-		}
+	} else if ((argcount = parse_diff_merge_opts(revs, argv))) {
 		return argcount;
-	} else if (!strcmp(arg, "--no-diff-merges")) {
-		revs->ignore_merges = 1;
-	} else if (!strcmp(arg, "-c")) {
-		revs->diff = 1;
-		revs->dense_combined_merges = 0;
-		revs->combine_merges = 1;
-	} else if (!strcmp(arg, "--combined-all-paths")) {
-		revs->diff = 1;
-		revs->combined_all_paths = 1;
-	} else if (!strcmp(arg, "--cc")) {
-		revs->diff = 1;
-		revs->dense_combined_merges = 1;
-		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
 	} else if (!strcmp(arg, "--pretty")) {
-- 
2.25.1

