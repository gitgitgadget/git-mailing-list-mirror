Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7BC21FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdFTCsn (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:43 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35889 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFTCsi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:38 -0400
Received: by mail-pf0-f177.google.com with SMTP id x63so62652130pff.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HAM03l5vgXK9K/02DS5/DmJH5OVcaX90zKdWyoj/z2c=;
        b=MntDcLJc3e0C3UPUvA6kYBXaUruy93bYe9/0e4ABHHtb8PsMtEhuEzD26LFNnP9jUK
         ZhtnTjKkJxGm/zLzYLtxhHmal7xeL7EqJaJMGNzWJZ/bQfExl8cmX6cDxUAJ1Z0s8F3r
         KDzbJshh5FFCEqiTXib8BGJ+C1ArFSdVE+0b/rshqH0bUxHHlZ9A2cWtyPIPVMpPRB/1
         WB95DHMCyI45aOwjsvHHIR/rW3FKZpE/JefdC+yLp8V7hAsLPx5d9RgMEj2L9Ytqkmvk
         V0odIjO7RrIYMbpZ+iDyc7bUfieNkYylXNltyOg2S1pTPJ99v2qfngv2vl4q/MEQP87Y
         3d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HAM03l5vgXK9K/02DS5/DmJH5OVcaX90zKdWyoj/z2c=;
        b=mP5k51zHbehe78bxyNQ39RagrVYPiYU6aukmQlGu2l9SyXlbPPJzikQBanlgwXxGfH
         4dTLGvMMsnxfv7gFUxlDD8q7rDiIwnSsqiODzJ5D0FaOrZ2F2/AKt4ZqCMbZV2jcNCgy
         5CLIBVtf2Hy6jAv3LBFyRSoSPt7uu6uIEmqtdPoawmomMO/JKef+bzSC/5mNGVrlImtT
         Nd0pn9iotn9LT9ztFsUwly9BNWvcFfa9kS7pCy0wpMbZ2pumjtl30nItsF9UB9iruOu9
         iDBk/zaacXXWnPIxzyehQeohBHA1KjyM1Hb2ugzBNkFZ2EXXeJY3hCIdD8IXKQQ7LQT4
         U+7g==
X-Gm-Message-State: AKS2vOwluUWGjR7a+FYk34wuOq3EXuCe+PYiIFCaX3dU2Rvq4zYKkskM
        032C9+A3RqZaqOmK
X-Received: by 10.98.65.215 with SMTP id g84mr28639537pfd.204.1497926918053;
        Mon, 19 Jun 2017 19:48:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id p23sm25018751pfi.52.2017.06.19.19.48.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 11/26] diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR
Date:   Mon, 19 Jun 2017 19:48:01 -0700
Message-Id: <20170620024816.20021-12-sbeller@google.com>
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
 diff.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/diff.c b/diff.c
index e6029e8213..7c56150b56 100644
--- a/diff.c
+++ b/diff.c
@@ -570,6 +570,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_MINUS,
 	DIFF_SYMBOL_WORDS_PORCELAIN,
 	DIFF_SYMBOL_WORDS,
+	DIFF_SYMBOL_FILEPAIR,
 };
 /*
  * Flags for content lines:
@@ -610,7 +611,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len, unsigned flags)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set;
+	const char *context, *reset, *set, *meta;
 	switch (s) {
 	case DIFF_SYMBOL_SEPARATOR:
 		fprintf(o->file, "%s%c",
@@ -676,6 +677,14 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		}
 		emit_line(o, context, reset, line, len);
 		break;
+	case DIFF_SYMBOL_FILEPAIR:
+		meta = diff_get_color_opt(o, DIFF_METAINFO);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		fprintf(o->file, "%s%s%s%s%s%s\n", diff_line_prefix(o), meta,
+			flags ? "+++ " : "--- ",
+			line, reset,
+			strchr(line, ' ') ? "\t" : "");
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -847,8 +856,6 @@ static void emit_rewrite_diff(const char *name_a,
 			      struct diff_options *o)
 {
 	int lc_a, lc_b;
-	const char *name_a_tab, *name_b_tab;
-	const char *metainfo = diff_get_color(o->use_color, DIFF_METAINFO);
 	const char *fraginfo = diff_get_color(o->use_color, DIFF_FRAGINFO);
 	const char *reset = diff_get_color(o->use_color, DIFF_RESET);
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
@@ -868,8 +875,6 @@ static void emit_rewrite_diff(const char *name_a,
 
 	name_a += (*name_a == '/');
 	name_b += (*name_b == '/');
-	name_a_tab = strchr(name_a, ' ') ? "\t" : "";
-	name_b_tab = strchr(name_b, ' ') ? "\t" : "";
 
 	strbuf_reset(&a_name);
 	strbuf_reset(&b_name);
@@ -896,11 +901,11 @@ static void emit_rewrite_diff(const char *name_a,
 
 	lc_a = count_lines(data_one, size_one);
 	lc_b = count_lines(data_two, size_two);
-	fprintf(o->file,
-		"%s%s--- %s%s%s\n%s%s+++ %s%s%s\n%s%s@@ -",
-		line_prefix, metainfo, a_name.buf, name_a_tab, reset,
-		line_prefix, metainfo, b_name.buf, name_b_tab, reset,
-		line_prefix, fraginfo);
+
+	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR, a_name.buf, a_name.len, 0);
+	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR, b_name.buf, b_name.len, 1);
+
+	fprintf(o->file, "%s%s@@ -", line_prefix, fraginfo);
 	if (!o->irreversible_delete)
 		print_line_count(o->file, lc_a);
 	else
@@ -1369,10 +1374,8 @@ static void find_lno(const char *line, struct emit_callback *ecbdata)
 static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	struct emit_callback *ecbdata = priv;
-	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
-	const char *line_prefix = diff_line_prefix(o);
 
 	o->found_changes = 1;
 
@@ -1383,15 +1386,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 
 	if (ecbdata->label_path[0]) {
-		const char *name_a_tab, *name_b_tab;
-
-		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
-		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
-
-		fprintf(o->file, "%s%s--- %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
-		fprintf(o->file, "%s%s+++ %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
+		emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR,
+				 ecbdata->label_path[0],
+				 strlen(ecbdata->label_path[0]), 0);
+		emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR,
+				 ecbdata->label_path[1],
+				 strlen(ecbdata->label_path[1]), 1);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
-- 
2.12.2.575.gb14f27f917

