Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13232023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbdEQC7z (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:55 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34836 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752896AbdEQC7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:25 -0400
Received: by mail-pf0-f182.google.com with SMTP id n23so84856842pfb.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XlnqqfWPjrACk0l4VkS5sre+vVdig02OgDvM1GuZHOM=;
        b=b3Y339Ka2tEz+RxDaVmdL40as+R5RjYZkSv/9MRX5Xnf96Efxl5w6q7pQemzYjzcTV
         uRua4J5mT/GmwkjeX0LQRw7kcgxRF2xKA81edTlA1blgn1GPfr6LgspIIqHQxWASPrq4
         tIWj6rokUP/020omt6H53C82Nx71OClCktpi85qQXTtpElvT3y+fjjUadYplfTMHvzU1
         0lpd4zZ7suuwjl95D7onX11FUfaXBcMLgmi3wBql/lIMu5+Xc3NXlfaPDa0nG9VZqcBo
         UeIbnTwKbWt5oLHpCzJ5e1lbUW2u0SnZQf5TWTse9aYjzHAIrLWQU5yAjipd5L0DRoPX
         Jchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XlnqqfWPjrACk0l4VkS5sre+vVdig02OgDvM1GuZHOM=;
        b=dL+6zL/vQ0b/K1zHBU62GjJ3wA2KkLPcsoaHcrvP+MHzgNQWgnQnh9z3SRB7d6OkH9
         fxDMog2CkFElowrmOQJpWy/ULbGkKlzRu1Ja9anvFZGJ2H8MvyRxwAciTY4YojyRxoti
         yabm0tH2+3wtNa4H0rjJPEYSyyhJIsuefQugId22Dd1lqJ62OHKOYbIExZCrpmKz0f/x
         p4RSpIkH19DOQInrEnJwJZUhxOzIqcQ9LRNKkZaD9Vny+fyE/2mZwnlziFV8sYVuxIuN
         IItXZTtkfaVxjanNeBkA23fN6qtKPjr+b/h/jT4VK+a6ySiXWDsfBBfLLgRuK9W8hU8e
         kIEg==
X-Gm-Message-State: AODbwcCZm2+sqoiWDHhmVkDbWdwjnMJdHfMq2isQHE9H8kb68TxaY+cr
        VVz3VWC7zhj2jyBE
X-Received: by 10.98.79.210 with SMTP id f79mr1323199pfj.148.1494989959830;
        Tue, 16 May 2017 19:59:19 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id f86sm645000pfj.128.2017.05.16.19.59.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:19 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 13/20] diff.c: convert emit_binary_diff_body to use emit_line_*
Date:   Tue, 16 May 2017 19:58:50 -0700
Message-Id: <20170517025857.32320-14-sbeller@google.com>
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
function is emit_line_0.

This covers emit_binary_diff_body.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 7c8d6a5d12..2dd10fa16a 100644
--- a/diff.c
+++ b/diff.c
@@ -2240,8 +2240,8 @@ static unsigned char *deflate_it(char *data,
 	return deflated;
 }
 
-static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
-				  const char *prefix)
+static void emit_binary_diff_body(struct diff_options *o,
+				  mmfile_t *one, mmfile_t *two)
 {
 	void *cp;
 	void *delta;
@@ -2270,13 +2270,12 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
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
@@ -2285,8 +2284,9 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
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
@@ -2294,20 +2294,25 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
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
@@ -2494,7 +2499,7 @@ static void builtin_diff(const char *name_a,
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

