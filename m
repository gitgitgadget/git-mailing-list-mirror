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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1668C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C54F64DA1
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhA0QkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbhA0QiI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 11:38:08 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4849C0613D6
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:37:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 6so2586504wri.3
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BMf0eGh6RQVhJNMs3kyLeEL57vg6b92BtnERf3iL3P0=;
        b=TDRgQ5m3V3eSrM5aiGomQQ/To+a+2nxw1AxqHRy24DE9G8alkvUYDHOEsMhNSNC2RH
         k080M0PkUalRKGKINs6jQ17Epka1lieGget65wr/T5YH3xZ9LCkI+ffo0BSHq4Kvxhtc
         sBWtMw0/VRoCFZSF5uuv3p4m0jWe9AnO7vZlmRFvm/SgwvTxcFF1vr9NM+K1kNFrcSLn
         UF7P2QWEMNdZ4CSgd2Un5fWLCa99ptmfxb9e0YW/+E+lT5YtE/jcdRrcVrk7wbO7zSAd
         zX2fhhcGM3e+6qsKgxdYqBl3istD7GnMCdNkb9Rw3lxoPQOXXBK/lCBTt1F2CrKHTgCe
         ygWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BMf0eGh6RQVhJNMs3kyLeEL57vg6b92BtnERf3iL3P0=;
        b=mOc8XGcWrykYsy1DBpKeVf45K3kGH8JhG9U3CrOD09uNlJyxi2GgB9/6cK6EvEW9Qu
         jn/y4SkLz477KeY+Yy3QnLd0ndtgz8roVQaQHY56jRvtlCgTienu89sjQir/L9HZZNQf
         BESxpqPvTmWM0cFXU1t1/J9larDEZ/uRViBneEzQeqh6tFDD18QzNkBBQN/qicSvRKL0
         Kkt+pyiaEX1NXvLuFnYE34NKo83bXAvyDqc3mnIffiF5juoTUgrTKFg6C8q0UX/wvVs0
         ThtNaqwNJEeBJdkATbXOEueDmMcUa56XxxbQ3tEl/uSkYDUDe2kWoSZQiWGoFbFrkUK3
         W5Aw==
X-Gm-Message-State: AOAM530Fg03JJqljZx/2GYwe5SCvKUHh8efTJfruj2y3+KOkhbf5sw94
        48u+xduiHWGEid22va5vVlL8mJwhNNQ=
X-Google-Smtp-Source: ABdhPJyA2jlOZTtUSYeBJgRqjpzuA35yWNroQkJWUwkZvZc6unJU4m/DTHZ7pNXihuhTbLguBtP9XA==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr12087388wre.344.1611765447254;
        Wed, 27 Jan 2021 08:37:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g187sm3144731wmf.1.2021.01.27.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 08:37:26 -0800 (PST)
Message-Id: <b98fa94b87037b811ea973c1aeb7cfe08d7c1bd6.1611765444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
References: <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
        <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 16:37:22 +0000
Subject: [PATCH v3 1/3] range-diff/format-patch: refactor check for commit
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
index bd6ff4f9f95..aeece57e86a 100644
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
index 24c4162f744..5b1f6326322 100644
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
index b9950f10c8c..9b93e08e840 100644
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
index 583ced2e8e7..c17dbc2e75a 100644
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

