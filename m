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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2487FC433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 23:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D428E64FB0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 23:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBDXap (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 18:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhBDXag (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 18:30:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95342C061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 15:29:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id a16so6851836wmm.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 15:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lWl5oMZywpdSWlIVHWwdXwp1SyJVtsfWXZNH7AT7K4Y=;
        b=ZbY7nmQBW+g+yP5O+EFSE62eLwclSdvSIEVGAzBqATR11p5YP9xD4T+Tly/1VdEOtX
         u6N7JqWgZeRr3GNHuMCBTddqFo7yCk6wyFBWbN1aqT583ejNpbuuEqi7s9D3+JX/DSNx
         vSbWgX2v/+WDtEBMAwec6rJheisxB+e6DcNRU/mLYAuQZTbRGhQMZov2kic+I40lmzI2
         sGHU0mPe1PXqRJN/NGAhq++7TR6tSaDxFooSz5pqkfAe4p7lFUiZKCVC85JYWvGthJLu
         Ifc54nvln5U3c5YuBLl1cLl30uo+0Hn0UGbT2n7QgEm2tfP1e+tLY7QpmHR0e9WuKBx4
         4S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lWl5oMZywpdSWlIVHWwdXwp1SyJVtsfWXZNH7AT7K4Y=;
        b=by2Z2dZa/A5T8m9j8AhR+gTOBeZyHiTW4lI2gNkro0EfSDakttnl9yuXeMTYxMNe1d
         e/fik5LauWBONtpQS/THcdwnrjMFN8CsjTvaIBEQlcGAJEMeZhyl759R8YgGUatVJhpL
         8tGBOxeajWStSnJ/y0NocFkRNnxwCZkq/HOju9qAFS084w3bow11FHUe+9UMQ+K6191w
         gLvxtZUAW3T3cAvCHU0iVYjlhyj67n7k1MsidYvZuCCMNYhvuKbgQ12UxlDzBeDa9+bn
         fTYehonoNmr4MkHA5tH7seIlURVzKHZFZ5pshYXiUDMlaFNFVRLHwbh8fF3Qxo0aIa2z
         bKWA==
X-Gm-Message-State: AOAM532GOC4/tWzy6yPWoMcESF/GDnBz+dZeWBeCdomgDDQLhcJfD+IY
        FuDGoYT4B+Ip8kN88/IHSK/rPhz3Khw=
X-Google-Smtp-Source: ABdhPJyzHmUZJRH9ktJ8/wA7XxSrYMtVznBLNhBKLlInnMwOm9h1ucvBxkx7jbQuQLIyqla4nxcLGA==
X-Received: by 2002:a7b:c153:: with SMTP id z19mr1159320wmi.87.1612481395101;
        Thu, 04 Feb 2021 15:29:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm7642670wmc.42.2021.02.04.15.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 15:29:54 -0800 (PST)
Message-Id: <b98fa94b87037b811ea973c1aeb7cfe08d7c1bd6.1612481392.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v5.git.1612481392.gitgitgadget@gmail.com>
References: <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
        <pull.841.v5.git.1612481392.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 23:29:50 +0000
Subject: [PATCH v5 1/3] range-diff/format-patch: refactor check for commit
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

