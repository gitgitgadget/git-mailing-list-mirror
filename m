Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125F7201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757712AbdERTiV (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:21 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34768 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757689AbdERTiK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:10 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so28528629pfj.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z2sYcJZ7QYS/8lkxP588GIOjbcygEKbGQm/4vtHXFJ8=;
        b=tnA0e1enHm8Vjy4Y0/SuNalfu9FhI1oYgvx8tcBg/551mczRxEQ5J2LGLSNJ8tBiR3
         YqpmBrv2Ksjqcwa40QTK4vE4oGpGKDWJHXpyhR8GX1jnqI76T8aKR/kNtvs3q85MPUu8
         OCPfQxNfaNbym7/DgBklvDiNXzGkUvF8InzTWZyKtY+jH/h78deIpDSFiGLo+TrRVp3F
         7Ypya+yFKuQ5ImzY07VBwmiYAEegZtA8E97h3cSF+iH3pFzO8KXDFP9aaXiCJSb3EM0i
         tYhWz0B3WiMziH7l56jQxYXCjIp4tpex6liOPj1egNiHh4x7SVmh/ZfL022A8J05V8h3
         X3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z2sYcJZ7QYS/8lkxP588GIOjbcygEKbGQm/4vtHXFJ8=;
        b=dKuLFI7SMGG+XodgQv7HuMhkkBW3XhJfdcjwwh0FNIJXPeHCFg74draCq+hv7QZp2B
         F9a3FMiKjaZog3QSrS91xtcbvdY19OB5JOHaqNTgMFJyDWMAR/uqQ8K9rsxRtorsjepo
         MicLV+O6dX1/XwEQUqGPkRLyX7cvdmsbTfBCjeVqunwyH5Pyq/jN3eHpnLbJjRUkm9Qy
         /wZRYZF6U+cRze5OpkpSe9uweoFrVIlmtO8OfT+8zk/HzkfLnCG7LMEIcD0Fq2sTmMaI
         guDMujm4IJj9Bhg4R3vc5AlhzyZ5MRLp10whzZhFHHZsNdFcrJ9hqVTshsFqjlcvuXsv
         ppxg==
X-Gm-Message-State: AODbwcAaRchcKgvO0e5Vrt5IH5HA6duYfyC4MYqtYPYxx5V5pvN5ZCZR
        k71wTWcsPbZtV+bK
X-Received: by 10.99.114.67 with SMTP id c3mr6306354pgn.67.1495136289994;
        Thu, 18 May 2017 12:38:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id r73sm10294395pfa.65.2017.05.18.12.38.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:38:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 13/20] diff.c: convert emit_binary_diff_body to use emit_line_*
Date:   Thu, 18 May 2017 12:37:39 -0700
Message-Id: <20170518193746.486-14-sbeller@google.com>
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

This covers emit_binary_diff_body.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 2950455e49..126038696d 100644
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

