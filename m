Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441BF1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 19:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbeGJT6y (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 15:58:54 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:34271 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbeGJT6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 15:58:54 -0400
Received: by mail-vk0-f73.google.com with SMTP id o62-v6so8329788vko.1
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=kFFKhDIitJP3vLfeWg+pHOu87RYw70sLnUXIWrTIXHI=;
        b=n0vfvs2IsU8qDdcILjET5YGx9gFqQQa5nHyh7R9euX2tJ5DjxVzKI94cOr9Y3wznzM
         7di+TLSqaoK6sbl6sZLvhl/NgJliZjmg3eTxMegXuySSpSsCxtj0xXTIyw6ZyB/ZYpE2
         qNRgdKGplpuvKldKFHpgNvh87VGjMt6iOvnUUkvrKncI0Wu0sAJnoYEe5fq7pc5XWXlT
         BaIqXBg5CQBwmi5z5l8AY91XBbB5yyqIjXXczoNLJhV8Tv8yRYW85abRiYNDPC9v6ll2
         c4UIcl4nEqyeZZ4677vNKNQg+5qyn38Csi7mFnV+t06IVPJXutnKJOhES8WnWyfJ7lT9
         qgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=kFFKhDIitJP3vLfeWg+pHOu87RYw70sLnUXIWrTIXHI=;
        b=FGW2R3sI4BRbPLaaYVQfg8u2JbF8VWLEQv17vSOgRfVgpircsFWV+eIG5j1JNSnt7K
         j8I744+8CkuFhZtLFis/d1gPDQOGnL0mIjwW9OzMh2dPeNEEqa3Z8ol2CinymfAYK+iT
         NMCyWpIT9sPOVLt3KIDKQQ/j1iGmOLEJrh95b1v8TAZQO3hsHs3oppSbpirWURRrMgGV
         f6d3Ef08wIv863pon1rRejjN6cIAHwEVisnq/LPd4mDjxHX40qjtHrfw+T3iaicfiewD
         0q5pDgw3sekGm0MF/PKdE2Hbm3FBk01EHNhFgIO/osA84/grx2UKq+g3UwCAoHl2kGYL
         YQ0g==
X-Gm-Message-State: APt69E2vUYig71ajIaCxd2YIt7JSv3cPtFP91ZNSOPcZkPpLzStG9aCA
        D+TGzt+lIWAfThyj98M3iys8nZdbPUGD
X-Google-Smtp-Source: AAOMgpcqFl1JdMBFkyJY4QBM90ghFLwFpabUo5vKbzD3mgJr1O5pBqqZqfdi7K/zSPav/RceAXSeuEeg6ac1
MIME-Version: 1.0
X-Received: by 2002:a1f:44e:: with SMTP id 75-v6mr12331971vke.121.1531252699815;
 Tue, 10 Jul 2018 12:58:19 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:58:03 -0700
In-Reply-To: <20180710174552.30123-3-sbeller@google.com>
Message-Id: <20180710195803.131062-1-sbeller@google.com>
References: <20180710174552.30123-3-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 1/2] diff.c: convert emit_line_ws_markup to take string for sign
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the diff of diffs, we have more than one character at the beginning
of the line with special meaning, so let's pass around a string that
contains all the markup for the line

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 32500716740..028d7d9a59c 100644
--- a/diff.c
+++ b/diff.c
@@ -969,7 +969,7 @@ static void dim_moved_lines(struct diff_options *o)
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set, const char *reset,
 				const char *line, int len,
-				const char *set_sign, char sign,
+				const char *set_sign, const char *sign,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
@@ -981,19 +981,19 @@ static void emit_line_ws_markup(struct diff_options *o,
 	}
 
 	if (!ws && !set_sign)
-		emit_line_0(o, set, 0, reset, sign, line, len);
+		emit_line_0(o, set, 0, reset, sign[0], line, len);
 	else if (!ws) {
 		/* Emit just the prefix, then the rest. */
 		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
-			    sign, "", 0);
+			    sign[0], "", 0);
 		emit_line_0(o, set, 0, reset, 0, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(o, ws, 0, reset, sign, line, len);
+		emit_line_0(o, ws, 0, reset, sign[0], line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
 		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
-			    sign, "", 0);
+			    sign[0], "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
 	}
@@ -1054,7 +1054,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c == '-')
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, ' ',
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, " ",
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1100,7 +1100,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				len--;
 			}
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, "+",
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1141,7 +1141,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c != '-')
 				set = diff_get_color_opt(o, DIFF_CONTEXT);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '-',
+		emit_line_ws_markup(o, set, reset, line, len, set_sign, "-",
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
-- 
2.18.0.203.gfac676dfb9-goog

