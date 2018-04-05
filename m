Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B72C1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeDEC2a (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:28:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46595 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752745AbeDEC20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:28:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id 59-v6so14333521plc.13
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y1TWmwGIz/nWq1xIWQdH2niEpK7IluUX6Ruh1YLX++I=;
        b=kEn9AlUkm8IExq1gvQ51E1e312NzIzHiGoGX7hCqvFmNsb6ZEDx3cKIQaiG9r/g7Ue
         vKjlsg+CLfUHR0d0LXrrFCBvvrd911UU1EL5OIuJE6vUHt9Hcs0Z6Vs2ZqMGqvniVLPs
         86IgDqj6GitrjPXdboVlkCYQAhUMR2boxN13uzSSnzjaQNo8HdASIU2mq/Cw3lpiSbem
         gAfXGlDOq+sG2f3lhHVYE6NhRAuyNK3Gobb91Gn9QTJcQLtYqdLvWh+tUmDpyDP0qdm/
         MD1vMjosoabNTpdSK3fUQgrSSIT21E7+RhHiWx4piWZLC5GYgvshBPCZ9OODY5yG7obG
         U/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y1TWmwGIz/nWq1xIWQdH2niEpK7IluUX6Ruh1YLX++I=;
        b=HKqAc3dug8VVtUM+Q/YbNRybtUxfIoYaZQq7qcegR7oMN52SyYZ0aOsFQbTh0OUHY0
         GcHKtKs0FBO8R5dkMsYc4L7SzlNaK8MljodU5Tvgt8DxgnZEgvd/LTBpivEz4qXJK0iZ
         0Xlv6xX3D6953U/O/U0m/60eeDKCeLrjL0FfaQg2/tHmTN3fB28g4b8CWz6SXL+VMJdH
         e5BvMki0CmcTlvBbfz+TzOUUDUMm/bl8Yhk6YmfKHzmquQuEVkXcSTK6CKEvWCBWVyGg
         12o9aU45NRKauB9snt35ME/x+QFrwCDyG9IyUGUkChW4rFkwk7NHca+HmaFPKml/mov1
         Ks4g==
X-Gm-Message-State: AElRT7GcImseC0msAwlPyy6AYNF9RSiVOkpwvJ/B8ytax0uuWy1GXzg+
        FVUmP/qfXZ4K1xGV57IV6OoHLqE=
X-Google-Smtp-Source: AIpwx4/b5Hrq1zO7d60qmgsv+nDJzm4MtwlpzzW8udqX/HuQVoow6eFwjdiWseFr62lo9dKVbdPOyw==
X-Received: by 2002:a17:902:9696:: with SMTP id n22-v6mr21548470plp.355.1522895305495;
        Wed, 04 Apr 2018 19:28:25 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id 86sm14194093pfh.93.2018.04.04.19.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:28:25 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v5 3/5] stash: convert drop and clear to builtin
Date:   Wed,  4 Apr 2018 19:28:08 -0700
Message-Id: <20180405022810.15796-4-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180405022810.15796-1-joel@teichroeb.net>
References: <20180405022810.15796-1-joel@teichroeb.net>
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
 builtin/stash--helper.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   4 +-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 9d00a9547d..520cd746c4 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,7 +12,14 @@
 #include "rerere.h"
 
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
 
@@ -21,6 +28,11 @@ static const char * const git_stash_helper_apply_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_clear_usage[] = {
+	N_("git stash--helper clear"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static int quiet;
 static struct strbuf stash_index_path = STRBUF_INIT;
@@ -134,6 +146,29 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
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
@@ -399,6 +434,74 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int do_drop_stash(const char *prefix, struct stash_info *info)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	int ret;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	/* reflog does not provide a simple function for deleting refs. One will
+	 * need to be added to avoid implementing too much reflog code here
+	 */
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
+	/* This could easily be replaced by get_oid, but currently it will throw a
+	 * fatal error when a reflog is empty, which we can not recover from
+	 */
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
@@ -421,6 +524,10 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.16.3

