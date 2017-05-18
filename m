Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E2F201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932130AbdERTjJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:39:09 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36808 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757501AbdERTiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:00 -0400
Received: by mail-pf0-f178.google.com with SMTP id m17so28484653pfg.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ATJ86nadQZKoEGLz3OHNTXLvZCY7TZYYy84LVZTUL4=;
        b=r4CkILnZuXwG8UwqF/pSlr9Z6keFEPclaurLNgabxBu8kfHes8nb3/3pv3Vy/VSzLT
         /wDmeT8dkwPj2u2UVbWKepRKvM4LUyMvBrKzuqWEiJlQ0NI2gd+zWJzoLPW8fw4YCjs6
         GLGBoUOQlFHws9Sf9lTIj9qCNSXDmVTHzJvBxW911QkViQJ6bIEdGr+4T56Fde0XxRe1
         oukS9Zk1I3VkkgNYihamwUKkjWWNkn14G607/KI33Qe4KklA+HMHdBPNdFmQqtGwtCLs
         Zcl8hdS7YVf0wLq9DU+kB0yJy0VnVnCf6pRAWbV2n45P9FlawjoVziYqZFx2huf0eA77
         l6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ATJ86nadQZKoEGLz3OHNTXLvZCY7TZYYy84LVZTUL4=;
        b=gozrABVxs6gUZZXV+fB3LUIRIuj3H0CmoyA4PYv3G9PugNxvKAug+jLyPzigXPv5me
         WSGfyB97STBUe0YccJAyQKT2X0NsYBUAQMRKCPntQbaNLT1MhAO8Ucl4LlMALHA0sbjT
         668VmeKxUGYY1TWYi6St0hT++DPZlnW7RQG5O1XWijD3qgVV6v4hGyIS9fZ/pErwGKNi
         auHDbTi/KTKoBRUXd4JL1m6n3RYWCZWQbkZoucG5/84VNhPXF4as84DKdJR3kJBvVnMI
         sbMc56HlsELo95AD7HngovqQnPQ2/e5WHo5pIITPujuGH1wDJaKCOqHLIe2h4h05T4zj
         joiA==
X-Gm-Message-State: AODbwcAFVSR397WHEMKQFUVkEYtj/RoyVC/CVjt8IEehMNE6TNKP732M
        lXTB4YrVmZ5C0dBL
X-Received: by 10.99.1.65 with SMTP id 62mr6316062pgb.89.1495136279940;
        Thu, 18 May 2017 12:37:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id h62sm10861583pfj.0.2017.05.18.12.37.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:37:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 04/20] diff.c: teach emit_line_0 to accept sign parameter
Date:   Thu, 18 May 2017 12:37:30 -0700
Message-Id: <20170518193746.486-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach emit_line_0 take a "sign" parameter specifically intended
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

