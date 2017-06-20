Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0335920D0C
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbdFTCtB (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:49:01 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33112 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbdFTCs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:57 -0400
Received: by mail-pf0-f178.google.com with SMTP id 83so62784220pfr.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bXy4jACbThlmvCTSK/PFN6hive2FmiG2wSZiGBs8Z3s=;
        b=IRjxHMSrm53/HQuMMyY5F5ETh81Pp50hsMJMveDAT3kG/Tua2dz+18sY7xf+Ucsj9P
         MF7I5kDLjONVIZ8rrs9ztxRHHok85EDixj/VchlRyvLCKstlq6SDNo8/zqtuQJUnrZz1
         x0fLLxdPKzzaASOmxz9ZeCOooJ64KAVFQLCbInbxZiDvfaNDAJ1Qu9W+ez1WhaS73fyV
         eZgxL2FO7tiW/6dYGuLAjHTGsCtdXAVcjEKZNrNxWLZ5//JJGjDLa7XFh1NIEBCJi8Fb
         hek7jqTaubFTUsbe1VncgswSQTBrsN1erCUb1tvAbZz167O+1TK2ge841WMEQlGPkmgM
         CDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bXy4jACbThlmvCTSK/PFN6hive2FmiG2wSZiGBs8Z3s=;
        b=t8aazj0j/teoiGmV5jJ+mSdr/V+1/hBu5sNqsCYSRi3++lp6fWlbux8wa4NOJijE8c
         sR8BWdZnxDBAfRFZOxQqErv50eQ7YyjMz/mvVqnbP1au1l9DgCpAJWtX4q3aB3zioNKb
         tuYgotxRq2fLk9dF0EwqQWoMHo5sbUBsXp4S7giSkzSwPs1fXRsO3fsLHqEFXOuZbB66
         snPpDQ/FUbFOET8Y5yMlXBMtrHhRHbHlE3SKJag89QWZJMlrhzgZ4sCm1Q7nBb8dxjYg
         KIt1Py1NFJdKZh6QrlMDdZeZclbdSpzEwGO7qAGC/cxayRaHBi6twjv+uZsP3W93LKU/
         TqCQ==
X-Gm-Message-State: AKS2vOxU2CBz47jrByXNU0Klt9WAxCDYEXm++X5NDukeeL294/YKyZMx
        9wsocTECMcrAXLiwf3AjyA==
X-Received: by 10.84.133.15 with SMTP id 15mr12239859plf.291.1497926921691;
        Mon, 19 Jun 2017 19:48:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id s88sm24421372pfk.16.2017.06.19.19.48.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 14/26] diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
Date:   Mon, 19 Jun 2017 19:48:04 -0700
Message-Id: <20170620024816.20021-15-sbeller@google.com>
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
 diff.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index e56962b844..96ce53c5cf 100644
--- a/diff.c
+++ b/diff.c
@@ -573,6 +573,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_FILEPAIR,
 	DIFF_SYMBOL_HEADER,
 	DIFF_SYMBOL_BINARY_FILES,
+	DIFF_SYMBOL_REWRITE_DIFF,
 };
 /*
  * Flags for content lines:
@@ -613,7 +614,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len, unsigned flags)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set, *meta;
+	const char *context, *reset, *set, *meta, *fraginfo;
 	switch (s) {
 	case DIFF_SYMBOL_SEPARATOR:
 		fprintf(o->file, "%s%c",
@@ -694,6 +695,11 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		fprintf(o->file, "%sBinary files %s differ\n",
 			diff_line_prefix(o), line);
 		break;
+	case DIFF_SYMBOL_REWRITE_DIFF:
+		fraginfo = diff_get_color(o->use_color, DIFF_FRAGINFO);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, fraginfo, reset, line, len);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -816,17 +822,17 @@ static void remove_tempfile(void)
 	}
 }
 
-static void print_line_count(FILE *file, int count)
+static void add_line_count(struct strbuf *out, int count)
 {
 	switch (count) {
 	case 0:
-		fprintf(file, "0,0");
+		strbuf_addstr(out, "0,0");
 		break;
 	case 1:
-		fprintf(file, "1");
+		strbuf_addstr(out, "1");
 		break;
 	default:
-		fprintf(file, "1,%d", count);
+		strbuf_addf(out, "1,%d", count);
 		break;
 	}
 }
@@ -865,14 +871,12 @@ static void emit_rewrite_diff(const char *name_a,
 			      struct diff_options *o)
 {
 	int lc_a, lc_b;
-	const char *fraginfo = diff_get_color(o->use_color, DIFF_FRAGINFO);
-	const char *reset = diff_get_color(o->use_color, DIFF_RESET);
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
 	const char *a_prefix, *b_prefix;
 	char *data_one, *data_two;
 	size_t size_one, size_two;
 	struct emit_callback ecbdata;
-	const char *line_prefix = diff_line_prefix(o);
+	struct strbuf out = STRBUF_INIT;
 
 	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		a_prefix = o->b_prefix;
@@ -914,14 +918,17 @@ static void emit_rewrite_diff(const char *name_a,
 	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR, a_name.buf, a_name.len, 0);
 	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR, b_name.buf, b_name.len, 1);
 
-	fprintf(o->file, "%s%s@@ -", line_prefix, fraginfo);
+	strbuf_addstr(&out, "@@ -");
 	if (!o->irreversible_delete)
-		print_line_count(o->file, lc_a);
+		add_line_count(&out, lc_a);
 	else
-		fprintf(o->file, "?,?");
-	fprintf(o->file, " +");
-	print_line_count(o->file, lc_b);
-	fprintf(o->file, " @@%s\n", reset);
+		strbuf_addstr(&out, "?,?");
+	strbuf_addstr(&out, " +");
+	add_line_count(&out, lc_b);
+	strbuf_addstr(&out, " @@\n");
+	emit_diff_symbol(o, DIFF_SYMBOL_REWRITE_DIFF, out.buf, out.len, 0);
+	strbuf_release(&out);
+
 	if (lc_a && !o->irreversible_delete)
 		emit_rewrite_lines(&ecbdata, '-', data_one, size_one);
 	if (lc_b)
-- 
2.12.2.575.gb14f27f917

