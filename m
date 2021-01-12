Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7500AC4332D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CD722E00
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405703AbhALItP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405681AbhALItO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:49:14 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11EBC0617A6
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:53 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 3so1262371wmg.4
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xz55P/En6olgyu71iHfy6aERihi8PJcXRqGmfbltiuk=;
        b=gTV0+Jq+R8fE56FmvQDaNU/HdMHSETNIuWLnQfR9/l4Yaf+0PDpLKcv2NnUkdlO7Ji
         L4a3wWq02XaH/EXvNJtSJRKCNJJE6goVPWbXTn7KZLV1yso8lsEmKkQBeW0Ts3FDd/cV
         yjqv9/c1oLdgOTaniqFJBEcXgtRh3vVHbbpeNkM/SKjj/2Nps9SuSftOc4Zb/oOpEk07
         6sgvss6tGoxW+e6r85SZ0gs2Zxgjef6xf0CrPFJ8LQqjt7nb8h5JD2BSmsp4nYrRuX4p
         ROCXtrnByNcDRHrRykxauElK6Q4XQEKWKSjZDkLzOPECo6EPP0g0p4h7EjsxHaeEm0zw
         vuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xz55P/En6olgyu71iHfy6aERihi8PJcXRqGmfbltiuk=;
        b=NZCmpAPRnneTAU09k3BNVY2DsnFSN1LwhfrLUbqn6LBQqVR4Qppn9R+RLxhb7CkxEg
         WCx11QY4AfYyvEZPq5PuAUN3JJbPTVAUebUFSxGtYZv6LksQiJ5bELUtIttRR2wWxL23
         9MCf/UboIJasUz0TE0P0SIzfo+P1CVtJyKMrVBkRBiJeU2LSWR463p0SVg6jX97Qn2lU
         TA+SrnNgC14/lqCHr0PDj+9D5H8u421YwwAC+fPtyF71ZScXiVP30lLUkZDEb1m27vP0
         4x/sm82KAe4HiHdn6nCCuztB5PEuG9QCQ5D9S50MMmAlLrTMC2Swnyb14ZwyXwRSsigZ
         ZlsA==
X-Gm-Message-State: AOAM531qaGk7VcgJmdxv4vYRCwbEppD9EhaZDEQk+uaD/90Ufcmw66dz
        AHEkkAG4UPB4b0mXe6qDLjcXtbsbTcw=
X-Google-Smtp-Source: ABdhPJxZQWw3QlsmgQzY8LUmW9aZp30aEkLfP5zTWWY9a0xZGJKTIg00M6GHMOjZG8HiqiFANJ52Lg==
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr2389321wmr.13.1610441272465;
        Tue, 12 Jan 2021 00:47:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y63sm3033834wmd.21.2021.01.12.00.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:52 -0800 (PST)
Message-Id: <4669ccbb1ae40f0c58a2d8e3c8b3a34d82176c7a.1610441263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:40 +0000
Subject: [PATCH 09/11] GETTEXT_POISON=rot13: do compare the output in
 `test_i18ncmp`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                |  1 +
 t/helper/test-i18n.c    | 89 +++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c    |  1 +
 t/helper/test-tool.h    |  1 +
 t/test-lib-functions.sh |  8 +++-
 t/test-lib.sh           |  1 +
 6 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-i18n.c

diff --git a/Makefile b/Makefile
index 7b64106930a..d49f80cb524 100644
--- a/Makefile
+++ b/Makefile
@@ -710,6 +710,7 @@ TEST_BUILTINS_OBJS += test-genzeros.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
+TEST_BUILTINS_OBJS += test-i18n.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-json-writer.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
diff --git a/t/helper/test-i18n.c b/t/helper/test-i18n.c
new file mode 100644
index 00000000000..4b572e6efad
--- /dev/null
+++ b/t/helper/test-i18n.c
@@ -0,0 +1,89 @@
+#include "test-tool.h"
+#include "cache.h"
+
+static const char *usage_msg = "\n"
+"  test-tool i18n cmp <file1> <file2>\n";
+
+static inline char do_rot13(char c)
+{
+	if (c >= 'a' && c <= 'm')
+		return c + 'n' - 'a';
+	if (c >= 'n' && c <= 'z')
+		return c + 'a' - 'n';
+	if (c >= 'A' && c <= 'M')
+		return c + 'N' - 'A';
+	if (c >= 'N' && c <= 'Z')
+		return c + 'A' - 'N';
+	return c;
+}
+
+static size_t unrot13(char *buf)
+{
+	char *p = buf, *q = buf;
+
+	while (*p) {
+		const char *begin = strstr(p, "<rot13>"), *end;
+
+		if (!begin)
+			break;
+
+		while (p != begin)
+			*(q++) = *(p++);
+
+		p += strlen("<rot13>");
+		end = strstr(p, "</rot13>");
+		if (!end)
+			BUG("could not find </rot13> in\n%s", buf);
+
+		while (p != end)
+			*(q++) = do_rot13(*(p++));
+		p += strlen("</rot13>");
+	}
+
+	while (*p)
+		*(q++) = *(p++);
+
+	return q - buf;
+}
+
+static void unrot13_strbuf(struct strbuf *buf)
+{
+	size_t len = unrot13(buf->buf);
+
+	if (len == buf->len)
+		die("not ROT13'ed:\n%s", buf->buf);
+	buf->len = len;
+}
+
+static int i18n_cmp(const char **argv)
+{
+	const char *path1 = *(argv++), *path2 = *(argv++);
+	struct strbuf a = STRBUF_INIT, b = STRBUF_INIT;
+
+	if (!path1 || !path2 || *argv)
+		usage(usage_msg);
+
+	if (strbuf_read_file(&a, path1, 0) < 0)
+		die_errno("could not read %s", path1);
+	if (strbuf_read_file(&b, path2, 0) < 0)
+		die_errno("could not read %s", path2);
+	unrot13_strbuf(&b);
+
+	if (a.len != b.len || memcmp(a.buf, b.buf, a.len))
+		return 1;
+
+	return 0;
+}
+
+int cmd__i18n(int argc, const char **argv)
+{
+	argv++;
+	if (!*argv)
+		usage(usage_msg);
+	if (!strcmp(*argv, "cmp"))
+		return i18n_cmp(argv+1);
+	else
+		usage(usage_msg);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 9d6d14d9293..7e1680ac108 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -34,6 +34,7 @@ static struct test_cmd cmds[] = {
 	{ "genzeros", cmd__genzeros },
 	{ "hashmap", cmd__hashmap },
 	{ "hash-speed", cmd__hash_speed },
+	{ "i18n", cmd__i18n },
 	{ "index-version", cmd__index_version },
 	{ "json-writer", cmd__json_writer },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index a6470ff62c4..43282a520ea 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -24,6 +24,7 @@ int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
+int cmd__i18n(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
 int cmd__json_writer(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999982fe4a9..08731bae854 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -993,7 +993,13 @@ test_cmp_bin () {
 # under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ncmp () {
-	! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
+	if test rot13 = "$GIT_TEST_GETTEXT_POISON"
+	then
+		test-tool i18n cmp "$@"
+	elif test_have_prereq C_LOCALE_OUTPUT
+	then
+		test_cmp "$@"
+	fi
 }
 
 # Use this instead of "grep expected-string actual" to see if the
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9fa7c1d0f6d..c9f9e2804fd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1537,6 +1537,7 @@ then
 fi
 
 test_lazy_prereq C_LOCALE_OUTPUT '
+	test rot13 != "$GIT_TEST_GETTEXT_POISON" &&
 	! test_bool_env GIT_TEST_GETTEXT_POISON false
 '
 
-- 
gitgitgadget

