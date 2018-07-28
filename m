Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C876B1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 03:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeG1E35 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 00:29:57 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:43528 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeG1E35 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 00:29:57 -0400
Received: by mail-qt0-f201.google.com with SMTP id d25-v6so5568668qtp.10
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 20:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3xFbpBpIhRuXRpadMxptsaLkrXYwMvLwpbk9fRIToQc=;
        b=RlVRT5kZUK4kEUWF6kXxZ5o+22wFwtizQuZ29c7n/4Fv+HqcdbaUVPF4a8Zs2pJKaq
         82VOw3bIj8ezebXxaCltAiRRLeSzTBLqyRjp9cJLLJbsb/n8yllkAzdJubJ6EE6mvokQ
         dhaw5pRJpEqkjwOqXPs14+AaCeBVBh+DCBnf8td7+E9uFg7pOSkbKI/A0w5I58lAU8dz
         XESKDJscFAROg47RApWTk5KqYp/z0L0hLzEbJbHaCG9sVS840DyRDzrKs9HP7HljqIq/
         mvWfuZKH4rb2W3BSewqmiaFfxSKpoVLD3fsGGrSlQGyZPzFpWerfeBMGNVOlAoXtmm27
         MhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3xFbpBpIhRuXRpadMxptsaLkrXYwMvLwpbk9fRIToQc=;
        b=jSmuauW5tZlQNNYnwhY8LCMyFxXLlV28E2mf866wV/5l+69jQgn5PZKJV2W941yDfu
         lFTzBR7TIiaAXInPqUymGaVgnYgMfupadVGGo0PLEs+WaoUggXgrscxgU04pRn3J7Uyz
         ykcrM8hZOK8EL/6Lc3DQuz6p9IHpU9Z5sGMyGxO8cTMtRU72vbc0MLZrCpKMvQ+SyL+p
         omA2UKWRXHY7C5ErnQbpPC2ZWH1NuFzxLOGps0tWlL4toQKaakFq8SOBkZnFESa22PaA
         wddXnuWbLViuV6eM/iYNnKZ6BB5dRLBZBnffJ8obhlZo96BtMxkqYpXOHZ6ihOtK0A/x
         CBiA==
X-Gm-Message-State: AOUpUlGsiP7d/KQbjiGJmetk4+rBOPBTJYBF2HRoNsYhQOO3Ey7RaGVI
        d+cIMGeN+FmrKYNT0Ci6kmVBJgPnwJxoWd98ha6bjXmG7ipVYLjzy367OcOGhL3ruzCwfKPlCJQ
        HGmthYXLalXZCt2pNbcrNXHVp4f4O1xubE52/sH1FyuZns8a51GYsQ6A8GYcw
X-Google-Smtp-Source: AAOMgpfA5cLMGUJhfEGBfzDz2hNJN3kEeMcoxCzB3jvgkydTZuiCl8l49gqYEh/viPWgo7qrCBp3Sgz8uHZ9
X-Received: by 2002:a0c:e789:: with SMTP id x9-v6mr4727477qvn.12.1532747111594;
 Fri, 27 Jul 2018 20:05:11 -0700 (PDT)
Date:   Fri, 27 Jul 2018 20:04:48 -0700
In-Reply-To: <20180728030448.192177-1-sbeller@google.com>
Message-Id: <20180728030448.192177-9-sbeller@google.com>
Mime-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 8/8] diff.c: rewrite emit_line_0 more understandably
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

emit_line_0 has no nested conditions, but puts out all its arguments
(if set) in order. There is still a slight confusion with set
and set_sign, but let's defer that to a later patch.

'first' used be output always no matter if it was 0, but that got lost
got lost at e8c285c4f9c (diff: add an internal option to dual-color
diffs of diffs, 2018-07-21), as there we broadened the meaning of 'first'
to also signal an early return.

The change in 'emit_line' makes sure that 'first' is never content, but
always under our control, a sign or special character in the beginning
of the line (or 0, in which case we ignore it).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 73 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/diff.c b/diff.c
index f565a2c0c2b..2bd4d3d6839 100644
--- a/diff.c
+++ b/diff.c
@@ -580,43 +580,52 @@ static void emit_line_0(struct diff_options *o,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
-	int nofirst;
 	int reverse = !!set && !!set_sign;
+	int needs_reset = 0;
+
 	FILE *file = o->file;
 
 	fputs(diff_line_prefix(o), file);
 
-	if (len == 0) {
-		has_trailing_newline = (first == '\n');
-		has_trailing_carriage_return = (!has_trailing_newline &&
-						(first == '\r'));
-		nofirst = has_trailing_newline || has_trailing_carriage_return;
-	} else {
-		has_trailing_newline = (len > 0 && line[len-1] == '\n');
-		if (has_trailing_newline)
-			len--;
-		has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
-		if (has_trailing_carriage_return)
-			len--;
-		nofirst = 0;
-	}
-
-	if (len || !nofirst) {
-		if (reverse && want_color(o->use_color))
-			fputs(GIT_COLOR_REVERSE, file);
-		if (set_sign || set)
-			fputs(set_sign ? set_sign : set, file);
-		if (first && !nofirst)
-			fputc(first, file);
-		if (len) {
-			if (set_sign && set && set != set_sign)
-				fputs(reset, file);
-			if (set)
-				fputs(set, file);
-			fwrite(line, len, 1, file);
-		}
-		fputs(reset, file);
+	has_trailing_newline = (len > 0 && line[len-1] == '\n');
+	if (has_trailing_newline)
+		len--;
+
+	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
+	if (has_trailing_carriage_return)
+		len--;
+
+	if (!len && !first)
+		goto end_of_line;
+
+	if (reverse && want_color(o->use_color)) {
+		fputs(GIT_COLOR_REVERSE, file);
+		needs_reset = 1;
+	}
+
+	if (set_sign || set) {
+		fputs(set_sign ? set_sign : set, file);
+		needs_reset = 1;
 	}
+
+	if (first)
+		fputc(first, file);
+
+	if (!len)
+		goto end_of_line;
+
+	if (set) {
+		if (set_sign && set != set_sign)
+			fputs(reset, file);
+		fputs(set, file);
+		needs_reset = 1;
+	}
+	fwrite(line, len, 1, file);
+	needs_reset |= len > 0;
+
+end_of_line:
+	if (needs_reset)
+		fputs(reset, file);
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
 	if (has_trailing_newline)
@@ -626,7 +635,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, NULL, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, reset, 0, line, len);
 }
 
 enum diff_symbol {
-- 
2.18.0.345.g5c9ce644c3-goog

