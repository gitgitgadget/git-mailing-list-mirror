Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240BE1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdFTCsg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:36 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33029 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFTCse (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:34 -0400
Received: by mail-pg0-f46.google.com with SMTP id f185so56566249pgc.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iGhelISNZYE7goUfLqzghJ20Q8mLcrXDgzbmQphBhHg=;
        b=Wu4aHEGQHSjUxRp8iPP/Rmz3IubJSUg3R/dbB2br83YF/YuFyb2tgCxOi1fEUYN4CQ
         S0vOynJ8dcRLuzqM+SqRlQ5ODfQpzfUl7CV0GtT4q+fqF/GqGwnhH2vOs80H/SkfwFdq
         yb1vW2j431ZYuO/P5jOzJ+V3AlXKm8ssEk5Tvs2ARBkuNVCDCPdD1QbaPoIZ9Lk/rw2W
         VI/3Rak1JaA3hsBsRKXjgBziE0rKRHeUPoE6ZVCG2srCenNaZskGU+ez0pyZ6bSKFkVo
         tjBQniZB4Y115AANivRFHvBqaIoTd63w/yFbqILAbXHBYGYz+dpS813qrlMZqxuvJJ4c
         HG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iGhelISNZYE7goUfLqzghJ20Q8mLcrXDgzbmQphBhHg=;
        b=tDaH6X7xmPaggedWbtzf0/W384qHdjwOy7fThSHyO0Fb10+A9x/ry8N85kGHbWDcCy
         DherKaAmVts+YEPEYF4+ofh1ZcatM+eOBT7o7hSm+ACtXNxleR4tGPm5W6d7Sz6m6aAi
         VhwPj40/HWQrse5m5pgb8qUrv8loqWksoAxozlRNgAVwoJskT4ErJ8zDn9CrMgzndvB6
         ach+ZhvH/VdH+v65QvvuQPcxjltDQJEeBj9crV8LpT/RlpqbvGM3wyB0+5t2bqYIJP4D
         CMWPd0Iju6esY7jX6czjBrcpO+bz18Y2gSBFJTc9n4JpBmYgPqEmO4FDOFGjUFIVjt86
         gKXg==
X-Gm-Message-State: AKS2vOyq4R/BVVyF2DOPpyVIfdzs0UCyJjBdBQWnGEgg0fyJhcBoE+tG
        uKPAluTFkd/gUhiw
X-Received: by 10.84.247.16 with SMTP id n16mr32312002pll.74.1497926913500;
        Mon, 19 Jun 2017 19:48:33 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id 25sm2842920pfj.59.2017.06.19.19.48.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 07/26] diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
Date:   Mon, 19 Jun 2017 19:47:57 -0700
Message-Id: <20170620024816.20021-8-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index a1804a7785..28be3226c2 100644
--- a/diff.c
+++ b/diff.c
@@ -563,11 +563,13 @@ enum diff_symbol {
 	DIFF_SYMBOL_SEPARATOR,
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_CONTEXT_FRAGINFO,
+	DIFF_SYMBOL_NO_LF_EOF,
 };
 
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len)
 {
+	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset;
 	switch (s) {
 	case DIFF_SYMBOL_SEPARATOR:
@@ -583,6 +585,13 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
 		emit_line(o, "", "", line, len);
 		break;
+	case DIFF_SYMBOL_NO_LF_EOF:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		putc('\n', o->file);
+		emit_line_0(o, context, reset, '\\',
+			    nneof, strlen(nneof));
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -750,7 +759,6 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 			       int prefix, const char *data, int size)
 {
 	const char *endp = NULL;
-	static const char *nneof = " No newline at end of file\n";
 	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
 
 	while (0 < size) {
@@ -768,13 +776,8 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		size -= len;
 		data += len;
 	}
-	if (!endp) {
-		const char *context = diff_get_color(ecb->color_diff,
-						     DIFF_CONTEXT);
-		putc('\n', ecb->opt->file);
-		emit_line_0(ecb->opt, context, reset, '\\',
-			    nneof, strlen(nneof));
-	}
+	if (!endp)
+		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0);
 }
 
 static void emit_rewrite_diff(const char *name_a,
-- 
2.12.2.575.gb14f27f917

