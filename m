Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3E4201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756551AbdERTh5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:37:57 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33314 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbdERTh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:37:56 -0400
Received: by mail-pf0-f169.google.com with SMTP id e193so28545600pfh.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=28qKEap56Wa2ijuhnMhXmnspoC8yzLs5fw6qnm4J3wg=;
        b=W/hNeTqp8LzqBBEa0xQrrqJ2oH1zHYA2YJ3Ktxxzyqv5/DKboq533Z0cIjq7ecT7Fj
         gdXZQ7V95Cql0LFL36j8i9qv8UJjzxivD2fALrpCSgMcvpRjUfuILVHyt13ISSMMJiLG
         MyefOo26KR6b2HX4Zse5zQYa/tzciVyHX6cgzceeSHucOjQUdBpUjdPYDiXEbvopW2Dw
         4WEsWMNP2ZqOuetKbwIJBacRLbQw0/juQORvkIz7dKJTSVgxZUXufPy5Vn0SaYBaAK6d
         ThubYwF1QyN2vfWl7vcRJ01BeF+JMsC68Sgqd0nl3oyjAit77O3OgP6D7DeZf3fl94Je
         4jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=28qKEap56Wa2ijuhnMhXmnspoC8yzLs5fw6qnm4J3wg=;
        b=czCILYpKhrP1c8IGM1pwkMZI7KQX9ez3y+22QeS9lF1it+oLS16xzqIljc1HrmFYIn
         jzL3vB3mk5HQYbCul3nSgp8XIAXSU+/lFLE22t92XNdahkYrUgvfmEs77vXrfq6DmGWx
         x9SgcUmH6LMyqXNjOoywk7dz+2E66LsnoTycpkijdrdBDHx8p/ciXWW2DatDdrxPcl2u
         vP6yrscLYwd/FYaktFlKQypAWOuOrPpBIdLrzR0NydoRhRvDhQgICRAJ1ysXM5bEqclH
         U+6K+VY5uhufow6DlsNzmLHFaY2W837RswVT4C23tKdpUrHxRPeZDAWgCPJzfS2DtmSh
         d2Lw==
X-Gm-Message-State: AODbwcCaPTdCNqscNkjwGA0/d83cR2yt6h7LdCyKqyeG5692QKPjZsh2
        NEfOvpfzaSbHa0ub
X-Received: by 10.99.54.7 with SMTP id d7mr6163548pga.24.1495136275261;
        Thu, 18 May 2017 12:37:55 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id q9sm10613604pfg.77.2017.05.18.12.37.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:37:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 00/20] Diff machine: highlight moved lines.
Date:   Thu, 18 May 2017 12:37:26 -0700
Message-Id: <20170518193746.486-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:
* see interdiff below.
* fixing one invalid computation (Thanks Junio!)
* I reasoned more about submodule and word diffing, see the commit message
  of the last patch:
  
    A note on the options '--submodule=diff' and '--color-words/--word-diff':
    In the conversion to use emit_line in the prior patches both submodules
    as well as word diff output carefully chose to call emit_line with sign=0.
    All output with sign=0 is ignored for move detection purposes in this
    patch, such that no weird looking output will be generated for these
    cases. This leads to another thought: We could pass on '--color-moved' to
    submodules such that they color up moved lines for themselves. If we'd do
    so only line moves within a repository boundary are marked up.

* better name for emit_line outside of diff.[ch]

v2:
* emit_line now takes an argument that indicates if we want it
  to emit the line prefix as well. This should allow for a more faithful
  refactoring in the beginning. (Thanks Jonathan!)
* fixed memleaks (Thanks Brandon!)
* "git -c color.moved=true log -p" works now! (Thanks Jeff)
* interdiff below, though it is large.
* less intrusive than v1 (Thanks Jonathan!)

v1:

For details on *why* see the commit message of the last commit.

The first five patches are slight refactorings to get into good
shape, the next patches are funneling all output through emit_line_*.

The second last patch introduces an option to buffer up all output
before printing, and then the last patch can color up moved lines
of code.

Any feedback welcome.

Thanks,
Stefan

Stefan Beller (20):
  diff: readability fix
  diff: move line ending check into emit_hunk_header
  diff.c: factor out diff_flush_patch_all_file_pairs
  diff.c: teach emit_line_0 to accept sign parameter
  diff.c: emit_line_0 can handle no color setting
  diff.c: emit_line_0 takes parameter whether to output line prefix
  diff.c: inline emit_line_0 into emit_line
  diff.c: convert fn_out_consume to use emit_line
  diff.c: convert builtin_diff to use emit_line_*
  diff.c: convert emit_rewrite_diff to use emit_line_*
  diff.c: convert emit_rewrite_lines to use emit_line_*
  submodule.c: convert show_submodule_summary to use emit_line_fmt
  diff.c: convert emit_binary_diff_body to use emit_line_*
  diff.c: convert show_stats to use emit_line_*
  diff.c: convert word diffing to use emit_line_*
  diff.c: convert diff_flush to use emit_line_*
  diff.c: convert diff_summary to use emit_line_*
  diff.c: emit_line includes whitespace highlighting
  diff: buffer all output if asked to
  diff.c: color moved lines differently

 Documentation/config.txt   |  14 +-
 diff.c                     | 849 +++++++++++++++++++++++++++++++++------------
 diff.h                     |  59 +++-
 submodule.c                |  87 ++---
 submodule.h                |   9 +-
 t/t4015-diff-whitespace.sh | 229 ++++++++++++
 6 files changed, 969 insertions(+), 278 deletions(-)

diff --git a/diff.c b/diff.c
index 15cf322b50..451cab2875 100644
--- a/diff.c
+++ b/diff.c
@@ -840,6 +840,12 @@ void emit_line_fmt(struct diff_options *o,
 	strbuf_release(&sb);
 }
 
+void diff_emit_line(struct diff_options *o, const char *set, const char *reset,
+		    const char *line, int len)
+{
+	emit_line(o, set, reset, 1, 0, 0, line, len);
+}
+
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
@@ -1009,12 +1015,10 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		if (endp)
 			len = endp - data + 1;
 		else {
-			while (0 < size) {
-				strbuf_addch(&sb, *data);
-				size -= len;
-				data += len;
-			}
+			strbuf_add(&sb, data, size);
 			strbuf_addch(&sb, '\n');
+			size = 0; /* to exit the loop. */
+
 			data = sb.buf;
 			len = sb.len;
 		}
diff --git a/diff.h b/diff.h
index b8b2a33ccc..2d86e3a012 100644
--- a/diff.h
+++ b/diff.h
@@ -234,10 +234,8 @@ struct diff_options {
 	struct hashmap *added_lines;
 };
 
-void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
-		   int add_line_prefix, const char *fmt, ...);
-void emit_line(struct diff_options *o, const char *set, const char *reset,
-	       int add_line_prefix, int markup_ws, int sign, const char *line, int len);
+void diff_emit_line(struct diff_options *o, const char *set, const char *reset,
+		    const char *line, int len);
 
 enum color_diff {
 	DIFF_RESET = 0,
diff --git a/submodule.c b/submodule.c
index 868f913971..19c63197fb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -378,9 +378,9 @@ static void print_submodule_summary(struct rev_info *rev,
 		format_commit_message(commit, format, &sb, &ctx);
 		strbuf_addch(&sb, '\n');
 		if (commit->object.flags & SYMMETRIC_LEFT)
-			emit_line(o, del, reset, 1, 0, 0, sb.buf, sb.len);
+			diff_emit_line(o, del, reset, sb.buf, sb.len);
 		else if (add)
-			emit_line(o, add, reset, 1, 0, 0, sb.buf, sb.len);
+			diff_emit_line(o, add, reset, sb.buf, sb.len);
 	}
 	strbuf_release(&sb);
 }
@@ -418,12 +418,17 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 	struct strbuf sb = STRBUF_INIT;
 	int fast_forward = 0, fast_backward = 0;
 
-	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-		emit_line_fmt(o, NULL, NULL, 1,
-			      "Submodule %s contains untracked content\n", path);
-	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-		emit_line_fmt(o, NULL, NULL, 1,
-			      "Submodule %s contains modified content\n", path);
+	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) {
+		strbuf_addf(&sb, "Submodule %s contains untracked content\n", path);
+		diff_emit_line(o, NULL, NULL, sb.buf, sb.len);
+		strbuf_reset(&sb);
+	}
+
+	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
+		strbuf_addf(&sb, "Submodule %s contains modified content\n", path);
+		diff_emit_line(o, NULL, NULL, sb.buf, sb.len);
+		strbuf_reset(&sb);
+	}
 
 	if (is_null_oid(one))
 		message = "(new submodule)";
@@ -473,7 +478,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 		strbuf_addf(&sb, " %s\n", message);
 	else
 		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");
-	emit_line(o, meta, reset, 1, 0, 0, sb.buf, sb.len);
+	diff_emit_line(o, meta, reset, sb.buf, sb.len);
 
 	strbuf_release(&sb);
 }
@@ -501,7 +506,7 @@ void show_submodule_summary(struct diff_options *o, const char *path,
 	/* Treat revision walker failure the same as missing commits */
 	if (prepare_submodule_summary(&rev, path, left, right, merge_bases)) {
 		const char *error = "(revision walker failed)\n";
-		emit_line(o, NULL, NULL, 1, 0, 0, error, strlen(error));
+		diff_emit_line(o, NULL, NULL, error, strlen(error));
 		goto out;
 	}
 
@@ -570,15 +575,15 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	prepare_submodule_repo_env(&cp.env_array);
 	if (start_command(&cp)) {
 		const char *error = "(diff failed)\n";
-		emit_line(o, NULL, NULL, 1, 0, 0, error, strlen(error));
+		diff_emit_line(o, NULL, NULL, error, strlen(error));
 	}
 
 	while (strbuf_getwholeline_fd(&sb, cp.out, '\n') != EOF)
-		emit_line(o, NULL, NULL, 1, 0, 0, sb.buf, sb.len);
+		diff_emit_line(o, NULL, NULL, sb.buf, sb.len);
 
 	if (finish_command(&cp)) {
 		const char *error = "(diff failed)\n";
-		emit_line(o, NULL, NULL, 1, 0, 0, error, strlen(error));
+		diff_emit_line(o, NULL, NULL, error, strlen(error));
 	}
 
 done:

