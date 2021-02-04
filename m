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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD95C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBC464F58
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 09:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhBDJcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbhBDJcS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 04:32:18 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCBAC0613D6
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 01:31:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u14so2673204wri.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 01:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lWl5oMZywpdSWlIVHWwdXwp1SyJVtsfWXZNH7AT7K4Y=;
        b=TYbCT7+mA5Kj7QL4W/bqXrWmgVVaMo4BP4rE1JnMwkt4/XRzZUW/L+vxA5myhZEB+s
         k+6/EU6a9Kclfv6xr51iBIrAe3MGSW5ndfqUCjWcPOPVlD7AkuY1b8aI6Ekv8k5wb93d
         ce7WB98hWgZ2uNejHhWLDk+l3nFOMJxNqNj6lavki7e1QMZwfIfQrqQIKZVAH+5y+r80
         bohQcMwNBsCVstjtYw3zYdnWdFNG1U+2pafSTY8a9twCv4W4Tip0QEYBp5evmfcI6Z5M
         TIa33w+enTmKlhQvxXnQ4QJiOFQ7ImWAQH7q7SBa/VAqVudUU1ph0/1eE8w1GKfYr8hh
         +MuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lWl5oMZywpdSWlIVHWwdXwp1SyJVtsfWXZNH7AT7K4Y=;
        b=FN0Gap0bQ54VRRxR4X8Vy2gqPlnIMBEbJXM/ZfcEC0A2nFfFOtW4zxFa60TT9S+iRX
         BgbAtMXuJTMHdyUZ3H5wveCSiwn26SG1ieJDI2oQTYxbI2mlkZVc+H0odE2o40BRlIs+
         eaz+HEz/PVgyZGTKpSVSHPlNF/l1xmsKq1abYlARlv352CAVMCXuQnBDdruDFNPtOC0n
         JAdeWKSQnIGqu6rpTOSdOMpYAN14x8jwBLlLqPpEpjma3+KHl8gQ0BNSowm7ytVrWa68
         yPjxYC+FcvmMXdR6kA3BWvg2pB0yBXwZLNjElW+78XHx7GGqBVn98D2ML1vOgfr/aowB
         13Yg==
X-Gm-Message-State: AOAM5303bw9dkaGzZJOQAn7x5f460XzAuRTQpGwg0EX5TVLd/zlLI4Uf
        RDyhbBMyAmdRqTUtUxi7g7z75Vd2kpc=
X-Google-Smtp-Source: ABdhPJzgXOvPs/To0eqFhiDcgiTXgtw/frqm7uT9XHBL55iRkgr+2KqaRVgcMklvwqT9vLgA+LB6Gw==
X-Received: by 2002:a05:6000:1364:: with SMTP id q4mr7955363wrz.335.1612431096412;
        Thu, 04 Feb 2021 01:31:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3sm1872900wrr.6.2021.02.04.01.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 01:31:35 -0800 (PST)
Message-Id: <b98fa94b87037b811ea973c1aeb7cfe08d7c1bd6.1612431093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
        <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 09:31:30 +0000
Subject: [PATCH v4 1/3] range-diff/format-patch: refactor check for commit
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

