Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC312C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8192065D
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK8JfSS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHRW6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgHRW6a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 18:58:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FFBC061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 15:58:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p14so400027wmg.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SUq/DO4Ns9BeZ5BcRTZG9KpIZxx5sIG12QxQYkBUFtA=;
        b=VK8JfSS8noIKRn+6KMzhA0N+yIIV8C8zAxsUgLpEHLP2TkmHbKTXr2o77pOPC0gJBF
         DWIs0krd7mUlYJMbribSpJY7PWFtdHesaq8m8QnbXGqyg0G2VKpl+BGvXjicONIP1GHz
         cWRN8nPzfF/3FILNKpvKHRavSZup/vJOpuO53na4D5vgGPPi9kl+pOkdWCDC3QFh4bSg
         a3mP6L31FINcupPpY/5omu4A9I974UIC8ckk3kI52GetN9xT1VGlx8zMYUUKe/c0ta7+
         fFiJU1BkyVAyK1QD/NW+SHeKa1UD1RFDEE/np+o9xtCtWU6d+YlD1Rp7v6xnznlpTrZ6
         08zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SUq/DO4Ns9BeZ5BcRTZG9KpIZxx5sIG12QxQYkBUFtA=;
        b=AWKCRQC2U19RJpONAhDtTeggD2YLGznI1KRMVtvIqOkvpZyL4fx6MtB2kSOk3fq7zf
         g1p/MA8piyg+oG2oTf08WpsWCRu8NAQy30RjUypPmnABJRwiSfM5JLTGZ/ZbuuDKbm3v
         hAOkJdbhIa7LfH3hkxeQfZ64wYdJfijCqzRevto8RGRzWDkVU1EEmxBNO9ApWD2b8UHy
         kgRzLW75QZUjdOi+8s1e2Mw+BYXPmGtEvmot/EQm+TCoZUOMWgbBuqLbvcFg+f80VEQZ
         McQfbjZTATJjNe+YJioKCt30GHCen6nhqZLSDkqfmp4UJtsDnzI3BFZgWd1wL8iQi1sL
         6yRA==
X-Gm-Message-State: AOAM530yFVWwV49xA6gLpKGOFhi1RPqbKxevv7wjarFLbuCcP/kcOlBy
        40lFICFbQOX3fxX/kQRk7YGbg1FFgR0=
X-Google-Smtp-Source: ABdhPJzOIdzGpGh3ZJvzuoAL/vZqFXoerwdzOBmKB5q89FzGIplUL/7d60f2jraVkcoPEppcSKMcOw==
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr2091329wmn.78.1597791507901;
        Tue, 18 Aug 2020 15:58:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm2553748wme.32.2020.08.18.15.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 15:58:27 -0700 (PDT)
Message-Id: <pull.831.v2.git.git.1597791506.gitgitgadget@gmail.com>
In-Reply-To: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 22:58:24 +0000
Subject: [PATCH v2 0/2] Clean up some memory leaks in and around dir.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some memory leaks in dir.c were making it hard for me to find my own leaks
in merge-ort. I followed a few threads and tried to both clean up the leaks
and make the API less prone to incorrect use.

Changes since v1:

 * dropped the first patch, since Peff submitted an identical patch a day
   before me
 * implemented Peff's suggestions to rename dir_free() to dir_clear() and
   have it call dir_init() at the end so that folks can re-use the struct
   after dir_clear() if they so choose.

Elijah Newren (2):
  dir: make clear_directory() free all relevant memory
  dir: fix problematic API to avoid memory leaks

 builtin/add.c          |  4 ++--
 builtin/check-ignore.c |  4 ++--
 builtin/clean.c        | 12 ++++--------
 builtin/grep.c         |  3 ++-
 builtin/ls-files.c     |  4 ++--
 builtin/stash.c        |  7 ++-----
 dir.c                  | 20 +++++++++++++++++---
 dir.h                  | 21 +++++++++++----------
 merge.c                |  3 ++-
 wt-status.c            |  8 ++------
 10 files changed, 46 insertions(+), 40 deletions(-)


base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-831%2Fnewren%2Fdir_memory_cleanup-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-831/newren/dir_memory_cleanup-v2
Pull-Request: https://github.com/git/git/pull/831

Range-diff vs v1:

 1:  932741d759 < -:  ---------- dir: fix leak of parent_hashmap and recursive_hashmap
 2:  068e097e22 ! 1:  f890ac0279 dir: make clear_directory() free all relevant memory
     @@ Commit message
          The calling convention for the dir API is supposed to end with a call to
          clear_directory() to free up no longer needed memory.  However,
          clear_directory() didn't free dir->entries or dir->ignored.  I believe
     -    this was oversight, but a number of callers noticed memory leaks and
     -    started free'ing these, but often somewhat haphazardly (sometimes
     -    freeing the entries in the arrays, and sometimes only free'ing the
     -    arrays themselves).  This suggests the callers weren't trying to make
     -    sure any possible memory used might be free'd, but just the memory they
     -    noticed their usecase definitely had allocated.  This also caused the
     -    extra memory deallocations to be duplicated in many places.
     +    this was an oversight, but a number of callers noticed memory leaks and
     +    started free'ing these.  Unfortunately, they did so somewhat haphazardly
     +    (sometimes freeing the entries in the arrays, and sometimes only
     +    free'ing the arrays themselves).  This suggests the callers weren't
     +    trying to make sure any possible memory used might be free'd, but just
     +    the memory they noticed their usecase definitely had allocated.
      
          Fix this mess by moving all the duplicated free'ing logic into
     -    clear_directory().
     +    clear_directory().  End by resetting dir to a pristine state so it could
     +    be reused if desired.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/stash.c: static int get_untracked_files(const struct pathspec *ps, int i
      
       ## dir.c ##
      @@ dir.c: int remove_path(const char *name)
     - 	return 0;
       }
       
     --/*
     + /*
      - * Frees memory within dir which was allocated for exclude lists and
      - * the exclude_stack.  Does not free dir itself.
     -- */
     -+/* Frees memory within dir which was allocated.  Does not free dir itself. */
     ++ * Frees memory within dir which was allocated, and resets fields for further
     ++ * use.  Does not free dir itself.
     +  */
       void clear_directory(struct dir_struct *dir)
       {
     - 	int i, j;
      @@ dir.c: void clear_directory(struct dir_struct *dir)
       		free(group->pl);
       	}
     @@ dir.c: void clear_directory(struct dir_struct *dir)
       	stk = dir->exclude_stack;
       	while (stk) {
       		struct exclude_stack *prev = stk->prev;
     +@@ dir.c: void clear_directory(struct dir_struct *dir)
     + 		stk = prev;
     + 	}
     + 	strbuf_release(&dir->basebuf);
     ++
     ++	memset(&dir, 0, sizeof(*dir));
     + }
     + 
     + struct ondisk_untracked_cache {
      
       ## dir.h ##
      @@
 3:  b9310e9941 ! 2:  dcd72eef48 dir: fix problematic API to avoid memory leaks
     @@ Metadata
       ## Commit message ##
          dir: fix problematic API to avoid memory leaks
      
     -    Two commits ago, we noticed that parent_hashmap and recursive_hashmap
     -    were being leaked and fixed it by making clear_pattern_list() free those
     -    hashmaps.  One commit ago, we noticed that clear_directory() was only
     -    taking responsibility for a subset of fields within dir_struct, despite
     -    the fact that entries[] and ignored[] we allocated internally to dir.c,
     -    resulting in many callers either leaking or haphazardly trying to free
     -    these arrays and their contents.
     +    The dir structure seemed to have a number of leaks and problems around
     +    it.  First I noticed that parent_hashmap and recursive_hashmap were
     +    being leaked (though Peff noticed and submitted fixes before me).  Then
     +    I noticed in the previous commit that clear_directory() was only taking
     +    responsibility for a subset of fields within dir_struct, despite the
     +    fact that entries[] and ignored[] we allocated internally to dir.c.
     +    That, of course, resulted in many callers either leaking or haphazardly
     +    trying to free these arrays and their contents.
      
          Digging further, I found that despite the pretty clear documentation
          near the top of dir.h that folks were supposed to call clear_directory()
     @@ Commit message
          which then snowballed into further problems with the entries[],
          ignored[], parent_hashmap, and recursive_hashmap problems.
      
     -    Rename clear_directory() to dir_free() to be more in line with other
     +    Rename clear_directory() to dir_clear() to be more in line with other
          data structures in git, and introduce a dir_init() to handle the
          suggested memsetting of dir_struct to all zeroes.  I hope that a name
     -    like "dir_free()" is more clear, and that the presence of dir_init()
     -    will provide a hint to those looking at the code that there may be a
     -    corresponding dir_free() that they need to call.
     +    like "dir_clear()" is more clear, and that the presence of dir_init()
     +    will provide a hint to those looking at the code that they need to look
     +    for either a dir_clear() or a dir_free() and lead them to find
     +    dir_clear().
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
       			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
       		die(_("Unable to write new index file"));
       
     -+	dir_free(&dir);
     ++	dir_clear(&dir);
       	UNLEAK(pathspec);
      -	UNLEAK(dir);
       	return exit_status;
     @@ builtin/check-ignore.c: int cmd_check_ignore(int argc, const char **argv, const
       	}
       
      -	clear_directory(&dir);
     -+	dir_free(&dir);
     ++	dir_clear(&dir);
       
       	return !num_ignored;
       }
     @@ builtin/clean.c: static int filter_by_patterns_cmd(void)
       
       		strbuf_list_free(ignore_list);
      -		clear_directory(&dir);
     -+		dir_free(&dir);
     ++		dir_clear(&dir);
       	}
       
       	strbuf_release(&confirm);
     @@ builtin/clean.c: int cmd_clean(int argc, const char **argv, const char *prefix)
       	}
       
      -	clear_directory(&dir);
     -+	dir_free(&dir);
     ++	dir_clear(&dir);
       
       	if (interactive && del_list.nr > 0)
       		interactive_main_loop();
     @@ builtin/grep.c: static int grep_directory(struct grep_opt *opt, const struct pat
       		if (hit && opt->status_only)
       			break;
       	}
     -+	dir_free(&dir);
     ++	dir_clear(&dir);
       	return hit;
       }
       
     @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cm
       	}
       
      -	UNLEAK(dir);
     -+	dir_free(&dir);
     ++	dir_clear(&dir);
       	return 0;
       }
      
     @@ builtin/stash.c: static int get_untracked_files(const struct pathspec *ps, int i
       	}
       
      -	clear_directory(&dir);
     -+	dir_free(&dir);
     ++	dir_clear(&dir);
       	return found;
       }
       
     @@ dir.c: static enum path_treatment read_directory_recursive(struct dir_struct *di
       {
       	int cnt = 0;
      @@ dir.c: int remove_path(const char *name)
     - }
     - 
     - /* Frees memory within dir which was allocated.  Does not free dir itself. */
     +  * Frees memory within dir which was allocated, and resets fields for further
     +  * use.  Does not free dir itself.
     +  */
      -void clear_directory(struct dir_struct *dir)
     -+void dir_free(struct dir_struct *dir)
     ++void dir_clear(struct dir_struct *dir)
       {
       	int i, j;
       	struct exclude_list_group *group;
     +@@ dir.c: void clear_directory(struct dir_struct *dir)
     + 	}
     + 	strbuf_release(&dir->basebuf);
     + 
     +-	memset(&dir, 0, sizeof(*dir));
     ++	dir_init(dir);
     + }
     + 
     + struct ondisk_untracked_cache {
      
       ## dir.h ##
      @@
     @@ dir.h
      - * - Use `dir.entries[]`.
      + * - Use `dir.entries[]` and `dir.ignored[]`.
        *
     -  * - Call `clear_directory()` when the contained elements are no longer in use.
     +- * - Call `clear_directory()` when the contained elements are no longer in use.
     ++ * - Call `dir_clear()` when the contained elements are no longer in use.
        *
     +  */
     + 
      @@ dir.h: int match_pathspec(const struct index_state *istate,
       int report_path_error(const char *ps_matched, const struct pathspec *pathspec);
       int within_depth(const char *name, int namelen, int depth, int max_depth);
     @@ dir.h: void parse_path_pattern(const char **string, int *patternlen, unsigned *f
       		 int baselen, struct pattern_list *pl, int srcpos);
       void clear_pattern_list(struct pattern_list *pl);
      -void clear_directory(struct dir_struct *dir);
     -+void dir_free(struct dir_struct *dir);
     ++void dir_clear(struct dir_struct *dir);
       
       int repo_file_exists(struct repository *repo, const char *path);
       int file_exists(const char *);
     @@ merge.c: int checkout_fast_forward(struct repository *r,
       		clear_unpack_trees_porcelain(&opts);
       		return -1;
       	}
     -+	dir_free(&dir);
     ++	dir_clear(&dir);
       	clear_unpack_trees_porcelain(&opts);
       
       	if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
     @@ wt-status.c: static void wt_status_collect_untracked(struct wt_status *s)
       	}
       
      -	clear_directory(&dir);
     -+	dir_free(&dir);
     ++	dir_clear(&dir);
       
       	if (advice_status_u_option)
       		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;

-- 
gitgitgadget
