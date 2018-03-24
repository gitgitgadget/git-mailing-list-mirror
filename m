Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39191F404
	for <e@80x24.org>; Sat, 24 Mar 2018 17:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeCXRhr (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 13:37:47 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:37126 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeCXRhq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 13:37:46 -0400
Received: by mail-pl0-f46.google.com with SMTP id w12-v6so9345913plp.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b22YYQ8CDeglEv+kazdOaPeRQhm5NFSUzQHz3WqAFfA=;
        b=bRC2CilHh3ADTSE51WjXw8RgSW+cMj7DTyshjDEamSQd5puUHZRBZ3eTwC8x/zaF1t
         ZuKMtLMVNO3fzGLJIpbLCA1wr9iBroqBBk9OM32by2a7If4A+mbB9HGMZzskDTO4wioI
         2XNZblQ0JhiERfed4N4H+trYN4GooW2CYzghOgKAqCcJouwBw382qqzatNsh/MHw16mj
         80bxB8iDmZo4BXtxon2OUufm8g16QluT6W8QWPCz3NKQnwJfOSMHr1frbr+I4m+UGtv9
         BOzfLgkvoR4G5clUlQlpBYlkg/szS/iS+a3f3dKjlOHIby9KoQj1NOdNL0RDyY1P+Krq
         Nhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b22YYQ8CDeglEv+kazdOaPeRQhm5NFSUzQHz3WqAFfA=;
        b=ZshXSk63lWUq2YVi9aGDFcv+idViZ2ONlzvCd7kYMR2RbWoZzGoVQdYGXj0gtbr9yP
         jhGyzf+DFOEAD7RV6i/afw1D0A0FnbOgVBc2GNpSUbsC0jvvYRwHxLXB1rZMl8iwbRuP
         tm2jytaJaU/WufSplumkfCDbRgziiHgGLlr+ggr5YKuNIFU2cl0Arp9WGQyfw+ParptE
         Lf11HHszkvOTMmWUHBatwp9hllFP/+5V17YTVg5jqocmKSn2PhKGoYWZewaZKHs/MwGP
         XMMqCyfSOEQzlq0T0wxd8f6Bg9vmDKpVxJ1hI7Eksn99FDT9mJrhrF5yi3DG4BsE0LNt
         vFPQ==
X-Gm-Message-State: AElRT7G3hgx27qFbmnD5len5qZO/qZQuzUW1I19vAUxWicFFvQ6mBrxr
        gZa9YFJK4esalZ1euI6kG2VoMMM=
X-Google-Smtp-Source: AG47ELu6APd3lzSYUzk4ibMUs6r8t3Wlhll2q/WQwNs8Wg16DbInJIO/S6L0hNg/LVYRIg6pSol+tA==
X-Received: by 2002:a17:902:7142:: with SMTP id u2-v6mr33966126plm.257.1521913066163;
        Sat, 24 Mar 2018 10:37:46 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id z6sm22005486pfe.9.2018.03.24.10.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 10:37:45 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH 4/4] stash: convert pop to builtin
Date:   Sat, 24 Mar 2018 10:37:07 -0700
Message-Id: <20180324173707.17699-5-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324173707.17699-1-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/stash--helper.c | 38 ++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |  3 ++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 1598b82ac2..b912f84c97 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
@@ -23,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_pop_usage[] = {
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_apply_usage[] = {
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	NULL
@@ -402,6 +408,36 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return do_drop_stash(prefix, &info);
 }
 
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int index = 0;
+	const char *commit = NULL;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			N_("attempt to ininstate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_helper_pop_usage, 0);
+
+	if (argc == 1)
+		commit = argv[0];
+
+	if (get_stash_info(&info, commit))
+		return -1;
+
+	if (!info.is_stash_ref)
+		return error(_("'%s' is not a stash reference"), commit);
+
+	if (do_apply_stash(prefix, &info, index))
+		return -1;
+
+	return do_drop_stash(prefix, &info);
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	const char *commit = NULL, *branch = NULL;
@@ -464,6 +500,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		result = clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		result = drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		result = pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		result = branch_stash(argc, argv, prefix);
 	else {
diff --git a/git-stash.sh b/git-stash.sh
index 54d0a6c21f..d595bbaf64 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -732,7 +732,8 @@ drop)
 	;;
 pop)
 	shift
-	pop_stash "$@"
+	cd "$START_DIR"
+	git stash--helper pop "$@"
 	;;
 branch)
 	shift
-- 
2.16.2

