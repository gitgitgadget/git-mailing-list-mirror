Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97055C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjDRTU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjDRTUO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:20:14 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ACBD302
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fe82d8bf5so157691157b3.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681845537; x=1684437537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9HI34V9F8AmyEowwW3Dgatr6yvmunmNRSnjftEGhn8=;
        b=DEAW5MoNT7UXYxXHSEn2abeS/PbOkkTuyztdofLTqhSyAXZOz781qgZzEqQnYi2tbr
         9cLPhDnTDMeiJkCL7ktOtr+krmQmhkqYoWHppVR4zB3ZB3WmiWESI9anrXsrcrHzzfWg
         6Oj7x/oahAtKOEQHPPkHfHnYfeSXmZbKE6ulYBl4GmHFZwbkiU0WJgyjc/4XbhChEnFS
         Yit7OinDUfIwzceDsPY0lFttf8EtaH2nA52VmE9dc97+lX813bcVmcZdf5Vqkqbb2cAE
         NcqeCSsfLR3Jb6sT3AGi0qvxT/Jv8ZmCVGD2BvVA0WaB9MBBCg1luFpwrwFJ2k5+T6g6
         z8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845537; x=1684437537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9HI34V9F8AmyEowwW3Dgatr6yvmunmNRSnjftEGhn8=;
        b=BqMLpjz20i7ZOsZQMxvTPulW7SyYg/hRk5KSNUhoaV0xVfLrKslYugKDffTfpJVMiM
         s2LckTBZVL+NYqo0mAXFQAqtqa958wsks53ZxHfge2yzmz0Jrzt3Bt6nOKgqYmrILwtZ
         7Klm37PpDaAjZysate5wGhTyrl7M0k/4eBig3UBhawKypUx8xhGhfdRSwDTzv5R94Sat
         kqYfRCVX5NC1xst8CxX1WJgQDkdd/EJRNe/PPGmu3SZyO+ACnqiNTLA4PfWsBsIWzzo4
         KzHzM5XgHyoUNXdHgQAGndqv7RAysXd+o46NkHm0B0rth8G92pEcIa0MjhZYO13y/PXQ
         ZdNg==
X-Gm-Message-State: AAQBX9ct4zybsn4tfuSgAaN0hbgtzjuY/dF/DuSfi2C6DnCL3lKk/m+b
        Tm0SRkphDg2ObxnkakAS2YdJggHjfLUpRWHeDW0qTg==
X-Google-Smtp-Source: AKy350YbAXTCF6eLCgzztw6fTpVNJRBw7TZqv2qpVTotDqZXO1ohFmOC2jOioTmnDjHOe0WSfMMujA==
X-Received: by 2002:a0d:fb01:0:b0:552:96b0:c4c0 with SMTP id l1-20020a0dfb01000000b0055296b0c4c0mr730792ywf.19.1681845537584;
        Tue, 18 Apr 2023 12:18:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bz2-20020a05690c084200b0054601a8399csm4002786ywb.119.2023.04.18.12.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:18:56 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:18:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] t/helper/test-json-writer.c: avoid using `strtok()`
Message-ID: <fc6cd23698dae1d3af43efaeb7d1ef8332367e61.1681845518.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681845518.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply similar treatment as in the previous commit to remove usage of
`strtok()` from the "oidmap" test helper.

Each of the different commands that the "json-writer" helper accepts
pops the next space-delimited token from the current line and interprets
it as a string, integer, or double (with the exception of the very first
token, which is the command itself).

To accommodate this, split the line in place by the space character, and
pass the corresponding string_list to each of the specialized `get_s()`,
`get_i()`, and `get_d()` functions.

`get_i()` and `get_d()` are thin wrappers around `get_s()` that convert
their result into the appropriate type by either calling `strtol()` or
`strtod()`, respectively. In `get_s()`, we mark the token as "consumed"
by incrementing the `consumed_nr` counter, indicating how many tokens we
have read up to that point.

Because each of these functions needs the string-list parts, the number
of tokens consumed, and the line number, these three are wrapped up in
to a struct representing the line state.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-json-writer.c | 76 +++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
index 86887f5320..af0a34aa04 100644
--- a/t/helper/test-json-writer.c
+++ b/t/helper/test-json-writer.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "json-writer.h"
+#include "string-list.h"
 
 static const char *expect_obj1 = "{\"a\":\"abc\",\"b\":42,\"c\":true}";
 static const char *expect_obj2 = "{\"a\":-1,\"b\":2147483647,\"c\":0}";
@@ -394,35 +395,41 @@ static int unit_tests(void)
 	return 0;
 }
 
-static void get_s(int line_nr, char **s_in)
+struct line {
+	struct string_list *parts;
+	size_t consumed_nr;
+	int nr;
+};
+
+static void get_s(struct line *line, char **s_in)
 {
-	*s_in = strtok(NULL, " ");
-	if (!*s_in)
-		die("line[%d]: expected: <s>", line_nr);
+	if (line->consumed_nr > line->parts->nr)
+		die("line[%d]: expected: <s>", line->nr);
+	*s_in = line->parts->items[line->consumed_nr++].string;
 }
 
-static void get_i(int line_nr, intmax_t *s_in)
+static void get_i(struct line *line, intmax_t *s_in)
 {
 	char *s;
 	char *endptr;
 
-	get_s(line_nr, &s);
+	get_s(line, &s);
 
 	*s_in = strtol(s, &endptr, 10);
 	if (*endptr || errno == ERANGE)
-		die("line[%d]: invalid integer value", line_nr);
+		die("line[%d]: invalid integer value", line->nr);
 }
 
-static void get_d(int line_nr, double *s_in)
+static void get_d(struct line *line, double *s_in)
 {
 	char *s;
 	char *endptr;
 
-	get_s(line_nr, &s);
+	get_s(line, &s);
 
 	*s_in = strtod(s, &endptr);
 	if (*endptr || errno == ERANGE)
-		die("line[%d]: invalid float value", line_nr);
+		die("line[%d]: invalid float value", line->nr);
 }
 
 static int pretty;
@@ -453,6 +460,7 @@ static char *get_trimmed_line(char *buf, int buf_size)
 
 static int scripted(void)
 {
+	struct string_list parts = STRING_LIST_INIT_NODUP;
 	struct json_writer jw = JSON_WRITER_INIT;
 	char buf[MAX_LINE_LENGTH];
 	char *line;
@@ -470,66 +478,77 @@ static int scripted(void)
 		die("expected first line to be 'object' or 'array'");
 
 	while ((line = get_trimmed_line(buf, MAX_LINE_LENGTH)) != NULL) {
+		struct line state = { 0 };
 		char *verb;
 		char *key;
 		char *s_value;
 		intmax_t i_value;
 		double d_value;
 
-		line_nr++;
+		state.parts = &parts;
+		state.nr = ++line_nr;
 
-		verb = strtok(line, " ");
+		/* see the comment in cmd__hashmap() */
+		string_list_setlen(&parts, 0);
+		/* break line into command and zero or more tokens */
+		string_list_split_in_place(&parts, line, ' ', -1);
+
+		/* ignore empty lines */
+		if (!parts.nr || !*parts.items[0].string)
+			continue;
+
+		verb = parts.items[state.consumed_nr++].string;
 
 		if (!strcmp(verb, "end")) {
 			jw_end(&jw);
 		}
 		else if (!strcmp(verb, "object-string")) {
-			get_s(line_nr, &key);
-			get_s(line_nr, &s_value);
+			get_s(&state, &key);
+			get_s(&state, &s_value);
 			jw_object_string(&jw, key, s_value);
 		}
 		else if (!strcmp(verb, "object-int")) {
-			get_s(line_nr, &key);
-			get_i(line_nr, &i_value);
+			get_s(&state, &key);
+			get_i(&state, &i_value);
 			jw_object_intmax(&jw, key, i_value);
 		}
 		else if (!strcmp(verb, "object-double")) {
-			get_s(line_nr, &key);
-			get_i(line_nr, &i_value);
-			get_d(line_nr, &d_value);
+			get_s(&state, &key);
+			get_i(&state, &i_value);
+			get_d(&state, &d_value);
 			jw_object_double(&jw, key, i_value, d_value);
 		}
 		else if (!strcmp(verb, "object-true")) {
-			get_s(line_nr, &key);
+			get_s(&state, &key);
 			jw_object_true(&jw, key);
 		}
 		else if (!strcmp(verb, "object-false")) {
-			get_s(line_nr, &key);
+			get_s(&state, &key);
 			jw_object_false(&jw, key);
 		}
 		else if (!strcmp(verb, "object-null")) {
-			get_s(line_nr, &key);
+			get_s(&state, &key);
 			jw_object_null(&jw, key);
 		}
 		else if (!strcmp(verb, "object-object")) {
-			get_s(line_nr, &key);
+			get_s(&state, &key);
 			jw_object_inline_begin_object(&jw, key);
 		}
 		else if (!strcmp(verb, "object-array")) {
-			get_s(line_nr, &key);
+			get_s(&state, &key);
 			jw_object_inline_begin_array(&jw, key);
 		}
 		else if (!strcmp(verb, "array-string")) {
-			get_s(line_nr, &s_value);
+			get_s(&state, &s_value);
 			jw_array_string(&jw, s_value);
 		}
 		else if (!strcmp(verb, "array-int")) {
-			get_i(line_nr, &i_value);
+			get_i(&state, &i_value);
 			jw_array_intmax(&jw, i_value);
 		}
 		else if (!strcmp(verb, "array-double")) {
-			get_i(line_nr, &i_value);
-			get_d(line_nr, &d_value);
+			get_i(&state, &i_value);
+			get_d(&state, &d_value);
 			jw_array_double(&jw, i_value, d_value);
 		}
 		else if (!strcmp(verb, "array-true"))
@@ -552,6 +571,7 @@ static int scripted(void)
 	printf("%s\n", jw.json.buf);
 
 	jw_release(&jw);
+	string_list_clear(&parts, 0);
 	return 0;
 }
 
-- 
2.40.0.358.g56d2318a6d

