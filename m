Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6678F1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 01:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeHNE0e (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 00:26:34 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:34672 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeHNE0e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 00:26:34 -0400
Received: by mail-ua1-f74.google.com with SMTP id n10-v6so8838407uao.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 18:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ya6fdQY6Dj3PD1zuqMR+4Vb67WE5CwWQv2pzjGFg9Qo=;
        b=pQeHdhRnw0rAbfAx/96/n57FpOgp/ZKo0fLqN93aCcht2AndYHBse8jt/CHuQh5Grv
         AzgvR2iqSKl219GPDn0J9O8qKoHldMjo9y4BkiBD1IbSCBzhnk6jfh5DSFzYUmvU9Fk2
         UIYfSwrPOnwHugXgS5C7AEH9ExhXgfSW8Z6osYL/T5Zm/hlzFddYGjZ30/HTqmN2cds4
         JaqyQvrYavSjIFyQtJRzYSvjX4THh0XasFgwPbmQ7lNlCL8rfVeAHZRViAasmkpAsCb+
         c895nOOTww1VhV2GyomUyEaJoDryd0gLVOJVi3fX98t7ogoFsVO8zg1cw7XWaR28gVE5
         NsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ya6fdQY6Dj3PD1zuqMR+4Vb67WE5CwWQv2pzjGFg9Qo=;
        b=BPI4k0rrhozXRixWZ5qjMZvjmlxokBiXx7Bs0oO6Afhb68qh1noy3cwba9PpyalRcv
         F1XD8zaxxyBFxisdqyquX/gGcDcT1JX2VqaOrA0Xm9U1hsbQocojTFn+fJesU7A6Tvzi
         a6rYjpGweB1BrRdNIrZxraMwRI2JjwneC4x2X7Yl+M2OdZLtznPzLl7Cdx+R7w/WBeOm
         g70NExAFKvDbcs00z8aEWZzAKXoHPcajq8NZqXAsr/RmJfpHIiQe/5guNCcVdTus0f2S
         NYviRv2sZ4MyrkoWEwujeAM40yTNGQNeyhwSSUsa95B2u/d/oIBvq8chC2bjvMoWR15x
         6EHw==
X-Gm-Message-State: AOUpUlHPkfA09W3hczXhVq0WCAgijQCxGl3OJFKWqcJCxiaRADz4xSTp
        I+5UB7v+SgqRE5St9ARHCVZVZgVvVtjb
X-Google-Smtp-Source: AA+uWPywE7UpV/ZDP2HW3nMktXJ7KdW9gFbyoh/a+KSUfBEpO4kFKYKPK/aaDnd5bVexoYfBg1afqYrD+Tw6
X-Received: by 2002:a9f:3aca:: with SMTP id q10-v6mr9192150uag.31.1534210902907;
 Mon, 13 Aug 2018 18:41:42 -0700 (PDT)
Date:   Mon, 13 Aug 2018 18:41:19 -0700
In-Reply-To: <20180814014122.30662-1-sbeller@google.com>
Message-Id: <20180814014122.30662-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180814014122.30662-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 5/8] diff.c: add set_sign to emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split the meaning of the `set` parameter that is passed to
emit_line_0()` to separate between the color of the "sign" (i.e.
the diff marker '+', '-' or ' ' that is passed in as the `first`
parameter) and the color of the rest of the line.

This changes the meaning of the `set` parameter to no longer refer
to the color of the diff marker, but instead to refer to the color
of the rest of the line. A value of `NULL` indicates that the rest
of the line wants to be colored the same as the diff marker.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index ab6e6a88a56..4ef66389282 100644
--- a/diff.c
+++ b/diff.c
@@ -622,7 +622,7 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 }
 
 static void emit_line_0(struct diff_options *o,
-			const char *set, unsigned reverse, const char *reset,
+			const char *set_sign, const char *set, unsigned reverse, const char *reset,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
@@ -652,9 +652,15 @@ static void emit_line_0(struct diff_options *o,
 	if (len || !nofirst) {
 		if (reverse && want_color(o->use_color))
 			fputs(GIT_COLOR_REVERSE, file);
-		fputs(set, file);
+		if (set_sign)
+			fputs(set_sign, file);
 		if (first && !nofirst)
 			fputc(first, file);
+		if (set && set != set_sign) {
+			if (set_sign)
+				fputs(reset, file);
+			fputs(set, file);
+		}
 		fwrite(line, len, 1, file);
 		fputs(reset, file);
 	}
@@ -667,7 +673,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, 0, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, 0, reset, line[0], line+1, len-1);
 }
 
 enum diff_symbol {
@@ -1199,17 +1205,17 @@ static void emit_line_ws_markup(struct diff_options *o,
 	}
 
 	if (!ws && !set_sign)
-		emit_line_0(o, set, 0, reset, sign, line, len);
+		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
 	else if (!ws) {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign, !!set_sign, reset, sign, "", 0);
-		emit_line_0(o, set, 0, reset, 0, line, len);
+		emit_line_0(o, set_sign, NULL, !!set_sign, reset, sign, "", 0);
+		emit_line_0(o, set, NULL, 0, reset, 0, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(o, ws, 0, reset, sign, line, len);
+		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
+		emit_line_0(o, set_sign ? set_sign : set, NULL, !!set_sign, reset,
 			    sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
@@ -1233,7 +1239,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, 0, reset, '\\',
+		emit_line_0(o, context, NULL, 0, reset, '\\',
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
-- 
2.18.0.865.gffc8e1a3cd6-goog

