Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A1C1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHKBGx (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:06:53 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:44906 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKBGw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:06:52 -0400
Received: by mail-ua1-f74.google.com with SMTP id d22-v6so2314849uaq.11
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N8b6TE8RTrgV7yIlmWAHS+PEUrEdjXgOMNTqw/OHcLQ=;
        b=Xnzha8mDwcbS5FUI5YqquQNri8Po2xUI1Ns87yORum9ucWOg9gSrvo0ouiB4dKVUKy
         uIiW6zKL8d28/pLJk03yDLU6lJIxiQS0VtSTHNFoV6ovn2FEPTJ0Cyf4KegLc7Eqg42Y
         9slZb97kSqO+sCFneswO9oCgshc89XbHjwE39KJieMJAbn2FFlYNqSgTIOLHXVZGAfV+
         9fuR5AWnUKViYmWlm3aF7GvSDJIGNEWBgkj1QjfjBT3fhm1KuOjT/eSbelS00sV2uftc
         4dt1JITDav16w+Qa5wUlb9dqupQGfDkZk8aJKjmAY+XQDYKxdZRXsHa8ezGPoHEnv5RC
         971A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N8b6TE8RTrgV7yIlmWAHS+PEUrEdjXgOMNTqw/OHcLQ=;
        b=KdcmjmlHco7+G+DLO06vse9pIaig1weKmBim41TXoF5swBgxN3v9Gh3ds0/fIeiWGi
         UETaTLxb9UhvKYkoJieq8XCfTEg0vWCtX6I2IPjbeJHbLqHLlsphO7PvClxpa/8YtXcU
         6XVz5SL8vAKynMBTWLzaxI5o6zKZsi/GezscbP3keakbqv36Xe6yGEcP1FHBJ0MZ3I/i
         XytrplXK64RIofVRkdhFtAkEm9DzgUwjrUoG7okwaFqmKoDg/8orT1F2JkpN/NavaP1/
         WSpbFD6dPi8E1VIgYW67lKuFSNp+TiOZhQXst6bcRHd1VF5iV7RQNBqrJorOcfxR330q
         fATg==
X-Gm-Message-State: AOUpUlHONxdUTVJQP4P/1quF13LA5KuKWrDjY4tK6vovdN1HN9Hbw7+L
        kqKdX6ZJuXQ4AA6TMo6BmMJOd+Jsk2v4
X-Google-Smtp-Source: AA+uWPxTWvO+QAxtzVseP52zMsdC8w61zM8BhMvhzBLZjeQSd1XG7rlL9yD0yH7edoUeXR99WgU/f9o0PdsK
X-Received: by 2002:ab0:4b81:: with SMTP id v1-v6mr3773914uaf.114.1533940502414;
 Fri, 10 Aug 2018 15:35:02 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:34:40 -0700
In-Reply-To: <20180810223441.30428-1-sbeller@google.com>
Message-Id: <20180810223441.30428-8-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 7/8] diff.c: compute reverse locally in emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 01095a59d3d..e50cd312755 100644
--- a/diff.c
+++ b/diff.c
@@ -622,11 +622,12 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 }
 
 static void emit_line_0(struct diff_options *o,
-			const char *set_sign, const char *set, unsigned reverse, const char *reset,
+			const char *set_sign, const char *set, const char *reset,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	int nofirst;
+	int reverse = !!set && !!set_sign;
 	FILE *file = o->file;
 
 	fputs(diff_line_prefix(o), file);
@@ -671,7 +672,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, NULL, 0, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, reset, line[0], line+1, len-1);
 }
 
 enum diff_symbol {
@@ -1203,15 +1204,15 @@ static void emit_line_ws_markup(struct diff_options *o,
 	}
 
 	if (!ws && !set_sign)
-		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
+		emit_line_0(o, set, NULL, reset, sign, line, len);
 	else if (!ws) {
-		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, line, len);
+		emit_line_0(o, set_sign, set, reset, sign, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
+		emit_line_0(o, ws, NULL, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, "", 0);
+		emit_line_0(o, set_sign, set, reset, sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
 	}
@@ -1234,7 +1235,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, NULL, 0, reset, '\\',
+		emit_line_0(o, context, NULL, reset, '\\',
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
-- 
2.18.0.865.gffc8e1a3cd6-goog

