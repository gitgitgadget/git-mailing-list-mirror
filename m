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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88664C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C3E611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhFWRvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFWRvH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:07 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE9EC0613A4
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d11so3638989wrm.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0xQ7vsbZI8wWiuX12McJfMF/3x1ijyNCAkdjzFUG0A=;
        b=WIb1E0KFC8WDqD2Zb4w/zOrLjAI92YA3Qgq0Rs2z0q2J1QuQ76im2QkDYhRrWFMzRU
         lGnB5XeSxWStBtYnbuxPWet0eb8iMH66QWEg/jPkWr7qxCwXBmQsYtQKBPWvsAAnjzvp
         LSZwnQoYAgenktLdkW9w9fCYmVo/BIW9RB4JhuSl5jfHluTtFIA0uA7vYIWL3QATF5kz
         /71faN4dipPdvGQN+4yOzLHIUkyR2eDSlZR6bVw1j6gEHBqcspkBwMwTKtp+yuFAoZfN
         XjsZPJHDqXf1Pw0kcZ173XZAZdL607hYvz1lMef2h66kkmOJSChL4bPxRu04vrfwBt+y
         a9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0xQ7vsbZI8wWiuX12McJfMF/3x1ijyNCAkdjzFUG0A=;
        b=N2Lp+UrStVGUqiJ2qs8UxxC9VVKIRM9iULPbWqo7NWOY9tLXyW0saPA3XfCSakeAjC
         1CiYXDCNk9+QRVBg/w0Pxj1oQKvzPBWngchxxk4qRJkiMzw4EnGfQAfEjadwnuEPPxeX
         +dCckHwogi5uEh4rRST0wYniE06fklkOFAdALbVzD5jwwHZOxeweCQxEpkYEwpEECBuU
         Ffh7hG5WjxEZa3aMPIkF0su8xOGfHBmtnvdcuVdCZzGaX40Pwr8HuXJVSknZsZbRJFfg
         5/6bf26oDoxM1omi2/2P0RKIpCcO/+dldxjvcIgVPsdxeyEeaGvcMP0nGMeu9A6zm7hF
         24BQ==
X-Gm-Message-State: AOAM533QytMqOc7662g8txl0w0aeGlqmnL/jwtZZOR06rgwIMfXYXHhm
        FJEvrJakuuTUbF1Bmlr4kb6qPEjVDqRrOw==
X-Google-Smtp-Source: ABdhPJxC+u+C+p7ivNvJDeGztEM5cpXlMJgCbSq5cOQ0AXhxOElkJ9IWLKjaiD1ngIS6AIrwgCr4og==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr1414096wrp.407.1624470519974;
        Wed, 23 Jun 2021 10:48:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/25] progress.c: pass "is done?" (again) to display()
Date:   Wed, 23 Jun 2021 19:48:15 +0200
Message-Id: <patch-15.25-160c5fe04c3-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Go back to passing a "are we done?" state variable to the display()
function, instead of passing a string that happens to end in a newline
for the ", done\n" special-case in stop_progress().

This doesn't matter now, but is needed to display an arbitrary message
earlier in the progress display, not just at the very end.

In a984a06a07c (nicer display of thin pack completion, 2007-11-08)
this code worked like this, but later on in 42e18fbf5f9 (more compact
progress display, 2007-10-16) we ended up with the "const
char *done". Then in d53ba841d4f (progress: assemble percentage and
counters in a strbuf before printing, 2019-04-05) we ended up with the
current code structure around the "counters_sb" strbuf.

The "counters_sb" is needed because when we emit a line like:

    Title (1/10)<CR>

We need to know how many characters the " (1/10)" variable part is, so
that we'll emit the appropriate number of spaces to "clear" the line.

If we want to emit output like:

    Title (1/10), some message<CR>

We'll need to stick the whole " (1/10), some message" part into the
strbuf, so that if we want to clear the message we'll know to emit:

    Title (1/10), some message<CR>
    Title (2/10)              <CR>

This didn't matter for the ", done\n" case because we were ending the
process anyway, but in preparation for the above let's star treating
it like any other line, and pass an "int last_update" to decide
whether the line ends with a "\r" or a "\n".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/progress.c b/progress.c
index 39d7f6bd86b..44479f65921 100644
--- a/progress.c
+++ b/progress.c
@@ -25,7 +25,8 @@ static int is_foreground_fd(int fd)
 	return tpgrp < 0 || tpgrp == getpgid(0);
 }
 
-static void display(struct progress *progress, uint64_t n, const char *done)
+static void display(struct progress *progress, uint64_t n,
+		    const char *update_msg, int last_update)
 {
 	const char *tp;
 	struct strbuf *counters_sb = &progress->counters_sb;
@@ -55,10 +56,13 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 		show_update = 1;
 	}
 
+	if (show_update && update_msg)
+		strbuf_addf(counters_sb, ", %s.", update_msg);
+
 	if (show_update) {
 		int stderr_is_foreground_fd = is_foreground_fd(fileno(stderr));
-		if (stderr_is_foreground_fd || done) {
-			const char *eol = done ? done : "\r";
+		if (stderr_is_foreground_fd || update_msg) {
+			const char *eol = last_update ? "\n" : "\r";
 			size_t clear_len = counters_sb->len < last_count_len ?
 					last_count_len - counters_sb->len + 1 :
 					0;
@@ -70,7 +74,7 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 			if (progress->split) {
 				fprintf(stderr, "  %s%*s", counters_sb->buf,
 					(int) clear_len, eol);
-			} else if (!done && cols < progress_line_len) {
+			} else if (!update_msg && cols < progress_line_len) {
 				clear_len = progress->title_len + 1 < cols ?
 					    cols - progress->title_len - 1 : 0;
 				fprintf(stderr, "%s:%*s\n  %s%s",
@@ -163,13 +167,13 @@ void display_throughput(struct progress *progress, uint64_t total)
 
 	throughput_string(&tp->display, total, rate);
 	if (progress->last_value != -1 && progress_update)
-		display(progress, progress->last_value, NULL);
+		display(progress, progress->last_value, NULL, 0);
 }
 
 void display_progress(struct progress *progress, uint64_t n)
 {
 	if (progress)
-		display(progress, n, NULL);
+		display(progress, n, NULL, 0);
 }
 
 static void progress_interval(int signum)
@@ -303,7 +307,6 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	*p_progress = NULL;
 	if (progress->last_value != -1) {
 		/* Force the last update */
-		char *buf;
 		struct throughput *tp = progress->throughput;
 
 		if (tp) {
@@ -314,9 +317,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 			throughput_string(&tp->display, tp->curr_total, rate);
 		}
 		progress_update = 1;
-		buf = xstrfmt(", %s.\n", msg);
-		display(progress, progress->last_value, buf);
-		free(buf);
+		display(progress, progress->last_value, msg, 1);
 	}
 	clear_progress_signal(progress);
 	strbuf_release(&progress->counters_sb);
-- 
2.32.0.599.g3967b4fa4ac

