Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0821F461
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfGKQJT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33029 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfGKQJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:09:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so6968950wru.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ke93K8MCfZTOpFN6h+SvDkqgwsTG3sIHO4fNip/unDI=;
        b=R/YhK99PCrzsrshw+dPQYjHV4dzOO2AUBiG6O0+CvW5ontn8ch8luBoCZoYyLaeTvb
         5RBy6DxRt8emyP9EH91gGPFWM87Qgrj9aNJUrWRFIxRHLnjLLjIiMmtZLP/j6CB31Dxe
         8GMV44+W88dR2JsTNa51EM5lZnz2tSdIuDRS5bFEGpwMW0VmE/gckOdKM2qiv+SaaL2R
         FYO2x91k9p0vDz4MIKlCpiaVidK33D04mEdS0YqRpkyJ1myFCZYJpxeLadHXlqQp6sn9
         hEuurS2Hbv1lm/HU5MNxsepvgcuirAH5aeNLsKU6KE734g2LRqHZ7mOGWrPu7llxpTIl
         anSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ke93K8MCfZTOpFN6h+SvDkqgwsTG3sIHO4fNip/unDI=;
        b=CNRWSawayn7rCFiOwfgofrIYlJMVjKUxRriM3l/YOE+4eoEfEdyMy9eC3tjYDJJKdg
         sHANihlZNHcFQ7Q9DPqu7VbEKxS1i/g7MJNbcQy1JJZcYZyZci8A0CjtvtwIWPwwiect
         3ynCm9Ih2QdTHFDfgIOgEXFQzsbqRTfsIFc8pbVRvFYdaTpJ2oN4O2PiS956xicgowrV
         1aK4zsfw8LnmN+4+HKrocBVlKjjgcb9b4YSeDVILCq+RtCj4qx10WDr8x1BRpasL6utI
         /8WTCHawde4vUeOcDbP5XmoA4FEOHDZTylv8otinviZphDxX94xRawxOufFTquifWbld
         CbbQ==
X-Gm-Message-State: APjAAAWB4bN2AAMl7ELpbHY5knk5S/W57rBud+RUbdzCBcBq0328nlSr
        pUdi6mWs/mMnlzq9zu5FK4mlNTBSCmQ=
X-Google-Smtp-Source: APXvYqxIV6OJN50clYb5b0xmmXK/wzSGr8gHh8r+tmDIsFZEgBvSTw8D+X4GFWvTW3a64KKdWuHKhA==
X-Received: by 2002:a5d:438e:: with SMTP id i14mr2954218wrq.122.1562861354016;
        Thu, 11 Jul 2019 09:09:14 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id 17sm6192686wmx.47.2019.07.11.09.09.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:09:13 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 09/14] range-diff: split lines manually
Date:   Thu, 11 Jul 2019 17:08:46 +0100
Message-Id: <20190711160851.14380-10-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190711160851.14380-1-t.gummerer@gmail.com>
References: <20190708163315.29912-1-t.gummerer@gmail.com>
 <20190711160851.14380-1-t.gummerer@gmail.com>
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

