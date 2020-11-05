Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF6EC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2AE20867
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB0EnImK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbgKEAYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgKEAWt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 19:22:49 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7E0C0613CF
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 16:22:49 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v5so35591wmh.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 16:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EFQG6p5I+KG50B0bEUbG9ucwNN4sD2/4eXJZZZzUrOI=;
        b=aB0EnImKZi7i3rNJ+6v4NTF3jBzgC8LDK3fU8O57mccTwHKLVn0xKRxiM5gwHst9Ed
         dc/k9iU0DqfwqdfqvM/QSkn/bg6BzM73JuU3fN8dxgVhwtD5cevqqgIKe8cZOmHlDPBQ
         EKmPPtMqtr5CgWrT9Dw15lr9zaf5gjKWoKOoxHckgKISJb9Im+C+UPf/+d3PXWUKLw13
         5E+0FZFSoZDhPFJRxoqLoRRfhQy5YpfEH0U1tPHiU7kpe3GgvBfpE+3RzI1nSlg8XEmN
         9mwToN1aGJFW5+xXrJzwFBeAySdjyVQ8koYNugCf+I8hS6Fgi751D3qEqycjf+cJfXuJ
         USgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EFQG6p5I+KG50B0bEUbG9ucwNN4sD2/4eXJZZZzUrOI=;
        b=U2iCpgkAZd5jpCNDED2ElCBxjN5tUAWQKTaBxAt6XdoV1qRJyy99LB89gXs+2ivVJU
         B+ewlE+aHNhGavId+Bd/ASVCM2c/FT8nmDdkCgBgdA/dsrjIf9G1eZAnbyrgZlVfMQ5O
         tYCgMNo/UZj0JawL8mFlHMzgG/2hNqA4G+Ck6ea635OyEz4wsxErldgdK2cXALUOvyj2
         xH203hCSxw4WTrse+XoS2Z8Rq5VMRcYLIwspmx3/KIr4xRZYbGmbtz3gTWFSnJicSS/y
         QZFUGH/BAtaa2zKC4tHAiHNOLFnalf9bDjqLviKMbWOTWf6/kK0kc61Uq6qYacaSD++n
         XeMA==
X-Gm-Message-State: AOAM5313SGrFrYua+W365bz3sbJquIj0J27PuR7CX3V1/0VZ8VjY4SBV
        tdgYolcd4JvcSr3igWdtGVVaLdZjp58=
X-Google-Smtp-Source: ABdhPJzpavDVDyBtibxmgr0t4fF/n1kzDh0XRjHtj8/Iq17Y8rNGfkhnCKQxlAHCodXuS4tpKPOGkg==
X-Received: by 2002:a1c:1f06:: with SMTP id f6mr83210wmf.108.1604535767467;
        Wed, 04 Nov 2020 16:22:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h128sm22853wme.38.2020.11.04.16.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:22:46 -0800 (PST)
Message-Id: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 00:22:32 +0000
Subject: [PATCH v4 00/13] Add struct strmap and associated utility functions
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

NOTE: While en/merge-ort-impl depends on this series, there are no changes
in v4 that affect it so en/merge-ort-impl does not need a reroll.

Changes since v3 (almost all of which were suggestions from Peff):

 * Fix pointer math due to platform differences in FLEX_ALLOC definition,
   and a few other FLEXPTR_ALLOC_STR cleanups
 * Define strmap_for_each_entry in terms of hashmap_for_each_entry instead
   of lower level functions
 * Use simpler _INIT macros
 * Remove strset_check_and_add() from API as per Peff's suggestion
   (merge-ort doesn't need it; we can add it later)
 * Update comments and commit messages to update now obsolete statements due
   to changes from earlier reviews

[1] 
https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/

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
 hashmap.h               |  91 +++++++++++---
 merge-recursive.c       |   6 +-
 name-hash.c             |   4 +-
 object.c                |   2 +-
 oidmap.c                |   2 +-
 patch-ids.c             |   2 +-
 range-diff.c            |   6 +-
 ref-filter.c            |   2 +-
 revision.c              |  11 +-
 sequencer.c             |   4 +-
 strmap.c                | 151 ++++++++++++++++++++++
 strmap.h                | 270 ++++++++++++++++++++++++++++++++++++++++
 submodule-config.c      |   4 +-
 t/helper/test-hashmap.c |   9 +-
 27 files changed, 593 insertions(+), 114 deletions(-)
 create mode 100644 strmap.c
 create mode 100644 strmap.h


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-835%2Fnewren%2Fstrmap-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-835/newren/strmap-v4
Pull-Request: https://github.com/git/git/pull/835

Range-diff vs v3:

  1:  af6b6fcb46 =  1:  af6b6fcb46 hashmap: add usage documentation explaining hashmap_free[_entries]()
  2:  591161fd78 =  2:  591161fd78 hashmap: adjust spacing to fix argument alignment
  3:  f2718d036d =  3:  f2718d036d hashmap: allow re-use after hashmap_free()
  4:  61f1da3c51 =  4:  61f1da3c51 hashmap: introduce a new hashmap_partial_clear()
  5:  861e8d65ae =  5:  861e8d65ae hashmap: provide deallocation function names
  6:  448d3b219f =  6:  448d3b219f strmap: new utility functions
  7:  42633b8d03 !  7:  5e8004c728 strmap: add more utility functions
     @@ strmap.h: void *strmap_get(struct strmap *map, const char *str);
      + * iterate through @map using @iter, @var is a pointer to a type strmap_entry
      + */
      +#define strmap_for_each_entry(mystrmap, iter, var)	\
     -+	for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, 0); \
     -+		var; \
     -+		var = hashmap_iter_next_entry_offset(iter, 0))
     ++	hashmap_for_each_entry(&(mystrmap)->map, iter, var, ent)
      +
       #endif /* STRMAP_H */
  8:  ea942eb803 =  8:  fd96e9fc8d strmap: enable faster clearing and reusing of strmaps
  9:  c1d2172171 !  9:  f499934f54 strmap: add functions facilitating use as a string->int map
     @@ Commit message
          isn't the case when we're storing an int value directly in the void*
          slot instead of using the void* slot as a pointer to data.
      
     -    A note on the name: if anyone has a better name suggestion than
     -    strintmap, I'm happy to take it.  It seems slightly unwieldy, but I have
     -    not been able to come up with a better name.
     -
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## strmap.c ##
     @@ strmap.h: int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
       			.strdup_strings = 1,                          \
       		    }
      +#define STRINTMAP_INIT { \
     -+			.map.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
     -+			.map.strdup_strings = 1,                          \
     -+			.default_value = 0,                               \
     -+		    }
     ++			.map = STRMAP_INIT,   \
     ++			.default_value = 0,   \
     ++		       }
       
       /*
        * Initialize the members of the strmap.  Any keys added to the strmap will
      @@ strmap.h: static inline int strmap_empty(struct strmap *map)
     - 		var; \
     - 		var = hashmap_iter_next_entry_offset(iter, 0))
     + #define strmap_for_each_entry(mystrmap, iter, var)	\
     + 	hashmap_for_each_entry(&(mystrmap)->map, iter, var, ent)
       
      +
      +/*
     @@ strmap.h: static inline int strmap_empty(struct strmap *map)
      + * Primary differences:
      + *    1) Since the void* value is just an int in disguise, there is no value
      + *       to free.  (Thus one fewer argument to strintmap_clear)
     -+ *    2) strintmap_get() returns an int; it also requires an extra parameter to
     -+ *       be specified so it knows what value to return if the underlying strmap
     -+ *       has not key matching the given string.
     ++ *    2) strintmap_get() returns an int, or returns the default_value if the
     ++ *       key is not found in the strintmap.
      + *    3) No strmap_put() equivalent; strintmap_set() and strintmap_incr()
      + *       instead.
      + */
 10:  0f57735f5e ! 10:  ee1ec55f1b strmap: add a strset sub-type
     @@ Commit message
          free_values argument to *_clear(), and the *_get() function), and
          strset_add() is chosen as the API instead of strset_put().
      
     -    Finally, shortlog already had a more minimal strset API; so this adds a
     -    strset_check_and_add() function for its benefit to allow it to switch
     -    over to this strset implementation.
     -
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     - ## strmap.c ##
     -@@ strmap.c: void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
     - 	else
     - 		strintmap_set(map, str, map->default_value + amt);
     - }
     -+
     -+int strset_check_and_add(struct strset *set, const char *str)
     -+{
     -+	if (strset_contains(set, str))
     -+		return 1;
     -+	strset_add(set, str);
     -+	return 0;
     -+}
     -
       ## strmap.h ##
      @@ strmap.h: int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
     - 			.map.strdup_strings = 1,                          \
     - 			.default_value = 0,                               \
     - 		    }
     -+#define STRSET_INIT { \
     -+			.map.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
     -+			.map.strdup_strings = 1,                          \
     -+		    }
     + 			.map = STRMAP_INIT,   \
     + 			.default_value = 0,   \
     + 		       }
     ++#define STRSET_INIT { .map = STRMAP_INIT }
       
       /*
        * Initialize the members of the strmap.  Any keys added to the strmap will
     @@ strmap.h: static inline void strintmap_set(struct strintmap *map, const char *st
      +{
      +	strmap_put(&set->map, str, NULL);
      +}
     -+
     -+/* Returns 1 if str already in set.  Otherwise adds str to set and returns 0 */
     -+int strset_check_and_add(struct strset *set, const char *str);
      +
       #endif /* STRMAP_H */
 11:  980537e877 = 11:  73a57045c3 strmap: enable allocations to come from a mem_pool
 12:  7f93cbb525 ! 12:  0352260de4 strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
     @@ strmap.c: static void strmap_free_entries_(struct strmap *map, int free_values)
       	}
       }
       
     -@@ strmap.c: void *strmap_put(struct strmap *map, const char *str, void *data)
     - 		old = entry->value;
     +@@ strmap.c: void strmap_partial_clear(struct strmap *map, int free_values)
     + void *strmap_put(struct strmap *map, const char *str, void *data)
     + {
     + 	struct strmap_entry *entry = find_strmap_entry(map, str);
     +-	void *old = NULL;
     + 
     + 	if (entry) {
     +-		old = entry->value;
     ++		void *old = entry->value;
       		entry->value = data;
     - 	} else {
     +-	} else {
      -		const char *key = str;
      -
      -		entry = map->pool ? mem_pool_alloc(map->pool, sizeof(*entry))
      -				  : xmalloc(sizeof(*entry));
     -+		if (map->strdup_strings) {
     -+			if (!map->pool) {
     -+				FLEXPTR_ALLOC_STR(entry, key, str);
     -+			} else {
     -+				/* Remember +1 for nul byte twice below */
     -+				size_t len = strlen(str);
     -+				entry = mem_pool_alloc(map->pool,
     -+					       st_add3(sizeof(*entry), len, 1));
     -+				memcpy(entry->keydata, str, len+1);
     -+			}
     -+		} else if (!map->pool) {
     -+			entry = xmalloc(sizeof(*entry));
     -+		} else {
     -+			entry = mem_pool_alloc(map->pool, sizeof(*entry));
     -+		}
     - 		hashmap_entry_init(&entry->ent, strhash(str));
     --
     +-		hashmap_entry_init(&entry->ent, strhash(str));
     ++		return old;
     ++	}
     + 
      -		if (map->strdup_strings)
      -			key = map->pool ? mem_pool_strdup(map->pool, str)
      -					: xstrdup(str);
      -		entry->key = key;
     -+		entry->key = map->strdup_strings ? entry->keydata : str;
     - 		entry->value = data;
     - 		hashmap_add(&map->map, &entry->ent);
     +-		entry->value = data;
     +-		hashmap_add(&map->map, &entry->ent);
     ++	if (map->strdup_strings) {
     ++		if (!map->pool) {
     ++			FLEXPTR_ALLOC_STR(entry, key, str);
     ++		} else {
     ++			size_t len = st_add(strlen(str), 1); /* include NUL */
     ++			entry = mem_pool_alloc(map->pool,
     ++					       st_add(sizeof(*entry), len));
     ++			memcpy(entry + 1, str, len);
     ++			entry->key = (void *)(entry + 1);
     ++		}
     ++	} else if (!map->pool) {
     ++		entry = xmalloc(sizeof(*entry));
     ++	} else {
     ++		entry = mem_pool_alloc(map->pool, sizeof(*entry));
       	}
     +-	return old;
     ++	hashmap_entry_init(&entry->ent, strhash(str));
     ++	if (!map->strdup_strings)
     ++		entry->key = str;
     ++	entry->value = data;
     ++	hashmap_add(&map->map, &entry->ent);
     ++	return NULL;
     + }
     + 
     + struct strmap_entry *strmap_get_entry(struct strmap *map, const char *str)
      @@ strmap.c: void strmap_remove(struct strmap *map, const char *str, int free_value)
       		return;
       	if (free_value)
     @@ strmap.h: struct strmap_entry {
       	struct hashmap_entry ent;
       	const char *key;
       	void *value;
     -+	char keydata[FLEX_ARRAY]; /* if strdup_strings=1, key == &keydata[0] */
     ++	/* strmap_entry may be allocated extra space to store the key at end */
       };
       
       int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
 13:  5f41fc63e5 = 13:  617926540b Use new HASHMAP_INIT macro to simplify hashmap initialization

-- 
gitgitgadget
