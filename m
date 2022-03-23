Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51887C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbiCWOUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244685AbiCWOUS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:20:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146CE7520B
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m30so2376832wrb.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04OwFl2+Kk4DBm28az6mMz5wpTiPfvfkd46gonJVzj4=;
        b=L/GHsZD8DFzxzsttFXvGwAJtZDznC74y65nZItaw9Qyna3vVYUvm0m8Pmt+y2BfcxH
         TOz4NeULXLWNPYjTyGyt+OweiSoXWZY2rrMQv+HganDrsmGV4HO22zJNo362aj1rtCtX
         VTg1p4h0WRtJ4nrtnA9AtcPNUf7tMWEecWNluTbHlP+q7rGdyVxOa/iIFf4CO+cgf/DQ
         4+IbrNcGDgG/v9a/GXcnT68GXJIMDw9Nhdd07cz5UnKHwx7Tc22121UXXuNiayyUo09g
         kAZrqhSq/u1fW5NRLkn5+KZMyz5hrDjyIbU4KWTOGhB+751vz1KmVyAltcrgIPrhIk6e
         6+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04OwFl2+Kk4DBm28az6mMz5wpTiPfvfkd46gonJVzj4=;
        b=GkZbaDma98Ihtvq7fQt+rNxAzHb1sJylnCZCJ+1QuI+v6YFK5RRPZPLoyLmLNEM1qA
         JFijSPQLfvhreyq4fd2ZTbVYS6j32hhuFuzB2rfAFpoehuSn8kFANh9+CEDQih6iwbCK
         bGbmRKpBRWxpHgmcPDlgrj3Mfz85qHqUyKwrN8SPHiYBHIJrkKu3z/LL3fjIOe/UYNdD
         /22+i7aTDYVYdsrOFnzNZAhkXL/rQ0g5iDa4tycH5hDTsBfECCjdk7hZBQzwwlmWR9bI
         vNl+fodkrzNXYTXnXS08DdsdMikSQqWTUpvKnvpGVSiISuJc6oP6vAdjHIUzc9QNCc3Z
         8jPg==
X-Gm-Message-State: AOAM532NzxaXu9MuTid1aJ5dYvcMhgjF5aHDd8olVeOa1f8YEq8RHT7h
        UsrarQUjr9Yul5w/Qgr8/R8rrk4QstmPpA==
X-Google-Smtp-Source: ABdhPJwlCbIwcDoFaudDI8y9ucMhraHH5+wJPoxqNIIV+CwA0jaZhfLFComuwF78OuIQ0gYRBZ8LNw==
X-Received: by 2002:a5d:6149:0:b0:204:4a17:bf2 with SMTP id y9-20020a5d6149000000b002044a170bf2mr3349wrt.379.1648045123731;
        Wed, 23 Mar 2022 07:18:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm30592wmq.46.2022.03.23.07.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:18:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 0/7] bottom-up ns/batched-fsync & "plugging" in object-file.c
Date:   Wed, 23 Mar 2022 15:18:24 +0100
Message-Id: <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
References: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quite a bit less WIP-y but still RFC version of patcehs to
integrate/squash into some form in Neeraj's fsync() series at
https://lore.kernel.org/git/pull.1134.v2.git.1647760560.gitgitgadget@gmail.com/

As noted in the v1 this starts (in 2/7) by removing the tmp-objdir
part of the "bulk checkin" as a POC. Clearly Neeraj wants to keep it,
so we should have it eventually. But this series argues that in both
patch organization and configurability (see the new 7/7!) that the "do
quarantine" should be split up and optional to "do bulk fsync".

The new documentation in 7/7 currently documents a vaporware setting,
but it's what we'd get if this were rebased early into Neeraj's
series, and we made the tmp-objdir part contingent on a configuration
setting.

Unlike v1 (I overzealously ripped out some unrelated bulk-checkin.c
code then) this doesn't fail any tests.

But most importantly the whole fsync() schema here is *much better* in
terms of semantics. We still do away with the "cookie" placeholder to
force an fsync, but now as can be seen in the 4/7 and 5/7 we'll
"fsync()" by using the updated index at the end as our cookie.

I.e. there's no need to introduce a "bulk_fsync" cookie file to force
an fsync() if we can instead alter the relevant calling code to be
aware of the new "fsync() transaction". It can then do the "flush" by
doing the fsync() on the file it wanted to update anyway (now an
index, in the future a ref). So this implements the "METHOD THREE"
noted in [1].



1. https://lore.kernel.org/git/220323.86sfr9ndpr.gmgdl@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (7):
  unpack-objects: add skeleton HASH_N_OBJECTS{,_{FIRST,LAST}} flags
  object-file: pass down unpack-objects.c flags for "bulk" checkin
  update-index: pass down skeleton "oflags" argument
  update-index: have the index fsync() flush the loose objects
  add: use WLI_NEED_LOOSE_FSYNC for new "only the index" bulk fsync()
  fsync docs: update for new syncing semantics
  fsync docs: add new fsyncMethod.batch.quarantine, elaborate on old

 Documentation/config/core.txt | 101 +++++++++++++++++++++++++++++-----
 builtin/add.c                 |   6 +-
 builtin/unpack-objects.c      |  62 +++++++++++----------
 builtin/update-index.c        |  39 ++++++-------
 bulk-checkin.c                |  74 -------------------------
 bulk-checkin.h                |   3 -
 cache.h                       |  10 ++--
 object-file.c                 |  39 +++++++++----
 read-cache.c                  |  37 ++++++++++++-
 9 files changed, 214 insertions(+), 157 deletions(-)

Range-diff against v1:
1:  e03c119c784 < -:  ----------- write-or-die.c: remove unused fsync_component() function
2:  00dbffc2331 = 1:  98921aa2052 unpack-objects: add skeleton HASH_N_OBJECTS{,_{FIRST,LAST}} flags
3:  beda9f99529 ! 2:  c6f776fc2bc object-file: pass down unpack-objects.c flags for "bulk" checkin
    @@ Commit message
         the previous case of fsync_component_or_die(...)" could just be added
         to the existing "fsync_object_files > 0" branch.
     
    -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Note: This commit reverts much of "core.fsyncmethod: batched disk
    +    flushes for loose-objects". We'll set up new structures to bring what
    +    it was doing back in a different way. I.e. to do the tmp-objdir
    +    plug-in in object-file.c
     
    - ## builtin/add.c ##
    -@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
    - 		string_list_clear(&only_match_skip_worktree, 0);
    - 	}
    - 
    --	plug_bulk_checkin();
    --
    - 	if (add_renormalize)
    - 		exit_status |= renormalize_tracked_files(&pathspec, flags);
    - 	else
    -@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
    - 
    - 	if (chmod_arg && pathspec.nr)
    - 		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
    --	unplug_bulk_checkin();
    - 
    - finish:
    - 	if (write_locked_index(&the_index, &lock_file,
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/unpack-objects.c ##
     @@ builtin/unpack-objects.c: static void unpack_all(void)
    @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
     
      ## bulk-checkin.c ##
     @@
    +  */
    + #include "cache.h"
    + #include "bulk-checkin.h"
    +-#include "lockfile.h"
    + #include "repository.h"
    + #include "csum-file.h"
      #include "pack.h"
      #include "strbuf.h"
    - #include "string-list.h"
    +-#include "string-list.h"
     -#include "tmp-objdir.h"
      #include "packfile.h"
      #include "object-store.h"
    @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
      		       int fd, size_t size, enum object_type type,
      		       const char *path, unsigned flags)
     @@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
    - 		finish_bulk_checkin(&bulk_checkin_state);
    - 	return status;
    - }
    --
    --void plug_bulk_checkin(void)
    --{
    --	assert(!bulk_checkin_plugged);
    + void plug_bulk_checkin(void)
    + {
    + 	assert(!bulk_checkin_plugged);
     -
     -	/*
     -	 * A temporary object directory is used to hold the files
    @@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
     -		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
     -	}
     -
    --	bulk_checkin_plugged = 1;
    --}
    --
    --void unplug_bulk_checkin(void)
    --{
    --	assert(bulk_checkin_plugged);
    --	bulk_checkin_plugged = 0;
    --	if (bulk_checkin_state.f)
    --		finish_bulk_checkin(&bulk_checkin_state);
    + 	bulk_checkin_plugged = 1;
    + }
    + 
    +@@ bulk-checkin.c: void unplug_bulk_checkin(void)
    + 	bulk_checkin_plugged = 0;
    + 	if (bulk_checkin_state.f)
    + 		finish_bulk_checkin(&bulk_checkin_state);
     -
     -	do_batch_fsync();
    --}
    + }
     
      ## bulk-checkin.h ##
     @@
    @@ bulk-checkin.h
      int index_bulk_checkin(struct object_id *oid,
      		       int fd, size_t size, enum object_type type,
      		       const char *path, unsigned flags);
    - 
    --void plug_bulk_checkin(void);
    --void unplug_bulk_checkin(void);
    --
    - #endif
     
      ## cache.h ##
    -@@ cache.h: void write_or_die(int fd, const void *buf, size_t count);
    - void fsync_or_die(int fd, const char *);
    +@@ cache.h: void fsync_or_die(int fd, const char *);
    + int fsync_component(enum fsync_component component, int fd);
      void fsync_component_or_die(enum fsync_component component, int fd, const char *msg);
      
     -static inline int batch_fsync_enabled(enum fsync_component component)
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
      
      	if (mtime) {
      		struct utimbuf utb;
    -
    - ## t/t1050-large.sh ##
    -@@ t/t1050-large.sh: test_description='adding and checking out large blobs'
    - 
    - . ./test-lib.sh
    - 
    -+skip_all='TODO: migrate the builtin/add.c code'
    -+test_done
    -+
    - test_expect_success setup '
    - 	# clone does not allow us to pass core.bigfilethreshold to
    - 	# new repos, so set core.bigfilethreshold globally
5:  a1474968991 ! 3:  4df8012100a update-index: pass down an "oflags" argument
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    update-index: pass down an "oflags" argument
    +    update-index: pass down skeleton "oflags" argument
     
    -    We do nothing with this yet, but will soon.
    +    As with a preceding change to "unpack-objects" add an "oflags" going
    +    from cmd_update_index() all the way down to the code in
    +    object-file.c. Note also how index_mem() will now call
    +    write_object_file_flags().
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/update-index.c: static int do_reupdate(int ac, const char **av,
      		free(path);
      		discard_cache_entry(old);
      		if (save_nr != active_nr)
    -@@ builtin/update-index.c: static enum parse_opt_result reupdate_callback(
    - 
    - static void line_from_stdin(struct strbuf *buf, struct strbuf *unquoted,
    - 			    const char *prefix, int prefix_length,
    --			    const int nul_term_line, const int set_executable_bit)
    -+			    const int nul_term_line, const int set_executable_bit,
    -+			    const unsigned oflags)
    - {
    - 	char *p;
    - 
    -@@ builtin/update-index.c: static void line_from_stdin(struct strbuf *buf, struct strbuf *unquoted,
    - 		strbuf_swap(buf, unquoted);
    - 	}
    - 	p = prefix_path(prefix, prefix_length, buf->buf);
    --	update_one(p);
    -+	update_one(p, oflags);
    - 	if (set_executable_bit)
    - 		chmod_path(set_executable_bit, p);
    - 	free(p);
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
      
      			setup_work_tree();
    @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
      				chmod_path(set_executable_bit, p);
      			free(p);
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
    - 		setup_work_tree();
    - 		while (getline_fn(&buf, stdin) != EOF)
    - 			line_from_stdin(&buf, &unquoted, prefix, prefix_length,
    --					nul_term_line, set_executable_bit);
    -+					nul_term_line, set_executable_bit, 0);
    - 		strbuf_release(&unquoted);
    - 		strbuf_release(&buf);
    - 	}
    + 				strbuf_swap(&buf, &unquoted);
    + 			}
    + 			p = prefix_path(prefix, prefix_length, buf.buf);
    +-			update_one(p);
    ++			update_one(p, 0);
    + 			if (set_executable_bit)
    + 				chmod_path(set_executable_bit, p);
    + 			free(p);
     
      ## object-file.c ##
     @@ object-file.c: static int index_mem(struct index_state *istate,
7:  481f1d771cb ! 4:  61f4f3d7ef4 update-index: make use of HASH_N_OBJECTS{,_{FIRST,LAST}} flags
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    update-index: make use of HASH_N_OBJECTS{,_{FIRST,LAST}} flags
    +    update-index: have the index fsync() flush the loose objects
     
         As with unpack-objects in a preceding commit have update-index.c make
         use of the HASH_N_OBJECTS{,_{FIRST,LAST}} flags. We now have a "batch"
    @@ Commit message
         Adding the t/* directory from git.git on a Linux ramdisk is a bit
         faster than with the tmp-objdir indirection:
     
    -            git hyperfine -L rev ns/batched-fsync,HEAD -s 'make CFLAGS=-O3' -p 'rm -rf repo && git init repo && cp -R t repo/' 'git ls-files -- t | ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' --warmup 1 -r 10
    -            Benchmark 1: git ls-files -- t | ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'ns/batched-fsync
    -              Time (mean ± σ):     289.8 ms ±   4.0 ms    [User: 186.3 ms, System: 103.2 ms]
    -              Range (min … max):   285.6 ms … 297.0 ms    10 runs
    +            $ git hyperfine -L rev ns/batched-fsync,HEAD -s 'make CFLAGS=-O3 && rm -rf repo && git init repo && cp -R t repo/ && git ls-files -- t >repo/.git/to-add.txt' -p 'rm -rf repo/.git/objects/* repo/.git/index' './git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' --warmup 1 -r 10Benchmark 1: ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'ns/batched-fsync
    +              Time (mean ± σ):     281.1 ms ±   2.6 ms    [User: 186.2 ms, System: 92.3 ms]
    +              Range (min … max):   278.3 ms … 287.0 ms    10 runs
     
    -            Benchmark 2: git ls-files -- t | ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'HEAD
    -              Time (mean ± σ):     273.9 ms ±   7.3 ms    [User: 189.3 ms, System: 84.1 ms]
    -              Range (min … max):   267.8 ms … 291.3 ms    10 runs
    +            Benchmark 2: ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'HEAD
    +              Time (mean ± σ):     265.9 ms ±   2.6 ms    [User: 181.7 ms, System: 82.1 ms]
    +              Range (min … max):   262.0 ms … 270.3 ms    10 runs
     
                 Summary
    -              'git ls-files -- t | ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'HEAD' ran
    -                1.06 ± 0.03 times faster than 'git ls-files -- t | ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'ns/batched-fsync'
    +              './git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'HEAD' ran
    +                1.06 ± 0.01 times faster than './git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'ns/batched-fsync'
     
         And as before running that with "strace --summary-only" slows things
         down a bit (probably mimicking slower I/O a bit). I then get:
     
                 Summary
    -              'git ls-files -- t | strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'HEAD' ran
    -                1.21 ± 0.02 times faster than 'git ls-files -- t | strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin' in 'ns/batched-fsync'
    +              'strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'HEAD' ran
    +                1.19 ± 0.03 times faster than 'strace --summary-only ./git -c core.fsync=loose-object -c core.fsyncMethod=batch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'ns/batched-fsync'
    +
    +    This one has a twist though, instead of fsync()-ing on the last object
    +    we write we'll not do that, and instead defer the fsync() until we
    +    write the index itself. This is outlined in [1] (as "METHOD THREE").
    +
    +    Because of this under FSYNC_METHOD_BATCH we'll do the N
    +    objects (possibly only one, because we're lazy) as HASH_N_OBJECTS, and
    +    we'll even now support doing this via N arguments on the command-line.
    +
    +    Then we won't fsync() any of it, but we will rename it
    +    in-place (which, if we were still using the tmp-objdir, would leave it
    +    "staged" in the tmp-objdir).
    +
    +    We'll then have the fsync() for the index update "flush" that out, and
    +    thus avoid two fsync() calls when one will do.
    +
    +    Running this with the "git hyperfine" command mentioned in a preceding
    +    commit with "strace --summary-only" shows that we do 1 fsync() now
    +    instead of 2, and have one more sync_file_range(), as expected.
     
         We also go from ~51k syscalls to ~39k, with ~2x the number of link()
    -    and unlink() in ns/batched-fsync.
    +    and unlink() in ns/batched-fsync, and of course one fsync() instead of
    +    two()>
     
    -    In the process of doing this conversion we lost the "bulk" mode for
    -    files added on the command-line. I don't think it's useful to optimize
    -    that, but we could if anyone cared.
    +    The flow of this code isn't quite set up for re-plugging the
    +    tmp-objdir back in. In particular we no longer pass
    +    HASH_N_OBJECTS_FIRST (but doing so would be trivial)< and there's no
    +    HASH_N_OBJECTS_LAST.
     
    -    We've also converted this to a string_list, we could walk with
    -    getline_fn() and get one line "ahead" to see what we have left, but I
    -    found that state machine a bit painful, and at least in my testing
    -    buffering this doesn't harm things. But we could also change this to
    -    stream again, at the cost of some getline_fn() twiddling.
    +    So this and other callers would need some light transaction-y API, or
    +    to otherwise pass down a "yes, I'd like to flush it" down to
    +    finalize_hashfile(), but doing so will be trivial.
    +
    +    And since we've started structuring it this way it'll become easy to
    +    do any arbitrary number of things down the line that would "bulk
    +    fsync" before the final fsync(). Now we write some objects and fsync()
    +    on the index, but between those two could do any number of other
    +    things where we'd defer the fsync().
    +
    +    This sort of thing might be especially interesting for "git repack"
    +    when it writes e.g. a *.bitmap, *.rev, *.pack and *.idx. In that case
    +    we could skip the fsync() on all of those, and only do it on the *.idx
    +    before we renamed it in-place. I *think* nothing cares about a *.pack
    +    without an *.idx, but even then we could fsync *.idx, rename *.pack,
    +    rename *.idx and still safely do only one fsync(). See "git show
    +    --first-parent" on 62874602032 (Merge branch
    +    'tb/pack-finalize-ordering' into maint, 2021-10-12) for a good
    +    overview of the code involved in that.
    +
    +    1. https://lore.kernel.org/git/220323.86sfr9ndpr.gmgdl@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/update-index.c ##
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
    + 
    + 			setup_work_tree();
    + 			p = prefix_path(prefix, prefix_length, path);
    +-			update_one(p, 0);
    ++			update_one(p, HASH_N_OBJECTS);
    + 			if (set_executable_bit)
    + 				chmod_path(set_executable_bit, p);
    + 			free(p);
    +@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
    + 				strbuf_swap(&buf, &unquoted);
    + 			}
    + 			p = prefix_path(prefix, prefix_length, buf.buf);
    +-			update_one(p, 0);
    ++			update_one(p, HASH_N_OBJECTS);
    + 			if (set_executable_bit)
    + 				chmod_path(set_executable_bit, p);
    + 			free(p);
    +@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
    + 				exit(128);
    + 			unable_to_lock_die(get_index_file(), lock_error);
    + 		}
    +-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
    ++		if (write_locked_index(&the_index, &lock_file,
    ++				       COMMIT_LOCK | WLI_NEED_LOOSE_FSYNC))
    + 			die("Unable to write new index file");
      	}
      
    - 	if (read_from_stdin) {
    -+		struct string_list list = STRING_LIST_INIT_NODUP;
    - 		struct strbuf line = STRBUF_INIT;
    - 		struct strbuf unquoted = STRBUF_INIT;
    -+		size_t i, nr;
    -+		unsigned oflags;
    +
    + ## cache.h ##
    +@@ cache.h: void ensure_full_index(struct index_state *istate);
    + /* For use with `write_locked_index()`. */
    + #define COMMIT_LOCK		(1 << 0)
    + #define SKIP_IF_UNCHANGED	(1 << 1)
    ++#define WLI_NEED_LOOSE_FSYNC	(1 << 2)
      
    - 		setup_work_tree();
    --		while (getline_fn(&line, stdin) != EOF)
    --			line_from_stdin(&line, &unquoted, prefix, prefix_length,
    --					nul_term_line, set_executable_bit, 0);
    -+		while (getline_fn(&line, stdin) != EOF) {
    -+			size_t len = line.len;
    -+			char *str = strbuf_detach(&line, NULL);
    -+
    -+			string_list_append_nodup(&list, str)->util = (void *)len;
    -+		}
    + /*
    +  * Write the index while holding an already-taken lock. Close the lock,
    +
    + ## read-cache.c ##
    +@@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
    + 	int ieot_entries = 1;
    + 	struct index_entry_offset_table *ieot = NULL;
    + 	int nr, nr_threads;
    ++	unsigned int wflags = FSYNC_COMPONENT_INDEX;
     +
    -+		nr = list.nr;
    -+		oflags = nr > 1 ? HASH_N_OBJECTS : 0;
    -+		for (i = 0; i < nr; i++) {
    -+			size_t nth = i + 1;
    -+			unsigned f = i == 0 ? HASH_N_OBJECTS_FIRST :
    -+				  nr == nth ? HASH_N_OBJECTS_LAST : 0;
    -+			struct strbuf buf = STRBUF_INIT;
    -+			struct string_list_item *item = list.items + i;
    -+			const size_t len = (size_t)item->util;
     +
    -+			strbuf_attach(&buf, item->string, len, len);
    -+			line_from_stdin(&buf, &unquoted, prefix, prefix_length,
    -+					nul_term_line, set_executable_bit,
    -+					oflags | f);
    -+			strbuf_release(&buf);
    -+		}
    - 		strbuf_release(&unquoted);
    --		strbuf_release(&line);
    -+		string_list_clear(&list, 0);
    - 	}
    ++	/*
    ++	 * TODO: This is abuse of the API recently modified
    ++	 * finalize_hashfile() which reveals a shortcoming of its
    ++	 * "fsync" design.
    ++	 * 
    ++	 * I.e. It expects a "enum fsync_component component" label,
    ++	 * but here we're passing it an OR of the two, knowing that
    ++	 * it'll call fsync_component_or_die() which (in
    ++	 * write-or-die.c) will do "(fsync_components & wflags)" (to
    ++	 * our "wflags" here).
    ++	 *
    ++	 * But the API really should be changed to explicitly take
    ++	 * such flags, because in this case we'd like to fsync() the
    ++	 * index if we're in the bulk mode, *even if* our
    ++	 * "core.fsync=index" isn't configured.
    ++	 *
    ++	 * That's because at this point we've been queuing up object
    ++	 * writes that we didn't fsync(), and are going to use this
    ++	 * fsync() to "flush" the whole thing. Doing it this way
    ++	 * avoids redundantly calling fsync() twice when once will do.
    ++	 */
    ++	if (fsync_method == FSYNC_METHOD_BATCH && 
    ++	    flags & WLI_NEED_LOOSE_FSYNC)
    ++		wflags |= FSYNC_COMPONENT_LOOSE_OBJECT;
    + 
    + 	f = hashfd(tempfile->fd, tempfile->filename.buf);
    + 
    +@@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
    + 	if (!alternate_index_output && (flags & COMMIT_LOCK))
    + 		csum_fsync_flag = CSUM_FSYNC;
    + 
    +-	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_INDEX,
    ++	finalize_hashfile(f, istate->oid.hash, wflags,
    + 			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
      
    - 	if (split_index > 0) {
    + 	if (close_tempfile_gently(tempfile)) {
-:  ----------- > 5:  2bf14fd4946 add: use WLI_NEED_LOOSE_FSYNC for new "only the index" bulk fsync()
6:  4fad333e9a1 ! 6:  c20301d7967 update-index: rename "buf" to "line"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    update-index: rename "buf" to "line"
    -
    -    This variable renaming makes a subsequent more meaningful change
    -    smaller.
    +    fsync docs: update for new syncing semantics
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/update-index.c ##
    -@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
    - 	}
    - 
    - 	if (read_from_stdin) {
    --		struct strbuf buf = STRBUF_INIT;
    -+		struct strbuf line = STRBUF_INIT;
    - 		struct strbuf unquoted = STRBUF_INIT;
    - 
    - 		setup_work_tree();
    --		while (getline_fn(&buf, stdin) != EOF)
    --			line_from_stdin(&buf, &unquoted, prefix, prefix_length,
    -+		while (getline_fn(&line, stdin) != EOF)
    -+			line_from_stdin(&line, &unquoted, prefix, prefix_length,
    - 					nul_term_line, set_executable_bit, 0);
    - 		strbuf_release(&unquoted);
    --		strbuf_release(&buf);
    -+		strbuf_release(&line);
    - 	}
    + ## Documentation/config/core.txt ##
    +@@ Documentation/config/core.txt: core.fsyncMethod::
    +   filesystem and storage hardware, data added to the repository may not be
    +   durable in the event of a system crash. This is the default mode on macOS.
    + * `batch` enables a mode that uses writeout-only flushes to stage multiple
    +-  updates in the disk writeback cache and then does a single full fsync of
    +-  a dummy file to trigger the disk cache flush at the end of the operation.
    +-  Currently `batch` mode only applies to loose-object files. Other repository
    +-  data is made durable as if `fsync` was specified. This mode is expected to
    +-  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
    +-  and on Windows for repos stored on NTFS or ReFS filesystems.
    ++  updates in the disk writeback cache and, before doing a full fsync() of
    ++  on the "last" file that to trigger the disk cache flush at the end of the
    ++  operation.
    +++
    ++Other repository data is made durable as if `fsync` was
    ++specified. This mode is expected to be as safe as `fsync` on macOS for
    ++repos stored on HFS+ or APFS filesystems and on Windows for repos
    ++stored on NTFS or ReFS filesystems.
    +++
    ++The `batch` is currently only applies to loose-object files and will
    ++kick in when using the linkgit:git-unpack-objects[1] and
    ++linkgit:update-index[1] commands. Note that the "last" file to be
    ++synced may be the last object, as in the case of
    ++linkgit:git-unpack-objects[1], or relevant "index" (or in the future,
    ++"ref") update, as in the case of linkgit:git-update-index[1]. I.e. the
    ++batch syncing of the loose objects may be deferred until a subsequent
    ++fsync() to a file that makes them "active".
      
    - 	if (split_index > 0) {
    + core.fsyncObjectFiles::
    + 	This boolean will enable 'fsync()' when writing object files.
4:  2c5395a3716 ! 7:  a5951366c6e update-index: use a utility function for stdin consumption
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    update-index: use a utility function for stdin consumption
    +    fsync docs: add new fsyncMethod.batch.quarantine, elaborate on old
    +
    +    Add a new fsyncMethod.batch.quarantine setting which defaults to
    +    "false". Preceding (RFC, and not meant to flip-flop like that
    +    eventually) commits ripped out the "tmp-objdir" part of the
    +    core.fsyncMethod=batch.
    +
    +    This documentation proposes to keep that as the default for the
    +    reasons discussed in it, while allowing users to set
    +    "fsyncMethod.batch.quarantine=true".
    +
    +    Furthermore update the discussion of "core.fsyncObjectFiles" with
    +    information about what it *really* does, why you probably shouldn't
    +    use it, and how to safely emulate most of what it gave users in the
    +    past in terms of performance benefit.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/update-index.c ##
    -@@ builtin/update-index.c: static enum parse_opt_result reupdate_callback(
    - 	return 0;
    - }
    + ## Documentation/config/core.txt ##
    +@@ Documentation/config/core.txt: stored on NTFS or ReFS filesystems.
    + +
    + The `batch` is currently only applies to loose-object files and will
    + kick in when using the linkgit:git-unpack-objects[1] and
    +-linkgit:update-index[1] commands. Note that the "last" file to be
    ++linkgit:git-update-index[1] commands. Note that the "last" file to be
    + synced may be the last object, as in the case of
    + linkgit:git-unpack-objects[1], or relevant "index" (or in the future,
    + "ref") update, as in the case of linkgit:git-update-index[1]. I.e. the
    + batch syncing of the loose objects may be deferred until a subsequent
    + fsync() to a file that makes them "active".
      
    -+static void line_from_stdin(struct strbuf *buf, struct strbuf *unquoted,
    -+			    const char *prefix, int prefix_length,
    -+			    const int nul_term_line, const int set_executable_bit)
    -+{
    -+	char *p;
    -+
    -+	if (!nul_term_line && buf->buf[0] == '"') {
    -+		strbuf_reset(unquoted);
    -+		if (unquote_c_style(unquoted, buf->buf, NULL))
    -+			die("line is badly quoted");
    -+		strbuf_swap(buf, unquoted);
    -+	}
    -+	p = prefix_path(prefix, prefix_length, buf->buf);
    -+	update_one(p);
    -+	if (set_executable_bit)
    -+		chmod_path(set_executable_bit, p);
    -+	free(p);
    -+}
    ++fsyncMethod.batch.quarantine::
    ++	A boolean which if set to `true` will cause "batched" writes
    ++	to objects to be "quarantined" if
    ++	`core.fsyncMethod=batch`. This is `false` by default.
    +++
    ++The primary object of these fsync() settings is to protect against
    ++repository corruption of things which are reachable, i.e. "reachable",
    ++via references, the index etc. Not merely objects that were present in
    ++the object store.
    +++
    ++Historically setting `core.fsyncObjectFiles=false` assumed that on a
    ++filesystem with where an fsync() would flush all preceding outstanding
    ++I/O that we might end up with a corrupt loose object, but that was OK
    ++as long as no reference referred to it. We'd eventually the corrupt
    ++object with linkgit:git-gc[1], and linkgit:git-fsck[1] would only
    ++report it as a minor annoyance
    +++
    ++Setting `fsyncMethod.batch.quarantine=true` takes the view that
    ++something like a corrupt *unreferenced* loose object in the object
    ++store is something we'd like to avoid, at the cost of reduced
    ++performance when using `core.fsyncMethod=batch`.
    +++
    ++Currently this uses the same mechanism described in the "QUARANTINE
    ++ENVIRONMENT" in the linkgit:git-receive-pack[1] documentation, but
    ++that's subject to change. The performance loss is because we need to
    ++"stage" the objects in that quarantine environment, fsync() it, and
    ++once that's done rename() or link() it in-place into the main object
    ++store, possibly with an fsync() of the index or ref at the end
    +++
    ++With `fsyncMethod.batch.quarantine=false` we'll "stage" things in the
    ++main object store, and then do one fsync() at the very end, either on
    ++the last object we write, or file (index or ref) that'll make it
    ++"reachable".
    +++
    ++The bad thing about setting this to `true` is lost performance, as
    ++well as not being able to access the objects as they're written (which
    ++e.g. consumers of linkgit:git-update-index[1]'s `--verbose` mode might
    ++want to do).
    +++
    ++The good thing is that you should be guaranteed not to get e.g. short
    ++or otherwise corrupt loose objects if you pull your power cord, in
    ++practice various git commands deal quite badly with discovering such a
    ++stray corrupt object (including perhaps assuming it's valid based on
    ++its existence, or hard dying on an error rather than replacing
    ++it). Repairing such "unreachable corruption" can require manual
    ++intervention.
     +
    - int cmd_update_index(int argc, const char **argv, const char *prefix)
    - {
    - 	int newfd, entries, has_errors = 0, nul_term_line = 0;
    -@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
    - 		struct strbuf unquoted = STRBUF_INIT;
    + core.fsyncObjectFiles::
    +-	This boolean will enable 'fsync()' when writing object files.
    +-	This setting is deprecated. Use core.fsync instead.
    +-+
    +-This setting affects data added to the Git repository in loose-object
    +-form. When set to true, Git will issue an fsync or similar system call
    +-to flush caches so that loose-objects remain consistent in the face
    +-of a unclean system shutdown.
    ++	This boolean will enable 'fsync()' when writing loose object
    ++	files.
    +++
    ++This setting is the historical fsync configuration setting. It's now
    ++*deprecated*, you should use `core.fsync` instead, perhaps in
    ++combination with `core.fsyncMethod=batch`.
    +++
    ++The `core.fsyncObjectFiles` was initially added based on integrity
    ++assumptions that early (pre-ext-4) versions of Linux's "ext"
    ++filesystems provided.
    +++
    ++I.e. that a write of file A without an `fsync()` followed by a write
    ++of file `B` with `fsync()` would implicitly guarantee that `A' would
    ++be `fsync()`'d by calling `fsync()` on `B`. This asssumption is *not*
    ++backed up by any standard (e.g. POSIX), but worked in practice on some
    ++Linux setups.
    +++
    ++Nowadays you should almost certainly want to use
    ++`core.fsync=loose-object` instead in combination with
    ++`core.fsyncMethod=bulk`, and possibly with
    ++`fsyncMethod.batch.quarantine=true`, see above. On modern OS's (Linux,
    ++OSX, Windows) that gives you most of the performance benefit of
    ++`core.fsyncObjectFiles=false` with all of the safety of the old
    ++`core.fsyncObjectFiles=true`.
      
    - 		setup_work_tree();
    --		while (getline_fn(&buf, stdin) != EOF) {
    --			char *p;
    --			if (!nul_term_line && buf.buf[0] == '"') {
    --				strbuf_reset(&unquoted);
    --				if (unquote_c_style(&unquoted, buf.buf, NULL))
    --					die("line is badly quoted");
    --				strbuf_swap(&buf, &unquoted);
    --			}
    --			p = prefix_path(prefix, prefix_length, buf.buf);
    --			update_one(p);
    --			if (set_executable_bit)
    --				chmod_path(set_executable_bit, p);
    --			free(p);
    --		}
    -+		while (getline_fn(&buf, stdin) != EOF)
    -+			line_from_stdin(&buf, &unquoted, prefix, prefix_length,
    -+					nul_term_line, set_executable_bit);
    - 		strbuf_release(&unquoted);
    - 		strbuf_release(&buf);
    - 	}
    + core.preloadIndex::
    + 	Enable parallel index preload for operations like 'git diff'
-- 
2.35.1.1428.g1c1a0152d61

