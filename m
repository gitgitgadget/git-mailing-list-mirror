Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7971AC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBAD22268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfDoZnTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgKBSz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKBSzU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:20 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1694C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:18 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c18so10441335wme.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d8ltJtEE36EpePnJV3RFDVNCFa7TbkPO5WUq7f0vinY=;
        b=vfDoZnTGPiqHj0S8pr36UDKxYdRqwEndqy2xL5bbFnPG5SsNYGluIUObULVrwTKNj1
         4Iu3WoLTIoub+S+1nKQpvWLPW0n6mck3DdmeoOv+l2qVt5lQCzcKnXzJZNy2ZhHJeId8
         5d9lWLUtuGLA3+bEoC++/59YK7qzUbgqQG7K8ebJ4+vA6fsiSxep1T2hoh64EOJt0o35
         1z4QetWyf3vbI7dD8hHsvgN+M97TSadjdts7qBstnzn2cJqyehkvKLZv59ce3QpQhs0C
         5iPmMVkgpzcASWlrsQ3ZWwZzRjMtyEiaWk7b5nAe7F/TTXpzWOm3IjTQ1Iv6VdBEvR5w
         cx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d8ltJtEE36EpePnJV3RFDVNCFa7TbkPO5WUq7f0vinY=;
        b=YhhVhOW++MfTEZNzKHTmJ/eViVE98+wuq+4zEYH/w3W/EsE+TxhhoQV2q/9s5xsW6o
         zEut2pH8uh6x8kA4g7ZtFGQ3WDgZ4CWPh3ivSHRjnBJBwYYeko6UXRAA939LvwaWHTcO
         ZyliwXXZIOKNvtFNQkddym3ugJnvABW8IfgTu1z4+dOlMMeD+9xCqveveEp1Rq3vcRfz
         VpemRohSANbk+Ti9TrSdlHTx3Hja0fP+lXYTu8nGFsoqPpRLrLjyaz5ozrJJUqdvkhrv
         wUc6U7Y0TSWcU0aKK4M8ea/md2Uqg0RuTzWLtew2osBt4laksD8q3U8XQQt6M3b7E43N
         qu9Q==
X-Gm-Message-State: AOAM531VMTccHO9wblPcpm+xGQOHJTLGRG1TJcidLuqHo0nTIr76zdsC
        AwNcmfBH13v5yvrA1epQ793uvoqOvAE=
X-Google-Smtp-Source: ABdhPJzdUztaArPC+BCqGKtutsFKxVbd6Y3IsyC7w6wqc3++5FRlYd4i+pDNwnVU59VVo7rfG7Dn5A==
X-Received: by 2002:a1c:4306:: with SMTP id q6mr20307566wma.189.1604343315756;
        Mon, 02 Nov 2020 10:55:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w1sm12997552wro.44.2020.11.02.10.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:15 -0800 (PST)
Message-Id: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:00 +0000
Subject: [PATCH v3 00/13] Add struct strmap and associated utility functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here I introduce a new strmap type (and strintmap and strset), which my new
merge backed, merge-ort, uses heavily. (I also made significant use of it in
my changes to diffcore-rename). This strmap type was based on Peff's
proposal from a couple years ago[1], but has additions that I made as I used
it, and a number of additions/changes suggested by Peff in his reviews. I
also start the series off with some changes to hashmap, based on Peff's
feedback on v1 & v2.

NOTE: My "fundamentals of merge-ort implementation"[2] that depends on this
series needs to be updated due to these changes. I'll send a reroll for it
soon.

Changes since v2 (almost all of which were suggestions from Peff):

 * Added HASHMAP_INIT() and STR*_INIT() macros (and added a patch converting
   some existing callsites to use them)
 * Introduced the improved hashmap deallocation function names that Peff
   suggested and updated the codebase (currently merges cleanly with seen,
   though there's always a risk someone else is introducing a new one, but
   it's at least clean right now)
 * Renamed free_util -> free_values, everywhere this time
 * Renamed strmap_ocd_init() -> strmap_init_with_options(). Similar for the
   other str* subtypes.
 * Implemented strmap_empty() on top of strmap_get_size() instead of
   hashmap_get_size()
 * Avoided the OFFSETOF_VAR initialization-on-windows concerns by just not
   using the macro; for strmap_entry, the offset is always 0
 * Stored the default_value for a strintmap in the strintmap rather than
   requiring it at every call to strintmap_get(). Updated strintmap_incr()
   to make use of it as well.
 * Add a strset_check_and_add() function to the API
 * Added an extra patch at the end to take advantage of FLEXPTR_ALLOC_STR in
   the default case to avoid an extra allocation and free.
 * Tweaked some commit messages, fixed a few more argument-alignment issues,
   removed a bad comment

Things that I'm still unsure about:

 * strintmap_init() takes a default_value parameter, as suggested by Peff.
   But this makes the function name strintmap_init_with_options() weird,
   because strintmap_init() already takes one option, so it seems like the
   name needs to replace "options" with "more_options". But that's kinda
   ugly too. I'm guessing strintmap_init_with_options() is fine as-is, but
   I'm wondering if anyone else thinks it looks weird and if so if there is
   anything I should do about it.

Things Peff mentioned on v2 that I did NOT do:

 * Peff brought up some questions about mapping strintmap to an int rather
   than an unsigned or intptr_t. I discussed my rationale in the thread

Things Peff mentioned on v1 that are still not included and which Peff
didn't comment on for v2, but which may still be worth mentioning again:

 * Peff brought up the idea of having a free_values member instead of having
   a free_values parameter to strmap_clear(). That'd just mean moving the
   parameter from strmap_clear() to strmap_init() and would be easy to do,
   but he sounded like he was just throwing it out as an idea and I didn't
   have a strong opinion, so I left it as-is. If others have
   opinions/preferences, changing it is easy right now.
 * Peff early on wanted the strmap_entry type to have a char key[FLEX_ALLOC]
   instead of having a (const) char *key. I spent a couple more days on this
   despite him not mentioning it while reviewing v2, and finally got it
   working this time and running valgrind-free. Note that such a change
   means always copying the key instead of allowing it as an option. After
   implementing it, I timed it and it slowed down my important testcase by
   just over 6%. So I chucked it. I think the FLEXPTR_ALLOC_STR usage in
   combination with defaulting to strdup_strings=1 gives us most the
   benefits Peff wanted, while still allowing merge-ort to reuse strings
   when it's important.

[1] 
https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/[2] 
https://lore.kernel.org/git/CABPp-BHKGkx04neULtYUyfiU+z-X7_rxQqriSEjxZjU1oXokOA@mail.gmail.com/T/#t
[3] 
https://lore.kernel.org/git/CABPp-BFyqTthyBmp5yt+iUniwTi+=y2QcBcmNnnCy=zvyi3Rbw@mail.gmail.com/

Elijah Newren (13):
  hashmap: add usage documentation explaining hashmap_free[_entries]()
  hashmap: adjust spacing to fix argument alignment
  hashmap: allow re-use after hashmap_free()
  hashmap: introduce a new hashmap_partial_clear()
  hashmap: provide deallocation function names
  strmap: new utility functions
  strmap: add more utility functions
  strmap: enable faster clearing and reusing of strmaps
  strmap: add functions facilitating use as a string->int map
  strmap: add a strset sub-type
  strmap: enable allocations to come from a mem_pool
  strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
  Use new HASHMAP_INIT macro to simplify hashmap initialization

 Makefile                |   1 +
 add-interactive.c       |   2 +-
 attr.c                  |  26 ++--
 blame.c                 |   2 +-
 bloom.c                 |   5 +-
 builtin/difftool.c      |   9 +-
 builtin/fetch.c         |   6 +-
 builtin/shortlog.c      |   2 +-
 config.c                |   2 +-
 diff.c                  |   4 +-
 diffcore-rename.c       |   2 +-
 dir.c                   |   8 +-
 hashmap.c               |  74 +++++++----
 hashmap.h               |  91 ++++++++++---
 merge-recursive.c       |   6 +-
 name-hash.c             |   4 +-
 object.c                |   2 +-
 oidmap.c                |   2 +-
 patch-ids.c             |   2 +-
 range-diff.c            |   6 +-
 ref-filter.c            |   2 +-
 revision.c              |  11 +-
 sequencer.c             |   4 +-
 strmap.c                | 158 +++++++++++++++++++++++
 strmap.h                | 280 ++++++++++++++++++++++++++++++++++++++++
 submodule-config.c      |   4 +-
 t/helper/test-hashmap.c |   9 +-
 27 files changed, 610 insertions(+), 114 deletions(-)
 create mode 100644 strmap.c
 create mode 100644 strmap.h


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-835%2Fnewren%2Fstrmap-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-835/newren/strmap-v3
Pull-Request: https://github.com/git/git/pull/835

Range-diff vs v2:

  1:  af6b6fcb46 =  1:  af6b6fcb46 hashmap: add usage documentation explaining hashmap_free[_entries]()
  2:  75f17619e9 !  2:  591161fd78 hashmap: adjust spacing to fix argument alignment
     @@ hashmap.c: struct hashmap_entry *hashmap_remove(struct hashmap *map,
       {
       	struct hashmap_entry *old = hashmap_remove(map, entry, NULL);
       	hashmap_add(map, entry);
     +
     + ## hashmap.h ##
     +@@ hashmap.h: struct hashmap {
     +  * prevent expensive resizing. If 0, the table is dynamically resized.
     +  */
     + void hashmap_init(struct hashmap *map,
     +-			 hashmap_cmp_fn equals_function,
     +-			 const void *equals_function_data,
     +-			 size_t initial_size);
     ++		  hashmap_cmp_fn equals_function,
     ++		  const void *equals_function_data,
     ++		  size_t initial_size);
     + 
     + /* internal function for freeing hashmap */
     + void hashmap_free_(struct hashmap *map, ssize_t offset);
     +@@ hashmap.h: void hashmap_free_(struct hashmap *map, ssize_t offset);
     +  * and if it is on stack, you can just let it go out of scope).
     +  */
     + static inline void hashmap_entry_init(struct hashmap_entry *e,
     +-					unsigned int hash)
     ++				      unsigned int hash)
     + {
     + 	e->hash = hash;
     + 	e->next = NULL;
     +@@ hashmap.h: static inline unsigned int hashmap_get_size(struct hashmap *map)
     +  * to `hashmap_cmp_fn` to decide whether the entry matches the key.
     +  */
     + struct hashmap_entry *hashmap_get(const struct hashmap *map,
     +-				const struct hashmap_entry *key,
     +-				const void *keydata);
     ++				  const struct hashmap_entry *key,
     ++				  const void *keydata);
     + 
     + /*
     +  * Returns the hashmap entry for the specified hash code and key data,
     +@@ hashmap.h: static inline struct hashmap_entry *hashmap_get_from_hash(
     +  * call to `hashmap_get` or `hashmap_get_next`.
     +  */
     + struct hashmap_entry *hashmap_get_next(const struct hashmap *map,
     +-			const struct hashmap_entry *entry);
     ++				       const struct hashmap_entry *entry);
     + 
     + /*
     +  * Adds a hashmap entry. This allows to add duplicate entries (i.e.
     +@@ hashmap.h: void hashmap_add(struct hashmap *map, struct hashmap_entry *entry);
     +  * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
     +  */
     + struct hashmap_entry *hashmap_put(struct hashmap *map,
     +-				struct hashmap_entry *entry);
     ++				  struct hashmap_entry *entry);
     + 
     + /*
     +  * Adds or replaces a hashmap entry contained within @keyvar,
     +@@ hashmap.h: struct hashmap_entry *hashmap_put(struct hashmap *map,
     +  * Argument explanation is the same as in `hashmap_get`.
     +  */
     + struct hashmap_entry *hashmap_remove(struct hashmap *map,
     +-					const struct hashmap_entry *key,
     +-					const void *keydata);
     ++				     const struct hashmap_entry *key,
     ++				     const void *keydata);
     + 
     + /*
     +  * Removes a hashmap entry contained within @keyvar,
     +@@ hashmap.h: struct hashmap_entry *hashmap_iter_next(struct hashmap_iter *iter);
     + 
     + /* Initializes the iterator and returns the first entry, if any. */
     + static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
     +-		struct hashmap_iter *iter)
     ++						       struct hashmap_iter *iter)
     + {
     + 	hashmap_iter_init(map, iter);
     + 	return hashmap_iter_next(iter);
  3:  a686d0758a !  3:  f2718d036d hashmap: allow re-use after hashmap_free()
     @@ Commit message
          Modify these functions to check for a NULL table and automatically
          allocate as needed.
      
     -    I also thought about creating a HASHMAP_INIT macro to allow initializing
     -    hashmaps on the stack without calling hashmap_init(), but virtually all
     -    uses of hashmap specify a usecase-specific equals_function which defeats
     -    the utility of such a macro.
     +    Also add a HASHMAP_INIT(fn, data) macro for initializing hashmaps on the
     +    stack without calling hashmap_init().
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ hashmap.c: struct hashmap_entry *hashmap_remove(struct hashmap *map,
       	if (!*e)
       		return NULL;
       
     +
     + ## hashmap.h ##
     +@@ hashmap.h: struct hashmap {
     + 
     + /* hashmap functions */
     + 
     ++#define HASHMAP_INIT(fn, data) { .cmpfn = fn, .cmpfn_data = data, \
     ++				 .do_count_items = 1 }
     ++
     + /*
     +  * Initializes a hashmap structure.
     +  *
  4:  061ab45a9b !  4:  61f1da3c51 hashmap: introduce a new hashmap_partial_clear()
     @@ Commit message
          hashmap: introduce a new hashmap_partial_clear()
      
          merge-ort is a heavy user of strmaps, which are built on hashmap.[ch].
     -    reset_maps() in merge-ort was taking about 12% of overall runtime in my
     -    testcase involving rebasing 35 patches of linux.git across a big rename.
     -    reset_maps() was calling hashmap_free() followed by hashmap_init(),
     -    meaning that not only was it freeing all the memory associated with each
     -    of the strmaps just to immediately allocate a new array again, it was
     -    allocating a new array that wasy likely smaller than needed (thus
     -    resulting in later need to rehash things).  The ending size of the map
     -    table on the previous commit was likely almost perfectly sized for the
     -    next commit we wanted to pick, and not dropping and reallocating the
     -    table immediately is a win.
     +    clear_or_reinit_internal_opts() in merge-ort was taking about 12% of
     +    overall runtime in my testcase involving rebasing 35 patches of
     +    linux.git across a big rename.  clear_or_reinit_internal_opts() was
     +    calling hashmap_free() followed by hashmap_init(), meaning that not only
     +    was it freeing all the memory associated with each of the strmaps just
     +    to immediately allocate a new array again, it was allocating a new array
     +    that was likely smaller than needed (thus resulting in later need to
     +    rehash things).  The ending size of the map table on the previous commit
     +    was likely almost perfectly sized for the next commit we wanted to pick,
     +    and not dropping and reallocating the table immediately is a win.
      
          Add some new API to hashmap to clear a hashmap of entries without
          freeing map->table (and instead only zeroing it out like alloc_table()
     @@ hashmap.c: void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function
      
       ## hashmap.h ##
      @@ hashmap.h: void hashmap_init(struct hashmap *map,
     - 			 const void *equals_function_data,
     - 			 size_t initial_size);
     + 		  const void *equals_function_data,
     + 		  size_t initial_size);
       
      -/* internal function for freeing hashmap */
      +/* internal functions for clearing or freeing hashmap */
  -:  ---------- >  5:  861e8d65ae hashmap: provide deallocation function names
  5:  5c7507f55b !  6:  448d3b219f strmap: new utility functions
     @@ Commit message
          taken directly from Peff's proposal at
          https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/
      
     -    A couple of items of note:
     -
     -      * Similar to string-list, I have a strdup_strings setting.  However,
     -        unlike string-list, strmap_init() does not take a parameter for this
     -        setting and instead automatically sets it to 1; callers who want to
     -        control this detail need to instead call strmap_ocd_init().
     -
     -      * I do not have a STRMAP_INIT macro.  I could possibly add one, but
     -          #define STRMAP_INIT { { NULL, cmp_str_entry, NULL, 0, 0, 0, 0, 0 }, 1 }
     -        feels a bit unwieldy and possibly error-prone in terms of future
     -        expansion of the hashmap struct.  The fact that cmp_str_entry needs to
     -        be in there prevents us from passing all zeros for the hashmap, and makes
     -        me worry that STRMAP_INIT would just be more trouble than it is worth.
     +    Note that similar string-list, I have a strdup_strings setting.
     +    However, unlike string-list, strmap_init() does not take a parameter for
     +    this setting and instead automatically sets it to 1; callers who want to
     +    control this detail need to instead call strmap_init_with_options().
     +    (Future patches will add additional parameters to
     +    strmap_init_with_options()).
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ strmap.c (new)
      +#include "git-compat-util.h"
      +#include "strmap.h"
      +
     -+static int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
     -+			    const struct hashmap_entry *entry1,
     -+			    const struct hashmap_entry *entry2,
     -+			    const void *keydata)
     ++int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
     ++		     const struct hashmap_entry *entry1,
     ++		     const struct hashmap_entry *entry2,
     ++		     const void *keydata)
      +{
      +	const struct strmap_entry *e1, *e2;
      +
     @@ strmap.c (new)
      +
      +void strmap_init(struct strmap *map)
      +{
     -+	strmap_ocd_init(map, 1);
     ++	strmap_init_with_options(map, 1);
      +}
      +
     -+void strmap_ocd_init(struct strmap *map,
     -+		     int strdup_strings)
     ++void strmap_init_with_options(struct strmap *map,
     ++			      int strdup_strings)
      +{
      +	hashmap_init(&map->map, cmp_strmap_entry, NULL, 0);
      +	map->strdup_strings = strdup_strings;
      +}
      +
     -+static void strmap_free_entries_(struct strmap *map, int free_util)
     ++static void strmap_free_entries_(struct strmap *map, int free_values)
      +{
      +	struct hashmap_iter iter;
      +	struct strmap_entry *e;
     @@ strmap.c (new)
      +	 * to make some call into the hashmap API to do that.
      +	 */
      +	hashmap_for_each_entry(&map->map, &iter, e, ent) {
     -+		if (free_util)
     ++		if (free_values)
      +			free(e->value);
      +		if (map->strdup_strings)
      +			free((char*)e->key);
     @@ strmap.c (new)
      +	}
      +}
      +
     -+void strmap_clear(struct strmap *map, int free_util)
     ++void strmap_clear(struct strmap *map, int free_values)
      +{
     -+	strmap_free_entries_(map, free_util);
     -+	hashmap_free(&map->map);
     ++	strmap_free_entries_(map, free_values);
     ++	hashmap_clear(&map->map);
      +}
      +
      +void *strmap_put(struct strmap *map, const char *str, void *data)
     @@ strmap.c (new)
      +		old = entry->value;
      +		entry->value = data;
      +	} else {
     -+		/*
     -+		 * We won't modify entry->key so it really should be const.
     -+		 */
      +		const char *key = str;
      +
      +		entry = xmalloc(sizeof(*entry));
     @@ strmap.h (new)
      +	void *value;
      +};
      +
     ++int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
     ++		     const struct hashmap_entry *entry1,
     ++		     const struct hashmap_entry *entry2,
     ++		     const void *keydata);
     ++
     ++#define STRMAP_INIT { \
     ++			.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
     ++			.strdup_strings = 1,                          \
     ++		    }
     ++
      +/*
      + * Initialize the members of the strmap.  Any keys added to the strmap will
      + * be strdup'ed with their memory managed by the strmap.
     @@ strmap.h (new)
      +/*
      + * Same as strmap_init, but for those who want to control the memory management
      + * carefully instead of using the default of strdup_strings=1.
     -+ * (OCD = Obsessive Compulsive Disorder, a joke that those who use this function
     -+ * are obsessing over minor details.)
      + */
     -+void strmap_ocd_init(struct strmap *map,
     -+		     int strdup_strings);
     ++void strmap_init_with_options(struct strmap *map,
     ++			      int strdup_strings);
      +
      +/*
      + * Remove all entries from the map, releasing any allocated resources.
  6:  61b5bf1110 !  7:  42633b8d03 strmap: add more utility functions
     @@ Commit message
          strmap: add more utility functions
      
          This adds a number of additional convienence functions I want/need:
     -      * strmap_empty()
            * strmap_get_size()
     +      * strmap_empty()
            * strmap_remove()
            * strmap_for_each_entry()
            * strmap_get_entry()
     @@ strmap.c: int strmap_contains(struct strmap *map, const char *str)
       	return find_strmap_entry(map, str) != NULL;
       }
      +
     -+void strmap_remove(struct strmap *map, const char *str, int free_util)
     ++void strmap_remove(struct strmap *map, const char *str, int free_value)
      +{
      +	struct strmap_entry entry, *ret;
      +	hashmap_entry_init(&entry.ent, strhash(str));
     @@ strmap.c: int strmap_contains(struct strmap *map, const char *str)
      +	ret = hashmap_remove_entry(&map->map, &entry, ent, NULL);
      +	if (!ret)
      +		return;
     -+	if (free_util)
     ++	if (free_value)
      +		free(ret->value);
      +	if (map->strdup_strings)
      +		free((char*)ret->key);
     @@ strmap.h: void *strmap_get(struct strmap *map, const char *str);
      +void strmap_remove(struct strmap *map, const char *str, int free_value);
      +
      +/*
     -+ * Return whether the strmap is empty.
     ++ * Return how many entries the strmap has.
      + */
     -+static inline int strmap_empty(struct strmap *map)
     ++static inline unsigned int strmap_get_size(struct strmap *map)
      +{
     -+	return hashmap_get_size(&map->map) == 0;
     ++	return hashmap_get_size(&map->map);
      +}
      +
      +/*
     -+ * Return how many entries the strmap has.
     ++ * Return whether the strmap is empty.
      + */
     -+static inline unsigned int strmap_get_size(struct strmap *map)
     ++static inline int strmap_empty(struct strmap *map)
      +{
     -+	return hashmap_get_size(&map->map);
     ++	return strmap_get_size(map) == 0;
      +}
      +
      +/*
      + * iterate through @map using @iter, @var is a pointer to a type strmap_entry
      + */
      +#define strmap_for_each_entry(mystrmap, iter, var)	\
     -+	for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, \
     -+						   OFFSETOF_VAR(var, ent)); \
     ++	for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, 0); \
      +		var; \
     -+		var = hashmap_iter_next_entry_offset(iter, \
     -+						     OFFSETOF_VAR(var, ent)))
     ++		var = hashmap_iter_next_entry_offset(iter, 0))
      +
       #endif /* STRMAP_H */
  7:  2ebce0c5d8 !  8:  ea942eb803 strmap: enable faster clearing and reusing of strmaps
     @@ Commit message
          Introduce strmap_partial_clear() to take advantage of this type of
          situation; it will act similar to strmap_clear() except that
          map->table's entries are zeroed instead of map->table being free'd.
     -    Making use of this function reduced the cost of reset_maps() by about
     -    20% in mert-ort, and dropped the overall runtime of my rebase testcase
     -    by just under 2%.
     +    Making use of this function reduced the cost of
     +    clear_or_reinit_internal_opts() by about 20% in mert-ort, and dropped
     +    the overall runtime of my rebase testcase by just under 2%.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## strmap.c ##
     -@@ strmap.c: void strmap_clear(struct strmap *map, int free_util)
     - 	hashmap_free(&map->map);
     +@@ strmap.c: void strmap_clear(struct strmap *map, int free_values)
     + 	hashmap_clear(&map->map);
       }
       
     -+void strmap_partial_clear(struct strmap *map, int free_util)
     ++void strmap_partial_clear(struct strmap *map, int free_values)
      +{
     -+	strmap_free_entries_(map, free_util);
     ++	strmap_free_entries_(map, free_values);
      +	hashmap_partial_clear(&map->map);
      +}
      +
     @@ strmap.c: void strmap_clear(struct strmap *map, int free_util)
       	struct strmap_entry *entry = find_strmap_entry(map, str);
      
       ## strmap.h ##
     -@@ strmap.h: void strmap_ocd_init(struct strmap *map,
     +@@ strmap.h: void strmap_init_with_options(struct strmap *map,
        */
       void strmap_clear(struct strmap *map, int free_values);
       
  8:  cc8d702f98 !  9:  c1d2172171 strmap: add functions facilitating use as a string->int map
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## strmap.c ##
     -@@ strmap.c: void strmap_remove(struct strmap *map, const char *str, int free_util)
     +@@ strmap.c: void strmap_remove(struct strmap *map, const char *str, int free_value)
       		free((char*)ret->key);
       	free(ret);
       }
     @@ strmap.c: void strmap_remove(struct strmap *map, const char *str, int free_util)
      +		*whence += amt;
      +	}
      +	else
     -+		strintmap_set(map, str, amt);
     ++		strintmap_set(map, str, map->default_value + amt);
      +}
      
       ## strmap.h ##
     -@@ strmap.h: static inline unsigned int strmap_get_size(struct strmap *map)
     - 		var = hashmap_iter_next_entry_offset(iter, \
     - 						     OFFSETOF_VAR(var, ent)))
     +@@ strmap.h: int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
     + 			.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
     + 			.strdup_strings = 1,                          \
     + 		    }
     ++#define STRINTMAP_INIT { \
     ++			.map.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
     ++			.map.strdup_strings = 1,                          \
     ++			.default_value = 0,                               \
     ++		    }
     + 
     + /*
     +  * Initialize the members of the strmap.  Any keys added to the strmap will
     +@@ strmap.h: static inline int strmap_empty(struct strmap *map)
     + 		var; \
     + 		var = hashmap_iter_next_entry_offset(iter, 0))
       
      +
      +/*
     @@ strmap.h: static inline unsigned int strmap_get_size(struct strmap *map)
      +
      +struct strintmap {
      +	struct strmap map;
     ++	int default_value;
      +};
      +
      +#define strintmap_for_each_entry(mystrmap, iter, var)	\
      +	strmap_for_each_entry(&(mystrmap)->map, iter, var)
      +
     -+static inline void strintmap_init(struct strintmap *map)
     ++static inline void strintmap_init(struct strintmap *map, int default_value)
      +{
      +	strmap_init(&map->map);
     ++	map->default_value = default_value;
      +}
      +
     -+static inline void strintmap_ocd_init(struct strintmap *map,
     -+				      int strdup_strings)
     ++static inline void strintmap_init_with_options(struct strintmap *map,
     ++					       int default_value,
     ++					       int strdup_strings)
      +{
     -+	strmap_ocd_init(&map->map, strdup_strings);
     ++	strmap_init_with_options(&map->map, strdup_strings);
     ++	map->default_value = default_value;
      +}
      +
      +static inline void strintmap_clear(struct strintmap *map)
     @@ strmap.h: static inline unsigned int strmap_get_size(struct strmap *map)
      +	return strmap_get_size(&map->map);
      +}
      +
     -+static inline int strintmap_get(struct strintmap *map, const char *str,
     -+				int default_value)
     ++/*
     ++ * Returns the value for str in the map.  If str isn't found in the map,
     ++ * the map's default_value is returned.
     ++ */
     ++static inline int strintmap_get(struct strintmap *map, const char *str)
      +{
      +	struct strmap_entry *result = strmap_get_entry(&map->map, str);
      +	if (!result)
     -+		return default_value;
     ++		return map->default_value;
      +	return (intptr_t)result->value;
      +}
      +
     @@ strmap.h: static inline unsigned int strmap_get_size(struct strmap *map)
      +	strmap_put(&map->map, str, (void *)v);
      +}
      +
     ++/*
     ++ * Increment the value for str by amt.  If str isn't in the map, add it and
     ++ * set its value to default_value + amt.
     ++ */
      +void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt);
      +
       #endif /* STRMAP_H */
  9:  490d3a42ad ! 10:  0f57735f5e strmap: add a strset sub-type
     @@ Commit message
      
          The difference in usage also results in some differences in API: a few
          things that aren't necessary or meaningful are dropped (namely, the
     -    free_util argument to *_clear(), and the *_get() function), and
     +    free_values argument to *_clear(), and the *_get() function), and
          strset_add() is chosen as the API instead of strset_put().
      
     +    Finally, shortlog already had a more minimal strset API; so this adds a
     +    strset_check_and_add() function for its benefit to allow it to switch
     +    over to this strset implementation.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## strmap.c ##
     +@@ strmap.c: void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
     + 	else
     + 		strintmap_set(map, str, map->default_value + amt);
     + }
     ++
     ++int strset_check_and_add(struct strset *set, const char *str)
     ++{
     ++	if (strset_contains(set, str))
     ++		return 1;
     ++	strset_add(set, str);
     ++	return 0;
     ++}
     +
       ## strmap.h ##
     -@@ strmap.h: static inline void strintmap_set(struct strintmap *map, const char *str,
     +@@ strmap.h: int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
     + 			.map.strdup_strings = 1,                          \
     + 			.default_value = 0,                               \
     + 		    }
     ++#define STRSET_INIT { \
     ++			.map.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
     ++			.map.strdup_strings = 1,                          \
     ++		    }
       
     + /*
     +  * Initialize the members of the strmap.  Any keys added to the strmap will
     +@@ strmap.h: static inline void strintmap_set(struct strintmap *map, const char *str,
     +  */
       void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt);
       
      +/*
     @@ strmap.h: static inline void strintmap_set(struct strintmap *map, const char *st
      +	strmap_init(&set->map);
      +}
      +
     -+static inline void strset_ocd_init(struct strset *set,
     -+				   int strdup_strings)
     ++static inline void strset_init_with_options(struct strset *set,
     ++					    int strdup_strings)
      +{
     -+	strmap_ocd_init(&set->map, strdup_strings);
     ++	strmap_init_with_options(&set->map, strdup_strings);
      +}
      +
      +static inline void strset_clear(struct strset *set)
     @@ strmap.h: static inline void strintmap_set(struct strintmap *map, const char *st
      +{
      +	strmap_put(&set->map, str, NULL);
      +}
     ++
     ++/* Returns 1 if str already in set.  Otherwise adds str to set and returns 0 */
     ++int strset_check_and_add(struct strset *set, const char *str);
      +
       #endif /* STRMAP_H */
 10:  eca4f1ddba ! 11:  980537e877 strmap: enable allocations to come from a mem_pool
     @@ Commit message
      
          For heavy users of strmaps, allowing the keys and entries to be
          allocated from a memory pool can provide significant overhead savings.
     -    Add an option to strmap_ocd_init() to specify a memory pool.
     +    Add an option to strmap_init_with_options() to specify a memory pool.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ strmap.c
       #include "strmap.h"
      +#include "mem-pool.h"
       
     - static int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
     - 			    const struct hashmap_entry *entry1,
     + int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
     + 		     const struct hashmap_entry *entry1,
      @@ strmap.c: static struct strmap_entry *find_strmap_entry(struct strmap *map,
       
       void strmap_init(struct strmap *map)
       {
     --	strmap_ocd_init(map, 1);
     -+	strmap_ocd_init(map, NULL, 1);
     +-	strmap_init_with_options(map, 1);
     ++	strmap_init_with_options(map, NULL, 1);
       }
       
     - void strmap_ocd_init(struct strmap *map,
     -+		     struct mem_pool *pool,
     - 		     int strdup_strings)
     + void strmap_init_with_options(struct strmap *map,
     ++			      struct mem_pool *pool,
     + 			      int strdup_strings)
       {
       	hashmap_init(&map->map, cmp_strmap_entry, NULL, 0);
      +	map->pool = pool;
       	map->strdup_strings = strdup_strings;
       }
       
     -@@ strmap.c: static void strmap_free_entries_(struct strmap *map, int free_util)
     +@@ strmap.c: static void strmap_free_entries_(struct strmap *map, int free_values)
       	if (!map)
       		return;
       
     -+	if (!free_util && map->pool)
     ++	if (!free_values && map->pool)
      +		/* Memory other than util is owned by and freed with the pool */
      +		return;
      +
       	/*
       	 * We need to iterate over the hashmap entries and free
       	 * e->key and e->value ourselves; hashmap has no API to
     -@@ strmap.c: static void strmap_free_entries_(struct strmap *map, int free_util)
     +@@ strmap.c: static void strmap_free_entries_(struct strmap *map, int free_values)
       	hashmap_for_each_entry(&map->map, &iter, e, ent) {
     - 		if (free_util)
     + 		if (free_values)
       			free(e->value);
      -		if (map->strdup_strings)
      -			free((char*)e->key);
     @@ strmap.c: static void strmap_free_entries_(struct strmap *map, int free_util)
       }
       
      @@ strmap.c: void *strmap_put(struct strmap *map, const char *str, void *data)
     - 		 */
     + 	} else {
       		const char *key = str;
       
      -		entry = xmalloc(sizeof(*entry));
     @@ strmap.c: void *strmap_put(struct strmap *map, const char *str, void *data)
       		entry->key = key;
       		entry->value = data;
       		hashmap_add(&map->map, &entry->ent);
     -@@ strmap.c: void strmap_remove(struct strmap *map, const char *str, int free_util)
     +@@ strmap.c: void strmap_remove(struct strmap *map, const char *str, int free_value)
       		return;
     - 	if (free_util)
     + 	if (free_value)
       		free(ret->value);
      -	if (map->strdup_strings)
      -		free((char*)ret->key);
     @@ strmap.h: void strmap_init(struct strmap *map);
        * Same as strmap_init, but for those who want to control the memory management
      - * carefully instead of using the default of strdup_strings=1.
      + * carefully instead of using the default of strdup_strings=1 and pool=NULL.
     -  * (OCD = Obsessive Compulsive Disorder, a joke that those who use this function
     -  * are obsessing over minor details.)
        */
     - void strmap_ocd_init(struct strmap *map,
     -+		     struct mem_pool *pool,
     - 		     int strdup_strings);
     + void strmap_init_with_options(struct strmap *map,
     ++			      struct mem_pool *pool,
     + 			      int strdup_strings);
       
       /*
     -@@ strmap.h: static inline void strintmap_init(struct strintmap *map)
     - }
     +@@ strmap.h: static inline void strintmap_init(struct strintmap *map, int default_value)
       
     - static inline void strintmap_ocd_init(struct strintmap *map,
     -+				      struct mem_pool *pool,
     - 				      int strdup_strings)
     + static inline void strintmap_init_with_options(struct strintmap *map,
     + 					       int default_value,
     ++					       struct mem_pool *pool,
     + 					       int strdup_strings)
       {
     --	strmap_ocd_init(&map->map, strdup_strings);
     -+	strmap_ocd_init(&map->map, pool, strdup_strings);
     +-	strmap_init_with_options(&map->map, strdup_strings);
     ++	strmap_init_with_options(&map->map, pool, strdup_strings);
     + 	map->default_value = default_value;
       }
       
     - static inline void strintmap_clear(struct strintmap *map)
      @@ strmap.h: static inline void strset_init(struct strset *set)
       }
       
     - static inline void strset_ocd_init(struct strset *set,
     -+				   struct mem_pool *pool,
     - 				   int strdup_strings)
     + static inline void strset_init_with_options(struct strset *set,
     ++					    struct mem_pool *pool,
     + 					    int strdup_strings)
       {
     --	strmap_ocd_init(&set->map, strdup_strings);
     -+	strmap_ocd_init(&set->map, pool, strdup_strings);
     +-	strmap_init_with_options(&set->map, strdup_strings);
     ++	strmap_init_with_options(&set->map, pool, strdup_strings);
       }
       
       static inline void strset_clear(struct strset *set)
  -:  ---------- > 12:  7f93cbb525 strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
  -:  ---------- > 13:  5f41fc63e5 Use new HASHMAP_INIT macro to simplify hashmap initialization

-- 
gitgitgadget
