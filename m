Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDAF82082F
	for <e@80x24.org>; Fri, 23 Jun 2017 01:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbdFWB36 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:58 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36493 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbdFWB34 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:56 -0400
Received: by mail-pg0-f48.google.com with SMTP id u62so14978636pgb.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/JURbWtys8/d2g2OwAPotrnnJd2csbWnzyvwQbvtiSE=;
        b=cPxhL+3R3+rWf7AlBdMClaDjvWZ2VyGWPgROVBSqOyTOvg30NnUWHwhLepel1Ja8q4
         9R+wpU3j3B0oQqhXsvKUpSrV+6o3btkLj6dHLhetgFf0Xx7pghynSOFeNWDFtdlHyGWD
         q7bSgCheNuCBCLW5nja9nCZNHhd7Jke4At7s1/GJgWQznliHrqxBumaLHOOD6dCkiXGA
         V893MeCOsxvJQP3BNb5blWyrUdgjD3NNMk/iDI1msuOZXDouEhB4NDATw9q7xq5YPsfe
         178VtNEc69GvpXSc4keJNR16+kv4ArBuWOxwoXdb+JtaaZ+fm8uNRJ43eIfdtAQKxDdT
         9xRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/JURbWtys8/d2g2OwAPotrnnJd2csbWnzyvwQbvtiSE=;
        b=pgS6pFri9bdSwoxiW3RPhk7PLC3yjDg86ITFURjVWZg1NHGpYVQNS5art0RyykqC1b
         DcgR0wxhxHvEuCAynp997GpovL+5nU2hLL3dAX2bBQ92Zx2vjqlPGnu15KrHjhJbP4ra
         CpGrsAxM70wAXMCFmcJN/Ai9/jC9usHFDMFYOYcKfKnbPSeHySR8rFpQyhctqb+DsDRw
         dlwygTXpODQrtmO+ainZSUcT+AUDMDvQCfJ4/KBjSSOGotZAMUeeEWMf5iDL++InYngW
         m3qs64mQffzTuVFowxdnOFaYzjpCSmbYzdS4SN/CN9gTBShuAUQpDvxaR7HkSvMeStwi
         gqWA==
X-Gm-Message-State: AKS2vOyjK4QacgIAyuHVxLF0WwTH5kN14QFlgfEYXsGCMUr3yy3+e9Gm
        JNXrJ9z2DahLCYZC
X-Received: by 10.84.217.220 with SMTP id d28mr6317431plj.218.1498181385832;
        Thu, 22 Jun 2017 18:29:45 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id 189sm5977116pgj.67.2017.06.22.18.29.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 14/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
Date:   Thu, 22 Jun 2017 18:29:08 -0700
Message-Id: <20170623012919.28693-15-sbeller@google.com>
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
 diff.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 78cf5ad691..0314d57647 100644
--- a/diff.c
+++ b/diff.c
@@ -560,6 +560,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_REWRITE_DIFF,
 	DIFF_SYMBOL_BINARY_FILES,
 	DIFF_SYMBOL_HEADER,
 	DIFF_SYMBOL_FILEPAIR_PLUS,
@@ -614,7 +615,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len, unsigned flags)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set, *meta;
+	const char *context, *reset, *set, *meta, *fraginfo;
 	switch (s) {
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -694,6 +695,11 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_HEADER:
 		fprintf(o->file, "%s", line);
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
@@ -916,14 +920,17 @@ static void emit_rewrite_diff(const char *name_a,
 	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_PLUS,
 			 b_name.buf, b_name.len, 0);
 
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

