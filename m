Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF26C433B4
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587BF6128B
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhDYORD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhDYORD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B718C061574
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so3680157wmh.0
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iT9l77WE50C1byC4/kGbs9WmHgI7WhyH6N2jRHf4dXU=;
        b=Vf7nERZ4zGwdaOvi+BwHaCH2GuU0+chP3vWvqwuuv3/v+UWdWfxJCGGmOR0EOJIZ7d
         4V261i7R93cjZicoy5KX2/ebI5PTrr9J1SkfGWBz18WkZPamM494Vdt7mLRgVYXqzFnG
         mKYDBAw+l3Azq4+jNyMSMk1SPTy5b/NO5tu1jINeqzdzbtKaufsiBYsyDrSIWJB5uFhD
         Ero6jmIJQnQWPrxC9X2A72OO435gvobYLDLcJP3WH75JW5an/Jb2zJNhEzI0+gCfwJX+
         8sU9Nl/Ych7BD4SADnULbCzt+c+dbid6Wg7K8Q/KFRIuiVT0nbBWB5+E+r6D1cgO4RhQ
         3aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iT9l77WE50C1byC4/kGbs9WmHgI7WhyH6N2jRHf4dXU=;
        b=sAxVjl7DsGjaCYekZDUXYZ9VvVOtSdTlAvXP3WrVdyM3jkYb/aP8XVr16EXgZ3/zUj
         eNxmJFjvSgmrUowHT3vfk8J3/4f6KHa9DdD0rTQedTSuAPYqO2CuYzg7nUs1jSxLDCM6
         bW0FPCzkKYOLdt7edwReE4pFQcOrGUsj0YTIlalMcSMHnga1WqMZrukBflQQeQ3xjESP
         7rpD3tU4mwxATViNG2WjwDaDANNfInephskN5lDhr0AvlwCgkBVjeczoi5/C+LDQfHyz
         TPqzfZg7NbV7CBeqT/ShOHl5fog4mBBcLp1MO6/O3PsJWPVbdIitgSwS45RlY/4Ih7dT
         QHDw==
X-Gm-Message-State: AOAM530f9DvJ8+fMAUeiJE81FMhpzs9vPDjMmNUbGITEvfOUzYDA53uh
        +3kuCaiU1aKNX6s5S5GXfz8uq7n0eAE=
X-Google-Smtp-Source: ABdhPJwc5ffLWetbcsCx0Y4rdTTJbHKVvfNSKPZ8mzi76AQ1F5bwMLtTAJdS1TVuM4OenpUybPaUpQ==
X-Received: by 2002:a1c:7e45:: with SMTP id z66mr14371341wmc.126.1619360181851;
        Sun, 25 Apr 2021 07:16:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm13313054wmh.0.2021.04.25.07.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:21 -0700 (PDT)
Message-Id: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:07 +0000
Subject: [PATCH v2 00/12] Fix all leaks in tests t0002-t0099: Part 1
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2 addresses all the issues brought up during review, and adds a link to
Gabor's analysis of the bloom filter changes.

Andrzej Hunt (12):
  revision: free remainder of old commit list in limit_list
  wt-status: fix multiple small leaks
  ls-files: free max_prefix when done
  bloom: clear each bloom_key after use
  branch: FREE_AND_NULL instead of NULL'ing real_ref
  builtin/bugreport: don't leak prefixed filename
  builtin/check-ignore: clear_pathspec before returning
  builtin/checkout: clear pending objects after diffing
  mailinfo: also free strbuf lists when clearing mailinfo
  builtin/for-each-ref: free filter and UNLEAK sorting.
  builtin/rebase: release git_format_patch_opt too
  builtin/rm: avoid leaking pathspec and seen

 bloom.c                |  1 +
 branch.c               |  2 +-
 builtin/bugreport.c    |  8 +++++---
 builtin/check-ignore.c |  1 +
 builtin/checkout.c     |  1 +
 builtin/for-each-ref.c |  3 +++
 builtin/ls-files.c     |  3 ++-
 builtin/rebase.c       |  1 +
 builtin/rm.c           |  2 ++
 mailinfo.c             | 14 +++-----------
 revision.c             | 17 ++++++++++-------
 strbuf.c               |  2 ++
 wt-status.c            |  4 ++++
 13 files changed, 36 insertions(+), 23 deletions(-)


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-929%2Fahunt%2Fleaksan-100-part1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-929/ahunt/leaksan-100-part1-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/929

Range-diff vs v1:

  1:  12f0dcaef109 !  1:  d97307edca42 revision: free remainder of old commit list in limit_list
     @@ Commit message
          to avoid a leak. (revs->commits itself will be an invalid pointer: it
          will have been free'd during the first pop_commit.)
      
     +    However the list pointer is later reused to iterate over our new list,
     +    but only for the limiting_can_increase_treesame() branch. We therefore
     +    need to introduce a new variable for that branch - and while we're here
     +    we can rename the original list to original_list as that makes its
     +    purpose more obvious.
     +
          This leak was found while running t0090. It's not likely to be very
          impactful, but it can happen quite early during some checkout
          invocations, and hence seems to be worth fixing:
     @@ Commit message
      
       ## revision.c ##
      @@ revision.c: static int limit_list(struct rev_info *revs)
     + {
     + 	int slop = SLOP;
     + 	timestamp_t date = TIME_MAX;
     +-	struct commit_list *list = revs->commits;
     ++	struct commit_list *original_list = revs->commits;
     + 	struct commit_list *newlist = NULL;
     + 	struct commit_list **p = &newlist;
     + 	struct commit_list *bottom = NULL;
     + 	struct commit *interesting_cache = NULL;
     + 
     + 	if (revs->ancestry_path) {
     +-		bottom = collect_bottom_commits(list);
     ++		bottom = collect_bottom_commits(original_list);
     + 		if (!bottom)
     + 			die("--ancestry-path given but there are no bottom commits");
     + 	}
     + 
     +-	while (list) {
     +-		struct commit *commit = pop_commit(&list);
     ++	while (original_list) {
     ++		struct commit *commit = pop_commit(&original_list);
     + 		struct object *obj = &commit->object;
     + 		show_early_output_fn_t show;
     + 
     +@@ revision.c: static int limit_list(struct rev_info *revs)
     + 
     + 		if (revs->max_age != -1 && (commit->date < revs->max_age))
     + 			obj->flags |= UNINTERESTING;
     +-		if (process_parents(revs, commit, &list, NULL) < 0)
     ++		if (process_parents(revs, commit, &original_list, NULL) < 0)
     + 			return -1;
     + 		if (obj->flags & UNINTERESTING) {
     + 			mark_parents_uninteresting(commit);
     +-			slop = still_interesting(list, date, slop, &interesting_cache);
     ++			slop = still_interesting(original_list, date, slop, &interesting_cache);
     + 			if (slop)
     + 				continue;
     + 			break;
     +@@ revision.c: static int limit_list(struct rev_info *revs)
     + 	 * Check if any commits have become TREESAME by some of their parents
     + 	 * becoming UNINTERESTING.
     + 	 */
     +-	if (limiting_can_increase_treesame(revs))
     ++	if (limiting_can_increase_treesame(revs)) {
     ++		struct commit_list *list = NULL;
     + 		for (list = newlist; list; list = list->next) {
     + 			struct commit *c = list->item;
     + 			if (c->object.flags & (UNINTERESTING | TREESAME))
     + 				continue;
       			update_treesame(revs, c);
       		}
     ++	}
       
     -+	free_commit_list(list);
     ++	free_commit_list(original_list);
       	revs->commits = newlist;
       	return 0;
       }
  2:  716a21b4ef73 =  2:  9ad3d8e3fbf4 wt-status: fix multiple small leaks
  3:  beccdb177869 !  3:  76519acdfee7 ls-files: free max_prefix when done
     @@ Commit message
          Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
      
       ## builtin/ls-files.c ##
     +@@ builtin/ls-files.c: static int option_parse_exclude_standard(const struct option *opt,
     + int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
     + {
     + 	int require_work_tree = 0, show_tag = 0, i;
     +-	const char *max_prefix;
     ++	char *max_prefix;
     + 	struct dir_struct dir;
     + 	struct pattern_list *pl;
     + 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
      @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
       	}
       
       	dir_clear(&dir);
     -+	free((void *)max_prefix);
     ++	free(max_prefix);
       	return 0;
       }
  4:  9ae15b948813 !  4:  fb64a3dcd0b0 bloom: clear each bloom_key after use
     @@ Commit message
          fill_bloom_key() allocates memory into bloom_key, we need to clean that
          up once the key is no longer needed.
      
     -    This fixes the following leak which was found while running t0002-t0099.
     -    Although this leak is happening in code being called from a test-helper,
     -    the same code is also used in various locations around git, and could
     -    presumably happen during normal usage too.
     +    This leak was found while running t0002-t0099. Although this leak is
     +    happening in code being called from a test-helper, the same code is also
     +    used in various locations around git, and can therefore happen during
     +    normal usage too. Gabor's analysis shows that peak-memory usage during
     +    'git commit-graph write' is reduced on the order of 10% for a selection
     +    of larger repos (along with an even larger reduction if we override
     +    modified path bloom filter limits):
     +    https://lore.kernel.org/git/20210411072651.GF2947267@szeder.dev/
     +
     +    LSAN output:
      
          Direct leak of 308 byte(s) in 11 object(s) allocated from:
              #0 0x49a5e2 in calloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
  5:  8c7ba2b83d5d =  5:  154c6714f305 branch: FREE_AND_NULL instead of NULL'ing real_ref
  6:  24129e3e633d =  6:  0ae6224e01bc builtin/bugreport: don't leak prefixed filename
  7:  563264af39c3 =  7:  693ea82490df builtin/check-ignore: clear_pathspec before returning
  8:  cdeb4b7875e3 =  8:  20c5f2e68c54 builtin/checkout: clear pending objects after diffing
  9:  130ef89218a4 !  9:  217f571f8ef5 mailinfo: also free strbuf lists when clearing mailinfo
     @@ Commit message
          array contents but want to reuse the array itself, hence we can't use
          strbuf_list_free() there.
      
     +    However, strbuf_list_free() cannot handle a NULL input, and the lists we
     +    are freeing might be NULL. Therefore we add a NULL check in
     +    strbuf_list_free() to make it safe to use with a NULL input (which is a
     +    pattern used by some of the other *_free() functions around git).
     +
          Leak output from t0023:
      
          Direct leak of 72 byte(s) in 3 object(s) allocated from:
     @@ mailinfo.c: void setup_mailinfo(struct mailinfo *mi)
       
       	while (mi->content < mi->content_top) {
       		free(*(mi->content_top));
     +
     + ## strbuf.c ##
     +@@ strbuf.c: void strbuf_list_free(struct strbuf **sbs)
     + {
     + 	struct strbuf **s = sbs;
     + 
     ++	if (!s)
     ++		return;
     + 	while (*s) {
     + 		strbuf_release(*s);
     + 		free(*s++);
 10:  8f2374ee899d = 10:  c4363c212217 builtin/for-each-ref: free filter and UNLEAK sorting.
 11:  c17e296bcb14 = 11:  a67168677477 builtin/rebase: release git_format_patch_opt too
 12:  db1b151e2a15 = 12:  703cd9656bf8 builtin/rm: avoid leaking pathspec and seen

-- 
gitgitgadget
