Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFE5C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbiKRLSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239958AbiKRLSh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:37 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E58DF6A
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:35 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l11so6705152edb.4
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SEEiAy3VhZEAPyeTD5EDbfEZvR5HBADiWyx11Hq+Ts=;
        b=GIng2s1mt6tOVnx7NGWEzAEzjuyeclAaaB5/qaPCvDusLbdoo6WtRkSAVo25BX0V7w
         L8rCRyF/j8gtROcuUh10YoGC1Pj/s+NAUuo9IrG6IS1A2soI961zQN9uRAZ+jvbVq6t2
         BK0SfNscLwOR0A4hlvXMABi+4L8ZhCMXGpWJ8RrtnPD1n9IaCDVAXf4Oblod6DucmgUi
         eBIsWu84F+vtvm78gRJWXja2uakyVPhoN4lFqhawBUL+UTonkWOFoKgOZhosAWmFWdGk
         qs5qDPHDig6UNoHe6KM6jzVPWU286IzKlevvc19WmR6ETuWoUWdGjt1NnLgi6SYzGwRi
         +Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SEEiAy3VhZEAPyeTD5EDbfEZvR5HBADiWyx11Hq+Ts=;
        b=uxdlewhzjY5m22YGpEMntlCGNEu3Wiknr0M4/Gn3K1KNHVw3/9sIdL3Wsw4Csv+lF0
         7YWUSUuD6z4Wd9zW2KfoDQJJ1xdVOFRsHml/TptIzOkN5wbjVnaN1+Cx2QyYQBmhI4rv
         6gDAsNA2yYrFOxPkjaYNAqn4V+m7HaOSrmf9PlwrYGIWA8MLnzcyFHbvob1wMiwO/0xc
         PdgyiMUtrcJgx/lxROBJ66jDZx4VOYoGQngo5fv/YaWhuSesWQF1Wngolv2pm5x23PTR
         6YVJQD0yPY3qlUBThJaiHpSc7zPMk2ZByxrJmXBwPFY5k6XWUK7erjApHxRJYyRS8QC/
         Xd5g==
X-Gm-Message-State: ANoB5pnjLk8ZnGlR5aORTST5MoJzM9157tFU7HQ7Z3f2AsqqPJze7beN
        QMCOegc8oQaKPTo9KU4LOr88kbnLjx3FSg==
X-Google-Smtp-Source: AA0mqf7RKreKsuP99bQgChZcfFso5KUL4mRp7hS/D7hkLXiDrZT1hQMXc/S4LKIRXUw95Yw0M0w4GQ==
X-Received: by 2002:aa7:dc19:0:b0:461:f94:913 with SMTP id b25-20020aa7dc19000000b004610f940913mr5696037edu.102.1668770313017;
        Fri, 18 Nov 2022 03:18:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 00/12] merge-index: prepare to rewrite merge drivers in C
Date:   Fri, 18 Nov 2022 12:18:17 +0100
Message-Id: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a prep series for a re-roll of Alban Gruin's series to rewrite
various merge drivers from *.sh to *.c, and being able to call those
in-process.

This was last discussed on-list in August[1], and has been ejected
from "seen" due to staleness.

The last time around there were concerns with the later part of this
topic, but the parts that are included here weren't controversial,
those will be part 2 (and I think I've addressed those concerns).

Changes since the v8:

 * Migrate "merge-index" to parse_options(), first in a bug-for-bug
   compatible way, and then later on fix the behavior, and add tests
   along the way.

 * The 5-9/12 here were all split out in one way or another from
   Alban's 3/14[2], in such a way as to make the diff for 10/12 as
   friendly as possible (e.g. catering to rename detection).

 * Alban's converted die()/exit() in the built-in to "error()", but in
   doing so introduced a behavior change: When we'd previously process
   N items we'd exit right away, but in the v8 we'd attempt all N
   items.

   It turns out that almost nothing that came after care about the
   die(), i.e. even if we've lib-ified it it's OK to call die() within
   that library.

 * A new 11/12 hopefully makes the way merge-index parses out OIDs and
   types easier to reason about.

 * Finally, 12/12 makes the semantics of "merge-index" sane vis-a-vis
   parse_options().

Passing CI and branch for this at
https://github.com/avar/git/tree/ag/merge-strategies-in-c-prep

The follow-on from this is then
https://github.com/avar/git/tree/ag/merge-strategies-in-c-2, for those
that want to peek ahead.

1. https://lore.kernel.org/git/20220809185429.20098-9-alban.gruin@gmail.com/
2. https://lore.kernel.org/git/20220809185429.20098-4-alban.gruin@gmail.com/

Alban Gruin (4):
  t6060: modify multiple files to expose a possible issue with
    merge-index
  t6060: add tests for removed files
  merge-index: improve die() error messages
  merge-index: libify merge_one_path() and merge_all()

Ævar Arnfjörð Bjarmason (8):
  merge-index doc & -h: fix padding, labels and "()" use
  merge-index tests: add usage tests
  merge-index: migrate to parse_options() API
  merge-index i18n: mark die() messages for translation
  merge-index: stop calling ensure_full_index() twice
  builtin/merge-index.c: don't USE_THE_INDEX_COMPATIBILITY_MACROS
  merge-index: use "struct strvec" and helper to prepare args
  merge-index: make the argument parsing sensible & simpler

 Documentation/git-merge-index.txt |   2 +-
 Makefile                          |   1 +
 builtin/merge-index.c             | 169 ++++++++++++++----------------
 git.c                             |   2 +-
 merge-strategies.c                |  87 +++++++++++++++
 merge-strategies.h                |  19 ++++
 t/t0450/txt-help-mismatches       |   1 -
 t/t6060-merge-index.sh            |  65 +++++++++++-
 8 files changed, 250 insertions(+), 96 deletions(-)
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

Range-diff against v8:
 -:  ----------- >  1:  cafc7db374e merge-index doc & -h: fix padding, labels and "()" use
 1:  0f791f500e6 !  2:  099d4812601 t6060: modify multiple files to expose a possible issue with merge-index
    @@ Commit message
         be trivially mergeable.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t6060-merge-index.sh ##
    -@@ t/t6060-merge-index.sh: test_description='basic git merge-index / git-merge-one-file tests'
    +@@ t/t6060-merge-index.sh: TEST_PASSES_SANITIZE_LEAK=true
      
      test_expect_success 'setup diverging branches' '
      	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
 2:  ed9e7a45855 !  3:  af3a235a224 t6060: add tests for removed files
    @@ Commit message
         tagged as `base', and deletes it in the commit tagged as `two'.
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t6060-merge-index.sh ##
    -@@ t/t6060-merge-index.sh: test_description='basic git merge-index / git-merge-one-file tests'
    +@@ t/t6060-merge-index.sh: TEST_PASSES_SANITIZE_LEAK=true
      test_expect_success 'setup diverging branches' '
      	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
      	cp file file2 &&
 -:  ----------- >  4:  7d686637fa3 merge-index tests: add usage tests
 -:  ----------- >  5:  845f9b0cc19 merge-index: migrate to parse_options() API
 -:  ----------- >  6:  fc4e64f669e merge-index: improve die() error messages
 -:  ----------- >  7:  04c2bae9e68 merge-index i18n: mark die() messages for translation
 -:  ----------- >  8:  badfc60354a merge-index: stop calling ensure_full_index() twice
 -:  ----------- >  9:  f29343197eb builtin/merge-index.c: don't USE_THE_INDEX_COMPATIBILITY_MACROS
 3:  d1d5740a8e5 ! 10:  c7a131a9a86 merge-index: libify merge_one_path() and merge_all()
    @@ Metadata
      ## Commit message ##
         merge-index: libify merge_one_path() and merge_all()
     
    -    The "resolve" and "octopus" merge strategies do not call directly `git
    -    merge-one-file', they delegate the work to another git command, `git
    -    merge-index', that will loop over files in the index and call the
    -    specified command.  Unfortunately, these functions are not part of
    -    libgit.a, which means that once rewritten, the strategies would still
    -    have to invoke `merge-one-file' by spawning a new process first.
    +    Move the workhorse functions in "builtin/merge-index.c" into a new
    +    "merge-strategies" library, and mostly "libify" the code while doing
    +    so.
     
    -    To avoid this, this moves and renames merge_one_path(), merge_all(), and
    -    their helpers to merge-strategies.c.  They also take a callback to
    -    dictate what they should do for each file.  For now, to preserve the
    -    behaviour of `merge-index', only one callback, launching a new process,
    -    is defined.
    +    Eventually this will allow us to invoke merge strategies such as
    +    "resolve" and "octopus" in-process, once we've followed-up and
    +    replaced "git-merge-{resolve,octopus}.sh" etc.
    +
    +    But for now let's move this code, while trying to optimize for as much
    +    of it as possible being highlighted by the diff rename detection.
    +
    +    We still call die() in this library. An earlier version of this[1]
    +    converted these to "error()", but the problem with that that we'd then
    +    potentially run into the same error N times, e.g. once for every
    +    "<file>" we were asked to operate on, instead of dying on the first
    +    case. So let's leave those to "die()" for now.
    +
    +    1. https://lore.kernel.org/git/20220809185429.20098-4-alban.gruin@gmail.com/
     
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
     @@ Makefile: LIB_OBJS += merge-blobs.o
    @@ Makefile: LIB_OBJS += merge-blobs.o
     
      ## builtin/merge-index.c ##
     @@
    - #define USE_THE_INDEX_COMPATIBILITY_MACROS
      #include "builtin.h"
    + #include "parse-options.h"
     +#include "merge-strategies.h"
      #include "run-command.h"
      
    - static const char *pgm;
    +-static const char *pgm;
     -static int one_shot, quiet;
     -static int err;
    ++struct mofs_data {
    ++	const char *program;
    ++};
      
    --static int merge_entry(int pos, const char *path)
    -+static int merge_one_file_spawn(struct index_state *istate,
    -+				const struct object_id *orig_blob,
    -+				const struct object_id *our_blob,
    -+				const struct object_id *their_blob, const char *path,
    -+				unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    -+				void *data)
    +-static int merge_entry(struct index_state *istate, int pos, const char *path)
    ++static int merge_one_file(struct index_state *istate,
    ++			  const struct object_id *orig_blob,
    ++			  const struct object_id *our_blob,
    ++			  const struct object_id *their_blob, const char *path,
    ++			  unsigned int orig_mode, unsigned int our_mode,
    ++			  unsigned int their_mode, void *data)
      {
     -	int found;
    --	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
    --	char hexbuf[4][GIT_MAX_HEXSZ + 1];
    --	char ownbuf[4][60];
    -+	char oids[3][GIT_MAX_HEXSZ + 1] = {{0}};
    -+	char modes[3][10] = {{0}};
    -+	const char *arguments[] = { pgm, oids[0], oids[1], oids[2],
    -+				    path, modes[0], modes[1], modes[2], NULL };
    ++	struct mofs_data *d = data;
    ++	const char *pgm = d->program;
    + 	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
    + 	char hexbuf[4][GIT_MAX_HEXSZ + 1];
    + 	char ownbuf[4][60];
    ++	int stage = 0;
    + 	struct child_process cmd = CHILD_PROCESS_INIT;
      
    --	if (pos >= active_nr)
    --		die("git merge-index: %s not in the cache", path);
    +-	if (pos >= istate->cache_nr)
    +-		die(_("'%s' is not in the cache"), path);
     -	found = 0;
     -	do {
    --		const struct cache_entry *ce = active_cache[pos];
    +-		const struct cache_entry *ce = istate->cache[pos];
     -		int stage = ce_stage(ce);
     -
     -		if (strcmp(ce->name, path))
    @@ builtin/merge-index.c
     -		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
     -		arguments[stage] = hexbuf[stage];
     -		arguments[stage + 4] = ownbuf[stage];
    --	} while (++pos < active_nr);
    +-	} while (++pos < istate->cache_nr);
     -	if (!found)
    --		die("git merge-index: %s not in the cache", path);
    +-		die(_("'%s' is not in the cache"), path);
     -
    --	if (run_command_v_opt(arguments, 0)) {
    +-	strvec_pushv(&cmd.args, arguments);
    +-	if (run_command(&cmd)) {
     -		if (one_shot)
     -			err++;
     -		else {
     -			if (!quiet)
    --				die("merge program failed");
    +-				die(_("merge program failed"));
     -			exit(1);
     -		}
    -+	if (orig_blob) {
    -+		oid_to_hex_r(oids[0], orig_blob);
    -+		xsnprintf(modes[0], sizeof(modes[0]), "%06o", orig_mode);
    ++#define ADD_MOF_ARG(oid, mode) \
    ++	if ((oid)) { \
    ++		stage++; \
    ++		oid_to_hex_r(hexbuf[stage], (oid)); \
    ++		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%06o", (mode)); \
    ++		arguments[stage] = hexbuf[stage]; \
    ++		arguments[stage + 4] = ownbuf[stage]; \
      	}
     -	return found;
     -}
    - 
    --static void merge_one_path(const char *path)
    --{
    --	int pos = cache_name_pos(path, strlen(path));
     -
    +-static void merge_one_path(struct index_state *istate, const char *path)
    +-{
    +-	int pos = index_name_pos(istate, path, strlen(path));
    + 
     -	/*
     -	 * If it already exists in the cache as stage0, it's
     -	 * already merged and there is nothing to do.
     -	 */
     -	if (pos < 0)
    --		merge_entry(-pos-1, path);
    +-		merge_entry(istate, -pos-1, path);
     -}
    -+	if (our_blob) {
    -+		oid_to_hex_r(oids[1], our_blob);
    -+		xsnprintf(modes[1], sizeof(modes[1]), "%06o", our_mode);
    -+	}
    - 
    --static void merge_all(void)
    +-
    +-static void merge_all(struct index_state *istate)
     -{
     -	int i;
    --	/* TODO: audit for interaction with sparse-index. */
    --	ensure_full_index(&the_index);
    --	for (i = 0; i < active_nr; i++) {
    --		const struct cache_entry *ce = active_cache[i];
    ++	ADD_MOF_ARG(orig_blob, orig_mode);
    ++	ADD_MOF_ARG(our_blob, our_mode);
    ++	ADD_MOF_ARG(their_blob, their_mode);
    + 
    +-	for (i = 0; i < istate->cache_nr; i++) {
    +-		const struct cache_entry *ce = istate->cache[i];
     -		if (!ce_stage(ce))
     -			continue;
    --		i += merge_entry(i, ce->name)-1;
    -+	if (their_blob) {
    -+		oid_to_hex_r(oids[2], their_blob);
    -+		xsnprintf(modes[2], sizeof(modes[2]), "%06o", their_mode);
    - 	}
    -+
    -+	return run_command_v_opt(arguments, 0);
    +-		i += merge_entry(istate, i, ce->name)-1;
    +-	}
    ++	strvec_pushv(&cmd.args, arguments);
    ++	return run_command(&cmd);
      }
      
      int cmd_merge_index(int argc, const char **argv, const char *prefix)
      {
    --	int i, force_file = 0;
    -+	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
    ++	int err = 0;
    + 	int all = 0;
    ++	int one_shot = 0;
    ++	int quiet = 0;
    + 	const char * const usage[] = {
    + 		N_("git merge-index [-o] [-q] <merge-program> (-a | ([--] <file>...))"),
    + 		NULL
    +@@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const char *prefix)
    + 		OPT_END(),
    + 	};
    + #undef OPT__MERGE_INDEX_ALL
    ++	struct mofs_data data = { 0 };
      
      	/* Without this we cannot rely on waitpid() to tell
      	 * what happened to our children.
     @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const char *prefix)
    - 		quiet = 1;
    - 		i++;
    - 	}
    -+
    - 	pgm = argv[i++];
    -+
    - 	for (; i < argc; i++) {
    - 		const char *arg = argv[i];
    - 		if (!force_file && *arg == '-') {
    + 	/* <merge-program> and its options */
    + 	if (!argc)
    + 		usage_msg_opt(_("need a <merge-program> argument"), usage, options);
    +-	pgm = argv[0];
    ++	data.program = argv[0];
    + 	argc = parse_options(argc, argv, prefix, options_prog, usage, 0);
    + 	if (argc && all)
    + 		usage_msg_opt(_("'-a' and '<file>...' are mutually exclusive"),
     @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const char *prefix)
    - 				continue;
    - 			}
    - 			if (!strcmp(arg, "-a")) {
    --				merge_all();
    -+				err |= merge_all_index(&the_index, one_shot, quiet,
    -+						       merge_one_file_spawn, NULL);
    - 				continue;
    - 			}
    - 			die("git merge-index: unknown option %s", arg);
    - 		}
    --		merge_one_path(arg);
    -+		err |= merge_index_path(&the_index, one_shot, quiet, arg,
    -+					merge_one_file_spawn, NULL);
    - 	}
    + 	ensure_full_index(the_repository->index);
    + 
    + 	if (all)
    +-		merge_all(the_repository->index);
    ++		err |= merge_all_index(the_repository->index, one_shot, quiet,
    ++				       merge_one_file, &data);
    + 	else
    + 		for (size_t i = 0; i < argc; i++)
    +-			merge_one_path(the_repository->index, argv[i]);
    ++			err |= merge_index_path(the_repository->index,
    ++						one_shot, quiet, argv[i],
    ++						merge_one_file, &data);
    + 
     -	if (err && !quiet)
    --		die("merge program failed");
    -+
    +-		die(_("merge program failed"));
      	return err;
      }
     
    @@ merge-strategies.c (new)
     +#include "merge-strategies.h"
     +
     +static int merge_entry(struct index_state *istate, unsigned int pos,
    -+		       const char *path, int *err, merge_fn fn, void *data)
    ++		       const char *path, int *err, merge_index_fn fn,
    ++		       void *data)
     +{
     +	int found = 0;
    -+	const struct object_id *oids[3] = {NULL};
    -+	unsigned int modes[3] = {0};
    ++	const struct object_id *oids[3] = { 0 };
    ++	unsigned int modes[3] = { 0 };
     +
    ++	*err = 0;
    ++
    ++	if (pos >= istate->cache_nr)
    ++		die(_("'%s' is not in the cache"), path);
     +	do {
     +		const struct cache_entry *ce = istate->cache[pos];
     +		int stage = ce_stage(ce);
    @@ merge-strategies.c (new)
     +		modes[stage - 1] = ce->ce_mode;
     +	} while (++pos < istate->cache_nr);
     +	if (!found)
    -+		return error(_("%s is not in the cache"), path);
    ++		die(_("'%s' is not in the cache"), path);
     +
    -+	if (fn(istate, oids[0], oids[1], oids[2], path,
    -+	       modes[0], modes[1], modes[2], data))
    ++	if (fn(istate, oids[0], oids[1], oids[2], path, modes[0], modes[1],
    ++	       modes[2], data))
     +		(*err)++;
     +
     +	return found;
     +}
     +
     +int merge_index_path(struct index_state *istate, int oneshot, int quiet,
    -+		     const char *path, merge_fn fn, void *data)
    ++		     const char *path, merge_index_fn fn, void *data)
     +{
    -+	int pos = index_name_pos(istate, path, strlen(path)), ret, err = 0;
    ++	int err, ret;
    ++	int pos = index_name_pos(istate, path, strlen(path));
     +
     +	/*
     +	 * If it already exists in the cache as stage0, it's
     +	 * already merged and there is nothing to do.
     +	 */
    -+	if (pos < 0) {
    -+		ret = merge_entry(istate, -pos - 1, path, &err, fn, data);
    -+		if (ret == -1)
    -+			return -1;
    -+		else if (err) {
    -+			if (!quiet && !oneshot)
    -+				error(_("merge program failed"));
    -+			return 1;
    -+		}
    ++	if (pos >= 0)
    ++		return 0;
    ++
    ++	ret = merge_entry(istate, -pos - 1, path, &err, fn, data);
    ++	if (ret < 0)
    ++		return ret;
    ++	if (err) {
    ++		if (!quiet && !oneshot)
    ++			die(_("merge program failed"));
    ++		return 1;
     +	}
     +	return 0;
     +}
     +
     +int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    -+		    merge_fn fn, void *data)
    ++		    merge_index_fn fn, void *data)
     +{
    -+	int err = 0, ret;
    ++	int err, ret;
     +	unsigned int i;
     +
    -+	/* TODO: audit for interaction with sparse-index. */
    -+	ensure_full_index(istate);
     +	for (i = 0; i < istate->cache_nr; i++) {
     +		const struct cache_entry *ce = istate->cache[i];
     +		if (!ce_stage(ce))
     +			continue;
     +
     +		ret = merge_entry(istate, i, ce->name, &err, fn, data);
    -+		if (ret > 0)
    ++		if (ret < 0)
    ++			return ret;
    ++		else if (ret > 0)
     +			i += ret - 1;
    -+		else if (ret == -1)
    -+			return -1;
     +
     +		if (err && !oneshot) {
     +			if (!quiet)
    -+				error(_("merge program failed"));
    ++				die(_("merge program failed"));
     +			return 1;
     +		}
     +	}
     +
     +	if (err && !quiet)
    -+		error(_("merge program failed"));
    ++		die(_("merge program failed"));
     +	return err;
     +}
     
    @@ merge-strategies.h (new)
     +#ifndef MERGE_STRATEGIES_H
     +#define MERGE_STRATEGIES_H
     +
    -+#include "object.h"
    -+
    -+typedef int (*merge_fn)(struct index_state *istate,
    -+			const struct object_id *orig_blob,
    -+			const struct object_id *our_blob,
    -+			const struct object_id *their_blob, const char *path,
    -+			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
    -+			void *data);
    ++struct object_id;
    ++struct index_state;
    ++typedef int (*merge_index_fn)(struct index_state *istate,
    ++			      const struct object_id *orig_blob,
    ++			      const struct object_id *our_blob,
    ++			      const struct object_id *their_blob,
    ++			      const char *path, unsigned int orig_mode,
    ++			      unsigned int our_mode, unsigned int their_mode,
    ++			      void *data);
     +
     +int merge_index_path(struct index_state *istate, int oneshot, int quiet,
    -+		     const char *path, merge_fn fn, void *data);
    ++		     const char *path, merge_index_fn fn, void *data);
     +int merge_all_index(struct index_state *istate, int oneshot, int quiet,
    -+		    merge_fn fn, void *data);
    ++		    merge_index_fn fn, void *data);
     +
     +#endif /* MERGE_STRATEGIES_H */
    -
    - ## t/t7607-merge-state.sh ##
    -@@ t/t7607-merge-state.sh: test_expect_success 'Ensure we restore original state if no merge strategy handl
    - 	# just hit conflicts, it completely fails and says that it cannot
    - 	# handle this type of merge.
    - 	test_expect_code 2 git merge branch2 branch3 >output 2>&1 &&
    --	grep "fatal: merge program failed" output &&
    -+	grep "error: merge program failed" output &&
    - 	grep "Should not be doing an octopus" output &&
    - 
    - 	# Make sure we did not leave stray changes around when no appropriate
 4:  4b0420836c1 <  -:  ----------- merge-index: drop the index
 5:  19a4fc52c57 <  -:  ----------- merge-index: add a new way to invoke `git-merge-one-file'
 6:  376130c1334 <  -:  ----------- update-index: move add_cacheinfo() to read-cache.c
 7:  e440127edf2 <  -:  ----------- merge-one-file: rewrite in C
 8:  661c358836e <  -:  ----------- merge-resolve: rewrite in C
 9:  388128cd351 <  -:  ----------- merge-recursive: move better_branch_name() to merge.c
10:  1515e154bf5 <  -:  ----------- merge-octopus: rewrite in C
11:  701c47371a7 <  -:  ----------- merge: use the "resolve" strategy without forking
12:  17597d0cc57 <  -:  ----------- merge: use the "octopus" strategy without forking
13:  cecfa666ecb <  -:  ----------- sequencer: use the "resolve" strategy without forking
14:  a23c0491a1f <  -:  ----------- sequencer: use the "octopus" strategy without forking
 -:  ----------- > 11:  adb712ca7a5 merge-index: use "struct strvec" and helper to prepare args
 -:  ----------- > 12:  f0368560140 merge-index: make the argument parsing sensible & simpler
-- 
2.38.0.1511.gcdcff1f1dc2

