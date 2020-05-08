Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A71C47247
	for <git@archiver.kernel.org>; Fri,  8 May 2020 06:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297AD20870
	for <git@archiver.kernel.org>; Fri,  8 May 2020 06:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDln52sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEHGVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 02:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgEHGVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 02:21:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA85C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 23:21:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so3780132pjb.3
        for <git@vger.kernel.org>; Thu, 07 May 2020 23:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRK7gtV7Y1zZzYuGH43LQ64YbS1s88BrlDhpgh3kEUs=;
        b=aDln52sCs5U1s1rLU5NPXFtfi8B6deBm/TUnn+31h+6OT6j4IBP/TnCJbimOE1ZRWJ
         kYEaOKFW+GQBUZTloy9pKdOuZgfRX8bNTeyr13OIW4l40m6XPUx9UcWMv6UZis/ahySn
         HIEv9RoAfn8tBWCLxmY1/LQYMKKynNDYd293/GF6CktF8RbkGx0jJGiK+um+Tv+9/XPq
         hvPc8mhYrgD+OTfYFaBPgfC2aVpLaqjeTYvkDlsO23g9rSM6kt0M1ClGteIJNGkJ5voV
         bP7k7aomkgAqcIifjzIeicrOp8iswffJFW75Qn/3jthyuIGGzagzGzX3ks/3j/2pik/b
         QeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRK7gtV7Y1zZzYuGH43LQ64YbS1s88BrlDhpgh3kEUs=;
        b=lZmhpTY/nzHDr9AvOV5BoOVs7QN5tBsauZ+puhR8azQTor0jyl3HiO3gsGWJ+QlEon
         1j4wmS1Qk52x8t//03cYd083eMmGQ4fgPC8e6Lj+YUSHLQWD38OWd1WLGC2+8+gP/pwC
         qgWIreAGGL/BrO4v0rlQVBy3KnmWZWvhdU9GHfU35nTjLD5stXmbPj4daiW3yG4f1ARH
         X+lWKKgusku0KyyulZRlQ/NSJClISUhpTOqu2evjLdZE2pnBwWkNq3/PlK9HcBAPZBuF
         +B/XDLqKKMi9Y7Ee/xJ4WlcxSqUaJTx0edOX/1eRAdUlFMyh/1av7xF/evkpB2aiqQVZ
         M2xw==
X-Gm-Message-State: AGi0PuZqj+s2qQ7bHt3CsQJj4iX9IN1bMJGTXrykVZ4BGtfqxHQesKIB
        vimd9BOwKj4b+F+5Qb1tkv6o9UrbORkCdg==
X-Google-Smtp-Source: APiQypJeNmQge2RYOWspjUN6aJaP5PNRO6GvwHzIEuX8WAinwuW+BbraEjn5zj6WypsBV5w79DRRag==
X-Received: by 2002:a17:902:9f8a:: with SMTP id g10mr911417plq.233.1588918909167;
        Thu, 07 May 2020 23:21:49 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id 4sm712289pff.18.2020.05.07.23.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:21:48 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com
Subject: [PATCH v5] submodule: port subcommand 'set-url' from shell to C
Date:   Fri,  8 May 2020 11:51:36 +0530
Message-Id: <20200508062136.15257-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert submodule subcommand 'set-url' to a builtin. Port 'set-url' to
'submodule--helper.c' and call the latter via 'git-submodule.sh'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 37 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 22 +---------------------
 2 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a4b391c88..8bc7b4cfa6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2246,6 +2246,42 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	usage_with_options(git_submodule_helper_usage, module_config_options);
 }
 
+static int module_set_url(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0;
+	const char *newurl;
+	const char *path;
+	char* config_name;
+
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
+		OPT_END()
+	};
+	const char *const usage[] = {
+		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	path = argv[0];
+	newurl = argv[1];
+
+	if (argc != 2 || !path || !newurl) {
+		usage_with_options(usage, options);
+		return 1;
+	}
+
+	config_name = xstrfmt("submodule.%s.url", path);
+
+	config_set_in_gitmodules_file_gently(config_name, newurl);
+	sync_submodule(path, prefix, quiet ? OPT_QUIET : 0);
+
+	free(config_name);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2276,6 +2312,7 @@ static struct cmd_struct commands[] = {
 	{"is-active", is_active, 0},
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
+	{"set-url", module_set_url, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 08e0439df0..39ebdf25b5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -805,27 +805,7 @@ cmd_set_url() {
 		shift
 	done
 
-	if test $# -ne 2
-	then
-		usage
-	fi
-
-	# we can't use `git submodule--helper name` here because internally, it
-	# hashes the path so a trailing slash could lead to an unintentional no match
-	name="$(git submodule--helper list "$1" | cut -f2)"
-	if test -z "$name"
-	then
-		exit 1
-	fi
-
-	url="$2"
-	if test -z "$url"
-	then
-		exit 1
-	fi
-
-	git submodule--helper config submodule."$name".url "$url"
-	git submodule--helper sync ${GIT_QUIET:+--quiet} "$name"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
 }
 
 #
-- 
2.26.2

