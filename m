Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49D51F404
	for <e@80x24.org>; Tue, 27 Mar 2018 05:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbeC0Fph (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 01:45:37 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46321 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeC0Fpg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 01:45:36 -0400
Received: by mail-pl0-f66.google.com with SMTP id f5-v6so13463902plj.13
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 22:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LhqHx/K6sEXkF8rYFqm90TwskVnHM0FEzo7F8ILLKVY=;
        b=p3A7tHCf4k4DPDOlHbwUaejXO804ml43FnKkYITVn7HFHsq8qpUz4/P59PsLqMQpSb
         mnwczqlrSmTuZ/b4GCY6QYU4wgOyw1Yr+3SMgYNWa34pcO4IMUGSjKlROfof3kuUxDfY
         lr7S8F9jPZS1d6or2nxyFSo5bD5ueuXK1PQOucXqQEXYTu2sdKr0bj9O+0wFF1PI/wDZ
         bFmh95GkoIX7vz2lQyFzU60Vo7+YZEksabKnKtcg++T1E1sen4474O0WSp/XWX5ozgpL
         0Hne4/JvzG0uJb0YrTXUtdwuAeksz4lYCQL4nICRKW9t5UDOt2VB7bU3eVNmmS/DfcQl
         /vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LhqHx/K6sEXkF8rYFqm90TwskVnHM0FEzo7F8ILLKVY=;
        b=f/5R37UNpj5WxQf2j/erapcCOnhrbwEM70OA3ElWiF5m6Xw+5E6TUzt6mAAmE8UbWp
         JtNpr6nufG20v+fAvLUzDQgnw4DUbnB/ZQu26fqJRqWMLoonwIVNwH1K0wJWE9lMAQkI
         yM9sfnZpVDRXGGqFhZ+hhBfCoBfB9fEOttZF8jyjg4eCtTGeoVbAlKdmEg4JaF8xcm/A
         Myhw5KYq7jcxZfo6bXiRXdn04I63le7vf+GNIXt3BJfvHifctX57/DTdiFIWAlee7Y8I
         UOl95BUHFK3Bn98cJFPmHs30uIHuSH7RpIhhKD75BVU9S6/3DxiTF+Uwjt84Y/7xk/kE
         vfew==
X-Gm-Message-State: AElRT7GlwBw8wgxPe8Zt+tOcOOw1VyN9/SDbNsLRworu1PTx2uyNkgk7
        Rq6OEFXIAIN/3Z+fPVHLFUEFUVQ=
X-Google-Smtp-Source: AIpwx487Nf4SLzS/GX9iZkeEDp6V0VrYHQ33DNlFWuL6DfI180ZVUDzQyB43Btdc+naA9U2s8Kelag==
X-Received: by 2002:a17:902:b181:: with SMTP id s1-v6mr5749494plr.263.1522129535332;
        Mon, 26 Mar 2018 22:45:35 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id n8sm898733pff.131.2018.03.26.22.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 22:45:34 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v3 3/5] stash: convert drop and clear to builtin
Date:   Mon, 26 Mar 2018 22:44:30 -0700
Message-Id: <20180327054432.26419-4-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180327054432.26419-1-joel@teichroeb.net>
References: <20180327054432.26419-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the drop and clear commands to the builtin helper. These two
are each simple, but are being added together as they are quite
related.

We have to unfortunately keep the drop and clear functions in the
shell script as functions are called with parameters internally
that are not valid when the commands are called externally. Once
pop is converted they can both be removed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 builtin/stash--helper.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   4 +-
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index df3c8e1e6..0d7a0d55e 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -11,7 +11,14 @@
 #include "dir.h"
 
 static const char * const git_stash_helper_usage[] = {
+	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper clear"),
+	NULL
+};
+
+static const char * const git_stash_helper_drop_usage[] = {
+	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	NULL
 };
 
@@ -20,6 +27,11 @@ static const char * const git_stash_helper_apply_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_clear_usage[] = {
+	N_("git stash--helper clear"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static int quiet;
 static char stash_index_path[PATH_MAX];
@@ -166,6 +178,29 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	return 0;
 }
 
+static int do_clear_stash(void)
+{
+	struct object_id obj;
+	if (get_oid(ref_stash, &obj))
+		return 0;
+
+	return delete_ref(NULL, ref_stash, &obj, 0);
+}
+
+static int clear_stash(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, git_stash_helper_clear_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc != 0)
+		return error(_("git stash--helper clear with parameters is unimplemented"));
+
+	return do_clear_stash();
+}
+
 static int reset_tree(struct object_id *i_tree, int update, int reset)
 {
 	struct unpack_trees_options opts;
@@ -410,6 +445,68 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int do_drop_stash(const char *prefix, struct stash_info *info)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	int ret;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	argv_array_pushl(&args, "reflog", "delete", "--updateref", "--rewrite", NULL);
+	argv_array_push(&args, info->revision.buf);
+	ret = cmd_reflog(args.argc, args.argv, prefix);
+	if (!ret) {
+		if (!quiet)
+			printf(_("Dropped %s (%s)\n"), info->revision.buf, oid_to_hex(&info->w_commit));
+	} else {
+		return error(_("%s: Could not drop stash entry"), info->revision.buf);
+	}
+
+	cp.git_cmd = 1;
+	/* Even though --quiet is specified, rev-parse still outputs the hash */
+	cp.no_stdout = 1;
+	argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
+	argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
+	ret = run_command(&cp);
+
+	if (ret)
+		do_clear_stash();
+
+	return 0;
+}
+
+static int assert_stash_ref(struct stash_info *info)
+{
+	if (!info->is_stash_ref)
+		return error(_("'%s' is not a stash reference"), info->revision.buf);
+
+	return 0;
+}
+
+static int drop_stash(int argc, const char **argv, const char *prefix)
+{
+	struct stash_info info;
+	int ret;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_helper_drop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	if (assert_stash_ref(&info)) {
+		free_stash_info(&info);
+		return -1;
+	}
+
+	ret = do_drop_stash(prefix, &info);
+	free_stash_info(&info);
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	int result = 0;
@@ -432,6 +529,10 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_stash_helper_usage, options);
 	else if (!strcmp(argv[0], "apply"))
 		result = apply_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "clear"))
+		result = clear_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "drop"))
+		result = drop_stash(argc, argv, prefix);
 	else {
 		error(_("unknown subcommand: %s"), argv[0]);
 		usage_with_options(git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 0b5d1f374..0b8f07b38 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -652,7 +652,7 @@ apply)
 	;;
 clear)
 	shift
-	clear_stash "$@"
+	git stash--helper clear "$@"
 	;;
 create)
 	shift
@@ -664,7 +664,7 @@ store)
 	;;
 drop)
 	shift
-	drop_stash "$@"
+	git stash--helper drop "$@"
 	;;
 pop)
 	shift
-- 
2.16.2

