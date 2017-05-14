Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223A020188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdENEBh (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:37 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:32887 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdENEBa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:30 -0400
Received: by mail-pg0-f54.google.com with SMTP id u187so45853901pgb.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cswS5nlos7/gFyw4Q6RrusK/IGCg8zdsVmpltGk9bvs=;
        b=h36A0vlv3l3xzCMN8fYcdes1WwLKoHqk8bFDu6Nh+bNms2VmrRG2xHQTUstxgrKZF3
         tQ96zGtH719u0szCHXF4Ogk54vVCQJo1AWHHZ68lWbS6i6wrOxfwKDUu4XyfqopiYvvt
         HwuRr1aw16mmSfNxL2i+ZO/vqg7e4+wBuLjURocJHu7NZwzQtwj7M/DZdgWYGeN5ugnf
         HiDk+idEiJNynyg3rAYq0Roz51UwdMKE0EY73/EzQ1kSqnHXd5OkVVSNxQcAejglVX9O
         QgduXFMLIb33Kplit/2PZeJx2opu1dSdhJ81Gb6yot+WDMdW4sYMZHjORnAlcEToq5Pw
         emGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cswS5nlos7/gFyw4Q6RrusK/IGCg8zdsVmpltGk9bvs=;
        b=RSW2fmF56koSWdG3EC9yZkBzV/qTxwkJ7Ez0WXeaN8NBckhfIxPfUNfB4GJ1Y0gfLx
         sQXzFWQredfrgAbLkCC47bSkX46GzKKDg3+R9xCL8cmKdYozCEGcNf1hHPcrRj8ZNRoT
         NWWp1rRJniRksE59cXQiTlx9OvdG8+1qxy5ZuBOndkkxC9myk6KKq5ou7kdMbJvtht4w
         mN0I7P9MhkhXMcLpc/MFT2Rg8zx8nK6B7liIsZavXMtYi6ZcSrYZeawMUnT/EZ3Ofpev
         /UTYBvlW2C+1m04AWVS9cK97xQYsbLu9f6bAMhDarBAzxELUtCKDdo9FEThCQZmOuX1F
         35bw==
X-Gm-Message-State: AODbwcA0ypT5yQW3kTRU5IrzzRQ23a256JcXVXSbn9gnMZ1eD+Gc540h
        8kx3RdT+UurOpfZM
X-Received: by 10.99.117.26 with SMTP id q26mr11922120pgc.21.1494734489784;
        Sat, 13 May 2017 21:01:29 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id x12sm11783347pge.60.2017.05.13.21.01.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/19] diff.c: drop 'nofirst' from emit_line_0
Date:   Sat, 13 May 2017 21:01:01 -0700
Message-Id: <20170514040117.25865-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 250f79930d (diff.c: split emit_line() from the first char and the rest
of the line, 2009-09-14) we introduced the local variable 'nofirst' that
indicates if we have no first sign character. With the given implementation
we had to use an extra variable unlike reusing 'first' because the lines
first character could be '\0'.

Change the meaning of the 'first' argument to not mean the first character
of the line, but rather just containing the sign that is prepended to the
line. Refactor emit_line to not include the lines first character, but pass
the complete line as well as a '\0' sign, which now serves as an indication
not to print a sign.

With this patch other callers hard code the sign (which are '+', '-',
' ' and '\\') such that we do not run into unexpectedly emitting an
error-nous '\0'.

The audit of the caller revealed that the sign cannot be '\n' or '\r',
so remove that condition for trailing newline or carriage return in the
sign; the else part of the condition handles the len==0 perfectly,
so we can drop the if/else construct.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index c2ed605cd0..4269b8dccf 100644
--- a/diff.c
+++ b/diff.c
@@ -517,33 +517,24 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 }
 
 static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
-			int first, const char *line, int len)
+			int sign, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
-	int nofirst;
 	FILE *file = o->file;
 
 	fputs(diff_line_prefix(o), file);
 
-	if (len == 0) {
-		has_trailing_newline = (first == '\n');
-		has_trailing_carriage_return = (!has_trailing_newline &&
-						(first == '\r'));
-		nofirst = has_trailing_newline || has_trailing_carriage_return;
-	} else {
-		has_trailing_newline = (len > 0 && line[len-1] == '\n');
-		if (has_trailing_newline)
-			len--;
-		has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
-		if (has_trailing_carriage_return)
-			len--;
-		nofirst = 0;
-	}
+	has_trailing_newline = (len > 0 && line[len-1] == '\n');
+	if (has_trailing_newline)
+		len--;
+	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
+	if (has_trailing_carriage_return)
+		len--;
 
-	if (len || !nofirst) {
+	if (len || sign) {
 		fputs(set, file);
-		if (!nofirst)
-			fputc(first, file);
+		if (sign)
+			fputc(sign, file);
 		fwrite(line, len, 1, file);
 		fputs(reset, file);
 	}
@@ -556,7 +547,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, reset, 0, line, len);
 }
 
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
@@ -4822,9 +4813,12 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
-			fprintf(options->file, "%s%c",
-				diff_line_prefix(options),
-				options->line_termination);
+			char term[2];
+			term[0] = options->line_termination;
+			term[1] = '\0';
+
+			emit_line(options, NULL, NULL,
+				  term, 1);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
 				fputs(options->stat_sep, options->file);
-- 
2.13.0.18.g183880de0a

