Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD05C1F405
	for <e@80x24.org>; Fri, 10 Aug 2018 22:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeHKBGp (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:06:45 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:43546 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKBGp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:06:45 -0400
Received: by mail-oi0-f73.google.com with SMTP id e23-v6so10695451oii.10
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QzqwFDxWwpBIex3kHb92QwRvl6k6I2mxc0+euTyYp38=;
        b=qLnXT7MiQQ59wjC0D18NgX+ogROGnpNY2dSwdgeIumkr3l35pe5Utp9r2WS40pFaCL
         7fdsbPCQhUY8+Uj6WlLQzxzoqbxo4uU2eh7witcfcqt05LIHPDULHasXR2H4wRmyVdc3
         tFIt5e6dCpUQFeL0+CKA7Gbtix5Wk374ksZwE5t9R+VhMvhJxaa0jsfiSqdtDMFRQ7C3
         2A2VVhQrYo9aF2ery3WFXYf0+VJdt/jPm2wk/QVHVOruIx2jUkpaJattQl7FMDXRNmJ/
         BmE8Z7v/njTLAmTv6gpFHg0457+OfPoeg6SxlTbu9BxLazNq7zKWzU4iT33iMvS4KQCg
         y4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QzqwFDxWwpBIex3kHb92QwRvl6k6I2mxc0+euTyYp38=;
        b=NanIKm6dreW0i322kbyU1ilZLuw4n9P9A1G5VlhkYR07USsmoXzTBezxLSK802ctm1
         0zVPnToCWzzbf9iBQA14XdrPfrdH9w1OckfQ5AvZ7P/H90nUuajyC5eoI5k9LF4FxgTI
         dfaucMsE/hZ/9JUt0BN+HTyLL9O0LmY3JsHYqyYxcfyX7oR/H49Fs+gP46S28T93ZXr+
         wSCZCos+TDBot0WN+m9uMobTnV/hb1O9xBe2FjDp5P3nXu1xV5wYK3Nl3t0k5k4GJ+9Z
         3Njj5ZMwx8Ztn4K/sZUo1KOScIZbh4U8OAFGi9cpkRpV7GayBHyjpH5FlNggZzi1UBOH
         ++NQ==
X-Gm-Message-State: AOUpUlF5qWgKEaJ87dE4A7p53Uuy9rVaoPTaGsOMTnvztE1sfwJfNh4k
        oS/iiZkW+Q2zTBnTNADmB6JI9gz2bzND
X-Google-Smtp-Source: AA+uWPwgXix5Z2NZGuzylZk9vNncx+SD/EUADp9NctpiADTWJw+rsMxXspQL+DJL7c7mp51B2V7l79f1n+5x
X-Received: by 2002:aca:5a89:: with SMTP id o131-v6mr4699900oib.65.1533940495283;
 Fri, 10 Aug 2018 15:34:55 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:34:37 -0700
In-Reply-To: <20180810223441.30428-1-sbeller@google.com>
Message-Id: <20180810223441.30428-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 4/8] diff.c: reorder arguments for emit_line_ws_markup
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The order shall be all colors first, then the content, flags at the end.
The colors are in order.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index f6df18af913..ab6e6a88a56 100644
--- a/diff.c
+++ b/diff.c
@@ -1185,9 +1185,9 @@ static void dim_moved_lines(struct diff_options *o)
 }
 
 static void emit_line_ws_markup(struct diff_options *o,
-				const char *set, const char *reset,
-				const char *line, int len,
-				const char *set_sign, char sign,
+				const char *set_sign, const char *set,
+				const char *reset,
+				char sign, const char *line, int len,
 				unsigned ws_rule, int blank_at_eof)
 {
 	const char *ws = NULL;
@@ -1271,7 +1271,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c == '-')
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, ' ',
+		emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1314,7 +1314,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
 			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
+		emit_line_ws_markup(o, set_sign, set, reset, '+', line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1357,7 +1357,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else
 				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '-',
+		emit_line_ws_markup(o, set_sign, set, reset, '-', line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
-- 
2.18.0.865.gffc8e1a3cd6-goog

