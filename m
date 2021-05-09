Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35329C433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 17:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1768C61004
	for <git@archiver.kernel.org>; Sun,  9 May 2021 17:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEIRNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 13:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhEIRNe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 13:13:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D36C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 10:12:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i190so11949995pfc.12
        for <git@vger.kernel.org>; Sun, 09 May 2021 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8Ph6izDDYJ2yFK0zDvvU/JyqtQT8D2wEJK8rPZTH88=;
        b=FeZDtHbFMvCoY7/qzfJTs2REj1st+EzYmelz6gzj7q7TbBDE0bWgCFgnjTWGKHiGK0
         hnyDnDZ4s7S5eoh0zUo3lzwcGkp7DTeiJiJJ9sH+xIUSJL1nmEV8zIVfPZngUMF7ugGP
         NLH5GMbf9KGUu5QaaKBEBFqJcjbvooAXgfKpkDDcyRGbmMTk29ZJ4JBCOvXpP+lGmJFZ
         QnYTK3I0WgVkxxQg4A1T5/e29EsbjDUjxir06cmknYbQuB2j9fRp+8tcxxhQQLuyaGNa
         J6KOggeE+4VybqwKY2phjnTomdsveTxeh3lk+nPiDeN4FslEF+nZDhgNICcaPTr5barm
         kJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8Ph6izDDYJ2yFK0zDvvU/JyqtQT8D2wEJK8rPZTH88=;
        b=Mg/crwsqxPEKeH7HN3BsJlY726bY/fYvP0MBX27DWIp746mTEB5ZSEliVW4uA5rFPe
         kyAIn7HedT273DZaik7MXe/2XcxfPTbgjoEoteW4i/x8zqK3sOe8J3XpFE4sjn5ENys7
         R1xB7qNFecn+M03fL6ROvPHQuBxTBQ0moB/6a//Jegsl7AlldiRMCWnn+1b7/aRj8Dq3
         XkwyqG3TEm3L+WgYMovSmwzhco2LF7iLfZs2Qk2VzLQch/Uooa3r1yArTqRT/gnTzitY
         poJCvxyAG1d9gt9ZWlzO8CmS/KcfIEzvvelZkOnNOyQgel8XbbymGkEcXKNaM7wqvgjx
         mruw==
X-Gm-Message-State: AOAM530WlRmeNczwXJm9aN3a5yHWlvRxRQQtzrobnWEyqWdRqROSKSf4
        rz6Mb5wkM/b2uR2vfk8WqOsghzNWd3eZ3Q==
X-Google-Smtp-Source: ABdhPJwEcYjWp7m6XQnC/wmGM3UBJhtRPmPaVVnHO9mLwraZ0EhTrH5W6jtUzYUfbNZFDpNvo136sg==
X-Received: by 2002:a63:eb12:: with SMTP id t18mr21493456pgh.349.1620580350554;
        Sun, 09 May 2021 10:12:30 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id l126sm9249374pga.41.2021.05.09.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 10:12:30 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 4/6] mailinfo: allow squelching quoted CRLF warning
Date:   Mon, 10 May 2021 00:12:11 +0700
Message-Id: <8aeb960dfdc6525764486ebd4e560efd96a03bc8.1620580178.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <cover.1620580178.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620580178.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous change, Git starts to warn for quoted CRLF in decoded
base64/QP email. Despite those warnings are usually helpful,
quoted CRLF could be part of some users' workflow.

Let's give them an option to turn off the warning completely.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-mailinfo.txt | 20 +++++++++++++++++++-
 builtin/mailinfo.c             | 12 ++++++++++++
 mailinfo.c                     | 20 +++++++++++++++++++-
 mailinfo.h                     |  7 +++++++
 t/t5100-mailinfo.sh            |  6 +++++-
 5 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index d343f040f5..824947a070 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -9,7 +9,9 @@ git-mailinfo - Extracts patch and authorship from a single e-mail message
 SYNOPSIS
 --------
 [verse]
-'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] <msg> <patch>
+'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n]
+	       [--[no-]scissors] [--quoted-cr=<action>]
+	       <msg> <patch>
 
 
 DESCRIPTION
@@ -89,6 +91,22 @@ This can be enabled by default with the configuration option mailinfo.scissors.
 --no-scissors::
 	Ignore scissors lines. Useful for overriding mailinfo.scissors settings.
 
+--quoted-cr=<action>::
+	Action when processes email messages sent with base64 or
+	quoted-printable encoding, and the decoded lines end with a CRLF
+	instead of a simple LF.
++
+The valid actions are:
++
+--
+*	`nowarn`: Git will do nothing when such a CRLF is found.
+*	`warn`: Git will issue a warning for each message if such a CRLF is
+	found.
+--
++
+The default action could be set by configuration option `mailinfo.quotedCR`.
+If no such configuration option has been set, `warn` will be used.
+
 <msg>::
 	The commit log message extracted from e-mail, usually
 	except the title line which comes from e-mail Subject.
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index f55549a097..01d16ef9e5 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -38,6 +38,15 @@ static int parse_opt_explicit_encoding(const struct option *opt,
 	return 0;
 }
 
+static int parse_opt_quoted_cr(const struct option *opt, const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+
+	if (mailinfo_parse_quoted_cr_action(arg, opt->value) != 0)
+		return error(_("bad action '%s' for '%s'"), arg, "--quoted-cr");
+	return 0;
+}
+
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	struct metainfo_charset meta_charset;
@@ -61,6 +70,9 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 			       N_("re-code metadata to this encoding"),
 			       PARSE_OPT_NONEG, parse_opt_explicit_encoding),
 		OPT_BOOL(0, "scissors", &mi.use_scissors, N_("use scissors")),
+		OPT_CALLBACK_F(0, "quoted-cr", &mi.quoted_cr, N_("<action>"),
+			       N_("action when quoted CR is found"),
+			       PARSE_OPT_NONEG, parse_opt_quoted_cr),
 		OPT_HIDDEN_BOOL(0, "inbody-headers", &mi.use_inbody_headers,
 			 N_("use headers in message's body")),
 		OPT_END()
diff --git a/mailinfo.c b/mailinfo.c
index c8caee4f55..a784552c7b 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1040,7 +1040,8 @@ static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
 
 static void summarize_quoted_cr(struct mailinfo *mi)
 {
-	if (mi->have_quoted_cr)
+	if (mi->have_quoted_cr &&
+	    mi->quoted_cr == quoted_cr_warn)
 		warning(_("quoted CRLF detected"));
 }
 
@@ -1220,6 +1221,17 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 	return mi->input_error;
 }
 
+int mailinfo_parse_quoted_cr_action(const char *actionstr, int *action)
+{
+	if (!strcmp(actionstr, "nowarn"))
+		*action = quoted_cr_nowarn;
+	else if (!strcmp(actionstr, "warn"))
+		*action = quoted_cr_warn;
+	else
+		return -1;
+	return 0;
+}
+
 static int git_mailinfo_config(const char *var, const char *value, void *mi_)
 {
 	struct mailinfo *mi = mi_;
@@ -1230,6 +1242,11 @@ static int git_mailinfo_config(const char *var, const char *value, void *mi_)
 		mi->use_scissors = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "mailinfo.quotedcr")) {
+		if (mailinfo_parse_quoted_cr_action(value, &mi->quoted_cr) != 0)
+			return error(_("bad action '%s' for '%s'"), value, var);
+		return 0;
+	}
 	/* perhaps others here */
 	return 0;
 }
@@ -1242,6 +1259,7 @@ void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->charset, 0);
 	strbuf_init(&mi->log_message, 0);
 	strbuf_init(&mi->inbody_header_accum, 0);
+	mi->quoted_cr = quoted_cr_warn;
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
diff --git a/mailinfo.h b/mailinfo.h
index b394ef9bce..768d06ac2a 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -5,6 +5,11 @@
 
 #define MAX_BOUNDARIES 5
 
+enum quoted_cr_action {
+	quoted_cr_nowarn,
+	quoted_cr_warn,
+};
+
 struct mailinfo {
 	FILE *input;
 	FILE *output;
@@ -14,6 +19,7 @@ struct mailinfo {
 	struct strbuf email;
 	int keep_subject;
 	int keep_non_patch_brackets_in_subject;
+	int quoted_cr; /* enum quoted_cr_action */
 	int add_message_id;
 	int use_scissors;
 	int use_inbody_headers;
@@ -40,6 +46,7 @@ struct mailinfo {
 	int input_error;
 };
 
+int mailinfo_parse_quoted_cr_action(const char *actionstr, int *action);
 void setup_mailinfo(struct mailinfo *);
 int mailinfo(struct mailinfo *, const char *msg, const char *patch);
 void clear_mailinfo(struct mailinfo *);
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index ac6fbfe596..1ecefa381d 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -255,7 +255,11 @@ test_expect_success 'mailinfo warn CR in base64 encoded email' '
 	check_quoted_cr_mail quoted-cr/0001 &&
 	test_must_be_empty quoted-cr/0001.err &&
 	check_quoted_cr_mail quoted-cr/0002 &&
-	grep "quoted CRLF detected" quoted-cr/0002.err
+	grep "quoted CRLF detected" quoted-cr/0002.err &&
+	check_quoted_cr_mail quoted-cr/0001 --quoted-cr=nowarn &&
+	test_must_be_empty quoted-cr/0001.err &&
+	check_quoted_cr_mail quoted-cr/0002 --quoted-cr=nowarn &&
+	test_must_be_empty quoted-cr/0002.err
 '
 
 test_done
-- 
2.31.1.448.g9c2f8508d1

