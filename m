Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3211F954
	for <e@80x24.org>; Wed, 22 Aug 2018 22:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeHWBwo (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 21:52:44 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:54262 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHWBwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 21:52:43 -0400
Received: by mail-vk0-f73.google.com with SMTP id x78-v6so1330424vkd.20
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=j3Paywmz9GbWkHH+Op0mGeKv8Uv0mr+uiz9uB73Jp9s=;
        b=XxBVYHbg+ZOfzONTe6UsBWFku7UJSnjxsgfAk8ilDNH4peEC4JknAZzBd0v2pIwT/7
         JQg3ge75w65+i6pn6AKVPiVL+RO+eTFGBO2+ui4Frl7pXKxZ7NkBWTKdXvZEIWsajZqg
         DFgbbNspZwXBkBgKsFwczl5QlavPR8wj9dI4UFeK+/wwLiUWgAeDkZpniHz0OiIxhsuY
         vGjk4UVU5GwGq4iCdQ80HTr7Kbfu/sozI+ZSTpM+Ms6IShFlFzsykjaxdosUx4wEMbUW
         WhRv+4pCs41IE1ayzDQ2K3YZ1NaFKSqNd2Cxs0JU2VrPuf7TgvpwqFbqV6vG9wWtz9rU
         KSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=j3Paywmz9GbWkHH+Op0mGeKv8Uv0mr+uiz9uB73Jp9s=;
        b=e188iYKGG+zfWKySFDVJ0hnDelpu50bCoBpseYJHVya8kAoysyzkdAuHTGljOGg6aY
         d6l+1q9EmT3EoKsmnozC9T2PvtYy3soEC6G8ZDJMgzL6McwjDMLEVEZfoWgSLCbZEP6U
         DkM6QVE3NKmbVj7hXPfAyVqFP4G294sbpaTharYNLtKGFZ/jFQdkFSCWp3AzhpnqkamA
         hOruE0suOJSmEM3sQS6dn1KEu0eAZA1md0E+5XP794NYtDKLjuVVcp8SKb0MAe/BOsSK
         Y1yP5cKuFVeEg8JWyHpgV3qMbQmFtfuz/ctufQMBmjOLYlHQkEiN7smF9xhVaesUTlYt
         JmKQ==
X-Gm-Message-State: AOUpUlEb3cQn9G2CZTKsgUL0y/IEbt4j/Uo5FbjP3wGB5NDpMkEn5pNW
        5yEiE/HSsaVnP3lqkKyd66nWjaH5RhJr
X-Google-Smtp-Source: AA+uWPyrZkFb20ORFGfWPfL0k2COrdkEL34k9wjOnTUfEeOLUvim7g/+ik9jD6CQALLfidxkecZkY2rHzhR6
MIME-Version: 1.0
X-Received: by 2002:a1f:b6d2:: with SMTP id g201-v6mr29541941vkf.77.1534976758800;
 Wed, 22 Aug 2018 15:25:58 -0700 (PDT)
Date:   Wed, 22 Aug 2018 15:25:48 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808211813020.73@tvgsbejvaqbjf.bet>
Message-Id: <20180822222548.236699-1-sbeller@google.com>
References: <nycvar.QRO.7.76.6.1808211813020.73@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH] diff.c: pass sign_index to emit_line_ws_markup
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of passing the sign directly to emit_line_ws_markup, pass only the
index to lookup the sign in diff_options->output_indicators.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)
 
So something like this on top of sb/range-diff-colors ?
If a resend is needed I'll squash this in (or carry it as a cleanup patch early
in the series), otherwise we could put this on top.

Thanks,
Stefan
 

diff --git a/diff.c b/diff.c
index 03486c35b75..17e33d506a1 100644
--- a/diff.c
+++ b/diff.c
@@ -1199,10 +1199,11 @@ static void dim_moved_lines(struct diff_options *o)
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set_sign, const char *set,
 				const char *reset,
-				char sign, const char *line, int len,
+				int sign_index, const char *line, int len,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
+	int sign = o->output_indicators[sign_index];
 
 	if (o->ws_error_highlight & ws_rule) {
 		ws = diff_get_color_opt(o, DIFF_WHITESPACE);
@@ -1282,8 +1283,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
 		emit_line_ws_markup(o, set_sign, set, reset,
-				    o->output_indicators[OUTPUT_INDICATOR_CONTEXT],
-				    line, len,
+				    OUTPUT_INDICATOR_CONTEXT, line, len,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1327,8 +1327,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
 		}
 		emit_line_ws_markup(o, set_sign, set, reset,
-				    o->output_indicators[OUTPUT_INDICATOR_NEW],
-				    line, len,
+				    OUTPUT_INDICATOR_NEW, line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1372,8 +1371,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
 		emit_line_ws_markup(o, set_sign, set, reset,
-				    o->output_indicators[OUTPUT_INDICATOR_OLD],
-				    line, len,
+				    OUTPUT_INDICATOR_OLD, line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
-- 
2.18.0.265.g16de1b435c9.dirty

