Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F5B2084B
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbdFWBa3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:30:29 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35576 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbdFWB3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:49 -0400
Received: by mail-pg0-f50.google.com with SMTP id 132so15007616pgb.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oMIy0bDLZCp1uY5kg4XAe62OcPwhqQwr1DQRV4YjAXc=;
        b=iIaejrTwTFZ+lcHTiDHKIrvTZ5uefzSucjLjcYPZ8Z98qN8mBuxfinU87kSiJS6xQF
         ZvC69Zg8SaD6FGF1q413HaBhBSfWTISey9+1Q3xuEPlwyL4XXW5MlTZuZg/6iG85gILR
         N3ajbdXGUjAXNcCr6n6nhD3knhfDD17uRAnF5evhkVIBHEuf4aDTXnle4wP92tdq/jmL
         cYqVcWcvtV6gU4f5x8O6g/zKYhxTjPU6RU1LeqCTBjEnADXzk2stmqDqiv9SwTbLvZpV
         6SPyEoG3daC+NKCXy3Z0QBuNDeBF8pOv2uCzIGppI4OvcM5wvefRjG28rVIBu3z6SDCY
         f5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oMIy0bDLZCp1uY5kg4XAe62OcPwhqQwr1DQRV4YjAXc=;
        b=THQ45+e7OVW2A4lxmXfb0agHzddfkLFdUlXzcsgfPMdwa5lu9w1MLssx4QQCFd7D4P
         eBNl9NcKYS+EDEDwZcrZ1JnGlEO23qZvo195uWklwF1VAGEYZ8+ndL88LM+5LuNbRSB6
         GhyWSTHycaqsoMV9cJKK0Z6lglJzv+JXS7EzjSCMvq8RSkxcJa3FVx2mqPYymG4IHPKw
         12mJ824RLZFnkjQTEoVzl3dfbBqVtFZZXOSZjkT2+PDYZqdEz1zj6HuCaRFXusMrMjZJ
         5ifiOGytDX2+A3wvQJEL2AKFiEQKeCPfFDWwxjWXvNFVpVPCuwqlbj4bzRwiwwSnZJjo
         IsXg==
X-Gm-Message-State: AKS2vOydseBdLUVrdI6sD+RI6IXS3b+/7QX6U/Qq4YUZw5BTLVfJSuDP
        MboMBjypnIt6EgsI
X-Received: by 10.99.2.134 with SMTP id 128mr5547977pgc.266.1498181388200;
        Thu, 22 Jun 2017 18:29:48 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id y15sm1727555pgs.33.2017.06.22.18.29.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 16/25] diff.c: convert emit_binary_diff_body to use emit_diff_symbol
Date:   Thu, 22 Jun 2017 18:29:10 -0700
Message-Id: <20170623012919.28693-17-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index bc78a216ab..7c92675f6f 100644
--- a/diff.c
+++ b/diff.c
@@ -560,6 +560,11 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
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
@@ -634,6 +639,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
 	case DIFF_SYMBOL_SUBMODULE_ERROR:
 	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
+	case DIFF_SYMBOL_BINARY_DIFF_BODY:
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
 		emit_line(o, "", "", line, len);
 		break;
@@ -705,6 +711,19 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
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
2.12.2.575.gb14f27f917

