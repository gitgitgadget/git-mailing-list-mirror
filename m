Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34C451F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932715AbcJTVko (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:40:44 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34078 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbcJTVkI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:40:08 -0400
Received: by mail-pf0-f171.google.com with SMTP id r16so43658991pfg.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Vywvrbc6RhrIRmSnUrYFLoUATmWL8glgMaq0Rmz15n0=;
        b=j1YaVc5pmuhNL8MBSOWWoRMKZCCkItd2K64/CZ1C1W5AqBrWnblLdRpkVf24OElGHE
         gTN6F5K2hmn7C4k11s6pNEwGArZ+N0OoU/JU2SFdzHGN09YlwCLyvbx1DfDFNgIarhLp
         e8Z2qDBSfnl26lkyrbzjY15tmS21UN04zHqzev07NI2xSTO9Vpq38GgGi4uDmEOy1umw
         xX5CY1dGMFoa2OXKeyDN1MBfO3e1qMtUC8MPMpWpr4IKK+CInx8klxZm8XwyzhhY1R04
         LTDukVZ8DMjlaUNxvFYtcNEmh5KGPdX6RUJ31sWha9n6ezI9zIY/uyeCfBm3eDHzCgoP
         zn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Vywvrbc6RhrIRmSnUrYFLoUATmWL8glgMaq0Rmz15n0=;
        b=dWRyW5cb7WkgNF0d1DBI6JPFSg9oyB53GrBa539YKSOj81MA6hHpyc/nhcm7xbX2fq
         gR00ShBmIAr5A898jRlz/fqFQYr2JhiPK1kBL2bc5PmXzK4lnR9SiQYYOrNGxxM2sC+w
         MqGNbcsHhBTqpKHzsYnm3hTa7MXvo0gh1zgxu79v+NoaP7JA/CS1HYcUHZs7BxYuJolt
         owx+HGAKDAD4yT7TBo4tsREeBNrv5AauVGd4cUTYbbyoDdlvHidekBECyd/bFC2LcO+N
         b/QYAc+PKY375TL02hEhX0eRIRiqMEUBPZUJWRVnKP30xl+viwKEcAbc/DZfewq4vp0f
         ecNQ==
X-Gm-Message-State: AA6/9RlOz+Sa63wlcQDEFWbjeM7JBOzJmIFUsaETgLdR6TkEhMxnzzRsSsBMBwkkdmeYm6sB
X-Received: by 10.99.146.69 with SMTP id s5mr4193796pgn.9.1476999607169;
        Thu, 20 Oct 2016 14:40:07 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id e6sm73883890pfb.57.2016.10.20.14.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Oct 2016 14:40:06 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v4 3/8] trailer: streamline trailer item create and add
Date:   Thu, 20 Oct 2016 14:39:48 -0700
Message-Id: <c821f75f4000fc3e224b23633cce983c33b6d4d6.1476998988.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476998988.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476998988.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476998988.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, creation and addition (to a list) of trailer items are spread
across multiple functions. Streamline this by only having 2 functions:
one to parse the user-supplied string, and one to add the parsed
information to a list.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 trailer.c | 130 +++++++++++++++++++++++++++++---------------------------------
 1 file changed, 60 insertions(+), 70 deletions(-)

diff --git a/trailer.c b/trailer.c
index 4e85aae..ae3972a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -500,10 +500,31 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	return 0;
 }
 
-static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *trailer)
+static const char *token_from_item(struct trailer_item *item, char *tok)
+{
+	if (item->conf.key)
+		return item->conf.key;
+	if (tok)
+		return tok;
+	return item->conf.name;
+}
+
+static int token_matches_item(const char *tok, struct trailer_item *item, int tok_len)
+{
+	if (!strncasecmp(tok, item->conf.name, tok_len))
+		return 1;
+	return item->conf.key ? !strncasecmp(tok, item->conf.key, tok_len) : 0;
+}
+
+static int parse_trailer(struct strbuf *tok, struct strbuf *val,
+			 const struct conf_info **conf, const char *trailer)
 {
 	size_t len;
 	struct strbuf seps = STRBUF_INIT;
+	struct trailer_item *item;
+	int tok_len;
+	struct list_head *pos;
+
 	strbuf_addstr(&seps, separators);
 	strbuf_addch(&seps, '=');
 	len = strcspn(trailer, seps.buf);
@@ -523,74 +544,31 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tra
 		strbuf_addstr(tok, trailer);
 		strbuf_trim(tok);
 	}
-	return 0;
-}
-
-static const char *token_from_item(struct trailer_item *item, char *tok)
-{
-	if (item->conf.key)
-		return item->conf.key;
-	if (tok)
-		return tok;
-	return item->conf.name;
-}
-
-static struct trailer_item *new_trailer_item(struct trailer_item *conf_item,
-					     char *tok, char *val)
-{
-	struct trailer_item *new = xcalloc(sizeof(*new), 1);
-	new->value = val ? val : xstrdup("");
-
-	if (conf_item) {
-		duplicate_conf(&new->conf, &conf_item->conf);
-		new->token = xstrdup(token_from_item(conf_item, tok));
-		free(tok);
-	} else {
-		duplicate_conf(&new->conf, &default_conf_info);
-		new->token = tok;
-	}
-
-	return new;
-}
-
-static int token_matches_item(const char *tok, struct trailer_item *item, int tok_len)
-{
-	if (!strncasecmp(tok, item->conf.name, tok_len))
-		return 1;
-	return item->conf.key ? !strncasecmp(tok, item->conf.key, tok_len) : 0;
-}
-
-static struct trailer_item *create_trailer_item(const char *string)
-{
-	struct strbuf tok = STRBUF_INIT;
-	struct strbuf val = STRBUF_INIT;
-	struct trailer_item *item;
-	int tok_len;
-	struct list_head *pos;
-
-	if (parse_trailer(&tok, &val, string))
-		return NULL;
-
-	tok_len = token_len_without_separator(tok.buf, tok.len);
 
 	/* Lookup if the token matches something in the config */
+	tok_len = token_len_without_separator(tok->buf, tok->len);
+	*conf = &default_conf_info;
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct trailer_item, list);
-		if (token_matches_item(tok.buf, item, tok_len))
-			return new_trailer_item(item,
-						strbuf_detach(&tok, NULL),
-						strbuf_detach(&val, NULL));
+		if (token_matches_item(tok->buf, item, tok_len)) {
+			char *tok_buf = strbuf_detach(tok, NULL);
+			*conf = &item->conf;
+			strbuf_addstr(tok, token_from_item(item, tok_buf));
+			free(tok_buf);
+			break;
+		}
 	}
 
-	return new_trailer_item(NULL,
-				strbuf_detach(&tok, NULL),
-				strbuf_detach(&val, NULL));
+	return 0;
 }
 
-static void add_trailer_item(struct list_head *head, struct trailer_item *new)
+static void add_trailer_item(struct list_head *head, char *tok, char *val,
+			     const struct conf_info *conf)
 {
-	if (!new)
-		return;
+	struct trailer_item *new = xcalloc(sizeof(*new), 1);
+	new->token = tok;
+	new->value = val;
+	duplicate_conf(&new->conf, conf);
 	list_add_tail(&new->list, head);
 }
 
@@ -599,21 +577,28 @@ static void process_command_line_args(struct list_head *arg_head,
 {
 	struct string_list_item *tr;
 	struct trailer_item *item;
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	const struct conf_info *conf;
 	struct list_head *pos;
 
 	/* Add a trailer item for each configured trailer with a command */
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct trailer_item, list);
-		if (item->conf.command) {
-			struct trailer_item *new = new_trailer_item(item, NULL, NULL);
-			add_trailer_item(arg_head, new);
-		}
+		if (item->conf.command)
+			add_trailer_item(arg_head,
+					 xstrdup(token_from_item(item, NULL)),
+					 xstrdup(""),
+					 &item->conf);
 	}
 
 	/* Add a trailer item for each trailer on the command line */
 	for_each_string_list_item(tr, trailers) {
-		struct trailer_item *new = create_trailer_item(tr->string);
-		add_trailer_item(arg_head, new);
+		if (!parse_trailer(&tok, &val, &conf, tr->string))
+			add_trailer_item(arg_head,
+					 strbuf_detach(&tok, NULL),
+					 strbuf_detach(&val, NULL),
+					 conf);
 	}
 }
 
@@ -734,6 +719,9 @@ static int process_input_file(FILE *outfile,
 {
 	int count = 0;
 	int patch_start, trailer_start, trailer_end, i;
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
+	const struct conf_info *conf;
 
 	/* Get the line count */
 	while (lines[count])
@@ -751,10 +739,12 @@ static int process_input_file(FILE *outfile,
 
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
-		if (lines[i]->buf[0] != comment_line_char) {
-			struct trailer_item *new = create_trailer_item(lines[i]->buf);
-			add_trailer_item(head, new);
-		}
+		if (lines[i]->buf[0] != comment_line_char &&
+		    !parse_trailer(&tok, &val, &conf, lines[i]->buf))
+			add_trailer_item(head,
+					 strbuf_detach(&tok, NULL),
+					 strbuf_detach(&val, NULL),
+					 conf);
 	}
 
 	return trailer_end;
-- 
2.8.0.rc3.226.g39d4020

