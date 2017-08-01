Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C5E20899
	for <e@80x24.org>; Tue,  1 Aug 2017 09:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbdHAJDq (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 05:03:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33843 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbdHAJDm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 05:03:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id x64so2032284wmg.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1qGTuRXWLSSIsmHUgCw4bXjeajtoLBreH+57/cNLeDM=;
        b=E+GGifcMCkYQ9eiH0O3JFFygsR1yKU8mITuW/5aO9mNP1x+EJIQuNY5sAa5N4a1Nho
         33rEh3kU7BW0c3/rx3qNkHiCE1QAbTd/eDeZUIbv/FLYTtaS9HDdUbJTRGGm2erTyWhS
         wSjVtAcXyUVf6MBh14X1IAm6z58q0OtZx5avGfMFLuk+XkVcFVMVBizS0tsylG30nOwJ
         T2xZLVhRA0uPlT8zr8sEQWX6daQj/zzG8lEHRuxIj+sArNbp0Fq7K5KnaFYItME+tQhI
         Cmm+KsoTg7ZhfkB3PjUYtHuQt6xubQILGXdGIirjK7f/5Z2u+WuIvmJZ+SLy2uDJQiS5
         rHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=1qGTuRXWLSSIsmHUgCw4bXjeajtoLBreH+57/cNLeDM=;
        b=AKnAZleP4nYDvbr0I7RAR9r/zAFNO7QFLdmf7qtQb0hT9cVp2p7plX8B9Ex3dgR7vI
         9k9slBCEfqN8EggECT+S30pUzHhTvOl+f3Q5UWfHIF5SwY7KePuWN3JXoCX47RLtqBep
         Gksc9B4HyeNE/kqdbKwjkFJNwZxJwcheNq21JpiGoRE1EN1cvGkmrlneC9R7jO2/9YlE
         S1XJjlejciM078GQonMld4D5sDkp08e/zfWDSRMRj+1dSXXvPq6zumQhvSGZ+QDJIHAR
         sSZIc4jrYKNUQfWCFU7/Z6/qfak6UDY70NWORl2r+pxb1pnRXQry+xvUk/Cqd97ikwMN
         SXXQ==
X-Gm-Message-State: AIVw11064mUaEdmmlOicNSIZStnm/nin+aWgv7NpdENVC5nah9TN5N0l
        3e/QpSrztPbu+zkeJN4=
X-Received: by 10.28.73.214 with SMTP id w205mr787000wma.127.1501578220478;
        Tue, 01 Aug 2017 02:03:40 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-192-75.adsl-ull.clienti.tiscali.it. [94.39.192.75])
        by smtp.gmail.com with ESMTPSA id 91sm29947237wrg.83.2017.08.01.02.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Aug 2017 02:03:39 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 3/4] interpret-trailers: add options for actions
Date:   Tue,  1 Aug 2017 11:03:32 +0200
Message-Id: <20170801090333.32642-4-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170801090333.32642-1-bonzini@gnu.org>
References: <20170801090333.32642-1-bonzini@gnu.org>
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
 trailer.c                                | 34 +++++++++++++---
 trailer.h                                |  7 ++++
 5 files changed, 156 insertions(+), 6 deletions(-)

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
index 6941da799..d441cd9ac 100644
--- a/trailer.c
+++ b/trailer.c
@@ -295,6 +295,9 @@ static void apply_arg_if_exists(struct trailer_item *in_tok,
 		else
 			free_arg_item(arg_tok);
 		break;
+	default:
+		die("BUG: trailer.c: unhandled value %d",
+		    arg_tok->conf.if_exists);
 	}
 }
 
@@ -316,6 +319,10 @@ static void apply_arg_if_missing(struct list_head *head,
 			list_add_tail(&to_add->list, head);
 		else
 			list_add(&to_add->list, head);
+		break;
+	default:
+		die("BUG: trailer.c: unhandled value %d",
+		    arg_tok->conf.if_missing);
 	}
 }
 
@@ -370,7 +377,9 @@ static void process_trailers_lists(struct list_head *head,
 
 int trailer_set_where(enum trailer_where *item, const char *value)
 {
-	if (!strcasecmp("after", value))
+	if (!value)
+		*item = WHERE_DEFAULT;
+	else if (!strcasecmp("after", value))
 		*item = WHERE_AFTER;
 	else if (!strcasecmp("before", value))
 		*item = WHERE_BEFORE;
@@ -385,7 +394,9 @@ int trailer_set_where(enum trailer_where *item, const char *value)
 
 int trailer_set_if_exists(enum trailer_if_exists *item, const char *value)
 {
-	if (!strcasecmp("addIfDifferent", value))
+	if (!value)
+		*item = EXISTS_DEFAULT;
+	else if (!strcasecmp("addIfDifferent", value))
 		*item = EXISTS_ADD_IF_DIFFERENT;
 	else if (!strcasecmp("addIfDifferentNeighbor", value))
 		*item = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
@@ -402,7 +413,9 @@ int trailer_set_if_exists(enum trailer_if_exists *item, const char *value)
 
 int trailer_set_if_missing(enum trailer_if_missing *item, const char *value)
 {
-	if (!strcasecmp("doNothing", value))
+	if (!value)
+		*item = MISSING_DEFAULT;
+	else if (!strcasecmp("doNothing", value))
 		*item = MISSING_DO_NOTHING;
 	else if (!strcasecmp("add", value))
 		*item = MISSING_ADD;
@@ -659,12 +672,21 @@ static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
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
 
@@ -690,7 +712,7 @@ static void process_command_line_args(struct list_head *arg_head,
 			add_arg_item(arg_head,
 				     xstrdup(token_from_item(item, NULL)),
 				     xstrdup(""),
-				     &item->conf);
+				     &item->conf, NULL);
 	}
 
 	/* Add an arg item for each trailer on the command line */
@@ -712,7 +734,7 @@ static void process_command_line_args(struct list_head *arg_head,
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


