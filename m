Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3142023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdEQC7P (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:15 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35822 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdEQC7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:09 -0400
Received: by mail-pf0-f170.google.com with SMTP id n23so84854898pfb.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RaMFnSEnKF90XRS1ji3QQT0fftEtptQnLNdwlnR85po=;
        b=U0ceyv5DIgzAGwQH5L9RGqMyXDrL2Gpc1o8AOnwUIOBSU32TL4I4t6D4GRPXLpV+Ew
         jRH0gN/lW7b+9vvEx3+cJn3yip4fwVT/OtakhN5q/vutzHWIZ4HhC4l2eQ6fUop5UiPl
         xwe8VUC5c0cTuJ4NUprt5IheNBiCurrjFmdszgUARpiFJ+OZZTW63xEPo/3KtgwyJKfJ
         cKng1AZ7JGTsAuBm5x+gXDp6la7lxWwtvDj8HWAYivLI2pifQ9ZIqWCvhN7s7U+7i+4K
         IckTtDaI9JMSBYJp77G2y4qtwerRyH43+PrH8TvkHIwS6gJ6QKjxzpXt7tuhxirDxy5Y
         qU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RaMFnSEnKF90XRS1ji3QQT0fftEtptQnLNdwlnR85po=;
        b=KDd761IStnH1TQH0E3HCYlAckIirihfkva51SmKMBpD3ud7I7l13b+v1d3HmL6JMY9
         IvxCjJyzsTJVh+Jr0fq8G+I7i8rdxCWQO4CLdYBrX7bjuZcF2IJTTReQkUPYTceEo8sL
         mxYcu9JJ4YhzhxB+4b6ZeSIjfSZoK1+twqHYDhQfVsiMOt9r8d6GlMliMgCcXOaIpCzA
         xN4hDkfB+0a2D9JS+AdudOufZFDg4/gE7YI2P3jILYkZ5lhL3T9QgPAyoxBF7w2wP0Rh
         BJb8nG2ZimD2ec9XViC0pOi2z70hHHY7N5/H/bCNQsRpVMkTm31dKG24HiG/kRLcgnQo
         n3DA==
X-Gm-Message-State: AODbwcD0FuvcV/wNNXyvq8OrMOq3ydLNQQd/kTEMTJ94l5h3WzmLK997
        Jgr0h0e2XadJCxan
X-Received: by 10.98.11.205 with SMTP id 74mr1328754pfl.214.1494989948883;
        Tue, 16 May 2017 19:59:08 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id s3sm713470pgn.29.2017.05.16.19.59.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 04/20] diff.c: teach emit_line_0 to accept sign parameter
Date:   Tue, 16 May 2017 19:58:41 -0700
Message-Id: <20170517025857.32320-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach emit_line_0 take an optional "sign" parameter specifically intended
to hold the sign of the line instead of a separate "first" parameter
representing the first character of the line to be printed.  Callers
that store the sign and line separately can use the "sign" parameter
like they used the "first" parameter previously, and callers that store
the sign and line together (or do not have a sign) no longer need to
manipulate their arguments to fit the requirements of emit_line_0.

With this patch other callers hard code the sign (which are '+', '-',
' ' and '\\') such that we do not run into unexpectedly emitting an
erroneous '\0'.

The audit of the caller revealed that the sign cannot be '\n' or '\r',
so remove that condition for trailing newline or carriage return in the
sign; the else part of the condition handles the len==0 perfectly,
so we can drop the if/else construct.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index 2f9722b382..73e55b0c10 100644
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
@@ -4833,9 +4824,11 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
-			fprintf(options->file, "%s%c",
-				diff_line_prefix(options),
-				options->line_termination);
+			char term[2];
+			term[0] = options->line_termination;
+			term[1] = '\0';
+
+			emit_line(options, NULL, NULL, term, !!term[0]);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
 				fputs(options->stat_sep, options->file);
-- 
2.13.0.18.g7d86cc8ba0

