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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89F3C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55002613C5
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhEDRVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 13:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhEDRVR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 13:21:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A015C06174A
        for <git@vger.kernel.org>; Tue,  4 May 2021 10:20:22 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p4so8411873pfo.3
        for <git@vger.kernel.org>; Tue, 04 May 2021 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVyUIHaxiLKdSgL7osmU3Fz9kyTRCn+KAbNkyCj1XJ8=;
        b=mva5cWy1rlGyJvpfsZ+F6Iu7hcoaOhl2I+LRvGL4ydoCKJU2CPxxYO2HGZpbVHacFe
         k5BNZX8/dJl8F4l/KT7laRSJQBNKpr9lJq8vam6LIAyPYSIFHykIUIC0IBLu305cggut
         ocwli+nUaRpYo0IZIdmx9N4RhlMtUu05NfRLKmLqPzKXCAhXd0M6NMCh6MTIPu8kgxgf
         L/dtQO/WUekrVElbocH2H+9SV55ve2VmEnQtF+COlr+ApovgIk7JQo5M4F7lakASoZOU
         7KRBfQtNje99wrJFlFlS8BGgjSm/gaBKxbHQ7Sym3pE2iGvarBdtbT5tGkXI2rFWzJpy
         Uzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVyUIHaxiLKdSgL7osmU3Fz9kyTRCn+KAbNkyCj1XJ8=;
        b=i7NwppEydR0eXhwrXKu2MLsBt0WfqyCi9uKVRUsnStOABzZUQlfEZFWM6Y1AkB9mc1
         Z7p8HmkbYCu11ohslJ480bdHY6j4ArR7hfvgeDhvoEEdR4lhzsWQ40Ylg4y5t62gw1R3
         Y1E4VEOs2uMiDJNr3wgdR6bPZvRphzbQ32ADeO7eoYure2KSnJwbAkikMGZkCf9X8vaH
         ie9Be0jICAH2Ke+it+Zk5TfUq2E0+pCrIjv59R42i4NKnnI3szYdV6DX92igp+uA6vxf
         0FzrHHQP2N5cmr6q52U9YO5WNLlSooK3V0tb3YHHefrBWjlWKOpX16bQQo9vC7QQ8dYo
         TSkQ==
X-Gm-Message-State: AOAM5325/xXsYwWgq6EreqOUorVufLMjGvvY/xToQiEVSarPu6ODwhm6
        2ijR212yQ1QNuoN6+Nfq6FdpdHm7/szJSw==
X-Google-Smtp-Source: ABdhPJyD5bt8rr9pJXvhP5m67QpmLNWUwSAXV0uilj28Os9JYprJbpmJ/QN71heVpqXn1b2WW7O++g==
X-Received: by 2002:a17:90b:182:: with SMTP id t2mr28611351pjs.138.1620148821970;
        Tue, 04 May 2021 10:20:21 -0700 (PDT)
Received: from athena.localdomain ([27.75.102.31])
        by smtp.gmail.com with ESMTPSA id a18sm4019267pgg.51.2021.05.04.10.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 10:20:21 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 5/5] am: learn to process quoted lines that ends with CRLF
Date:   Wed,  5 May 2021 00:20:02 +0700
Message-Id: <d2052bcea925ec9e7d780e99e5b5e3bb1b9bd056.1620148732.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.500.gbc6bbdd36b
In-Reply-To: <cover.1620148732.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620148732.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous changes, mailinfo has learnt to process lines that decoded
from base64 or quoted-printable and ends with CRLF.

Let's teach "am" that new option, too.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-am.txt |  4 +++
 builtin/am.c             | 56 ++++++++++++++++++++++++++++++++++++++++
 mailinfo.h               |  1 +
 t/t4258-am-quoted-cr.sh  | 37 ++++++++++++++++++++++++++
 t/t4258/mbox             | 12 +++++++++
 5 files changed, 110 insertions(+)
 create mode 100755 t/t4258-am-quoted-cr.sh
 create mode 100644 t/t4258/mbox

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index decd8ae122..8714dfcb76 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
+	 [--quoted-cr=<action>]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
 
@@ -59,6 +60,9 @@ OPTIONS
 --no-scissors::
 	Ignore scissors lines (see linkgit:git-mailinfo[1]).
 
+--quoted-cr=<action>::
+	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+
 -m::
 --message-id::
 	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
diff --git a/builtin/am.c b/builtin/am.c
index 8355e3566f..ff4c8ee68f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -116,6 +116,7 @@ struct am_state {
 	int keep; /* enum keep_type */
 	int message_id;
 	int scissors; /* enum scissors_type */
+	int quoted_cr; /* enum quoted_cr_action */
 	struct strvec git_apply_opts;
 	const char *resolvemsg;
 	int committer_date_is_author_date;
@@ -145,6 +146,7 @@ static void am_state_init(struct am_state *state)
 	git_config_get_bool("am.messageid", &state->message_id);
 
 	state->scissors = SCISSORS_UNSET;
+	state->quoted_cr = quoted_cr_unset;
 
 	strvec_init(&state->git_apply_opts);
 
@@ -165,6 +167,19 @@ static void am_state_release(struct am_state *state)
 	strvec_clear(&state->git_apply_opts);
 }
 
+static int am_option_parse_quoted_cr(const struct option *opt,
+				     const char *arg, int unset)
+{
+	int *quoted_cr = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	*quoted_cr = mailinfo_parse_quoted_cr_action(arg);
+	if (*quoted_cr == quoted_cr_invalid_action)
+		return -1;
+	return 0;
+}
+
 /**
  * Returns path relative to the am_state directory.
  */
@@ -397,6 +412,14 @@ static void am_load(struct am_state *state)
 	else
 		state->scissors = SCISSORS_UNSET;
 
+	read_state_file(&sb, state, "quoted-cr", 1);
+	if (!*sb.buf)
+		state->quoted_cr = quoted_cr_unset;
+	else
+		state->quoted_cr = mailinfo_parse_quoted_cr_action(sb.buf);
+	if (state->quoted_cr == quoted_cr_invalid_action)
+		die(_("could not parse %s"), am_path(state, "quoted-cr"));
+
 	read_state_file(&sb, state, "apply-opt", 1);
 	strvec_clear(&state->git_apply_opts);
 	if (sq_dequote_to_strvec(sb.buf, &state->git_apply_opts) < 0)
@@ -1002,6 +1025,24 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	}
 	write_state_text(state, "scissors", str);
 
+	switch (state->quoted_cr) {
+	case quoted_cr_unset:
+		str = "";
+		break;
+	case quoted_cr_nowarn:
+		str = "nowarn";
+		break;
+	case quoted_cr_warn:
+		str = "warn";
+		break;
+	case quoted_cr_strip:
+		str = "strip";
+		break;
+	default:
+		BUG("invalid value for state->quoted_cr");
+	}
+	write_state_text(state, "quoted-cr", str);
+
 	sq_quote_argv(&sb, state->git_apply_opts.v);
 	write_state_text(state, "apply-opt", sb.buf);
 
@@ -1162,6 +1203,18 @@ static int parse_mail(struct am_state *state, const char *mail)
 		BUG("invalid value for state->scissors");
 	}
 
+	switch (state->quoted_cr) {
+	case quoted_cr_unset:
+		break;
+	case quoted_cr_nowarn:
+	case quoted_cr_warn:
+	case quoted_cr_strip:
+		mi.quoted_cr = state->quoted_cr;
+		break;
+	default:
+		BUG("invalid value for state->quoted_cr");
+	}
+
 	mi.input = xfopen(mail, "r");
 	mi.output = xfopen(am_path(state, "info"), "w");
 	if (mailinfo(&mi, am_path(state, "msg"), am_path(state, "patch")))
@@ -2242,6 +2295,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			0, PARSE_OPT_NONEG),
 		OPT_BOOL('c', "scissors", &state.scissors,
 			N_("strip everything before a scissors line")),
+		OPT_CALLBACK_F(0, "quoted-cr", &state.quoted_cr, N_("action"),
+			       N_("pass it through git-mailinfo"),
+			       PARSE_OPT_NONEG, am_option_parse_quoted_cr),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
 			N_("pass it through git-apply"),
 			0),
diff --git a/mailinfo.h b/mailinfo.h
index e0e094c311..8c78c72bbe 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -6,6 +6,7 @@
 #define MAX_BOUNDARIES 5
 
 enum quoted_cr_action {
+	quoted_cr_unset = -1,
 	quoted_cr_nowarn,
 	quoted_cr_warn,
 	quoted_cr_strip,
diff --git a/t/t4258-am-quoted-cr.sh b/t/t4258-am-quoted-cr.sh
new file mode 100755
index 0000000000..2029115ecd
--- /dev/null
+++ b/t/t4258-am-quoted-cr.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='test am --quoted-cr=<action>'
+
+. ./test-lib.sh
+
+DATA="$TEST_DIRECTORY/t4258"
+
+test_expect_success 'setup' '
+	test_write_lines one two three >text &&
+	test_commit one text &&
+	test_write_lines one owt three >text &&
+	test_commit two text
+'
+
+test_expect_success 'am warn if quoted-cr is found' '
+	git reset --hard one &&
+	test_must_fail git am "$DATA/mbox" 2>err &&
+	grep "quoted CR detected" err
+'
+
+test_expect_success 'am strip if quoted-cr is found' '
+	test_might_fail git am --abort &&
+	git reset --hard one &&
+	git am --quoted-cr=strip "$DATA/mbox" &&
+	git diff --exit-code HEAD two
+'
+
+test_expect_success 'am strip if quoted-cr is found' '
+	test_might_fail git am --abort &&
+	git reset --hard one &&
+	test_config mailinfo.quotedCr strip &&
+	git am "$DATA/mbox" &&
+	git diff --exit-code HEAD two
+'
+
+test_done
diff --git a/t/t4258/mbox b/t/t4258/mbox
new file mode 100644
index 0000000000..c62819f3d2
--- /dev/null
+++ b/t/t4258/mbox
@@ -0,0 +1,12 @@
+From: A U Thor <mail@example.com>
+To: list@example.org
+Subject: [PATCH v2] sample
+Date: Mon,  3 Aug 2020 22:40:55 +0700
+Message-Id: <msg-id@example.com>
+Content-Type: text/plain; charset="utf-8"
+Content-Transfer-Encoding: base64
+
+VGhpcyBpcyBjb21taXQgbWVzc2FnZS4NCi0tLQ0KIHRleHQgfCAyICstDQogMSBmaWxlIGNoYW5n
+ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS90ZXh0IGIv
+dGV4dA0KaW5kZXggNTYyNmFiZi4uZjcxOWVmZCAxMDA2NDQNCi0tLSBhL3RleHQNCisrKyBiL3Rl
+eHQNCkBAIC0xICsxIEBADQotb25lDQordHdvDQotLSANCjIuMzEuMQoK
-- 
2.31.1.500.gbc6bbdd36b

