Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F44AC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1284C61052
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhI0M4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbhI0M4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 08:56:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922EC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 205-20020a1c01d6000000b0030cd17ffcf8so468674wmb.3
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CTTwCuLyZx2TFMOZ280LopQ33Kijk3s6t+hOKBiHXoU=;
        b=KwnaQhMo1Q4wWEHr3t7qDjaVnhWQszrerpLQthADdJ4yxZ3yKoppVLdIReDMZtH3kT
         A5yUW82UIDPTYse31b/w3FLDlYr1m5ax638PL0Ha7pKJS9ZQXeEqaXbJwq0DznbgI4G5
         fQ5kcwizdZTB/zSrOdWNw6yUK4cUwq4lLgsv0jfEj7wEIyahTkezNqdtGnUJIetprmDX
         FMorb88hVAxLo7taUoHKH7l3jEYDk8l3NZjq9Zw04yIvq1rDPBWlCCxFmko+B2nphs2t
         UdfKycfPQaGf/ETbiUyG7tarAp9N5s6fNFSrgIiLn+BQIRIOEk1ETw2HzwdDU4EAvGjZ
         KX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CTTwCuLyZx2TFMOZ280LopQ33Kijk3s6t+hOKBiHXoU=;
        b=llKkMNtTbnXVM76gQ50eKE8nw8OoiGjHLqAgAMdM7bzGFlC9QK/oiqVHwebuZfzV80
         mPUXSiG23sZD2ef1SI85pFuaw3D9RbQ/Fks9ou+S/YeTdzSvy4GiX97LaVF1MTip/Gy4
         NUzn74SS1Q5/hTuKVv+UwmivCgAOkCeJi0E1gtA5re+awELW773KPasHX/yMgymaPJl6
         rdNKRPygepgzvsgnAcSfF8bs1Yb+9vwlW2fuLrc/hvxKAHOvrYlnjU8OPUkz2fzPXwt7
         fNvomFqn9+HHuJuOBvBVZHehV4w+P7T5mlrOpMj1hDz2Q+6zHCDgNMKkibM0V5Qzr9he
         kO4g==
X-Gm-Message-State: AOAM5316TQN52myXm0iY8nTPxhzx31nQ/Me8urJkAl2ATEZtLCeJvukd
        JCsgnxZ+/MyMWV163wdrY3mGGwAejoyGHw==
X-Google-Smtp-Source: ABdhPJwUjiWBpawxbI1bCcBIGqMob0ER9vvz89+kYQjraUYUMr14ENWsg6nei9OuNq0QiQQkrGnHBQ==
X-Received: by 2002:a1c:a387:: with SMTP id m129mr3048549wme.181.1632747283608;
        Mon, 27 Sep 2021 05:54:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w14sm16460434wro.8.2021.09.27.05.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:54:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] Designated initializer cleanup & conversion
Date:   Mon, 27 Sep 2021 14:54:23 +0200
Message-Id: <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrates more code to designated initializers, see
http://lore.kernel.org/git/cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com
for the v1.

This addresses all the feedback on v1, thanks all! Changes:

 * I'd misread the text around section 6.7.8 in C99 and misconverted
   the CHECKOUT_INIT macro. Thanks to Johannes Sixt for pointing it
   out.

 * Typo change in commit message & elaborate on why I'm not using the
   "*t = (struct cb_tree){ 0 };" pattern in 5/5.

 * Convert the LIST_HEAD_INIT and TRACE_KEY_INIT macros, which I
   missed in v1.

Nothing else changed as far as the end-state is concerned, but as the
range-diff shows I did some of the changes in the previous 4/5
partially in 3/5, e.g. for CACHE_DEF_INIT I first remove the duplicate
and redundant "0" fields, and then convert it to a designated
initializer.

Ævar Arnfjörð Bjarmason (5):
  submodule-config.h: remove unused SUBMODULE_INIT macro
  *.[ch] *_INIT macros: use { 0 } for a "zero out" idiom
  *.h _INIT macros: don't specify fields equal to 0
  *.h: move some *_INIT to designated initializers
  cbtree.h: define cb_init() in terms of CBTREE_INIT

 add-interactive.c                             |  8 +++++--
 builtin/submodule--helper.c                   | 21 ++++++++++---------
 cache.h                                       |  4 +++-
 cbtree.h                                      |  5 +++--
 checkout.c                                    |  2 +-
 .../git-credential-gnome-keyring.c            |  2 +-
 .../libsecret/git-credential-libsecret.c      |  2 +-
 diff.c                                        |  4 ++--
 entry.h                                       |  2 +-
 list.h                                        |  5 ++++-
 lockfile.h                                    |  2 +-
 object-store.h                                |  2 +-
 object.h                                      |  2 +-
 oid-array.h                                   |  2 +-
 path.h                                        |  5 +----
 ref-filter.c                                  |  2 +-
 remote.c                                      |  2 +-
 revision.c                                    |  2 +-
 sequencer.h                                   |  4 +++-
 shallow.h                                     |  4 +++-
 simple-ipc.h                                  |  6 +-----
 strbuf.h                                      |  2 +-
 strvec.h                                      |  4 +++-
 submodule-config.h                            |  4 ----
 submodule.c                                   |  8 ++++---
 submodule.h                                   |  4 +++-
 t/helper/test-run-command.c                   |  6 ++++--
 trace.h                                       |  2 +-
 transport.h                                   |  4 +++-
 29 files changed, 68 insertions(+), 54 deletions(-)

Range-diff against v1:
1:  7a7a0141515 = 1:  7a7a0141515 submodule-config.h: remove unused SUBMODULE_INIT macro
2:  d612e7df7a5 ! 2:  afcd2729c95 *.[ch] *_INIT macros: use { 0 } for a "zero out" idiom
    @@ Commit message
         zero'd out to 0, NULL or '\0', just providing a "{ 0 }" will
         accomplish that.
     
    -    Let's also change change code that provided N zero'd fields to just
    +    Let's also change code that provided N zero'd fields to just
         provide one, and change e.g. "{ NULL }" to "{ 0 }" for
         consistency. I.e. even if the first member is a pointer let's use "0"
         instead of "NULL". The point of using "0" consistently is to pick one,
    @@ diff.c: struct emitted_diff_symbol {
      static void append_emitted_diff_symbol(struct diff_options *o,
      				       struct emitted_diff_symbol *e)
     
    - ## entry.h ##
    -@@ entry.h: struct checkout {
    - 		 clone:1,
    - 		 refresh_cache:1;
    - };
    --#define CHECKOUT_INIT { NULL, "" }
    -+#define CHECKOUT_INIT { 0 }
    - 
    - #define TEMPORARY_FILENAME_LENGTH 25
    - /*
    -
      ## lockfile.h ##
     @@ lockfile.h: struct lock_file {
      	struct tempfile *tempfile;
3:  9e45d2e7bb3 ! 3:  590220bbdcc *.h _INIT macros: don't specify fields equal to 0
    @@ Commit message
         "struct ipc_client_connect_option" struct added in
         59c7b88198a (simple-ipc: add win32 implementation, 2021-03-15).
     
    +    Do the same for a few other initializers, e.g. STRVEC_INIT and
    +    CACHE_DEF_INIT.
    +
         Finally, start incrementally changing the same pattern in
         "t/helper/test-run-command.c". This change was part of an earlier
         on-list version[1] of c90be786da9 (test-tool run-command: fix
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## cache.h ##
    +@@ cache.h: struct cache_def {
    + 	int track_flags;
    + 	int prefix_len_stat_func;
    + };
    +-#define CACHE_DEF_INIT { STRBUF_INIT, 0, 0, 0 }
    ++#define CACHE_DEF_INIT { STRBUF_INIT }
    + static inline void cache_def_clear(struct cache_def *cache)
    + {
    + 	strbuf_release(&cache->path);
    +
      ## simple-ipc.h ##
     @@ simple-ipc.h: struct ipc_client_connect_options {
      	unsigned int uds_disallow_chdir:1;
    @@ strbuf.h: struct strbuf {
      /*
       * Predeclare this here, since cache.h includes this file before it defines the
     
    + ## strvec.h ##
    +@@ strvec.h: struct strvec {
    + 	size_t alloc;
    + };
    + 
    +-#define STRVEC_INIT { empty_strvec, 0, 0 }
    ++#define STRVEC_INIT { empty_strvec }
    + 
    + /**
    +  * Initialize an array. This is no different than assigning from
    +
    + ## submodule.h ##
    +@@ submodule.h: struct submodule_update_strategy {
    + 	enum submodule_update_type type;
    + 	const char *command;
    + };
    +-#define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
    ++#define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED}
    + 
    + int is_gitmodules_unmerged(struct index_state *istate);
    + int is_writing_gitmodules_ok(void);
    +
      ## t/helper/test-run-command.c ##
     @@ t/helper/test-run-command.c: struct testsuite {
      	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
    @@ t/helper/test-run-command.c: struct testsuite {
      
      static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
      		     void **task_cb)
    +
    + ## trace.h ##
    +@@ trace.h: struct trace_key {
    + 
    + extern struct trace_key trace_default_key;
    + 
    +-#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
    ++#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name }
    + extern struct trace_key trace_perf_key;
    + extern struct trace_key trace_setup_key;
    + 
4:  1f364565111 ! 4:  dd4ec1a0219 *.h: move some *_INIT to designated initializers
    @@ cache.h: struct cache_def {
      	int track_flags;
      	int prefix_len_stat_func;
      };
    --#define CACHE_DEF_INIT { STRBUF_INIT, 0, 0, 0 }
    +-#define CACHE_DEF_INIT { STRBUF_INIT }
     +#define CACHE_DEF_INIT { \
     +	.path = STRBUF_INIT, \
     +}
    @@ cache.h: struct cache_def {
      {
      	strbuf_release(&cache->path);
     
    + ## entry.h ##
    +@@ entry.h: struct checkout {
    + 		 clone:1,
    + 		 refresh_cache:1;
    + };
    +-#define CHECKOUT_INIT { NULL, "" }
    ++#define CHECKOUT_INIT { .base_dir = "" }
    + 
    + #define TEMPORARY_FILENAME_LENGTH 25
    + /*
    +
    + ## list.h ##
    +@@ list.h: struct list_head {
    + #define INIT_LIST_HEAD(ptr) \
    + 	(ptr)->next = (ptr)->prev = (ptr)
    + 
    +-#define LIST_HEAD_INIT(name) { &(name), &(name) }
    ++#define LIST_HEAD_INIT(name) { \
    ++	.next = &(name), \
    ++	.prev = &(name), \
    ++}
    + 
    + /* Add new element at the head of the list. */
    + static inline void list_add(struct list_head *newp, struct list_head *head)
    +
      ## sequencer.h ##
     @@ sequencer.h: struct todo_list {
      	struct stat_data stat;
    @@ strvec.h: struct strvec {
      	size_t alloc;
      };
      
    --#define STRVEC_INIT { empty_strvec, 0, 0 }
    +-#define STRVEC_INIT { empty_strvec }
     +#define STRVEC_INIT { \
     +	.v = empty_strvec, \
     +}
    @@ submodule.h: struct submodule_update_strategy {
      	enum submodule_update_type type;
      	const char *command;
      };
    --#define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
    +-#define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED}
     +#define SUBMODULE_UPDATE_STRATEGY_INIT { \
     +	.type = SM_UPDATE_UNSPECIFIED, \
     +}
    @@ t/helper/test-run-command.c: struct testsuite {
      static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
      		     void **task_cb)
     
    + ## trace.h ##
    +@@ trace.h: struct trace_key {
    + 
    + extern struct trace_key trace_default_key;
    + 
    +-#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name }
    ++#define TRACE_KEY_INIT(name) { .key = "GIT_TRACE_" #name }
    + extern struct trace_key trace_perf_key;
    + extern struct trace_key trace_setup_key;
    + 
    +
      ## transport.h ##
     @@ transport.h: struct transport_ls_refs_options {
      	 */
5:  7e571667674 ! 5:  76b47e7c80a cbtree.h: define cb_init() in terms of CBTREE_INIT
    @@ Commit message
         5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
         macro, 2021-07-01).
     
    +    It has been pointed out[1] that we could perhaps use this C99
    +    replacement of using a compound literal for all of these:
    +
    +        *t = (struct cb_tree){ 0 };
    +
    +    But let's just stick to the existing pattern established in
    +    5726a6b4012 for now, we can leave another weather balloon for some
    +    other time.
    +
    +    1. http://lore.kernel.org/git/ef724a3a-a4b8-65d3-c928-13a7d78f189a@gmail.com
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## cbtree.h ##
-- 
2.33.0.1316.gb2e9b3ba3ae

