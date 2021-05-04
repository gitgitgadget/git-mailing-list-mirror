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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CA5C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F79613BC
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhEDRVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 13:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhEDRVO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 13:21:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37195C06174A
        for <git@vger.kernel.org>; Tue,  4 May 2021 10:20:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b15so8405853pfl.4
        for <git@vger.kernel.org>; Tue, 04 May 2021 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNbf4bDdESwGKhVEUvsVUYQuaUXo08qeCkJ86KpaCvQ=;
        b=ryEsOU/wXCwMQqqPlpmX8k+2ycO9w+Ze0aETEH88EnUMkAFm7+kyQURoHoPInhvhgf
         XsgQMlD+qVy2feTfKoMaRNLafiemIowA6tbjR7DB5GxpSAEJsuKb3GMIkmy+0VoNS1cW
         k68m+51eZgPypi+gpgD6HwBwMbT0RVG9YSmVgDD5ibyYkBNJya8t/04SOqtUcRbjnXe4
         gsCz2AmU1g+gPgI+MdI6SorvcMXoFQLl3ceo80+HAZrsEGlsf0sSiH8wxKvIFEh93VV3
         c00IFYFlZHsY1gbA55W4LIyAMHXTeweIktVt1iGKNRkRXrdNWBtFCu2awcDtoY7g4GCP
         Blbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNbf4bDdESwGKhVEUvsVUYQuaUXo08qeCkJ86KpaCvQ=;
        b=n/QUDfw/mY4YCJLJmQziKnfyKFcv/zI7mF52VITQoLx1NsmBtahfuTkwNlCRStkc+n
         hRk3IIrbgbuRdIokezG38TIpmaIbF7601CgShTOnjMsnupfS5X9HowgQdIBSt10G2gR1
         2vYD2XNi4Hta1cWmK8Ixsy61YYMabCazWlmqjsin47hqOHF2jy2i91KYRraAmj+29NXf
         cKxgBkfqfrpjfw+/ykdN7xWgbswrYdkmEXx+FJ9ObpQIgqmZ3bPoVW6ZjZRDdcX9Wq4q
         24ijBQUH7sIRswsWAu6K3dIBltTbeuuxVlpWNVRe6AvlgA8nSjuxMDWpKWEuywgVCHRD
         aajA==
X-Gm-Message-State: AOAM533mfQrYvUR4EoaPtZZ2+CKv2yexAWTvOTt4Gka+Cl1dk3SYKnYm
        yxt//0ctBTiWxGgbUZ7kHBAKLELm6ByGcQ==
X-Google-Smtp-Source: ABdhPJzXBdJd9b0nxT5h6dMaZSe4pqV1Agl8WlWZpqWK2FUaUGFW3DQJzDN3BzHKbGIpt5L4NWbPTg==
X-Received: by 2002:a62:7b8d:0:b029:28b:a5c1:7847 with SMTP id w135-20020a627b8d0000b029028ba5c17847mr23320054pfc.27.1620148818460;
        Tue, 04 May 2021 10:20:18 -0700 (PDT)
Received: from athena.localdomain ([27.75.102.31])
        by smtp.gmail.com with ESMTPSA id a18sm4019267pgg.51.2021.05.04.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 10:20:18 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 3/5] mailinfo: skip quoted CR on user's wish
Date:   Wed,  5 May 2021 00:20:00 +0700
Message-Id: <3215ea95cf869c8495d95cfd774973c330c14d1d.1620148732.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.500.gbc6bbdd36b
In-Reply-To: <cover.1620148732.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620148732.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous change, we've turned on warning for quoted CR in base64
encoded email. Despite those warnings are usually helpful for our users,
they may expect quoted CR in their emails.

Let's give them an option to turn off the warning completely.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-mailinfo.txt | 18 +++++++++++++++++-
 builtin/mailinfo.c             |  8 ++++++--
 mailinfo.c                     | 21 ++++++++++++++++++++-
 mailinfo.h                     |  8 ++++++++
 t/t5100-mailinfo.sh            |  6 ++++--
 5 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index d343f040f5..c776b27515 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -9,7 +9,7 @@ git-mailinfo - Extracts patch and authorship from a single e-mail message
 SYNOPSIS
 --------
 [verse]
-'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] <msg> <patch>
+'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] [--quoted-cr=<action>] <msg> <patch>
 
 
 DESCRIPTION
@@ -89,6 +89,22 @@ This can be enabled by default with the configuration option mailinfo.scissors.
 --no-scissors::
 	Ignore scissors lines. Useful for overriding mailinfo.scissors settings.
 
+--quoted-cr=<action>::
+	Action when processes email messages sent with base64 or
+	quoted-printable encoding, and the decoded lines end with CR-LF
+	instead of a simple LF.
++
+The valid actions are:
++
+--
+*	`nowarn`: Git will do nothing with this action.
+*	`warn`: Git will issue a warning for each message if such CR-LF is
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
index b309badce5..1d600263cb 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -9,7 +9,7 @@
 #include "mailinfo.h"
 
 static const char mailinfo_usage[] =
-	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
+	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] [--quoted-cr=<action>] <msg> <patch> < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
@@ -43,7 +43,11 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 			mi.use_scissors = 0;
 		else if (!strcmp(argv[1], "--no-inbody-headers"))
 			mi.use_inbody_headers = 0;
-		else
+		else if (skip_prefix(argv[1], "--quoted-cr=", &str)) {
+			mi.quoted_cr = mailinfo_parse_quoted_cr_action(str);
+			if (mi.quoted_cr == quoted_cr_invalid_action)
+				usage(mailinfo_usage);
+		} else
 			usage(mailinfo_usage);
 		argc--; argv++;
 	}
diff --git a/mailinfo.c b/mailinfo.c
index 713567f84b..fe7ffd01d0 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1040,7 +1040,8 @@ static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
 
 static void summarize_quoted_cr(struct mailinfo *mi, int have_quoted_cr)
 {
-	if (have_quoted_cr)
+	if (have_quoted_cr
+	    && mi->quoted_cr == quoted_cr_warn)
 		warning("quoted CR detected");
 }
 
@@ -1221,9 +1222,19 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 	return mi->input_error;
 }
 
+enum quoted_cr_action mailinfo_parse_quoted_cr_action(const char *action)
+{
+	if (!strcmp(action, "nowarn"))
+		return quoted_cr_nowarn;
+	else if (!strcmp(action, "warn"))
+		return quoted_cr_warn;
+	return quoted_cr_invalid_action;
+}
+
 static int git_mailinfo_config(const char *var, const char *value, void *mi_)
 {
 	struct mailinfo *mi = mi_;
+	const char *str;
 
 	if (!starts_with(var, "mailinfo."))
 		return git_default_config(var, value, NULL);
@@ -1231,6 +1242,13 @@ static int git_mailinfo_config(const char *var, const char *value, void *mi_)
 		mi->use_scissors = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "mailinfo.quotedcr")) {
+		git_config_string(&str, var, value);
+		mi->quoted_cr = mailinfo_parse_quoted_cr_action(str);
+		if (mi->quoted_cr == quoted_cr_invalid_action)
+			die(_("bad action '%s' for '%s'"), str, var);
+		free((void *)str);
+	}
 	/* perhaps others here */
 	return 0;
 }
@@ -1243,6 +1261,7 @@ void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->charset, 0);
 	strbuf_init(&mi->log_message, 0);
 	strbuf_init(&mi->inbody_header_accum, 0);
+	mi->quoted_cr = quoted_cr_warn;
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
diff --git a/mailinfo.h b/mailinfo.h
index 79b1d6774e..1bcef5a6f3 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -5,6 +5,12 @@
 
 #define MAX_BOUNDARIES 5
 
+enum quoted_cr_action {
+	quoted_cr_nowarn,
+	quoted_cr_warn,
+	quoted_cr_invalid_action
+};
+
 struct mailinfo {
 	FILE *input;
 	FILE *output;
@@ -14,6 +20,7 @@ struct mailinfo {
 	struct strbuf email;
 	int keep_subject;
 	int keep_non_patch_brackets_in_subject;
+	enum quoted_cr_action quoted_cr;
 	int add_message_id;
 	int use_scissors;
 	int use_inbody_headers;
@@ -39,6 +46,7 @@ struct mailinfo {
 	int input_error;
 };
 
+enum quoted_cr_action mailinfo_parse_quoted_cr_action(const char *action);
 void setup_mailinfo(struct mailinfo *);
 int mailinfo(struct mailinfo *, const char *msg, const char *patch);
 void clear_mailinfo(struct mailinfo *);
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index d8fdda6bea..57b8fc8104 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -236,11 +236,13 @@ check_quoted_cr_mail() {
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
2.31.1.500.gbc6bbdd36b

