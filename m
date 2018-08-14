Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A83FB1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 01:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbeHNE0m (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 00:26:42 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:54772 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeHNE0m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 00:26:42 -0400
Received: by mail-ua1-f74.google.com with SMTP id c4-v6so8829468uan.21
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 18:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hd0uM7dbDBw6EiWSGkA+/vA0l64H7BI3qkZGq+nEtuk=;
        b=CBk67V344XGKBhsKhL6mAXxEWCc6eHcBiUkfUhTvvEEI/a56yOl8rp8gC7Gwd8Qvt/
         WbK/IgY/ZjOm1wmy0luRQkzGYhAw7bBQARZKoaTttNkVv08IlNplSThA7zRjqe8PvTnx
         ifzSRUOO/JG0I28uOz+4NV+kXe6H/qO1KRMXhMi6/ce1nrSwk18CLRXMOA3wnCtg6bdb
         byDIYVVfkPhLTxej9319gnReqxRaj+7sp3xdK1+i5H7BE4vcXqVZ+RRHhymFwi6thXEn
         vvK+rkN52f71z1t1fcCLP4BcocdFHdxplUDRc9oONwMHedQJupB7miKePtO3T8NMrU5q
         FUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hd0uM7dbDBw6EiWSGkA+/vA0l64H7BI3qkZGq+nEtuk=;
        b=iLDhW9WI+OY/Rb+yu6kiLm7IksCy6KNefvdN9bnpBIvxr+itRWu80wDQEIM0+rLi9B
         l93T0lTtnnRmvXbFk/BPYLhO4abH8nzNn3GJE2kaieKOoRySrOyjvSXhmzYZPW2Caod2
         hXAOYXpkRKZWFMmN/LOle+86rjaQRnxfp2V2DqD0TEJwImHv7RqzHTyr5imgA+zUlW4X
         8vh5XyAJWETaRbf5HnBdFulBlWR0t/Sqkzxh2WzoqAeqsKpp3NifLwfHZad2EfmOBDdz
         mvS/7xPbzYo6ahe9XF+8KM9VdNw1hbyAkYkYARKdAa9NB140pn18geB7JsXvt54DE5JO
         y8cg==
X-Gm-Message-State: AOUpUlFVBxmLamc3yh4rpwF9IsvQzHe/opXFzd3HArt7o2GVDcSjSot1
        aF+r/CE1rVXxaMHCJlOFpFoAnvxCf+gD
X-Google-Smtp-Source: AA+uWPyZXMbQ2gBJYqIl+PIkvm5mHCmXhBtOkp+oPr643/cDEA2m/a+DtbQ7s39tjkfwoBe36/h7636OA2Cj
X-Received: by 2002:ab0:5113:: with SMTP id e19-v6mr9697327uaa.103.1534210910784;
 Mon, 13 Aug 2018 18:41:50 -0700 (PDT)
Date:   Mon, 13 Aug 2018 18:41:22 -0700
In-Reply-To: <20180814014122.30662-1-sbeller@google.com>
Message-Id: <20180814014122.30662-9-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180814014122.30662-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 8/8] diff.c: rewrite emit_line_0 more understandably
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite emit_line_0 to have fewer (nested) conditions.

The change in 'emit_line' makes sure that 'first' is never user data,
but always under our control, a sign or special character in the
beginning of the line (or 0, in which case we ignore it).
So from now on, let's pass only a diff marker or 0 as the 'first'
character of the line.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 73 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/diff.c b/diff.c
index 7a23adf254d..c5c7739ce34 100644
--- a/diff.c
+++ b/diff.c
@@ -626,43 +626,50 @@ static void emit_line_0(struct diff_options *o,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
-	int nofirst;
+	int needs_reset = 0; /* at the end of the line */
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
-		if (set_sign)
-			fputs(set_sign, file);
-		if (first && !nofirst)
-			fputc(first, file);
-		if (len) {
-			if (set && set != set_sign) {
-				if (set_sign)
-					fputs(reset, file);
-				fputs(set, file);
-			}
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
+	if (set_sign) {
+		fputs(set_sign, file);
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
+	needs_reset = 1; /* 'line' may contain color codes. */
+
+end_of_line:
+	if (needs_reset)
+		fputs(reset, file);
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
 	if (has_trailing_newline)
@@ -672,7 +679,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, NULL, 0, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, 0, reset, 0, line, len);
 }
 
 enum diff_symbol {
-- 
2.18.0.865.gffc8e1a3cd6-goog

