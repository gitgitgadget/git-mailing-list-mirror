Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E0CC388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26CD2078E
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV/9GJwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbgKFAZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbgKFAZC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:02 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2763CC0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:02 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p19so2177535wmg.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mh7zT7aAp7vDg7NlaBJ0gF5zCL3qIJRWG0SPQj1eJLA=;
        b=kV/9GJwtJ+qwSzI8Qz+qbecE2jRXrx72K57HGcTTlUbhHvJp6zR/t4fRG+yCNatiw5
         esHy0saL/zXE4nNuVxhmYRwmGatRuGGdgpQVUj0lwHydGcd8fCt4y8ktRgLJupVACNaS
         5pxdbsqooeP4LM8pkTPS6XhDKMOimLD1ZwZ4zBqDP2O3JmscODjPM5Ln+Qp0kmRlmyky
         wFsvPTw//BD4iq6FSot0NFLRN1/z41rcfBA8eesk9pJtFLC98r5J96p5M1NAA+xXdYOd
         +xyAwT1OtOJSo6QW82jgItxFC2gI7gxoY6GVhsorCQmkY0qwtd7segCZrT+fvGJrtsv7
         CDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mh7zT7aAp7vDg7NlaBJ0gF5zCL3qIJRWG0SPQj1eJLA=;
        b=cFaQy0Na26ayYy3ey7R82//FNhe80+T04PI/0tpGBgFXfygM9EOAYWtZLhRgXStO5E
         U/NnsRkFD3HlTVn1sDrijYXKV5ZA1RvJeCh0i+A/GpxkJES1jQTPUqDKqzlmbi2iJv4e
         /2XUmFkfeADsNfs0ZHV9aPbHckpeDWS0+UQi3iesSJDW/TWkGaH2YGfac0DmTBuaER0/
         0R897tmwOpxIwf555/N4iR64mIA0oh0pTjZNioVVo6Cc6dOdys1BOqOSw/s6I75pqxtR
         mbRQ9qCxDEqzVsfxkCX77PJOc8ZUuIMIetxnqnDluJsj/W2wykNNDGVhlWZIIX5bO2CN
         enCA==
X-Gm-Message-State: AOAM53377NQuupa3YU/dc09QpXavae68IumHT3hxu1PHWNXRgD1+uxqS
        02viUJP1CpgaOHJEb4us42ugeIxh6yw=
X-Google-Smtp-Source: ABdhPJyfa4qlThHoTDKRl8GFu38EV8nQkMxD9ambT2iZJwx40pHEKDgxkzllELE+3C/6p8LntYRguA==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr5131732wml.174.1604622300388;
        Thu, 05 Nov 2020 16:25:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a128sm5064433wmf.5.2020.11.05.16.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:24:59 -0800 (PST)
Message-Id: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:43 +0000
Subject: [PATCH v5 00/15] Add struct strmap and associated utility functions
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

Here I introduce new strmap, strintmap, and strset types. This strmap type
was based on Peff's proposal from a couple years ago[1], but has additions
that I made as I used it, and a number of additions/changes suggested by
Peff in his reviews (and Junio in his). I also start the series off with
some changes to hashmap, based on Peff's feedback on v1 & v2.

NOTE: While en/merge-ort-impl depends on this series, there are no changes
in v5 that affect it so en/merge-ort-impl does not need a reroll.

Changes since v4:

 * Make strset_add() return a boolean -- 1 if it added the value to the set,
   0 if the value was already in the set.
 * Add a preparatory patch to the above which adds a create_entry() helper
   function so that strset_add() can bypass strmap_put().
 * Add a patch which updates shortlog to use the new strset API.

[1] 
https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/

Elijah Newren (15):
  hashmap: add usage documentation explaining hashmap_free[_entries]()
  hashmap: adjust spacing to fix argument alignment
  hashmap: allow re-use after hashmap_free()
  hashmap: introduce a new hashmap_partial_clear()
  hashmap: provide deallocation function names
  strmap: new utility functions
  strmap: add more utility functions
  strmap: enable faster clearing and reusing of strmaps
  strmap: add functions facilitating use as a string->int map
  strmap: split create_entry() out of strmap_put()
  strmap: add a strset sub-type
  strmap: enable allocations to come from a mem_pool
  strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
  Use new HASHMAP_INIT macro to simplify hashmap initialization
  shortlog: use strset from strmap.h

 Makefile                |   1 +
 add-interactive.c       |   2 +-
 attr.c                  |  26 ++--
 blame.c                 |   2 +-
 bloom.c                 |   5 +-
 builtin/difftool.c      |   9 +-
 builtin/fetch.c         |   6 +-
 builtin/shortlog.c      |  61 +--------
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
 strmap.c                | 178 ++++++++++++++++++++++++++
 strmap.h                | 268 ++++++++++++++++++++++++++++++++++++++++
 submodule-config.c      |   4 +-
 t/helper/test-hashmap.c |   9 +-
 27 files changed, 621 insertions(+), 170 deletions(-)
 create mode 100644 strmap.c
 create mode 100644 strmap.h


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-835%2Fnewren%2Fstrmap-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-835/newren/strmap-v5
Pull-Request: https://github.com/git/git/pull/835

Range-diff vs v4:

  1:  af6b6fcb46 =  1:  af6b6fcb46 hashmap: add usage documentation explaining hashmap_free[_entries]()
  2:  591161fd78 =  2:  591161fd78 hashmap: adjust spacing to fix argument alignment
  3:  f2718d036d =  3:  f2718d036d hashmap: allow re-use after hashmap_free()
  4:  61f1da3c51 =  4:  61f1da3c51 hashmap: introduce a new hashmap_partial_clear()
  5:  861e8d65ae =  5:  861e8d65ae hashmap: provide deallocation function names
  6:  448d3b219f =  6:  448d3b219f strmap: new utility functions
  7:  5e8004c728 =  7:  5e8004c728 strmap: add more utility functions
  8:  fd96e9fc8d =  8:  fd96e9fc8d strmap: enable faster clearing and reusing of strmaps
  9:  f499934f54 =  9:  f499934f54 strmap: add functions facilitating use as a string->int map
  -:  ---------- > 10:  3bcceb8cdb strmap: split create_entry() out of strmap_put()
 10:  ee1ec55f1b ! 11:  e128a71fec strmap: add a strset sub-type
     @@ Commit message
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## strmap.c ##
     +@@ strmap.c: void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
     + 	else
     + 		strintmap_set(map, str, map->default_value + amt);
     + }
     ++
     ++int strset_add(struct strset *set, const char *str)
     ++{
     ++	/*
     ++	 * Cannot use strmap_put() because it'll return NULL in both cases:
     ++	 *   - cannot find str: NULL means "not found"
     ++	 *   - does find str: NULL is the value associated with str
     ++	 */
     ++	struct strmap_entry *entry = find_strmap_entry(&set->map, str);
     ++
     ++	if (entry)
     ++		return 0;
     ++
     ++	entry = create_entry(&set->map, str, NULL);
     ++	hashmap_add(&set->map.map, &entry->ent);
     ++	return 1;
     ++}
     +
       ## strmap.h ##
      @@ strmap.h: int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
       			.map = STRMAP_INIT,   \
     @@ strmap.h: static inline void strintmap_set(struct strintmap *map, const char *st
      +	return strmap_get_size(&set->map);
      +}
      +
     -+static inline void strset_add(struct strset *set, const char *str)
     -+{
     -+	strmap_put(&set->map, str, NULL);
     -+}
     ++/* Returns 1 if str is added to the set; returns 0 if str was already in set */
     ++int strset_add(struct strset *set, const char *str);
      +
       #endif /* STRMAP_H */
 11:  73a57045c3 ! 12:  34f542d9dd strmap: enable allocations to come from a mem_pool
     @@ strmap.c: static void strmap_free_entries_(struct strmap *map, int free_values)
       	}
       }
       
     -@@ strmap.c: void *strmap_put(struct strmap *map, const char *str, void *data)
     - 	} else {
     - 		const char *key = str;
     - 
     --		entry = xmalloc(sizeof(*entry));
     -+		entry = map->pool ? mem_pool_alloc(map->pool, sizeof(*entry))
     -+				  : xmalloc(sizeof(*entry));
     - 		hashmap_entry_init(&entry->ent, strhash(str));
     - 
     - 		if (map->strdup_strings)
     --			key = xstrdup(str);
     -+			key = map->pool ? mem_pool_strdup(map->pool, str)
     -+					: xstrdup(str);
     - 		entry->key = key;
     - 		entry->value = data;
     - 		hashmap_add(&map->map, &entry->ent);
     +@@ strmap.c: static struct strmap_entry *create_entry(struct strmap *map,
     + 	struct strmap_entry *entry;
     + 	const char *key = str;
     + 
     +-	entry = xmalloc(sizeof(*entry));
     ++	entry = map->pool ? mem_pool_alloc(map->pool, sizeof(*entry))
     ++			  : xmalloc(sizeof(*entry));
     + 	hashmap_entry_init(&entry->ent, strhash(str));
     + 
     + 	if (map->strdup_strings)
     +-		key = xstrdup(str);
     ++		key = map->pool ? mem_pool_strdup(map->pool, str)
     ++				: xstrdup(str);
     + 	entry->key = key;
     + 	entry->value = data;
     + 	return entry;
      @@ strmap.c: void strmap_remove(struct strmap *map, const char *str, int free_value)
       		return;
       	if (free_value)
 12:  0352260de4 ! 13:  39ec2fa411 strmap: take advantage of FLEXPTR_ALLOC_STR when relevant
     @@ strmap.c: static void strmap_free_entries_(struct strmap *map, int free_values)
       	}
       }
       
     -@@ strmap.c: void strmap_partial_clear(struct strmap *map, int free_values)
     - void *strmap_put(struct strmap *map, const char *str, void *data)
     +@@ strmap.c: static struct strmap_entry *create_entry(struct strmap *map,
     + 					 void *data)
       {
     - 	struct strmap_entry *entry = find_strmap_entry(map, str);
     --	void *old = NULL;
     + 	struct strmap_entry *entry;
     +-	const char *key = str;
       
     - 	if (entry) {
     --		old = entry->value;
     -+		void *old = entry->value;
     - 		entry->value = data;
     --	} else {
     --		const char *key = str;
     --
     --		entry = map->pool ? mem_pool_alloc(map->pool, sizeof(*entry))
     --				  : xmalloc(sizeof(*entry));
     --		hashmap_entry_init(&entry->ent, strhash(str));
     -+		return old;
     -+	}
     - 
     --		if (map->strdup_strings)
     --			key = map->pool ? mem_pool_strdup(map->pool, str)
     --					: xstrdup(str);
     --		entry->key = key;
     --		entry->value = data;
     --		hashmap_add(&map->map, &entry->ent);
     +-	entry = map->pool ? mem_pool_alloc(map->pool, sizeof(*entry))
     +-			  : xmalloc(sizeof(*entry));
      +	if (map->strdup_strings) {
      +		if (!map->pool) {
      +			FLEXPTR_ALLOC_STR(entry, key, str);
     @@ strmap.c: void strmap_partial_clear(struct strmap *map, int free_values)
      +		entry = xmalloc(sizeof(*entry));
      +	} else {
      +		entry = mem_pool_alloc(map->pool, sizeof(*entry));
     - 	}
     --	return old;
     -+	hashmap_entry_init(&entry->ent, strhash(str));
     ++	}
     + 	hashmap_entry_init(&entry->ent, strhash(str));
     +-
     +-	if (map->strdup_strings)
     +-		key = map->pool ? mem_pool_strdup(map->pool, str)
     +-				: xstrdup(str);
     +-	entry->key = key;
      +	if (!map->strdup_strings)
      +		entry->key = str;
     -+	entry->value = data;
     -+	hashmap_add(&map->map, &entry->ent);
     -+	return NULL;
     + 	entry->value = data;
     + 	return entry;
       }
     - 
     - struct strmap_entry *strmap_get_entry(struct strmap *map, const char *str)
      @@ strmap.c: void strmap_remove(struct strmap *map, const char *str, int free_value)
       		return;
       	if (free_value)
 13:  617926540b = 14:  d3713d88f2 Use new HASHMAP_INIT macro to simplify hashmap initialization
  -:  ---------- > 15:  24e5ce60f5 shortlog: use strset from strmap.h

-- 
gitgitgadget
