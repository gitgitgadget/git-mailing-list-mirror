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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A34C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F3861166
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhEFPDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbhEFPDx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:03:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0AFC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:02:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s20so3525147plr.13
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZC991hWkO/SL4oUy6K1NQgdSl8FhQADyPBSCC6LSt5M=;
        b=nP2DxJYoLb5+9c3h1yvxh6VYiJgZO1S9KjLxFi8YmF/0ntqD7/hUDIGL3/V66mL3gS
         +2G5TGcwpw6ajJIj19ZxB9eoogZubwKxTxu5Gg4tulOjGcn3Y7LXLT4S2HwW02b5IRxP
         6svw+Dq1XOMqosUnIBdcUQT97whA4/EoX7wUkEbLmYTtiLVTc5TPY0sXMYXxT1/oFEHH
         sfQYe47yxooaxJN8UFW+UGrtr4buDxqdpGHNO9YUCXbq/UhEhrdDDzO8+TwElt4im/Fm
         Vvoc0K3UxvjHzqDTNb+eWddIlRWig++EUu5QAGKjTGaQL1Y/bF51qjSkKFa8E9yfD+Hl
         Mp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZC991hWkO/SL4oUy6K1NQgdSl8FhQADyPBSCC6LSt5M=;
        b=LNHHe5PNJZHQMZk3lq/rjrq+nWh1hZmHp3HHitIJRY+sD1kSaV2tYCL3e1YPcpCIdI
         36e6nwXAg7FlYACEbt88oERhItFOlDDfwURRvDpRB6eo+97yEZ7m8Xo1PlGl43S11j3Z
         6L79CJIFI8mXkuVs/syMbYrWxcKJNK+c3wZOIikyLvA6FQ+3m4Ol8Mdfj2XteydJIT52
         zdAle5vs61yKbG6vhrgtLB7SKVaNW9rvj4MV8YVgZXeyAb+XKXTv1jUjv05gsCJiTmB+
         OMcGa1hkl0s2TmDiPXqWTPGb+pwkYgjs8huXvBpYKFT+nMbnFHph1qGkZkgiWLMu/Rly
         JwrQ==
X-Gm-Message-State: AOAM531c2sp0a69gXrYlWgR65Z6gT2qJ8KIm1+I6SDXrAhMXrvgbFhkJ
        AKtQG+b70Cx3OolDR2KaOrro5kUz93pmgA==
X-Google-Smtp-Source: ABdhPJw12Fm/0A4VFVS7mHaq428/c9wHQ0wGTVqcMCgJmq0UGqiVUd2a9nDE1gl7G7xceeDUZKh4ig==
X-Received: by 2002:a17:90a:6c43:: with SMTP id x61mr1433915pjj.124.1620313368200;
        Thu, 06 May 2021 08:02:48 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id v15sm2278377pgc.57.2021.05.06.08.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:02:46 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 6/6] am: learn to process quoted lines that ends with CRLF
Date:   Thu,  6 May 2021 22:02:24 +0700
Message-Id: <d6aa12acc0c0e11e2268ff344fa63cf5edf51290.1620311544.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <cover.1620311544.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620311544.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous changes, mailinfo has learnt to process lines that decoded
from base64 or quoted-printable, and ends with CRLF.

Let's teach "am" that new trick, too.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-am.txt               |  4 ++
 builtin/am.c                           | 51 ++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  5 +++
 mailinfo.h                             |  1 +
 t/t4258-am-quoted-cr.sh                | 37 +++++++++++++++++++
 t/t4258/mbox                           | 12 ++++++
 6 files changed, 110 insertions(+)
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
index 8355e3566f..0b2d886c81 100644
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
 
@@ -165,6 +167,16 @@ static void am_state_release(struct am_state *state)
 	strvec_clear(&state->git_apply_opts);
 }
 
+static int am_option_parse_quoted_cr(const struct option *opt,
+				     const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+
+	if (mailinfo_parse_quoted_cr_action(arg, opt->value) != 0)
+		return error(_("bad action '%s' for '%s'"), arg, "--quoted-cr");
+	return 0;
+}
+
 /**
  * Returns path relative to the am_state directory.
  */
@@ -397,6 +409,12 @@ static void am_load(struct am_state *state)
 	else
 		state->scissors = SCISSORS_UNSET;
 
+	read_state_file(&sb, state, "quoted-cr", 1);
+	if (!*sb.buf)
+		state->quoted_cr = quoted_cr_unset;
+	else if (mailinfo_parse_quoted_cr_action(sb.buf, &state->quoted_cr) != 0)
+		die(_("could not parse %s"), am_path(state, "quoted-cr"));
+
 	read_state_file(&sb, state, "apply-opt", 1);
 	strvec_clear(&state->git_apply_opts);
 	if (sq_dequote_to_strvec(sb.buf, &state->git_apply_opts) < 0)
@@ -1002,6 +1020,24 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
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
 
@@ -1162,6 +1198,18 @@ static int parse_mail(struct am_state *state, const char *mail)
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
@@ -2242,6 +2290,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			0, PARSE_OPT_NONEG),
 		OPT_BOOL('c', "scissors", &state.scissors,
 			N_("strip everything before a scissors line")),
+		OPT_CALLBACK_F(0, "quoted-cr", &state.quoted_cr, N_("action"),
+			       N_("pass it through git-mailinfo"),
+			       PARSE_OPT_NONEG, am_option_parse_quoted_cr),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
 			N_("pass it through git-apply"),
 			0),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 49e76e9d08..edf635095e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1333,6 +1333,7 @@ __git_whitespacelist="nowarn warn error error-all fix"
 __git_patchformat="mbox stgit stgit-series hg mboxrd"
 __git_showcurrentpatch="diff raw"
 __git_am_inprogress_options="--skip --continue --resolved --abort --quit --show-current-patch"
+__git_quoted_cr="nowarn warn strip"
 
 _git_am ()
 {
@@ -1354,6 +1355,10 @@ _git_am ()
 		__gitcomp "$__git_showcurrentpatch" "" "${cur##--show-current-patch=}"
 		return
 		;;
+	--quoted-cr=*)
+		__gitcomp "$__git_quoted_cr" "" "${cur##--quoted-cr=}"
+		return
+		;;
 	--*)
 		__gitcomp_builtin am "" \
 			"$__git_am_inprogress_options"
diff --git a/mailinfo.h b/mailinfo.h
index 2ddf8be90f..f2ffd0349e 100644
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
2.31.1.448.g9c2f8508d1

