Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E6C201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbdF3UyN (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:54:13 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35361 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753062AbdF3Uxf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:35 -0400
Received: by mail-pf0-f182.google.com with SMTP id c73so72473500pfk.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rnZ+w/EfST5yCnLq5DFNQ15/CuLT1yPpTIx3Naj9UbE=;
        b=ORaj22SlWphrUnqd7ZOIwJjHRcH25cpXWEFiBFQRNENUzprH0iS/csjDObvMrDd+N3
         ORHky7T0qqhhlosu5peQtUUPb5aufVUC49QhsPmA1AP2dpTzrilhjFPSt3QZUDIl8obJ
         dgc/UaFBJbMDwovkpnpWeaRkWHAxxnJgA/iiZ1fWekJBmx8DuBxLNIYugUeW/HZE/PDQ
         iv7/jGts1IhPE1saxbi513WiwooWsYkZV8mJQq2VLgPpAfhC5xLkZhNVHwWlMxTaZPSn
         8uddJpbJkoOo4uZYgt0sXQ1Hb53bgwkuEPLjk0QtnmX8QieZsm2thEV2ZW+boXXWoH5y
         d/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rnZ+w/EfST5yCnLq5DFNQ15/CuLT1yPpTIx3Naj9UbE=;
        b=GGIzW6Ob/Idu5cn8fS8SJbf/IrHLef5hyO/elalA/olJAXYYwhnpMQ+g8JbGLVspnd
         1WdiEy63CKgqRLPnadaqYkwWRUDQ4cSjNSztOSia5OOhmTHTKN+PRqgcTSmppU7BnEHU
         HZJl8q+s/NqS6YFwXI4Zb+hzO6cxwT518U5N/ms1pKg3f9dyFW/k1t2RsbzXvCccJD2F
         qNtibKjZb6YvUoG/5K/IoRR9yIogkOZgBQ6p+Rdo2Cx1YECk1vFBjaUTUCOLK1ScvViJ
         6iQNVU7aNX5hoT/xL4hHVlDScvRV0hWvdcIX4rnuoehO1wC6ymZTZkcVoMqpYH2XxDu2
         xHyQ==
X-Gm-Message-State: AKS2vOyGaa8ClYT9tNYqSKI7L7RCzrzL6ldfBbpu8a9+Rk81LEjJ3UwD
        r8OF8HZiJyA60k4p
X-Received: by 10.101.76.3 with SMTP id u3mr22642755pgq.119.1498856014326;
        Fri, 30 Jun 2017 13:53:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id t26sm22839261pfe.88.2017.06.30.13.53.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 16/25] diff.c: convert emit_binary_diff_body to use emit_diff_symbol
Date:   Fri, 30 Jun 2017 13:53:01 -0700
Message-Id: <20170630205310.7380-17-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 48f719fb07..f5a14359ae 100644
--- a/diff.c
+++ b/diff.c
@@ -561,6 +561,11 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_BINARY_DIFF_HEADER,
+	DIFF_SYMBOL_BINARY_DIFF_HEADER_DELTA,
+	DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL,
+	DIFF_SYMBOL_BINARY_DIFF_BODY,
+	DIFF_SYMBOL_BINARY_DIFF_FOOTER,
 	DIFF_SYMBOL_SUBMODULE_ADD,
 	DIFF_SYMBOL_SUBMODULE_DEL,
 	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
@@ -635,6 +640,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
 	case DIFF_SYMBOL_SUBMODULE_ERROR:
 	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
+	case DIFF_SYMBOL_BINARY_DIFF_BODY:
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
 		emit_line(o, "", "", line, len);
 		break;
@@ -706,6 +712,19 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_HEADER:
 		fprintf(o->file, "%s", line);
 		break;
+	case DIFF_SYMBOL_BINARY_DIFF_HEADER:
+		fprintf(o->file, "%sGIT binary patch\n", diff_line_prefix(o));
+		break;
+	case DIFF_SYMBOL_BINARY_DIFF_HEADER_DELTA:
+		fprintf(o->file, "%sdelta %s\n", diff_line_prefix(o), line);
+		break;
+	case DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL:
+		fprintf(o->file, "%sliteral %s\n", diff_line_prefix(o), line);
+		break;
+	case DIFF_SYMBOL_BINARY_DIFF_FOOTER:
+		fputs(diff_line_prefix(o), o->file);
+		fputc('\n', o->file);
+		break;
 	case DIFF_SYMBOL_REWRITE_DIFF:
 		fraginfo = diff_get_color(o->use_color, DIFF_FRAGINFO);
 		reset = diff_get_color_opt(o, DIFF_RESET);
@@ -2390,8 +2409,8 @@ static unsigned char *deflate_it(char *data,
 	return deflated;
 }
 
-static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
-				  const char *prefix)
+static void emit_binary_diff_body(struct diff_options *o,
+				  mmfile_t *one, mmfile_t *two)
 {
 	void *cp;
 	void *delta;
@@ -2420,13 +2439,18 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 	}
 
 	if (delta && delta_size < deflate_size) {
-		fprintf(file, "%sdelta %lu\n", prefix, orig_size);
+		char *s = xstrfmt("%lu", orig_size);
+		emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_HEADER_DELTA,
+				 s, strlen(s), 0);
+		free(s);
 		free(deflated);
 		data = delta;
 		data_size = delta_size;
-	}
-	else {
-		fprintf(file, "%sliteral %lu\n", prefix, two->size);
+	} else {
+		char *s = xstrfmt("%lu", two->size);
+		emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL,
+				 s, strlen(s), 0);
+		free(s);
 		free(delta);
 		data = deflated;
 		data_size = deflate_size;
@@ -2435,8 +2459,9 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 	/* emit data encoded in base85 */
 	cp = data;
 	while (data_size) {
+		int len;
 		int bytes = (52 < data_size) ? 52 : data_size;
-		char line[70];
+		char line[71];
 		data_size -= bytes;
 		if (bytes <= 26)
 			line[0] = bytes + 'A' - 1;
@@ -2444,20 +2469,24 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 			line[0] = bytes - 26 + 'a' - 1;
 		encode_85(line + 1, cp, bytes);
 		cp = (char *) cp + bytes;
-		fprintf(file, "%s", prefix);
-		fputs(line, file);
-		fputc('\n', file);
+
+		len = strlen(line);
+		line[len++] = '\n';
+		line[len] = '\0';
+
+		emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_BODY,
+				 line, len, 0);
 	}
-	fprintf(file, "%s\n", prefix);
+	emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_FOOTER, NULL, 0, 0);
 	free(data);
 }
 
-static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two,
-			     const char *prefix)
+static void emit_binary_diff(struct diff_options *o,
+			     mmfile_t *one, mmfile_t *two)
 {
-	fprintf(file, "%sGIT binary patch\n", prefix);
-	emit_binary_diff_body(file, one, two, prefix);
-	emit_binary_diff_body(file, two, one, prefix);
+	emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_HEADER, NULL, 0, 0);
+	emit_binary_diff_body(o, one, two);
+	emit_binary_diff_body(o, two, one);
 }
 
 int diff_filespec_is_binary(struct diff_filespec *one)
@@ -2643,7 +2672,7 @@ static void builtin_diff(const char *name_a,
 		emit_diff_symbol(o, DIFF_SYMBOL_HEADER, header.buf, header.len, 0);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
-			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
+			emit_binary_diff(o, &mf1, &mf2);
 		else {
 			strbuf_addf(&sb, "%sBinary files %s and %s differ\n",
 				    diff_line_prefix(o), lbl[0], lbl[1]);
-- 
2.13.0.31.g9b732c453e

