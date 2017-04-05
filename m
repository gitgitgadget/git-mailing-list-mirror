Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AED81FAFB
	for <e@80x24.org>; Wed,  5 Apr 2017 10:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754603AbdDEKZ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 06:25:59 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35713 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753902AbdDEKYw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 06:24:52 -0400
Received: by mail-pf0-f195.google.com with SMTP id n11so1313528pfg.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fcLSuEb5FK2o7UwyFNPogLHxW34SCoYHYSYc2Z7JC+g=;
        b=Ia26bsgBykFPm9O50TBrs+ByXutV9aLMc0y7rQlDlP78DR5HhoheCj9LnbwO2TKZlQ
         WA0qV0SAa16bChlWtHW9kFRSOkM8k4kHpInSm3xYDX6FnDow71tzB5nJz5PZs93Y9Yje
         d87ba468HlqwUlrEkeLp8+6Amx65xGFsSAdUtDDM5QmtUt5QtbflA91Bs1CjoaVehcq7
         bpclhLUO+lu7RzmWJP8A6abheENobDEtSpKSQYhL+x9apJiMMlxvwKg6XvAtOImz/gYv
         MSxi/Y64OdNtz5nHWfFR/FLlEc2Wqw55NepcAzrXzqAmuD98pjk1yz6FKX9Ma15bni8w
         r2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fcLSuEb5FK2o7UwyFNPogLHxW34SCoYHYSYc2Z7JC+g=;
        b=ML5GpmVPYcCIvhipfDt+Pshko19lnqUieUFSkMKOB2zf8JpGWJ+IW43fLn57/kFaSd
         iI2R20whv2b5kNyQhqg5qiUzygHZg+FVOsWPL5Z22Zg62zHVFGzcuAYAvzEhTc9Bg88K
         cW5ge2vq5BnUfnpiLjT5hT5X/veuwHHHoo1RcDans0qVRwJeO1YkdhCImjB2dvTIsQBE
         j1w0dr0TagvJMdiz8rfEE/5jodLeWrlhWcJbmtEafWcXPCEpk4rm1KjcbhJIoexVF/an
         6WMVlhe68k1j0wdIN/8kb+0tsJnYgsjWaSP+yBhL7H6bJkovDBnJEp8vj1iynzy+gx7z
         a1nQ==
X-Gm-Message-State: AFeK/H18ZzqmCiH5LZvvSHZeIH8hh8jp5Xa+ExgVJ4TP0a2kabVRbxRNRJ+N0e1CLXLD9g==
X-Received: by 10.99.97.77 with SMTP id v74mr29157377pgb.76.1491387891745;
        Wed, 05 Apr 2017 03:24:51 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 74sm22869762pfn.102.2017.04.05.03.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Apr 2017 03:24:50 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 05 Apr 2017 17:24:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, tboegi@web.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 2/2] config: resolve symlinks in conditional include's patterns
Date:   Wed,  5 Apr 2017 17:24:39 +0700
Message-Id: <20170405102439.14797-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170405102439.14797-1-pclouds@gmail.com>
References: <20170330113723.20474-1-pclouds@gmail.com>
 <20170405102439.14797-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$GIT_DIR returned by get_git_dir() is normalized, with all symlinks
resolved (see setup_work_tree function). In order to match paths (or
patterns) against $GIT_DIR char-by-char, they have to be normalized
too. There is a note in config.txt about this, that the user need to
resolve symlinks by themselves if needed.

The problem is, we allow certain path expansion, '~/' and './', for
convenience and can't ask the user to resolve symlinks in these
expansions. Make sure the expanded paths have all symlinks resolved.

PS. The strbuf_realpath(&text, get_git_dir(), 1) is still needed because
get_git_dir() may return relative path.

Noticed-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Tests are added in v2.

 config.c                  |  6 +++---
 t/t1305-config-include.sh | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index f036c721e6..d5ba848b65 100644
--- a/config.c
+++ b/config.c
@@ -177,7 +177,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 	char *expanded;
 	int prefix = 0;
 
-	expanded = expand_user_path(pat->buf, 0);
+	expanded = expand_user_path(pat->buf, 1);
 	if (expanded) {
 		strbuf_reset(pat);
 		strbuf_addstr(pat, expanded);
@@ -191,7 +191,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 			return error(_("relative config include "
 				       "conditionals must come from files"));
 
-		strbuf_add_absolute_path(&path, cf->path);
+		strbuf_realpath(&path, cf->path, 1);
 		slash = find_last_dir_sep(path.buf);
 		if (!slash)
 			die("BUG: how is this possible?");
@@ -213,7 +213,7 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
 	struct strbuf pattern = STRBUF_INIT;
 	int ret = 0, prefix;
 
-	strbuf_add_absolute_path(&text, get_git_dir());
+	strbuf_realpath(&text, get_git_dir(), 1);
 	strbuf_add(&pattern, cond, cond_len);
 	prefix = prepare_include_condition_pattern(&pattern);
 
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index e833939320..8fbc7a029f 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -3,6 +3,16 @@
 test_description='test config file include directives'
 . ./test-lib.sh
 
+# Force setup_explicit_git_dir() to run until the end. This is needed
+# by some tests to make sure real_path() is called on $GIT_DIR. The
+# caller needs to make sure git commands are run from a subdirectory
+# though or real_path() will not be called.
+force_setup_explicit_git_dir() {
+    GIT_DIR="$(pwd)/.git"
+    GIT_WORK_TREE="$(pwd)"
+    export GIT_DIR GIT_WORK_TREE
+}
+
 test_expect_success 'include file by absolute path' '
 	echo "[test]one = 1" >one &&
 	echo "[include]path = \"$(pwd)/one\"" >.gitconfig &&
@@ -208,6 +218,50 @@ test_expect_success 'conditional include, both unanchored, icase' '
 	)
 '
 
+test_expect_success SYMLINKS 'conditional include, set up symlinked $HOME' '
+	mkdir real-home &&
+	ln -s real-home home &&
+	(
+		HOME="$TRASH_DIRECTORY/home" &&
+		export HOME &&
+		cd "$HOME" &&
+
+		git init foo &&
+		cd foo &&
+		mkdir sub
+	)
+'
+
+test_expect_success SYMLINKS 'conditional include, $HOME expansion with symlinks' '
+	(
+		HOME="$TRASH_DIRECTORY/home" &&
+		export HOME &&
+		cd "$HOME"/foo &&
+
+		echo "[includeIf \"gitdir:~/foo/\"]path=bar2" >>.git/config &&
+		echo "[test]two=2" >.git/bar2 &&
+		echo 2 >expect &&
+		force_setup_explicit_git_dir &&
+		git -C sub config test.two >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success SYMLINKS 'conditional include, relative path with symlinks' '
+	echo "[includeIf \"gitdir:./foo/.git\"]path=bar4" >home/.gitconfig &&
+	echo "[test]four=4" >home/bar4 &&
+	(
+		HOME="$TRASH_DIRECTORY/home" &&
+		export HOME &&
+		cd "$HOME"/foo &&
+
+		echo 4 >expect &&
+		force_setup_explicit_git_dir &&
+		git -C sub config test.four >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'include cycles are detected' '
 	cat >.gitconfig <<-\EOF &&
 	[test]value = gitconfig
-- 
2.11.0.157.gd943d85

