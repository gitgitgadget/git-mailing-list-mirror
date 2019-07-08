Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12FA1F461
	for <e@80x24.org>; Mon,  8 Jul 2019 16:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfGHQiI (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:38:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39827 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbfGHQiG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:38:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so17868131wrt.6
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ke93K8MCfZTOpFN6h+SvDkqgwsTG3sIHO4fNip/unDI=;
        b=Xj2yHWSWZViG8zOFJDKr+FQnRz9hFBzy4ENMBZoVcW6T43zi8EaLc7zGskNXkoSevV
         xXew2LvQYDr0QKFJ+civ0PEmdRGa3ALF3H2z2AeneprFjrVaRw6jEoaOMHlzxFW0SRy+
         oF6M5pRigfDPm2jSyax/YfBaab3KPaYSGYeLVq0nrlg6bD95DrrCglt7PWhufL/3WYDc
         8XqAw/JVvHYDnj6l9IMzq2zQYmyps+aeF7DxyGm6Gon5HI4e6nzuB+jRrBNAusgluXxN
         qXv9xumHvYLOV0z2zekDR5vK+b4kP0+v1EUbKRJDMf/1Q9a9Jz+s/Na3gC/edLQUCN9W
         ifjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ke93K8MCfZTOpFN6h+SvDkqgwsTG3sIHO4fNip/unDI=;
        b=Vu4JVuOMWPCfclMLoe5RbQ/ULl6WPwQqZtBRNmlQLcnF9oW8oC8v6SNwjW+62TKoke
         wcKI0JItSf5Epxh503L4YqJ6c68iePD3a7B5I7sPoMJFhLESw6D76jtpPYTPr6syJGoN
         xR68EI1uJEzFIAmIzM7w3HwkTtHAZXvkJ1udOUErpXA3eA/xtry6qqiUTUZn7JZ27T0p
         4Q7p19WsBo+mhAv5StDP153hUfcgFZI6DDWMZBWTNgSo5hrlu1+z2+RhZWzdKlk+/QuG
         DPDRPWy2eWa3FZZxQc6vdBH2y36sejiWSDffT3e/j09AUVBp7O5VruKudt4QSHaqI36d
         rRxg==
X-Gm-Message-State: APjAAAXgUlPb8MCAnnhmBKC9JkT+H4keBTyk1WSD5aPOoA9jqzv/xi82
        l23ohcezBkPiBaOh74oKEgOvInK0
X-Google-Smtp-Source: APXvYqwS0SD2GPHUs0PJklzAR+UbHfQl2olO7gm+S7DuD1iusHaZ0+McDpjRZTZ7EDxTlXw4hceNMA==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr20549623wrm.235.1562603883782;
        Mon, 08 Jul 2019 09:38:03 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id 66sm85893wma.11.2019.07.08.09.38.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:38:03 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 09/14] range-diff: split lines manually
Date:   Mon,  8 Jul 2019 17:33:10 +0100
Message-Id: <20190708163315.29912-10-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently range-diff uses the 'strbuf_getline()' function for doing
its line by line processing.  In a future patch we want to do parts of
that parsing using the 'parse_git_diff_header()' function.  That
function does its own line by line reading of the input, and doesn't
use strbufs.  This doesn't match with how we do the line-by-line
processing in range-diff currently.

Switch range-diff to do our own line by line parsing, so we can re-use
the 'parse_git_diff_header()' function later.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c | 68 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 9242b8975f..784fac301b 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -24,6 +24,17 @@ struct patch_util {
 	struct object_id oid;
 };
 
+static size_t find_end_of_line(char *buffer, unsigned long size)
+{
+	char *eol = memchr(buffer, '\n', size);
+
+	if (!eol)
+		return size;
+
+	*eol = '\0';
+	return eol + 1 - buffer;
+}
+
 /*
  * Reads the patches into a string list, with the `util` field being populated
  * as struct object_id (will need to be free()d).
@@ -31,10 +42,12 @@ struct patch_util {
 static int read_patches(const char *range, struct string_list *list)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	FILE *in;
-	struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
 	struct patch_util *util = NULL;
 	int in_header = 1;
+	char *line;
+	int offset, len;
+	size_t size;
 
 	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 			"--reverse", "--date-order", "--decorate=no",
@@ -54,17 +67,20 @@ static int read_patches(const char *range, struct string_list *list)
 
 	if (start_command(&cp))
 		return error_errno(_("could not start `log`"));
-	in = fdopen(cp.out, "r");
-	if (!in) {
+	if (strbuf_read(&contents, cp.out, 0) < 0) {
 		error_errno(_("could not read `log` output"));
 		finish_command(&cp);
 		return -1;
 	}
 
-	while (strbuf_getline(&line, in) != EOF) {
+	line = contents.buf;
+	size = contents.len;
+	for (offset = 0; size > 0; offset += len, size -= len, line += len) {
 		const char *p;
 
-		if (skip_prefix(line.buf, "commit ", &p)) {
+		len = find_end_of_line(line, size);
+		line[len - 1] = '\0';
+		if (skip_prefix(line, "commit ", &p)) {
 			if (util) {
 				string_list_append(list, buf.buf)->util = util;
 				strbuf_reset(&buf);
@@ -75,8 +91,7 @@ static int read_patches(const char *range, struct string_list *list)
 				free(util);
 				string_list_clear(list, 1);
 				strbuf_release(&buf);
-				strbuf_release(&line);
-				fclose(in);
+				strbuf_release(&contents);
 				finish_command(&cp);
 				return -1;
 			}
@@ -85,26 +100,28 @@ static int read_patches(const char *range, struct string_list *list)
 			continue;
 		}
 
-		if (starts_with(line.buf, "diff --git")) {
+		if (starts_with(line, "diff --git")) {
 			in_header = 0;
 			strbuf_addch(&buf, '\n');
 			if (!util->diff_offset)
 				util->diff_offset = buf.len;
 			strbuf_addch(&buf, ' ');
-			strbuf_addbuf(&buf, &line);
+			strbuf_addstr(&buf, line);
 		} else if (in_header) {
-			if (starts_with(line.buf, "Author: ")) {
-				strbuf_addbuf(&buf, &line);
+			if (starts_with(line, "Author: ")) {
+				strbuf_addstr(&buf, line);
 				strbuf_addstr(&buf, "\n\n");
-			} else if (starts_with(line.buf, "    ")) {
-				strbuf_rtrim(&line);
-				strbuf_addbuf(&buf, &line);
+			} else if (starts_with(line, "    ")) {
+				p = line + len - 2;
+				while (isspace(*p) && p >= line)
+					p--;
+				strbuf_add(&buf, line, p - line + 1);
 				strbuf_addch(&buf, '\n');
 			}
 			continue;
-		} else if (starts_with(line.buf, "@@ "))
+		} else if (starts_with(line, "@@ "))
 			strbuf_addstr(&buf, "@@");
-		else if (!line.buf[0] || starts_with(line.buf, "index "))
+		else if (!line[0] || starts_with(line, "index "))
 			/*
 			 * A completely blank (not ' \n', which is context)
 			 * line is not valid in a diff.  We skip it
@@ -117,25 +134,24 @@ static int read_patches(const char *range, struct string_list *list)
 			 * we are not interested.
 			 */
 			continue;
-		else if (line.buf[0] == '>') {
+		else if (line[0] == '>') {
 			strbuf_addch(&buf, '+');
-			strbuf_add(&buf, line.buf + 1, line.len - 1);
-		} else if (line.buf[0] == '<') {
+			strbuf_addstr(&buf, line + 1);
+		} else if (line[0] == '<') {
 			strbuf_addch(&buf, '-');
-			strbuf_add(&buf, line.buf + 1, line.len - 1);
-		} else if (line.buf[0] == '#') {
+			strbuf_addstr(&buf, line + 1);
+		} else if (line[0] == '#') {
 			strbuf_addch(&buf, ' ');
-			strbuf_add(&buf, line.buf + 1, line.len - 1);
+			strbuf_addstr(&buf, line + 1);
 		} else {
 			strbuf_addch(&buf, ' ');
-			strbuf_addbuf(&buf, &line);
+			strbuf_addstr(&buf, line);
 		}
 
 		strbuf_addch(&buf, '\n');
 		util->diffsize++;
 	}
-	fclose(in);
-	strbuf_release(&line);
+	strbuf_release(&contents);
 
 	if (util)
 		string_list_append(list, buf.buf)->util = util;
-- 
2.22.0.510.g264f2c817a

