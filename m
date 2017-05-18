Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD5DF201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932125AbdERTiu (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:50 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36734 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757676AbdERTiF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:05 -0400
Received: by mail-pg0-f45.google.com with SMTP id x64so27262522pgd.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DUmtSBfQjYYEbs580pwMpvoMQloirfoICyAluAabTsY=;
        b=lyw+7lv85H/hbJIbbmENLpauIOd37BjxN6bFRvfGd0mjO0D4ScqzOzRKn5H4Osoqy3
         eJXaSyrPIBMi//bcx8Lmi8oX5qE1D7DM4phfWSaWmpe/eVIeO2n/5KfOdchSbsxNZDQ1
         6wgFCwDzZcV2GgVX8qJhGai6RKnTtBwcacB+fRIVS35ARK/m1jLInN0We14RDdi6tC4r
         oMwOYC6vtiTGXxu+l5BPFStIeOGo25LnUiu90V05LyhgoK4FqEiL2UmZJjwK6sLsuY1j
         ex9oXuZY9ayOlMTAkIwkc8oxzhB1BuVPcCDpajTuWqwZ51r0CoJf/TY8ZC5bQ3VnMn/X
         +8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DUmtSBfQjYYEbs580pwMpvoMQloirfoICyAluAabTsY=;
        b=L8vB9z54JhfW9GlS0UuYA70JXZ3AmCO3/Of2OcSxbfZ3oX5rznl1ACzgzymSn46zEJ
         BJ+npzdmqikCbaNx+f0elp3ubocEYCFQAR/QrGgROuCBwj7Ob4QFeYhp5fRZwCXbQvTt
         8lnpHnhLkC1QeFTkwQU7lx4zNPbq9DPrFrY4VlIocHu7/ebpCUebV3frdBmWK4Kki+EG
         8R3pqkQCpQ+0Wu8L7olVO+yWDK81wl0WPUT8lYoWTDQIUL+dGMgLKL2mKQkNmSCdTNto
         A3c3RmHqFJxb937KRxQxNyhYplVIgiznzumM2HZ9KMGxRyFu5ZebuVyEnRhTZB9lCK+g
         JFlA==
X-Gm-Message-State: AODbwcB45+CnJth2cudf1fzHVnvbr8WTiF2SqaVhdg+mc/DrjJ+hRjO+
        svcIyc5ibA9rHRq1
X-Received: by 10.99.24.65 with SMTP id 1mr6323444pgy.49.1495136284158;
        Thu, 18 May 2017 12:38:04 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id o20sm10487377pfa.96.2017.05.18.12.38.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:38:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 08/20] diff.c: convert fn_out_consume to use emit_line
Date:   Thu, 18 May 2017 12:37:34 -0700
Message-Id: <20170518193746.486-9-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line.

This covers the parts of fn_out_consume.  In the next
patches we'll convert more functions that want to emit
formatted output, so we'd want to have a formatted emit
function. Add it here.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 3569857818..8186289734 100644
--- a/diff.c
+++ b/diff.c
@@ -547,6 +547,21 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 		fputc('\n', file);
 }
 
+static void emit_line_fmt(struct diff_options *o,
+			  const char *set, const char *reset,
+			  int add_line_prefix,
+			  const char *fmt, ...)
+{
+	struct strbuf sb = STRBUF_INIT;
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	va_end(ap);
+
+	emit_line(o, set, reset, add_line_prefix, 0, sb.buf, sb.len);
+	strbuf_release(&sb);
+}
+
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
@@ -1270,7 +1285,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
-	const char *line_prefix = diff_line_prefix(o);
 
 	o->found_changes = 1;
 
@@ -1282,14 +1296,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
 	if (ecbdata->label_path[0]) {
 		const char *name_a_tab, *name_b_tab;
-
 		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
-
-		fprintf(o->file, "%s%s--- %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
-		fprintf(o->file, "%s%s+++ %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
+		emit_line_fmt(o, meta, reset, 1, "--- %s%s\n",
+			      ecbdata->label_path[0], name_a_tab);
+		emit_line_fmt(o, meta, reset, 1, "+++ %s%s\n",
+			      ecbdata->label_path[1], name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
@@ -1330,7 +1342,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
 			emit_line(o, context, reset, 1, 0, line, len);
-			fputs("~\n", o->file);
+			emit_line(o, NULL, NULL, 0, 0, "~\n", 2);
 		} else {
 			/*
 			 * Skip the prefix character, if any.  With
-- 
2.13.0.18.g7d86cc8ba0

