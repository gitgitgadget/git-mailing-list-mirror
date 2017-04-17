Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7801FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 10:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753653AbdDQKKY (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 06:10:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35976 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753577AbdDQKKW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 06:10:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id i5so23938195pfc.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzyLaBIl+4v/hgLItj0c9AsGDUm53lATolRoPUDs8SE=;
        b=h+YCsv3o3rJMZoeyTzxmE4Z1YzDi7VsCMNu7bWbpV5fr/k3/NpjhVjRfTmX3KPaphN
         f+0tu6Td4w+O2qfUpjkuYX/r5BOmaOrV+TMJ3OMLfShJ8lCUrGUVvNyD18HYQBQLEGEe
         iIXfbVUxrPhe68qg5oFt5U70mu7t6e1tTTlfWGkSiGPUs6n5+TyWaL68opc0e26ITM4s
         Bb75xnPDKPgR3HpuZx9SsO9v9nAu9SyBBTwhlznLV2SQrI5HSS9G+N/AdXTJWSwkuY0W
         ILavgmkmYlZbeR2jnYObzWX5nBBR2Sf0dcb7l/m8B8wzktzQ8fKyBInYtNUf4lzjEskE
         PkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzyLaBIl+4v/hgLItj0c9AsGDUm53lATolRoPUDs8SE=;
        b=kZX6GJCIwKiTUH5scFTd6NVoKhGACVSzwRs/lVLKpzqxgCEEOyE3hjHUYugNYJ2r00
         fRjl9XrgXT3q8GUJfk67oqIuStqSw8GqH/UGMoPnvzFOxV4qBeMy/Z5WR7UnjURqS2Zp
         52iCKEza9L09Crpuh3pLsUufdtaH4be94u/pQWwJPTvz9O7oDc/z0QVF/R209WiQYgM7
         0vL2MGJQK00IM5ohOV5oxT3okkmxWC7iFDQhIxOhk9FIafnqYDnwEJ0jy08XofQjqUup
         0ah/G9vr3c8VIoewk9+TRhaD57pIYcefv0cRfK/g3fcx7LjKqW1hdOt7Tixpyb8b6FIy
         mu7Q==
X-Gm-Message-State: AN3rC/7ZqZUnOhpGZBVjur2IfkJR2DsKRbPM7dbVhUTxWyuCks5fJc0S
        YpgskelKNdbgIw==
X-Received: by 10.98.166.197 with SMTP id r66mr11035457pfl.5.1492423821901;
        Mon, 17 Apr 2017 03:10:21 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id e123sm17062794pfa.92.2017.04.17.03.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2017 03:10:21 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 17 Apr 2017 17:10:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        bert.wesarg@googlemail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 3/3] config: correct file reading order in read_early_config()
Date:   Mon, 17 Apr 2017 17:10:02 +0700
Message-Id: <20170417101002.18272-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170417101002.18272-1-pclouds@gmail.com>
References: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
 <20170417101002.18272-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Config file reading order is important because each file can override
values in the previous files and this is expected behavior. Normally
we read in this order, all in do_git_config_sequence():

1. $HOME/.gitconfig
2. $GIT_DIR/config
3. config from command line

However in read_early_config() the order may be swapped a bit if
setup_git_directory() has not been called:

1. $HOME/.gitconfig
2. $GIT_DIR/config is NOT read because .git dir is not found _yet_
3. config from command line
4. $GIT_DIR/config is now READ (after discover_git_directory() call)

The reading at step 4 could override config at step 3, which is not
the expectation.

Now that we could pass the .git dir around, we could feed
discover_git_directory() back to step 2, so that it works again, and
remove step 4.

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 config.c                | 26 ++++++++++++--------------
 t/helper/test-config.c  |  4 ++++
 t/t1309-early-config.sh | 17 +++++++++++++++++
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/config.c b/config.c
index 14f0417460..fffda653e3 100644
--- a/config.c
+++ b/config.c
@@ -1504,12 +1504,20 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-static int do_git_config_sequence(config_fn_t fn, void *data)
+static int do_git_config_sequence(const struct config_options *opts,
+				  config_fn_t fn, void *data)
 {
 	int ret = 0;
 	char *xdg_config = xdg_config_home("config");
 	char *user_config = expand_user_path("~/.gitconfig");
-	char *repo_config = have_git_dir() ? git_pathdup("config") : NULL;
+	char *repo_config;
+
+	if (opts->git_dir)
+		repo_config = mkpathdup("%s/config", opts->git_dir);
+	else if (have_git_dir())
+		repo_config = git_pathdup("config");
+	else
+		repo_config = NULL;
 
 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
@@ -1563,7 +1571,7 @@ int git_config_with_options(config_fn_t fn, void *data,
 	else if (config_source && config_source->blob)
 		return git_config_from_blob_ref(fn, config_source->blob, data);
 
-	return do_git_config_sequence(fn, data);
+	return do_git_config_sequence(opts, fn, data);
 }
 
 static void git_config_raw(config_fn_t fn, void *data)
@@ -1613,7 +1621,6 @@ void read_early_config(config_fn_t cb, void *data)
 {
 	struct config_options opts = {0};
 	struct strbuf buf = STRBUF_INIT;
-	char *to_free = NULL;
 
 	opts.respect_includes = 1;
 
@@ -1628,20 +1635,11 @@ void read_early_config(config_fn_t cb, void *data)
 	 * call).
 	 */
 	else if (discover_git_directory(&buf))
-		opts.git_dir = to_free = xstrdup(buf.buf);
+		opts.git_dir = buf.buf;
 
 	git_config_with_options(cb, data, NULL, &opts);
 
-	if (!have_git_dir() && opts.git_dir) {
-		struct git_config_source repo_config;
-
-		memset(&repo_config, 0, sizeof(repo_config));
-		strbuf_addstr(&buf, "/config");
-		repo_config.file = buf.buf;
-		git_config_with_options(cb, data, &repo_config, &opts);
-	}
 	strbuf_release(&buf);
-	free(to_free);
 }
 
 static void git_config_check_init(void);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 8e3ed6a76c..696d0a52fd 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -84,6 +84,10 @@ int cmd_main(int argc, const char **argv)
 	struct config_set cs;
 
 	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
+		const char *cmdline_config = getenv("CMDL_CFG");
+
+		if (cmdline_config)
+			git_config_push_parameter(cmdline_config);
 		read_early_config(early_config_cb, (void *)argv[2]);
 		return 0;
 	}
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index b97357b8ab..c15f18dd96 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -47,6 +47,23 @@ test_expect_success 'ceiling #2' '
 	test xdg = "$(cat output)"
 '
 
+test_expect_success 'read config file in right order' '
+	echo "[test]source = home" >>.gitconfig &&
+	git init foo &&
+	(
+		cd foo &&
+		echo "[test]source = repo" >>.git/config &&
+		CMDL_CFG=test.source=cmdline test-config \
+			read_early_config test.source >actual &&
+		cat >expected <<-\EOF &&
+		home
+		repo
+		cmdline
+		EOF
+		test_cmp expected actual
+	)
+'
+
 test_with_config () {
 	rm -rf throwaway &&
 	git init throwaway &&
-- 
2.11.0.157.gd943d85

