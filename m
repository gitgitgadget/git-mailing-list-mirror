Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7981F404
	for <e@80x24.org>; Mon, 26 Mar 2018 01:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeCZBOq (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 21:14:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37402 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeCZBOn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 21:14:43 -0400
Received: by mail-pf0-f193.google.com with SMTP id t16so2678031pfh.4
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 18:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9XpKphDbQx2LcvoeizNpLEa+8Pn3SDhlkz9f/fEd3yE=;
        b=KYzxWz/fFx7xiLrf25l9z9+BwTCqQwinvrvpdwsmNjfrKcqISSc9VEYd3TzadN3kXL
         Wa2pOVIHPCS5YXCPacY7hDM2gLfI/i+TWgpsi2OyGx+WFNe2rZzBilEO7SyGVJ5CjCuH
         Sc6K9GMV90nOAuQIJSeOtSW8iZf+MFs6nW876CsVerqafsaD14uptoiCqHZjd2J77dGW
         KOYhU1F0y+5fHuaCLJLiVgVBsLaTkudZcAqqKphy+oo5g6BAjq6jopZ8HiicpDtYatSM
         mwQtDbWyAH9VJvQuJ07vsBCfeqCm1GD5How+G1ZVqY/yJMt0vvziTvZpZYvWfVysKVwv
         AS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9XpKphDbQx2LcvoeizNpLEa+8Pn3SDhlkz9f/fEd3yE=;
        b=oupv8UKWtYuqNH2NPzO3BQ9BZHsuj2nAv0aS/gqdE6CeCh2vUYGQOVg25O9LqEpv5L
         6V5LfbY3vHHT6mvVxfK5bkbr3cDkjIeF2fSHhtF9p/QLQwb/9Ql3/DaaxNzISWbp6OYV
         Wd+Y9cFxc5ElZiJfyOcIRSRnglk9+8+D7CKbm3uk1Q3ZewzQYpa+pbJccCSvSDR8YH0l
         xAbL1ENdM2ICo6ReqA2nSL35YHlhubiA4ein+N6Aj7DNRBV1qXiZMuSSQxbWC/k766EE
         c6vlaFvjk8YqX1i0vhu1HpMovUaJm82d3JKKnd664dYXK3xZmmvw0M0viVaeC3TP4UpL
         LBlA==
X-Gm-Message-State: AElRT7FHSDBkQYwDxlNRUhoIGeZQ0zv5khalNUXdLGcbo//gIanWZa0D
        WHjnu5vEQxKklidbSv3B4WzgAIs=
X-Google-Smtp-Source: AG47ELtKC9pAI+tplpUXBt626WU+VlgOpJUNub14QtXU0C+gC7n6ocbzwrGrn5gLtxCtND4zMWAaQA==
X-Received: by 10.99.111.139 with SMTP id k133mr27587596pgc.236.1522026882415;
        Sun, 25 Mar 2018 18:14:42 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id k70sm18664894pga.72.2018.03.25.18.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 18:14:41 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v2 4/6] stash: convert drop and clear to builtin
Date:   Sun, 25 Mar 2018 18:14:24 -0700
Message-Id: <20180326011426.19159-5-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180326011426.19159-1-joel@teichroeb.net>
References: <20180326011426.19159-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 builtin/stash--helper.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   4 +-
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 050de415b4..640de6d0aa 100644
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
@@ -399,6 +434,68 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
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
+		destroy_stash_info(&info);
+		return -1;
+	}
+
+	ret = do_drop_stash(prefix, &info);
+	destroy_stash_info(&info);
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	int result = 0;
@@ -421,6 +518,10 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
index 0b5d1f3743..0b8f07b38a 100755
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

