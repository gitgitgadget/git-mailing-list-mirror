Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C539320209
	for <e@80x24.org>; Wed, 24 May 2017 21:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161185AbdEXVlj (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:41:39 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35659 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164144AbdEXVk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:40:58 -0400
Received: by mail-pf0-f177.google.com with SMTP id n23so147418189pfb.2
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JBWkBPRB9y6qFff47Mo3DriO37Q/gCYwuHf55yDMBOc=;
        b=XdS1sLc2EFdciBL5eaPB3TjOsRvDoV2GIh54cExSdG9DDBBstRdaRnPE3fDOaUvbjN
         ifNzsXh+eZ/qbNPo6AvCxceA8Ik2jKRb0QWLP0K+1AcPCuQGn6VzI5sRqryo3n/dMeAa
         p+qQNnDi4lu7z+hwK6WKbe/6llgoyso5F+to1E50O1wqKk9tMOPRBwRr74Hm0yK+55LZ
         6F+lQS77fVHAxSh/aUuOtrsmiinVloucJE+YOvhz3lvOGRVdJeU9wDoYwIA7U0KzzWJs
         jSXO4wsezE8vpScEcCuHyswdM3vwb2VicJ5mMHLTadpZaqwfgA0Vc2DXvfZYNTLtC7xm
         Y1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JBWkBPRB9y6qFff47Mo3DriO37Q/gCYwuHf55yDMBOc=;
        b=uhry8JckY33wqnO8EVJkagHCAGhh27myE2zrTHEMIn+mjtCTjUs+8J6KAohwcOipuB
         AfvYn0sUyrxZH7Yca43n3RH6J1F4QJFdsmVVHHsuVr4ojpwnzfBfdJojtwE6ApljUWbj
         eVvCTuZHyMF3q002bZX6xCp3V54GdDM24h2jvjXCbBS8l8/dROwRX0R6FYOFzEQNFCJj
         V6T8M2QKjn+cW6dIAAkTuB5MKHM4ooPyOKRKYTXMiEX3WBY+2YgU+yrVSItbFdP+/tyy
         8Mz/aK5P4MFUhIdxvQLxGpwB6KSwjrsFSpW3pOKnRBR/EYdGjgITkoKiM+kMLZ6cIDMD
         GKRw==
X-Gm-Message-State: AODbwcDaZzDOxjE+tLzyJQtwWewG7OWaqq7o01jbvrrp3xrXsejQI/jQ
        UOQHX+ChoHsdwhrJ
X-Received: by 10.99.174.5 with SMTP id q5mr643846pgf.196.1495662057982;
        Wed, 24 May 2017 14:40:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:70df:e59:d409:fbba])
        by smtp.gmail.com with ESMTPSA id 80sm9596534pfx.80.2017.05.24.14.40.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 14:40:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 14/17] diff.c: convert diff_summary to use emit_line_*
Date:   Wed, 24 May 2017 14:40:33 -0700
Message-Id: <20170524214036.29623-15-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170524214036.29623-1-sbeller@google.com>
References: <20170523024048.16879-1-sbeller@google.com/>
 <20170524214036.29623-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

This covers diff_summary.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 64 ++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/diff.c b/diff.c
index 8ebe673331..76cafde4be 100644
--- a/diff.c
+++ b/diff.c
@@ -4504,67 +4504,71 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
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
+	emit_line(opt, NULL, NULL, 1, 0, sb.buf, sb.len);
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
 		if (show_name) {
-			write_name_quoted(p->two->path, file, '\n');
+			strbuf_addch(&sb, ' ');
+			quote_c_style(p->two->path, &sb, NULL, 0);
 		}
+		emit_line_fmt(opt, NULL, NULL, 1,
+			      " mode change %06o => %06o%s\n",
+			      p->one->mode, p->two->mode,
+			      show_name ? sb.buf : "");
+		strbuf_release(&sb);
 	}
 }
 
-static void show_rename_copy(FILE *file, const char *renamecopy, struct diff_filepair *p,
-			const char *line_prefix)
+static void show_rename_copy(struct diff_options *opt, const char *renamecopy,
+		struct diff_filepair *p)
 {
 	char *names = pprint_rename(p->one->path, p->two->path);
-
-	fprintf(file, " %s %s (%d%%)\n", renamecopy, names, similarity_index(p));
+	emit_line_fmt(opt, NULL, NULL, 1, " %s %s (%d%%)\n",
+		      renamecopy, names, similarity_index(p));
 	free(names);
-	show_mode_change(file, p, 0, line_prefix);
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
+			emit_line(opt, NULL, NULL, 1, 0, sb.buf, sb.len);
 		}
-		show_mode_change(file, p, !p->score, line_prefix);
+		show_mode_change(opt, p, !p->score);
 		break;
 	}
 }
-- 
2.13.0.18.g7d86cc8ba0

