Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261AA20248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfCSTEH (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:04:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33344 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfCSTEF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:04:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so5202637wmi.0
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=A81anqiIfEXoWwIG3c3DvWeFfjccWOE71q+HbqCzQys=;
        b=qympBAqwWwgd5z0reFRZCXeEFy6ggvFJITfaZ+qX/K3Y6XDawA48obyxIjAVyrFcB8
         Eq+z2ycXHhTA2HkLQw9dUgw4IdiaWJe9cWNXRQdQOoNhVpufq05Q0SzHUYWtoc6Fz23O
         z/oz3eLy1mS4CDRb82CmEeuBBFmvoA89kaLTOl7rpbvWY5KjdaU/S2YemPu00MthyUbl
         Jv1Y5vaJazCNqDJAyuTugFWaWDesL3E42Wy1WUGlH6vh2FZj27IFGnp6IVglu2oCYwwy
         JrUl96T3WmayxAUYx9MjHDueNyYEXJJcYYc6bn8nZ8oUGkfFElI2HSAzknBiXdgAOyBu
         yZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=A81anqiIfEXoWwIG3c3DvWeFfjccWOE71q+HbqCzQys=;
        b=HbW+VgtmjD79jqPk+H6NmEXz1tkphb+UAMk0UP5UgNYeUxH6+/mpotzjuAqqkvpmN0
         etbmxvJFfXsM+EB0jm+sCtsyCf4krld6jfC8EFHaSEyZaRB8N0f9N0zSWN4Ck1K0dGBt
         0yrTAffAtITr0vyNlXTM5VaTeTzfg0nJ64qcDtYcXkH/du38WEHuZ+wbqCRqIXpKSBSi
         frU+N6NuI9m2wW6V+raPHGVHw7Ib43TW2Y5RXplcf92pcqZ9ZYpeIDo7NDInF/vBqGUk
         fDdWsfZuIDxmTSP+l++J39nGfTXClWhw8//npgXNoa30zqH2TyCtUhasNgruRquxHIfj
         tucw==
X-Gm-Message-State: APjAAAV9Ga7n99vjqsA/lWd/wakzfO6iG68u7wbyW6pECl74zg4FyznL
        pEFpnvU+w1EZuasIzI6eMavsJHaeqWk=
X-Google-Smtp-Source: APXvYqz/ERtrG9dMlCHFQL5N9enOCn87WlrDDoZsPXPG/DRLCd9cf1yr+NSXGf0EXqgIMftQDS3MpQ==
X-Received: by 2002:a1c:f510:: with SMTP id t16mr4803215wmh.105.1553022242999;
        Tue, 19 Mar 2019 12:04:02 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s187sm6253853wms.7.2019.03.19.12.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:04:02 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 07/11] rebase -i: use struct object_id for squash_onto
Date:   Tue, 19 Mar 2019 19:03:13 +0000
Message-Id: <20190319190317.6632-8-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319190317.6632-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

More preparation for using `struct rebase_options` in
cmd_rebase__interactive(). Using a string was a hangover from the
scripted version of rebase, update the functions that use `squash_onto`
to take a `sturct object_id`.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c   | 21 +++++++++++++--------
 parse-options-cb.c | 17 +++++++++++++++++
 parse-options.h    |  3 +++
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0584b331bf..c93f2aa629 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -198,7 +198,7 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 				 const char *switch_to, struct commit *upstream,
 				 struct commit *onto, const char *onto_name,
-				 const char *squash_onto, const char *head_name,
+				 struct object_id *squash_onto, const char *head_name,
 				 struct commit *restrict_revision, char *raw_strategies,
 				 struct string_list *commands, unsigned autosquash)
 {
@@ -226,7 +226,8 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 	}
 
 	if (!upstream && squash_onto)
-		write_file(path_squash_onto(), "%s\n", squash_onto);
+		write_file(path_squash_onto(), "%s\n",
+			   oid_to_hex(squash_onto));
 
 	argv_array_pushl(&make_script_args, "", revisions, NULL);
 	if (restrict_revision)
@@ -267,10 +268,11 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1, ret = 0;
-	const char *onto_name = NULL,
-		*squash_onto = NULL, *head_name = NULL,
-		*switch_to = NULL, *cmd = NULL;
+	const char *onto_name = NULL, *head_name = NULL, *switch_to = NULL,
+		*cmd = NULL;
 	struct commit *onto = NULL, *upstream = NULL, *restrict_revision = NULL;
+	struct object_id squash_onto = null_oid;
+	struct object_id *squash_onto_opt = NULL;
 	struct string_list commands = STRING_LIST_INIT_DUP;
 	char *raw_strategies = NULL;
 	enum {
@@ -311,8 +313,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "restrict-revision", &restrict_revision,
 		  N_("restrict-revision"), N_("restrict revision"),
 		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
-		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
-			   N_("squash onto")),
+		{ OPTION_CALLBACK, 0, "squash-onto", &squash_onto, N_("squash-onto"),
+		  N_("squash onto"), PARSE_OPT_NONEG, parse_opt_object_id, 0 },
 		{ OPTION_CALLBACK, 0, "upstream", &upstream, N_("upstream"),
 		  N_("the upstream commit"), PARSE_OPT_NONEG, parse_opt_commit,
 		  0 },
@@ -349,6 +351,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 
 	opts.gpg_sign = xstrdup_or_null(opts.gpg_sign);
 
+	if (!is_null_oid(&squash_onto))
+		squash_onto_opt = &squash_onto;
+
 	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
@@ -373,7 +378,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			die(_("a base commit must be provided with --upstream or --onto"));
 
 		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
-					    onto_name, squash_onto, head_name, restrict_revision,
+					    onto_name, squash_onto_opt, head_name, restrict_revision,
 					    raw_strategies, &commands, autosquash);
 		break;
 	case SKIP: {
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 2206eb763c..28ad5cd94b 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -129,6 +129,23 @@ int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+int parse_opt_object_id(const struct option *opt, const char *arg, int unset)
+{
+	struct object_id oid;
+	struct object_id *target = opt->value;
+
+	if (unset) {
+		*target = null_oid;
+		return 0;
+	}
+	if (!arg)
+		return -1;
+	if (get_oid(arg, &oid))
+		return error(_("malformed object name '%s'"), arg);
+	*target = oid;
+	return 0;
+}
+
 int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
 {
 	int *target = opt->value;
diff --git a/parse-options.h b/parse-options.h
index 5a75646618..0ab1103bc7 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -264,7 +264,10 @@ int parse_opt_abbrev_cb(const struct option *, const char *, int);
 int parse_opt_expiry_date_cb(const struct option *, const char *, int);
 int parse_opt_color_flag_cb(const struct option *, const char *, int);
 int parse_opt_verbosity_cb(const struct option *, const char *, int);
+/* value is struct oid_array* */
 int parse_opt_object_name(const struct option *, const char *, int);
+/* value is struct object_id* */
+int parse_opt_object_id(const struct option *, const char *, int);
 int parse_opt_commits(const struct option *, const char *, int);
 int parse_opt_commit(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
-- 
2.21.0

