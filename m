Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58C4C43217
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbiKSMl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiKSMli (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:41:38 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8937D519
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:36 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bj12so18962771ejb.13
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssYWGGouKBApoA2quB1y6MP5G+A6+oXdhcQDh/W8eDk=;
        b=JNolCjAboqLzxUXx0L8HkB9dENQMQos35vbfG/DmMBi5UcDIb4rC1OXG34QdskxyWi
         /tFQkYxEgnPdu7TxuTgtKYtrA+1F74IMDMesLWaTV293VbJvHjpA3hNMPDbPFn3faiIq
         44Q54rbudDRXb5B9ApN5IusHtSeI3VrsrpXb0mDBDJKygRIUNW4p/Vm1W0SoWbp/1Ait
         Ydywo6OW+gpr++kEPjkNQ4bB1fwScKMDlB7ajuhkHiNlsXFVq4TLN+63VBiRa8G+zQ+S
         faxp8U6VDDuQw7jq4gQWVHudMTqE1HgfIc7sStesVYlMEh9KoxUNVQQRZqReKJDBsy9b
         sstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssYWGGouKBApoA2quB1y6MP5G+A6+oXdhcQDh/W8eDk=;
        b=sz9QQG3C/ikAbLGvPkpWG8kD2q0PSuvCVttIyTHTk6C3quR/s3AQKkcEAHavJQVF0H
         hqWg6zJi334MTQkn9sdZu7yqqteEjM47phWdC6Nimu81xjRe/ZDUNzb/YUw9naKmUOpH
         qa6p1cnPAPI+IlXNIC7paHN96zl9PYPOluyAC0MAyVeB48CK7NLMUbq06NSvv1IzCas8
         vn6vFz3c1n/I9wAeURKaw0lzo8oB2RuKYVslebfESPLdxnmh1k4UPuv2eJt8d2rBCViv
         iZdIzLrScpZzDnpDwJAtNjYPbB9rPWeP6pFEViWA83CWuzzPKjYl4W+Lb4pW87uRy7gY
         CEFA==
X-Gm-Message-State: ANoB5plodulTwmQrY2avrvMWGX4BdC4A4xmDptoIV+bYJj/PDLN7eSf/
        BRXpBDBz5aaYtyq6U7PGBvz0jOpV3IgmqQ==
X-Google-Smtp-Source: AA0mqf6+XEyW0qWBQmFcciHuZenLOQDVlNSCPfi+FDhafH1ehwJ7en7hTCL/es3Tf6qZcwyKVE4yqQ==
X-Received: by 2002:a17:906:6d88:b0:7ad:b86b:3ff with SMTP id h8-20020a1709066d8800b007adb86b03ffmr9715101ejt.448.1668861694879;
        Sat, 19 Nov 2022 04:41:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007b29eb8a4dbsm2909276ejc.13.2022.11.19.04.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:41:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/9] submodule--helper: don't use global --super-prefix in "absorbgitdirs"
Date:   Sat, 19 Nov 2022 13:41:22 +0100
Message-Id: <patch-v3-3.9-6e10a47c60a-20221119T122853Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "--super-prefix" facility was introduced in [1] has always been a
transitory hack, which is why we've made it an error to supply it as
an option to "git" to commands that don't know about it.

That's been a good goal, as it has a global effect we haven't wanted
calls to get_super_prefix() from built-ins we didn't expect.

But it has meant that when we've had chains of different built-ins
using it all of the processes in that "chain" have needed to support
it, and worse processes that don't need it have needed to ask for
"SUPPORT_SUPER_PREFIX" because their parent process needs it.

That's how "fsmonitor--daemon" ended up with it, per [2] it's called
from (among other things) "submodule--helper absorbgitdirs", but as we
declared "submodule--helper" as "SUPPORT_SUPER_PREFIX" we needed to
declare "fsmonitor--daemon" as accepting it too, even though it
doesn't care about it.

But in the case of "absorbgitdirs" it only needed "--super-prefix" to
invoke itself recursively, and we'd never have another "in-between"
process in the chain. So we didn't need the bigger hammer of "git
--super-prefix", and the "setenv(GIT_SUPER_PREFIX_ENVIRONMENT, ...)"
that it entails.

Let's instead accept a hidden "--super-prefix" option to
"submodule--helper absorbgitdirs" itself.

Eventually (as with all other "--super-prefix" users) we'll want to
clean this code up so that this all happens in-process. I.e. needing
any variant of "--super-prefix" is itself a hack around our various
global state, and implicit reliance on "the_repository". This stepping
stone makes such an eventual change easier, as we'll need to deal with
less global state at that point.

The "fsmonitor--daemon" test adjusted here was added in [3]. To assert
that it didn't run into the "--super-prefix" message it was asserting
the output it didn't have. Let's instead assert the full output that
we *do* have, which we can do here as this is based on a change[4] to
make it predictable (until [4] it contained absolute paths).

We could also remove the test entirely (as [5] did), but even though
the initial reason for having it is gone we're still getting some
marginal benefit from testing the "fsmonitor" and "submodule
absorbgitdirs" interaction, so let's keep it.

The change here to have either a NULL or non-"" string as a
"super_prefix" instead of the previous arrangement of "" or non-"" is
somewhat arbitrary. We could also decide to never have to check for
NULL.

As we'll be changing the rest of the "git --super-prefix" users to the
same pattern, leaving them all consistent makes sense. Why not pick ""
over NULL? Because that's how the "prefix" works[6], and having
"prefix" and "super_prefix" work the same way will be less
confusing. That "prefix" picked NULL instead of "" is itself
arbitrary, but as it's easy to make this small bit of our overall API
consistent, let's go with that.

1. 74866d75793 (git: make super-prefix option, 2016-10-07)
2. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
   2022-05-26)
3. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
   2022-05-26)
4. https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com/
5. https://lore.kernel.org/git/20221109004708.97668-5-chooglen@google.com/
6. 9725c8dda20 (built-ins: trust the "prefix" from run_builtin(),
   2022-02-16)

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c  |  7 +++----
 git.c                        |  2 +-
 parse-options.h              |  4 ++++
 submodule.c                  | 12 +++++++-----
 t/t7527-builtin-fsmonitor.sh | 33 ++++++++-------------------------
 5 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index dc220d3348b..9f6ebc64140 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2834,8 +2834,9 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	int i;
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
-	const char *super_prefix;
+	const char *super_prefix = NULL;
 	struct option embed_gitdir_options[] = {
+		OPT__SUPER_PREFIX(&super_prefix),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
@@ -2850,7 +2851,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	if (module_list_compute(argv, prefix, &pathspec, &list) < 0)
 		goto cleanup;
 
-	super_prefix = get_super_prefix();
 	for (i = 0; i < list.nr; i++)
 		absorb_git_dir_into_superproject(list.entries[i]->name,
 						 super_prefix);
@@ -3391,8 +3391,7 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 
 	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
 	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
-	    strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
-	    get_super_prefix())
+	    strcmp(subcmd, "sync") && get_super_prefix())
 		/*
 		 * xstrfmt() rather than "%s %s" to keep the translated
 		 * string identical to git.c's.
diff --git a/git.c b/git.c
index 10202a7f126..b1b7e1a837e 100644
--- a/git.c
+++ b/git.c
@@ -539,7 +539,7 @@ static struct cmd_struct commands[] = {
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
-	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, SUPPORT_SUPER_PREFIX | RUN_SETUP },
+	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
diff --git a/parse-options.h b/parse-options.h
index b6ef86e0d15..50d852f2991 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -369,6 +369,10 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
 	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
 	  N_("use <n> digits to display object names"),	\
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
+#define OPT__SUPER_PREFIX(var) \
+	OPT_STRING_F(0, "super-prefix", (var), N_("prefix"), \
+		N_("prefixed path to initial superproject"), PARSE_OPT_HIDDEN)
+
 #define OPT__COLOR(var, h) \
 	OPT_COLOR_FLAG(0, "color", (var), (h))
 #define OPT_COLUMN(s, l, v, h) \
diff --git a/submodule.c b/submodule.c
index d339ce3b62c..3383c47c719 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2269,7 +2269,8 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
  * Embeds a single submodules git directory into the superprojects git dir,
  * non recursively.
  */
-static void relocate_single_git_dir_into_superproject(const char *path)
+static void relocate_single_git_dir_into_superproject(const char *path,
+						      const char *super_prefix)
 {
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
@@ -2303,7 +2304,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	       real_old_git_dir[off] == real_new_git_dir[off])
 		off++;
 	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\n"),
-		get_super_prefix_or_empty(), path,
+		super_prefix ? super_prefix : "", path,
 		real_old_git_dir + off, real_new_git_dir + off);
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
@@ -2323,10 +2324,11 @@ static void absorb_git_dir_into_superproject_recurse(const char *path,
 	cp.dir = path;
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-	strvec_pushf(&cp.args, "--super-prefix=%s%s/", super_prefix ?
-		     super_prefix : "", path);
 	strvec_pushl(&cp.args, "submodule--helper",
 		     "absorbgitdirs", NULL);
+	strvec_pushf(&cp.args, "--super-prefix=%s%s/", super_prefix ?
+		     super_prefix : "", path);
+
 	prepare_submodule_repo_env(&cp.env);
 	if (run_command(&cp))
 		die(_("could not recurse into submodule '%s'"), path);
@@ -2380,7 +2382,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		char *real_common_git_dir = real_pathdup(get_git_common_dir(), 1);
 
 		if (!starts_with(real_sub_git_dir, real_common_git_dir))
-			relocate_single_git_dir_into_superproject(path);
+			relocate_single_git_dir_into_superproject(path, super_prefix);
 
 		free(real_sub_git_dir);
 		free(real_common_git_dir);
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 4abc74db2bb..31526937d95 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -866,30 +866,11 @@ test_expect_success 'submodule always visited' '
 # the submodule, and someone does a `git submodule absorbgitdirs`
 # in the super, Git will recursively invoke `git submodule--helper`
 # to do the work and this may try to read the index.  This will
-# try to start the daemon in the submodule *and* pass (either
-# directly or via inheritance) the `--super-prefix` arg to the
-# `git fsmonitor--daemon start` command inside the submodule.
-# This causes a warning because fsmonitor--daemon does take that
-# global arg (see the table in git.c)
-#
-# This causes a warning when trying to start the daemon that is
-# somewhat confusing.  It does not seem to hurt anything because
-# the fsmonitor code maps the query failure into a trivial response
-# and does the work anyway.
-#
-# It would be nice to silence the warning, however.
-
-have_t2_error_event () {
-	log=$1
-	msg="fsmonitor--daemon doesnQt support --super-prefix" &&
-
-	tr '\047' Q <$1 | grep -e "$msg"
-}
+# try to start the daemon in the submodule.
 
 test_expect_success "stray submodule super-prefix warning" '
 	test_when_finished "rm -rf super; \
-			    rm -rf sub;   \
-			    rm super-sub.trace" &&
+			    rm -rf sub" &&
 
 	create_super super &&
 	create_sub sub &&
@@ -904,10 +885,12 @@ test_expect_success "stray submodule super-prefix warning" '
 
 	test_path_is_dir super/dir_1/dir_2/sub/.git &&
 
-	GIT_TRACE2_EVENT="$PWD/super-sub.trace" \
-		git -C super submodule absorbgitdirs &&
-
-	! have_t2_error_event super-sub.trace
+	cat >expect <<-\EOF &&
+	Migrating git directory of '\''dir_1/dir_2/sub'\'' from '\''dir_1/dir_2/sub/.git'\'' to '\''.git/modules/dir_1/dir_2/sub'\''
+	EOF
+	git -C super submodule absorbgitdirs >out 2>actual &&
+	test_cmp expect actual &&
+	test_must_be_empty out
 '
 
 # On a case-insensitive file system, confirm that the daemon
-- 
2.38.0.1509.g9445af83948

