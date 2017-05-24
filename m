Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1936020209
	for <e@80x24.org>; Wed, 24 May 2017 21:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035937AbdEXVlW (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:41:22 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36426 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163618AbdEXVlE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:41:04 -0400
Received: by mail-pf0-f178.google.com with SMTP id m17so147396505pfg.3
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0KlrDfeueUorOKlLIDeSpD944sE1gDpvRxSsOKYO33g=;
        b=ITBcDKM/h8HIggzuS9VOnIdbOwrXYVZHAoY6q8wlVlgrAXJqihVbxEFFoVreyeZ7p6
         6Srk9rOiLB8xPG6ePKUREL3tmbz4LPtG+hPfLKMvu9Rh2CuzQZa4+besWowhGBUQkCCd
         NyDjj+T8k4Qpv8E06+BLjeOvXumg/0KovkzKuPWR0ddjl7c3/474FdQIWpWxjS1ZZwgc
         MUjdpe6f0CIGO/MfyoPOUySc5zoTY/7lydbekn+3e0LTzEWObpnTqelWG73h7mdzyjhQ
         qZiQ60yJ6Ef16u/QHwJRPnGRKQbQHY+WQx5mFbBpGGmK+OMXsX7sE3L4Q82senbwNfSD
         QugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0KlrDfeueUorOKlLIDeSpD944sE1gDpvRxSsOKYO33g=;
        b=c7tZ7QYjOEcxi5zXh+EXyMN8JReO0VVayvMRKZwtFQd/Ws7F7D4tHMlTeHg9X4dKap
         R4WkTSXlNLIkX3JyIhga10ddLNKos7pJorlLvS6mofl8tY9bS7iJp2HLrslAvwegdWEC
         GzHOg8DDvmgYh6He5Zk2WU8U9g3LiigsFovthNpdnKiTi5J4eSxLNTvJyzCw3mhmxPoj
         t5+G7WlN2KQ1CPsYB4YPhdu3a8W6GQi/dg9ELCuwonhWSyuC+X7TeJqwpC+L5g2hqcjL
         ZGR5EKFqzKGknyeNC+YTTffos+5YobS9lYc9ey+lZEvENb0ePKCJcH3MDWsUjZuNe6Ir
         enzA==
X-Gm-Message-State: AODbwcCtxRBQmK9hSaiXTraHdLQ0wD7MW7VR9XZZHx0QwacOvjG8k/9U
        VaGuECXhCfmHN3iQ
X-Received: by 10.84.231.16 with SMTP id f16mr46831009plk.20.1495662053279;
        Wed, 24 May 2017 14:40:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:70df:e59:d409:fbba])
        by smtp.gmail.com with ESMTPSA id s75sm9457763pgs.54.2017.05.24.14.40.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 14:40:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 10/17] diff.c: convert emit_binary_diff_body to use emit_line_*
Date:   Wed, 24 May 2017 14:40:29 -0700
Message-Id: <20170524214036.29623-11-sbeller@google.com>
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

This covers emit_binary_diff_body.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 3357c0fca3..b5a5261a4e 100644
--- a/diff.c
+++ b/diff.c
@@ -2244,8 +2244,8 @@ static unsigned char *deflate_it(char *data,
 	return deflated;
 }
 
-static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
-				  const char *prefix)
+static void emit_binary_diff_body(struct diff_options *o,
+				  mmfile_t *one, mmfile_t *two)
 {
 	void *cp;
 	void *delta;
@@ -2274,13 +2274,12 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 	}
 
 	if (delta && delta_size < deflate_size) {
-		fprintf(file, "%sdelta %lu\n", prefix, orig_size);
+		emit_line_fmt(o, NULL, NULL, 1, "delta %lu\n", orig_size);
 		free(deflated);
 		data = delta;
 		data_size = delta_size;
-	}
-	else {
-		fprintf(file, "%sliteral %lu\n", prefix, two->size);
+	} else {
+		emit_line_fmt(o, NULL, NULL, 1, "literal %lu\n", two->size);
 		free(delta);
 		data = deflated;
 		data_size = deflate_size;
@@ -2289,8 +2288,9 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 	/* emit data encoded in base85 */
 	cp = data;
 	while (data_size) {
+		int len;
 		int bytes = (52 < data_size) ? 52 : data_size;
-		char line[70];
+		char line[71];
 		data_size -= bytes;
 		if (bytes <= 26)
 			line[0] = bytes + 'A' - 1;
@@ -2298,20 +2298,25 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 			line[0] = bytes - 26 + 'a' - 1;
 		encode_85(line + 1, cp, bytes);
 		cp = (char *) cp + bytes;
-		fprintf(file, "%s", prefix);
-		fputs(line, file);
-		fputc('\n', file);
+
+		len = strlen(line);
+		line[len++] = '\n';
+		line[len] = '\0';
+
+		emit_line(o, NULL, NULL, 1, 0, line, len);
 	}
-	fprintf(file, "%s\n", prefix);
+	emit_line(o, NULL, NULL, 1, 0, "\n", 1);
 	free(data);
 }
 
-static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two,
-			     const char *prefix)
+static void emit_binary_diff(struct diff_options *o,
+			     mmfile_t *one, mmfile_t *two)
 {
-	fprintf(file, "%sGIT binary patch\n", prefix);
-	emit_binary_diff_body(file, one, two, prefix);
-	emit_binary_diff_body(file, two, one, prefix);
+	const char *s = "GIT binary patch\n";
+	const int len = strlen(s);
+	emit_line(o, NULL, NULL, 1, 0, s, len);
+	emit_binary_diff_body(o, one, two);
+	emit_binary_diff_body(o, two, one);
 }
 
 int diff_filespec_is_binary(struct diff_filespec *one)
@@ -2498,7 +2503,7 @@ static void builtin_diff(const char *name_a,
 			  header.buf, header.len);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
-			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
+			emit_binary_diff(o, &mf1, &mf2);
 		else
 			emit_line_fmt(o, NULL, NULL, 1,
 				      "Binary files %s and %s differ\n",
-- 
2.13.0.18.g7d86cc8ba0

