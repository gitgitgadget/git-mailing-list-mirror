Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F832C7D63F
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937A2247F5
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMOvF3c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfLMSJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:09:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45611 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMSJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 13:09:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so389442wrj.12
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HKXnTwx3hedBkrbZA0TbB9RdxwC3C+Os1jFcYxGDZ98=;
        b=UMOvF3c3h7oqEl0ATF0ShEP5xl2IR3hG37NEwuO/Si3KYcLFicszG5o0xTkoNeBQel
         uXqawzI41wry8ldaaL+QbSwJ4WNAq39mYTeWkk9dmJyyx2/czInBNzA1L6fJL510ObCz
         2+OAQKaaeK4gSFqZb27Fswft9LceZ2YVwa+zze+8MLoFffz7yrhbjkwtggEL4eUaTqUH
         fsDOV8Y5KbLmOBQmtXtptkahCnHz3ykUlSykxr5ytEVfsWlJkHo/yaHuk3taVJAmMEm6
         aeHuCL2bxikSZPjwVyZu3TpYLIHiRK8kAX/79tWk6vHCJcVqxOPl9k+/U3LHfrffjMaG
         W0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HKXnTwx3hedBkrbZA0TbB9RdxwC3C+Os1jFcYxGDZ98=;
        b=a8EcDH5E1JGQ4ZiHZW0IKIvLDSbyqiVkXy9gp8mqIfKFCcTzVf79bPkLifT4Velj4S
         Y9N1dfroGFMAaU3qHfA/YroU10fDz/LKtZa62uPH0NiPVcXb4K1tXLVBc2T6t0TAtRor
         K+Gr4V/6SGWOx2PI3a7kb1WtfwyAQjXSIyVx6spUui7usT6xrCXN9MMSB6myA5mnzOf1
         XvB78yigh/+pvGhc2xwblMCEL5IN4ehGeV6xnG9B6qAIzkoI9geOJBWneXWEpyFIDXtM
         8bFX8pc+E2PPpyXcAX1PgtNAjWftXa8SFIjG0JFDMorkLt/HZ7o00YDn1ElvjUkf+fvT
         qRkw==
X-Gm-Message-State: APjAAAUoDwpu1oIWD/HihgiH67FC2XGVApIK+oklIdK6WsZ0DDXhwm0f
        DL9RpkFgiWkYQ5XWVYRAFOkItAQC
X-Google-Smtp-Source: APXvYqzfPYfYLDQXVfj1xrITvvJMo7igvpjauy3I9xzaf+DuKBnOQ9/dAH6WoQeWEzhl9aM8wVFG2A==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr13703125wrp.71.1576260595072;
        Fri, 13 Dec 2019 10:09:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u22sm11490493wru.30.2019.12.13.10.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 10:09:54 -0800 (PST)
Message-Id: <pull.488.v2.git.1576260593.gitgitgadget@gmail.com>
In-Reply-To: <pull.488.git.1575920580.gitgitgadget@gmail.com>
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 18:09:52 +0000
Subject: [PATCH v2 0/1] sparse-checkout: respect core.ignoreCase in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first of several cleanups to the sparse-checkout feature that
had a large overhaul in ds/sparse-cone.

We have an internal customer that plans to use sparse-checkout as a core
feature of their version control experience. They use a case-insensitive
filesystem, so as they created their directory dependency graph they did not
keep consistent casing. This data is what they plan to feed to "git
sparse-checkout set".

While I would certainly prefer that the data is cleaned up (and that process
is ongoing), I could not argue with the logic that git add does the "right
thing" when core.ignoreCase is enabled.

Update in V2:

Based on excellent feedback from Junio, we decided to shore up the case
issues from the previous implementation. Now, the sparse-checkout file may
be stored with the "wrong" case but the hash algorithm is replaced with a
case-insensitive check when core.ignoreCase is set. Because the performance
impact is much lower than I anticipated, I no longer think it is important
to add a new config option to enable/disable this logic.

Thanks, -Stolee

Derrick Stolee (1):
  sparse-checkout: respect core.ignoreCase in cone mode

 Documentation/git-sparse-checkout.txt |  5 +++++
 builtin/sparse-checkout.c             | 10 ++++++++--
 dir.c                                 | 15 ++++++++++++---
 t/t1091-sparse-checkout-builtin.sh    | 17 +++++++++++++++++
 4 files changed, 42 insertions(+), 5 deletions(-)


base-commit: cff4e9138d8df45e3b6199171092ee781cdadaeb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-488%2Fderrickstolee%2Fsparse-case-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-488/derrickstolee/sparse-case-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/488

Range-diff vs v1:

 1:  23705845ce ! 1:  dc97d5a0d2 sparse-checkout: respect core.ignoreCase in cone mode
     @@ -12,23 +12,42 @@
          using a case-insensitive match. Do the same for the sparse-checkout
          feature.
      
     -    The sanitize_cone_input() method is named to imply that other checks
     -    may be added. In fact, such checks are planned including looking for
     -    wildcards that make the paths invalid cone patterns or must be
     -    escaped.
     -
     -    Specifically, if the path has a match in the index, then use that
     -    path instead. If there is no match, still add that path to the
     -    patterns, as the user may expect the directory to appear after a
     -    checkout to another ref. However, we have no matching path to
     -    correct for a case conflict, and must assume that the user provided
     -    the correct case.
     -
     -    Another option would be to do case-insensitive checks while
     -    updating the skip-worktree bits during unpack_trees(). Outside of
     -    the potential performance loss on a more expensive code path, that
     -    also breaks compatibility with older versions of Git as using the
     -    same sparse-checkout file would change the paths that are included.
     +    Perform case-insensitive checks while updating the skip-worktree
     +    bits during unpack_trees(). This is done by changing the hash
     +    algorithm and hashmap comparison methods to optionally use case-
     +    insensitive methods.
     +
     +    When this is enabled, there is a small performance cost in the
     +    hashing algorithm. To tease out the worst possible case, the
     +    following was run on a repo with a deep directory structure:
     +
     +            git ls-tree -d -r --name-only HEAD |
     +                    git sparse-checkout set --stdin
     +
     +    The 'set' command was timed with core.ignoreCase disabled or
     +    enabled. For the repo with a deep history, the numbers were
     +
     +            core.ignoreCase=false: 62s
     +            core.ignoreCase=true:  74s (+19.3%)
     +
     +    For reproducibility, the equivalent test on the Linux kernel
     +    repository had these numbers:
     +
     +            core.ignoreCase=false: 3.1s
     +            core.ignoreCase=true:  3.6s (+16%)
     +
     +    Now, this is not an entirely fair comparison, as most users
     +    will define their sparse cone using more shallow directories,
     +    and the performance improvement from eb42feca97 ("unpack-trees:
     +    hash less in cone mode" 2019-11-21) can remove most of the
     +    hash cost. For a more realistic test, drop the "-r" from the
     +    ls-tree command to store only the first-level directories.
     +    In that case, the Linux kernel repository takes 0.2-0.25s in
     +    each case, and the deep repository takes one second, plus or
     +    minus 0.05s, in each case.
     +
     +    Thus, we _can_ demonstrate a cost to this change, but it is
     +    unlikely to matter to any reasonable sparse-checkout cone.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -39,9 +58,10 @@
       If the patterns do match the expected format, then Git will use faster hash-
       based algorithms to compute inclusion in the sparse-checkout.
       
     -+If `core.ignoreCase=true`, then the 'git sparse-checkout set' command will
     -+correct for incorrect case when assigning patterns to the sparse-checkout
     -+file.
     ++If `core.ignoreCase=true`, then the pattern-matching algorithm will use a
     ++case-insensitive check. This corrects for case mismatched filenames in the
     ++'git sparse-checkout set' command to reflect the expected cone in the working
     ++directory.
      +
       SEE ALSO
       --------
     @@ -51,71 +71,76 @@
       --- a/builtin/sparse-checkout.c
       +++ b/builtin/sparse-checkout.c
      @@
     - 	}
     - }
     + 	struct pattern_entry *e = xmalloc(sizeof(*e));
     + 	e->patternlen = path->len;
     + 	e->pattern = strbuf_detach(path, NULL);
     +-	hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));
     ++	hashmap_entry_init(&e->ent,
     ++			   ignore_case ?
     ++			   strihash(e->pattern) :
     ++			   strhash(e->pattern));
     + 
     + 	hashmap_add(&pl->recursive_hashmap, &e->ent);
       
     -+static void sanitize_cone_input(struct strbuf *line)
     -+{
     -+	if (ignore_case) {
     -+		struct index_state *istate = the_repository->index;
     -+		const char *name = index_dir_matching_name(istate, line->buf, line->len);
     -+
     -+		if (name) {
     -+			strbuf_setlen(line, 0);
     -+			strbuf_addstr(line, name);
     -+		}
     -+	}
     -+
     -+	if (line->buf[0] != '/')
     -+		strbuf_insert(line, 0, "/", 1);
     -+}
     -+
     - static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
     - {
     - 	strbuf_trim(line);
      @@
     - 	if (!line->len)
     - 		return;
     + 		e = xmalloc(sizeof(struct pattern_entry));
     + 		e->patternlen = newlen;
     + 		e->pattern = xstrndup(oldpattern, newlen);
     +-		hashmap_entry_init(&e->ent, memhash(e->pattern, e->patternlen));
     ++		hashmap_entry_init(&e->ent,
     ++				   ignore_case ?
     ++				   strihash(e->pattern) :
     ++				   strhash(e->pattern));
       
     --	if (line->buf[0] != '/')
     --		strbuf_insert(line, 0, "/", 1);
     -+	sanitize_cone_input(line);
     + 		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
     + 			hashmap_add(&pl->parent_hashmap, &e->ent);
     +
     + diff --git a/dir.c b/dir.c
     + --- a/dir.c
     + +++ b/dir.c
     +@@
     + 			 ? ee1->patternlen
     + 			 : ee2->patternlen;
       
     - 	insert_recursive_pattern(pl, line);
     ++	if (ignore_case)
     ++		return strncasecmp(ee1->pattern, ee2->pattern, min_len);
     + 	return strncmp(ee1->pattern, ee2->pattern, min_len);
       }
     -
     - diff --git a/cache.h b/cache.h
     - --- a/cache.h
     - +++ b/cache.h
     + 
      @@
     - int verify_path(const char *path, unsigned mode);
     - int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
     - int index_dir_exists(struct index_state *istate, const char *name, int namelen);
     -+const char *index_dir_matching_name(struct index_state *istate, const char *name, int namelen);
     - void adjust_dirname_case(struct index_state *istate, char *name);
     - struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
     + 		translated->pattern = truncated;
     + 		translated->patternlen = given->patternlen - 2;
     + 		hashmap_entry_init(&translated->ent,
     +-				   memhash(translated->pattern, translated->patternlen));
     ++				   ignore_case ?
     ++				   strihash(translated->pattern) :
     ++				   strhash(translated->pattern));
       
     -
     - diff --git a/name-hash.c b/name-hash.c
     - --- a/name-hash.c
     - +++ b/name-hash.c
     + 		if (!hashmap_get_entry(&pl->recursive_hashmap,
     + 				       translated, ent, NULL)) {
      @@
     - 	return dir && dir->nr;
     + 	translated->pattern = xstrdup(given->pattern);
     + 	translated->patternlen = given->patternlen;
     + 	hashmap_entry_init(&translated->ent,
     +-			   memhash(translated->pattern, translated->patternlen));
     ++			   ignore_case ?
     ++			   strihash(translated->pattern) :
     ++			   strhash(translated->pattern));
     + 
     + 	hashmap_add(&pl->recursive_hashmap, &translated->ent);
     + 
     +@@
     + 	/* Check straight mapping */
     + 	p.pattern = pattern->buf;
     + 	p.patternlen = pattern->len;
     +-	hashmap_entry_init(&p.ent, memhash(p.pattern, p.patternlen));
     ++	hashmap_entry_init(&p.ent,
     ++			   ignore_case ?
     ++			   strihash(p.pattern) :
     ++			   strhash(p.pattern));
     + 	return !!hashmap_get_entry(map, &p, ent, NULL);
       }
       
     -+const char *index_dir_matching_name(struct index_state *istate, const char *name, int namelen)
     -+{
     -+	struct dir_entry *dir;
     -+
     -+	lazy_init_name_hash(istate);
     -+	dir = find_dir_entry(istate, name, namelen);
     -+
     -+	return dir ? dir->name : NULL;
     -+}
     -+
     - void adjust_dirname_case(struct index_state *istate, char *name)
     - {
     - 	const char *startPtr = name;
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
     @@ -125,16 +150,20 @@
       '
       
      +test_expect_success 'cone mode: set with core.ignoreCase=true' '
     -+	test_when_finished git -C repo config --unset core.ignoreCase &&
      +	git -C repo sparse-checkout init --cone &&
     -+	git -C repo config core.ignoreCase true &&
     -+	git -C repo sparse-checkout set Folder1 &&
     ++	git -C repo -c core.ignoreCase=true sparse-checkout set folder1 &&
      +	cat >expect <<-EOF &&
      +		/*
      +		!/*/
      +		/folder1/
      +	EOF
     -+	test_cmp expect repo/.git/info/sparse-checkout
     ++	test_cmp expect repo/.git/info/sparse-checkout &&
     ++	ls repo >dir &&
     ++	cat >expect <<-EOF &&
     ++		a
     ++		folder1
     ++	EOF
     ++	test_cmp expect dir
      +'
      +
       test_done

-- 
gitgitgadget
