Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5BBC1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 19:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbcKRT7G (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 14:59:06 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35043 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbcKRT7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 14:59:04 -0500
Received: by mail-pg0-f41.google.com with SMTP id p66so106073875pga.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RLLDBtGHgCnSgywGez/MiPg+1Y5wKGjqAxKEK5alSZE=;
        b=LP2V265x81qQwtvTgw/7RnBVpF1A9R16dJ5qVpTR8UKWcCbaTXQ52rHbVnQgh6/1Nw
         Uj9f+dS7OxrBDfhUOURfOE3nBGZB1/WyJb3YWBe9zcTtvr8EtVPbKWGR9P+UsJWP7WzT
         l7W4zzvqVkMUHaPyPFW31FF8oQ8x9CktPfXHuXhSAm5b+c7rLkred09svPZwMad/x9xj
         dkueNwGdYIZptXAwEcNTTfs+QwQcSNy2XaeudWuZfCoOM+aRxC4NNUsZU9kyGrhDtAv6
         lcfmRiCk1RZ3TPt24on3d+8f8xCMWGLxg3CGMxC/kRVipShJxRZeb29MWwsoOL31GjMb
         vY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RLLDBtGHgCnSgywGez/MiPg+1Y5wKGjqAxKEK5alSZE=;
        b=fB5xVTUcnaS8874n4rrZTX1WTWSvXBflZ3eFvYEPTqLpSJUs766773uAuCggZlAMk4
         /wxJSeBSWvKsFUQTlmZXqCJijL4x4ExwvnJRl0RJujH2zSYKakS6cMW5itKfSHkXAeyq
         6mCVX0X2l7OunPXQuw++mc6gbz9MBbLVeZz/yaYkxZxOlUSQR+meKeY/Z1WXo++FKcnt
         RCbtQLTkBYQSTWew9yD7bvubtEi3LdPclOL8mmnwcofk6n81+B6cXFwgl9luJml4TEyg
         u8OgWyDkd06eA51uMlIEFqHPoUbN1am5B4712DAMddivhWOzOqa71QA3X9GlaKvo4oyL
         7fSA==
X-Gm-Message-State: AKaTC03ottEHdjhy5MMaAPfX7yhXg/T8QmnaJ+J3DvumScxqnyPaZIXH69QEEUYKAeR0XZkr
X-Received: by 10.98.29.205 with SMTP id d196mr1836704pfd.111.1479499143244;
        Fri, 18 Nov 2016 11:59:03 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm19850441pfb.42.2016.11.18.11.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Nov 2016 11:59:01 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v4 0/6] recursively grep across submodules
Date:   Fri, 18 Nov 2016 11:58:49 -0800
Message-Id: <1479499135-64269-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1478908273-190166-1-git-send-email-bmwill@google.com>
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This revision of this series should address all of the problems brought up with
v3.

* indent output example in patch 5/6.
* fix ':' in submodule names and add a test to verify.
* cleanup some comments.
* fixed tests to test the case where a submodule isn't at the root of a
  repository.
* always pass --threads=%d in order to limit threads to child proccess.

Brandon Williams (6):
  submodules: add helper functions to determine presence of submodules
  submodules: load gitmodules file from commit sha1
  grep: add submodules as a grep source type
  grep: optionally recurse into submodules
  grep: enable recurse-submodules to work on <tree> objects
  grep: search history of moved submodules

 Documentation/git-grep.txt         |  14 ++
 builtin/grep.c                     | 393 ++++++++++++++++++++++++++++++++++---
 cache.h                            |   2 +
 config.c                           |   8 +-
 git.c                              |   2 +-
 grep.c                             |  16 +-
 grep.h                             |   1 +
 submodule-config.c                 |   6 +-
 submodule-config.h                 |   3 +
 submodule.c                        |  50 +++++
 submodule.h                        |   3 +
 t/t7814-grep-recurse-submodules.sh | 213 ++++++++++++++++++++
 12 files changed, 679 insertions(+), 32 deletions(-)
 create mode 100755 t/t7814-grep-recurse-submodules.sh

-- interdiff based on 'bw/grep-recurse-submodules'

diff --git a/builtin/grep.c b/builtin/grep.c
index 1cd2be9..747b0c3 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -518,9 +518,8 @@ static void compile_submodule_options(const struct grep_opt *opt,
 	 * This is to prevent potential fork-bomb behavior of git-grep as each
 	 * submodule process has its own thread pool.
 	 */
-	if (num_threads)
-		argv_array_pushf(&submodule_options, "--threads=%d",
-				 (num_threads + 1) / 2);
+	argv_array_pushf(&submodule_options, "--threads=%d",
+			 (num_threads + 1) / 2);
 
 	/* Add Pathspecs */
 	argv_array_push(&submodule_options, "--");
@@ -542,7 +541,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	struct work_item *w = opt->output_priv;
 
 	end_of_base = strchr(gs->name, ':');
-	if (end_of_base)
+	if (gs->identifier && end_of_base)
 		name = end_of_base + 1;
 	else
 		name = gs->name;
@@ -558,13 +557,13 @@ static int grep_submodule_launch(struct grep_opt *opt,
 
 	/*
 	 * Add basename of parent project
-	 * When performing grep on a <tree> object the filename is prefixed
-	 * with the object's name: '<tree-name>:filename'.  In order to
+	 * When performing grep on a tree object the filename is prefixed
+	 * with the object's name: 'tree-name:filename'.  In order to
 	 * provide uniformity of output we want to pass the name of the
 	 * parent project's object name to the submodule so the submodule can
 	 * prefix its output with the parent's name and not its own SHA1.
 	 */
-	if (end_of_base)
+	if (gs->identifier && end_of_base)
 		argv_array_pushf(&cp.args, "--parent-basename=%.*s",
 				 (int) (end_of_base - gs->name),
 				 gs->name);
@@ -572,7 +571,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	/* Add options */
 	for (i = 0; i < submodule_options.argc; i++) {
 		/*
-		 * If there is a <tree> identifier for the submodule, add the
+		 * If there is a tree identifier for the submodule, add the
 		 * rev after adding the submodule options but before the
 		 * pathspecs.  To do this we listen for the '--' and insert the
 		 * sha1 before pushing the '--' onto the child process argv
@@ -615,17 +614,20 @@ static int grep_submodule_launch(struct grep_opt *opt,
 static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 			  const char *filename, const char *path)
 {
-	if (!(is_submodule_initialized(path) &&
-	      is_submodule_populated(path))) {
+	if (!is_submodule_initialized(path))
+		return 0;
+	if (!is_submodule_populated(path)) {
 		/*
 		 * If searching history, check for the presense of the
 		 * submodule's gitdir before skipping the submodule.
 		 */
 		if (sha1) {
-			path = git_path("modules/%s",
-					submodule_from_path(null_sha1, path)->name);
+			const struct submodule *sub =
+					submodule_from_path(null_sha1, path);
+			if (sub)
+				path = git_path("modules/%s", sub->name);
 
-			if (!(is_directory(path) && is_git_directory(path)))
+			if(!(is_directory(path) && is_git_directory(path)))
 				return 0;
 		} else {
 			return 0;
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index ee173ad..7d66716 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -60,7 +60,7 @@ test_expect_success 'grep and nested submodules' '
 	submodule/sub/a:foobar
 	EOF
 
-	git grep -e "bar" --recurse-submodules > actual &&
+	git grep -e "bar" --recurse-submodules >actual &&
 	test_cmp expect actual
 '
 
@@ -71,7 +71,7 @@ test_expect_success 'grep and multiple patterns' '
 	submodule/sub/a:foobar
 	EOF
 
-	git grep -e "bar" --and -e "foo" --recurse-submodules > actual &&
+	git grep -e "bar" --and -e "foo" --recurse-submodules >actual &&
 	test_cmp expect actual
 '
 
@@ -80,7 +80,7 @@ test_expect_success 'grep and multiple patterns' '
 	b/b:bar
 	EOF
 
-	git grep -e "bar" --and --not -e "foo" --recurse-submodules > actual &&
+	git grep -e "bar" --and --not -e "foo" --recurse-submodules >actual &&
 	test_cmp expect actual
 '
 
@@ -92,7 +92,7 @@ test_expect_success 'basic grep tree' '
 	HEAD:submodule/sub/a:foobar
 	EOF
 
-	git grep -e "bar" --recurse-submodules HEAD > actual &&
+	git grep -e "bar" --recurse-submodules HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -103,7 +103,7 @@ test_expect_success 'grep tree HEAD^' '
 	HEAD^:submodule/a:foobar
 	EOF
 
-	git grep -e "bar" --recurse-submodules HEAD^ > actual &&
+	git grep -e "bar" --recurse-submodules HEAD^ >actual &&
 	test_cmp expect actual
 '
 
@@ -113,7 +113,7 @@ test_expect_success 'grep tree HEAD^^' '
 	HEAD^^:b/b:bar
 	EOF
 
-	git grep -e "bar" --recurse-submodules HEAD^^ > actual &&
+	git grep -e "bar" --recurse-submodules HEAD^^ >actual &&
 	test_cmp expect actual
 '
 
@@ -123,49 +123,80 @@ test_expect_success 'grep tree and pathspecs' '
 	HEAD:submodule/sub/a:foobar
 	EOF
 
-	git grep -e "bar" --recurse-submodules HEAD -- submodule > actual &&
+	git grep -e "bar" --recurse-submodules HEAD -- submodule >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep recurse submodule colon in name' '
+	git init parent &&
+	test_when_finished "rm -rf parent" &&
+	echo "foobar" >"parent/fi:le" &&
+	git -C parent add "fi:le" &&
+	git -C parent commit -m "add fi:le" &&
+
+	git init "su:b" &&
+	test_when_finished "rm -rf su:b" &&
+	echo "foobar" >"su:b/fi:le" &&
+	git -C "su:b" add "fi:le" &&
+	git -C "su:b" commit -m "add fi:le" &&
+
+	git -C parent submodule add "../su:b" "su:b" &&
+	git -C parent commit -m "add submodule" &&
+
+	cat >expect <<-\EOF &&
+	fi:le:foobar
+	su:b/fi:le:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	HEAD:fi:le:foobar
+	HEAD:su:b/fi:le:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules HEAD >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep history with moved submoules' '
 	git init parent &&
+	test_when_finished "rm -rf parent" &&
 	echo "foobar" >parent/file &&
 	git -C parent add file &&
 	git -C parent commit -m "add file" &&
 
 	git init sub &&
+	test_when_finished "rm -rf sub" &&
 	echo "foobar" >sub/file &&
 	git -C sub add file &&
 	git -C sub commit -m "add file" &&
 
-	git -C parent submodule add ../sub &&
+	git -C parent submodule add ../sub dir/sub &&
 	git -C parent commit -m "add submodule" &&
 
 	cat >expect <<-\EOF &&
+	dir/sub/file:foobar
 	file:foobar
-	sub/file:foobar
 	EOF
-	git -C parent grep -e "foobar" --recurse-submodules > actual &&
+	git -C parent grep -e "foobar" --recurse-submodules >actual &&
 	test_cmp expect actual &&
 
-	git -C parent mv sub sub-moved &&
+	git -C parent mv dir/sub sub-moved &&
 	git -C parent commit -m "moved submodule" &&
 
 	cat >expect <<-\EOF &&
 	file:foobar
 	sub-moved/file:foobar
 	EOF
-	git -C parent grep -e "foobar" --recurse-submodules > actual &&
+	git -C parent grep -e "foobar" --recurse-submodules >actual &&
 	test_cmp expect actual &&
 
 	cat >expect <<-\EOF &&
+	HEAD^:dir/sub/file:foobar
 	HEAD^:file:foobar
-	HEAD^:sub/file:foobar
 	EOF
-	git -C parent grep -e "foobar" --recurse-submodules HEAD^ > actual &&
-	test_cmp expect actual &&
-
-	rm -rf parent sub
+	git -C parent grep -e "foobar" --recurse-submodules HEAD^ >actual &&
+	test_cmp expect actual
 '
 
 test_incompatible_with_recurse_submodules ()

-- 
2.8.0.rc3.226.g39d4020

