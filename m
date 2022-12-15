Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649C4C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLOIw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOIw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B191D64D
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o5so2320931wrm.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvU6CV6U8xi0CQQxXFk0wfAp1nTRdMrFB+Q4Qg7UDtA=;
        b=BGiMGwucRWQZ9BdS0KtbPSxwGyRpk8ixtdx9oWhSdR0CO2UOrFQ8UWo1hHmthlB8Nj
         /775M4JXrnCTWlesc672tTcoShFwfORsA+9d6cBiWK8oql2JSdCYXzjYfGpLNO3rVs4p
         bpOycfjpWnASKtw5QkGXIcMwlfdZ19PuBWp9HmamzxtXTbq+CFRhn0OUZQGoREhtpGo1
         6+zQKXxudrZIITxRXkpm0vSiYvHYKXYvMurYTXexsmg1rE/Q0Z56rNNYp4WwaCaiMmCk
         Nus1OLZB0G7Q0a5dvo1tGVqHgY8JF5pxJl3I/dBaHTMkMHKyXcwK/P7xv6OIIVjwxw39
         bN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvU6CV6U8xi0CQQxXFk0wfAp1nTRdMrFB+Q4Qg7UDtA=;
        b=D0t5PAREuKUbyzyIFhkPJXCFkALqeviOPuXdB6CvPDDt8rdo4XOcmBkHM/Z1HJLRSb
         Yrc4DueVsxz6wAqeyhHZFd/UnlsfdrvX3YxiY380wdHpryro6h98yyuwDi8Lp5LvMuWM
         vLdRXozEtS24M+kp19M30JzXv2S3KqxjCb0YXH+1oDA7QIiIVJRXfuIF+rifD4ki/wtD
         JMFiMK0fwove+6Fc0/jnZq3XC0F9CYJJfrSyuruxTCh/heTS0SXkG+TtHhDNKj0yxXaY
         3+aZadVhYG0q8LPZrVsPqMDw/cJrJ6Ae+iqcIblI0V7aC5JXSNUnJPMwwE+WOxfCZalv
         PyYg==
X-Gm-Message-State: ANoB5pnGQF5ydonZ0Jb+ZvsqDsz1LwqF/phBU11mx5ZoC0zClscEjBL0
        9bOc25vx+UxHrAKCpEhopTFDnMWbWeCWZA==
X-Google-Smtp-Source: AA0mqf7W8ejsrYztqCE7+qHG1P2JD7QSsnZaxZPegbm6BLnRn4yj5Kkf4XyXX45uo6DxTWULyOr39w==
X-Received: by 2002:a5d:404f:0:b0:242:7c7a:7ee7 with SMTP id w15-20020a5d404f000000b002427c7a7ee7mr17903163wrp.53.1671094344203;
        Thu, 15 Dec 2022 00:52:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:23 -0800 (PST)
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
Subject: [PATCH v10 00/12] merge-index: prepare to rewrite merge drivers in C
Date:   Thu, 15 Dec 2022 09:52:04 +0100
Message-Id: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a prep series for a re-roll of Alban Gruin's series to rewrite
various merge drivers from *.sh to *.c, and being able to call those
in-process.

That series was discussed on-list in August[1], and has now been
ejected from "seen" due to staleness. This v10 re-roll is my second
attempt at re-starting this topic, see [2] for v9.

In v8 there were concerns with the later part of this topic, but the
parts that are included here weren't controversial, those will be part
2 (and I think I've addressed those concerns).

Changes since v9:

* Rebase on minor (unrelated) merge-index and
  "USE_THE_INDEX_COMPATIBILITY_MACROS" changes that have since landed.

* Trivial adjustments to error messages, including marking one that
  wasn't marked with _() for translation.

See [3] for my branch for this topic, which includes passing CI.

1. https://lore.kernel.org/git/20220809185429.20098-9-alban.gruin@gmail.com/
2. https://lore.kernel.org/git/cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com/
3. https://github.com/avar/git/tree/ag/merge-strategies-in-c-prep-3

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
  builtin/merge-index.c: don't USE_THE_INDEX_VARIABLE
  merge-index: use "struct strvec" and helper to prepare args
  merge-index: make the argument parsing sensible & simpler

 Documentation/git-merge-index.txt |   2 +-
 Makefile                          |   1 +
 builtin/merge-index.c             | 167 ++++++++++++++----------------
 git.c                             |   2 +-
 merge-strategies.c                |  87 ++++++++++++++++
 merge-strategies.h                |  19 ++++
 t/t0450/txt-help-mismatches       |   1 -
 t/t6060-merge-index.sh            |  65 +++++++++++-
 8 files changed, 249 insertions(+), 95 deletions(-)
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

Range-diff against v9:
 1:  660b1242707 !  1:  9240ab10649 merge-index doc & -h: fix padding, labels and "()" use
    @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const ch
     -		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
     +		usage("git merge-index [-o] [-q] <merge-program> (-a | ([--] <file>...))");
      
    - 	read_cache();
    + 	repo_read_index(the_repository);
      
     
      ## t/t0450/txt-help-mismatches ##
 2:  caf4a3790c4 =  2:  de36b52286b t6060: modify multiple files to expose a possible issue with merge-index
 3:  d659ac983f8 =  3:  5edc8132329 t6060: add tests for removed files
 4:  7c5b7c36411 =  4:  aa731011e0a merge-index tests: add usage tests
 5:  07f6936011a !  5:  a3f69564ac5 merge-index: migrate to parse_options() API
    @@ Commit message
     
      ## builtin/merge-index.c ##
     @@
    - #define USE_THE_INDEX_COMPATIBILITY_MACROS
    + #define USE_THE_INDEX_VARIABLE
      #include "builtin.h"
     +#include "parse-options.h"
      #include "run-command.h"
    @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const ch
     +		usage_msg_opt(_("'-a' and '<file>...' are mutually exclusive"),
     +			      usage, options);
      
    - 	read_cache();
    + 	repo_read_index(the_repository);
      
      	/* TODO: audit for interaction with sparse-index. */
      	ensure_full_index(&the_index);
 6:  8d6cfd4bacc !  6:  324368401a2 merge-index: improve die() error messages
    @@ builtin/merge-index.c
     @@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
      	struct child_process cmd = CHILD_PROCESS_INIT;
      
    - 	if (pos >= active_nr)
    + 	if (pos >= the_index.cache_nr)
     -		die("git merge-index: %s not in the cache", path);
     +		die("'%s' is not in the cache", path);
      	found = 0;
      	do {
    - 		const struct cache_entry *ce = active_cache[pos];
    + 		const struct cache_entry *ce = the_index.cache[pos];
     @@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
      		arguments[stage + 4] = ownbuf[stage];
    - 	} while (++pos < active_nr);
    + 	} while (++pos < the_index.cache_nr);
      	if (!found)
     -		die("git merge-index: %s not in the cache", path);
     +		die("'%s' is not in the cache", path);
 7:  62c5fd4faaa !  7:  de4d11798db merge-index i18n: mark die() messages for translation
    @@ builtin/merge-index.c
     @@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
      	struct child_process cmd = CHILD_PROCESS_INIT;
      
    - 	if (pos >= active_nr)
    + 	if (pos >= the_index.cache_nr)
     -		die("'%s' is not in the cache", path);
     +		die(_("'%s' is not in the cache"), path);
      	found = 0;
      	do {
    - 		const struct cache_entry *ce = active_cache[pos];
    + 		const struct cache_entry *ce = the_index.cache[pos];
     @@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
      		arguments[stage + 4] = ownbuf[stage];
    - 	} while (++pos < active_nr);
    + 	} while (++pos < the_index.cache_nr);
      	if (!found)
     -		die("'%s' is not in the cache", path);
     +		die(_("'%s' is not in the cache"), path);
 8:  e44d58a505a !  8:  45cf7995448 merge-index: stop calling ensure_full_index() twice
    @@ builtin/merge-index.c: static void merge_one_path(const char *path)
     -	/* TODO: audit for interaction with sparse-index. */
     -	ensure_full_index(&the_index);
     +
    - 	for (i = 0; i < active_nr; i++) {
    - 		const struct cache_entry *ce = active_cache[i];
    + 	for (i = 0; i < the_index.cache_nr; i++) {
    + 		const struct cache_entry *ce = the_index.cache[i];
      		if (!ce_stage(ce))
     @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const char *prefix)
      	/* TODO: audit for interaction with sparse-index. */
 9:  1f7c941035d !  9:  fc9a05ee034 builtin/merge-index.c: don't USE_THE_INDEX_COMPATIBILITY_MACROS
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    builtin/merge-index.c: don't USE_THE_INDEX_COMPATIBILITY_MACROS
    +    builtin/merge-index.c: don't USE_THE_INDEX_VARIABLE
     
    -    Remove "USE_THE_INDEX_COMPATIBILITY_MACROS" and instead pass
    -    "the_index" around between the functions in this file. In a subsequent
    -    commit we'll libify this, and don't want to use
    -    "USE_THE_INDEX_COMPATIBILITY_MACROS" in any more places in the
    -    top-level *.c files. Doing this first makes that diff a lot smaller.
    +    Remove "USE_THE_INDEX_VARIABLE" and instead pass "the_index" around
    +    between the functions in this file. In a subsequent commit we'll
    +    libify this, and don't want to use "USE_THE_INDEX_VARIABLE" in any
    +    more places in the top-level *.c files. Doing this first makes that
    +    diff a lot smaller.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/merge-index.c ##
     @@
    --#define USE_THE_INDEX_COMPATIBILITY_MACROS
    +-#define USE_THE_INDEX_VARIABLE
      #include "builtin.h"
      #include "parse-options.h"
      #include "run-command.h"
    @@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
      	char ownbuf[4][60];
      	struct child_process cmd = CHILD_PROCESS_INIT;
      
    --	if (pos >= active_nr)
    +-	if (pos >= the_index.cache_nr)
     +	if (pos >= istate->cache_nr)
      		die(_("'%s' is not in the cache"), path);
      	found = 0;
      	do {
    --		const struct cache_entry *ce = active_cache[pos];
    +-		const struct cache_entry *ce = the_index.cache[pos];
     +		const struct cache_entry *ce = istate->cache[pos];
      		int stage = ce_stage(ce);
      
    @@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
      		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
      		arguments[stage] = hexbuf[stage];
      		arguments[stage + 4] = ownbuf[stage];
    --	} while (++pos < active_nr);
    +-	} while (++pos < the_index.cache_nr);
     +	} while (++pos < istate->cache_nr);
      	if (!found)
      		die(_("'%s' is not in the cache"), path);
    @@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
     -static void merge_one_path(const char *path)
     +static void merge_one_path(struct index_state *istate, const char *path)
      {
    --	int pos = cache_name_pos(path, strlen(path));
    +-	int pos = index_name_pos(&the_index, path, strlen(path));
     +	int pos = index_name_pos(istate, path, strlen(path));
      
      	/*
    @@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
      {
      	int i;
      
    --	for (i = 0; i < active_nr; i++) {
    --		const struct cache_entry *ce = active_cache[i];
    +-	for (i = 0; i < the_index.cache_nr; i++) {
    +-		const struct cache_entry *ce = the_index.cache[i];
     +	for (i = 0; i < istate->cache_nr; i++) {
     +		const struct cache_entry *ce = istate->cache[i];
      		if (!ce_stage(ce))
    @@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
      }
      
     @@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const char *prefix)
    - 		usage_msg_opt(_("'-a' and '<file>...' are mutually exclusive"),
    - 			      usage, options);
    - 
    --	read_cache();
    -+	repo_read_index(the_repository);
    + 	repo_read_index(the_repository);
      
      	/* TODO: audit for interaction with sparse-index. */
     -	ensure_full_index(&the_index);
10:  8c43b64dec4 = 10:  0efc5039e46 merge-index: libify merge_one_path() and merge_all()
11:  592db883dad = 11:  748fef4434f merge-index: use "struct strvec" and helper to prepare args
12:  5a2c4dd3acf = 12:  40b6d296f3a merge-index: make the argument parsing sensible & simpler
-- 
2.39.0.rc2.1048.g0e5493b8d5b

