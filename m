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
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D7B1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbfFXSNc (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:13:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33756 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbfFXSNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:13:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so528650wme.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jjjOIKj+RGusBRxxlzthlITZIX/tPrLiawA3qHT6WM=;
        b=AUP1+lv4XHahxvZUprSEmH3Hp78626wYErVxySjaUwRy5gaGlCkfZuPc72/EoyAK0J
         qi6XO/8FAIsomtW2qQPXRNgVNEUX492crDXjqLRlw9B+pNU0gA8ednstqxDMqi2zJvXu
         aSiq7OCjHoziwPF2hpHrmkEKRFm39krw1oVovp6w1/XDaj0Aiu9sD6g+rbJ65uU5/yl4
         91DaJvNA/3Lc4zjGMLWevingTrAiZQQdq26dwcM9HO43sA7D+J2IchjaVNp/MYs7IKiF
         D8pJjoDxB6UbKRaVFjB48I+CKbB+Aav+Vl1xpI3WbmmmH8XPghtwo0fQg6jas2DdZxlL
         2qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jjjOIKj+RGusBRxxlzthlITZIX/tPrLiawA3qHT6WM=;
        b=tZP/evva57fsOotC4CsKHwny9uD+KQYJIY4OmnOURsbUhs6tM+2UpQ3L+a+BrBUeUk
         ryY8RRGi9xbZ5gmKkCsBl+yRW2Y6gr42DrBMryTpKrHKOhNSpvTNwjZjIJ8SX5WLek/E
         q49PNcO0JOXNTxI5/SNSw6DDrmlwAS5ZdzPrX4C2ms45TFlu2yjOygt0sJaddnK53zlI
         L5+ihjEmNPAGeD43tv32RV3lDacLJeuVJwMs5CncPNF9h1Artbk4RSGhj0c57woyARHN
         CSEJY8a5qHYMavRw14RiglVAhh8wwL39+ZmgD2Pw4auZe97a7ImuTmsQ+wLYX9XP6Nck
         LeCQ==
X-Gm-Message-State: APjAAAV83VQ61ny7qtm532H512LYPgzpmps3TpMFN0J5+OJNCE+T4i0t
        UTkRBqtRcrJGQhuYmb0v3IQ=
X-Google-Smtp-Source: APXvYqzh4LVJZG7cO1opvx2aZcoWvNZIXoCnB4/RawJhyn2EAZxaInvMTdtIOWsUx/YwehIcHH0bdg==
X-Received: by 2002:a1c:618a:: with SMTP id v132mr16640776wmb.17.1561400008375;
        Mon, 24 Jun 2019 11:13:28 -0700 (PDT)
Received: from localhost.localdomain (x4db9a89d.dyn.telefonica.de. [77.185.168.157])
        by smtp.gmail.com with ESMTPSA id v65sm401349wme.31.2019.06.24.11.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 11:13:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 3/5] pager: add a helper function to clear the last line in the terminal
Date:   Mon, 24 Jun 2019 20:13:16 +0200
Message-Id: <20190624181318.17388-4-szeder.dev@gmail.com>
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

There are a couple of places where we want to clear the last line on
the terminal, e.g. when a progress bar line is overwritten by a
shorter line, then the end of that progress line would remain visible,
unless we cover it up.

In 'progress.c' we did this by always appending a fixed number of
space characters to the next line (even if it was not shorter than the
previous), but as it turned out that fixed number was not quite large
enough, see the fix in 9f1fd84e15 (progress: clear previous progress
update dynamically, 2019-04-12).  From then on we've been keeping
track of the length of the last displayed progress line and appending
the appropriate number of space characters to the next line, if
necessary, but, alas, this approach turned out to be error prone, see
the fix in 1aed1a5f25 (progress: avoid empty line when breaking the
progress line, 2019-05-19).  The next patch in this series is about to
fix a case where we don't clear the last line, and on occasion do end
up with such garbage at the end of the line.  It would be great if we
could do that without the need to deal with that without meticulously
computing the necessary number of space characters.

So add a helper function to clear the last line on the terminal using
an ANSI escape sequence, which has the advantage to clear the whole
line no matter how wide it is, even after the terminal width changed.
Such an escape sequence is not available on dumb terminals, though, so
in that case fall back to simply print a whole terminal width (as
reported by term_columns()) worth of space characters.

In 'editor.c' launch_specified_editor() already used this ANSI escape
sequence, so replace it with a call to this function.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 cache.h  |  1 +
 editor.c |  6 +++---
 pager.c  | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index b4bb2e2c11..5b2cd32bad 100644
--- a/cache.h
+++ b/cache.h
@@ -1759,6 +1759,7 @@ void setup_pager(void);
 int pager_in_use(void);
 extern int pager_use_color;
 int term_columns(void);
+void term_clear_line(void);
 int decimal_width(uintmax_t);
 int check_pager_config(const char *cmd);
 void prepare_pager_args(struct child_process *, const char *pager);
diff --git a/editor.c b/editor.c
index 71547674ab..f079abbf11 100644
--- a/editor.c
+++ b/editor.c
@@ -96,10 +96,10 @@ static int launch_specified_editor(const char *editor, const char *path,
 
 		if (print_waiting_for_editor && !is_terminal_dumb())
 			/*
-			 * Go back to the beginning and erase the entire line to
-			 * avoid wasting the vertical space.
+			 * Erase the entire line to avoid wasting the
+			 * vertical space.
 			 */
-			fputs("\r\033[K", stderr);
+			term_clear_line();
 	}
 
 	if (!buffer)
diff --git a/pager.c b/pager.c
index 4168460ae9..41446d4f05 100644
--- a/pager.c
+++ b/pager.c
@@ -177,6 +177,26 @@ int term_columns(void)
 	return term_columns_at_startup;
 }
 
+/*
+ * Clear the entire line, leave cursor in first column.
+ */
+void term_clear_line(void)
+{
+	if (is_terminal_dumb())
+		/*
+		 * Fall back to print a terminal width worth of space
+		 * characters (hoping that the terminal is still as wide
+		 * as it was upon the first call to term_columns()).
+		 */
+		fprintf(stderr, "\r%*s\r", term_columns(), "");
+	else
+		/*
+		 * On non-dumb terminals use an escape sequence to clear
+		 * the whole line, no matter how wide the terminal.
+		 */
+		fputs("\r\033[K", stderr);
+}
+
 /*
  * How many columns do we need to show this number in decimal?
  */
-- 
2.22.0.589.g5bd7971b91

