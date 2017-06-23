Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7B32082F
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbdFWB3z (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:55 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36476 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbdFWB3v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:51 -0400
Received: by mail-pg0-f54.google.com with SMTP id u62so14977856pgb.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8fce7q1nKnf5ud+pSRAbLYjdKjcc9Vomtu/Bca3S4Lc=;
        b=q8aCBNzzGQ5A6A/Yy3/lJnaUtHMtIDmgkPP0cAWgxauODFh1YA4ea73Dv69zRGdnya
         4wZs1sSXT1+dbRpVgbKQpgWZbGRjxTpPq82jc7KI/W4k42h17gL+BdyqdwWXVO1HK+/l
         pd/yL2uEIRmOAYxmgeGPvgVGO+jRFKjwuPnhPo730I/ZSlKGCP0A2ZmaIOdfSDWL52Tc
         RVtPxGXwJqYAZiHBW8/RQjZ7txACawplZ/AhiK3XWuUSij3d7Mq41fc/oLH/RVU/ZXtY
         FjDRUEVXJZB9KkDhRXRsiw/DYmym/OZiTD3w4bYNO2G4v6ZIRfVNTvbMpPe2sfdVfnst
         3+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8fce7q1nKnf5ud+pSRAbLYjdKjcc9Vomtu/Bca3S4Lc=;
        b=qnxWx/yJg9dNaf01/13eR9+cJ645zIbTZnRe7soimVBa2Vpjt5IjS2Iyqdu9UI/xrJ
         tXvDx4HaNNzgTd7koUU1wIfMsJPV8oBtGbK0RiBj0MnGaEj1NrmJvzPAQQo6MfViefyb
         DMnAjFM/m5MLCQacAoa05TZCwld8FMEtk0XN+IeQVLS7vY2SFV06yDBxBIZLOLdh1wzP
         8Y6TcXK0TC5CBXL9itavacYpiVQhcirUKeaHsuFPSULgGKhmynEtpk57EUE91TQegCGL
         lkWOiJ0ThgswYUBa3q18Cxs1vdN9RjVnciQsHCJvCFvIdPo3tDx3pOCTRWkZdjcJ+Zqc
         L7LA==
X-Gm-Message-State: AKS2vOw4LxZKeSI4rn9RAr82/KH0jGeFHQJvjE+Ny4U5aQQR0PgBBOBs
        orydnnWcE4myOUeu
X-Received: by 10.99.157.140 with SMTP id i134mr5448902pgd.73.1498181380821;
        Thu, 22 Jun 2017 18:29:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id 66sm6285068pgh.59.2017.06.22.18.29.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 10/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
Date:   Thu, 22 Jun 2017 18:29:04 -0700
Message-Id: <20170623012919.28693-11-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The context marker use the exact same output pattern, so reuse it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 3d081edd12..f3d0918810 100644
--- a/diff.c
+++ b/diff.c
@@ -563,6 +563,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_WORDS_PORCELAIN,
 	DIFF_SYMBOL_WORDS,
 	DIFF_SYMBOL_CONTEXT,
+	DIFF_SYMBOL_CONTEXT_INCOMPLETE,
 	DIFF_SYMBOL_PLUS,
 	DIFF_SYMBOL_MINUS,
 	DIFF_SYMBOL_NO_LF_EOF,
@@ -621,6 +622,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
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
2.12.2.575.gb14f27f917

