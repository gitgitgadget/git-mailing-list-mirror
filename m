Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5B9C433F1
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F2B2076A
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7rClZnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGQKyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGQKyp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEE2C061755
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so14194369wme.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/qIjWfT4mtBFleFBV+pP34DT95UJ+LOk41nFSdQcsqk=;
        b=Z7rClZnUTidt0v7RBHU5Fz6d2qU5vpAT6r3cMOPz1ihPE8frVV8kd3d15QCgAKKPFj
         I8U503Idk5bxXLJnzthjMUF2EUhm4iWzkazWjL+N8SnqpPfkkZsoRhHIdYfHhF70HbND
         XTGYkCwhdEoIEd3qb0yRLLzZhSzl/zBxQNNjNOg7XO7b3uCdogn7Bq1L2DvrFNWYnkWZ
         q2hWJocb2uCatHpDZt+uBHGgcNoENXtYNfCsG+U4fbO3h+Li1jjdIPIkz1z8n+bjOm/x
         AhflepOgpJuQN8DI7eONdKZYUaiaxYEEsHgcuhir8nSX7AjuE5MJH9heZ9PAT0euBmN/
         cJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/qIjWfT4mtBFleFBV+pP34DT95UJ+LOk41nFSdQcsqk=;
        b=UfG+1ACSKDRClQHyzWv8EaUKcxW7d0WSfUnv2Do9Fj/XyOcRGuq6POIQ9bEecpwkzl
         DlmCIY7D62sxb5Rc8P85iaG7O14TyvrII8rUE7XVExInB2GbvbZHdzifgYRxM6eixt7+
         evWBYSxGmk+KS+gZX6QK+he10HOsPi8j2WLG3xRnAi/zwA0V8BXR4BH703mqt0BD/npl
         zt+EZ5ZRCVsFPFsCzVhT1jh/BexdUj6wt35+CHoUB+Knr670yZLHLtihvE4ME9s4Cz3h
         aI9AzVSW29Is9NP95PTKAl2yEh8YEZy2ZpEtIJc/zlGVGAPjeZ8nqBhqTfsHadL1bk73
         D/4Q==
X-Gm-Message-State: AOAM531TbHjEDHiYXnWar9e9VlbfZWIXCdZEVHtCJbpy+Jf0cTR+W4MK
        O8YNn4A+jM/hf1EfeVfx0wMqzaX2
X-Google-Smtp-Source: ABdhPJwTMxspBquHbSsJiAYIGlsBfspMLRIhZV3aHKt6AddYLyNU+uteQsCs1Qkp6NryLwhhgbRQ8g==
X-Received: by 2002:a7b:c921:: with SMTP id h1mr8151316wml.29.1594983283197;
        Fri, 17 Jul 2020 03:54:43 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:42 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 09/13] bisect--helper: retire `--next-all` subcommand
Date:   Fri, 17 Jul 2020 12:54:02 +0200
Message-Id: <20200717105406.82226-10-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--next-all` subcommand is no longer used from the git-bisect.sh
shell script. Instead the function `bisect_next_all()` is called from
the C implementation of `bisect_next()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index a8742dc37d..fc6bf36e42 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
@@ -861,8 +860,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		NEXT_ALL = 1,
-		WRITE_TERMS,
+		WRITE_TERMS = 1,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -876,8 +874,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "next-all", &cmdmode,
-			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
@@ -916,9 +912,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case NEXT_ALL:
-		res = bisect_next_all(the_repository, prefix, no_checkout);
-		break;
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
-- 
2.25.0

