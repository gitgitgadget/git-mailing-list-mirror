Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F97C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A572622522
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="g7lzbfOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgAPCkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:40:15 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34307 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgAPCkP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:40:15 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so17845758qkk.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlWKulbzOKAG273Z5wQsoZYgYeZDdtwGtmVVfKvGF/Q=;
        b=g7lzbfOCyvczMFsmlOHjbXBH+jMOE1S06GFzIiRIqM8oCs+TqtV1QdwyA9KLkl+6VW
         EL7AP8WWLLuUbjkp0I+lJM4bPsCDruVKyPfEXwUEi3RhmqAAaHuV8QNWneGEa/httIsJ
         7VmGJHNkSs5BbiiD5BsMHMO54dvB1f4q2J4hvY77jRX2X/DEQxc6yxsb2h65N5jmli7H
         F1Y6KfqkRoJXxcZSKDCKI+9lykXUevWRFTBYG3UxAbtPCBNOf3I+U20TMtos4Hsm4px7
         uHr0MFR9Zyyj8PifzEWgRYOl1zU/chwsge47n5EdcsX5qKFterqVbhygqxsh80eXRM6U
         hz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlWKulbzOKAG273Z5wQsoZYgYeZDdtwGtmVVfKvGF/Q=;
        b=RXxauGzWMZvc5mAQT7+5X9qZVl/6Dz/bwybI4u2x6CZPwha3hHwhI8+5FU1Zf305gR
         mPEs44epBRgWqLzQWvLn3T4IkvXU7vGJ4f5x0vuTC4IFxnYwUFkpt4eUUQsBNBY+V7TB
         QnuBqYYDAhkqg3CPqn7ILMsRUpsgd7+iOxyczwBdoXBzy9nJ3NMZwRS/JIDueg0q5iR6
         nctlV5+QHoHh9yjafdZJU2np4Coi+CpYu/KLrzl7MzOu3XD7RKkUSVWjLKNfNCnmEFrq
         OQmE9w+Al+vSdoXvSz+1zzKEkbEJFV5e+sKSi6wFuCKYyI0mV3U9URxvSYcK2EWA2iA4
         7W8g==
X-Gm-Message-State: APjAAAUC57EcAL7BfFK96x+8+TZDo8EmVhwEe/8O2NDCqR1b62gb1SWq
        YhNis/8IGkobwhdVy0SZtqTDEvwXrM0=
X-Google-Smtp-Source: APXvYqx6xAejvW9s8YShpM3vHsjWVVfWKkWU4l5iJV0109d0O99hPFUaHUhJBh/80uZtDMLdrWCFOQ==
X-Received: by 2002:a37:582:: with SMTP id 124mr26060798qkf.257.1579142413069;
        Wed, 15 Jan 2020 18:40:13 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:40:12 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 00/12] grep: improve threading and fix race conditions
Date:   Wed, 15 Jan 2020 23:39:48 -0300
Message-Id: <cover.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series focus on re-enabling threads at git-grep for the
object store case. They are currently disabled due to being slower than
single-threaded grep in this case. However, by allowing parallel zlib
inflation when reading objects, speedups of up to 3.3x were observed.

The patchset also contains some fixes for race conditions found in the
working tree git-grep and other thread optimizations. With them, the
working tree case reached speedups of up to 1.52x.

Changes since v2:
- Updated commit message of patch 6 and added comment in the code to
  document how we ensure that the unlocked inflation code is thread-safe
  (as suggested by Christian[1]).
- Added patch to adjust the default number of threads in git-grep
  according to the number of available cores.
- Fixed some typos in the commit messages
- Rebased with master (d0654dc)

Note: this patchset is part of my GSoC project, and also of my
bachelor's capstone project (which had the same theme/goal). In case
someone might want to take a look, the project's final essay can be
found here[2] :) Besides extra details, it contains more performance
tests and plots of the resulting speedups.


[1]: https://public-inbox.org/git/CAP8UFD3QHNoePGsc9t0fVxTJpPy+KBCbPfXKGoNOx_2bCf1Hxg@mail.gmail.com/
[2]: https://matheustavares.gitlab.io/assets/tavares-final-essay.pdf
travis build: https://travis-ci.org/matheustavares/git/builds/637708218

Matheus Tavares (12):
  grep: fix race conditions on userdiff calls
  grep: fix race conditions at grep_submodule()
  grep: fix racy calls in grep_objects()
  replace-object: make replace operations thread-safe
  object-store: allow threaded access to object reading
  grep: replace grep_read_mutex by internal obj read lock
  submodule-config: add skip_if_read option to repo_read_gitmodules()
  grep: allow submodule functions to run in parallel
  grep: protect packed_git [re-]initialization
  grep: re-enable threads in non-worktree case
  grep: move driver pre-load out of critical section
  grep: use no. of cores as the default no. of threads

 .tsan-suppressions         |  6 +++
 Documentation/git-grep.txt | 15 +++++-
 builtin/grep.c             | 93 +++++++++++++++++++-------------------
 grep.c                     | 32 +++++++------
 grep.h                     | 13 ------
 object-store.h             | 37 +++++++++++++++
 object.c                   |  2 +
 packfile.c                 | 34 ++++++++++++++
 replace-object.c           | 11 ++++-
 replace-object.h           |  7 ++-
 sha1-file.c                | 57 +++++++++++++++++++++--
 submodule-config.c         | 18 +++-----
 submodule-config.h         |  2 +-
 unpack-trees.c             |  4 +-
 14 files changed, 233 insertions(+), 98 deletions(-)

Range-diff against v2:
 1:  0f31cb0c12 !  1:  e2f3d377f5 grep: fix race conditions on userdiff calls
    @@ Commit message
         git-grep uses an internal grep_read_mutex to protect object reading
         operations. Similarly, there's a grep_attr_mutex to protect calls to the
         gitattributes machinery. However, two of the three functions protected
    -    by the last mutex may also perform object reading, as seen bellow:
    +    by the last mutex may also perform object reading, as seen below:
     
         - userdiff_get_textconv() > notes_cache_init() >
           notes_cache_match_validity() > lookup_commit_reference_gently() >
    @@ Commit message
         that, let's make sure to acquire the lock before both of these calls.
     
         Note: this patch might slow down the threaded grep in worktree, for the
    -    sake of thread-safeness. However, in the following patches we should
    +    sake of thread-safeness. However, in the following patches, we should
         regain performance by replacing grep_read_mutex for an internal object
         reading lock and allowing parallel inflation during object reading.
     
 2:  be32683f1d =  2:  6f0899701b grep: fix race conditions at grep_submodule()
 3:  34aeb218bf !  3:  5295c892ee grep: fix racy calls in grep_objects()
    @@ Commit message
         condition with object reading operations (such as the ones internally
         performed by fill_textconv(), called at fill_textconv_grep()). The same
         problem happens with the call to gitmodules_config_oid() which also has
    -    parse_object() in its call stack. Fix that protecting both call with the
    -    said grep_read_mutex.
    +    parse_object() in its call stack. Fix that protecting both calls with
    +    the said grep_read_mutex.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
 4:  5deee3cf11 !  4:  d7f739bc57 replace-object: make replace operations thread-safe
    @@ object-store.h: struct raw_object_store {
     
      ## object.c ##
     @@ object.c: struct raw_object_store *raw_object_store_new(void)
    - 
      	memset(o, 0, sizeof(*o));
      	INIT_LIST_HEAD(&o->packed_git_mru);
    + 	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
     +	pthread_mutex_init(&o->replace_mutex, NULL);
      	return o;
      }
 5:  4c5652ab34 !  5:  b72e90f229 object-store: allow threaded access to object reading
    @@ Commit message
         object-store: allow threaded access to object reading
     
         Allow object reading to be performed by multiple threads protecting it
    -    with an internal lock. The lock usage can be toggled with
    -    enable_obj_read_lock() and disable_obj_read_lock(). Currently, the
    +    with an internal lock, the obj_read_mutex. The lock usage can be toggled
    +    with enable_obj_read_lock() and disable_obj_read_lock(). Currently, the
         functions which can be safely called in parallel are:
         read_object_file_extended(), repo_read_object_file(),
         read_object_file(), read_object_with_reference(), read_object(),
    -    oid_object_info() and oid_object_info_extended(). It's also possible to
    -    use obj_read_lock() and obj_read_unlock() to protect other sections that
    -    cannot execute in parallel with object reading.
    +    oid_object_info() and oid_object_info_extended(). It's also possible
    +    to use obj_read_lock() and obj_read_unlock() to protect other sections
    +    that cannot execute in parallel with object reading.
     
         Probably there are many spots in the functions listed above that could
         be executed unlocked (and thus, in parallel). But, for now, we are most
         interested in allowing parallel access to zlib inflation. This is one of
    -    the sections where object reading spends most of the time and it's
    -    already thread-safe. So, to take advantage of that, the respective lock
    -    is released when calling git_inflate() and re-acquired right after, for
    -    every calling spot in oid_object_info_extended()'s call chain. We may
    -    refine the lock to also exploit other possible parallel spots in the
    -    future, but threaded zlib inflation should already give great speedups
    -    for now.
    +    the sections where object reading spends most of the time in (e.g. up to
    +    one-third of git-grep's execution time in the chromium repo corresponds
    +    to inflation) and it's already thread-safe. So, to take advantage of
    +    that, the obj_read_mutex is released when calling git_inflate() and
    +    re-acquired right after, for every calling spot in
    +    oid_object_info_extended()'s call chain. We may refine this lock to also
    +    exploit other possible parallel spots in the future, but for now,
    +    threaded zlib inflation should already give great speedups for threaded
    +    object reading callers.
     
         Note that add_delta_base_cache() was also modified to skip adding
         already present entries to the cache. This wasn't possible before, but
    -    now it is since phase I and phase III of unpack_entry() may execute
    -    concurrently.
    +    it would be now, with the parallel inflation. Take for example the
    +    following situation, where two threads - A and B - are executing the
    +    code at unpack_entry():
     
    -    Another important thing to notice is that the object reading lock only
    -    works in conjunction with the 'struct raw_object_store's replace_mutex.
    -    Otherwise, there would still be racy spots in object reading
    -    functions.
    +    1. Thread A is performing the decompression of a base O (which is not
    +       yet in the cache) at PHASE II. Thread B is simultaneously trying to
    +       unpack O, but just starting at PHASE I.
    +    2. Since O is not yet in the cache, B will go to PHASE II to also
    +       perform the decompression.
    +    3. When they finish decompressing, one of them will get the object
    +       reading mutex and go to PHASE III while the other waits for the
    +       mutex. Let’s say A got the mutex first.
    +    4. Thread A will add O to the cache, go throughout the rest of PHASE III
    +       and return.
    +    5. Thread B gets the mutex, also add O to the cache (if the check wasn't
    +       there) and returns.
    +
    +    Finally, it is also important to highlight that the object reading lock
    +    can only ensure thread-safety in the mentioned functions thanks to two
    +    complementary mechanisms: the use of 'struct raw_object_store's
    +    replace_mutex, which guards sections in the object reading machinery
    +    that would otherwise be thread-unsafe; and the 'struct pack_window's
    +    inuse_cnt, which protects window reading operations (such as the one
    +    performed during the inflation of a packed object), allowing them to
    +    execute without the acquisition of the obj_read_mutex.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    @@ packfile.c: unsigned long get_size_from_delta(struct packed_git *p,
      	do {
      		in = use_pack(p, w_curs, curpos, &stream.avail_in);
      		stream.next_in = in;
    ++		/*
    ++		 * Note: the window section returned by use_pack() must be
    ++		 * available throughout git_inflate()'s unlocked execution. To
    ++		 * ensure no other thread will modify the window in the
    ++		 * meantime, we rely on the packed_window.inuse_cnt. This
    ++		 * counter is incremented before window reading and checked
    ++		 * before window disposal.
    ++		 *
    ++		 * Other worrying sections could be the call to close_pack_fd(),
    ++		 * which can close packs even with in-use windows, and to
    ++		 * reprepare_packed_git(). Regarding the former, mmap doc says:
    ++		 * "closing the file descriptor does not unmap the region". And
    ++		 * for the latter, it won't re-open already available packs.
    ++		 */
     +		obj_read_unlock();
      		st = git_inflate(&stream, Z_FINISH);
     +		obj_read_lock();
    @@ packfile.c: static void add_delta_base_cache(struct packed_git *p, off_t base_of
      	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
      	struct list_head *lru, *tmp;
      
    -+	if (get_delta_base_cache_entry(p, base_offset))
    ++	/*
    ++	 * Check required to avoid redundant entries when more than one thread
    ++	 * is unpacking the same object, in unpack_entry() (since its phases I
    ++	 * and III might run concurrently across multiple threads).
    ++	 */
    ++	if (in_delta_base_cache(p, base_offset))
     +		return;
     +
      	delta_base_cached += base_size;
    @@ packfile.c: static void *unpack_compressed_entry(struct packed_git *p,
      	do {
      		in = use_pack(p, w_curs, curpos, &stream.avail_in);
      		stream.next_in = in;
    ++		/*
    ++		 * Note: we must ensure the window section returned by
    ++		 * use_pack() will be available throughout git_inflate()'s
    ++		 * unlocked execution. Please refer to the comment at
    ++		 * get_size_from_delta() to see how this is done.
    ++		 */
     +		obj_read_unlock();
      		st = git_inflate(&stream, Z_FINISH);
     +		obj_read_lock();
 6:  b439bdeed3 =  6:  fc1200bb07 grep: replace grep_read_mutex by internal obj read lock
 7:  d759f1e8c7 !  7:  d39d2ce9c4 submodule-config: add skip_if_read option to repo_read_gitmodules()
    @@ Metadata
      ## Commit message ##
         submodule-config: add skip_if_read option to repo_read_gitmodules()
     
    -    Currently, submodule-config.c doesn't have an externally acessible
    +    Currently, submodule-config.c doesn't have an externally accessible
         function to read gitmodules only if it wasn't already read. But this
    -    exactly behavior is internally implemented by gitmodules_read_check(),
    -    to perform a lazy load. Let's merge this function with
    -    repo_read_gitmodules() adding an 'skip_if_read' which allow both
    +    exact behavior is internally implemented by gitmodules_read_check(), to
    +    perform a lazy load. Let's merge this function with
    +    repo_read_gitmodules() adding a 'skip_if_read' which allows both
         internal and external callers to access this functionality. This
    -    simplifies a little the code. The added option will also be used in the
    -    following patch.
    +    simplifies a little the code. The added option will also be used in
    +    the following patch.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    @@ submodule-config.h: int option_fetch_parse_recurse_submodules(const struct optio
     -void repo_read_gitmodules(struct repository *repo);
     +void repo_read_gitmodules(struct repository *repo, int skip_if_read);
      void gitmodules_config_oid(const struct object_id *commit_oid);
    - const struct submodule *submodule_from_name(struct repository *r,
    - 					    const struct object_id *commit_or_tree,
    + 
    + /**
     
      ## unpack-trees.c ##
     @@ unpack-trees.c: static void load_gitmodules_file(struct index_state *index,
 8:  2e76847ec9 !  8:  af8ad95d41 grep: allow submodule functions to run in parallel
    @@ Commit message
           race condition with object reading (for example parse_object() and
           is_promisor_remote()). However, they only call repo_read_gitmodules()
           if it wasn't read before. So let's pre-read it before firing the
    -      threads and allow these two functions to safelly be called in
    +      threads and allow these two functions to safely be called in
           parallel.
     
         - repo_submodule_init() is already thread-safe, so remove it from the
    @@ Commit message
           protected for now. Let's add a "NEEDSWORK" to it, informing why it
           cannot be removed from the critical section yet.
     
    -    - Finally, add_to_alternates_memory() must be kept protected by the same
    -      reason of the above item.
    +    - Finally, add_to_alternates_memory() must be kept protected for the
    +      same reason as the item above.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
 9:  134114b001 !  9:  0ccf79ba86 grep: protect packed_git [re-]initialization
    @@ Commit message
         happen often, it could be hard to detect. So to prevent future
         headaches, let's force eager initialization of packed_git when setting
         git-grep up. There'll be a small overhead in the cases where we didn't
    -    really needed to prepare packed_git during execution but this shouldn't
    -    be very noticeable.
    +    really need to prepare packed_git during execution but this shouldn't be
    +    very noticeable.
     
         Also, packed_git may be re-initialized by
         packfile.c:reprepare_packed_git(). Again, all paths to it in git-grep
10:  04a4d81ff5 ! 10:  6c09e9169d grep: re-enable threads in non-worktree case
    @@ Commit message
             8**  |   6.2886s  |   6.9843s
     
         These are all means of 30 executions after 2 warmup runs. All tests were
    -    executed on an i7-7700HQ (quad core w/ hyper-threading), 16GB of RAM and
    +    executed on an i7-7700HQ (quad-core w/ hyper-threading), 16GB of RAM and
         SSD, running Manjaro Linux. But to make sure the optimization also
         performs well on HDD, the tests were repeated on another machine with an
    -    i5-4210U (dual core w/ hyper-threading), 8GB of RAM and HDD (SATA III,
    +    i5-4210U (dual-core w/ hyper-threading), 8GB of RAM and HDD (SATA III,
         5400 rpm), also running Manjaro Linux:
     
          Threads |   Regex 1  |  Regex 2
    @@ Commit message
         case when --textconv is used and there're too many text conversions.
         Probably the reason for this is that the object read lock is used to
         protect fill_textconv() and therefore there is a mutual exclusion
    -    between textconv execution and object reading. Because both are time
    -    consuming operations, not being able to perform them in parallel can
    -    cause performance drops. To inform the users about this (and other
    -    threading detais), let's also add a "NOTES ON THREADS" section to
    +    between textconv execution and object reading. Because both are
    +    time-consuming operations, not being able to perform them in parallel
    +    can cause performance drops. To inform the users about this (and other
    +    threading details), let's also add a "NOTES ON THREADS" section to
         Documentation/git-grep.txt.
     
         [1]: chromium’s repo at commit 03ae96f (“Add filters testing at DSF=2”,
11:  4f6f8b611c = 11:  2f72f30341 grep: move driver pre-load out of critical section
 -:  ---------- > 12:  a5891176d7 grep: use no. of cores as the default no. of threads
-- 
2.24.1

