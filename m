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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3CBC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 16:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4471564EA1
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 16:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhBEOzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 09:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhBEOw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:52:59 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D0FC06121C
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:31:04 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hs11so12915024ejc.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4vOvP8GvypLyqwVS8j8edlPeLJbqOe1KQrGSvUN46RE=;
        b=ab6E/089WRPOyiy2HegvLSN7mrjK77w133hgcc6Vc5DAVLGUoU/r3ZYufa2/axRtW2
         YvZm051ZYY6QGfvnfbAGj1tFiC5/oUejPdPmrmU/yOuWdfCF06uhrS6ist2vHagsKQJI
         qPnKee0OnZJqtCPYyuosr58Ehw39d0b6KA5WqkMIjEnUisrzvreyr0v75g1ieDRMfcSw
         uY7YcT5ZAh1hS7O8TMGKOjDDvIWvI8gAoR6e0ThwafzFd4QJxH3/Fg5YMuC9sgE2wlC0
         Mpnmz37DTuQnZbUtl24du+URNHejyBP+t2U2jv86ohxkzHl7TCqUjnHj5CcPb/FnubFz
         bstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4vOvP8GvypLyqwVS8j8edlPeLJbqOe1KQrGSvUN46RE=;
        b=Yt3WBuFcPMQjH5Yj00V3hKzzsaT3K/V0RQ8Ezehqdo1jgisGfbjTXFwRqNJKs1nDTl
         ijDMbdaqoyqE6/xqYzzGDp1Eb+sHNVohmaOxg+4xxyUUB/9GNvgr5bh0w/1s0qRR6ESG
         suB9TZJubwHFMBni5Sg3fsziywgc7V89BfFko+6XTsTRT8wDy+eW1pNnoVN9+njJ0Aaf
         OYOo16dn3TvF5MBxb/oQYa0TojtoNDjqAJX74U9RiINpNxCElZBgH19GWqRVTlhNhJDv
         m7skjffMGL6a0zcX2MAZs+NDL+7riHFaJ3LJVSAsfqDi41eziDO9fuJMhk3jey5aqh+V
         bYmQ==
X-Gm-Message-State: AOAM532/GxwBlnhFehSOVW2x55vfLqD15BNuFS8lg7WlqJvgaWqsIGLk
        fl6rk3KPogXJR/WBkGSGpeLC2JuYqpw=
X-Google-Smtp-Source: ABdhPJwu95+DZ1AfnKNYNpoT4AsWdlksigU86nem0L2nwb0AedxEIs6kv6twzI164Ci3+LvyR0A8Jg==
X-Received: by 2002:adf:d206:: with SMTP id j6mr5304297wrh.427.1612536293566;
        Fri, 05 Feb 2021 06:44:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c20sm8757126wmb.38.2021.02.05.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:44:52 -0800 (PST)
Message-Id: <f8e6a1ad9d3df20383edbb30592461974f439db8.1612536290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v6.git.1612536290.gitgitgadget@gmail.com>
References: <pull.841.v5.git.1612481392.gitgitgadget@gmail.com>
        <pull.841.v6.git.1612536290.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:44:48 +0000
Subject: [PATCH v6 2/3] range-diff/format-patch: handle commit ranges other
 than A..B
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

In the `SPECIFYING RANGES` section of gitrevisions[7], two ways are
described to specify commit ranges that `range-diff` does not yet
accept: "<commit>^!" and "<commit>^-<n>".

Let's accept them, by parsing them via the revision machinery and
looking for at least one interesting and one uninteresting revision in
the resulting `pending` array.

This also finally lets us reject arguments that _do_ contain `..` but
are not actually ranges, e.g. `HEAD^{/do.. match this}`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c          | 26 +++++++++++++++++++++++++-
 range-diff.h          |  4 +---
 t/t3206-range-diff.sh | 13 +++++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 9b93e08e8407..a88612cb8923 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -11,6 +11,7 @@
 #include "pretty.h"
 #include "userdiff.h"
 #include "apply.h"
+#include "revision.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -567,5 +568,28 @@ int show_range_diff(const char *range1, const char *range2,
 
 int is_range_diff_range(const char *arg)
 {
-	return !!strstr(arg, "..");
+	char *copy = xstrdup(arg); /* setup_revisions() modifies it */
+	const char *argv[] = { "", copy, "--", NULL };
+	int i, positive = 0, negative = 0;
+	struct rev_info revs;
+
+	init_revisions(&revs, NULL);
+	if (setup_revisions(3, argv, &revs, NULL) == 1) {
+		for (i = 0; i < revs.pending.nr; i++)
+			if (revs.pending.objects[i].item->flags & UNINTERESTING)
+				negative++;
+			else
+				positive++;
+		for (i = 0; i < revs.pending.nr; i++) {
+			struct object *obj = revs.pending.objects[i].item;
+
+			if (obj->type == OBJ_COMMIT)
+				clear_commit_marks((struct commit *)obj,
+						   ALL_REV_FLAGS);
+		}
+	}
+
+	free(copy);
+	object_array_clear(&revs.pending);
+	return negative > 0 && positive > 0;
 }
diff --git a/range-diff.h b/range-diff.h
index c17dbc2e75a8..4abd70c40fed 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -18,9 +18,7 @@ int show_range_diff(const char *range1, const char *range2,
 
 /*
  * Determine whether the given argument is usable as a range argument of `git
- * range-diff`, e.g. A..B. Note that this only validates the format but does
- * _not_ parse it, i.e. it does _not_ look up the specified commits in the
- * local repository.
+ * range-diff`, e.g. A..B.
  */
 int is_range_diff_range(const char *arg);
 
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 6eb344be0312..2b518378d4a0 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -150,6 +150,19 @@ test_expect_success 'simple A B C (unmodified)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'A^! and A^-<n> (unmodified)' '
+	git range-diff --no-color topic^! unmodified^-1 >actual &&
+	cat >expect <<-EOF &&
+	1:  $(test_oid t4) = 1:  $(test_oid u4) s/12/B/
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'A^{/..} is not mistaken for a range' '
+	test_must_fail git range-diff topic^.. topic^{/..} 2>error &&
+	test_i18ngrep "not a commit range" error
+'
+
 test_expect_success 'trivial reordering' '
 	git range-diff --no-color master topic reordered >actual &&
 	cat >expect <<-EOF &&
-- 
gitgitgadget

