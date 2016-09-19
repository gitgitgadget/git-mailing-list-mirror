Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E49C2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 18:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbcISSxr (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 14:53:47 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36263 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbcISSxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 14:53:46 -0400
Received: by mail-pf0-f172.google.com with SMTP id q2so33541299pfj.3
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZ002yFqbL+O/yQIrtwUEqVjor1qQV/iPpfiC3cdCt8=;
        b=duRxq8RLwOUIokra/Dsnf+OJHCT7FM/7KyXz6LfPg+Db/LIROe0bBhozk0F0Z+fiPl
         J1LUXWKVu04J3nbW5qIWkxnJ291eo6OMCceT0UK1y2p6s2cIwX6PXZFGn2yy3elTa52P
         UAphNUdpDIiCFpZ7RR8nyAgSqlyLY/o/zCCzLkWCPE3uBot/6HEq6KauRJ96OrfJGi8S
         vhveQqQm0f9VvmnkHayObvU3jXPhP9K2JqSCqRxDSB0tWuhVuUmvtFhtVkDU6/72Jepo
         rlwZ3chQKZVfrTR8RfqFZCfc5sZs6ZqtSV12sTDDdl+Hmi6lc6D+CssJ1w1TU6+gXWxZ
         kQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tZ002yFqbL+O/yQIrtwUEqVjor1qQV/iPpfiC3cdCt8=;
        b=K03aT2Wb5SBKvClmQqHck8lR2O1QoRL8FeJ7N299djLOn7WssI+S0qKDv4BOtlPvYR
         iuqTdBZAKf3itt5sHC5gWwWRM8pXnUTsJYEeXo5AyMD2GiBat+eCtVW6yGSKpSjiPRpz
         tnTlSRjy8+BlR5IqoNYln2VbyLNqGl9rWcSZTTjrEE7W7UMuc1w2lXNmNifAwq+koOrg
         aCn36iU/KHMEZOfZuNwggAW5gxnGAS39VGi4kD8p9QLeEp/WSsIMICfaM022aHvVJUfD
         Rj/MNiZ6b+GOrj2m+EvXziMHmELGRdT9D+lBHeqp2ElXm5yYaGu2KILfym5bJa5C0GM8
         nPvg==
X-Gm-Message-State: AE9vXwNsS0h887SN8ysYADAtVqonW2iFD1GUI9e9pId4/pG8iuOmydaUuTmvVR/BL9yXnITt
X-Received: by 10.98.89.93 with SMTP id n90mr35537439pfb.184.1474311225397;
        Mon, 19 Sep 2016 11:53:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:d8c4:7fc2:20bf:cca7])
        by smtp.gmail.com with ESMTPSA id bn9sm33286027pab.39.2016.09.19.11.53.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Sep 2016 11:53:43 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH v2] ls-files: add pathspec matching for submodules
Date:   Mon, 19 Sep 2016 11:52:31 -0700
Message-Id: <1474311151-117883-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <CAKoko1qrAuLhn6qQax-BSZFhEqbFdiBbVrip8TD3NVjD8Xzy0g@mail.gmail.com>
References: <CAKoko1qrAuLhn6qQax-BSZFhEqbFdiBbVrip8TD3NVjD8Xzy0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pathspecs can be a bit tricky when trying to apply them to submodules.
The main challenge is that the pathspecs will be with respect to the
super module and not with respect to paths in the submodule.  The
approach this patch takes is to pass in the identical pathspec from the
super module to the submodule in addition to the submodule-prefix, which
is the path from the root of the super module to the submodule, and then
we can compare an entry in the submodule prepended with the
submodule-prefix to the pathspec in order to determine if there is a
match.

This patch also permits the pathspec logic to perform a prefix match against
submodules since a pathspec could refer to a file inside of a submodule.
This can can result in false positive matches since a super module
doesn't know what files could be in the submodule.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-ls-files.txt         |   4 +-
 builtin/ls-files.c                     | 144 ++++++++++++++++++++-------------
 dir.c                                  |  67 ++++++++++++++-
 dir.h                                  |   4 +
 t/t3007-ls-files-recurse-submodules.sh |  66 +++++++++++++--
 5 files changed, 215 insertions(+), 70 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index a623ebf..09e4449 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -19,7 +19,7 @@ SYNOPSIS
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
 		[--full-name] [--recurse-submodules]
-		[--output-path-prefix=<path>]
+		[--submodule-prefix=<path>]
 		[--abbrev] [--] [<file>...]
 
 DESCRIPTION
@@ -143,7 +143,7 @@ a space) at the start of each line:
 	Recursively calls ls-files on each submodule in the repository.
 	Currently there is only support for the --cached mode.
 
---output-path-prefix=<path>::
+--submodule-prefix=<path>::
 	Prepend the provided path to the output of each file
 
 --abbrev[=<n>]::
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 687e475..1417f44 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -29,7 +29,7 @@ static int show_valid_bit;
 static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
-static const char *output_path_prefix;
+static const char *submodule_prefix;
 static int recurse_submodules;
 
 static const char *prefix;
@@ -78,9 +78,9 @@ static void write_name(const char *name)
 	 * churn.
 	 */
 	static struct strbuf full_name = STRBUF_INIT;
-	if (output_path_prefix && *output_path_prefix) {
+	if (submodule_prefix && *submodule_prefix) {
 		strbuf_reset(&full_name);
-		strbuf_addstr(&full_name, output_path_prefix);
+		strbuf_addstr(&full_name, submodule_prefix);
 		strbuf_addstr(&full_name, name);
 		name = full_name.buf;
 	}
@@ -177,12 +177,34 @@ static void show_gitlink(const struct cache_entry *ce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status;
+	int i;
 
 	argv_array_push(&cp.args, "ls-files");
 	argv_array_push(&cp.args, "--recurse-submodules");
-	argv_array_pushf(&cp.args, "--output-path-prefix=%s%s/",
-			 output_path_prefix ? output_path_prefix : "",
+	argv_array_pushf(&cp.args, "--submodule-prefix=%s%s/",
+			 submodule_prefix ? submodule_prefix : "",
 			 ce->name);
+	/* add options */
+	if (show_eol)
+		argv_array_push(&cp.args, "--eol");
+	if (show_valid_bit)
+		argv_array_push(&cp.args, "-v");
+	if (show_stage)
+		argv_array_push(&cp.args, "--stage");
+	if (show_cached)
+		argv_array_push(&cp.args, "--cached");
+	if (debug_mode)
+		argv_array_push(&cp.args, "--debug");
+
+	/*
+	 * Pass in the original pathspec args.  The submodule will be
+	 * responsible for prepending the 'submodule_prefix' prior to comparing
+	 * against the pathspec for matches.
+	 */
+	argv_array_push(&cp.args, "--");
+	for (i = 0; i < pathspec.nr; ++i)
+		argv_array_push(&cp.args, pathspec.items[i].original);
+
 	cp.git_cmd = 1;
 	cp.dir = ce->name;
 	status = run_command(&cp);
@@ -192,57 +214,62 @@ static void show_gitlink(const struct cache_entry *ce)
 
 static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 {
+	struct strbuf name = STRBUF_INIT;
 	int len = max_prefix_len;
+	if (submodule_prefix)
+		strbuf_addstr(&name, submodule_prefix);
+	strbuf_addstr(&name, ce->name);
 
 	if (len >= ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
-	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
-			    len, ps_matched,
-			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
-		return;
-	if (recurse_submodules && S_ISGITLINK(ce->ce_mode)) {
+	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
+	    submodule_path_match(&pathspec, name.buf, ps_matched)) {
 		show_gitlink(ce);
-		return;
-	}
+	} else if (match_pathspec(&pathspec, name.buf, name.len,
+				  len, ps_matched,
+				  S_ISDIR(ce->ce_mode) ||
+				  S_ISGITLINK(ce->ce_mode))) {
+		if (tag && *tag && show_valid_bit &&
+		    (ce->ce_flags & CE_VALID)) {
+			static char alttag[4];
+			memcpy(alttag, tag, 3);
+			if (isalpha(tag[0]))
+				alttag[0] = tolower(tag[0]);
+			else if (tag[0] == '?')
+				alttag[0] = '!';
+			else {
+				alttag[0] = 'v';
+				alttag[1] = tag[0];
+				alttag[2] = ' ';
+				alttag[3] = 0;
+			}
+			tag = alttag;
+		}
 
-	if (tag && *tag && show_valid_bit &&
-	    (ce->ce_flags & CE_VALID)) {
-		static char alttag[4];
-		memcpy(alttag, tag, 3);
-		if (isalpha(tag[0]))
-			alttag[0] = tolower(tag[0]);
-		else if (tag[0] == '?')
-			alttag[0] = '!';
-		else {
-			alttag[0] = 'v';
-			alttag[1] = tag[0];
-			alttag[2] = ' ';
-			alttag[3] = 0;
+		if (!show_stage) {
+			fputs(tag, stdout);
+		} else {
+			printf("%s%06o %s %d\t",
+			       tag,
+			       ce->ce_mode,
+			       find_unique_abbrev(ce->sha1,abbrev),
+			       ce_stage(ce));
+		}
+		write_eolinfo(ce, ce->name);
+		write_name(ce->name);
+		if (debug_mode) {
+			const struct stat_data *sd = &ce->ce_stat_data;
+
+			printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
+			printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
+			printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
+			printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
+			printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
 		}
-		tag = alttag;
 	}
 
-	if (!show_stage) {
-		fputs(tag, stdout);
-	} else {
-		printf("%s%06o %s %d\t",
-		       tag,
-		       ce->ce_mode,
-		       find_unique_abbrev(ce->sha1,abbrev),
-		       ce_stage(ce));
-	}
-	write_eolinfo(ce, ce->name);
-	write_name(ce->name);
-	if (debug_mode) {
-		const struct stat_data *sd = &ce->ce_stat_data;
-
-		printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
-		printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
-		printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
-		printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
-		printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
-	}
+	strbuf_release(&name);
 }
 
 static void show_ru_info(void)
@@ -510,7 +537,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		{ OPTION_SET_INT, 0, "full-name", &prefix_len, NULL,
 			N_("make the output relative to the project top directory"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
-		OPT_STRING(0, "output-path-prefix", &output_path_prefix,
+		OPT_STRING(0, "submodule-prefix", &submodule_prefix,
 			N_("path"), N_("prepend <path> to each file")),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
 			N_("recurse through submodules")),
@@ -566,27 +593,28 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		setup_work_tree();
 
 	if (recurse_submodules &&
-	    (show_stage || show_deleted || show_others || show_unmerged ||
-	     show_killed || show_modified || show_resolve_undo ||
-	     show_valid_bit || show_tag || show_eol))
-		die("ls-files --recurse-submodules can only be used in "
-		    "--cached mode");
+	    (show_deleted || show_others || show_unmerged ||
+	     show_killed || show_modified || show_resolve_undo))
+		die("ls-files --recurse-submodules unsupported mode");
 
 	if (recurse_submodules && error_unmatch)
 		die("ls-files --recurse-submodules does not support "
 		    "--error-unmatch");
 
-	if (recurse_submodules && argc)
-		die("ls-files --recurse-submodules does not support path "
-		    "arguments");
-
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       prefix, argv);
 
-	/* Find common prefix for all pathspec's */
-	max_prefix = common_prefix(&pathspec);
+	/*
+	 * Find common prefix for all pathspec's
+	 * This is used as a performance optimization which unfortunately cannot
+	 * be done when recursing into submodules
+	 */
+	if (recurse_submodules)
+		max_prefix = NULL;
+	else
+		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
 
 	/* Treat unmatching pathspec elements as errors */
diff --git a/dir.c b/dir.c
index 0ea235f..1afc3ff 100644
--- a/dir.c
+++ b/dir.c
@@ -63,6 +63,35 @@ int fspathncmp(const char *a, const char *b, size_t count)
 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
 }
 
+/**
+ * Used to perform prefix matching against a pathspec_item for determining if we
+ * should decend into a submodule.  This function can result in false positives
+ * since we are only trying to match the 'string' to a prefix of the 'pattern'
+ */
+static int prefix_fnmatch(const struct pathspec_item *item,
+		   const char *pattern, const char *string,
+		   int prefix)
+{
+	if (prefix > 0) {
+		if (ps_strncmp(item, pattern, string, prefix))
+			return WM_NOMATCH;
+		pattern += prefix;
+		string += prefix;
+	}
+
+	if (item->flags & PATHSPEC_ONESTAR) {
+		return WM_MATCH;
+	} else if (item->magic & PATHSPEC_GLOB) {
+		return wildmatch(pattern, string,
+				 WM_PATHNAME |
+				 (item->magic & PATHSPEC_ICASE ?
+				  WM_CASEFOLD : 0),
+				 NULL);
+	}
+
+	return WM_NOMATCH;
+}
+
 int git_fnmatch(const struct pathspec_item *item,
 		const char *pattern, const char *string,
 		int prefix)
@@ -207,8 +236,9 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
 
-#define DO_MATCH_EXCLUDE   1
-#define DO_MATCH_DIRECTORY 2
+#define DO_MATCH_EXCLUDE   (1<<0)
+#define DO_MATCH_DIRECTORY (1<<1)
+#define DO_MATCH_SUBMODULE (1<<2)
 
 /*
  * Does 'match' match the given name?
@@ -283,6 +313,24 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 			 item->nowildcard_len - prefix))
 		return MATCHED_FNMATCH;
 
+	/* Perform checks to see if "name" is a super set of the pathspec */
+	if (flags & DO_MATCH_SUBMODULE) {
+		int matched = 0;
+
+		/* Check if the name is a literal prefix of the pathspec */
+		if ((item->match[namelen] == '/') &&
+		    !ps_strncmp(item, match, name, namelen)) {
+			matched = MATCHED_RECURSIVELY;
+		/* Check if the name wildmatches to the pathspec */
+		} else if (item->nowildcard_len < item->len &&
+			   !prefix_fnmatch(item, match, name,
+					   item->nowildcard_len - prefix)) {
+			matched = MATCHED_FNMATCH;
+		}
+
+		return matched;
+	}
+
 	return 0;
 }
 
@@ -386,6 +434,21 @@ int match_pathspec(const struct pathspec *ps,
 	return negative ? 0 : positive;
 }
 
+/**
+ * Check if a submodule is a superset of the pathspec
+ */
+int submodule_path_match(const struct pathspec *ps,
+			 const char *submodule_name,
+			 char *seen)
+{
+	int matched = do_match_pathspec(ps, submodule_name,
+					strlen(submodule_name),
+					0, seen,
+					DO_MATCH_DIRECTORY |
+					DO_MATCH_SUBMODULE);
+	return matched;
+}
+
 int report_path_error(const char *ps_matched,
 		      const struct pathspec *pathspec,
 		      const char *prefix)
diff --git a/dir.h b/dir.h
index da1a858..97c83bb 100644
--- a/dir.h
+++ b/dir.h
@@ -304,6 +304,10 @@ extern int git_fnmatch(const struct pathspec_item *item,
 		       const char *pattern, const char *string,
 		       int prefix);
 
+extern int submodule_path_match(const struct pathspec *ps,
+				const char *submodule_name,
+				char *seen);
+
 static inline int ce_path_match(const struct cache_entry *ce,
 				const struct pathspec *pathspec,
 				char *seen)
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index caf3815..977f85c 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -69,9 +69,63 @@ test_expect_success 'ls-files recurses more than 1 level' '
 	test_cmp expect actual
 '
 
-test_expect_success '--recurse-submodules does not support using path arguments' '
-	test_must_fail git ls-files --recurse-submodules b 2>actual &&
-	test_i18ngrep "does not support path arguments" actual
+test_expect_success '--recurse-submodules and pathspecs setup' '
+	echo e >submodule/subsub/e.txt &&
+	git -C submodule/subsub add e.txt &&
+	git -C submodule/subsub commit -m "adding e.txt" &&
+	echo f >submodule/f.TXT &&
+	echo g >submodule/g.txt &&
+	git -C submodule add f.TXT g.txt &&
+	git -C submodule commit -m "add f and g" &&
+	echo h >h.txt &&
+	git add h.txt &&
+	git commit -m "add h" &&
+
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	h.txt
+	submodule/.gitmodules
+	submodule/c
+	submodule/f.TXT
+	submodule/g.txt
+	submodule/subsub/d
+	submodule/subsub/e.txt
+	EOF
+
+	git ls-files --recurse-submodules "*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--recurse-submodules and pathspecs' '
+	cat >expect <<-\EOF &&
+	h.txt
+	submodule/g.txt
+	submodule/subsub/e.txt
+	EOF
+
+	git ls-files --recurse-submodules "*.txt" >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	h.txt
+	submodule/f.TXT
+	submodule/g.txt
+	submodule/subsub/e.txt
+	EOF
+
+	git ls-files --recurse-submodules ":(icase)*.txt" >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	h.txt
+	submodule/f.TXT
+	submodule/g.txt
+	EOF
+
+	git ls-files --recurse-submodules ":(icase)*.txt" ":(exclude)submodule/subsub/*" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--recurse-submodules does not support --error-unmatch' '
@@ -82,18 +136,14 @@ test_expect_success '--recurse-submodules does not support --error-unmatch' '
 test_incompatible_with_recurse_submodules () {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
 		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
-		test_i18ngrep 'can only be used in --cached mode' actual
+		test_i18ngrep 'unsupported mode' actual
 	"
 }
 
-test_incompatible_with_recurse_submodules -v
-test_incompatible_with_recurse_submodules -t
 test_incompatible_with_recurse_submodules --deleted
 test_incompatible_with_recurse_submodules --modified
 test_incompatible_with_recurse_submodules --others
-test_incompatible_with_recurse_submodules --stage
 test_incompatible_with_recurse_submodules --killed
 test_incompatible_with_recurse_submodules --unmerged
-test_incompatible_with_recurse_submodules --eol
 
 test_done
-- 
2.8.0.rc3.226.g39d4020

