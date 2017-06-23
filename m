Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E339520846
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754144AbdFWBaW (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:30:22 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33407 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbdFWB3y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:54 -0400
Received: by mail-pf0-f180.google.com with SMTP id e7so16608348pfk.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cPpS66Z73Cc4+pw0/vpnebLU8fU4u7JAe7DlwRNAXXA=;
        b=RNinujyHxLevrI7QZ97FJQmQoZsC9Fh6Vc9x23JrLrsdIdCnn0ShksC7cRVfCy+WgW
         e23JehHD1scN5V6lZsKJoDBI64lEvSX8mC4iQxciAZkI0IjjHk4ItCKTfIKArXPBr0GO
         1ZGV5FkrvcLSram0H9ln8YmYyLRf3UdQLORgSNBEI1GEP5Rkmfr74iSJj+X7WzZ0EJ4S
         n+LkUNLawHajeLP99GROSGF5vF7s+OUo2jx692QnqpLU5lM1KUg4FlPe3NGit+fkpRhd
         fVfe85YF6xn+o+M7vKymLFfvtW9wNNdfSpb6sYShNTb/ox/+9B+J5pBFlX6eTS+ke+aH
         6OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cPpS66Z73Cc4+pw0/vpnebLU8fU4u7JAe7DlwRNAXXA=;
        b=tIxKKfPB/x4/Cg1XncaQ4xR0HLHR5VHHt3eZVC5XLAX/rDZ1t1N50m/j/C5it7U7kx
         Ieb1pHyIooXvrgXbC5yJUKO5HYwm+STty3vW8uGzYAupQrPMzR8UyTjdCia6kYsFe0zv
         Vk5iP/9I9liPMMgG/ZdLfdS3KMkxKjyS7YN9IUIOf2ia8vCs1TFFVfGv6DZUxIdunqJU
         GeQsI3EY+vccSZUbDJYDx6kjRoe5CTO+TsWnlGyFGIHXRbOknkkG2Hiv4p7nQDene16f
         02KF6YUpSoWQutIKoEyG9cxsJbQqnx6VHiTzFTQb6tEKrCfwgfMi/4ghxN0eoIjuPlm2
         FdRg==
X-Gm-Message-State: AKS2vOyn1VCEtlpSoNahSzRvaePyQ0+M5FD0mJbu9eP7UiXDiiqPgWlm
        H279jEAFeynjD0vOEcsNcw==
X-Received: by 10.99.152.18 with SMTP id q18mr5459490pgd.91.1498181393458;
        Thu, 22 Jun 2017 18:29:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id r129sm5981685pfr.112.2017.06.22.18.29.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 20/25] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
Date:   Thu, 22 Jun 2017 18:29:14 -0700
Message-Id: <20170623012919.28693-21-sbeller@google.com>
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
 diff.c | 71 ++++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/diff.c b/diff.c
index 0ed86ba984..f9fb94b0d3 100644
--- a/diff.c
+++ b/diff.c
@@ -571,6 +571,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_STATS_LINE,
 	DIFF_SYMBOL_WORD_DIFF,
 	DIFF_SYMBOL_STAT_SEP,
+	DIFF_SYMBOL_SUMMARY,
 	DIFF_SYMBOL_SUBMODULE_ADD,
 	DIFF_SYMBOL_SUBMODULE_DEL,
 	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
@@ -647,6 +648,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_SUBMODULE_ERROR:
 	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
 	case DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES:
+	case DIFF_SYMBOL_SUMMARY:
 	case DIFF_SYMBOL_STATS_LINE:
 	case DIFF_SYMBOL_BINARY_DIFF_BODY:
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
@@ -4720,67 +4722,76 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 	}
 }
 
-static void show_file_mode_name(FILE *file, const char *newdelete, struct diff_filespec *fs)
+static void show_file_mode_name(struct diff_options *opt, const char *newdelete, struct diff_filespec *fs)
 {
+	struct strbuf sb = STRBUF_INIT;
 	if (fs->mode)
-		fprintf(file, " %s mode %06o ", newdelete, fs->mode);
+		strbuf_addf(&sb, " %s mode %06o ", newdelete, fs->mode);
 	else
-		fprintf(file, " %s ", newdelete);
-	write_name_quoted(fs->path, file, '\n');
-}
+		strbuf_addf(&sb, " %s ", newdelete);
 
+	quote_c_style(fs->path, &sb, NULL, 0);
+	strbuf_addch(&sb, '\n');
+	emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
+			 sb.buf, sb.len, 0);
+	strbuf_release(&sb);
+}
 
-static void show_mode_change(FILE *file, struct diff_filepair *p, int show_name,
-		const char *line_prefix)
+static void show_mode_change(struct diff_options *opt, struct diff_filepair *p,
+		int show_name)
 {
 	if (p->one->mode && p->two->mode && p->one->mode != p->two->mode) {
-		fprintf(file, "%s mode change %06o => %06o%c", line_prefix, p->one->mode,
-			p->two->mode, show_name ? ' ' : '\n');
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addf(&sb, " mode change %06o => %06o",
+			    p->one->mode, p->two->mode);
 		if (show_name) {
-			write_name_quoted(p->two->path, file, '\n');
+			strbuf_addch(&sb, ' ');
+			quote_c_style(p->two->path, &sb, NULL, 0);
 		}
+		emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
+				 sb.buf, sb.len, 0);
+		strbuf_release(&sb);
 	}
 }
 
-static void show_rename_copy(FILE *file, const char *renamecopy, struct diff_filepair *p,
-			const char *line_prefix)
+static void show_rename_copy(struct diff_options *opt, const char *renamecopy,
+		struct diff_filepair *p)
 {
+	struct strbuf sb = STRBUF_INIT;
 	char *names = pprint_rename(p->one->path, p->two->path);
-
-	fprintf(file, " %s %s (%d%%)\n", renamecopy, names, similarity_index(p));
+	strbuf_addf(&sb, " %s %s (%d%%)\n",
+			renamecopy, names, similarity_index(p));
 	free(names);
-	show_mode_change(file, p, 0, line_prefix);
+	emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
+				 sb.buf, sb.len, 0);
+	show_mode_change(opt, p, 0);
 }
 
 static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 {
-	FILE *file = opt->file;
-	const char *line_prefix = diff_line_prefix(opt);
-
 	switch(p->status) {
 	case DIFF_STATUS_DELETED:
-		fputs(line_prefix, file);
-		show_file_mode_name(file, "delete", p->one);
+		show_file_mode_name(opt, "delete", p->one);
 		break;
 	case DIFF_STATUS_ADDED:
-		fputs(line_prefix, file);
-		show_file_mode_name(file, "create", p->two);
+		show_file_mode_name(opt, "create", p->two);
 		break;
 	case DIFF_STATUS_COPIED:
-		fputs(line_prefix, file);
-		show_rename_copy(file, "copy", p, line_prefix);
+		show_rename_copy(opt, "copy", p);
 		break;
 	case DIFF_STATUS_RENAMED:
-		fputs(line_prefix, file);
-		show_rename_copy(file, "rename", p, line_prefix);
+		show_rename_copy(opt, "rename", p);
 		break;
 	default:
 		if (p->score) {
-			fprintf(file, "%s rewrite ", line_prefix);
-			write_name_quoted(p->two->path, file, ' ');
-			fprintf(file, "(%d%%)\n", similarity_index(p));
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addstr(&sb, " rewrite ");
+			quote_c_style(p->two->path, &sb, NULL, 0);
+			strbuf_addf(&sb, " (%d%%)\n", similarity_index(p));
+			emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
+					 sb.buf, sb.len, 0);
 		}
-		show_mode_change(file, p, !p->score, line_prefix);
+		show_mode_change(opt, p, !p->score);
 		break;
 	}
 }
-- 
2.12.2.575.gb14f27f917

