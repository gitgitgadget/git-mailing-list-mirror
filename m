Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA45E1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbeGaCJg (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 22:09:36 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:33265 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbeGaCJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 22:09:36 -0400
Received: by mail-yw0-f201.google.com with SMTP id c11-v6so8293858ywb.0
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=oc6zjcyrpmYlkYKwvbe8kbmgciblOuzxAl1en1ejoJM=;
        b=VlOR16GwbDQyoyEy5CrQzi/OV4hW7c6HzLDU1fV5SbeP8ElJC6XvWKYQake1X7f1Bg
         mwLWXeoODSfZrYPvGHbwFVOR4dMImjvGeYOKqPpGAADab/d+MydLnzjgoof0NRysyH6W
         cN7dA2ruC3i9gqzNxUo7kCiYjgQXL94uEEHvIHq+1jMPUBPdUHtiIk/8Eg3tfGMDwk/4
         6vLPdlU5tRxBO3yGpvl4vXOwhKjXfclybMlKQ1X8AJdoIEh6GU1AjtdxoAHbULCsnY+4
         uzA3DO86KPRFpcUUo/ELiTVhZpuMA2s/btbAcRqhJR5oktWjoOabsgqoPuizLuivjpWI
         njyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=oc6zjcyrpmYlkYKwvbe8kbmgciblOuzxAl1en1ejoJM=;
        b=XyZNJRCbZHK3rdH0tyZ/p9NRMd/nMvZqA2wDW6IG/nijn6r9XnB1AijQPYOvBHHptU
         RsncA9TjEjRRIwmE8zYgwQtk1hqcgB8vj5AMI/iUtKt6majSJY6fC3A7NDR6nUqtVhKg
         F8p62VbV66oVP4+Mniw6Er/qQazJIGfzfppU4Y+0XDxQx2DNFhtxmzPIiJGNpRScnT8I
         FeLxdDPSGWPscj3ZvHkeZ3TDOcpprD9QtIDRsTZVvT3bSAK2M3nt9iS8EMZPoZrLOItz
         G8GoSff2s47ohTc//RbOgBNX+rQCwizHIBMhNBtnLRbdtNydiaknpKgto49Ovor0qWlT
         uWKg==
X-Gm-Message-State: AOUpUlHKYX6C8goKMzWEUv1sk+u4BNkDJq9lbNcIkqib+ajzstMBrYRn
        Q+aT9K2H2BkHKrtrjftCdmFdbw6p1kk5
X-Google-Smtp-Source: AAOMgpc7Z2w7odqHVSxVTiulrLaOsFkQNaQDSCQ0wWVKmQsAS0Yx43+TcTwRnOXl8IvQUDk/zo7iMnwRbnsw
MIME-Version: 1.0
X-Received: by 2002:a81:3c0b:: with SMTP id j11-v6mr5321514ywa.43.1532997124439;
 Mon, 30 Jul 2018 17:32:04 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:31:40 -0700
In-Reply-To: <20180731003141.105192-1-sbeller@google.com>
Message-Id: <20180731003141.105192-8-sbeller@google.com>
References: <20180728030448.192177-1-sbeller@google.com> <20180731003141.105192-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 7/8] diff.c: compute reverse locally in emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index fdad7ffdd77..f565a2c0c2b 100644
--- a/diff.c
+++ b/diff.c
@@ -576,11 +576,12 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
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
@@ -625,7 +626,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, NULL, 0, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, reset, line[0], line+1, len-1);
 }
 
 enum diff_symbol {
@@ -998,15 +999,15 @@ static void emit_line_ws_markup(struct diff_options *o,
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
@@ -1029,7 +1030,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, NULL, 0, reset, '\\',
+		emit_line_0(o, context, NULL, reset, '\\',
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
-- 
2.18.0.132.g195c49a2227

