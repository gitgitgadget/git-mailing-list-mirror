Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B123CC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 12:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiLTMnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiLTMnH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 07:43:07 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FAC1CFDF
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ja17so8594635wmb.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuAlp611vdaUwy7xf5zt9ILKfZsIDXObZBlnq7skH8M=;
        b=qPgQKrLHPJ1QN8PaWr3oGIPX5Cu7dIrt+1vt0gDwbp7MIjiUcBuMMIchDJjvJBMRe7
         Dv/NqIxtE5tO5lecN6Rm7od7VLlCQBkzHiSo3wzit134/gJM+99xY2FWjdW2ygDH2rIk
         ohogGp4kqnyp6k144WeoIkSXGOIYaKlewbNUT+VBoC8y09CVwyFWGoHvCjLVyuaaM1wX
         eZQ5wvbncfMPa4zUt1nUaEC/9RuKNCXCDP6ZqPZlZYjG25y1GJBwUGvE5zVL5y8peiIv
         165xa+frROZJLnqkVlVUfOMpFvKf2AJocVygxTVgLpWLXMNRKg/VWY9dx6Eq7gGehWLH
         o2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuAlp611vdaUwy7xf5zt9ILKfZsIDXObZBlnq7skH8M=;
        b=alpPF+df9hG/Hdc9PsulAJvFQ88cUGIENOC2n3RZMPrKlbkvWvAJ2QFsAFlfd6EQdM
         cyNpCKBXY74I+H/xDbVAIH633PAxtEqVjwjD/PabMqz5BXFtkopct3bGL5izNcNrNOm3
         XG4KSC7ymCxm5J96Vwkhr7vabTDiEdAHiczMUXGVtwiEVlVAd1K0h6O5ZEyEMo/l6HPX
         oYGAj0/1P/NgQdmsDDreNHbMfcsjpDT+HghRmfOl20ef8tj81FO9IUZkO9qX42p0w25D
         NCOCY8RIoL390vcTlyz/jMq2shrLv1vJKBBhFXfNdt2o40TsU3B3p4O4XSv/vO+AhlFE
         WvTw==
X-Gm-Message-State: ANoB5pnt9BgDg7H4iJgRpRGQRVex79N5WelEZ+UMlQt25/d2WqT987Gi
        zqf+5+c+IiuFoShv6gWjgePQrasv5o05+g==
X-Google-Smtp-Source: AA0mqf60f3dsnz4QjgPJ0LtHaoVwJM2VVpl6ZtwgMlg/mW8Zi9OfOFqq7CgcfW79ieOPg1glhkqy3g==
X-Received: by 2002:a05:600c:538f:b0:3d1:d396:1ade with SMTP id hg15-20020a05600c538f00b003d1d3961ademr35340584wmb.9.1671540005310;
        Tue, 20 Dec 2022 04:40:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003d355ad9bb7sm9630759wmq.20.2022.12.20.04.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:40:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 4/9] submodule--helper: don't use global --super-prefix in "absorbgitdirs"
Date:   Tue, 20 Dec 2022 13:39:51 +0100
Message-Id: <patch-v5-4.9-0b30497f187-20221220T104519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.g08bce9674be
In-Reply-To: <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
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
we *do* have, using the same pattern as a preceding change to
"t/t7412-submodule-absorbgitdirs.sh" used.

We could also remove the test entirely (as [4] did), but even though
the initial reason for having it is gone we're still getting some
marginal benefit from testing the "fsmonitor" and "submodule
absorbgitdirs" interaction, so let's keep it.

The change here to have either a NULL or non-"" string as a
"super_prefix" instead of the previous arrangement of "" or non-"" is
somewhat arbitrary. We could also decide to never have to check for
NULL.

As we'll be changing the rest of the "git --super-prefix" users to the
same pattern, leaving them all consistent makes sense. Why not pick ""
over NULL? Because that's how the "prefix" works[5], and having
"prefix" and "super_prefix" work the same way will be less
confusing. That "prefix" picked NULL instead of "" is itself
arbitrary, but as it's easy to make this small bit of our overall API
consistent, let's go with that.

1. 74866d75793 (git: make super-prefix option, 2016-10-07)
2. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
   2022-05-26)
3. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
   2022-05-26)
4. https://lore.kernel.org/git/20221109004708.97668-5-chooglen@google.com/
5. 9725c8dda20 (built-ins: trust the "prefix" from run_builtin(),
   2022-02-16)

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c  |  7 +++----
 git.c                        |  2 +-
 parse-options.h              |  4 ++++
 submodule.c                  | 12 +++++++-----
 t/t7527-builtin-fsmonitor.sh | 36 ++++++++++++++----------------------
 5 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index da844cad5ce..b8b2bc776d1 100644
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
index 277a8cce840..e473b4b7d72 100644
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
index bf19598b8c2..46a03473195 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2275,7 +2275,8 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
  * Embeds a single submodules git directory into the superprojects git dir,
  * non recursively.
  */
-static void relocate_single_git_dir_into_superproject(const char *path)
+static void relocate_single_git_dir_into_superproject(const char *path,
+						      const char *super_prefix)
 {
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
@@ -2305,7 +2306,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
 
 	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s'\n"),
-		get_super_prefix_or_empty(), path,
+		super_prefix ? super_prefix : "", path,
 		real_old_git_dir, real_new_git_dir);
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
@@ -2325,10 +2326,11 @@ static void absorb_git_dir_into_superproject_recurse(const char *path,
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
@@ -2382,7 +2384,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		char *real_common_git_dir = real_pathdup(get_git_common_dir(), 1);
 
 		if (!starts_with(real_sub_git_dir, real_common_git_dir))
-			relocate_single_git_dir_into_superproject(path);
+			relocate_single_git_dir_into_superproject(path, super_prefix);
 
 		free(real_sub_git_dir);
 		free(real_common_git_dir);
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 4abc74db2bb..76d0220daa0 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -866,27 +866,9 @@ test_expect_success 'submodule always visited' '
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
 
-test_expect_success "stray submodule super-prefix warning" '
+test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
 	test_when_finished "rm -rf super; \
 			    rm -rf sub;   \
 			    rm super-sub.trace" &&
@@ -904,10 +886,20 @@ test_expect_success "stray submodule super-prefix warning" '
 
 	test_path_is_dir super/dir_1/dir_2/sub/.git &&
 
+	cwd="$(cd super && pwd)" &&
+	cat >expect <<-EOF &&
+	Migrating git directory of '\''dir_1/dir_2/sub'\'' from
+	'\''$cwd/dir_1/dir_2/sub/.git'\'' to
+	'\''$cwd/.git/modules/dir_1/dir_2/sub'\''
+	EOF
 	GIT_TRACE2_EVENT="$PWD/super-sub.trace" \
-		git -C super submodule absorbgitdirs &&
+		git -C super submodule absorbgitdirs >out 2>actual &&
+	test_cmp expect actual &&
+	test_must_be_empty out &&
 
-	! have_t2_error_event super-sub.trace
+	# Confirm that the trace2 log contains a record of the
+	# daemon starting.
+	test_subcommand git fsmonitor--daemon start <super-sub.trace
 '
 
 # On a case-insensitive file system, confirm that the daemon
-- 
2.39.0.1071.g97ce8966538

