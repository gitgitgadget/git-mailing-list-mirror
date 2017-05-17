Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AA22023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbdEQC7b (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:31 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34817 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdEQC7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:15 -0400
Received: by mail-pf0-f177.google.com with SMTP id n23so84855920pfb.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DUmtSBfQjYYEbs580pwMpvoMQloirfoICyAluAabTsY=;
        b=itC0nNfO3dqX2rLbdARr8CGl0zn5qxzqOfxrpDiEuqs5fh6nzr2FWFJcdiXMqGSqEn
         IhZ5MGoZdxTEGKWNcq8wIlScKo8Ouo8oKYaUVgu9LeRLOAMrWzzvZJEciTsDvnZvyfDN
         2WQKuOSpPHlfpJOJDWCj1B3RkNN6TFydXoAwgN3DYQqT50RP1lpdVMsVdZNT+aOem9zQ
         3pVQaa5SrArmmCEy2xHtQNI2zCNK+Lv4T5FLVDl/+EihR2Z7ut+AEem6srP+k9CKXcpQ
         Q0Ss5MjC/0kIq2ZAIBhMro/PinudrzMkioKBisw7YA0hJJmxaWB4/cfJcbcFPlR7dNjn
         7YJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DUmtSBfQjYYEbs580pwMpvoMQloirfoICyAluAabTsY=;
        b=AxA+iSWS4MfO2yBATF/3ukhsI54UWzgIl0HBUtd8oyIGbrMeM7KTggn/AfQ7EjIWSk
         /G98gO8ihf2MnfXv8QyKT4gFX4amu1iKAYe3mIgOkX2BHKhE6SB/WMTCeiVbGOptZcr4
         y5RteeD42RDaSGL2frdq7p669NVf7M9ofcKpvNeMClL86cO37YGrBcVhB9/3camCr2Wo
         xUDGXaXx3mt7WZs7oXYkObFbOmFJ/ATVW1EJxJHx36yFXv6+zGqKgVKJER/bKvte+nRY
         gRsFgZvPKEZxefwpfXEbr4op5rdEusu3yJvCZ+cPRZhWc5Ilw0pU9nctUQgzvRgB8UlG
         qjSw==
X-Gm-Message-State: AODbwcAVj3MGDHamvgS5QNShu22ARxch4od1iYnLPy12rZ5ndgnIQXYh
        GUFi+R5kqUlSXg13
X-Received: by 10.98.59.2 with SMTP id i2mr1334955pfa.50.1494989954107;
        Tue, 16 May 2017 19:59:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id x80sm649178pff.105.2017.05.16.19.59.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 08/20] diff.c: convert fn_out_consume to use emit_line
Date:   Tue, 16 May 2017 19:58:45 -0700
Message-Id: <20170517025857.32320-9-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
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
function is emit_line.

This covers the parts of fn_out_consume.  In the next
patches we'll convert more functions that want to emit
formatted output, so we'd want to have a formatted emit
function. Add it here.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 3569857818..8186289734 100644
--- a/diff.c
+++ b/diff.c
@@ -547,6 +547,21 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 		fputc('\n', file);
 }
 
+static void emit_line_fmt(struct diff_options *o,
+			  const char *set, const char *reset,
+			  int add_line_prefix,
+			  const char *fmt, ...)
+{
+	struct strbuf sb = STRBUF_INIT;
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	va_end(ap);
+
+	emit_line(o, set, reset, add_line_prefix, 0, sb.buf, sb.len);
+	strbuf_release(&sb);
+}
+
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
@@ -1270,7 +1285,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
-	const char *line_prefix = diff_line_prefix(o);
 
 	o->found_changes = 1;
 
@@ -1282,14 +1296,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
 	if (ecbdata->label_path[0]) {
 		const char *name_a_tab, *name_b_tab;
-
 		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
-
-		fprintf(o->file, "%s%s--- %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
-		fprintf(o->file, "%s%s+++ %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
+		emit_line_fmt(o, meta, reset, 1, "--- %s%s\n",
+			      ecbdata->label_path[0], name_a_tab);
+		emit_line_fmt(o, meta, reset, 1, "+++ %s%s\n",
+			      ecbdata->label_path[1], name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
@@ -1330,7 +1342,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
 			emit_line(o, context, reset, 1, 0, line, len);
-			fputs("~\n", o->file);
+			emit_line(o, NULL, NULL, 0, 0, "~\n", 2);
 		} else {
 			/*
 			 * Skip the prefix character, if any.  With
-- 
2.13.0.18.g7d86cc8ba0

