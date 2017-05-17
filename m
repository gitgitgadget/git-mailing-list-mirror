Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 847AB2023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbdEQC73 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:29 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36147 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbdEQC7R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:17 -0400
Received: by mail-pg0-f41.google.com with SMTP id x64so66004694pgd.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1VYl0LKCXZhD4cm8kVbfUD9vWfWZb6QMdTIExNHn0+A=;
        b=Jrzuh5GSxcCsdSFqJPEJA5u4CRiNc8FwHJRFDfFWTbF4Z4mLAbk9llM0vO40tB6Kib
         8Osf1sGJernL4QHxOS7+8DxMlQLp5/2eH1WeDxSx7qsg4tGLf6ImA1VGvpXDt31+yXqx
         acptVsVf9keDRCFXR9Dbzb+iDztMZhwwocupmWTG617OwMA96Bt/1CeK7iiITlFbz8GG
         UdweR4gtvor7rc+4ER9/d+blCQ1CQ9I8OKiCwSShLGfmoXo5hOFhSAKorMNy8XGtfHQJ
         1F5wCcVe4KV5tg7c22FdwobfYNSAemR6dSEF31WIyiGaZXImyHp1lwZ1XvKAmlgr2p/Z
         /PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1VYl0LKCXZhD4cm8kVbfUD9vWfWZb6QMdTIExNHn0+A=;
        b=B7CCro9SmSGu6k7lAswmotKPEoPZYFtALt++0yW7cbsf9ijS4WUrWy7oUYluxSeUcP
         0+fCBxYtC8fkaVpOHL8AjxRyuNE2xY8qPW87xuNMC15ufFDN6jj4n9m8ebfokddoR0En
         RRJ0xYJqFXqIa0QYje2LzY+bZK+enJGA/zb2vo2T2wmraiiQQMZf7rVcW8hwN7RgliMF
         yNBp6T1wobQygbqlVftOXDWwjK1cGGRJMsdeYEUtY+dZsvHhVNBocG0P75ZsRWU894xx
         pkPV5yumQ9Cc+xe/f0Qb5LmFjQ+szAU15CX7tmfRyAOJB7A4/gRPGSfceZq7entLAj96
         rZJA==
X-Gm-Message-State: AODbwcChG9skIiHe+hQm3GHuLp9Rfq/s3gI76Xr/VlpJGAkgwqVZcR2m
        QjGhYDHdrkeLtaPK
X-Received: by 10.84.232.71 with SMTP id f7mr1530477pln.168.1494989951351;
        Tue, 16 May 2017 19:59:11 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id 20sm681004pfq.42.2017.05.16.19.59.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 06/20] diff.c: emit_line_0 takes parameter whether to output line prefix
Date:   Tue, 16 May 2017 19:58:43 -0700
Message-Id: <20170517025857.32320-7-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we'll make extensive use of emit_line_0, as we'd want
to funnel all output through this function such that we can add buffering
there.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 6c1886d495..25735f03d2 100644
--- a/diff.c
+++ b/diff.c
@@ -517,12 +517,13 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 }
 
 static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
-			int sign, const char *line, int len)
+			int add_line_prefix, int sign, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	FILE *file = o->file;
 
-	fputs(diff_line_prefix(o), file);
+	if (add_line_prefix)
+		fputs(diff_line_prefix(o), file);
 
 	has_trailing_newline = (len > 0 && line[len-1] == '\n');
 	if (has_trailing_newline)
@@ -549,7 +550,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, reset, 0, line, len);
+	emit_line_0(o, set, reset, 1, 0, line, len);
 }
 
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
@@ -580,13 +581,13 @@ static void emit_line_checked(const char *reset,
 	}
 
 	if (!ws)
-		emit_line_0(ecbdata->opt, set, reset, sign, line, len);
+		emit_line_0(ecbdata->opt, set, reset, 1, sign, line, len);
 	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
+		emit_line_0(ecbdata->opt, ws, reset, 1, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
+		emit_line_0(ecbdata->opt, set, reset, 1, sign, "", 0);
 		ws_check_emit(line, len, ecbdata->ws_rule,
 			      ecbdata->opt->file, set, reset, ws);
 	}
@@ -735,7 +736,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
 		putc('\n', ecb->opt->file);
-		emit_line_0(ecb->opt, context, reset, '\\',
+		emit_line_0(ecb->opt, context, reset, 1, '\\',
 			    nneof, strlen(nneof));
 	}
 }
-- 
2.13.0.18.g7d86cc8ba0

