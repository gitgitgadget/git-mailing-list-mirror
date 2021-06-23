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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4148C48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C3E611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhFWRvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFWRvH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFAEC06124C
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j2so3552008wrs.12
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLxGhaeE4kEOrVW9Q17yjFR4I7S07E1UaazbEpNpxF0=;
        b=IhhyNatJMpOnwYzG3ZRs1rHCAU7+0WFgefmZ8dxhW8v/SECGheeB4TlYJaLxYsr0+X
         rWTJ31LvdTfud6VC70qB0QlSp4RKlfw1nN+F9STGS/oVt+0XManzI1Y7s+Em5mlcElhF
         qxsXEvhRvxOLVxcGkR3OqtiTLfDS4uuAREOOUpnZqsRvEu+dWl7gHeR7yUFMq3qtIy1i
         MpbxN0bwi/Mqb36bvFIAGpbad2x1fmU8CBeY3K5RQkPuCSiwqICS2sRaS2xxcoO4bfju
         /QCpahI2stKKHZe+Xi2sn3aoPJsVfkVgzzDvCxrAoUbO5C0BKx1xZh6SoRYQL0SA2k51
         62YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLxGhaeE4kEOrVW9Q17yjFR4I7S07E1UaazbEpNpxF0=;
        b=K0kvorzEMexB17Dm8A57jNxqj2N/Rfi7zUubDsWOhfnAS3PY2cqrqa1YvusNnXD8BO
         1GYC6h6F8X3Nr+7l72Kk4KvkgL2ZakDI4LE11PNY3p8RDnpR24jO/8WHH0hNmjkaFpw9
         UIKS2bXlbK1U+B0l2J79YKMaxxbiEDYDQkYLBVg1SBZODOtTgX+eqTpdcNe7eBJHomGU
         52sqIj+Eg3VpZda2JsqvuBRdGYFKQQRKy+9w8/3vyWbpLGO2Y2OImzwoMC8gNjeDTxb+
         XNjJdWHTSTrLeF4PSjazyxofkhHBCrbSzW0EzIvTakOg4wJMNoEdGUOYWTA/42BAQZwu
         McEw==
X-Gm-Message-State: AOAM5322j/Pwv72A/7zUwpk4+5bl5CBMk5W5ugZHVrtCi2RnteaceL1r
        J7gFFfp9LQcoi+MHHOnZphBP7EGD65ooZA==
X-Google-Smtp-Source: ABdhPJypPIHq5yRg2dcIBU75XLw1mxBZXZCr0tGYsx5OZTQgsbxlAZywEshn9ybvwFRh0Ps48W3FfA==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr1488347wrn.247.1624470521430;
        Wed, 23 Jun 2021 10:48:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/25] progress.c: refactor display() for less confusion, and fix bug
Date:   Wed, 23 Jun 2021 19:48:17 +0200
Message-Id: <patch-17.25-8f2ba566aae-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As tested for in 2bb74b53a49 (Test the progress display, 2019-09-16)
we would redundantly emit extra spaces to clear output we never
emitted under the split mode. Now we'll always clear precisely as many
columns as we need, and no more.

The root cause of that issue is that since the progress code was
originally written we've grown support for various new features, and
ended up with a function where we didn't build the output we were
about to emit once, and then emitted it.

We thus couldn't easily track the length of the output we really did
emit, with everything going downhill from there.

The alternative approach is longer (largely due to added comments),
but I think much clearer.

We no longer rely on magic constants like "2" for ": " or "
" (although we do still rely on the two separators being the same
length, but now have a related BUG(...) assertion).

We don't update "status_len_utf8" (or rather, the now-gone
"last_count_len") or "progress->last_value" until after we've emitted
all the output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c                  | 137 +++++++++++++++++++++++++++---------
 t/t0500-progress-display.sh |   8 +--
 2 files changed, 104 insertions(+), 41 deletions(-)

diff --git a/progress.c b/progress.c
index e17490964c4..6c4038df791 100644
--- a/progress.c
+++ b/progress.c
@@ -25,17 +25,24 @@ static int is_foreground_fd(int fd)
 	return tpgrp < 0 || tpgrp == getpgid(0);
 }
 
+static const char *counter_prefix(int split)
+{
+	switch (split) {
+	case 1: return "  ";
+	case 0: return ": ";
+	default: BUG("unknown split value");
+	}
+}
+
 static void display(struct progress *progress, uint64_t n,
 		    const char *update_msg, int last_update)
 {
 	const char *tp;
 	int show_update = 0;
-	size_t last_count_len = progress->status_len_utf8;
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return;
 
-	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
@@ -44,61 +51,121 @@ static void display(struct progress *progress, uint64_t n,
 
 			strbuf_reset(&progress->status);
 			strbuf_addf(&progress->status,
-				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
+				    "%s%3u%% (%"PRIuMAX"/%"PRIuMAX")%s",
+				    counter_prefix(progress->split), percent,
 				    (uintmax_t)n, (uintmax_t)progress->total,
 				    tp);
 			show_update = 1;
 		}
 	} else if (progress_update) {
 		strbuf_reset(&progress->status);
-		strbuf_addf(&progress->status, "%"PRIuMAX"%s", (uintmax_t)n, tp);
+		strbuf_addf(&progress->status, "%s%"PRIuMAX"%s", counter_prefix(progress->split),
+			    (uintmax_t)n, tp);
 		show_update = 1;
 	}
 
 	if (show_update && update_msg)
-		strbuf_addf(&progress->status, ", %s.", update_msg);
+		strbuf_addstr(&progress->status, update_msg);
 
 	if (show_update) {
 		int stderr_is_foreground_fd = is_foreground_fd(fileno(stderr));
 		if (stderr_is_foreground_fd || update_msg) {
 			const char *eol = last_update ? "\n" : "\r";
-			size_t clear_len = progress->status.len < last_count_len ?
-					last_count_len - progress->status.len + 1 :
-					0;
-			/* The "+ 2" accounts for the ": ". */
-			size_t progress_line_len = progress->title_len_utf8 +
-						progress->status.len + 2;
-			int cols = term_columns();
-			progress->status_len_utf8 = utf8_strwidth(progress->status.buf);
-
-			if (progress->split) {
-				fprintf(stderr, "  %*s%*s",
-					(int)progress->status_len_utf8,
-					progress->status.buf,
-					(int)clear_len, eol);
-			} else if (!update_msg && cols < progress_line_len) {
-				clear_len = progress->title_len_utf8 + 1 < cols ?
-					    cols - progress->title_len_utf8 - 1 : 0;
-				fprintf(stderr, "%*s:%*s\n  %*s%s",
-					(int)progress->title_len_utf8,
-					progress->title.buf,
-					(int)clear_len, "",
-					(int)progress->status_len_utf8,
-					progress->status.buf, eol);
+			size_t status_len_utf8 = utf8_strwidth(progress->status.buf);
+			size_t progress_line_len = progress->title_len_utf8 + status_len_utf8;
+
+			/*
+			 * We're back at the beginning, so we'll
+			 * always print out the title, unless we're
+			 * already split, then the title is on an
+			 * earlier line.
+			 */
+			if (!progress->split)
+				fprintf(stderr, "%*s",
+					(int)(progress->title_len_utf8),
+					progress->title.buf);
+
+			/*
+			 * Did the user resize the terminal and we're
+			 * splitting this progress bar? Clear previous
+			 * ": (X/Y) [msg]"
+			 */
+			if (!progress->split &&
+			    term_columns() < progress_line_len) {
+				const char *split_prefix = counter_prefix(0);
+				const char *unsplit_prefix = counter_prefix(1);
+				const char *split_colon = ":";
 				progress->split = 1;
+
+				if (progress->last_value == -1) {
+					/*
+					 * We've got no previous
+					 * output whatsoever, so we
+					 * were "always split". No
+					 * previous status output to
+					 * erase.
+					 */
+					fprintf(stderr, "%s\n", split_colon);
+				} else {
+					const char *split_colon = ":";
+					const size_t split_colon_len = strlen(split_colon);
+
+					/*
+					 * Erase whatever we had, adding a
+					 * trailing ":" (not ": ") to indicate
+					 * the progress on the next line.
+					 */
+					fprintf(stderr, "%s%*s\n", split_colon,
+						(int)(progress->status_len_utf8 - split_colon_len),
+						"");
+				}
+
+				/*
+				 * For the one-off switching from
+				 * "!progress->split" to
+				 * "progress->split" fake up the
+				 * expected strbuf and replace the ":
+				 * " with a " ".
+				 *
+				 * The length of the two delimiters
+				 * must be the same for this trick to
+				 * work.
+				 */
+				if (!starts_with(progress->status.buf, split_prefix))
+					BUG("switching from already true split mode to split mode?");
+
+				strbuf_splice(&progress->status, 0,
+					      strlen(split_prefix),
+					      unsplit_prefix,
+					      strlen(unsplit_prefix));
+
+				fprintf(stderr, "%*s%s", (int)status_len_utf8,
+					progress->status.buf, eol);
 			} else {
-				fprintf(stderr, "%*s: %*s%*s",
-					(int)progress->title_len_utf8,
-					progress->title.buf,
-					(int)progress->status_len_utf8,
-					progress->status.buf,
-					(int)clear_len, eol);
+				/*
+				 * Our current
+				 * message may be larger or smaller than the
+				 * last one. Either the progress bar went
+				 * backards (smaller numbers), or we went back
+				 * and forth with a status message.
+				 */
+				size_t clear_len = progress->status_len_utf8 > status_len_utf8
+					? progress->status_len_utf8 - status_len_utf8
+					: 0;
+				fprintf(stderr, "%*s%*s%s",
+					(int) status_len_utf8, progress->status.buf,
+					(int) clear_len, "",
+					eol);
 			}
+			progress->status_len_utf8 = status_len_utf8;
+
 			if (stderr_is_foreground_fd)
 				fflush(stderr);
 		}
 		progress_update = 0;
 	}
+	progress->last_value = n;
+
 }
 
 static void throughput_string(struct strbuf *buf, uint64_t total,
@@ -303,7 +370,7 @@ void stop_progress(struct progress **p_progress)
 		trace2_region_leave("progress", progress->title.buf, the_repository);
 	}
 
-	stop_progress_msg(p_progress, _("done"));
+	stop_progress_msg(p_progress, _(", done."));
 }
 
 void stop_progress_msg(struct progress **p_progress, const char *msg)
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 476a31222a3..883e044fe64 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -85,12 +85,10 @@ EOF
 '
 
 test_expect_success 'progress display breaks long lines #2' '
-	# Note: we do not need that many spaces after the title to cover up
-	# the last line before breaking the progress line.
 	sed -e "s/Z$//" >expect <<\EOF &&
 Working hard.......2.........3.........4.........5.........6:   0% (1/100000)<CR>
 Working hard.......2.........3.........4.........5.........6:   0% (2/100000)<CR>
-Working hard.......2.........3.........4.........5.........6:                   Z
+Working hard.......2.........3.........4.........5.........6:                Z
    10% (10000/100000)<CR>
   100% (100000/100000)<CR>
   100% (100000/100000), done.
@@ -112,10 +110,8 @@ EOF
 '
 
 test_expect_success 'progress display breaks long lines #3 - even the first is too long' '
-	# Note: we do not actually need any spaces at the end of the title
-	# line, because there is no previous progress line to cover up.
 	sed -e "s/Z$//" >expect <<\EOF &&
-Working hard.......2.........3.........4.........5.........6:                   Z
+Working hard.......2.........3.........4.........5.........6:
    25% (25000/100000)<CR>
    50% (50000/100000)<CR>
    75% (75000/100000)<CR>
-- 
2.32.0.599.g3967b4fa4ac

