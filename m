Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159D9C433FE
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbhKWMLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbhKWMLH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:11:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEBDC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:07:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o13so3679741wrs.12
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t3GotPPXSztK38TipfV4ZlQeLm/MrV46xXqH6TDWXg0=;
        b=nPBsJT8T0pfBkAeS0LmGCLD1vk2bWV7kpLOExTKLLPif2W7r875S7w+hQ/vwsJNQHV
         SndrSTzgTdWrrZ8dUMsNV5qWPzc6UPIspz5375Tm7UqfTrQfQkJczE3g57ORO5zuWwPg
         moN2dHk2dp/LVxsueqaH93VodHU6f8gpuCrdJlKJTD5MJVcfu1y/fRIAPqf2txu73ajR
         CcyTXUX5tYeQPGxA+0tbqDZxWdX3+lfmpfw6HfS1nK+YLCmrzZjsIvYikyZgDiKgDQOM
         uGXR2quD78BWaejy95/3x0Ex5M3vThWvPKqHWT0orWXuN0JTyJ076CkqdkGWkiGoP33S
         EEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t3GotPPXSztK38TipfV4ZlQeLm/MrV46xXqH6TDWXg0=;
        b=kYYWvn7lVTOxC/zfESrLxVsk12xQ9WChGnnRd7ubQARjLdXI7qL4j9VOaDqALWUsGS
         P+VA24p3LkjmTmbbyKo1Qpf83zsMGqDmvKvUktDmTuxRJycJvgdqXlR1OmY7o8iJjSyn
         2T/5dgkvzeWHMM/YMC9hgdVuumKk7RyPxpmgLlKjSdSXq1ADm9YMZWHbnsXWgofOVIMd
         DiMTuVbTUEeHYqbt/nGxbvVlgS9ENW2IxDIF9rAdfiLjYd6Gr9j9TFw8TNEL4H/wrvsM
         NVMVQA+n0kLCncdLvlZNX7elKlJmnPUcu1f2/AMDLqryNsZ0RcFFmFHeTloD9OjqY44c
         pTAQ==
X-Gm-Message-State: AOAM533oLO96hU7h3++x3YvFWWAmPJqLjHCe/ganf+vFFo7udkVWgC/F
        NTy5uGXsrMjacHiamJnGgwEfIt3EYlP9OQ==
X-Google-Smtp-Source: ABdhPJwfcxAssXmwRk5ZLOITZqZS4H9iGEI2XvsDdS5CqfUwpvMDr8smq0DfLozi+KVSuBiC2BCBTQ==
X-Received: by 2002:a5d:51cb:: with SMTP id n11mr6568438wrv.278.1637669276633;
        Tue, 23 Nov 2021 04:07:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m9sm1220299wmq.1.2021.11.23.04.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:07:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/9] run-command API: get rid of "argv" and "env"
Date:   Tue, 23 Nov 2021 13:06:27 +0100
Message-Id: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That the run-command API exposed two subtly different ways of doing
the same thing wouldn't only lead to the sort of bug reported in [1],
but also made memory management around it rather painful. As noted by
Jeff King in[2]:

    I'd like to eventually get rid of the argv interface entirely
    because it has memory-ownership semantics that are easy to get
    wrong.

As noted in v1[1] there's probably never going to be a perfect time to
do this as a change to this widely used API will probably impact
things in-flight.

Now seems to be a particularly good time though, merging this to
"seen" only conflicts with my ab/config-based-hooks-2 in
builtin/worktree.c. The resolution is trivial (just use the new hook
API added in that topic).

This re-rolled v2 also had a semantic conflict with that topic's use
of the "env" member, which is solved with a just-submitted update of
mine[2].

Changes since v2:

 * I ejected the test for the segfault this topic solves, I understood
   that Junio wanted to fast-track a more limited fix based on Enzo
   Matsumiya's [3]. In any case the two won't semantically conflict as
   far as the test goes, this larger change also fixes the segfault.

 * I'm now removing the "env" member in addition to "argv". The two
   patches at the end are new. Doing so was a much smaller change than
   "argv".

 * I changed all the minimal refactorings to get rid of "env" to
   larger changes to get rid of any function-local "argv" arrays with
   a hardcoded size.

 * As a result, the mid-series is now structured in such a way as to
   group changes where we can trivially prove that we're not
   introducing a logic error (since the "argv" variable went away),
   and those cases where we still keep the "argv" (usually from an
   existing "struct strvec").

 * The whole Windows-specific complexity in v1 is gone. I didn't
   really need to change the behavior of that code, now it's just a
   simple search-replacement of s/cmd->argv/cmd->args.v/. It means we
   clobber the "env_array" member as we were doing with the "env"
   before, but since that's nothing new it doesn't require careful
   review of change semantics.

1. https://lore.kernel.org/git/cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com/
3. https://lore.kernel.org/git/20211120194048.12125-1-ematsumiya@suse.de/

Ævar Arnfjörð Bjarmason (9):
  worktree: remove redundant NULL-ing of "cp.argv
  upload-archive: use regular "struct child_process" pattern
  run-command API users: use strvec_pushv(), not argv assignment
  run-command tests: use strvec_pushv(), not argv assignment
  run-command API users: use strvec_pushl(), not argv construction
  run-command API users: use strvec_push(), not argv construction
  run-command API: remove "argv" member, always use "args"
  difftool: use "env_array" to simplify memory management
  run-command API: remove "env" member, always use "env_array"

 add-patch.c                 |  4 +-
 archive-tar.c               |  9 ++---
 builtin/add.c               |  7 +---
 builtin/difftool.c          | 14 ++-----
 builtin/fsck.c              | 12 ++----
 builtin/help.c              |  3 +-
 builtin/merge.c             |  3 +-
 builtin/notes.c             |  5 +--
 builtin/receive-pack.c      | 80 ++++++++++++++-----------------------
 builtin/replace.c           |  3 +-
 builtin/upload-archive.c    |  5 ++-
 builtin/worktree.c          |  8 ++--
 connected.c                 |  3 +-
 daemon.c                    | 20 ++++------
 diff.c                      |  8 +---
 editor.c                    |  8 ++--
 http-backend.c              |  2 +-
 http.c                      |  5 ++-
 object-file.c               |  2 +-
 prompt.c                    |  7 +---
 remote-curl.c               |  2 +-
 run-command.c               | 62 +++++++++++++---------------
 run-command.h               | 54 ++++++++++++-------------
 sequencer.c                 | 10 ++---
 sub-process.c               |  2 +-
 t/helper/test-run-command.c |  9 +++--
 t/helper/test-subprocess.c  |  2 +-
 trace2/tr2_tgt_event.c      |  2 +-
 trace2/tr2_tgt_normal.c     |  2 +-
 trace2/tr2_tgt_perf.c       |  4 +-
 trailer.c                   |  2 +-
 transport.c                 | 11 +++--
 upload-pack.c               |  5 +--
 33 files changed, 154 insertions(+), 221 deletions(-)

Range-diff against v1:
 -:  ----------- >  1:  9cc220ce5a3 worktree: remove redundant NULL-ing of "cp.argv
 2:  a411098699d !  2:  bfa65e5afd7 upload-archive: use regular "struct child_process" pattern
    @@ builtin/upload-archive.c: static ssize_t process_input(int child_fd, int band)
      	if (argc == 2 && !strcmp(argv[1], "-h"))
      		usage(upload_archive_usage);
     @@ builtin/upload-archive.c: int cmd_upload_archive(int argc, const char **argv, const char *prefix)
    - 	argv[0] = "upload-archive--writer";
    + 	 * multiplexed out to our fd#1.  If the child dies, we tell the other
    + 	 * end over channel #3.
    + 	 */
    +-	argv[0] = "upload-archive--writer";
      	writer.out = writer.err = -1;
      	writer.git_cmd = 1;
     +	strvec_push(&writer.args, "upload-archive--writer");
    -+	if (argc > 1)
    -+		strvec_pushv(&writer.args, &argv[1]);
    ++	strvec_pushv(&writer.args, argv + 1);
      	if (start_command(&writer)) {
      		int err = errno;
      		packet_write_fmt(1, "NACK unable to spawn subprocess\n");
 3:  fd6c4c960ba !  3:  61e4eb8e173 run-command API users: use strvec_pushv(), not argv assignment
    @@ Commit message
         run-command API users: use strvec_pushv(), not argv assignment
     
         Migrate those run-command API users that assign directly to the "argv"
    -    member to use a strvec_pushv() of "args" instead, but exclude those
    -    cases where we can't easily get rid of the construction of the "argv"
    -    variable being given to the resulting "strvec_pushv()".
    +    member to use a strvec_pushv() of "args" instead.
     
    -    This is in preparation for getting rid of the "argv" member from the
    -    run-command API itself.
    +    In these cases it did not make sense to further refactor these
    +    callers, e.g. daemon.c could be made to construct the arguments closer
    +    to handle(), but that would require moving the construction from its
    +    cmd_main() and pass "argv" through two intermediate functions.
    +
    +    It would be possible for a change like this to introduce a regression
    +    if we were doing:
    +
    +          cp.argv = argv;
    +          argv[1] = "foo";
    +
    +    And changed the code, as is being done here, to:
    +
    +          strvec_pushv(&cp.args, argv);
    +          argv[1] = "foo";
    +
    +    But as viewing this change with the "-W" flag reveals none of these
    +    functions modify variable that's being pushed afterwards in a way that
    +    would introduce such a logic error.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec
      		res = capture_command(&colored_cp, colored, 0);
      		strvec_clear(&args);
     
    - ## builtin/notes.c ##
    -@@ builtin/notes.c: static void write_commented_object(int fd, const struct object_id *object)
    - 	struct strbuf cbuf = STRBUF_INIT;
    - 
    - 	/* Invoke "git show --stat --no-notes $object" */
    --	show.argv = show_args;
    -+	strvec_pushv(&show.args, show_args);
    - 	show.no_stdin = 1;
    - 	show.out = -1;
    - 	show.err = 0;
    -
    - ## builtin/receive-pack.c ##
    -@@ builtin/receive-pack.c: static int run_and_feed_hook(const char *hook_name, feed_fn feed,
    - 
    - 	argv[1] = NULL;
    - 
    --	proc.argv = argv;
    -+	strvec_pushv(&proc.args, argv);
    - 	proc.in = -1;
    - 	proc.stdout_to_stderr = 1;
    - 	proc.trace2_hook_name = hook_name;
    -@@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
    - 	proc.no_stdin = 1;
    - 	proc.stdout_to_stderr = 1;
    - 	proc.err = use_sideband ? -1 : 0;
    --	proc.argv = argv;
    -+	strvec_pushv(&proc.args, argv);
    - 	proc.trace2_hook_name = "update";
    - 
    - 	code = start_command(&proc);
    -@@ builtin/receive-pack.c: static int run_proc_receive_hook(struct command *commands,
    - 	}
    - 	argv[1] = NULL;
    - 
    --	proc.argv = argv;
    -+	strvec_pushv(&proc.args, argv);
    - 	proc.in = -1;
    - 	proc.out = -1;
    - 	proc.trace2_hook_name = "proc-receive";
    -@@ builtin/receive-pack.c: static const char *push_to_deploy(unsigned char *sha1,
    - 	};
    - 	struct child_process child = CHILD_PROCESS_INIT;
    - 
    --	child.argv = update_refresh;
    -+	strvec_pushv(&child.args, update_refresh);
    - 	child.env = env->v;
    - 	child.dir = work_tree;
    - 	child.no_stdin = 1;
    -@@ builtin/receive-pack.c: static const char *push_to_deploy(unsigned char *sha1,
    - 
    - 	/* run_command() does not clean up completely; reinitialize */
    - 	child_process_init(&child);
    --	child.argv = diff_files;
    -+	strvec_pushv(&child.args, diff_files);
    - 	child.env = env->v;
    - 	child.dir = work_tree;
    - 	child.no_stdin = 1;
    -@@ builtin/receive-pack.c: static const char *push_to_deploy(unsigned char *sha1,
    - 	diff_index[4] = head_has_history() ? "HEAD" : empty_tree_oid_hex();
    - 
    - 	child_process_init(&child);
    --	child.argv = diff_index;
    -+	strvec_pushv(&child.args, diff_index);
    - 	child.env = env->v;
    - 	child.no_stdin = 1;
    - 	child.no_stdout = 1;
    -@@ builtin/receive-pack.c: static const char *push_to_deploy(unsigned char *sha1,
    - 
    - 	read_tree[3] = hash_to_hex(sha1);
    - 	child_process_init(&child);
    --	child.argv = read_tree;
    -+	strvec_pushv(&child.args, read_tree);
    - 	child.env = env->v;
    - 	child.dir = work_tree;
    - 	child.no_stdin = 1;
    -@@ builtin/receive-pack.c: int cmd_receive_pack(int argc, const char **argv, const char *prefix)
    - 			proc.stdout_to_stderr = 1;
    - 			proc.err = use_sideband ? -1 : 0;
    - 			proc.git_cmd = proc.close_object_store = 1;
    --			proc.argv = argv_gc_auto;
    -+			strvec_pushv(&proc.args, argv_gc_auto);
    - 
    - 			if (!start_command(&proc)) {
    - 				if (use_sideband)
    -
      ## daemon.c ##
     @@ daemon.c: static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
      #endif
    @@ daemon.c: static void handle(int incoming, struct sockaddr *addr, socklen_t addr
      	cld.out = dup(incoming);
      
     
    - ## editor.c ##
    -@@ editor.c: static int launch_specified_editor(const char *editor, const char *path,
    - 		strbuf_realpath(&realpath, path, 1);
    - 		args[1] = realpath.buf;
    - 
    --		p.argv = args;
    -+		strvec_pushv(&p.args, args);
    - 		p.env = env;
    - 		p.use_shell = 1;
    - 		p.trace2_child_class = "editor";
    -
      ## http-backend.c ##
     @@ http-backend.c: static void run_service(const char **argv, int buffer_input)
      		strvec_pushf(&cld.env_array,
    @@ run-command.c: int run_command_v_opt_cd_env_tr2(const char **argv, int opt, cons
      	cmd.git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
      	cmd.stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
     
    - ## sequencer.c ##
    -@@ sequencer.c: static int run_rewrite_hook(const struct object_id *oldoid,
    - 	argv[1] = "amend";
    - 	argv[2] = NULL;
    - 
    --	proc.argv = argv;
    -+	strvec_pushv(&proc.args, argv);
    - 	proc.in = -1;
    - 	proc.stdout_to_stderr = 1;
    - 	proc.trace2_hook_name = "post-rewrite";
    -
      ## t/helper/test-subprocess.c ##
     @@ t/helper/test-subprocess.c: int cmd__subprocess(int argc, const char **argv)
      		argv++;
    @@ t/helper/test-subprocess.c: int cmd__subprocess(int argc, const char **argv)
     +	strvec_pushv(&cp.args, (const char **)argv + 1);
      	return run_command(&cp);
      }
    -
    - ## transport.c ##
    -@@ transport.c: static int run_pre_push_hook(struct transport *transport,
    - 	argv[2] = transport->url;
    - 	argv[3] = NULL;
    - 
    --	proc.argv = argv;
    -+	strvec_pushv(&proc.args, argv);
    - 	proc.in = -1;
    - 	proc.trace2_hook_name = "pre-push";
    - 
 -:  ----------- >  4:  a2ee10e214c run-command tests: use strvec_pushv(), not argv assignment
 4:  61751f55ff2 !  5:  2b446606eb9 run-command API users: use strvec_pushl(), not argv construction
    @@ Metadata
      ## Commit message ##
         run-command API users: use strvec_pushl(), not argv construction
     
    -    Migrate those run-command API users that assign directly to the "argv"
    -    member to use a strvec_pushl() of a list instead, this gets rid of the
    -    intermediate "const char *args[]" these callers were using.
    +    Change a pattern of hardcoding an "argv" array size, populating it and
    +    assigning to the "argv" member of "struct child_process" to instead
    +    use "strvec_pushl()" to add data to the "args" member.
     
    -    This is in preparation for getting rid of the "argv" member from the
    -    run-command API itself.
    +    This implements the same behavior as before in fewer lines of code,
    +    and moves us further towards being able to remove the "argv" member in
    +    a subsequent commit.
     
    -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Since we've entirely removed the "argv" variable(s) we can be sure
    +    that no potential logic errors of the type discussed in a preceding
    +    commit are being introduced here, i.e. ones where the local "argv" was
    +    being modified after the assignment to "struct child_process"'s
    +    "argv".
     
    - ## archive-tar.c ##
    -@@ archive-tar.c: static int write_tar_filter_archive(const struct archiver *ar,
    - {
    - 	struct strbuf cmd = STRBUF_INIT;
    - 	struct child_process filter = CHILD_PROCESS_INIT;
    --	const char *argv[2];
    - 	int r;
    - 
    - 	if (!ar->data)
    -@@ archive-tar.c: static int write_tar_filter_archive(const struct archiver *ar,
    - 	if (args->compression_level >= 0)
    - 		strbuf_addf(&cmd, " -%d", args->compression_level);
    - 
    --	argv[0] = cmd.buf;
    --	argv[1] = NULL;
    --	filter.argv = argv;
    -+	strvec_push(&filter.args, cmd.buf);
    - 	filter.use_shell = 1;
    - 	filter.in = -1;
    - 
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/add.c ##
     @@ builtin/add.c: int interactive_add(const char **argv, const char *prefix, int patch)
    @@ builtin/add.c: static int edit_patch(int argc, const char **argv, const char *pr
      
      	child.git_cmd = 1;
     -	child.argv = apply_argv;
    -+	strvec_pushl(&child.args, "apply", "--recount", "--cached", file, NULL);
    ++	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
    ++		     NULL);
      	if (run_command(&child))
      		die(_("Could not apply '%s'"), file);
      
    @@ builtin/merge.c: static int save_state(struct object_id *stash)
      	cp.git_cmd = 1;
      
     
    + ## builtin/notes.c ##
    +@@ builtin/notes.c: static void copy_obj_to_fd(int fd, const struct object_id *oid)
    + 
    + static void write_commented_object(int fd, const struct object_id *object)
    + {
    +-	const char *show_args[5] =
    +-		{"show", "--stat", "--no-notes", oid_to_hex(object), NULL};
    + 	struct child_process show = CHILD_PROCESS_INIT;
    + 	struct strbuf buf = STRBUF_INIT;
    + 	struct strbuf cbuf = STRBUF_INIT;
    + 
    + 	/* Invoke "git show --stat --no-notes $object" */
    +-	show.argv = show_args;
    ++	strvec_pushl(&show.args, "show", "--stat", "--no-notes",
    ++		     oid_to_hex(object), NULL);
    + 	show.no_stdin = 1;
    + 	show.out = -1;
    + 	show.err = 0;
    +
    + ## builtin/receive-pack.c ##
    +@@ builtin/receive-pack.c: static const char *push_to_deploy(unsigned char *sha1,
    + 				  struct strvec *env,
    + 				  const char *work_tree)
    + {
    +-	const char *update_refresh[] = {
    +-		"update-index", "-q", "--ignore-submodules", "--refresh", NULL
    +-	};
    +-	const char *diff_files[] = {
    +-		"diff-files", "--quiet", "--ignore-submodules", "--", NULL
    +-	};
    +-	const char *diff_index[] = {
    +-		"diff-index", "--quiet", "--cached", "--ignore-submodules",
    +-		NULL, "--", NULL
    +-	};
    +-	const char *read_tree[] = {
    +-		"read-tree", "-u", "-m", NULL, NULL
    +-	};
    + 	struct child_process child = CHILD_PROCESS_INIT;
    + 
    +-	child.argv = update_refresh;
    ++	strvec_pushl(&child.args, "update-index", "-q", "--ignore-submodules",
    ++		     "--refresh", NULL);
    + 	child.env = env->v;
    + 	child.dir = work_tree;
    + 	child.no_stdin = 1;
    +@@ builtin/receive-pack.c: static const char *push_to_deploy(unsigned char *sha1,
    + 
    + 	/* run_command() does not clean up completely; reinitialize */
    + 	child_process_init(&child);
    +-	child.argv = diff_files;
    ++	strvec_pushl(&child.args, "diff-files", "--quiet",
    ++		     "--ignore-submodules", "--", NULL);
    + 	child.env = env->v;
    + 	child.dir = work_tree;
    + 	child.no_stdin = 1;
    +@@ builtin/receive-pack.c: static const char *push_to_deploy(unsigned char *sha1,
    + 	if (run_command(&child))
    + 		return "Working directory has unstaged changes";
    + 
    +-	/* diff-index with either HEAD or an empty tree */
    +-	diff_index[4] = head_has_history() ? "HEAD" : empty_tree_oid_hex();
    +-
    + 	child_process_init(&child);
    +-	child.argv = diff_index;
    ++	strvec_pushl(&child.args, "diff-index", "--quiet", "--cached",
    ++		     "--ignore-submodules",
    ++		     /* diff-index with either HEAD or an empty tree */
    ++		     head_has_history() ? "HEAD" : empty_tree_oid_hex(),
    ++		     "--", NULL);
    + 	child.env = env->v;
    + 	child.no_stdin = 1;
    + 	child.no_stdout = 1;
    +@@ builtin/receive-pack.c: static const char *push_to_deploy(unsigned char *sha1,
    + 	if (run_command(&child))
    + 		return "Working directory has staged changes";
    + 
    +-	read_tree[3] = hash_to_hex(sha1);
    + 	child_process_init(&child);
    +-	child.argv = read_tree;
    ++	strvec_pushl(&child.args, "read-tree", "-u", "-m", hash_to_hex(sha1),
    ++		     NULL);
    + 	child.env = env->v;
    + 	child.dir = work_tree;
    + 	child.no_stdin = 1;
    +@@ builtin/receive-pack.c: int cmd_receive_pack(int argc, const char **argv, const char *prefix)
    + 		run_update_post_hook(commands);
    + 		string_list_clear(&push_options, 0);
    + 		if (auto_gc) {
    +-			const char *argv_gc_auto[] = {
    +-				"gc", "--auto", "--quiet", NULL,
    +-			};
    + 			struct child_process proc = CHILD_PROCESS_INIT;
    + 
    + 			proc.no_stdin = 1;
    + 			proc.stdout_to_stderr = 1;
    + 			proc.err = use_sideband ? -1 : 0;
    + 			proc.git_cmd = proc.close_object_store = 1;
    +-			proc.argv = argv_gc_auto;
    ++			strvec_pushl(&proc.args, "gc", "--auto", "--quiet",
    ++				     NULL);
    + 
    + 			if (!start_command(&proc)) {
    + 				if (use_sideband)
    +
      ## builtin/replace.c ##
     @@ builtin/replace.c: static int import_object(struct object_id *oid, enum object_type type,
      		return error_errno(_("unable to open %s for reading"), filename);
    @@ builtin/replace.c: static int import_object(struct object_id *oid, enum object_t
      		cmd.in = fd;
      		cmd.out = -1;
     
    - ## daemon.c ##
    -@@ daemon.c: static int run_access_hook(struct daemon_service *service, const char *dir,
    - {
    - 	struct child_process child = CHILD_PROCESS_INIT;
    - 	struct strbuf buf = STRBUF_INIT;
    --	const char *argv[8];
    --	const char **arg = argv;
    - 	char *eol;
    - 	int seen_errors = 0;
    - 
    --	*arg++ = access_hook;
    --	*arg++ = service->name;
    --	*arg++ = path;
    --	*arg++ = hi->hostname.buf;
    --	*arg++ = get_canon_hostname(hi);
    --	*arg++ = get_ip_address(hi);
    --	*arg++ = hi->tcp_port.buf;
    --	*arg = NULL;
    --
    - 	child.use_shell = 1;
    --	child.argv = argv;
    -+	strvec_pushl(&child.args, access_hook, service->name, path,
    -+		     hi->hostname.buf, get_canon_hostname(hi),
    -+		     get_ip_address(hi), hi->tcp_port.buf, NULL);
    - 	child.no_stdin = 1;
    - 	child.no_stderr = 1;
    - 	child.out = -1;
    + ## editor.c ##
    +@@ editor.c: static int launch_specified_editor(const char *editor, const char *path,
    + 
    + 	if (strcmp(editor, ":")) {
    + 		struct strbuf realpath = STRBUF_INIT;
    +-		const char *args[] = { editor, NULL, NULL };
    + 		struct child_process p = CHILD_PROCESS_INIT;
    + 		int ret, sig;
    + 		int print_waiting_for_editor = advice_enabled(ADVICE_WAITING_FOR_EDITOR) && isatty(2);
    +@@ editor.c: static int launch_specified_editor(const char *editor, const char *path,
    + 		}
    + 
    + 		strbuf_realpath(&realpath, path, 1);
    +-		args[1] = realpath.buf;
    + 
    +-		p.argv = args;
    ++		strvec_pushl(&p.args, editor, realpath.buf, NULL);
    + 		p.env = env;
    + 		p.use_shell = 1;
    + 		p.trace2_child_class = "editor";
     
    - ## diff.c ##
    -@@ diff.c: static char *run_textconv(struct repository *r,
    - 			  size_t *outsize)
    + ## sequencer.c ##
    +@@ sequencer.c: static int run_rewrite_hook(const struct object_id *oldoid,
    + 			    const struct object_id *newoid)
      {
    - 	struct diff_tempfile *temp;
    + 	struct child_process proc = CHILD_PROCESS_INIT;
     -	const char *argv[3];
    --	const char **arg = argv;
    - 	struct child_process child = CHILD_PROCESS_INIT;
    - 	struct strbuf buf = STRBUF_INIT;
    - 	int err = 0;
    - 
    - 	temp = prepare_temp_file(r, spec->path, spec);
    --	*arg++ = pgm;
    --	*arg++ = temp->name;
    --	*arg = NULL;
    - 
    - 	child.use_shell = 1;
    --	child.argv = argv;
    -+	strvec_pushl(&child.args, pgm, temp->name, NULL);
    - 	child.out = -1;
    - 	if (start_command(&child)) {
    - 		remove_tempfile();
    -
    - ## prompt.c ##
    -@@
    - static char *do_askpass(const char *cmd, const char *prompt)
    - {
    - 	struct child_process pass = CHILD_PROCESS_INIT;
    --	const char *args[3];
    - 	static struct strbuf buffer = STRBUF_INIT;
    - 	int err = 0;
    - 
    --	args[0] = cmd;
    --	args[1]	= prompt;
    --	args[2] = NULL;
    --
    --	pass.argv = args;
    -+	strvec_pushl(&pass.args, cmd, prompt, NULL);
    - 	pass.out = -1;
    + 	int code;
    + 	struct strbuf sb = STRBUF_INIT;
    ++	const char *hook_path = find_hook("post-rewrite");
      
    - 	if (start_command(&pass))
    +-	argv[0] = find_hook("post-rewrite");
    +-	if (!argv[0])
    ++	if (!hook_path)
    + 		return 0;
    + 
    +-	argv[1] = "amend";
    +-	argv[2] = NULL;
    +-
    +-	proc.argv = argv;
    ++	strvec_pushl(&proc.args, hook_path, "amend", NULL);
    + 	proc.in = -1;
    + 	proc.stdout_to_stderr = 1;
    + 	proc.trace2_hook_name = "post-rewrite";
     
      ## upload-pack.c ##
     @@ upload-pack.c: static int do_reachable_revlist(struct child_process *cmd,
 1:  1d8cab554bb !  6:  fad420dc563 archive-tar: use our own cmd.buf in error message
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    archive-tar: use our own cmd.buf in error message
    +    run-command API users: use strvec_push(), not argv construction
     
    -    Use the "cmd.buf" we just created in this function, instead of the
    -    argv[0], which we assigned "cmd.buf" for. This is in preparation for
    -    getting rid of the use of "argv" in this function.
    +    Change a pattern of hardcoding an "argv" array size, populating it and
    +    assigning to the "argv" member of "struct child_process" to instead
    +    use "strvec_push()" to add data to the "args" member.
    +
    +    As noted in the preceding commit this moves us further towards being
    +    able to remove the "argv" member in a subsequent commit
    +
    +    These callers could have used strvec_pushl(), but moving to
    +    strvec_push() makes the diff easier to read, and keeps the arguments
    +    aligned as before.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## archive-tar.c ##
     @@ archive-tar.c: static int write_tar_filter_archive(const struct archiver *ar,
    + {
    + 	struct strbuf cmd = STRBUF_INIT;
    + 	struct child_process filter = CHILD_PROCESS_INIT;
    +-	const char *argv[2];
    + 	int r;
    + 
    + 	if (!ar->data)
    +@@ archive-tar.c: static int write_tar_filter_archive(const struct archiver *ar,
    + 	if (args->compression_level >= 0)
    + 		strbuf_addf(&cmd, " -%d", args->compression_level);
    + 
    +-	argv[0] = cmd.buf;
    +-	argv[1] = NULL;
    +-	filter.argv = argv;
    ++	strvec_push(&filter.args, cmd.buf);
    + 	filter.use_shell = 1;
      	filter.in = -1;
      
      	if (start_command(&filter) < 0)
    @@ archive-tar.c: static int write_tar_filter_archive(const struct archiver *ar,
      
      	strbuf_release(&cmd);
      	return r;
    +
    + ## builtin/receive-pack.c ##
    +@@ builtin/receive-pack.c: static int run_and_feed_hook(const char *hook_name, feed_fn feed,
    + {
    + 	struct child_process proc = CHILD_PROCESS_INIT;
    + 	struct async muxer;
    +-	const char *argv[2];
    + 	int code;
    ++	const char *hook_path = find_hook(hook_name);
    + 
    +-	argv[0] = find_hook(hook_name);
    +-	if (!argv[0])
    ++	if (!hook_path)
    + 		return 0;
    + 
    +-	argv[1] = NULL;
    +-
    +-	proc.argv = argv;
    ++	strvec_push(&proc.args, hook_path);
    + 	proc.in = -1;
    + 	proc.stdout_to_stderr = 1;
    + 	proc.trace2_hook_name = hook_name;
    +@@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
    + 
    + static int run_update_hook(struct command *cmd)
    + {
    +-	const char *argv[5];
    + 	struct child_process proc = CHILD_PROCESS_INIT;
    + 	int code;
    ++	const char *hook_path = find_hook("update");
    + 
    +-	argv[0] = find_hook("update");
    +-	if (!argv[0])
    ++	if (!hook_path)
    + 		return 0;
    + 
    +-	argv[1] = cmd->ref_name;
    +-	argv[2] = oid_to_hex(&cmd->old_oid);
    +-	argv[3] = oid_to_hex(&cmd->new_oid);
    +-	argv[4] = NULL;
    ++	strvec_push(&proc.args, hook_path);
    ++	strvec_push(&proc.args, cmd->ref_name);
    ++	strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
    ++	strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
    + 
    + 	proc.no_stdin = 1;
    + 	proc.stdout_to_stderr = 1;
    + 	proc.err = use_sideband ? -1 : 0;
    +-	proc.argv = argv;
    + 	proc.trace2_hook_name = "update";
    + 
    + 	code = start_command(&proc);
    +@@ builtin/receive-pack.c: static int run_proc_receive_hook(struct command *commands,
    + 	struct child_process proc = CHILD_PROCESS_INIT;
    + 	struct async muxer;
    + 	struct command *cmd;
    +-	const char *argv[2];
    + 	struct packet_reader reader;
    + 	struct strbuf cap = STRBUF_INIT;
    + 	struct strbuf errmsg = STRBUF_INIT;
    + 	int hook_use_push_options = 0;
    + 	int version = 0;
    + 	int code;
    ++	const char *hook_path = find_hook("proc-receive");
    + 
    +-	argv[0] = find_hook("proc-receive");
    +-	if (!argv[0]) {
    ++	if (!hook_path) {
    + 		rp_error("cannot find hook 'proc-receive'");
    + 		return -1;
    + 	}
    +-	argv[1] = NULL;
    + 
    +-	proc.argv = argv;
    ++	strvec_push(&proc.args, hook_path);
    + 	proc.in = -1;
    + 	proc.out = -1;
    + 	proc.trace2_hook_name = "proc-receive";
    +
    + ## daemon.c ##
    +@@ daemon.c: static int run_access_hook(struct daemon_service *service, const char *dir,
    + {
    + 	struct child_process child = CHILD_PROCESS_INIT;
    + 	struct strbuf buf = STRBUF_INIT;
    +-	const char *argv[8];
    +-	const char **arg = argv;
    + 	char *eol;
    + 	int seen_errors = 0;
    + 
    +-	*arg++ = access_hook;
    +-	*arg++ = service->name;
    +-	*arg++ = path;
    +-	*arg++ = hi->hostname.buf;
    +-	*arg++ = get_canon_hostname(hi);
    +-	*arg++ = get_ip_address(hi);
    +-	*arg++ = hi->tcp_port.buf;
    +-	*arg = NULL;
    ++	strvec_push(&child.args, access_hook);
    ++	strvec_push(&child.args, service->name);
    ++	strvec_push(&child.args, path);
    ++	strvec_push(&child.args, hi->hostname.buf);
    ++	strvec_push(&child.args, get_canon_hostname(hi));
    ++	strvec_push(&child.args, get_ip_address(hi));
    ++	strvec_push(&child.args, hi->tcp_port.buf);
    + 
    + 	child.use_shell = 1;
    +-	child.argv = argv;
    + 	child.no_stdin = 1;
    + 	child.no_stderr = 1;
    + 	child.out = -1;
    +
    + ## diff.c ##
    +@@ diff.c: static char *run_textconv(struct repository *r,
    + 			  size_t *outsize)
    + {
    + 	struct diff_tempfile *temp;
    +-	const char *argv[3];
    +-	const char **arg = argv;
    + 	struct child_process child = CHILD_PROCESS_INIT;
    + 	struct strbuf buf = STRBUF_INIT;
    + 	int err = 0;
    + 
    + 	temp = prepare_temp_file(r, spec->path, spec);
    +-	*arg++ = pgm;
    +-	*arg++ = temp->name;
    +-	*arg = NULL;
    ++	strvec_push(&child.args, pgm);
    ++	strvec_push(&child.args, temp->name);
    + 
    + 	child.use_shell = 1;
    +-	child.argv = argv;
    + 	child.out = -1;
    + 	if (start_command(&child)) {
    + 		remove_tempfile();
    +
    + ## prompt.c ##
    +@@
    + static char *do_askpass(const char *cmd, const char *prompt)
    + {
    + 	struct child_process pass = CHILD_PROCESS_INIT;
    +-	const char *args[3];
    + 	static struct strbuf buffer = STRBUF_INIT;
    + 	int err = 0;
    + 
    +-	args[0] = cmd;
    +-	args[1]	= prompt;
    +-	args[2] = NULL;
    ++	strvec_push(&pass.args, cmd);
    ++	strvec_push(&pass.args, prompt);
    + 
    +-	pass.argv = args;
    + 	pass.out = -1;
    + 
    + 	if (start_command(&pass))
    +
    + ## transport.c ##
    +@@ transport.c: static int run_pre_push_hook(struct transport *transport,
    + 	struct ref *r;
    + 	struct child_process proc = CHILD_PROCESS_INIT;
    + 	struct strbuf buf;
    +-	const char *argv[4];
    ++	const char *hook_path = find_hook("pre-push");
    + 
    +-	if (!(argv[0] = find_hook("pre-push")))
    ++	if (!hook_path)
    + 		return 0;
    + 
    +-	argv[1] = transport->remote->name;
    +-	argv[2] = transport->url;
    +-	argv[3] = NULL;
    ++	strvec_push(&proc.args, hook_path);
    ++	strvec_push(&proc.args, transport->remote->name);
    ++	strvec_push(&proc.args, transport->url);
    + 
    +-	proc.argv = argv;
    + 	proc.in = -1;
    + 	proc.trace2_hook_name = "pre-push";
    + 
 5:  ea1011f7473 !  7:  67ab5114ed7 run-command API: remove "argv" member, always use "args"
    @@ Commit message
         API might be painful.
     
         We also have a recent report[2] of a user of the API segfaulting,
    -    which is a direct result of it being complex to use. A test being
    -    added here would segfault before this change.
    +    which is a direct result of it being complex to use. This commit
    +    addresses the root cause of that bug.
     
         This change is larger than I'd like, but there's no easy way to avoid
         it that wouldn't involve even more verbose intermediate steps. We use
    @@ Commit message
         change all parts of run-command.[ch] itself, as well as the trace2
         logging at the same time.
     
    -    We can also similarly follow-up and remove "env" member in favor of
    -    "env_array", which is a much smaller change than this series removing
    -    "argv", but let's stop at "argv" for now. We can always do "env" as a
    -    follow-up.
    -
    -    I have not carefully tested the Windows-specific code in
    -    start_command() as I don't have a Windows system, but it seems to pass
    -    CI + runs the tests there.
    +    The resulting Windows-specific code in start_command() is a bit nasty,
    +    as we're now assigning to a strvec's "v" member, instead of to our own
    +    "argv". There was a suggestion of some alternate approaches in reply
    +    to an earlier version of this commit[3], but let's leave larger a
    +    larger and needless refactoring of this code for now.
     
         1. http://lore.kernel.org/git/YT6BnnXeAWn8BycF@coredump.intra.peff.net
         2. https://lore.kernel.org/git/20211120194048.12125-1-ematsumiya@suse.de/
    +    3. https://lore.kernel.org/git/patch-5.5-ea1011f7473-20211122T153605Z-avarab@gmail.com/
     
    -    Reported-by: Enzo Matsumiya <ematsumiya@suse.de>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/worktree.c ##
    -@@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
    - 		goto done;
    - 
    - 	if (opts->checkout) {
    --		cp.argv = NULL;
    - 		strvec_clear(&cp.args);
    - 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
    - 		if (opts->quiet)
    -@@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
    - 			cp.stdout_to_stderr = 1;
    - 			cp.dir = path;
    - 			cp.env = env;
    --			cp.argv = NULL;
    - 			cp.trace2_hook_name = "post-checkout";
    - 			strvec_pushl(&cp.args, absolute_path(hook),
    - 				     oid_to_hex(null_oid()),
    -
      ## run-command.c ##
     @@ run-command.c: static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
      	switch (cerr->err) {
    @@ run-command.c: int start_command(struct child_process *cmd)
      {
      	int fhin = 0, fhout = 1, fherr = 2;
     -	const char **sargv = cmd->argv;
    -+	const char **sargv = strvec_detach(&cmd->args);
    ++	const char **sargv = cmd->args.v;
      	struct strvec nargv = STRVEC_INIT;
    -+	const char **temp_argv = NULL;
      
      	if (cmd->no_stdin)
    - 		fhin = open("/dev/null", O_RDWR);
     @@ run-command.c: int start_command(struct child_process *cmd)
      		fhout = dup(cmd->out);
      
      	if (cmd->git_cmd)
     -		cmd->argv = prepare_git_cmd(&nargv, cmd->argv);
    -+		temp_argv = prepare_git_cmd(&nargv, sargv);
    ++		cmd->args.v = prepare_git_cmd(&nargv, sargv);
      	else if (cmd->use_shell)
     -		cmd->argv = prepare_shell_cmd(&nargv, cmd->argv);
    -+		temp_argv = prepare_shell_cmd(&nargv, sargv);
    -+	else
    -+		temp_argv = sargv;
    -+	if (!temp_argv)
    -+		BUG("should have some cmd->args to set");
    -+	strvec_pushv(&cmd->args, temp_argv);
    -+	strvec_clear(&nargv);
    ++		cmd->args.v = prepare_shell_cmd(&nargv, sargv);
      
     -	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, (char**) cmd->env,
     +	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v, (char**) cmd->env,
    @@ run-command.c: int start_command(struct child_process *cmd)
      	if (cmd->clean_on_exit && cmd->pid >= 0)
      		mark_child_for_cleanup(cmd->pid, cmd);
      
    --	strvec_clear(&nargv);
    + 	strvec_clear(&nargv);
     -	cmd->argv = sargv;
    -+	strvec_pushv(&cmd->args, sargv);;
    -+	free(sargv);
    ++	cmd->args.v = sargv;
      	if (fhin != 0)
      		close(fhin);
      	if (fhout != 1)
    @@ sub-process.c: static int handshake_capabilities(struct child_process *process,
      	}
      
     
    - ## t/helper/test-run-command.c ##
    -@@ t/helper/test-run-command.c: static int parallel_next(struct child_process *cp,
    - 	if (number_callbacks >= 4)
    - 		return 0;
    - 
    --	strvec_pushv(&cp->args, d->argv);
    -+	strvec_pushv(&cp->args, d->args.v);
    - 	strbuf_addstr(err, "preloaded output of a child\n");
    - 	number_callbacks++;
    - 	return 1;
    -@@ t/helper/test-run-command.c: static int quote_stress_test(int argc, const char **argv)
    - 		if (i < skip)
    - 			continue;
    - 
    --		cp.argv = args.v;
    -+		strvec_pushv(&cp.args, args.v);
    - 		strbuf_reset(&out);
    - 		if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0) < 0)
    - 			return error("Failed to spawn child process");
    -@@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    - 	}
    - 	if (argc < 3)
    - 		return 1;
    --	proc.argv = (const char **)argv + 2;
    -+	strvec_clear(&proc.args);
    -+	strvec_pushv(&proc.args, (const char **)argv + 2);
    - 
    - 	if (!strcmp(argv[1], "start-command-ENOENT")) {
    - 		if (start_command(&proc) < 0 && errno == ENOENT)
    -@@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
    - 		exit(run_command(&proc));
    - 
    - 	jobs = atoi(argv[2]);
    --	proc.argv = (const char **)argv + 3;
    -+	strvec_clear(&proc.args);
    -+	strvec_pushv(&proc.args, (const char **)argv + 3);
    - 
    - 	if (!strcmp(argv[1], "run-command-parallel"))
    - 		exit(run_processes_parallel(jobs, parallel_next,
    -
    - ## t/t7006-pager.sh ##
    -@@ t/t7006-pager.sh: test_expect_success 'setup' '
    - 	test_commit initial
    - '
    - 
    -+test_expect_success 'non-existent pager does not segfault' '
    -+	git -c pager.show=INVALID show
    -+'
    -+
    - test_expect_success TTY 'some commands use a pager' '
    - 	rm -f paginated.out &&
    - 	test_terminal git log &&
    -
      ## trace2/tr2_tgt_event.c ##
     @@ trace2/tr2_tgt_event.c: static void fn_child_start_fl(const char *file, int line,
      	jw_object_inline_begin_array(&jw, "argv");
 -:  ----------- >  8:  b8387a4a76d difftool: use "env_array" to simplify memory management
 -:  ----------- >  9:  6bd9f508a3d run-command API: remove "env" member, always use "env_array"
-- 
2.34.0.831.gd33babec0d1

