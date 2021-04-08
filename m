Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E0AC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF2261151
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhDHNfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhDHNe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 09:34:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6766C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 06:34:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e14so3055291ejz.11
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N5y+jE1A0gEtuQn83NUg7WsP0Hg+rJGsa42Z6zLZ5Yg=;
        b=TdzRvZgzxZSR+8xvmfYcgkNJUfwgIwbCMfsuPe1KomJgRdcDCmLuztrQgh95Ybjs0p
         ouRYH5C0fApniNqgCqzj1q+JF32I9dVyBy0b35+u1Ub796xlL8RzFOObwyQ6KuOsOUQJ
         Ex9eFWFmCQfuN2xYbDdH0DPzx6M0OHlm3pnOSg3JqOID5+/D9sh6r23w7gLwk9eo7wfz
         BjJTwtg2lcjcK/55hNAa4lDiHDHHThaA/vUmXkEqdVhZ/aum9gmyZiBrm2LHTtZ6u0rA
         N3qCeu4Vwl4hNcKev6PykXIbB52R0D6NEf7FLssWKCaoi56TUSUZTFR5Huu27mjBeb7w
         INzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N5y+jE1A0gEtuQn83NUg7WsP0Hg+rJGsa42Z6zLZ5Yg=;
        b=P53inFLfpmM+CpIoYNXZTUIHphTiPK2YGiZ0XMz17vFh6tgqwQdi37htpMOcDy5COO
         Qq7N08HE6N2XEWevxqKR5h6RoXbXuZc9VMtYFn6m7WBGGwbng7cLlL4SjKHhmit7jgT8
         Q+oairCKVpr6pNqNDtWlGgwQLbBr1sQhPTbX36PxpapnLqsUtHv3NwibcjBG9mYIpEYp
         94sHltMzJ3NSGvvImPQRICzirL0yIhBCRI/vvry9CqvnDQe7LUXY/B5hO+iFG/Dxy0Ak
         p9/z3TdxN+07Qy1i/zm4RIZ1YPTmvLmBVR2ci+i2ReXw+ZBsN17DhNQ5498KjwKheUHZ
         la2w==
X-Gm-Message-State: AOAM533x3/DWNp7sD6x3Xo6B0pTGbjvO/qZlUnoY01rJqL509cqaBppC
        isVXGiVobrgWKJU9b/Nwtfo5mCoi8hYAQQ==
X-Google-Smtp-Source: ABdhPJzA40e9evKm1mBMWAsANVj1DK7Q2xYAYqPTxiiUYchUK3+h+fG8SzOgYMkaovkmn7FyFc38Pw==
X-Received: by 2002:a17:906:f9c2:: with SMTP id lj2mr10164117ejb.195.1617888883183;
        Thu, 08 Apr 2021 06:34:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x24sm12441621edr.36.2021.04.08.06.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:34:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lin Sun <lin.sun@zoom.us>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] config: add --type=bool-or-auto switch
Date:   Thu,  8 Apr 2021 15:34:29 +0200
Message-Id: <patch-5.6-9f8996a888-20210408T133125Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we're using git_config_tristate() internally let's expose it
via "git config" like we do "bool", "int" etc for completeness, and so
that we can easily test it.

Unlike the --type=bool-or-str option added in dbd8c09bfe (mergetool:
allow auto-merge for meld to follow the vim-diff behavior, 2020-05-07)
we don't have or anticipate any in-tree user of this except the tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-config.txt |  4 +++
 builtin/config.c             | 19 ++++++++++++++
 t/t1300-config.sh            | 49 ++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 4ae9ef210c..1af8222e82 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -189,6 +189,10 @@ Valid `<type>`'s include:
   above.
 - 'bool-or-str: canonicalize according to either 'bool' (as described
   above), or emit the value as-is.
+- 'bool-or-auto: canonicalize according to either 'bool', as described
+  above, or whether the value is "auto". This is used by various
+  "tristate" variables such as `core.restrictInheritedHandles`,
+  `format.numbered` etc.
 - 'path': canonicalize by adding a leading `~` to the value of `$HOME` and
   `~user` to the home directory for the specified user. This specifier has no
   effect when setting the value (but you can use `git config section.variable
diff --git a/builtin/config.c b/builtin/config.c
index f71fa39b38..039a4f0961 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -68,6 +68,7 @@ static int fixed_value;
 #define TYPE_EXPIRY_DATE	5
 #define TYPE_COLOR		6
 #define TYPE_BOOL_OR_STR	7
+#define TYPE_BOOL_OR_AUTO	8
 
 #define OPT_CALLBACK_VALUE(s, l, v, h, i) \
 	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
@@ -99,6 +100,8 @@ static int option_parse_type(const struct option *opt, const char *arg,
 			new_type = TYPE_BOOL_OR_INT;
 		else if (!strcmp(arg, "bool-or-str"))
 			new_type = TYPE_BOOL_OR_STR;
+		else if (!strcmp(arg, "bool-or-auto"))
+			new_type = TYPE_BOOL_OR_AUTO;
 		else if (!strcmp(arg, "path"))
 			new_type = TYPE_PATH;
 		else if (!strcmp(arg, "expiry-date"))
@@ -156,6 +159,7 @@ static struct option builtin_config_options[] = {
 	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
 	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
 	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string"), TYPE_BOOL_OR_STR),
+	/* No bool-or-auto! The --<type> form is deprecated in favor of --type=<what> */
 	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
@@ -263,6 +267,12 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 				strbuf_addstr(buf, value_);
 			else
 				strbuf_addstr(buf, v ? "true" : "false");
+		} else if (type == TYPE_BOOL_OR_AUTO) {
+			int v = git_config_tristate(key_, value_);
+			if (v == 2)
+				strbuf_addstr(buf, "auto");
+			else
+				strbuf_addstr(buf, v ? "true" : "false");
 		} else if (type == TYPE_PATH) {
 			const char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
@@ -435,6 +445,15 @@ static char *normalize_value(const char *key, const char *value)
 		else
 			return xstrdup(v ? "true" : "false");
 	}
+	if (type == TYPE_BOOL_OR_AUTO) {
+		int v = git_parse_maybe_tristate(value);
+		if (v < 0)
+			return xstrdup(value);
+		else if (v == 2)
+			xstrdup("auto");
+		else
+			return xstrdup(v ? "true" : "false");
+	}
 	if (type == TYPE_COLOR) {
 		char v[COLOR_MAXLEN];
 		if (git_config_color(v, key, value))
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index a002ec5644..952d9e9ed9 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -874,6 +874,55 @@ test_expect_success 'get --bool-or-str' '
 	test_cmp expect actual
 '
 
+test_expect_success 'there is no --bool-or-auto, --<type> is deprecated in favor of --type=<type>' '
+	test_expect_code 129 git config --bool-or-auto
+'
+
+test_expect_success 'get --type=bool-or-auto' '
+	cat >.git/config <<-\EOF &&
+	[bool]
+	true1
+	true2 = true
+	false = false
+	[int]
+	int1 = 0
+	int2 = 1
+	int3 = -1
+	[string]
+	string1 = hello
+	string2 = there you
+	[auto]
+	auto1 = auto
+	auto2 = AUTO
+	[bad-auto]
+	bad-auto1 = AUTOMATIC
+	EOF
+	cat >expect <<-\EOF &&
+	true
+	true
+	false
+	false
+	true
+	true
+	auto
+	auto
+	EOF
+	{
+		git config --type=bool-or-auto bool.true1 &&
+		git config --type=bool-or-auto bool.true2 &&
+		git config --type=bool-or-auto bool.false &&
+		git config --type=bool-or-auto int.int1 &&
+		git config --type=bool-or-auto int.int2 &&
+		git config --type=bool-or-auto int.int3 &&
+		git config --type=bool-or-auto auto.auto1 &&
+		git config --type=bool-or-auto auto.auto2
+	} >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git config --type=bool-or-auto --get bad-auto.bad-auto1 2>err &&
+	grep "bad tristate config value" err
+'
+
 cat >expect <<\EOF
 [bool]
 	true1 = true
-- 
2.31.1.527.g9b8f7de2547

