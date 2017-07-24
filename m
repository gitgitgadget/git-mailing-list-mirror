Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821D31F89D
	for <e@80x24.org>; Mon, 24 Jul 2017 08:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbdGXIW6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 04:22:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37028 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbdGXIWw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 04:22:52 -0400
Received: by mail-wr0-f195.google.com with SMTP id 12so8846898wrb.4
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OioX9WazmyqdS+KPOYc2a3C0L05jiU/Ca9ppeZckoBk=;
        b=qfh6lJNsSMaIIDW3Zgc3kkzv1W5RZfKZjkv3F6yzOu4MGPhTtni+vwhd+NmTFckYbN
         1AqNfUgB0QGg9cztzFD2lX90hQjd5vnivScZIEZXBn7ER5bZTXyAy44jw0vmh0Mq0Ugc
         tHn/2a3ZwasB804I0DQc8TyXQyyhhLLvMaUKXxMQDLTUcEb4umNqyP5khwNTdd6NUANz
         vTR69sWd90+JEtHik/dC+6dTIZozxxVWPih7iNF+2obWcLvLMWe1lstsn3yv57G9msOJ
         LzY32Tsfd3dChER5xThtYubzhC5hesEqWuUKXVR/0+ceyeMKK3L5hMdRKA+SF21xSyXi
         m5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OioX9WazmyqdS+KPOYc2a3C0L05jiU/Ca9ppeZckoBk=;
        b=ETDMbaIxWEDhS6adwTU5OrZVIODIL6huJd0z7paRBNjIoa16KwTXXmMMrP31aFTflC
         JybLFOJfXI4CyzhSAx3+ppKRdHbDmg/4nmi2R/3Vf/K9ZQe0nUuOyiyLUZkaxRQld6We
         0wirJ3wpogvjS18P/XIY8vxb55W3ar2U4NQP5Ura5DsalYICwOtm5x1kONoWJ9n2DVF/
         2Tbbyyp+STxOpchvf7na5hU6Erb9Q8eSOUVDXLRp9AD3zFwAMfOS0/CwvrqcBbouqTaZ
         mpAGL/0g6Zx3Zx/QNURs4z60kCmabFqW9ttLBtiajYodOFE+JM4EuacegFk8HedFjN3a
         1qlQ==
X-Gm-Message-State: AIVw111bJuRRDUWTwIVJj5KGW2Lk0UJhpPEDrae2bk9L7kbfwmHFPt1s
        OQI8bxCUOSGABS27WyQ=
X-Received: by 10.223.136.44 with SMTP id d41mr14535989wrd.81.1500884570484;
        Mon, 24 Jul 2017 01:22:50 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-195-172.adsl-ull.clienti.tiscali.it. [94.39.195.172])
        by smtp.gmail.com with ESMTPSA id r129sm7911476wmg.42.2017.07.24.01.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jul 2017 01:22:49 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 3/3] interpret-trailers: add options for actions
Date:   Mon, 24 Jul 2017 10:22:45 +0200
Message-Id: <20170724082245.26496-3-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170724082044.26199-1-bonzini@gnu.org>
References: <20170724082044.26199-1-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Allow using non-default values for trailers without having to set
them up in .gitconfig first.  For example, if you have the following
configuration

     trailer.signed-off-by.where = end

you may use "--where before" when a patch author forgets his
Signed-off-by and provides it in a separate email.  Likewise for
--if-exists and --if-missing

Reverting to the behavior specified by .gitconfig is done with
--no-where, --no-if-exists and --no-if-missing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/git-interpret-trailers.txt | 23 +++++++++++
 builtin/interpret-trailers.c             | 32 ++++++++++++++++
 t/t7513-interpret-trailers.sh            | 66 ++++++++++++++++++++++++++++++++
 trailer.c                                | 27 ++++++++++---
 trailer.h                                |  7 ++++
 5 files changed, 149 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 31cdeaecd..76d5fdfaf 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -80,6 +80,29 @@ OPTIONS
 	trailer to the input messages. See the description of this
 	command.
 
+--where <placement>::
+--no-where::
+	Specify where all new trailers will be added.  A setting
+	provided with '--where' overrides all configuration variables
+	and applies to all '--trailer' options until the next occurrence of
+	'--where' or '--no-where'.
+
+--if-exists <action>::
+--no-if-exists::
+	Specify what action will be performed when there is already at
+	least one trailer with the same <token> in the message.  A setting
+	provided with '--if-exists' overrides all configuration variables
+	and applies to all '--trailer' options until the next occurrence of
+	'--if-exists' or '--no-if-exists'.
+
+--if-missing <action>::
+--no-if-missing::
+	Specify what action will be performed when there is no other
+	trailer with the same <token> in the message.  A setting
+	provided with '--if-missing' overrides all configuration variables
+	and applies to all '--trailer' options until the next occurrence of
+	'--if-missing' or '--no-if-missing'.
+
 CONFIGURATION VARIABLES
 -----------------------
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 8f38fa318..83249e3eb 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -16,6 +16,28 @@ static const char * const git_interpret_trailers_usage[] = {
 	NULL
 };
 
+static enum trailer_where where;
+static enum trailer_if_exists if_exists;
+static enum trailer_if_missing if_missing;
+
+static int option_parse_where(const struct option *opt,
+			      const char *arg, int unset)
+{
+	return trailer_set_where(&where, arg);
+}
+
+static int option_parse_if_exists(const struct option *opt,
+				  const char *arg, int unset)
+{
+	return trailer_set_if_exists(&if_exists, arg);
+}
+
+static int option_parse_if_missing(const struct option *opt,
+				   const char *arg, int unset)
+{
+	return trailer_set_if_missing(&if_missing, arg);
+}
+
 static void new_trailers_clear(struct list_head *trailers)
 {
 	struct list_head *pos, *tmp;
@@ -44,6 +66,9 @@ static int option_parse_trailer(const struct option *opt,
 
 	item = xmalloc(sizeof *item);
 	item->text = arg;
+	item->where = where;
+	item->if_exists = if_exists;
+	item->if_missing = if_missing;
 	list_add_tail(&item->list, trailers);
 	return 0;
 }
@@ -58,6 +83,13 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "in-place", &in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
 
+		OPT_CALLBACK(0, "where", NULL, N_("action"),
+			     N_("where to place the new trailer"), option_parse_where),
+		OPT_CALLBACK(0, "if-exists", NULL, N_("action"),
+			     N_("action if trailer already exists"), option_parse_if_exists),
+		OPT_CALLBACK(0, "if-missing", NULL, N_("action"),
+			     N_("action if trailer is missing"), option_parse_if_missing),
+
 		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add"), option_parse_trailer),
 		OPT_END()
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 0c6f91c43..adbdf54f8 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -681,6 +681,36 @@ test_expect_success 'using "where = before"' '
 	test_cmp expected actual
 '
 
+test_expect_success 'overriding configuration with "--where after"' '
+	git config trailer.ack.where "before" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --where after --trailer "ack: Peff" \
+		complex_message >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'using "where = before" with "--no-where"' '
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Fixes: Z
+		Acked-by= Peff
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --where after --no-where --trailer "ack: Peff" \
+		--trailer "bug: 42" complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'using "where = after"' '
 	git config trailer.ack.where "after" &&
 	cat complex_message_body >expected &&
@@ -947,6 +977,23 @@ test_expect_success 'using "ifExists = add" with "where = after"' '
 	test_cmp expected actual
 '
 
+test_expect_success 'overriding configuration with "--if-exists replace"' '
+	git config trailer.fix.key "Fixes: " &&
+	git config trailer.fix.ifExists "add" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Fixes: 22
+	EOF
+	git interpret-trailers --if-exists replace --trailer "review:" \
+		--trailer "fix=53" --trailer "fix=22" --trailer "bug: 42" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'using "ifExists = replace"' '
 	git config trailer.fix.key "Fixes: " &&
 	git config trailer.fix.ifExists "replace" &&
@@ -1026,6 +1073,25 @@ test_expect_success 'the default is "ifMissing = add"' '
 	test_cmp expected actual
 '
 
+test_expect_success 'overriding configuration with "--if-missing doNothing"' '
+	git config trailer.ifmissing "add" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Junio
+		Acked-by= Peff
+		Reviewed-by:
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --if-missing doNothing \
+		--trailer "review:" --trailer "fix=53" \
+		--trailer "cc=Linus" --trailer "ack: Junio" \
+		--trailer "fix=22" --trailer "bug: 42" --trailer "ack: Peff" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'when default "ifMissing" is "doNothing"' '
 	git config trailer.ifmissing "doNothing" &&
 	cat complex_message_body >expected &&
diff --git a/trailer.c b/trailer.c
index aed5fa1f8..ea0474236 100644
--- a/trailer.c
+++ b/trailer.c
@@ -370,7 +370,9 @@ static void process_trailers_lists(struct list_head *head,
 
 int trailer_set_where(enum trailer_where *item, const char *value)
 {
-	if (!strcasecmp("after", value))
+	if (!value)
+		*item = WHERE_DEFAULT;
+	else if (!strcasecmp("after", value))
 		*item = WHERE_AFTER;
 	else if (!strcasecmp("before", value))
 		*item = WHERE_BEFORE;
@@ -385,7 +387,9 @@ int trailer_set_where(enum trailer_where *item, const char *value)
 
 int trailer_set_if_exists(enum trailer_if_exists *item, const char *value)
 {
-	if (!strcasecmp("addIfDifferent", value))
+	if (!value)
+		*item = EXISTS_DEFAULT;
+	else if (!strcasecmp("addIfDifferent", value))
 		*item = EXISTS_ADD_IF_DIFFERENT;
 	else if (!strcasecmp("addIfDifferentNeighbor", value))
 		*item = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
@@ -402,7 +406,9 @@ int trailer_set_if_exists(enum trailer_if_exists *item, const char *value)
 
 int trailer_set_if_missing(enum trailer_if_missing *item, const char *value)
 {
-	if (!strcasecmp("doNothing", value))
+	if (!value)
+		*item = MISSING_DEFAULT;
+	else if (!strcasecmp("doNothing", value))
 		*item = MISSING_DO_NOTHING;
 	else if (!strcasecmp("add", value))
 		*item = MISSING_ADD;
@@ -659,12 +665,21 @@ static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
 }
 
 static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
-			 const struct conf_info *conf)
+			 const struct conf_info *conf,
+			 const struct new_trailer_item *new_trailer_item)
 {
 	struct arg_item *new = xcalloc(sizeof(*new), 1);
 	new->token = tok;
 	new->value = val;
 	duplicate_conf(&new->conf, conf);
+	if (new_trailer_item) {
+		if (new_trailer_item->where != WHERE_DEFAULT)
+			new->conf.where = new_trailer_item->where;
+		if (new_trailer_item->if_exists != EXISTS_DEFAULT)
+			new->conf.if_exists = new_trailer_item->if_exists;
+		if (new_trailer_item->if_missing != MISSING_DEFAULT)
+			new->conf.if_missing = new_trailer_item->if_missing;
+	}
 	list_add_tail(&new->list, arg_head);
 }
 
@@ -692,7 +707,7 @@ static void process_command_line_args(struct list_head *arg_head,
 			add_arg_item(arg_head,
 				     xstrdup(token_from_item(item, NULL)),
 				     xstrdup(""),
-				     &item->conf);
+				     &item->conf, NULL);
 	}
 
 	/* Add an arg item for each trailer on the command line */
@@ -712,7 +727,7 @@ static void process_command_line_args(struct list_head *arg_head,
 			add_arg_item(arg_head,
 				     strbuf_detach(&tok, NULL),
 				     strbuf_detach(&val, NULL),
-				     conf);
+				     conf, tr);
 		}
 	}
 
diff --git a/trailer.h b/trailer.h
index b83b249b6..973b533a1 100644
--- a/trailer.h
+++ b/trailer.h
@@ -4,12 +4,14 @@
 #include "list.h"
 
 enum trailer_where {
+	WHERE_DEFAULT,
 	WHERE_END,
 	WHERE_AFTER,
 	WHERE_BEFORE,
 	WHERE_START
 };
 enum trailer_if_exists {
+	EXISTS_DEFAULT,
 	EXISTS_ADD_IF_DIFFERENT_NEIGHBOR,
 	EXISTS_ADD_IF_DIFFERENT,
 	EXISTS_ADD,
@@ -17,6 +19,7 @@ enum trailer_if_exists {
 	EXISTS_DO_NOTHING
 };
 enum trailer_if_missing {
+	MISSING_DEFAULT,
 	MISSING_ADD,
 	MISSING_DO_NOTHING
 };
@@ -54,6 +57,10 @@ struct new_trailer_item {
 	struct list_head list;
 
 	const char *text;
+
+	enum trailer_where where;
+	enum trailer_if_exists if_exists;
+	enum trailer_if_missing if_missing;
 };
 
 void process_trailers(const char *file, int in_place, int trim_empty,
-- 
2.13.3

