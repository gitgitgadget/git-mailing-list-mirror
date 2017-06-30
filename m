Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4483202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbdF3AIR (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:08:17 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34311 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbdF3AH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:56 -0400
Received: by mail-pg0-f46.google.com with SMTP id t186so55416422pgb.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DKCmUm271quFz59evQjwsdKNJ5oQ4hRUvaTdnfdaVW4=;
        b=h0sN2ntxLHO+9m4b2Z6zOMyWqmMUjKLXIO6V7Irx3CU+ie//8xxShXHqTptpQo7zmv
         qn2klacD0QdQYvhyYI9WMCsKAqIoXjj7lyor8QRFH3mLUkZb3maxG5OHuk5z210P4ZhQ
         1Fn201c4hYHvz/cnHshlu91dp5vzPYRi1oO/dRdIiRBc/ueG8mM6X7zq/GDJmUHktDMK
         8ViZSBsygwbYFS9/IO8nJVm1aXpyXQnkvF+mTizn7xG4NdFNx7o6nO8oVnzFe8N6A74V
         ukq3RokVmmlwb0JUrQwSsszpynyveJn8AFlR3BAHowN751C412rrzPfKQ400RrozyORA
         Hyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DKCmUm271quFz59evQjwsdKNJ5oQ4hRUvaTdnfdaVW4=;
        b=Bg+xk7AEB0zPbhb2rvC0XFDpstaENHPUG0C9iaiIL/mS1APP3oO7OWBtE+GAg/8tec
         YLBb+MQG8YGJrTeQxNIzAjv/L99Wy0vdTVGwlu/ctZ2xNtgCLm0d3t4+B+/+Y204wR0u
         IpbdwU36+IsC2PDfkdjxPPCqVng7iUE1gp1CZTH1fxU6ac/RQkTNBpXn5p+GsJcHcB/E
         jG2tupuaEOedMu4KbTTEX0+QS4/7udvHSD1ZGff3pXMVfaoAvKS8+mbhtrxR400kmzZ6
         fmV0K1LVk45WKZRQVjcOoBfhxGXNffKnDCh6Yni5Ot5tXqokz7NgP4KSqiDytytc2zXh
         D2og==
X-Gm-Message-State: AKS2vOxsrCtJNxosOfLrdq8Mey0LX5eXf4eEvW2c3QIDOh3jbXLsMvIn
        XddR0AMESBPS5TlEyHMtHQ==
X-Received: by 10.84.176.131 with SMTP id v3mr11284603plb.142.1498781256183;
        Thu, 29 Jun 2017 17:07:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id r90sm13391397pfj.37.2017.06.29.17.07.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
Date:   Thu, 29 Jun 2017 17:06:55 -0700
Message-Id: <20170630000710.10601-11-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The context marker use the exact same output pattern, so reuse it.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 85bfd9310d..b2b2a19fcf 100644
--- a/diff.c
+++ b/diff.c
@@ -564,6 +564,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_WORDS_PORCELAIN,
 	DIFF_SYMBOL_WORDS,
 	DIFF_SYMBOL_CONTEXT,
+	DIFF_SYMBOL_CONTEXT_INCOMPLETE,
 	DIFF_SYMBOL_PLUS,
 	DIFF_SYMBOL_MINUS,
 	DIFF_SYMBOL_NO_LF_EOF,
@@ -622,6 +623,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
 		emit_line(o, "", "", line, len);
 		break;
+	case DIFF_SYMBOL_CONTEXT_INCOMPLETE:
 	case DIFF_SYMBOL_CONTEXT_MARKER:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
@@ -1448,8 +1450,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	default:
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
-		emit_line(o, diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
-			  reset, line, len);
+		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
+				 line, len, 0);
 		break;
 	}
 }
-- 
2.13.0.31.g9b732c453e

