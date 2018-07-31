Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 674221F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbeGaCJ3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 22:09:29 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:54800 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbeGaCJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 22:09:29 -0400
Received: by mail-oi0-f74.google.com with SMTP id 20-v6so12346616ois.21
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=AKPNkRrvh8JF+xSB+7B6ki3I8C6J/HPQQO3sqUtI2+o=;
        b=f1WEaC+o9mL8JRPZI7lwZoBS0687nodSYNkyugAJTztMNtY+lzyk+bWT/W/wJoZjgu
         t2FnY6jC8+CCJV9Icg+6tsMviAijQCDUx1t2XMsHHkE+NaueCsgcMoSG8IzppwE/7c+Q
         gTtamf5L/+NgdHrNMHeVspjjMcMhLyWUfUQgFkb4XiYDE2ygjVf0iQ+w3aH/qJfcZQw3
         bTG8s00PsBhMEYeb+EEHD6To1hpipQidK9MwQQwF9kLh/5IF/0dCgD+pD7rHH5kvSJ7B
         ++O4DkQ1S5o0xKy/xHwn9lBQMJLnKGqz7+bUqqMAW3jJ6K91UwoKXlayqJjtz9rM8ZJ2
         tAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=AKPNkRrvh8JF+xSB+7B6ki3I8C6J/HPQQO3sqUtI2+o=;
        b=bkcsLBiZuwONu2jns9w4/I7ZAQFEz1BCg8JOXd3MsOZlD9eXRZyfKXiUsWODV+E32s
         +W0YF38GQf/RiXRLM1uMg70Z36jbxZ4h6Xm7K3Si5dSlpTNmGujlnMZ8s6r39f1t2swh
         gHqlKxKuN1IQ9Cv4HrpMxBDJWzdd4SJGCz0akmj12dyUXu2aIAEA8p08lhK/ZXMl3abk
         OIAfTKJbbjsvSbk/xsdxHxYx2a5B5Kyroa7k5A/p916cUGnW8IX1iNupIFVy610TOjrg
         uCzo3X5+lAv+dksf3fb8O375DMGSpNvHz9t16iIDiqRv6iBCuwQduwt/QdCClplkHchr
         6ttQ==
X-Gm-Message-State: AOUpUlHNUuPHB6dPUXWQ4l+YkAbbtwNaVzFPzNlkiGqJNvUToi5hWU6o
        aBr6Ie+FzQd3PbqXNPNjjcg6toiXBwhO
X-Google-Smtp-Source: AAOMgpderSB7rvXcyUoTscOP8pwTcKLbpymVCrFHokUebdNRr7NR8+TPfHl8+9U+vk3uSGt7hxFwjIqwNauY
MIME-Version: 1.0
X-Received: by 2002:aca:ded5:: with SMTP id v204-v6mr11563995oig.7.1532997116899;
 Mon, 30 Jul 2018 17:31:56 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:31:37 -0700
In-Reply-To: <20180731003141.105192-1-sbeller@google.com>
Message-Id: <20180731003141.105192-5-sbeller@google.com>
References: <20180728030448.192177-1-sbeller@google.com> <20180731003141.105192-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 4/8] diff.c: reorder arguments for emit_line_ws_markup
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The order shall be all colors first, then the content, flags at the end.
The colors are in order.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index f7251c89cbb..8fd2171d808 100644
--- a/diff.c
+++ b/diff.c
@@ -980,9 +980,9 @@ static void dim_moved_lines(struct diff_options *o)
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
@@ -1066,7 +1066,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else if (c == '-')
 				set = diff_get_color_opt(o, DIFF_FILE_OLD);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, ' ',
+		emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
@@ -1109,7 +1109,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
 			flags |= WS_IGNORE_FIRST_SPACE;
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
+		emit_line_ws_markup(o, set_sign, set, reset, '+', line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
@@ -1152,7 +1152,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 			else
 				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
 		}
-		emit_line_ws_markup(o, set, reset, line, len, set_sign, '-',
+		emit_line_ws_markup(o, set_sign, set, reset, '-', line, len,
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
 		break;
 	case DIFF_SYMBOL_WORDS_PORCELAIN:
-- 
2.18.0.132.g195c49a2227

