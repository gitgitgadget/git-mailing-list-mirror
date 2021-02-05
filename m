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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EADEC433E9
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3905564FF2
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhBEWaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhBEOTR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:19:17 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180FCC061223
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 07:47:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id w2so12550932ejk.13
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lWl5oMZywpdSWlIVHWwdXwp1SyJVtsfWXZNH7AT7K4Y=;
        b=sMtPz1UHOAsvyiYxjsmDQ7kFQMqCdz4Euj9eCzs4837U/+4EAmaaSUolBTtaPA+W9l
         a1M0pi0ZY54dUF0FmnaNTytCQO34NAfYJFONIZnRV/+sEWTjQmDbgW2FA4Bq9hR6Y9Jj
         pE3lMkaSnSfxi8epGXUQKZPwa+NVU0BQ6FLI3FizxQ63kevXST9MeNwM66FyFXLK3n5T
         umv+7+MYYxb1+hwMM1o/eAl3wSbA3gL8SIJ6wv+/zxMb9CWniF9PYfL4UjzgV/jlYeo7
         IgVIQVQilIhLq211OP+Qd+3GPFJm1fYivxbM4aH4XcY42sdTeT4WevlzhjQvI3GBolMO
         81ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lWl5oMZywpdSWlIVHWwdXwp1SyJVtsfWXZNH7AT7K4Y=;
        b=NSyumdbQOXfQNQ30BhC+rWvSIvapSstXAqg7pne91eInZ4ljhlR6/50xCwiGh4UqhC
         mFgq34V3T7lBd/FVhq06A9FxYAYEWtiQ2ax+xIg8zvqdiYuaPOHlIiweXBX50zmKVhQn
         dU2fi+ORNtGHFlUYovT2Iow+u9a5DSrX3Be46f0zmD1FfiGat1AEqQmlDOyK2cH51Ta0
         zXemV0v+n1srsLbb8YFJmrFqMtOG/qRzvuNEerHrpNNrYlMSasjT5e8J4Yb7axizzwAT
         8K/24uo4zEOkDQYmMofAZgPinAglCFAVJSJVbqG2B5rOrhIKHMUZBH2Sfl0gvFhxZS36
         MEZQ==
X-Gm-Message-State: AOAM533hAd5lb+jUeESQXll69dQPD3MkVwcR4e1p0+gP8AQeW23c7cE4
        XlAL2JyeLg+YzwltVCUUVBxqU9wNjl8=
X-Google-Smtp-Source: ABdhPJwu8F7QTRqQS9veNxq9fog4hYsQgKaKAHOHkCIGNLI84PoLF43xe8fAz5tEIkMheOPZeNQRLw==
X-Received: by 2002:a5d:4203:: with SMTP id n3mr5376681wrq.49.1612536292475;
        Fri, 05 Feb 2021 06:44:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm11792751wrt.85.2021.02.05.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:44:51 -0800 (PST)
Message-Id: <b98fa94b87037b811ea973c1aeb7cfe08d7c1bd6.1612536290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v6.git.1612536290.gitgitgadget@gmail.com>
References: <pull.841.v5.git.1612481392.gitgitgadget@gmail.com>
        <pull.841.v6.git.1612536290.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:44:47 +0000
Subject: [PATCH v6 1/3] range-diff/format-patch: refactor check for commit
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
 range-diff.c         | 5 +++++
 range-diff.h         | 8 ++++++++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index bd6ff4f9f956..aeece57e86a2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1680,7 +1680,7 @@ static void infer_range_diff_ranges(struct strbuf *r1,
 				    struct commit *head)
 {
 	const char *head_oid = oid_to_hex(&head->object.oid);
-	int prev_is_range = !!strstr(prev, "..");
+	int prev_is_range = is_range_diff_range(prev);
 
 	if (prev_is_range)
 		strbuf_addstr(r1, prev);
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 24c4162f7446..5b1f6326322f 100644
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
+		if (!is_range_diff_range(argv[0]))
+			die(_("not a commit range: '%s'"), argv[0]);
 		strbuf_addstr(&range1, argv[0]);
 
-		if (!strstr(argv[1], ".."))
-			die(_("no .. in range: '%s'"), argv[1]);
+		if (!is_range_diff_range(argv[1]))
+			die(_("not a commit range: '%s'"), argv[1]);
 		strbuf_addstr(&range2, argv[1]);
 	} else if (argc == 3) {
 		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
diff --git a/range-diff.c b/range-diff.c
index b9950f10c8c4..9b93e08e8407 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -564,3 +564,8 @@ int show_range_diff(const char *range1, const char *range2,
 
 	return res;
 }
+
+int is_range_diff_range(const char *arg)
+{
+	return !!strstr(arg, "..");
+}
diff --git a/range-diff.h b/range-diff.h
index 583ced2e8e74..c17dbc2e75a8 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -16,4 +16,12 @@ int show_range_diff(const char *range1, const char *range2,
 		    const struct diff_options *diffopt,
 		    const struct strvec *other_arg);
 
+/*
+ * Determine whether the given argument is usable as a range argument of `git
+ * range-diff`, e.g. A..B. Note that this only validates the format but does
+ * _not_ parse it, i.e. it does _not_ look up the specified commits in the
+ * local repository.
+ */
+int is_range_diff_range(const char *arg);
+
 #endif
-- 
gitgitgadget

