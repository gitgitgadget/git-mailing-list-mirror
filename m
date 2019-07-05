Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494781F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfGERHK (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:07:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33745 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfGERHI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:07:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so10641896wru.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+EJif8SwSYXiJzxVXEsUjNUyDz7SPbpi5OkkxWedsps=;
        b=NgO5EoD94f9Z/MCCLbdkFCGSkUCx/WUSo/BzSHys6eFMZiMc2QFs3T8VTIymD2EwDn
         RneRPTGSaoR1CBbI0FbUgq4XjhF31281cLjiWT8F8SSGf6J4eC3DCo6eVvWCx6sjHiqI
         lRYXNldFKR73QtnLH4LgsYe2EnaXmpPg6gQwDnWxEtE6zjXqPhkuNR8CZ+NNjCO64buw
         dInjxNJwLhyqInfDaAE6Ro3/ku5S2zE7ix9sob/AKCub1m9Jtfc29nRL/5YfCuB3AxMj
         eONKTsuHj3nsTFCMXMkMAwJsOMbxV1Fwc4gusNUl3sVScO+GUNTCj4ZnqpYJA2lkPhPB
         hyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EJif8SwSYXiJzxVXEsUjNUyDz7SPbpi5OkkxWedsps=;
        b=BeCV3McjrtsS3HqdgNLdO2fIR9yvFDJDdQCJE7vRfPhAP4oQJ6q1Q/7fYvIKdb93Mk
         02luoDll3IqX67F9Gu5CxTS6+yqtCDUfID9O6jFKdzXYHOqwFfrjn+9/1xTxPMLmfaSq
         Xa28/RbiCmohS75+5dKBj9T89xJLpZ/Q8Ze1OoRdSRPQCP476cz1djUMGvhV3OX+xtwh
         PtXXmQiMav33w+mOhckuPB6xvBSO4jBpTqdxkMYWSjRxr+NfaWSkvMtHSMi/E0lG26+s
         M4/sUSYDoMbD5PZnxuqzpTeQIplp/wQGFyLq0oa7f6cet9f7N0cbFF0MBk2lhtwRCXOl
         JtXw==
X-Gm-Message-State: APjAAAXXtHYM1daqxyvRFSDdX+RR4+Z532XXsIylVS0qeTDrAeqn/ElQ
        dlNf9Qzew6JFLqhSbcpcB/h2Ms3U
X-Google-Smtp-Source: APXvYqxBiB1fy6CI2s4e0f3XjE1/8lXp++WMB+VCzSd9QyJ4TQopLvfNAAOYrrx21PsSdOY0UxF7/Q==
X-Received: by 2002:adf:ce82:: with SMTP id r2mr4621769wrn.223.1562346425240;
        Fri, 05 Jul 2019 10:07:05 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id u6sm9427405wml.9.2019.07.05.10.07.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:07:04 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 09/14] range-diff: split lines manually
Date:   Fri,  5 Jul 2019 18:06:25 +0100
Message-Id: <20190705170630.27500-10-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190705170630.27500-1-t.gummerer@gmail.com>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
 <20190705170630.27500-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently range-diff uses the 'strbuf_getline()' function for doing
its line by line processing.  In a future patch we want to do parts of
that parsing using the 'parse_git_header()' function, which does
requires reading parts of the input from that function, which doesn't
use strbufs.

Switch range-diff to do our own line by line parsing, so we can re-use
the parse_git_header function later.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Longer term it might be better to have both range-diff and apply code
use strbufs.  However I didn't feel it's worth making that change for
this patch series.

 range-diff.c | 69 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 9242b8975f..916afa44c0 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -24,6 +24,17 @@ struct patch_util {
 	struct object_id oid;
 };
 
+static unsigned long linelen(const char *buffer, unsigned long size)
+{
+	unsigned long len = 0;
+	while (size--) {
+		len++;
+		if (*buffer++ == '\n')
+			break;
+	}
+	return len;
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
+	struct strbuf buf = STRBUF_INIT, file = STRBUF_INIT;
 	struct patch_util *util = NULL;
 	int in_header = 1;
+	char *line;
+	int offset, len;
+	size_t size;
 
 	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 			"--reverse", "--date-order", "--decorate=no",
@@ -54,17 +67,15 @@ static int read_patches(const char *range, struct string_list *list)
 
 	if (start_command(&cp))
 		return error_errno(_("could not start `log`"));
-	in = fdopen(cp.out, "r");
-	if (!in) {
-		error_errno(_("could not read `log` output"));
-		finish_command(&cp);
-		return -1;
-	}
+	strbuf_read(&file, cp.out, 0);
 
-	while (strbuf_getline(&line, in) != EOF) {
+	line = strbuf_detach(&file, &size);
+	for (offset = 0; size > 0; offset += len, size -= len, line += len) {
 		const char *p;
 
-		if (skip_prefix(line.buf, "commit ", &p)) {
+		len = linelen(line, size);
+		line[len - 1] = '\0';
+		if (skip_prefix(line, "commit ", &p)) {
 			if (util) {
 				string_list_append(list, buf.buf)->util = util;
 				strbuf_reset(&buf);
@@ -75,8 +86,6 @@ static int read_patches(const char *range, struct string_list *list)
 				free(util);
 				string_list_clear(list, 1);
 				strbuf_release(&buf);
-				strbuf_release(&line);
-				fclose(in);
 				finish_command(&cp);
 				return -1;
 			}
@@ -85,26 +94,28 @@ static int read_patches(const char *range, struct string_list *list)
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
@@ -117,25 +128,23 @@ static int read_patches(const char *range, struct string_list *list)
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
 
 	if (util)
 		string_list_append(list, buf.buf)->util = util;
-- 
2.22.0.510.g264f2c817a

