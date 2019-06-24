Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732D41F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbfFXSNf (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:13:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34234 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731820AbfFXSNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:13:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so14946795wrl.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08oo5kXeqGBZVSQi1iecIauL4nW/6JU4igUWM/AIHQw=;
        b=V0eBmfifyeLHdDLL6GPgtCki8FBarioFSnLgdhdXONzF1BBBPxPQ6Nl9HSCX4BTTbk
         5uO9lttrSdUTKN566CfAGWZmXEpj0QOSrqekrbrcSiy0tGM3sf6Qhy9NSjz5cr12zuA1
         n370wZPrWzdJ0hhWZo6EK1qkKmTtfz5RiirItlkz9YlMWuPADTi83JDX3PFIOWIZrz9C
         hcyRDPTk1w+G79fvno5+9gGXXeHWUN1qNhq+h3TAg5ehqDMd4OtP5q1pKeXVlb25WJbK
         BFYpCQW6LBQUzaAYg+fZz/nVGDSM2JROeJ3FqVIqPO/Tu8guTfJT4nNdE+PGZYH6OfOH
         UDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08oo5kXeqGBZVSQi1iecIauL4nW/6JU4igUWM/AIHQw=;
        b=jy3AEFCy9XrV2A2VaQyvegk+1MgwiZkmJb9Xh2k3GJSEnWQcqEF95VgzNrUMFbSZ4L
         jQfq+GCyIMQ21z+BrYX9kd0WBO6Sh/SmY+L/mDNCplFTO13Z6ILuSZ2WDXhTWv9/ONgc
         9a2UNt15c86TPgw9LIAGhpa2AjCEkMxRMyfW3hyaPCg91iX7h95RVpTLhsuOOdMwBPE6
         OlMyuccUyFEBdRfG0gwc0Ev3ExfYLz0XBTfJ5J0X13OgyTNo9c5rNMNSrwvy7MpESgqY
         zQMXlkh1Oq4BlfWhhJVE0BciDbE1/AMuupz34hz0TvVzd6rQDf9FGwUqss09GEqp+6+v
         WTaw==
X-Gm-Message-State: APjAAAWpjuMo1tE2x5ZXmmx6/+d+1XughCMAJ9vb7cxAmD9Yj9+acGKK
        TjQgbeBjbcAcHL7f/3PRIPY=
X-Google-Smtp-Source: APXvYqwnLETTZvJ5a3KI+ZWXMDE6eJOL2GcXTRebtZc1s1/DYTHWOwTUbV9Fn7wyTzddLRSaFyq61A==
X-Received: by 2002:adf:8183:: with SMTP id 3mr97741759wra.181.1561400010815;
        Mon, 24 Jun 2019 11:13:30 -0700 (PDT)
Received: from localhost.localdomain (x4db9a89d.dyn.telefonica.de. [77.185.168.157])
        by smtp.gmail.com with ESMTPSA id v65sm401349wme.31.2019.06.24.11.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 11:13:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 5/5] progress: use term_clear_line()
Date:   Mon, 24 Jun 2019 20:13:18 +0200
Message-Id: <20190624181318.17388-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
In-Reply-To: <20190624181318.17388-1-szeder.dev@gmail.com>
References: <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190624181318.17388-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make sure that the previously displayed progress line is completely
covered up when the new line is shorter, commit 545dc345eb (progress:
break too long progress bar lines, 2019-04-12) added a bunch of
calculations to figure out how many characters it needs to overwrite
with spaces.

Use the just introduced term_clear_line() helper function to, well,
clear the last line, making all these calculations unnecessary, and
thus simplifying the code considerably.

Three tests in 't5541-http-push-smart.sh' 'grep' for specific text
shown in the progress lines at the beginning of the line, but now
those lines begin either with the ANSI escape sequence or with the
terminal width worth of space characters clearing the line.  Relax the
'grep' patterns to match anywhere on the line.  Note that only two of
these three tests fail without relaxing their 'grep' pattern, but the
third looks for the absence of the pattern, so it still succeeds, but
without the adjustment would potentially hide future regressions.

Note also that with this change we no longer need the length of the
previously displayed progress line, so the strbuf added to 'struct
progress' in d53ba841d4 (progress: assemble percentage and counters in
a strbuf before printing, 2019-04-05) is not strictly necessary
anymore.  We still keep it, though, as it avoids allocating and
releasing a strbuf each time the progress is updated.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c                 | 28 +++++++++++-----------------
 t/t5541-http-push-smart.sh |  6 +++---
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/progress.c b/progress.c
index a2e8cf64a8..095dcd0ddf 100644
--- a/progress.c
+++ b/progress.c
@@ -88,7 +88,6 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	const char *tp;
 	struct strbuf *counters_sb = &progress->counters_sb;
 	int show_update = 0;
-	int last_count_len = counters_sb->len;
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
@@ -116,26 +115,21 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	if (show_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
 			const char *eol = done ? done : "\r";
-			size_t clear_len = counters_sb->len < last_count_len ?
-					last_count_len - counters_sb->len + 1 :
-					0;
-			size_t progress_line_len = progress->title_len +
-						counters_sb->len + 2;
-			int cols = term_columns();
 
+			term_clear_line();
 			if (progress->split) {
-				fprintf(stderr, "  %s%*s", counters_sb->buf,
-					(int) clear_len, eol);
-			} else if (!done && cols < progress_line_len) {
-				clear_len = progress->title_len + 1 < cols ?
-					    cols - progress->title_len - 1 : 0;
-				fprintf(stderr, "%s:%*s\n  %s%s",
-					progress->title, (int) clear_len, "",
-					counters_sb->buf, eol);
+				fprintf(stderr, "  %s%s", counters_sb->buf,
+					eol);
+			} else if (!done &&
+				   /* The "+ 2" accounts for the ": ". */
+				   term_columns() < progress->title_len +
+						    counters_sb->len + 2) {
+				fprintf(stderr, "%s:\n  %s%s",
+					progress->title, counters_sb->buf, eol);
 				progress->split = 1;
 			} else {
-				fprintf(stderr, "%s: %s%*s", progress->title,
-					counters_sb->buf, (int) clear_len, eol);
+				fprintf(stderr, "%s: %s%s", progress->title,
+					counters_sb->buf, eol);
 			}
 			fflush(stderr);
 		}
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8ef8763e06..2e4802e206 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -213,7 +213,7 @@ test_expect_success TTY 'push shows progress when stderr is a tty' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit noisy &&
 	test_terminal git push >output 2>&1 &&
-	test_i18ngrep "^Writing objects" output
+	test_i18ngrep "Writing objects" output
 '
 
 test_expect_success TTY 'push --quiet silences status and progress' '
@@ -228,7 +228,7 @@ test_expect_success TTY 'push --no-progress silences progress but not status' '
 	test_commit no-progress &&
 	test_terminal git push --no-progress >output 2>&1 &&
 	test_i18ngrep "^To http" output &&
-	test_i18ngrep ! "^Writing objects" output
+	test_i18ngrep ! "Writing objects" output
 '
 
 test_expect_success 'push --progress shows progress to non-tty' '
@@ -236,7 +236,7 @@ test_expect_success 'push --progress shows progress to non-tty' '
 	test_commit progress &&
 	git push --progress >output 2>&1 &&
 	test_i18ngrep "^To http" output &&
-	test_i18ngrep "^Writing objects" output
+	test_i18ngrep "Writing objects" output
 '
 
 test_expect_success 'http push gives sane defaults to reflog' '
-- 
2.22.0.589.g5bd7971b91

