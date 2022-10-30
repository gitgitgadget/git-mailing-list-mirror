Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6F3FA373D
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ3Lkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Lkl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:40:41 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BE8B1F2
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130024; bh=tMarVyDTDBTh3Qd130O0BgfBGu1zuls2xCUo11Mm6to=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=XihxO8lrfrAUoYxN/scmBe+yZui3gT2ewFf/nUXeEMaQyy+gRqP7P2M1nCrKHZ6VH
         20DU78+Ok61QGvwH2Rb9E9EKK6v30W/p4HwDSSgiWL+rPQBvxhh6KEPqORwDAx/344
         Ssm2OjBydfhqL10xRyLd5rcpzL5i+WiBTrjGZJTMwc2GsBfFi9s6F23SbxQhpiMfxF
         1P5fVwGtSKY6S+25ceCbIJ+7SRcnUtUNCOPMCx4AdjHBhXWa3xUIENrHpVEuoSq14V
         8KGD+0GRO/EF4BL7VkaZH7Mh5J/YSwuUylSKLdlpvHKlAF1iwGg/gWr5YFVop3iQwo
         /WFhQfJkZTbhg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m9H-1oopYp0iot-000vxK; Sun, 30
 Oct 2022 12:40:24 +0100
Message-ID: <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
Date:   Sun, 30 Oct 2022 12:40:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 0/12] run-command: remove run_command_v_*()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
In-Reply-To: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VyTKoTRV3My+t+26mL1RvhbwENWS0bE+b3vAm48V0ZObO8NlkR6
 FwXNhCItayb/BylymRN7OZVmSCrCGBiMLs0RcV+TRwhMtFsRLeG8McInntUjL4p1SwW1f+x
 r0ZHWi3sEeLGGVqiK0WyGWiaju6bGClRSWLJBdpvXr5fw3qhGHl3u8Jqmre/YHMhMWa0Atd
 UOf17kXqMtbMajXFlGeOg==
UI-OutboundReport: notjunk:1;M01:P0:pnYGav/U8yc=;b15AQJiziJz8VRDw9zCykA610lf
 3kl4GZVmFOfLz0hpPS19mcvjYPtJvHe3ey0eER9f0qbd2WnIVZhDksbXnbGGNAornYAkBM2gh
 lIQl09xOCQedM1JqIkY4YRK0wZnBneDhkiLBMIpxax1+G1pkU2K+rJpnF/Cy15mY2ipc+Xhdr
 FI4agls0V/gE1UCUvG7LMBmxKa5Gh0/s6jNNfL71v/CbQuOWC2jGBU+8I8qmp7EdGpEa2qXNt
 QJ/peBrycD9HFdrE+xAxeM1IS/AntCurJx1gd/M0p6EkCp4p+uUG01stXJJylL4zkR3GJljIO
 HPe7WhtcaX+nm05+nLnVbkCGIJfibXQjguIdKmiI6bKVwTV+7Xv+58rji7rQoU+sIyntpCQGD
 pX0Y/C/uS9ghZUzrHvSB5qKAsq72IetT9Q7nCbfaNe1Pr9OFTsPbDutyfBB/edCePTu5gKdRa
 ymQVlnWHM25b7nERJTul9/73+7x/RhYEEWd76MZGJd7q/WzYVbDEqIiosQhiTCd90dX3Qug5X
 5Bp9WUPTtD4Qr2EcpVuhT91kCDbt1dYwy35g02tzj/d4o7GodtG8lnxfq4eWRC5fUOOBXvVjF
 jzHoO1HkO9x1tuxra6Z9tt+WKMdtvQ5qG7FnYX0AgQmMERO/e5Mzk3z1zm4RUr/ASF1TzosCW
 ywHHvXls5dRheUVO8HaTbVUGa8UHGCKMfwGKmMylsK5Eq8OoTKdFSWte+y5ZOj6uN1mN92hRG
 2rOuK1RA7ktYUhn7EPhBGMbn5AqK02afNvlaarhfPjOH86LeW6/R1TLcaSr03tsbCAvuS08QL
 q1FnIYGhoHhN+ZsuWz4RhvLOy5yPe2M4rEFXPdgWbVeUuGU6x4j0k8mksSpPwPuzgRChkKS9I
 uv4T1AEYqNr1R33jC84wHA73RnqVThGiSd0ASq65+jGLOQswld8D3mEozRtwIU0xS4O9eGIhp
 ZAQODvF60vcIR3pwcPazP2xUgNk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the convenience functions run_command_v_opt() et. al. and use
struct child_process and run_command() directly instead, for an overall
code reduction and a simpler and more flexible API that allows creating
argument lists without magic numbers and reduced risk of memory leaks.

Changes since v1:
- Do the return value fix earlier; it was only an afterthought before.
  Keep the colon (no "while at it, ...").
- Break out the xstrdup(), oid_to_hex_r() and C99 cleanups.
- Convert tricky string arrays before strvecs because =C3=86var didn't lik=
e
  the opposite order.
- Extend the example code in tmp-objdir.h so it still only requires
  "cmd".

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
  merge: remove always-the-same "verbose" arguments

Ren=C3=A9 Scharfe (11):
  run-command: fix return value comment
  am: simplify building "show" argument list
  bisect: simplify building "checkout" argument list
  bisect--helper: factor out do_bisect_run()
  sequencer: simplify building argument list in do_exec()
  use child_process member "args" instead of string array variable
  use child_process members "args" and "env" directly
  replace and remove run_command_v_opt_cd_env()
  replace and remove run_command_v_opt_tr2()
  replace and remove run_command_v_opt_cd_env_tr2()
  replace and remove run_command_v_opt()

 add-interactive.c        |   9 ++-
 bisect.c                 |  12 ++--
 builtin/add.c            |  19 +++--
 builtin/am.c             |  12 ++--
 builtin/bisect--helper.c |  68 +++++++++---------
 builtin/clone.c          |  41 ++++++-----
 builtin/difftool.c       |  24 ++++---
 builtin/fetch.c          |   9 ++-
 builtin/gc.c             |  55 ++++++++++-----
 builtin/merge-index.c    |   4 +-
 builtin/merge.c          |  53 ++++++--------
 builtin/pull.c           | 147 +++++++++++++++++++--------------------
 builtin/remote.c         |  40 +++++------
 compat/mingw.c           |  11 +--
 diff.c                   |  27 ++++---
 fsmonitor-ipc.c          |  10 ++-
 git.c                    |  15 ++--
 ll-merge.c               |   7 +-
 merge.c                  |  18 ++---
 run-command.c            |  35 ----------
 run-command.h            |  34 +--------
 scalar.c                 |  13 ++--
 sequencer.c              |  32 ++++-----
 shell.c                  |  17 +++--
 t/helper/test-fake-ssh.c |   7 +-
 t/helper/test-trace2.c   |   4 +-
 tmp-objdir.h             |   6 +-
 27 files changed, 346 insertions(+), 383 deletions(-)

Range-Diff gegen v1:
 1:  c0b2b88500 =3D  1:  113a9e0a81 merge: remove always-the-same "verbose=
" arguments
 -:  ---------- >  2:  d10e70460b run-command: fix return value comment
 -:  ---------- >  3:  c8cd913e39 am: simplify building "show" argument li=
st
 -:  ---------- >  4:  4bb142e4a9 bisect: simplify building "checkout" arg=
ument list
 2:  387db545d1 =3D  5:  5fcbe94eb4 bisect--helper: factor out do_bisect_r=
un()
 -:  ---------- >  6:  962403cf22 sequencer: simplify building argument li=
st in do_exec()
 4:  348bc6d32c !  7:  f1689abe85 use child_process member "args" instead =
of string array variable
    @@ Commit message

         Use run_command() with a struct child_process variable and popula=
te its
         "args" member directly instead of building a string array and pas=
sing it
    -    to run_command_v_opt().  This avoids the use of magic index numbe=
rs.
    -
    - ## bisect.c ##
    -@@ bisect.c: static struct oid_array skipped_revs;
    -
    - static struct object_id *current_bad_oid;
    -
    --static const char *argv_checkout[] =3D {"checkout", "-q", NULL, "--"=
, NULL};
    --
    - static const char *term_bad;
    - static const char *term_good;
    -
    -@@ bisect.c: static int is_expected_rev(const struct object_id *oid)
    - enum bisect_error bisect_checkout(const struct object_id *bisect_rev=
,
    - 				  int no_checkout)
    - {
    --	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
    - 	struct commit *commit;
    - 	struct pretty_print_context pp =3D {0};
    - 	struct strbuf commit_msg =3D STRBUF_INIT;
    -
    --	oid_to_hex_r(bisect_rev_hex, bisect_rev);
    - 	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE=
_REFS_DIE_ON_ERR);
    -
    --	argv_checkout[2] =3D bisect_rev_hex;
    - 	if (no_checkout) {
    - 		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
    - 			   UPDATE_REFS_DIE_ON_ERR);
    - 	} else {
    --		if (run_command_v_opt(argv_checkout, RUN_GIT_CMD))
    -+		struct child_process cmd =3D CHILD_PROCESS_INIT;
    -+
    -+		cmd.git_cmd =3D 1;
    -+		strvec_pushl(&cmd.args, "checkout", "-q",
    -+			     oid_to_hex(bisect_rev), "--", NULL);
    -+		if (run_command(&cmd))
    - 			/*
    - 			 * Errors in `run_command()` itself, signaled by res < 0,
    - 			 * and errors in the child process, signaled by res > 0
    -
    - ## builtin/am.c ##
    -@@ builtin/am.c: static int show_patch(struct am_state *state, enum s=
how_patch_type sub_mode)
    - 	int len;
    -
    - 	if (!is_null_oid(&state->orig_commit)) {
    --		const char *av[4] =3D { "show", NULL, "--", NULL };
    --		char *new_oid_str;
    --		int ret;
    -+		struct child_process cmd =3D CHILD_PROCESS_INIT;
    -
    --		av[1] =3D new_oid_str =3D xstrdup(oid_to_hex(&state->orig_commit))=
;
    --		ret =3D run_command_v_opt(av, RUN_GIT_CMD);
    --		free(new_oid_str);
    --		return ret;
    -+		strvec_pushl(&cmd.args, "show", oid_to_hex(&state->orig_commit),
    -+			     "--", NULL);
    -+		cmd.git_cmd =3D 1;
    -+		return run_command(&cmd);
    - 	}
    -
    - 	switch (sub_mode) {
    +    to run_command_v_opt().  This avoids the use of magic index numbe=
rs and
    +    makes simplifies the possible addition of more arguments in the f=
uture.

      ## builtin/difftool.c ##
     @@ builtin/difftool.c: static int run_dir_diff(const char *extcmd, in=
t symlinks, const char *prefix,
    @@ ll-merge.c: static enum ll_merge_result ll_ext_merge(const struct l=
l_merge_drive
      	if (fd < 0)
      		goto bad;

    - ## sequencer.c ##
    -@@ sequencer.c: static int error_failed_squash(struct repository *r,
    -
    - static int do_exec(struct repository *r, const char *command_line)
    - {
    --	const char *child_argv[] =3D { NULL, NULL };
    -+	struct child_process cmd =3D CHILD_PROCESS_INIT;
    - 	int dirty, status;
    -
    - 	fprintf(stderr, _("Executing: %s\n"), command_line);
    --	child_argv[0] =3D command_line;
    --	status =3D run_command_v_opt(child_argv, RUN_USING_SHELL);
    -+	cmd.use_shell =3D 1;
    -+	strvec_push(&cmd.args, command_line);
    -+	status =3D run_command(&cmd);
    -
    - 	/* force re-reading of the cache */
    - 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
    -
      ## t/helper/test-fake-ssh.c ##
     @@ t/helper/test-fake-ssh.c: int cmd_main(int argc, const char **argv=
)
      	struct strbuf buf =3D STRBUF_INIT;
 3:  7745e16df4 =3D  8:  a467a4ecb5 use child_process members "args" and "=
env" directly
 5:  eeaa6aa86d !  9:  dc27358775 replace and remove run_command_v_opt_cd_=
env()
    @@ run-command.h
     @@ run-command.h: struct child_process {

      /**
    -  * The functions: child_process_init, start_command, finish_command,
    -- * run_command, run_command_v_opt, run_command_v_opt_cd_env, child_p=
rocess_clear
    -- * do the following:
    -+ * run_command, run_command_v_opt, child_process_clear do the follow=
ing:
    +  * The functions: start_command, finish_command, run_command,
    +- * run_command_v_opt, run_command_v_opt_cd_env do the following:
    ++ * run_command_v_opt do the following:
       *
       * - If a system call failed, errno is set and -1 is returned. A dia=
gnostic
       *   is printed.
    @@ run-command.h: int run_command_v_opt_tr2(const char **argv, int opt=
, const char

      ## tmp-objdir.h ##
     @@
    +  *
       * Example:
       *
    ++ *	struct child_process child =3D CHILD_PROCESS_INIT;
       *	struct tmp_objdir *t =3D tmp_objdir_create("incoming");
     - *	if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
     - *	    !tmp_objdir_migrate(t))
    -+ *	strvec_pushv(&cmd.env, tmp_objdir_env(t));
    -+ *	if (!run_command(&cmd)) && !tmp_objdir_migrate(t))
    ++ *	strvec_push(&child.args, cmd);
    ++ *	strvec_pushv(&child.env, tmp_objdir_env(t));
    ++ *	if (!run_command(&child)) && !tmp_objdir_migrate(t))
       *		printf("success!\n");
       *	else
       *		die("failed...tmp_objdir will clean up for us");
 6:  95b5dcbb66 =3D 10:  dcd65580c6 replace and remove run_command_v_opt_t=
r2()
 7:  5e111ab053 ! 11:  389ec8ef54 replace and remove run_command_v_opt_cd_=
env_tr2()
    @@ run-command.h: int run_auto_maintenance(int quiet);

      /**
     - * Convenience functions that encapsulate a sequence of
    -+ * Convenience function that encapsulate a sequence of
    ++ * Convenience function that encapsulates a sequence of
       * start_command() followed by finish_command(). The argument argv
       * specifies the program and its arguments. The argument opt is zero
       * or more of the flags `RUN_COMMAND_NO_STDIN`, `RUN_GIT_CMD`,
 8:  f1f438d724 ! 12:  a6e7135e31 replace and remove run_command_v_opt()
    @@ Commit message

         Suggested-by: Jeff King <peff@peff.net>

    + ## bisect.c ##
    +@@ bisect.c: enum bisect_error bisect_checkout(const struct object_id=
 *bisect_rev,
    + 		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
    + 			   UPDATE_REFS_DIE_ON_ERR);
    + 	} else {
    +-		const char *argv_checkout[] =3D {
    +-			"checkout", "-q", oid_to_hex(bisect_rev), "--", NULL
    +-		};
    ++		struct child_process cmd =3D CHILD_PROCESS_INIT;
    +
    +-		if (run_command_v_opt(argv_checkout, RUN_GIT_CMD))
    ++		cmd.git_cmd =3D 1;
    ++		strvec_pushl(&cmd.args, "checkout", "-q",
    ++			     oid_to_hex(bisect_rev), "--", NULL);
    ++		if (run_command(&cmd))
    + 			/*
    + 			 * Errors in `run_command()` itself, signaled by res < 0,
    + 			 * and errors in the child process, signaled by res > 0
    +
    + ## builtin/am.c ##
    +@@ builtin/am.c: static int show_patch(struct am_state *state, enum s=
how_patch_type sub_mode)
    + 	int len;
    +
    + 	if (!is_null_oid(&state->orig_commit)) {
    +-		const char *av[] =3D {
    +-			"show", oid_to_hex(&state->orig_commit), "--", NULL
    +-		};
    ++		struct child_process cmd =3D CHILD_PROCESS_INIT;
    +
    +-		return run_command_v_opt(av, RUN_GIT_CMD);
    ++		strvec_pushl(&cmd.args, "show", oid_to_hex(&state->orig_commit),
    ++			     "--", NULL);
    ++		cmd.git_cmd =3D 1;
    ++		return run_command(&cmd);
    + 	}
    +
    + 	switch (sub_mode) {
    +
      ## builtin/bisect--helper.c ##
     @@ builtin/bisect--helper.c: static enum bisect_error bisect_start(st=
ruct bisect_terms *terms, const char **a
      		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
    @@ run-command.c: int run_command(struct child_process *cmd)

      ## run-command.h ##
     @@ run-command.h: struct child_process {
    + }

      /**
    -  * The functions: child_process_init, start_command, finish_command,
    -- * run_command, run_command_v_opt, child_process_clear do the follow=
ing:
    -+ * run_command, child_process_clear do the following:
    +- * The functions: start_command, finish_command, run_command,
    +- * run_command_v_opt do the following:
    ++ * The functions: start_command, finish_command, run_command do the =
following:
       *
       * - If a system call failed, errno is set and -1 is returned. A dia=
gnostic
       *   is printed.
    @@ run-command.h: int run_command(struct child_process *);
     -#define RUN_CLOSE_OBJECT_STORE		(1<<7)
     -
     -/**
    -- * Convenience function that encapsulate a sequence of
    +- * Convenience function that encapsulates a sequence of
     - * start_command() followed by finish_command(). The argument argv
     - * specifies the program and its arguments. The argument opt is zero
     - * or more of the flags `RUN_COMMAND_NO_STDIN`, `RUN_GIT_CMD`,
    @@ run-command.h: int run_command(struct child_process *);
       * Execute the given command, sending "in" to its stdin, and capturi=
ng its
       * stdout and stderr in the "out" and "err" strbufs. Any of the thre=
e may

    + ## sequencer.c ##
    +@@ sequencer.c: static int error_failed_squash(struct repository *r,
    +
    + static int do_exec(struct repository *r, const char *command_line)
    + {
    +-	const char *child_argv[] =3D { command_line, NULL };
    ++	struct child_process cmd =3D CHILD_PROCESS_INIT;
    + 	int dirty, status;
    +
    + 	fprintf(stderr, _("Executing: %s\n"), command_line);
    +-	status =3D run_command_v_opt(child_argv, RUN_USING_SHELL);
    ++	cmd.use_shell =3D 1;
    ++	strvec_push(&cmd.args, command_line);
    ++	status =3D run_command(&cmd);
    +
    + 	/* force re-reading of the cache */
    + 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
    +
      ## shell.c ##
     @@ shell.c: static void cd_to_homedir(void)
      static void run_shell(void)
 9:  59677c9598 <  -:  ---------- run-command: fix return value comment
=2D-
2.38.1
