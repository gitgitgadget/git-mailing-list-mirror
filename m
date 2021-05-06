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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D00C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858AD61166
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbhEFPDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbhEFPDn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:03:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58AEC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:02:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so3624751pjb.3
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5lExw1vZ7ka/NkzP+5W4viDl4rKesc07FS0isOms6g=;
        b=scdiNBWr6IwQydq1BiTwm3jKBsTqe3UR7a8KInqEP2ZI6srJKFavs6MMYQ2u8or2p6
         QRTHl8mZ7ibpWfm+hnL/ZaI8TQYsh7xMmjilBeK/ROi0ewsYff+4EBgyQy0VeL6H3CyJ
         m+UO8TTu+BZwPz9ipZTlKq4xkd1cFIPoOvwuZOT5YOde3tsjTBrPrdMzPdw10DeuIFgz
         uSGUBCjgTlD2Pre3D0D+kORedwT/y6jIYLuAskztGyTP3Y2zXD1Qy6pjEYVbYiScin6y
         vvOwhlGBHXGdHrqpqIfHdGVrm1JcFQ4A6VAs1r2imVL1NDHUIr0PWjtwpsx3My/ELCoC
         eN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5lExw1vZ7ka/NkzP+5W4viDl4rKesc07FS0isOms6g=;
        b=FV5bFuBh/Z1pdgIKtHyrFD7V5SDTKOVm1asH29oDVClXJ0mLko6aCRZjDl6PiKmOj9
         cXenm3Mion5P6SX+YslXVA7rLiPLcNvbBYTOKoYXmqWKIMOupjW1arIq2JxO2HTZ3AG8
         UiGwB3ALkBxDAAfjo3njckHdPkonHMgqaF7xoZ1C9iVzjrZUW8EKQCZnaLe6upVDFCvc
         2AHSJ7xrTuPBpn+hgFDLwCnDkwrJcPWFV/VKhjcPNoY6kEBKXED7GSDbADmj2/eob+1v
         nSXkBOwIGne7GSZOIoHdaa+lUNLngzQfw77p1eOHJViBt16uoZ6TCqsJtMblHLlUIeAt
         anRw==
X-Gm-Message-State: AOAM533p7Ycs36Uir5qbEFPZ3HRLNPTBT/CVHliTtMTOjVkxveIpwsIx
        fZV/C6tiLRVy7e2zemQZnCrEoqpeNu8KcA==
X-Google-Smtp-Source: ABdhPJyyGH1ypfWAxvGm88W/ThnQ6a4kJa/YcMeih6lAzyZ1QFRe68t5+G4yZYLXQgc5zh326hkdkw==
X-Received: by 2002:a17:90b:31cc:: with SMTP id jv12mr18410368pjb.105.1620313363018;
        Thu, 06 May 2021 08:02:43 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id v15sm2278377pgc.57.2021.05.06.08.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:02:42 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 4/6] mailinfo: allow squelching quoted CR warning
Date:   Thu,  6 May 2021 22:02:22 +0700
Message-Id: <d5b2da370d072489b76d6883f01f309ebb1f3266.1620311544.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <cover.1620311544.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620311544.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous change, Git starts to warn for quoted CR in decoded
base64/QP email. Despite those warnings are usually helpful,
quoted CR could be part of some users' workflow.

Let's give them an option to turn off the warning completely.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-mailinfo.txt | 20 +++++++++++++++++++-
 builtin/mailinfo.c             | 12 ++++++++++++
 mailinfo.c                     | 20 +++++++++++++++++++-
 mailinfo.h                     |  7 +++++++
 t/t5100-mailinfo.sh            |  6 ++++--
 5 files changed, 61 insertions(+), 4 deletions(-)

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
index dcf579700d..c57eed25a5 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1040,7 +1040,8 @@ static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
 
 static void summarize_quoted_cr(struct mailinfo *mi)
 {
-	if (mi->have_quoted_cr)
+	if (mi->have_quoted_cr &&
+	    mi->quoted_cr == quoted_cr_warn)
 		warning("quoted CR detected");
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
index c7ea1b30df..51e8690fbd 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -236,11 +236,13 @@ check_quoted_cr_mail () {
 	test_cmp "$DATA/quoted-cr-info" quoted-cr-info
 }
 
-test_expect_success 'mailinfo warn CR in base64 encoded email' '
+test_expect_success 'mailinfo handle CR in base64 encoded email' '
 	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-msg" >expect-cr-msg &&
 	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-patch" >expect-cr-patch &&
 	check_quoted_cr_mail &&
-	grep "quoted CR detected" quoted-cr-err
+	grep "quoted CR detected" quoted-cr-err &&
+	check_quoted_cr_mail --quoted-cr=nowarn &&
+	test_must_be_empty quoted-cr-err
 '
 
 test_done
-- 
2.31.1.448.g9c2f8508d1

