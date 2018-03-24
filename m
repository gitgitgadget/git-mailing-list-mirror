Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F4A1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 17:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeCXRhp (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 13:37:45 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36409 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeCXRhn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 13:37:43 -0400
Received: by mail-pl0-f66.google.com with SMTP id 91-v6so1546445pld.3
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+s7vcu8dPt1CPBw4T+1utVD7m/qXMrPfxknHSEYjtM=;
        b=ZRLTKNQZjyMMah613LHFwEuGczlTYnf5CdspNzuyMVnCU9/s27z6yGfFp/i15p+tUK
         ZfTuG7++2JarQkJyaavq3B5AQi1WX1oD2u5pJWqRrBWge7ehi/boQCCRMv5AOKskI20N
         +wi0dcQ4a+K9fG094AL3EgzXP34stmzb4vTcI9p5NexYp1QYXy4IzuG8TWJTfNd8VGBm
         h1hMNKR52gDx30WREAiv61bYOy5z/oVer/4+3D1pdOv2xi6Ra4AE0kwf94HplkAH5g7r
         cql2ayP2ntmP10vAIHuctiMOdiGZUUYrf3xZcYeAiJSLIBbzNJw3wPj6E++qhwc3R9pU
         GPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0+s7vcu8dPt1CPBw4T+1utVD7m/qXMrPfxknHSEYjtM=;
        b=K41kUq7QOTG1WMHwhRuUi2xTis5WORrzewiTwYROEuo7HqdqHh+KWvMuOKGonB9R1E
         FHgCl4HdPXJ8v8x2SZdSOavSq5nmgyy0P/YozDoiGTpqysEaBfKDpVCKV4Dw4W5PAHYs
         Gg0WKirtt5orDULUW2Zh98ir+Ic2epN1bo+KJ0zTtQXaYyGHCGhV3OvvWJsbtMRFfkE7
         wLPwa+70R/3scOpzLsTiSUT3Z8f4KUTyavI4ygIWqd1diGlvJ8JH53137itbUuMTl0ke
         MQUGkY0na+W+elK3fw78m10wT+mVHZ5yG8HMuXuDgEb4TvJPnTnwaLRz+Y6p36CprLkb
         g0qw==
X-Gm-Message-State: AElRT7FJlCtOobWypPId+M7oDE8LWfSAe5GqkTwms9Do2EpFYPzA8qYP
        Be5i6UIsSHatl3ZbK6CN5Qi4xzQ=
X-Google-Smtp-Source: AG47ELsEjH6pmVRbGU9rTgrqFtOna09mHFEHCYroeRJchratmOHzanfBtyvxrQ6hUlDp7Y5jYd2vvQ==
X-Received: by 2002:a17:902:51ad:: with SMTP id y42-v6mr31096940plh.314.1521913062767;
        Sat, 24 Mar 2018 10:37:42 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id z6sm22005486pfe.9.2018.03.24.10.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 10:37:42 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH 3/4] stash: convert drop and clear to builtin
Date:   Sat, 24 Mar 2018 10:37:06 -0700
Message-Id: <20180324173707.17699-4-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324173707.17699-1-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/stash--helper.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |  4 +--
 2 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 18c4aba665..1598b82ac2 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -11,8 +11,15 @@
 #include "dir.h"
 
 static const char * const git_stash_helper_usage[] = {
+	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
+	N_("git stash--helper clear"),
+	NULL
+};
+
+static const char * const git_stash_helper_drop_usage[] = {
+	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	NULL
 };
 
@@ -26,6 +33,11 @@ static const char * const git_stash_helper_branch_usage[] = {
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
@@ -114,6 +126,29 @@ static int get_stash_info(struct stash_info *info, const char *commit)
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
 static int reset_tree(struct object_id i_tree, int update, int reset)
 {
 	struct unpack_trees_options opts;
@@ -313,6 +348,60 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	return do_apply_stash(prefix, &info, index);
 }
 
+static int do_drop_stash(const char *prefix, struct stash_info *info)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	int ret;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	argv_array_pushl(&args, "reflog", "delete", "--updateref", "--rewrite", NULL);
+	argv_array_push(&args, info->revision);
+	ret = cmd_reflog(args.argc, args.argv, prefix);
+	if (!ret) {
+		if (!quiet) {
+			printf(_("Dropped %s (%s)\n"), info->revision, sha1_to_hex(info->w_commit.hash));
+		}
+	} else {
+		return error(_("%s: Could not drop stash entry"), info->revision);
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
+static int drop_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *commit = NULL;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_helper_drop_usage, 0);
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
+	return do_drop_stash(prefix, &info);
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	const char *commit = NULL, *branch = NULL;
@@ -371,6 +460,10 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_stash_helper_usage, options);
 	else if (!strcmp(argv[0], "apply"))
 		result = apply_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "clear"))
+		result = clear_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "drop"))
+		result = drop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		result = branch_stash(argc, argv, prefix);
 	else {
diff --git a/git-stash.sh b/git-stash.sh
index 360643ad4e..54d0a6c21f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -716,7 +716,7 @@ apply)
 	;;
 clear)
 	shift
-	clear_stash "$@"
+	git stash--helper clear "$@"
 	;;
 create)
 	shift
@@ -728,7 +728,7 @@ store)
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

