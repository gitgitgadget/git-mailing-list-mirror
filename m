Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0312082E
	for <e@80x24.org>; Fri, 23 Jun 2017 01:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754102AbdFWB3u (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:50 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35564 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbdFWB3p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:45 -0400
Received: by mail-pg0-f45.google.com with SMTP id 132so15007026pgb.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EFUzDjxBgp6fjxWU0KU4J0Lyrrb7tN0Q/C8NaKpZPwY=;
        b=IwGF4gaz/g0+Uiiu194XXrGjYLN8Kdzkxve8wvxjtLVZ0GORX7cT9TWzK0tUwDTNFh
         U3vwKYrZaUbt9RCVJeSDGoNK6hi314L/VE7oh/1nU58iqpMMjl7glrzZkChoYY1EthiB
         7hcXFErbvTWIW2F5+mSBIO0o4AsnqCyhnkR4FLgeKRQ4e4W5F9e2jXuoY7GoYjB8j498
         8DNLuP8B+9olxlRqYM5byAmxh9DwhBXaD1OiMunyCKHr7+PeBz0Al6uPIGmW4N1qRih/
         bDCT5L201ILP7CD9iiWhjfgnq7aDNOOCECN117b+Osj8Kp7sAslra1sUC8IGhrJqc5Jh
         AUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EFUzDjxBgp6fjxWU0KU4J0Lyrrb7tN0Q/C8NaKpZPwY=;
        b=mLGSK7o2mF+iDnMch/X6bOCN+hgf8leEnwXVKfyHTN7m4NrOru5kWOJL+0tGtGUNoL
         xzQshxFayPwKzCJyjt6/Py1AVUinRVmc54nRGTmm+FMnoUQ+9qHxn84yRcmcXFsBz5dK
         sg4x7MHgKsHcWntmbiNHIo8uc6SiiSeJkbhsENkK73a8WR44bcZp9XTnTj9H0o1ixNkO
         eKIYewluHy7VZuJGmJDhSzWn8UAEBcDOlDgsyF/tWIbmjbHfZMWKrXqK3LSX368L4/wL
         pJ9RvdUFdhIt3pqdW/vXZ1HG3Ijyrpp1qB1Bqdhw9gckSheAg5OisDBXBAWAQexE1OoA
         MrlQ==
X-Gm-Message-State: AKS2vOzzFmZrXPuipCgydFQ1KrLcrtl5x2+fJ2rYdOU+6uED7Vl4rrkp
        Op5cjYiZLIPkd5uv
X-Received: by 10.99.96.141 with SMTP id u135mr5458478pgb.129.1498181384591;
        Thu, 22 Jun 2017 18:29:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id a79sm6436377pfj.5.2017.06.22.18.29.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 13/25] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
Date:   Thu, 22 Jun 2017 18:29:07 -0700
Message-Id: <20170623012919.28693-14-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

we could save a little bit of memory when buffering in a later mode
by just passing the inner part ("%s and %s", file1, file 2), but
those a just a few bytes, so instead let's reuse the implementation from
DIFF_SYMBOL_HEADER and keep the whole line around.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 34314455b5..78cf5ad691 100644
--- a/diff.c
+++ b/diff.c
@@ -560,6 +560,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_BINARY_FILES,
 	DIFF_SYMBOL_HEADER,
 	DIFF_SYMBOL_FILEPAIR_PLUS,
 	DIFF_SYMBOL_FILEPAIR_MINUS,
@@ -689,6 +690,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			line, reset,
 			strchr(line, ' ') ? "\t" : "");
 		break;
+	case DIFF_SYMBOL_BINARY_FILES:
 	case DIFF_SYMBOL_HEADER:
 		fprintf(o->file, "%s", line);
 		break;
@@ -2542,6 +2544,7 @@ static void builtin_diff(const char *name_a,
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
 	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
 	      (!textconv_two && diff_filespec_is_binary(two)) )) {
+		struct strbuf sb = STRBUF_INIT;
 		if (!one->data && !two->data &&
 		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
 		    !DIFF_OPT_TST(o, BINARY)) {
@@ -2554,8 +2557,11 @@ static void builtin_diff(const char *name_a,
 			}
 			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
 					 header.buf, header.len, 0);
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+			strbuf_addf(&sb, "%sBinary files %s and %s differ\n",
+				    diff_line_prefix(o), lbl[0], lbl[1]);
+			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
+					 sb.buf, sb.len, 0);
+			strbuf_release(&sb);
 			goto free_ab_and_return;
 		}
 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
@@ -2572,9 +2578,13 @@ static void builtin_diff(const char *name_a,
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
-		else
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+		else {
+			strbuf_addf(&sb, "%sBinary files %s and %s differ\n",
+				    diff_line_prefix(o), lbl[0], lbl[1]);
+			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
+					 sb.buf, sb.len, 0);
+			strbuf_release(&sb);
+		}
 		o->found_changes = 1;
 	} else {
 		/* Crazy xdl interfaces.. */
-- 
2.12.2.575.gb14f27f917

