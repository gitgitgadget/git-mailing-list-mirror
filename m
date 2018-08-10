Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8B21F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeHKBGz (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:06:55 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:34805 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKBGy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:06:54 -0400
Received: by mail-oi0-f74.google.com with SMTP id 13-v6so10716712oiq.1
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JXSw4mTcyxitvv2jhmr9b9NWceQXpsHpMSIhAWleG2s=;
        b=e55HLEi+rgDSY5MIC4CAwxPejypm3pCsEkv7sUSJHB4ZtHAbt9nxQclzgWZAymCjUF
         zLTO13qkm5qDwFUPseNPGpu6s/SdXGn5eyUfCana7HhXDEXcNeaL8OzJoXiXkwCLQ+25
         pv/fPGxa7w/ZK8ucP8wVYnyn0q1D8rY2na3GPJWoApb6QtB93scM6aKnKcSsQzVyaOTL
         22Y0YR0atjRCUeAp/7nrTnn5HriEnn+l/no7DEG/8pp5hnkTCKbwscUq37kQleBKe/gl
         OiBVH+uAgblnGnBKr1jsq0HzPXL7NcM8DwtDW0BFomwLu6uCzg0M+qkkNPfQjJ/5KUxr
         XmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JXSw4mTcyxitvv2jhmr9b9NWceQXpsHpMSIhAWleG2s=;
        b=KeDdDkpggH2E73WdZUZzzzQpkvl6g1IEUXy36z0FwbcqLPfeAjrNdMtVjmu5hMaRSa
         IDSNKR6GhVh30bcQZ1W+qrmbbN57qtG0ug8TwOOGG3oXc3y2xHJP2+TuSiUoq2wEOrme
         99XN0E2pNxjVG6aIlDnwfM+INhxA1m48dgWAW1Ld3CSVxTPRskc+ysk4Q20lEFa9ejbR
         /A2GAsThsSFYuBSyF7FqlVDCgmaV6VyBnld2CZhDelAY9xkMiRZjmY6kZdL138JQ7mnT
         nJuER4ojD1LikfKzU+uY3ItJK7QV8VIYe1ln6YvUZsQ37yU9IRL2o2hUCHrLt6Nv0yIx
         G2QQ==
X-Gm-Message-State: AOUpUlHclkhCm+kLpBka+1m8UMd741yeQvCImFBZQEb+shYS+A4Jyrle
        P37Dw54fSvjBP09FumCNdrzNQd9j9OdM
X-Google-Smtp-Source: AA+uWPwOAMMfMIdMK4bU3YWhC9G+QifHsELemJakNYjWT17+aQ64RH3xxT8VHW83D+7zsJ3D420ytjwrR9J3
X-Received: by 2002:aca:5a89:: with SMTP id o131-v6mr4700091oib.65.1533940504979;
 Fri, 10 Aug 2018 15:35:04 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:34:41 -0700
In-Reply-To: <20180810223441.30428-1-sbeller@google.com>
Message-Id: <20180810223441.30428-9-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 8/8] diff.c: rewrite emit_line_0 more understandably
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

emit_line_0 has no nested conditions, but puts out all its arguments
(if set) in order. There is still a slight confusion with set
and set_sign, but let's defer that to a later patch.

'first' used be output always no matter if it was 0, but that got lost
at "diff: add an internal option to dual-color diffs of diffs",
2018-07-21), as there we broadened the meaning of 'first' to also
signal an early return.

The change in 'emit_line' makes sure that 'first' is never content, but
always under our control, a sign or special character in the beginning
of the line (or 0, in which case we ignore it).

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 73 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/diff.c b/diff.c
index e50cd312755..af9316c8f91 100644
--- a/diff.c
+++ b/diff.c
@@ -626,43 +626,52 @@ static void emit_line_0(struct diff_options *o,
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
@@ -672,7 +681,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, NULL, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, reset, 0, line, len);
 }
 
 enum diff_symbol {
-- 
2.18.0.865.gffc8e1a3cd6-goog

