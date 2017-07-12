Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C29520357
	for <e@80x24.org>; Wed, 12 Jul 2017 22:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbdGLWVx (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 18:21:53 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34470 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdGLWVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 18:21:51 -0400
Received: by mail-wr0-f196.google.com with SMTP id k67so7715640wrc.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XqKJENDjRwto4x92rtLtxN90fwcrEXQz95tUZ4HxgP4=;
        b=kUsfoCkjqHR7wySjVBNeh013rNqeXCSno8s97jKU+J/wLOJTxMrA671asGseE8Lfyf
         F/+r8CCxX6XONP7XJ6AFud57ubjLPLemLahjmdb7wrf8jpQcVOL0+M5b+XL7ApxdC3D1
         xbwNcNZ+3L4Cme8qa1Pvig7EsO72JoDlCajn2NEx3nw2GC2Q5fuT9igvSMb9pK+FQVwU
         Lp4SXfP6ZntmIREGdrcJulVNpQZuBW3HpnvkUlldwiDg4WH/uA2ZG5HJLQ8EQwdZeIdH
         WIQNCstjY1UOHJi3QIgByFjYglaoL4IQEYy7evtaIxd33B/CHl/GOVuahHc8j1Tq0HK4
         PzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=XqKJENDjRwto4x92rtLtxN90fwcrEXQz95tUZ4HxgP4=;
        b=JpAKlkDlANbWjJHqRZi79Dl6CPYs/pqL0QbRyVf4//kTgw0c47GOr6Y6SdlT1pRiSP
         Yzi5dedSwU8uXJIBg8OdWcE1OcXCLCHPnSvA46geihEYDi0D0EM4rPhstxkKVxzDMDsl
         ORJi4KWbfer7N+V3ZggG6FqB/vTwR1NdEoW0nPHIojGBbDtrLyVY/xxxY25CUz0KH1B9
         W82XSq2BX17tJZqdknglc8Tik/IbygqfyWdXAduqNvzpjnb4lh2FA6NqX87RQfXJ7RCW
         b9mjEZFR7a6IDSN5cnI0CIebB5MZsso1C30mxYKtXsAUe+8Ibec8NfBPFgMoFFbi5zDY
         T/4w==
X-Gm-Message-State: AIVw113MQ5n5uau+NMoJWRkn3yK6YD7BvuIWaituh1+jTawYkwtQJwB6
        6u3u8+Ymk8S2uA/zxxY=
X-Received: by 10.223.142.143 with SMTP id q15mr307737wrb.180.1499898085837;
        Wed, 12 Jul 2017 15:21:25 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-191-51.adsl-ull.clienti.tiscali.it. [94.39.191.51])
        by smtp.gmail.com with ESMTPSA id r200sm3444539wmd.20.2017.07.12.15.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jul 2017 15:21:24 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 3/3] interpret-trailers: add options for actions
Date:   Thu, 13 Jul 2017 00:21:16 +0200
Message-Id: <20170712222116.7095-4-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170712222116.7095-1-bonzini@gnu.org>
References: <20170712222116.7095-1-bonzini@gnu.org>
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
Signed-off-by and provides it in a separate email.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	v1->v2: fix and test behavior of --no-where and similar

 Documentation/git-interpret-trailers.txt | 16 ++++++++
 builtin/interpret-trailers.c             | 31 +++++++++++++++
 t/t7513-interpret-trailers.sh            | 66 ++++++++++++++++++++++++++++++++
 trailer.c                                | 40 ++++++++++++++++---
 trailer.h                                |  6 +++
 5 files changed, 153 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 31cdeaecd..f4d67b8a1 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -80,6 +80,22 @@ OPTIONS
 	trailer to the input messages. See the description of this
 	command.
 
+--where <placement>::
+	Specify where all new trailers will be added.  This option
+	overrides all configuration variables.
+
+--if-exists <action>::
+	Specify what action will be performed when there is already at
+	least one trailer with the same <token> in the message.  This
+	option applies to all '--trailer' options and overrides all
+	configuration variables.
+
+--if-missing <action>::
+	Specify what action will be performed when there is no other
+	trailer with the same <token> in the message.  This option
+	applies to all '--trailer' options and overrides all
+	configuration variables.
+
 CONFIGURATION VARIABLES
 -----------------------
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 6528680b5..bb93412ac 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -16,6 +16,30 @@ static const char * const git_interpret_trailers_usage[] = {
 	NULL
 };
 
+static int option_parse_where(const struct option *opt,
+			      const char *arg, int unset)
+{
+	enum action_where *where = opt->value;
+
+	return set_where(where, arg);
+}
+
+static int option_parse_if_exists(const struct option *opt,
+				  const char *arg, int unset)
+{
+	enum action_if_exists *if_exists = opt->value;
+
+	return set_if_exists(if_exists, arg);
+}
+
+static int option_parse_if_missing(const struct option *opt,
+				   const char *arg, int unset)
+{
+	enum action_if_missing *if_missing = opt->value;
+
+	return set_if_missing(if_missing, arg);
+}
+
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	struct trailer_opts opts = { 0 };
@@ -24,6 +48,13 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
+		OPT_CALLBACK(0, "where", &opts.where, N_("action"),
+			     N_("where to place the new trailer"), option_parse_where),
+		OPT_CALLBACK(0, "if-exists", &opts.if_exists, N_("action"),
+			     N_("action if trailer already exists"), option_parse_if_exists),
+		OPT_CALLBACK(0, "if-missing", &opts.if_missing, N_("action"),
+			     N_("action if trailer is missing"), option_parse_if_missing),
+
 		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add")),
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
index a371c7b45..0a3d207d9 100644
--- a/trailer.c
+++ b/trailer.c
@@ -371,7 +371,9 @@ static void process_trailers_lists(struct list_head *head,
 
 int set_where(enum action_where *item, const char *value)
 {
-	if (!strcasecmp("after", value))
+	if (!value)
+		*item = WHERE_DEFAULT;
+	else if (!strcasecmp("after", value))
 		*item = WHERE_AFTER;
 	else if (!strcasecmp("before", value))
 		*item = WHERE_BEFORE;
@@ -386,7 +388,9 @@ int set_where(enum action_where *item, const char *value)
 
 int set_if_exists(enum action_if_exists *item, const char *value)
 {
-	if (!strcasecmp("addIfDifferent", value))
+	if (!value)
+		*item = EXISTS_DEFAULT;
+	else if (!strcasecmp("addIfDifferent", value))
 		*item = EXISTS_ADD_IF_DIFFERENT;
 	else if (!strcasecmp("addIfDifferentNeighbor", value))
 		*item = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
@@ -403,7 +407,9 @@ int set_if_exists(enum action_if_exists *item, const char *value)
 
 int set_if_missing(enum action_if_missing *item, const char *value)
 {
-	if (!strcasecmp("doNothing", value))
+	if (!value)
+		*item = MISSING_DEFAULT;
+	else if (!strcasecmp("doNothing", value))
 		*item = MISSING_DO_NOTHING;
 	else if (!strcasecmp("add", value))
 		*item = MISSING_ADD;
@@ -545,8 +551,24 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	return 0;
 }
 
-static void ensure_configured(void)
+static void apply_config_overrides(struct conf_info *conf,
+				   const struct trailer_opts *opts)
 {
+	if (!opts)
+		return;
+	if (opts->where != WHERE_DEFAULT)
+		conf->where = opts->where;
+	if (opts->if_exists != EXISTS_DEFAULT)
+		conf->if_exists = opts->if_exists;
+	if (opts->if_missing != MISSING_DEFAULT)
+		conf->if_missing = opts->if_missing;
+}
+
+static void ensure_configured(const struct trailer_opts *opts)
+{
+	struct arg_item *item;
+	struct list_head *pos;
+
 	if (configured)
 		return;
 
@@ -555,7 +576,14 @@ static void ensure_configured(void)
 	default_conf_info.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
 	default_conf_info.if_missing = MISSING_ADD;
 	git_config(git_trailer_default_config, NULL);
+	apply_config_overrides(&default_conf_info, opts);
+
 	git_config(git_trailer_config, NULL);
+	list_for_each(pos, &conf_head) {
+		item = list_entry(pos, struct arg_item, list);
+		apply_config_overrides(&item->conf, opts);
+	}
+
 	configured = 1;
 }
 
@@ -976,7 +1004,7 @@ void process_trailers(const char *file, const struct trailer_opts *opts,
 	int trailer_end;
 	FILE *outfile = stdout;
 
-	ensure_configured();
+	ensure_configured(opts);
 
 	read_input_file(&sb, file);
 
@@ -1012,7 +1040,7 @@ void trailer_info_get(struct trailer_info *info, const char *str)
 	size_t nr = 0, alloc = 0;
 	char **last = NULL;
 
-	ensure_configured();
+	ensure_configured(NULL);
 
 	patch_start = find_patch_start(str);
 	trailer_end = find_trailer_end(str, patch_start);
diff --git a/trailer.h b/trailer.h
index f306bf059..634643c9d 100644
--- a/trailer.h
+++ b/trailer.h
@@ -2,12 +2,14 @@
 #define TRAILER_H
 
 enum action_where {
+	WHERE_DEFAULT,
 	WHERE_END,
 	WHERE_AFTER,
 	WHERE_BEFORE,
 	WHERE_START
 };
 enum action_if_exists {
+	EXISTS_DEFAULT,
 	EXISTS_ADD_IF_DIFFERENT_NEIGHBOR,
 	EXISTS_ADD_IF_DIFFERENT,
 	EXISTS_ADD,
@@ -15,6 +17,7 @@ enum action_if_exists {
 	EXISTS_DO_NOTHING
 };
 enum action_if_missing {
+	MISSING_DEFAULT,
 	MISSING_ADD,
 	MISSING_DO_NOTHING
 };
@@ -22,6 +25,9 @@ enum action_if_missing {
 struct trailer_opts {
 	int in_place;
 	int trim_empty;
+	enum action_where where;
+	enum action_if_exists if_exists;
+	enum action_if_missing if_missing;
 };
 
 int set_where(enum action_where *item, const char *value);
-- 
2.13.0

