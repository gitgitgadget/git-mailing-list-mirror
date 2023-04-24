Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186B3C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 22:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjDXWUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjDXWU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 18:20:29 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127548A52
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:25 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b99e0ffbabbso846123276.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682374825; x=1684966825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KuoeN0pAowH46l2c5tho3VSYmKzQ0EsUWMIdBTDhzDY=;
        b=z+lUu4rNanFPlU9nLHF/ugIo4lMrlotN0gDIj6QbWnmXz/M1w/gRFjXf65+oT12t4L
         FY5LaTB6ldpQuWr1Zgb3L5xQpNxuA6+XTthHOvpInNs4aOMWPpZFFxHNRtCBTeyeuNmK
         nGehgoauYj5UDwS+I4dxN8cm4UXpo0mBOR2QL2WDnO6iGguJY4/1r0+9hKHzRYkgaSOC
         4fFqm66bf92IbQoJ9L7pC28umM7KA6RfPZQTwEucb2s/I39sKQFYYzEZuBfc09jcrn0u
         qrNKi3nlrXcUY8fhBfDtEmhiqVdJbm0jSM250Xo5bDAV4NuRKhVcIbH4+gwAPcza5o+O
         Ch6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374825; x=1684966825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuoeN0pAowH46l2c5tho3VSYmKzQ0EsUWMIdBTDhzDY=;
        b=bnmKDj76p7wuLeYXrYUjDYMSBX2/ytP+jaWv4X6O0z8zJN4CQQc1bdCxcKgL2ngkTc
         EzxfVaWQfyGU1bYAdgTE02u7MhcV8cOee0Umy0u4qW7WGwBDWjTv7V0FWwKzFBw4IMdH
         rYIKbUKCCj2d/fZxc0KcPsCq1c8KsEd0kZ/5G2uRcC7JMAG7db2efUg9cplLWdU4TbTm
         om8ClYz5NTJzOBZD3MrKPkN4Ex9a9jnR1hruD/jnbYgwf3lSZdz3qvnDlKAiRPfUJwbz
         NNBLnt9sXaHu821rfP9pf2OUQyvcsoGr94W1tyfAs1axQe+CIOxucwQl5FeLTP3/Is+C
         lW7g==
X-Gm-Message-State: AAQBX9fTJhd3NULBzT0fgaEDAiov6xNRFof3C0RR1l/dByvZ4zvnC5+N
        f0+JmOiLA8wxS+yS615CjbkdA7p1r4JRcnOaIMgbXw==
X-Google-Smtp-Source: AKy350ZAbGRcwIGKXeWdxT9jBt9UcY1SuVqp+HlKxpwoN60W3Yngh2sATnJqizuOcXSnf4CbQ3Z/GA==
X-Received: by 2002:a25:aab2:0:b0:b8f:490c:a0db with SMTP id t47-20020a25aab2000000b00b8f490ca0dbmr11192454ybi.59.1682374824901;
        Mon, 24 Apr 2023 15:20:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e65-20020a25e744000000b00b7767ca749dsm3151395ybh.58.2023.04.24.15.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:20:24 -0700 (PDT)
Date:   Mon, 24 Apr 2023 18:20:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 5/6] t/helper/test-json-writer.c: avoid using `strtok()`
Message-ID: <201fcac6c41a80df78e58edd0d4dfda5f3944b8a.1682374789.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682374789.git.me@ttaylorr.com>
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
index 86887f5320..afe393f597 100644
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
+		/* break line into command and zero or more tokens */
+		string_list_setlen(&parts, 0);
+		string_list_split_in_place(&parts, line, " ", -1);
+		string_list_remove_empty_items(&parts, 0);
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
2.40.0.380.gd2df7d2365

