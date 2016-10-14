Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535D11F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 17:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754503AbcJNRiQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 13:38:16 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35936 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbcJNRiM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 13:38:12 -0400
Received: by mail-pa0-f53.google.com with SMTP id ry6so48750985pac.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xkArObchbBO+Yh4gPqCEH4H/tsbJdVFYrjEmlkXmxPg=;
        b=VKyQNr0N+TPPkpARSDSWI3hbTEokIqneG6gIHfD3ri7b6cwOkb5ThfeD5guSExaSvn
         z4SjT02t3+OUZm7+Z13gLygmk+ZJMPovYb1obXCwJbMy0GhNNA5Cz9ApKPlPK4pisWHi
         Z0hvXbISRRbGk7vr1RBtdftRuoNCJMbn8Ji1jns49QBXWgZqmcAmvvdSu9MEifOoqIY3
         LyJL1viIIe7HsS+cMt8O3q0X6Ju60r537QB6z0svnu3IcL0B/oNHEYEb5ePxp2aTSwdB
         gcIHiHcBg3vHP/ua8qJczynXG87lrHzADU8/GwCShagv6IbBE1X49VId50S0GONrQfva
         IMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xkArObchbBO+Yh4gPqCEH4H/tsbJdVFYrjEmlkXmxPg=;
        b=P7B+2/w5Rypz0wanndXYoi8U8i6FCA9dUPQcyQ6psC3ubnaWabV32v13RbTSbB5Yrl
         ihayy19tKrzMCvoiUtuaXwRvQh2bzRylceCIiL7G8VWgEhB0f8bkUbuOeAcFV0xjHstV
         y5m4FtfKUfKA6IEEKWbUy0aBl1xezqYa5b+ZfDd+yHtSfcZQlFcIYbdf3Ss9sLC3wy/8
         iIkQ6pEFac5csKljJIhaVe9ZeOqC7u+vZjL8mirYyOo9QqtJ2eirCrukifySUTU9198o
         qHQVg02osleTm5HfC6gezfqPxdrrlc6qCt+C/wgVeWraatynLV+sKzzbcNCVFFPG0hVQ
         mkbg==
X-Gm-Message-State: AA6/9RlAukpoUi67tjRdy9eQuCigqY0mykx9jwe5/HR1EXpC3t2IFLQLTr9V+bXRKETK33G+
X-Received: by 10.66.163.197 with SMTP id yk5mr10809559pab.152.1476466691523;
        Fri, 14 Oct 2016 10:38:11 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b88sm28955706pfe.72.2016.10.14.10.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Oct 2016 10:38:10 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jnareb@gmail.com
Subject: [PATCH v3 3/6] trailer: streamline trailer item create and add
Date:   Fri, 14 Oct 2016 10:38:00 -0700
Message-Id: <b09fb7693069a14d2ed9ec47545e49294ac3015e.1476466609.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476466609.git.jonathantanmy@google.com>
References: <cover.1476466609.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476466609.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476466609.git.jonathantanmy@google.com>
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
index 0afa240..54cc930 100644
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

