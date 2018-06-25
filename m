Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBBB51F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933860AbeFYQnk (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:43:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54464 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754979AbeFYQnh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:43:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so3066434wmf.4
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EECa6Wc+0CtDQdTp9nJVfpXPJT1vPfXdQBy5YoIfDOU=;
        b=YC2LKqdQa3YMdeeUTHHkwZPLXbpmpbEcxoaMXBSNdROpENOiWKTVeJGbE2SM1CQeA0
         TDsxBKs5yorkw13WHwcBTlHdi6KfOW5Hh1rfy+/9DZY6xGRvTfqPL5pDQ4Q2zDnis0xv
         FvgPYs3dH3J8ebZzldfgUsRY8jnNM+CwE98GNCV+9ljHwyYbqO6Khfl4Ug33HlVuk2Oq
         XWjFccac6QxumA3EAkZhi/rDZ8kl5o9UNQe7Dlwrwh+C9pzNJ2j7Bz+x25rSVbAW69Mm
         ua54iKpelQM9W+k3ksN7u0TpvTGWbpKyB7PCvU8CVkmXyJPZOgsIxLxj9sgiL9n1c+0/
         nFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EECa6Wc+0CtDQdTp9nJVfpXPJT1vPfXdQBy5YoIfDOU=;
        b=M07QPfjwtwqpC7CXb8uKjVB+kHYTgN3lALI458rHByTXM2SWVIdRVxJAlt2rmh2nVy
         EJj48pTQWR4SPksLjtrgQohLTReTEBDc0qr7Oaqfq5GZ2u6HCYd+q3JWNj7waEmwR3Zy
         TSRE2fMNmEhk9EGgPYL6Jf4517Ptaj7JlVWnlg8V11rr/YARI3m4YFXHvbG2mxqcc3pt
         Qw64SvSLXcl+dua/ZcMu7+At480d2JVh1it8uaDzPbL4NFtbqD0B2r2c4VBQo3WUsfGJ
         k0pMGg1UQh/zcmvtI+6KCV0D2E5EipaK04KBPK3256CoQ/ZMMYE/Yy/8KnoZ4wOPAber
         6Aiw==
X-Gm-Message-State: APt69E3lg/v+O0Ja2MBXvl/7zL39F41+ZnB7Ce1pfILaRXcHJ1xN2xbC
        +UEPvKJxjga1W4JcQ+uNvbUaww8/
X-Google-Smtp-Source: AAOMgpdC39XCE5D6QgDXZhMGuS0kWg/o4Neo+I7fPSrPnUJjqZOz+Q54accgvPZ+rbpjRDYTXAAWuw==
X-Received: by 2002:a1c:e8c:: with SMTP id 134-v6mr1649722wmo.51.1529945015640;
        Mon, 25 Jun 2018 09:43:35 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id b124-v6sm14287200wmf.11.2018.06.25.09.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:43:34 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 2/4] stash: convert drop and clear to builtin
Date:   Mon, 25 Jun 2018 19:43:24 +0300
Message-Id: <5373f422a82da2357828b8cc4a2b84fb2bedd780.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add the drop and clear commands to the builtin helper. These two
are each simple, but are being added together as they are quite
related.

We have to unfortunately keep the drop and clear functions in the
shell script as functions are called with parameters internally
that are not valid when the commands are called externally. Once
pop is converted they can both be removed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 112 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   4 +-
 2 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 1c4387b10..84a537f39 100644
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
@@ -139,6 +151,31 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
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
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_clear_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
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
@@ -414,6 +451,77 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int do_drop_stash(const char *prefix, struct stash_info *info)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int ret;
+
+	/*
+	 * reflog does not provide a simple function for deleting refs. One will
+	 * need to be added to avoid implementing too much reflog code here
+	 */
+	argv_array_pushl(&args, "reflog", "delete", "--updateref", "--rewrite",
+			 NULL);
+	argv_array_push(&args, info->revision.buf);
+	ret = cmd_reflog(args.argc, args.argv, prefix);
+	if (!ret) {
+		if (!quiet)
+			printf(_("Dropped %s (%s)\n"), info->revision.buf,
+			       oid_to_hex(&info->w_commit));
+	} else {
+		return error(_("%s: Could not drop stash entry"), info->revision.buf);
+	}
+
+	/*
+	 * This could easily be replaced by get_oid, but currently it will throw a
+	 * fatal error when a reflog is empty, which we can not recover from
+	 */
+	cp.git_cmd = 1;
+	/* Even though --quiet is specified, rev-parse still outputs the hash */
+	cp.no_stdout = 1;
+	argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
+	argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
+	ret = run_command(&cp);
+
+	/* do_clear_stash if we just dropped the last stash entry */
+	if (ret)
+		do_clear_stash();
+
+	return 0;
+}
+
+static void assert_stash_ref(struct stash_info *info)
+{
+	if (!info->is_stash_ref) {
+		free_stash_info(info);
+		error(_("'%s' is not a stash reference"), info->revision.buf);
+		exit(128);
+	}
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
+			     git_stash_helper_drop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	assert_stash_ref(&info);
+
+	ret = do_drop_stash(prefix, &info);
+	free_stash_info(&info);
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -436,6 +544,10 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_stash_helper_usage, options);
 	if (!strcmp(argv[0], "apply"))
 		return !!apply_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "clear"))
+		return !!clear_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "drop"))
+		return !!drop_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 809b1c2d1..a99d5dc9e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -653,7 +653,7 @@ apply)
 	;;
 clear)
 	shift
-	clear_stash "$@"
+	git stash--helper clear "$@"
 	;;
 create)
 	shift
@@ -665,7 +665,7 @@ store)
 	;;
 drop)
 	shift
-	drop_stash "$@"
+	git stash--helper drop "$@"
 	;;
 pop)
 	shift
-- 
2.18.0.rc2.13.g506fc12fb

