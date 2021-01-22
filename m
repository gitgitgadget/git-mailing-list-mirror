Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D123DC10F00
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B399C23AF8
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbhAVSkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbhAVSRA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 13:17:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B1C061786
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 10:16:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g10so5976326wrx.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 10:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WNn/b50LA8pa+dQx7PCUJLoOEaMfXPro4ERU2UQYmEw=;
        b=KFYb/8rLYOggXPWtxb0mLGof+w7TGB8fFykVqlQpD/mAgzQINAj3QctwMC2isHMPJZ
         EJJiX3YgrOzNIA6uasyROOQC0+LNXMnAJo4oZNqJPjVtEGLZIaH4MoiVUDRGZakKlfTC
         8DEsubPVS3Taeafd7CoLvtKoO4px+cE2/Rrk6QnMvZVzLHphaZOb3Op6fwcZvgooCVQ4
         eHYtNwXeiU4M4Lmy+hMdKtO56bVrPNESdAA56UCq1AmKdLhFkADYWDf30c+qIODkXp9a
         XLh5Q8+jNsq0fnzuGFxU81p7Ek0A+wEZXpTSEdCbLxV/ojrDueSJBa4mgqdazmlEj0cO
         bY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WNn/b50LA8pa+dQx7PCUJLoOEaMfXPro4ERU2UQYmEw=;
        b=MNINUgqggXH8K2AnWeUETFaGfB+DRiZUDMrhCOKQfEknq9Zk5uNIfQ6RfYF18Xl+RY
         4WieDcH/apS9s2J6o9EEMPfPRRnkCje+sIhD5BNSZX8goVK+vgCfZ5zV6AIasU6HnS1q
         6RbjpIzfYtuLJnN6MQtKh3oawoe+ldmcjRyed3M+9sW17NAEC+vRI+RrgNMpbk+eB7dM
         clnsL8eS+KyFAjrQGNYsQ4zm4Ll3KNvToSfHv2tF2HF/bjbuKso5ABEPXm9wMhEJtOts
         u+2cDRuLzX9eeWb7QuZWlZo6fEzNd5HfWLO84LG3E2vq6Er2qbt6d8QaAfB7o1czl8sx
         xMQQ==
X-Gm-Message-State: AOAM532dOZsCyAhJ3wtWn6tYr6Lb44fgOTe7py+riZsNuVxelDchXcdz
        L+19PH1t/vESayCTTwMkGbgarvGpYZc=
X-Google-Smtp-Source: ABdhPJz3QrMdMPSQJexwiFjgyAXpCByoxN55W0EaogxYYm1MBSp5I+W3Qdd+jgGGfIzynymMdKE/vQ==
X-Received: by 2002:a5d:4d84:: with SMTP id b4mr5935506wru.361.1611339375308;
        Fri, 22 Jan 2021 10:16:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6sm1765093wro.27.2021.01.22.10.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 10:16:14 -0800 (PST)
Message-Id: <3f21e10f919eead049dc2440a29bb2bed6c99d0d.1611339373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 18:16:10 +0000
Subject: [PATCH v2 1/3] range-diff/format-patch: refactor check for commit
 range
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Currently, when called with exactly two arguments, `git range-diff`
tests for a literal `..` in each of the two. Likewise, the argument
provided via `--range-diff` to `git format-patch` is checked in the same
manner.

However, `<commit>^!` is a perfectly valid commit range, equivalent to
`<commit>^..<commit>` according to the `SPECIFYING RANGES` section of
gitrevisions[7].

In preparation for allowing more sophisticated ways to specify commit
ranges, let's refactor the check into its own function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/log.c        | 2 +-
 builtin/range-diff.c | 9 +++++----
 revision.c           | 5 +++++
 revision.h           | 7 +++++++
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index bd6ff4f9f95..099abdfb7e6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1680,7 +1680,7 @@ static void infer_range_diff_ranges(struct strbuf *r1,
 				    struct commit *head)
 {
 	const char *head_oid = oid_to_hex(&head->object.oid);
-	int prev_is_range = !!strstr(prev, "..");
+	int prev_is_range = specifies_commit_range(prev);
 
 	if (prev_is_range)
 		strbuf_addstr(r1, prev);
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 24c4162f744..89d54158011 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -3,6 +3,7 @@
 #include "parse-options.h"
 #include "range-diff.h"
 #include "config.h"
+#include "revision.h"
 
 static const char * const builtin_range_diff_usage[] = {
 N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
@@ -46,12 +47,12 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		diffopt.use_color = 1;
 
 	if (argc == 2) {
-		if (!strstr(argv[0], ".."))
-			die(_("no .. in range: '%s'"), argv[0]);
+		if (!specifies_commit_range(argv[0]))
+			die(_("not a commit range: '%s'"), argv[0]);
 		strbuf_addstr(&range1, argv[0]);
 
-		if (!strstr(argv[1], ".."))
-			die(_("no .. in range: '%s'"), argv[1]);
+		if (!specifies_commit_range(argv[1]))
+			die(_("not a commit range: '%s'"), argv[1]);
 		strbuf_addstr(&range2, argv[1]);
 	} else if (argc == 3) {
 		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
diff --git a/revision.c b/revision.c
index 9dff845bed6..00675f598a3 100644
--- a/revision.c
+++ b/revision.c
@@ -4206,3 +4206,8 @@ void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
 	fputs(mark, stdout);
 	putchar(' ');
 }
+
+int specifies_commit_range(const char *range)
+{
+	return !!strstr(range, "..");
+}
diff --git a/revision.h b/revision.h
index 086ff10280d..66777c8e60f 100644
--- a/revision.h
+++ b/revision.h
@@ -457,4 +457,11 @@ int rewrite_parents(struct rev_info *revs,
  */
 struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
 
+/*
+ * Determine whether the given argument defines a commit range, e.g. A..B.
+ * Note that this only validates the format but does _not_ parse it, i.e.
+ * it does _not_ look up the specified commits in the local repository.
+ */
+int specifies_commit_range(const char *range);
+
 #endif
-- 
gitgitgadget

