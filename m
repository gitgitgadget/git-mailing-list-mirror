Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8ECB201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757721AbdERTi0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:26 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36860 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757704AbdERTiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:21 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so28487235pfg.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7wt5qjSPqZqB/5x2lwm/ACFyhhqPCkQw+T1BG8kSxBE=;
        b=ERZVRtJv4IINDIc9Xq0ObQk/8E8d70eWRbikg+ufACeV55hrBZePODRxCX8QKr6uFC
         uZi4d1cnvyelxnb024Wn7Q3ZCgvpr5sI/Zj3mRtoThRBTtFwnf9QUYCABsuD/UgGRY88
         KyXVE/hv94WPTrnpnZxR6+CGiwGtzi9x2PMPlYrEQSN5i+VA97drRWmJ6WrAAlVPTvq2
         tCc3U5GfWShzBttoAbj1QJ+ThI3A0SbI6sK3gqFNR8eC+TY4DKD65Kv5K917oOX3vmgP
         AXFryeXVJn8uDgY7cy4Yra2mpIkTSLMs8j7B3K63eB/cHV3IDR6EqX6kMazMryFjvOdx
         1JJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7wt5qjSPqZqB/5x2lwm/ACFyhhqPCkQw+T1BG8kSxBE=;
        b=eMlt/4F7jpH+ahgJzvWEZETrz6mLay1ie+fEeYiRpIAtYlTWYklnoB3NGHi4TmOLLu
         KV+dc9g6u9TzINLW9sHvJVSAe5hSezfUU36O24/GT2DkBy5Z73Ge9YbiHsap+xGZt9yK
         Q5ipYLHDzYa5hBtuw4y4+DrXjRH8QkSBRLnygCD4Bn0AVh5kvmFvA9Gsw962n9wnecht
         Q9TgnWibxPskUr6kURMrT+qGfKhcFF/i4mfNU47IKCGt2tuadp+N9ceJgCI6p/EXI3VA
         6lYZQiBOcwMOQm41w/N+s0o2y2u7KtI2OiSDOZiIgo/VEE67H4mQUJPupouVr6PjCdlx
         +75w==
X-Gm-Message-State: AODbwcBdxNaEBxxLRJSs33ovJHrp4rGT2+wN2oA6tjdyYg5rdcMWeQrE
        X6DJ91akSeZTnE+0
X-Received: by 10.98.33.74 with SMTP id h71mr6216133pfh.209.1495136295000;
        Thu, 18 May 2017 12:38:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id w85sm11275646pfk.62.2017.05.18.12.38.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:38:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 17/20] diff.c: convert diff_summary to use emit_line_*
Date:   Thu, 18 May 2017 12:37:43 -0700
Message-Id: <20170518193746.486-18-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
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
---
 diff.c | 64 ++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/diff.c b/diff.c
index 774f1acdd3..0945802ebf 100644
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

