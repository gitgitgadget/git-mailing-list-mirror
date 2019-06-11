Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D87F1F609
	for <e@80x24.org>; Tue, 11 Jun 2019 13:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389923AbfFKNDl (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 09:03:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35741 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbfFKNDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 09:03:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so12973066wrv.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RCKQTT5cEAI2wSKTeHzmbou5LKFz0NApOae24X92gk=;
        b=AaXhfIUUBmtY0MLF0Jsq5Lgn1KIYPaCjLkmWV3NRjfYuDEaWu6DBJXsBZoEpTEVu+J
         wJuz3aN4RwaQVWzNiayCubcyNlyKcTF/SwFEVkK307xkbuZCULQvduU4ZE+/RffKvp7r
         tZhh2gaLdKbPt/O63wbcfICSEn0pnVhI68x6fB6b6HmM1+LGez0EFWX2yTzC5vnK1PJ2
         13QBhcK/IPb9UQAS/9bewNuOngMtvDfRBgDngGN4f4oC2n9ruMGOaL45Sq8N8FyqwGpX
         Imyn3ZlMgbNaPJJ06fmQdJaqyKdYU9tcTk0gBKqRSHpbUnfVCNzPlwELYnSr5aJe1C2p
         UVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RCKQTT5cEAI2wSKTeHzmbou5LKFz0NApOae24X92gk=;
        b=clCs7rX2mZkQHQgRiBb06edJXfQKDtJ4rGmSmJNYXOu3Qm65b/37YqmdA3SQFm3GFJ
         WEfMk43YG3eDJn/8E1O6mRl5baEQ+ojZ2swxRcPONl6p/VrmDS6KkETkCXmnGJVO01px
         HKsfdHNTiEJ2P4ozO1HuG4r/Fir4pTN75drodfrg/3MtyO5u8D7DhkZHPy5UkgMveZPQ
         XhlOO6bq0n8ZnJT5O3UmEAdkJUhMFWNRZZJ8ZF3R0Dml/i/kOdlCLvihZ4bqOZEDFDcx
         LmF7ofPrYYWsnm64+cvJcWarDl54Lrh5gim5xVQn8vjjSMSV42OekSaL22Zl4CS/6hFJ
         dKkg==
X-Gm-Message-State: APjAAAXTBELGovO8Z3PYa1bUpvCJHIWdRhR2wEzkGV19tUjjWnP/knmb
        mNpWBRW2jDsyIpdpZeiDv1A=
X-Google-Smtp-Source: APXvYqxhJq6Subup+968Q0MQMvLw6cjaQjeS1a78ARkNgMYeFQuNUw4XAfFzLLXi693E0Sh8cmT4DQ==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr5214470wro.36.1560258218908;
        Tue, 11 Jun 2019 06:03:38 -0700 (PDT)
Received: from localhost.localdomain (x4d0cbedf.dyn.telefonica.de. [77.12.190.223])
        by smtp.gmail.com with ESMTPSA id l190sm2561524wml.16.2019.06.11.06.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 06:03:38 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/4] pager: add a helper function to clear the last line in the terminal
Date:   Tue, 11 Jun 2019 15:03:18 +0200
Message-Id: <20190611130320.18499-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.566.g58873a45ff
In-Reply-To: <20190611130320.18499-1-szeder.dev@gmail.com>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
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
2.22.0.566.g58873a45ff

