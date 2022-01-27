Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06650C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 20:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbiA0UEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343887AbiA0UDu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 15:03:50 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11326C06175D
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 12:03:50 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id d8so3878399qvv.2
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 12:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrT0K4ZNXxQXq2+4Jhxaarf14wkVsgOjB+fAzQPbxlM=;
        b=imZVLZ/iw/FB+5r7UjNni29q07tr5mi30MgPAk+c7AuSEkS4WdSpdoB6aBCd5VKJzi
         SRiDYAuJGpnd7t0atL8arN0X7Ao/kuJdli5lMVVC3XgkBGQpN0qBRFvcU/oU2go3NeTP
         Fr+Ok031iPymzDx/wate5CngNoiDmdv3U+578R5XpcE5Q8VHPzzMWQJ3iy6yTJMC6P4p
         qIYb3+rHgsfA1vWORZH2G/VMSbtWFRtO2hnvDH2aEh8ooNH74kC92robbd2nvLqmnzT2
         d6XcnM20NxQ/xzCsJlwDxynZfLId226EtAHjqe4XC6PZwaHvKl4mfptjEknK5SUO2NL6
         ZpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrT0K4ZNXxQXq2+4Jhxaarf14wkVsgOjB+fAzQPbxlM=;
        b=yRnfYjgtd7fVke8opMHs3pHhOCQ2UPpI6jCyHB89DKqmJ9GOeBCTdv/EepQNl8dFNv
         kzNAwiVR+CYa397a66rvz71OXQ1iZeWN7ft4WNZDf0JwElrsbpST9oD97SA8Rn+W1Ptn
         +EjIgPqbS8NWu3oO+HJyW6CgJkcVp9YWrr+xkgW90a+iHoUcjmE5BXUJ84rvOrQpMiDs
         Iv/K+UtG+OFWfjc5Nk6IkghjO5mq2fihWtXqbMt9kO6r9rLzoNA3/mNMgkJ+xyw9C7uL
         1B2yzB0wpfvT9PQyywBEC17LIK9JJLkgpUMC7E7oTmzZN8c0pwHcmQdQR6zQIyN5Nqs3
         hNrA==
X-Gm-Message-State: AOAM533jDHOT56GF0zyiZ1Y0BHM506/MAL2SF/UTPrSp/bbyAxJlMlkU
        ipQZucpw+x6UFrWaer1INOM=
X-Google-Smtp-Source: ABdhPJzGwm774hbRGtV0QJHmv/qwZvvP8jYDPjYBCZxeFuCcdbuAx4t6G0Mxs+gSZYmp88/elrDvDA==
X-Received: by 2002:a05:6214:c85:: with SMTP id r5mr4358338qvr.123.1643313828526;
        Thu, 27 Jan 2022 12:03:48 -0800 (PST)
Received: from iron-rod.attlocal.net ([2600:1700:bae0:2de0::1b])
        by smtp.gmail.com with ESMTPSA id b23sm1765346qtp.94.2022.01.27.12.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:03:47 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Glen Choo <chooglen@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5 07/11] rebase: do not attempt to remove startup_info->original_cwd)
Date:   Thu, 27 Jan 2022 12:03:41 -0800
Message-Id: <20220127200341.333996-1-newren@gmail.com>
X-Mailer: git-send-email 2.35.0.2.g9420af4777.dirty
In-Reply-To: <CAPig+cQVNdmHQnhORqh2XtJSMhcOymR99pmKTWOAyhoQ10khSw@mail.gmail.com>
References: <CAPig+cQVNdmHQnhORqh2XtJSMhcOymR99pmKTWOAyhoQ10khSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 9:53 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Jan 26, 2022 at 6:00 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > On 25/01/2022 23:59, Elijah Newren wrote:
> > > There's nothing wrong with running checkout from a subdirectory.  It
> > > is unfortunate that setup.c auto-discovers both the git directory and
> > > the working tree, but sets GIT_DIR without setting GIT_WORK_TREE in
> > > the case of a non-main worktree; it's not particularly friendly for
> > > subcommands.  Of course, it's also unfortunate that sequencer still
> > > forks subprocesses other than those requested by a user with e.g.
> > > --exec.
> > >
> > > But, anyway, I've got a patch that I'll send as soon as it passes CI
> > > (https://github.com/git/git/pull/1205).
> >
> > The patch hasn't come through to me on the mailing list yet, but it
> > looks good. I thought we set both GIT_DIR and GIT_WORK_TREE when we were
> > in a non-main worktree but obviously we don't. Eric do you happen to
> > know if that is intentional?
>
> As far as I know, there is no reason to set GIT_DIR and GIT_WORK_TREE,
> in general, when in a linked worktree since each worktree has its own
> .git file ("gitfile") which tells Git commands where the repository is
> and signals that that directory itself (which contains the .git file)
> is indeed a Git worktree.

Oh, interesting.  Not setting GIT_DIR either does sound a bit better.

...though after digging for a while, it turns out to be a bit more
involved than I thought.  Although the below patch passes our current
testsuite and fixes the reported bug, I'm worried I've missed some cases
not tested by the testsuite.

Not sure if we want to pursue this, drop it, or something else.  Thoughts?

-- >8 --
Subject: [RFC/POC PATCH] setup: do not pre-emptively set GIT_DIR based on discovery

setup_git_directory_gently() handles a few cases, but when it discovers
the git directory and finds it is not ".git", it sets and exports the
GIT_DIR environment variable to the discovered value.  It does not set
GIT_WORK_TREE, though, even when it also discovers it.  This has two
drawbacks:

  * Since Git assumes the working tree is '.' when GIT_DIR is set and
    GIT_WORK_TREE isn't, any subprocesses called by Git which need to
    operate on the working tree either need to be careful to always
    invoke with their cwd being the toplevel of the actual working tree
    (and potentially losing information about 'prefix'), or take care to
    also specify the GIT_WORK_TREE environment value when forking.

  * The GIT_DIR environment variable behaves somewhat like an implicit
    'the_repository'; it's another bit of global state that is
    potentially problematic for libifying efforts of libgit.

Avoid these issues by no longer exporting GIT_DIR from the setup code
(other locations like the parser handling the --git-dir flag will still
set it, though).

Some comments on the various code changes:
   * clone/push/fetch related:
     * there are *many* subprocesses involved in fetch/push and friends,
       and they typically need to know the GIT_DIR they are operating on
     * this involves: fetch-patch.c, connected.c, bundle.c, clone.c,
       transport-helper.c, receive-pack.c, upload-pack.c
     * this accounts for the majority of this patch
     * much of this work could be avoided by having enter_repo() call
       xsetenv(GIT_DIR_ENVIRONMENT, ".", 1) just after its set_git_dir()
       call, but I don't know if that'd be considered a half measure
   * rev-parse.c: substitute usage of the GIT_DIR environment variable
     with the_repository->gitdir that should have the same value
     (exept when the latter is ".git" the former will be NULL, so there
     are some small logic tweaks).
   * run-command: hooks have been operating under the assumption that
     GIT_DIR is set for a long time.  This is possibly
     counter-productive for the same reasons listed above, and it has
     certainly been brought up before on the list, but backward
     compatibility concerns led me to just propagate it to avoid
     breaking anything.
   * test-subprocess: not sure if we should automatically export
     GIT_DIR, but the existing code and one test in the repo relied on
     it, so I just included it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clone.c            |  7 ++++++-
 builtin/receive-pack.c     | 12 ++++++++++++
 builtin/rev-parse.c        |  8 +++-----
 bundle.c                   |  2 ++
 connected.c                |  2 ++
 environment.c              |  1 -
 fetch-pack.c               |  6 ++++++
 run-command.c              |  2 ++
 t/helper/test-subprocess.c |  2 ++
 transport-helper.c         |  3 +++
 upload-pack.c              |  2 ++
 11 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 727e16e0ae..5304939cec 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -836,13 +836,18 @@ static void dissociate_from_references(void)
 {
 	static const char* argv[] = { "repack", "-a", "-d", NULL };
 	char *alternates = git_pathdup("objects/info/alternates");
+	struct strvec env = STRVEC_INIT;
+	strvec_pushf(&env, GIT_DIR_ENVIRONMENT "=%s", the_repository->gitdir);
 
 	if (!access(alternates, F_OK)) {
-		if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
+		if (run_command_v_opt_cd_env(argv,
+					     RUN_GIT_CMD|RUN_COMMAND_NO_STDIN,
+					     NULL, env.v))
 			die(_("cannot repack to clean up"));
 		if (unlink(alternates) && errno != ENOENT)
 			die_errno(_("cannot unlink temporary alternates file"));
 	}
+	strvec_clear(&env);
 	free(alternates);
 }
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816c..b5d2633b78 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -825,6 +825,8 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	proc.stdout_to_stderr = 1;
 	proc.trace2_hook_name = hook_name;
 
+	strvec_pushf(&proc.env_array, "%s=%s",
+		     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 	if (feed_state->push_options) {
 		int i;
 		for (i = 0; i < feed_state->push_options->nr; i++)
@@ -953,6 +955,8 @@ static int run_update_hook(struct command *cmd)
 	strvec_push(&proc.args, cmd->ref_name);
 	strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
 	strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
+	strvec_pushf(&proc.env_array, "%s=%s",
+		     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
@@ -1128,6 +1132,8 @@ static int run_proc_receive_hook(struct command *commands,
 	}
 
 	strvec_push(&proc.args, hook_path);
+	strvec_pushf(&proc.env_array, "%s=%s",
+		     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 	proc.in = -1;
 	proc.out = -1;
 	proc.trace2_hook_name = "proc-receive";
@@ -1645,6 +1651,8 @@ static void run_update_post_hook(struct command *commands)
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
 	proc.trace2_hook_name = "post-update";
+	strvec_pushf(&proc.env_array, "%s=%s",
+		     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 
 	if (!start_command(&proc)) {
 		if (use_sideband)
@@ -2236,6 +2244,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
+		strvec_pushf(&child.env_array, "%s=%s",
+			     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 		status = run_command(&child);
 		if (status)
 			return "unpack-objects abnormal exit";
@@ -2267,6 +2277,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		child.out = -1;
 		child.err = err_fd;
 		child.git_cmd = 1;
+		strvec_pushf(&child.env_array, "%s=%s",
+			     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 		status = start_command(&child);
 		if (status)
 			return "index-pack fork failed";
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8480a59f57..1d578d48a1 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -930,12 +930,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--git-dir") ||
 			    !strcmp(arg, "--absolute-git-dir")) {
-				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
+				const char *gitdir = the_repository->gitdir;
 				char *cwd;
 				int len;
 				enum format_type wanted = format;
 				if (arg[2] == 'g') {	/* --git-dir */
-					if (gitdir) {
+					if (strcmp(gitdir, ".git")) {
 						print_path(gitdir, prefix, format, DEFAULT_UNMODIFIED);
 						continue;
 					}
@@ -945,9 +945,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					}
 				} else {		/* --absolute-git-dir */
 					wanted = FORMAT_CANONICAL;
-					if (!gitdir && !prefix)
-						gitdir = ".git";
-					if (gitdir) {
+					if (strcmp(gitdir, ".git") || !prefix) {
 						struct strbuf realpath = STRBUF_INIT;
 						strbuf_realpath(&realpath, gitdir, 1);
 						puts(realpath.buf);
diff --git a/bundle.c b/bundle.c
index a0bb687b0f..897d36c83a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -573,6 +573,8 @@ int unbundle(struct repository *r, struct bundle_header *header,
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
+	strvec_pushf(&ip.env_array, "%s=%s",
+		     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 
 	if (extra_index_pack_args) {
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
diff --git a/connected.c b/connected.c
index ed3025e7a2..3dfc6278e8 100644
--- a/connected.c
+++ b/connected.c
@@ -109,6 +109,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 			     _("Checking connectivity"));
 
 	rev_list.git_cmd = 1;
+	strvec_pushf(&rev_list.env_array, "%s=%s",
+		     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 	if (opt->env)
 		strvec_pushv(&rev_list.env_array, opt->env);
 	rev_list.in = -1;
diff --git a/environment.c b/environment.c
index fd0501e77a..db31c37a62 100644
--- a/environment.c
+++ b/environment.c
@@ -327,7 +327,6 @@ char *get_graft_file(struct repository *r)
 
 static void set_git_dir_1(const char *path)
 {
-	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
 	setup_git_env(path);
 }
 
diff --git a/fetch-pack.c b/fetch-pack.c
index dd6ec449f2..8b59014c3a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -892,6 +892,8 @@ static int get_pack(struct fetch_pack_args *args,
 		cmd_name = "index-pack";
 		strvec_push(&cmd.args, cmd_name);
 		strvec_push(&cmd.args, "--stdin");
+		strvec_pushf(&cmd.env_array, "%s=%s",
+			     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 		if (!args->quiet && !args->no_progress)
 			strvec_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
@@ -927,6 +929,8 @@ static int get_pack(struct fetch_pack_args *args,
 	}
 	else {
 		cmd_name = "unpack-objects";
+		strvec_pushf(&cmd.env_array, "%s=%s",
+			     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 		strvec_push(&cmd.args, cmd_name);
 		if (args->quiet || args->no_progress)
 			strvec_push(&cmd.args, "-q");
@@ -1703,6 +1707,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			strvec_pushf(&cmd.args, "--index-pack-arg=%s",
 				     index_pack_args.v[j]);
 		strvec_push(&cmd.args, uri);
+		strvec_pushf(&cmd.env_array, "%s=%s",
+			     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 		cmd.git_cmd = 1;
 		cmd.no_stdin = 1;
 		cmd.out = -1;
diff --git a/run-command.c b/run-command.c
index 69dde42f1e..0fb21f92bf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1319,6 +1319,8 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	strvec_push(&hook.args, p);
 	while ((p = va_arg(args, const char *)))
 		strvec_push(&hook.args, p);
+	strvec_pushf(&hook.env_array, "%s=%s",
+		     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 	if (env)
 		strvec_pushv(&hook.env_array, (const char **)env);
 	hook.no_stdin = 1;
diff --git a/t/helper/test-subprocess.c b/t/helper/test-subprocess.c
index ff22f2fa2c..d58bf7e18d 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -16,5 +16,7 @@ int cmd__subprocess(int argc, const char **argv)
 	}
 	cp.git_cmd = 1;
 	strvec_pushv(&cp.args, (const char **)argv + 1);
+	strvec_pushf(&cp.env_array, "%s=%s",
+		     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 	return run_command(&cp);
 }
diff --git a/transport-helper.c b/transport-helper.c
index a0297b0986..d26b5ecd10 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -448,6 +448,9 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 		strvec_pushf(&fastimport->args, "--cat-blob-fd=%d", cat_blob_fd);
 	}
 	fastimport->git_cmd = 1;
+	if (have_git_dir())
+		strvec_pushf(&fastimport->env_array, "%s=%s",
+			     GIT_DIR_ENVIRONMENT, get_git_dir());
 
 	code = start_command(fastimport);
 	return code;
diff --git a/upload-pack.c b/upload-pack.c
index 8acc98741b..7bf36d6d3a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -295,6 +295,8 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		strvec_push(&pack_objects.args, "--shallow-file");
 		strvec_push(&pack_objects.args, "");
 	}
+	strvec_pushf(&pack_objects.env_array, "%s=%s",
+		     GIT_DIR_ENVIRONMENT, the_repository->gitdir);
 	strvec_push(&pack_objects.args, "pack-objects");
 	strvec_push(&pack_objects.args, "--revs");
 	if (pack_data->use_thin_pack)
-- 
2.35.0.2.g9420af4777.dirty

