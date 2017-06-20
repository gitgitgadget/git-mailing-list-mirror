Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF381FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbdFTCtH (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:49:07 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33859 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbdFTCtF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:49:05 -0400
Received: by mail-pf0-f174.google.com with SMTP id s66so62712651pfs.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vc3jDjcxVLnpGPQ7dzhsOWEnFh65ub/oZQWBSLjTVuo=;
        b=T3NMpes+UiUzlUs6Y0+1GPB9jTizgZ8zF1swQ8TWVCsaDMofleLMVjz63t+Fjo44GV
         kpusSAZ1M8IK0Wwz8Adnl7AKFJkWh6nMDWTqIulHd5TjxNStobNlPhxrYQyOHH3Cpsr0
         +a/2gY1ChD8NCQqkYft5xemujG40f30VGTeDfra1z94+uMo8Q8FwzuG5OvFngwdraBiV
         6XqhOfvfuPMzxudnhmtuCQmimxq+LJQAdy3ja0iPB3HzKnsmUlRtOfqM3/W6AU9CInPf
         VGOKNDxSPRNKDExMgd13efWRPE6Yyb/tI60PNbEj+JegkX/uCDAEu6XN+U0CB5nnIRO1
         exIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vc3jDjcxVLnpGPQ7dzhsOWEnFh65ub/oZQWBSLjTVuo=;
        b=KsKi3o++hXL+CiiUpP88RtpN9NO1iO/ehfNu4FgoxGZ1NnX9UseGOX/3/B0Xw+Xfqw
         wmVZ4jWscvxTU6mog5eGCQJHonto3YHoCKfxKURccY4OvQ0D4cqiftRuQSTdtKgl/0GN
         9vi3LgWVYJN+Z5xhrODTL5w2Ixaa+9gRyl9MLm0R+4KRY2Xmo+6fAKqKueSEm9uPzEMi
         XMUI1DJeA5q7nxlUSEIy3v1xko7HnYoJCEw5vHQtVNCvyP/dc3ko2kQ71bguXlVPAe4J
         1IFrEvPC7sQG+4pteL1gZPdVR01LAmcdmTzfa1R5DtRNBeqXaBAEuYc0zXNAeTR913+n
         UA7A==
X-Gm-Message-State: AKS2vOwxIhg4xTgUVPWxwTREka20lsqKmIGaQkQgbPW0+qf+gEwbg4+l
        ELgWd7E2sOIdVWqU
X-Received: by 10.99.0.138 with SMTP id 132mr28993551pga.30.1497926929041;
        Mon, 19 Jun 2017 19:48:49 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id k70sm23450088pfg.72.2017.06.19.19.48.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 20/26] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
Date:   Mon, 19 Jun 2017 19:48:10 -0700
Message-Id: <20170620024816.20021-21-sbeller@google.com>
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
 diff.c | 73 +++++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/diff.c b/diff.c
index 18bfc4720b..f2f7a4da79 100644
--- a/diff.c
+++ b/diff.c
@@ -592,6 +592,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_STATS_LINE,
 	DIFF_SYMBOL_WORD_DIFF,
 	DIFF_SYMBOL_STAT_SEP,
+	DIFF_SYMBOL_SUMMARY,
 };
 /*
  * Flags for content lines:
@@ -780,6 +781,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_STAT_SEP:
 		fputs(o->stat_sep, o->file);
 		break;
+	case DIFF_SYMBOL_SUMMARY:
+		emit_line(o, "", "", line, len);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -4727,67 +4731,76 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
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

