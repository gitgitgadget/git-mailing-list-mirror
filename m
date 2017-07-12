Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3795D202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbdGLNrC (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 09:47:02 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35034 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbdGLNrB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 09:47:01 -0400
Received: by mail-wr0-f196.google.com with SMTP id y28so1400687wrd.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Ex3PotA+OJNmmTo0QeBlRJB3m/DUo0Oj2RVARN2q+o=;
        b=ROIw/TcuWjoI7l2NC2e+FO2Ps0D05tHTZ+G05oUvkPplIMZKZ0QS3cIbn2P6kC1qhs
         MZYcVI9J78se0WrDlZBEEI03bMxdE+napBS80IIeitoFQvC8MoMhka4ZOKzCyo2SEyqa
         KkEDsgJ0Hfrx/EtkfaVQ973VNszCIkPy7e2JQwotHm5Y8bhxOaXfjmt2OQ/t58Zs1QHl
         bGJP0g5bBSAd7+2OcRTK6Rq6Xb+QMcZEwztaOdDeyJXPpeuyxmFWQV+vIY+SEPf/Susi
         CjzhDQ/ZBCOnbu0qodEWvfp1B5+bYTuSz/qWBxj18hLqycjcwqpw41PycvfMQmplV8bq
         rzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/Ex3PotA+OJNmmTo0QeBlRJB3m/DUo0Oj2RVARN2q+o=;
        b=gQF+oYdLnqJ4b8n6Pn6qcoFhRSM+Thyf4fZk76PnJXb/5igKGjw2wxmwv5PcrmX+UQ
         ckT3pD28OxbFm0e3KPH3XOHLv8M5lUcQgs+igSnitCDfZpKdlGRemksbR0MvNfFoqFJP
         8mCY7bK6zt2oxsuatvcbI3I4iDb+vb+KuBCM/GUq78ViCFtQX6GZX3wykOjG1DzRpsRA
         bjTnZb2goLFJSnCdyTWQ1sRBz7kcnPKkSqSfhDalUB4WGmP/lXb6rw5+Hi7pldThSGex
         KMFk0cjyxrAUOQe45mXm3gECTpid2rWij9Beac99IVFmTi8ecHvF1mrqnKcH7Npp6TDk
         ti5w==
X-Gm-Message-State: AIVw111mpv37IhZp0E3y+mx6UdnDHKx+TDOlCdcewqxQibo+q9uA1GWp
        KgsyIKiUOUii0r6uypY=
X-Received: by 10.223.131.99 with SMTP id 90mr3064506wrd.123.1499867214234;
        Wed, 12 Jul 2017 06:46:54 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-191-51.adsl-ull.clienti.tiscali.it. [94.39.191.51])
        by smtp.gmail.com with ESMTPSA id 55sm3437950wrt.36.2017.07.12.06.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jul 2017 06:46:53 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] interpret-trailers: add options for actions
Date:   Wed, 12 Jul 2017 15:46:46 +0200
Message-Id: <20170712134646.17179-4-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170712134646.17179-1-bonzini@gnu.org>
References: <20170712134646.17179-1-bonzini@gnu.org>
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
 Documentation/git-interpret-trailers.txt | 16 ++++++++++
 builtin/interpret-trailers.c             | 40 +++++++++++++++++++++++++
 t/t7513-interpret-trailers.sh            | 51 ++++++++++++++++++++++++++++++++
 trailer.c                                | 28 ++++++++++++++++--
 trailer.h                                |  6 ++++
 5 files changed, 138 insertions(+), 3 deletions(-)

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
index 6528680b5..5f05f0af0 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -16,6 +16,39 @@ static const char * const git_interpret_trailers_usage[] = {
 	NULL
 };
 
+static int option_parse_where(const struct option *opt,
+			      const char *arg, int unset)
+{
+	enum action_where *where = opt->value;
+
+	if (unset)
+		return 0;
+
+	return set_where(where, arg);
+}
+
+static int option_parse_if_exists(const struct option *opt,
+				  const char *arg, int unset)
+{
+	enum action_if_exists *if_exists = opt->value;
+
+	if (unset)
+		return 0;
+
+	return set_if_exists(if_exists, arg);
+}
+
+static int option_parse_if_missing(const struct option *opt,
+				   const char *arg, int unset)
+{
+	enum action_if_missing *if_missing = opt->value;
+
+	if (unset)
+		return 0;
+
+	return set_if_missing(if_missing, arg);
+}
+
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	struct trailer_opts opts = { 0 };
@@ -24,6 +57,13 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
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
index 0c6f91c43..49f4f823d 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -681,6 +681,21 @@ test_expect_success 'using "where = before"' '
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
 test_expect_success 'using "where = after"' '
 	git config trailer.ack.where "after" &&
 	cat complex_message_body >expected &&
@@ -947,6 +962,23 @@ test_expect_success 'using "ifExists = add" with "where = after"' '
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
@@ -1026,6 +1058,25 @@ test_expect_success 'the default is "ifMissing = add"' '
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
index 558c52431..78e88f98d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -549,14 +549,36 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	return 0;
 }
 
-static void ensure_configured(void)
+static void apply_config_overrides(struct conf_info *conf, struct trailer_opts *opts)
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
+static void ensure_configured(struct trailer_opts *opts)
+{
+	struct arg_item *item;
+	struct list_head *pos;
+
 	if (configured)
 		return;
 
 	/* Default config must be setup first */
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
 
@@ -977,7 +999,7 @@ void process_trailers(const char *file, struct trailer_opts *opts,
 	int trailer_end;
 	FILE *outfile = stdout;
 
-	ensure_configured();
+	ensure_configured(opts);
 
 	read_input_file(&sb, file);
 
@@ -1013,7 +1035,7 @@ void trailer_info_get(struct trailer_info *info, const char *str)
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

