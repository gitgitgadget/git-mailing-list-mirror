Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE286C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 10:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbiKNKJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 05:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbiKNKJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 05:09:00 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDB0E0D0
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:08:58 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f5so27029028ejc.5
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6zKp5EnRGQinPmaAmSUhMWslxpESuFxp0tM4fzN/58=;
        b=RanzhLfphL3aYmn+Am7novFViUa2ewS8hITmkGsjTfkFkOci6WnThyty6kINRbdcZb
         uvvlFSlCGIN2WjA62sUtJvdO7uy4MsDw93gL+Npj+Wc5aRGyH6N4aySfzuwAtmsxCcxp
         vzvpL0Sl/y2ZdEWa449frsE/fBWT5iaNzeSgZlcFZ1A5ijYV897e4QPxcCqU3N2J6mqj
         CdPfx/86YRMMJYLRZtibpu7T38qGHMSR3laFqIgmeTzy49s7ANnf8hm/GzXZjI0XTPBg
         9kkLWL78EOono/ghUD6EkRlQ6ks+OVE8AHt8cQKexzF7U+mfVmd7fugcdcMKGLck/fJP
         rZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6zKp5EnRGQinPmaAmSUhMWslxpESuFxp0tM4fzN/58=;
        b=XneDAIMi+SrF8mJQMUc4sDX9j5cU1lID6IoWNI5ZhNCtZfUypai3QAvhjAGQShIUoH
         Hz08GTRgdUCUK2PBp/kuGMBNlcZPViVOUqbba0cLM/dZ8viP4cGANWV5Ur2zl1QojeJd
         ZgY92RVNnJswnVqopzLXssCr5HBTV1G1WL58JWdW0WvniOxbIi1uCwBxuTDN94lJ+Hs+
         bjZ3GxBW4zIDbgGhR12RoitrTiStNGZhPlKdIJYaEXCkAZwC4TLj8PVg0CwFX50Yt0S8
         IchRWmt/nBzIagpwvUtyWUQPCvwiUFx491VQbNf90H8zE2Q7wSOqDn7WOmBmlM+MoRem
         280Q==
X-Gm-Message-State: ANoB5pnAuj8d7x7xTB96kCwlwOayXdm1nZJ8/pf4ViQKaUTZuoq8chFZ
        +/thmppJ9A+EnpP28XCIo2wqSDzpn1ehCA==
X-Google-Smtp-Source: AA0mqf7DnIZR95SduoGLI0+3U4/aegETmklQPLqkzJkwlvsCmHSgrJZMPOqKC2QKjEqE0hTo9prXLw==
X-Received: by 2002:a17:906:c182:b0:781:f37a:f50e with SMTP id g2-20020a170906c18200b00781f37af50emr9682347ejz.468.1668420536643;
        Mon, 14 Nov 2022 02:08:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ml21-20020a170906cc1500b007828150a2f1sm4012062ejb.36.2022.11.14.02.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:08:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] submodule--helper: don't use global --super-prefix in "absorbgitdirs"
Date:   Mon, 14 Nov 2022 11:08:42 +0100
Message-Id: <patch-v2-02.10-5a35f7b75b3-20221114T100803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1471.ge4d8947e7aa
In-Reply-To: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
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

The "fsmonitor--daemon" test adjusted here was added in [3]. The
comment added in that commit has been out-of-date from the beginning,
and the "have_t2_error_event()" was being overly specific in testing
for a bug that we *don't* have. Let's instead test for the stdout and
stderr that we *do have*.

1. 74866d75793 (git: make super-prefix option, 2016-10-07)
2. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
   2022-05-26)
3. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
   2022-05-26)

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c  |  8 +++++---
 git.c                        |  2 +-
 parse-options.h              |  4 ++++
 submodule.c                  | 20 ++++++++++++--------
 submodule.h                  |  7 ++++++-
 t/t7527-builtin-fsmonitor.sh | 33 ++++++++-------------------------
 6 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c75e9e86b06..427e793e204 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2828,7 +2828,9 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	int i;
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
+	const char *super_prefix = NULL;
 	struct option embed_gitdir_options[] = {
+		OPT__SUPER_PREFIX(&super_prefix),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
@@ -2844,7 +2846,8 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 
 	for (i = 0; i < list.nr; i++)
-		absorb_git_dir_into_superproject(list.entries[i]->name);
+		absorb_git_dir_into_superproject_sp(list.entries[i]->name,
+						    super_prefix);
 
 	ret = 0;
 cleanup:
@@ -3382,8 +3385,7 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 
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
index c47358097fd..d9fd0af81b6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2268,7 +2268,8 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
  * Embeds a single submodules git directory into the superprojects git dir,
  * non recursively.
  */
-static void relocate_single_git_dir_into_superproject(const char *path)
+static void relocate_single_git_dir_into_superproject(const char *path,
+						      const char *super_prefix)
 {
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
@@ -2302,7 +2303,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	       real_old_git_dir[off] == real_new_git_dir[off])
 		off++;
 	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\n"),
-		get_super_prefix_or_empty(), path,
+		(super_prefix ? super_prefix : ""), path,
 		real_old_git_dir + off, real_new_git_dir + off);
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
@@ -2313,7 +2314,8 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	strbuf_release(&new_gitdir);
 }
 
-static void absorb_git_dir_into_superproject_recurse(const char *path)
+static void absorb_git_dir_into_superproject_recurse(const char *path,
+						     const char *super_prefix)
 {
 
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -2321,10 +2323,11 @@ static void absorb_git_dir_into_superproject_recurse(const char *path)
 	cp.dir = path;
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
-	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
-		     get_super_prefix_or_empty(), path);
 	strvec_pushl(&cp.args, "submodule--helper",
 		     "absorbgitdirs", NULL);
+	strvec_pushf(&cp.args, "--super-prefix=%s%s/", super_prefix ?
+		     super_prefix : "", path);
+
 	prepare_submodule_repo_env(&cp.env);
 	if (run_command(&cp))
 		die(_("could not recurse into submodule '%s'"), path);
@@ -2335,7 +2338,8 @@ static void absorb_git_dir_into_superproject_recurse(const char *path)
  * having its git directory within the working tree to the git dir nested
  * in its superprojects git dir under modules/.
  */
-void absorb_git_dir_into_superproject(const char *path)
+void absorb_git_dir_into_superproject_sp(const char *path,
+					 const char *super_prefix)
 {
 	int err_code;
 	const char *sub_git_dir;
@@ -2377,14 +2381,14 @@ void absorb_git_dir_into_superproject(const char *path)
 		char *real_common_git_dir = real_pathdup(get_git_common_dir(), 1);
 
 		if (!starts_with(real_sub_git_dir, real_common_git_dir))
-			relocate_single_git_dir_into_superproject(path);
+			relocate_single_git_dir_into_superproject(path, super_prefix);
 
 		free(real_sub_git_dir);
 		free(real_common_git_dir);
 	}
 	strbuf_release(&gitdir);
 
-	absorb_git_dir_into_superproject_recurse(path);
+	absorb_git_dir_into_superproject_recurse(path, super_prefix);
 }
 
 int get_superproject_working_tree(struct strbuf *buf)
diff --git a/submodule.h b/submodule.h
index b52a4ff1e73..e5ee13fb06a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -164,7 +164,12 @@ void submodule_unset_core_worktree(const struct submodule *sub);
  */
 void prepare_submodule_repo_env(struct strvec *env);
 
-void absorb_git_dir_into_superproject(const char *path);
+void absorb_git_dir_into_superproject_sp(const char *path,
+					 const char *super_prefix);
+static inline void absorb_git_dir_into_superproject(const char *path)
+{
+	absorb_git_dir_into_superproject_sp(path, NULL);
+}
 
 /*
  * Return the absolute path of the working tree of the superproject, which this
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
2.38.0.1471.ge4d8947e7aa

