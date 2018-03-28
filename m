Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19A91F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753728AbeC1WVs (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:21:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42004 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753586AbeC1WVq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:21:46 -0400
Received: by mail-pf0-f195.google.com with SMTP id a16so1791411pfn.9
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ueyDCwffjZ+YPRmCo/Q0c8fDwQKQDAaU4OC0D+472b4=;
        b=0jAeN/uJ9m/vEOaBxReFvfu+Bg1fgCoTZAV5KaV6e07d8eNr3Tlp/61yt+im2VRQTx
         9LHRdIHpGgj7sfe6u7wiAAKXDTnQoQi9y5g8lzD18GKhss+Jh5AWTPDTW1MriExkxvgP
         PYjhCNaCgEtsxVwyz7n+F5EUPhPiMo7MbIB8a34ssdtTYDzcRgTQxOM0q4zoVtJsYqbD
         S8r4MUt64Ev0HZ+mapewvM2Md+oiGgZPYdVxDnGk8BaFpmVn2rYPtDY8S6Jhn3p7P+uQ
         rmBQK9O4KPNRG93yNBJtvqq/BDYlHIr80FWO8ZOZl57JvKEa6lTT5BGOK1xOOutDFl8C
         ggMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ueyDCwffjZ+YPRmCo/Q0c8fDwQKQDAaU4OC0D+472b4=;
        b=oACmDiNrhO6O9Kvc3ns0xvmE1QsWSCaEP2Nqmqos743Wjw2owJANZ+jYrGJ6PN16Eg
         w4KPBWuw+JsXS5LVFXiaCsnSKe9tZzt9tGT/i87mp6/uxkqn7LIi1jHr+b3bKP4peYei
         cmewbDEmV4kUpTwOBrLvmbzeBQdsX6BBYh9CT2DrqwcNrNgAayWoD9SO1f/hWLhfMVtq
         fObBUeNgLxXdnvYq3VzCod7lPePUcbFKfBoBVZ7nmG05CJgrM3ShowHSRMKznNXoJTaI
         G4L90sktjWKTXbhJ5ZH5GW6G6NhvxDuWUpgEOfRslnzhd7aBSBKgM6Kbl2+QlYcS97F1
         uepA==
X-Gm-Message-State: AElRT7G+asQMOukJ+NCkZLDnyMd2WplPT1WF4O34/3mUNWPStYGC6NFw
        P/DSSF7HKthnpYEa/SWvTSJQEv4=
X-Google-Smtp-Source: AIpwx48Cd8pMZOv9OUJL3whg/mi0HD71CWNSpLbpDHPZAaXpOaJmDPdcWWh4Pa3cGZHksYDCu6+trg==
X-Received: by 10.98.170.13 with SMTP id e13mr4300760pff.137.1522275705876;
        Wed, 28 Mar 2018 15:21:45 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id e23sm8801907pfi.76.2018.03.28.15.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 15:21:45 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v4 3/5] stash: convert drop and clear to builtin
Date:   Wed, 28 Mar 2018 15:21:27 -0700
Message-Id: <20180328222129.22192-4-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328222129.22192-1-joel@teichroeb.net>
References: <20180328222129.22192-1-joel@teichroeb.net>
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
index 00e854734..640c545f5 100644
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
@@ -168,6 +180,29 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
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
@@ -412,6 +447,68 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
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
@@ -434,6 +531,10 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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

