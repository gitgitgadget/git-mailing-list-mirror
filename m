Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24EF020A04
	for <e@80x24.org>; Sun, 16 Apr 2017 10:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755410AbdDPKlk (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 06:41:40 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36575 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755204AbdDPKlj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 06:41:39 -0400
Received: by mail-pf0-f194.google.com with SMTP id i5so20639078pfc.3
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 03:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNQSJcXwAXetkyHiexOYlQQ87MXN3n2MUFqcuCg+P+Q=;
        b=D4UvY0bYP0qooSj9hFgN7pQpOLM8w2QSf4BfLirgIYXCdbW4ZJeLSiM3nBhkVCF14b
         J4tcNWam90qbqe6pmzLj8UZWBwphrfoCsARj7E7+oBlyNd1JZftcCAOsBGPYM84y1RaH
         Q+EY9O5fzMEPrwiauaTwBH4VtZ0UzshYpYIbbiqoJDy5/9N5L+jMpVtSC3oV3UrZZQDn
         k06OZZsc9iJ4pL7GZeg0fz8ZWfHibIK3Ip0B6n+pmef6xrbrMUU/UTr2Qug14yjhBvfR
         D6k/8Qo2qeNdLNQqdNMir+vsQvGZLqy+YggvUDitiz2P6pZ1omb21Yvu9b8oavYLSE+E
         KoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNQSJcXwAXetkyHiexOYlQQ87MXN3n2MUFqcuCg+P+Q=;
        b=PDom0OImqyHYLr0tTJtai8UIHju7mZi3hQwzFXOGkYDq10mlqxfi53WFczIroSLHWT
         1vx9UXMPSA8yIKZa8JeY2c6L808NBCj/Y+Nkf9stDlpLEcCoOMvL0zxbdu1EJ9mbXOm+
         2+URmuVZAt3ot7r33RZG9VkdAtlGhqLcryDloK5Lxl2aXyj/halEY6mkmzmj+LEmNAJb
         tFtH/vEyYFWzVbGk+wnLKoxsdl1oovg8yGwDPkcl7AWwq94DoG/YaU71pvVLCxb2ELM2
         PVtVHEeXItQgzLEeIxQeapI5Mt9GjwIniUxphMFWk+brGEm5HXURfRIcEZonHKEqN9Lf
         nZbg==
X-Gm-Message-State: AN3rC/56KLe2CgERYy5c+qOQ4TTGLVl6FUZ77JKTqhRuiJ2O3YSQhvlm
        ZmMqb15BWO2evQ==
X-Received: by 10.84.134.131 with SMTP id 3mr8560054plh.116.1492339298471;
        Sun, 16 Apr 2017 03:41:38 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 74sm12099900pfn.102.2017.04.16.03.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 03:41:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 16 Apr 2017 17:41:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        bert.wesarg@googlemail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] config: handle conditional include when $GIT_DIR is not set up
Date:   Sun, 16 Apr 2017 17:41:25 +0700
Message-Id: <20170416104125.15300-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170416104125.15300-1-pclouds@gmail.com>
References: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
 <20170416104125.15300-1-pclouds@gmail.com>
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

There are two cases when a config file could be read before $GIT_DIR is
located. The first one is check_repository_format(), where we read just
the one file $GIT_DIR/config to check if we could understand this
repository. This case should be safe. The concerned variables should
never be hidden away behind includes anyway.

The second one is triggered in check_pager_config() when we're about to
run an external git command. We might be able to find $GIT_DIR in this
case, which is exactly what read_early_config() does (and also is the
what check_pager_config() uses). Conditional includes and
get_git_dir() could be triggered by the first git_config_with_options()
call there, before discover_git_directory() is used as a fallback
$GIT_DIR detection.

Detect this special "early reading" case, pass down the $GIT_DIR,
either from previous setup or detected by discover_git_directory(),
and make conditional include use it.

Noticed-by: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h                   |  2 ++
 config.c                  | 35 ++++++++++++++++++++++++++---------
 t/t1305-config-include.sh | 11 +++++++++++
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index e29a093839..27b7286f99 100644
--- a/cache.h
+++ b/cache.h
@@ -1884,6 +1884,8 @@ enum config_origin_type {
 
 struct config_options {
 	unsigned int respect_includes : 1;
+	unsigned int early_config : 1;
+	const char *git_dir; /* only valid when early_config is true */
 };
 
 typedef int (*config_fn_t)(const char *, const char *, void *);
diff --git a/config.c b/config.c
index 042321a3a0..f323b96283 100644
--- a/config.c
+++ b/config.c
@@ -207,13 +207,20 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 	return prefix;
 }
 
-static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
+static int include_by_gitdir(const struct config_options *opts,
+			     const char *cond, size_t cond_len, int icase)
 {
 	struct strbuf text = STRBUF_INIT;
 	struct strbuf pattern = STRBUF_INIT;
 	int ret = 0, prefix;
 
-	strbuf_add_absolute_path(&text, get_git_dir());
+	if (!opts->early_config)
+		strbuf_add_absolute_path(&text, get_git_dir());
+	else if (opts->git_dir)
+		strbuf_add_absolute_path(&text, opts->git_dir);
+	else
+		goto done;
+
 	strbuf_add(&pattern, cond, cond_len);
 	prefix = prepare_include_condition_pattern(&pattern);
 
@@ -242,13 +249,14 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
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
@@ -273,7 +281,7 @@ int git_config_include(const char *var, const char *value, void *data)
 		ret = handle_path_include(value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    (cond && include_condition_is_true(cond, cond_len)) &&
+	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
 	    !strcmp(key, "path"))
 		ret = handle_path_include(value, inc);
 
@@ -1603,10 +1611,13 @@ void read_early_config(config_fn_t cb, void *data)
 {
 	struct config_options opts = {0};
 	struct strbuf buf = STRBUF_INIT;
+	char *to_free = NULL;
 
 	opts.respect_includes = 1;
-	git_config_with_options(cb, data, NULL, &opts);
+	opts.early_config = 1;
 
+	if (have_git_dir())
+		opts.git_dir = get_git_dir();
 	/*
 	 * When setup_git_directory() was not yet asked to discover the
 	 * GIT_DIR, we ask discover_git_directory() to figure out whether there
@@ -1615,15 +1626,21 @@ void read_early_config(config_fn_t cb, void *data)
 	 * notably, the current working directory is still the same after the
 	 * call).
 	 */
-	if (!have_git_dir() && discover_git_directory(&buf)) {
+	else if (discover_git_directory(&buf))
+		opts.git_dir = to_free = strbuf_detach(&buf, NULL);
+
+	git_config_with_options(cb, data, NULL, &opts);
+
+	if (opts.git_dir) {
 		struct git_config_source repo_config;
 
 		memset(&repo_config, 0, sizeof(repo_config));
-		strbuf_addstr(&buf, "/config");
+		strbuf_addf(&buf, "%s/config", opts.git_dir);
 		repo_config.file = buf.buf;
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

