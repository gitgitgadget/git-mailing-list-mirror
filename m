Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4D31FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 10:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbdDQKKS (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 06:10:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35692 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbdDQKKR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 06:10:17 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so26165355pge.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pmXt03ZI3P1Qr+KfAreH2BU4MyyXPWowxy2jiyYS8aI=;
        b=UjD0H1i9GxfNOTWFYPK9Lqea8Ef2SqRR997lqeJWNzbgx3WWqSYM1aflw5t2zdy0XT
         zsMwRR17uyT2cX36lw8D9InvNeLBzvV+YjUppecDBZE/oIw3LKm7iTzqqC3NBmcLfOQe
         ERhZN3Mv3qN5xMY+Ssz0GfNFqqD5aCCWCfTVFWvuD0msK8NkQeLhpYgaI00TlATb50fO
         +88C3aitfD8RGBpw92sN+5k11VgL3yzEbkZY5WR+aw++Ok06epWZzjS2rLFAOQpZxC2z
         c49lRjo86NO54ytKp7OkGpn+Z6+IV5exgTu7t8zTwN6qDvcCRzzn5ovUSXIMz+jSNeF2
         HyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pmXt03ZI3P1Qr+KfAreH2BU4MyyXPWowxy2jiyYS8aI=;
        b=cPDUN2WxMJO6NSa7XaETxKMJSpSetf17dt9Ii7PnIdO8/PIEsHTsDzfDlZm5vKjQGr
         cm8a9KI114RzmFTDjTasWZvIDu52tiQhVXBmDKhGKBkr3TCY9fcpbhZzBqrP0tBNZPzi
         WwWnSRXmLAPcb3DEHAlb8MYGL6j4dAyB/IsiuISSt/hvB6CwP2liMZ38nYaVcVb5Jece
         60P4UWIHFNDb+0mvnehtNiasMtJ+3NmdjQnCtgYEVGqJ2UZlWkhKIRyYsrzEAcsntoVS
         YjT8ZmkBOLwE5Kn6RQtSsmY2Jorvuo7P8ZocB8f/uyvNoCPVtApdRsZq9FRAPltbQx/D
         ht4A==
X-Gm-Message-State: AN3rC/4igx9BMhfuEFyrxSe5Mh85RRRvAePdfl8DmjBRUDVA878Qizjy
        19dyUDXT3qtsqA==
X-Received: by 10.99.55.78 with SMTP id g14mr11273279pgn.191.1492423816701;
        Mon, 17 Apr 2017 03:10:16 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id s10sm17103976pfe.28.2017.04.17.03.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2017 03:10:16 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 17 Apr 2017 17:10:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        bert.wesarg@googlemail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 2/3] config: handle conditional include when $GIT_DIR is not set up
Date:   Mon, 17 Apr 2017 17:10:01 +0700
Message-Id: <20170417101002.18272-2-pclouds@gmail.com>
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

If setup_git_directory() and friends have not been called,
get_git_dir() (because of includeIf.gitdir:XXX) would lead to

    die("BUG: setup_git_env called without repository");

There are two cases when a config file could be read before $GIT_DIR
is located.

The first one is check_repository_format(), where we read just the one
file $GIT_DIR/config to check if we could understand this
repository. This case should be safe. We do not parse include
directives, which can only be triggered from git_config_with_options,
but setup code uses a lower-level function. The concerned variables
should never be hidden away behind includes anyway.

The second one is triggered in check_pager_config() when we're about
to run an external git command. We might be able to find $GIT_DIR in
this case, which is exactly what read_early_config() does (and also is
what check_pager_config() uses). Conditional includes and
get_git_dir() could be triggered by the first
git_config_with_options() call there, before discover_git_directory()
is used as a fallback $GIT_DIR detection.

Detect this special "early reading" case, pass down the $GIT_DIR,
either from previous setup or detected by discover_git_directory(),
and make conditional include use it.

Noticed-by: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h                   |  1 +
 config.c                  | 34 ++++++++++++++++++++++++++--------
 t/t1305-config-include.sh | 11 +++++++++++
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index a6294d2573..878e1d441f 100644
--- a/cache.h
+++ b/cache.h
@@ -1887,6 +1887,7 @@ enum config_origin_type {
 
 struct config_options {
 	unsigned int respect_includes : 1;
+	const char *git_dir;
 };
 
 typedef int (*config_fn_t)(const char *, const char *, void *);
diff --git a/config.c b/config.c
index 042321a3a0..14f0417460 100644
--- a/config.c
+++ b/config.c
@@ -207,13 +207,22 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 	return prefix;
 }
 
-static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
+static int include_by_gitdir(const struct config_options *opts,
+			     const char *cond, size_t cond_len, int icase)
 {
 	struct strbuf text = STRBUF_INIT;
 	struct strbuf pattern = STRBUF_INIT;
 	int ret = 0, prefix;
+	const char *git_dir;
 
-	strbuf_add_absolute_path(&text, get_git_dir());
+	if (opts->git_dir)
+		git_dir = opts->git_dir;
+	else if (have_git_dir())
+		git_dir = get_git_dir();
+	else
+		goto done;
+
+	strbuf_add_absolute_path(&text, git_dir);
 	strbuf_add(&pattern, cond, cond_len);
 	prefix = prepare_include_condition_pattern(&pattern);
 
@@ -242,13 +251,14 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
 	return ret;
 }
 
-static int include_condition_is_true(const char *cond, size_t cond_len)
+static int include_condition_is_true(const struct config_options *opts,
+				     const char *cond, size_t cond_len)
 {
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
-		return include_by_gitdir(cond, cond_len, 0);
+		return include_by_gitdir(opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
-		return include_by_gitdir(cond, cond_len, 1);
+		return include_by_gitdir(opts, cond, cond_len, 1);
 
 	/* unknown conditionals are always false */
 	return 0;
@@ -273,7 +283,7 @@ int git_config_include(const char *var, const char *value, void *data)
 		ret = handle_path_include(value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    (cond && include_condition_is_true(cond, cond_len)) &&
+	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
 	    !strcmp(key, "path"))
 		ret = handle_path_include(value, inc);
 
@@ -1603,10 +1613,12 @@ void read_early_config(config_fn_t cb, void *data)
 {
 	struct config_options opts = {0};
 	struct strbuf buf = STRBUF_INIT;
+	char *to_free = NULL;
 
 	opts.respect_includes = 1;
-	git_config_with_options(cb, data, NULL, &opts);
 
+	if (have_git_dir())
+		opts.git_dir = get_git_dir();
 	/*
 	 * When setup_git_directory() was not yet asked to discover the
 	 * GIT_DIR, we ask discover_git_directory() to figure out whether there
@@ -1615,7 +1627,12 @@ void read_early_config(config_fn_t cb, void *data)
 	 * notably, the current working directory is still the same after the
 	 * call).
 	 */
-	if (!have_git_dir() && discover_git_directory(&buf)) {
+	else if (discover_git_directory(&buf))
+		opts.git_dir = to_free = xstrdup(buf.buf);
+
+	git_config_with_options(cb, data, NULL, &opts);
+
+	if (!have_git_dir() && opts.git_dir) {
 		struct git_config_source repo_config;
 
 		memset(&repo_config, 0, sizeof(repo_config));
@@ -1624,6 +1641,7 @@ void read_early_config(config_fn_t cb, void *data)
 		git_config_with_options(cb, data, &repo_config, &opts);
 	}
 	strbuf_release(&buf);
+	free(to_free);
 }
 
 static void git_config_check_init(void);
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index e833939320..fddb47bafa 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -208,6 +208,17 @@ test_expect_success 'conditional include, both unanchored, icase' '
 	)
 '
 
+test_expect_success 'conditional include, early config reading' '
+	(
+		cd foo &&
+		echo "[includeIf \"gitdir:foo/\"]path=bar6" >>.git/config &&
+		echo "[test]six=6" >.git/bar6 &&
+		echo 6 >expect &&
+		test-config read_early_config test.six >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
2.11.0.157.gd943d85

