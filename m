Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C49202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbdF3AH4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:56 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32815 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdF3AHy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:54 -0400
Received: by mail-pg0-f47.google.com with SMTP id f127so55149398pgc.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LGvK/MsH1uw+HT+9ILU0NqKNOJ/DxahuWHt/2ix5+9g=;
        b=fnPf8aSBMD6L26PptQ8HphrKawRQKtn8i8Ne3Px2HEQMp899mocWk/no55sva3mRLs
         ncTmGXdTwNxalqqmh5YUaGV4NfIEdAVH8m/4o/WP1n9exB3T4OuEy3QFbXpY/IoJTTVJ
         56Cd2Asn89c7dtHNftxqji4MXqASPXXNxAAMbTuyke9Kl+J6WIcHh8rhyoj8KXO6SbrO
         2HGWlvxtiKCRrebA7iqqW7YDO5LNKxQBYcsbPlBUbtR+P/kIMaUWNcxI+i5l57aVtMKZ
         ippHsEXO08rCfUhSbnxHkZ8/EQ0qfh1xR7Lsf4MZu8f004LigdU6s82NBlWT0SWKzec3
         kRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LGvK/MsH1uw+HT+9ILU0NqKNOJ/DxahuWHt/2ix5+9g=;
        b=CakYSEKHiswvTqpM0mQ2/TYbNEot9KoZVwJ7GRHJYTyXTh2lPjL2J2JbMLlB+4WzZ1
         eZ4KEO0TmEACleeO9ljbJg01P7LC/thlmhAaDkO1zPRqeGjhtV6zRBGOLhimA6bkPEa5
         5fCM/Tfjv2/MqhGX8p7Y3ljALTjRyyzAQhZhQ3j/Ih1H2qm2qB2K8rjOlRV/61KOhfDu
         l5gW2lJwXIdAJKQURKKzfsa41hcYQyL5YO2l+LGVxzZsPS29vsFwWsFX1PCK/bv48H97
         wuKWWHxPpASAJV1nf7VHkxS+hJfXcjHEG7y3fsodYHdtQMklpKgk8uW1eydKqICCG2Za
         snHA==
X-Gm-Message-State: AKS2vOy6stqZhz7b1GuEm1tXw1nuPySQJqQJe45GxqXV9keOhAVbCEzX
        iuut9C8YB2+iu8Hm
X-Received: by 10.99.109.201 with SMTP id i192mr17897069pgc.204.1498781268770;
        Thu, 29 Jun 2017 17:07:48 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id 197sm11399394pga.58.2017.06.29.17.07.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 20/25] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
Date:   Thu, 29 Jun 2017 17:07:05 -0700
Message-Id: <20170630000710.10601-21-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 71 ++++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/diff.c b/diff.c
index 5a9c55736d..2db0d7c0f5 100644
--- a/diff.c
+++ b/diff.c
@@ -572,6 +572,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_STATS_LINE,
 	DIFF_SYMBOL_WORD_DIFF,
 	DIFF_SYMBOL_STAT_SEP,
+	DIFF_SYMBOL_SUMMARY,
 	DIFF_SYMBOL_SUBMODULE_ADD,
 	DIFF_SYMBOL_SUBMODULE_DEL,
 	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
@@ -648,6 +649,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_SUBMODULE_ERROR:
 	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
 	case DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES:
+	case DIFF_SYMBOL_SUMMARY:
 	case DIFF_SYMBOL_STATS_LINE:
 	case DIFF_SYMBOL_BINARY_DIFF_BODY:
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
@@ -4717,67 +4719,76 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
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
2.13.0.31.g9b732c453e

