Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFFDC64E7C
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29667221EB
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2RZEp8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgJMAkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 20:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgJMAkz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 20:40:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8F1C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d81so19157356wmc.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XOQgaH4o9oYoL3sICarn4rH/4XX/1WXqmKFmR/xwFkc=;
        b=m2RZEp8UkRjhycRLLxgeWqWgjRZxBpLslhn2uTb2dyNI1AxqgWTyF3olAQg50WI1UB
         74G0G0fv68yPtqZD06hF08FFmzZst4WlWL0kOr+hTh1wM0DzU5Y1Ml0hzjs01jJ/pTmm
         M0vs+vPArzW5JtvpIQV1cfUSzJEPwwenXfOBICW0E367zqfF7RKFf3XHbbx+MOTVLeai
         lySmeTbgt9EFRZ423XHoCBU59so0lXGYfa0yUTQDRngb+ezQfGvOCd1VBCmQfwPxZT1n
         qZW4U66WarS2pZ4/u+RAkxzxOvfiPWBhMjwirx2WffUdmU+mvhCm0WDlZsruN1205QSb
         AOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XOQgaH4o9oYoL3sICarn4rH/4XX/1WXqmKFmR/xwFkc=;
        b=dd4ED3ODAWqNcJ2fAB+qeEPvxM5ucOf/cnH+XcdIvtleu07PmodJUYmfGbjLA5CYSE
         TlrBpLVdNyIY0WCqRm19QME6c0uzF9rdX8uqP9MdWH7SAkKXr/yjabUSkWGHZ7Aaqh6l
         JhIwFR4FxmHouJKOp/6APaealKngUGdQ2itFAJ9KvkZsKNlWTokZkyJ5wel4lsq83KfR
         5z8FyBp7zRlAEbv9jL0aPqZr4RUjooyuv1jof3z0tMbA8r67ISjtfuR+XOkomt3/f9jl
         BRnvoPB1rIjFScAWJnOnmRj4rYV7gp1TRJ9aVssuEQLNxAIrQfUbxUxwm7VToxofgB2R
         uTXg==
X-Gm-Message-State: AOAM533obq1A/an1aDNcy6le6LhMX5xM5gDC9lT2EhYjbqxIInS7+dMH
        78gG8inZ618FJ3CurlC1D0PSfSWmOBA=
X-Google-Smtp-Source: ABdhPJzng3yKiZjfZfHLij7paea+suaFK4J47W1wtQBV5fR8ai+iq3AfP1mLso2MFfKAqBYmd92TaQ==
X-Received: by 2002:a1c:ded7:: with SMTP id v206mr12498265wmg.183.1602549652509;
        Mon, 12 Oct 2020 17:40:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 40sm27929364wrc.46.2020.10.12.17.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 17:40:51 -0700 (PDT)
Message-Id: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 00:40:40 +0000
Subject: [PATCH v2 00/10] Add struct strmap and associated utility functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here I introduce a new strmap type, which my new merge backed, merge-ort,
uses heavily. (I also made significant use of it in my changes to
diffcore-rename). This strmap type was based on Peff's proposal from a
couple years ago[1], but has additions that I made as I used it. I also
start the series off with some changes to hashmap, based on Peff's feedback
on v1.

Changes since v1:

 * Rebased on newer origin/master (to resolve a conflict in Makefile)
 * First fixed hashmap to allow it to continue to be used after
   hashmap_free() is called, as requested by Peff.
 * Renamed my hashmap_clear() to hashmap_partial_clear() to avoid mis-use
   and make it clear it doesn't free everything.
 * Distanced the API from string-list, as per feedback from Peff. In
   particular, removed the use of string_list_item, and made strdup_strings
   the default -- strmap_init() does not accept a strdup_strings parameter
   it just defaults to on; one has to call strmap_ocd_init() instead if one
   wants to control the memory closely.
 * Added strintmap and strset types, for string->int mappings, and cases
   where we just want a set of keys rather than having each key map to some
   value.
 * Also included a patch enabling strmaps to make use of mem_pools (also
   only accessible via the strmap_ocd_init() constructor ); I previously
   thought this only made sense to include after the relevant point in
   merge-ort, but I figured since it slightly affects the API (it was part
   of what led me to the strmap_ocd_init() name), I decided to include it
   for now.
 * The hashmap_partial_clear() and strmap_partial_clear() additions in
   patches 4 and 7 could also potentially be deferred much like mem_pool
   additions, but again, I decided to include them because they give a
   better picture of the overall usage I have and usecases I'm trying to
   design the API for.

Things Peff mentioned that are NOT included in this v2:

 * Peff brought up the idea of having a free_values member instead of having
   a free_util parameter to strmap_clear(). I think that would just mean
   moving the parameter from strmap_clear() to strmap_init().
 * Peff wanted the strmap_entry type to have a char key[FLEX_ALLOC] instead
   of having a (const) char *key.

Explanations/excuses for the above: 

 * For the free_values member, it sounded like Peff didn't have a strong
   opinion. I don't either, so I'm happy to switch it if someone feels
   strongly. But since it sounded like a thinking-out-loud comment and I
   couldn't see an advantage one way or the other, I left things as-is.
 * For the FLEX_ALLOC implementation, Peff did have a clear strong
   preference. I put a day or so of time into trying to get an alternate
   implementation working (and I at least ripped out the string_list_item
   sub-type, made the key be const, and fixed the ugly casts), but didn't
   quite get the code to a working state. (Not only does it change the
   memory management quite a bit in ways that I need to run under valgrind
   both with and without mem_pools, but there's an extra wrinkle as well:
   merge-ort differs from merge-recursive in that all filepaths come from a
   single tree traversal instead of several different ones, which means that
   I had the ability to compare path strings for equality via pointer
   comparisons instead of using strcmp. Copying strings for each of the
   different strmaps breaks that.) If the changes I've made aren't
   sufficient and folks still want to see the performance of a FLEX_ALLOC
   implementation, it's probably possible to get it working, just
   surprisingly non-trivial. For now, I at least wanted to get feedback on
   my other changes, and probe for whether folks do want me to put another
   day or two into this.

[1] 
https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/

Elijah Newren (10):
  hashmap: add usage documentation explaining hashmap_free[_entries]()
  hashmap: adjust spacing to fix argument alignment
  hashmap: allow re-use after hashmap_free()
  hashmap: introduce a new hashmap_partial_clear()
  strmap: new utility functions
  strmap: add more utility functions
  strmap: enable faster clearing and reusing of strmaps
  strmap: add functions facilitating use as a string->int map
  strmap: add a strset sub-type
  strmap: enable allocations to come from a mem_pool

 Makefile  |   1 +
 hashmap.c |  72 +++++++++++-----
 hashmap.h |  44 +++++++++-
 strmap.c  | 152 +++++++++++++++++++++++++++++++++
 strmap.h  | 250 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 494 insertions(+), 25 deletions(-)
 create mode 100644 strmap.c
 create mode 100644 strmap.h


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-835%2Fnewren%2Fstrmap-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-835/newren/strmap-v2
Pull-Request: https://github.com/git/git/pull/835

Range-diff vs v1:

  1:  b295e9393a !  1:  af6b6fcb46 hashmap: add usage documentation explaining hashmap_free[_entries]()
     @@ Commit message
          hashmap: add usage documentation explaining hashmap_free[_entries]()
      
          The existence of hashmap_free() and hashmap_free_entries() confused me,
     -    and the docs weren't clear enough.  I had to consult other source code
     -    examples and the implementation.  Add a brief note to clarify,
     -    especially since hashmap_clear*() variants may be added in the future.
     +    and the docs weren't clear enough.  We are dealing with a map table,
     +    entries in that table, and possibly also things each of those entries
     +    point to.  I had to consult other source code examples and the
     +    implementation.  Add a brief note to clarify the differences.  This will
     +    become even more important once we introduce a new
     +    hashmap_partial_clear() function which will add the question of whether
     +    the table itself has been freed.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ hashmap.h: void hashmap_init(struct hashmap *map,
      + * Many callers will need to iterate over all entries and free the data each
      + * entry points to; in such a case, they can free the entry itself while at it.
      + * Thus, you might see:
     ++ *
      + *    hashmap_for_each_entry(map, hashmap_iter, e, hashmap_entry_name) {
      + *      free(e->somefield);
      + *      free(e);
      + *    }
      + *    hashmap_free(map);
     ++ *
      + * instead of
     ++ *
      + *    hashmap_for_each_entry(map, hashmap_iter, e, hashmap_entry_name) {
      + *      free(e->somefield);
      + *    }
      + *    hashmap_free_entries(map, struct my_entry_struct, hashmap_entry_name);
     ++ *
      + * to avoid the implicit extra loop over the entries.  However, if there are
      + * no special fields in your entry that need to be freed beyond the entry
      + * itself, it is probably simpler to avoid the explicit loop and just call
  -:  ---------- >  2:  75f17619e9 hashmap: adjust spacing to fix argument alignment
  -:  ---------- >  3:  a686d0758a hashmap: allow re-use after hashmap_free()
  -:  ---------- >  4:  061ab45a9b hashmap: introduce a new hashmap_partial_clear()
  2:  a86fd5fdcc !  5:  5c7507f55b strmap: new utility functions
     @@ Commit message
          taken directly from Peff's proposal at
          https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.net/
      
     -    Peff only included the header, not the implementation, so it isn't clear what
     -    the structure was he was going to use for the hash entries.  Instead of having
     -    my str_entry struct have three subfields (the hashmap_entry, the string, and
     -    the void* value), I made it only have two -- the hashmap_entry and a
     -    string_list_item, for two reasons:
     +    A couple of items of note:
      
     -      1) a strmap is often the data structure we want where string_list has
     -         been used in the past.  Using the same building block for
     -         individual entries in both makes it easier to adopt and reuse
     -         parts of the string_list API in strmap.
     +      * Similar to string-list, I have a strdup_strings setting.  However,
     +        unlike string-list, strmap_init() does not take a parameter for this
     +        setting and instead automatically sets it to 1; callers who want to
     +        control this detail need to instead call strmap_ocd_init().
      
     -      2) In some cases, after doing lots of other work, I want to be able
     -         to iterate over the items in my strmap in sorted order.  hashmap
     -         obviously doesn't support that, but I wanted to be able to export
     -         the strmap to a string_list easily and then use its functions.
     -         (Note: I do not need the data structure to both be sorted and have
     -         efficient lookup at all times.  If I did, I might use a B-tree
     -         instead, as suggested by brian in response to Peff in the thread
     -         noted above.  In my case, most strmaps will never need sorting, but
     -         in one special case at the very end of a bunch of other work I want
     -         to iterate over the items in sorted order without doing any more
     -         lookups afterward.)
     -
     -    Also, I removed the STRMAP_INIT macro, since it cannot be used to
     -    correctly initialize a strmap; the underlying hashmap needs a call to
     -    hashmap_init() to allocate the hash table first.
     +      * I do not have a STRMAP_INIT macro.  I could possibly add one, but
     +          #define STRMAP_INIT { { NULL, cmp_str_entry, NULL, 0, 0, 0, 0, 0 }, 1 }
     +        feels a bit unwieldy and possibly error-prone in terms of future
     +        expansion of the hashmap struct.  The fact that cmp_str_entry needs to
     +        be in there prevents us from passing all zeros for the hashmap, and makes
     +        me worry that STRMAP_INIT would just be more trouble than it is worth.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Makefile ##
     -@@ Makefile: LIB_OBJS += strbuf.o
     - LIB_OBJS += strvec.o
     +@@ Makefile: LIB_OBJS += stable-qsort.o
     + LIB_OBJS += strbuf.o
       LIB_OBJS += streaming.o
       LIB_OBJS += string-list.o
      +LIB_OBJS += strmap.o
     + LIB_OBJS += strvec.o
       LIB_OBJS += sub-process.o
       LIB_OBJS += submodule-config.o
     - LIB_OBJS += submodule.o
      
       ## strmap.c (new) ##
      @@
      +#include "git-compat-util.h"
      +#include "strmap.h"
      +
     -+static int cmp_str_entry(const void *hashmap_cmp_fn_data,
     -+			 const struct hashmap_entry *entry1,
     -+			 const struct hashmap_entry *entry2,
     -+			 const void *keydata)
     ++static int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
     ++			    const struct hashmap_entry *entry1,
     ++			    const struct hashmap_entry *entry2,
     ++			    const void *keydata)
      +{
     -+	const struct str_entry *e1, *e2;
     ++	const struct strmap_entry *e1, *e2;
      +
     -+	e1 = container_of(entry1, const struct str_entry, ent);
     -+	e2 = container_of(entry2, const struct str_entry, ent);
     -+	return strcmp(e1->item.string, e2->item.string);
     ++	e1 = container_of(entry1, const struct strmap_entry, ent);
     ++	e2 = container_of(entry2, const struct strmap_entry, ent);
     ++	return strcmp(e1->key, e2->key);
      +}
      +
     -+static struct str_entry *find_str_entry(struct strmap *map,
     -+					const char *str)
     ++static struct strmap_entry *find_strmap_entry(struct strmap *map,
     ++					      const char *str)
      +{
     -+	struct str_entry entry;
     ++	struct strmap_entry entry;
      +	hashmap_entry_init(&entry.ent, strhash(str));
     -+	entry.item.string = (char *)str;
     ++	entry.key = str;
      +	return hashmap_get_entry(&map->map, &entry, ent, NULL);
      +}
      +
      +void strmap_init(struct strmap *map)
      +{
     -+	hashmap_init(&map->map, cmp_str_entry, NULL, 0);
     ++	strmap_ocd_init(map, 1);
      +}
      +
     -+void strmap_clear(struct strmap *map, int free_util)
     ++void strmap_ocd_init(struct strmap *map,
     ++		     int strdup_strings)
     ++{
     ++	hashmap_init(&map->map, cmp_strmap_entry, NULL, 0);
     ++	map->strdup_strings = strdup_strings;
     ++}
     ++
     ++static void strmap_free_entries_(struct strmap *map, int free_util)
      +{
      +	struct hashmap_iter iter;
     -+	struct str_entry *e;
     ++	struct strmap_entry *e;
      +
      +	if (!map)
      +		return;
      +
     -+	hashmap_for_each_entry(&map->map, &iter, e, ent /* member name */) {
     -+		free(e->item.string);
     ++	/*
     ++	 * We need to iterate over the hashmap entries and free
     ++	 * e->key and e->value ourselves; hashmap has no API to
     ++	 * take care of that for us.  Since we're already iterating over
     ++	 * the hashmap, though, might as well free e too and avoid the need
     ++	 * to make some call into the hashmap API to do that.
     ++	 */
     ++	hashmap_for_each_entry(&map->map, &iter, e, ent) {
      +		if (free_util)
     -+			free(e->item.util);
     ++			free(e->value);
     ++		if (map->strdup_strings)
     ++			free((char*)e->key);
     ++		free(e);
      +	}
     -+	hashmap_free_entries(&map->map, struct str_entry, ent);
     -+	strmap_init(map);
      +}
      +
     -+/*
     -+ * Insert "str" into the map, pointing to "data". A copy of "str" is made, so
     -+ * it does not need to persist after the this function is called.
     -+ *
     -+ * If an entry for "str" already exists, its data pointer is overwritten, and
     -+ * the original data pointer returned. Otherwise, returns NULL.
     -+ */
     ++void strmap_clear(struct strmap *map, int free_util)
     ++{
     ++	strmap_free_entries_(map, free_util);
     ++	hashmap_free(&map->map);
     ++}
     ++
      +void *strmap_put(struct strmap *map, const char *str, void *data)
      +{
     -+	struct str_entry *entry = find_str_entry(map, str);
     ++	struct strmap_entry *entry = find_strmap_entry(map, str);
      +	void *old = NULL;
      +
      +	if (entry) {
     -+		old = entry->item.util;
     -+		entry->item.util = data;
     ++		old = entry->value;
     ++		entry->value = data;
      +	} else {
     ++		/*
     ++		 * We won't modify entry->key so it really should be const.
     ++		 */
     ++		const char *key = str;
     ++
      +		entry = xmalloc(sizeof(*entry));
      +		hashmap_entry_init(&entry->ent, strhash(str));
     -+		entry->item.string = strdup(str);
     -+		entry->item.util = data;
     ++
     ++		if (map->strdup_strings)
     ++			key = xstrdup(str);
     ++		entry->key = key;
     ++		entry->value = data;
      +		hashmap_add(&map->map, &entry->ent);
      +	}
      +	return old;
     @@ strmap.c (new)
      +
      +void *strmap_get(struct strmap *map, const char *str)
      +{
     -+	struct str_entry *entry = find_str_entry(map, str);
     -+	return entry ? entry->item.util : NULL;
     ++	struct strmap_entry *entry = find_strmap_entry(map, str);
     ++	return entry ? entry->value : NULL;
      +}
      +
      +int strmap_contains(struct strmap *map, const char *str)
      +{
     -+	return find_str_entry(map, str) != NULL;
     ++	return find_strmap_entry(map, str) != NULL;
      +}
      
       ## strmap.h (new) ##
     @@ strmap.h (new)
      +#define STRMAP_H
      +
      +#include "hashmap.h"
     -+#include "string-list.h"
      +
      +struct strmap {
      +	struct hashmap map;
     ++	unsigned int strdup_strings:1;
      +};
      +
     -+struct str_entry {
     ++struct strmap_entry {
      +	struct hashmap_entry ent;
     -+	struct string_list_item item;
     ++	const char *key;
     ++	void *value;
      +};
      +
      +/*
     -+ * Initialize an empty strmap
     ++ * Initialize the members of the strmap.  Any keys added to the strmap will
     ++ * be strdup'ed with their memory managed by the strmap.
      + */
      +void strmap_init(struct strmap *map);
      +
      +/*
     ++ * Same as strmap_init, but for those who want to control the memory management
     ++ * carefully instead of using the default of strdup_strings=1.
     ++ * (OCD = Obsessive Compulsive Disorder, a joke that those who use this function
     ++ * are obsessing over minor details.)
     ++ */
     ++void strmap_ocd_init(struct strmap *map,
     ++		     int strdup_strings);
     ++
     ++/*
      + * Remove all entries from the map, releasing any allocated resources.
      + */
      +void strmap_clear(struct strmap *map, int free_values);
      +
      +/*
     -+ * Insert "str" into the map, pointing to "data". A copy of "str" is made, so
     -+ * it does not need to persist after the this function is called.
     ++ * Insert "str" into the map, pointing to "data".
      + *
      + * If an entry for "str" already exists, its data pointer is overwritten, and
      + * the original data pointer returned. Otherwise, returns NULL.
  3:  5bda171d0c !  6:  61b5bf1110 strmap: add more utility functions
     @@ Commit message
            * strmap_get_size()
            * strmap_remove()
            * strmap_for_each_entry()
     -      * strmap_free()
     -      * strmap_get_item()
     +      * strmap_get_entry()
      
          I suspect the first four are self-explanatory.
      
     -    strmap_free() differs from strmap_clear() in that the data structure is
     -    not reusable after it is called; strmap_clear() is not sufficient for
     -    the API because without strmap_free() we will leak memory.
     -
     -    strmap_get_item() is similar to strmap_get() except that instead of just
     +    strmap_get_entry() is similar to strmap_get() except that instead of just
          returning the void* value that the string maps to, it returns the
     -    string_list_item that contains both the string and the void* value (or
     +    strmap_entry that contains both the string and the void* value (or
          NULL if the string isn't in the map).  This is helpful because it avoids
          multiple lookups, e.g. in some cases a caller would need to call:
            * strmap_contains() to check that the map has an entry for the string
     @@ Commit message
            * strmap_put() to update/overwrite the value
          If the void* pointer returned really is a pointer, then the last step is
          unnecessary, but if the void* pointer is just cast to an integer then
     -    strmap_put() will be needed.  In contrast, one can call strmap_get_item()
     +    strmap_put() will be needed.  In contrast, one can call strmap_get_entry()
          and then:
            * check if the string was in the map by whether the pointer is NULL
     -      * access the value via item->util
     -      * directly update item->util
     +      * access the value via entry->value
     +      * directly update entry->value
          meaning that we can replace two or three hash table lookups with one.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## strmap.c ##
     -@@ strmap.c: void strmap_init(struct strmap *map)
     - 	hashmap_init(&map->map, cmp_str_entry, NULL, 0);
     - }
     - 
     --void strmap_clear(struct strmap *map, int free_util)
     -+void strmap_free(struct strmap *map, int free_util)
     - {
     - 	struct hashmap_iter iter;
     - 	struct str_entry *e;
     -@@ strmap.c: void strmap_clear(struct strmap *map, int free_util)
     - 	if (!map)
     - 		return;
     - 
     --	hashmap_for_each_entry(&map->map, &iter, e, ent /* member name */) {
     --		free(e->item.string);
     --		if (free_util)
     --			free(e->item.util);
     -+	if (free_util) {
     -+		hashmap_for_each_entry(&map->map, &iter, e, ent) {
     -+			free(e->item.string);
     -+			if (free_util)
     -+				free(e->item.util);
     -+		}
     - 	}
     - 	hashmap_free_entries(&map->map, struct str_entry, ent);
     -+}
     -+
     -+void strmap_clear(struct strmap *map, int free_util)
     -+{
     -+	strmap_free(map, free_util);
     - 	strmap_init(map);
     - }
     - 
      @@ strmap.c: void *strmap_put(struct strmap *map, const char *str, void *data)
       	return old;
       }
       
     -+struct string_list_item *strmap_get_item(struct strmap *map,
     -+					 const char *str)
     ++struct strmap_entry *strmap_get_entry(struct strmap *map, const char *str)
      +{
     -+	struct str_entry *entry = find_str_entry(map, str);
     -+	return entry ? &entry->item : NULL;
     ++	return find_strmap_entry(map, str);
      +}
      +
       void *strmap_get(struct strmap *map, const char *str)
       {
     - 	struct str_entry *entry = find_str_entry(map, str);
     + 	struct strmap_entry *entry = find_strmap_entry(map, str);
      @@ strmap.c: int strmap_contains(struct strmap *map, const char *str)
       {
     - 	return find_str_entry(map, str) != NULL;
     + 	return find_strmap_entry(map, str) != NULL;
       }
      +
      +void strmap_remove(struct strmap *map, const char *str, int free_util)
      +{
     -+	struct str_entry entry, *ret;
     ++	struct strmap_entry entry, *ret;
      +	hashmap_entry_init(&entry.ent, strhash(str));
     -+	entry.item.string = (char *)str;
     ++	entry.key = str;
      +	ret = hashmap_remove_entry(&map->map, &entry, ent, NULL);
     -+	if (ret && free_util)
     -+		free(ret->item.util);
     ++	if (!ret)
     ++		return;
     ++	if (free_util)
     ++		free(ret->value);
     ++	if (map->strdup_strings)
     ++		free((char*)ret->key);
      +	free(ret);
      +}
      
       ## strmap.h ##
     -@@ strmap.h: void strmap_init(struct strmap *map);
     - /*
     -  * Remove all entries from the map, releasing any allocated resources.
     -  */
     -+void strmap_free(struct strmap *map, int free_values);
     -+
     -+/*
     -+ * Same as calling strmap_free() followed by strmap_init().
     -+ */
     - void strmap_clear(struct strmap *map, int free_values);
     - 
     - /*
      @@ strmap.h: void strmap_clear(struct strmap *map, int free_values);
        */
       void *strmap_put(struct strmap *map, const char *str, void *data);
       
      +/*
     -+ * Return the string_list_item mapped by "str", or NULL if there is not such
     ++ * Return the strmap_entry mapped by "str", or NULL if there is not such
      + * an item in map.
      + */
     -+struct string_list_item *strmap_get_item(struct strmap *map, const char *str);
     ++struct strmap_entry *strmap_get_entry(struct strmap *map, const char *str);
      +
       /*
        * Return the data pointer mapped by "str", or NULL if the entry does not
     @@ strmap.h: void *strmap_get(struct strmap *map, const char *str);
      +}
      +
      +/*
     -+ * iterate through @map using @iter, @var is a pointer to a type str_entry
     ++ * iterate through @map using @iter, @var is a pointer to a type strmap_entry
      + */
      +#define strmap_for_each_entry(mystrmap, iter, var)	\
      +	for (var = hashmap_iter_first_entry_offset(&(mystrmap)->map, iter, \
      +						   OFFSETOF_VAR(var, ent)); \
      +		var; \
      +		var = hashmap_iter_next_entry_offset(iter, \
     -+						OFFSETOF_VAR(var, ent)))
     ++						     OFFSETOF_VAR(var, ent)))
      +
       #endif /* STRMAP_H */
  -:  ---------- >  7:  2ebce0c5d8 strmap: enable faster clearing and reusing of strmaps
  5:  418975b460 !  8:  cc8d702f98 strmap: add functions facilitating use as a string->int map
     @@ Commit message
          isn't the case when we're storing an int value directly in the void*
          slot instead of using the void* slot as a pointer to data.
      
     -    A note on the name: strintmap looks and sounds pretty lame to me, but
     -    after trying to come up with something better and having no luck, I
     -    figured I'd just go with it for a while and then at some point some
     -    better and obvious name would strike me and I could replace it.  Several
     -    months later, I still don't have a better name.  Hopefully someone else
     -    has one.
     +    A note on the name: if anyone has a better name suggestion than
     +    strintmap, I'm happy to take it.  It seems slightly unwieldy, but I have
     +    not been able to come up with a better name.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## strmap.c ##
      @@ strmap.c: void strmap_remove(struct strmap *map, const char *str, int free_util)
     - 		free(ret->item.util);
     + 		free((char*)ret->key);
       	free(ret);
       }
      +
     -+void strintmap_incr(struct strmap *map, const char *str, intptr_t amt)
     ++void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
      +{
     -+	struct str_entry *entry = find_str_entry(map, str);
     ++	struct strmap_entry *entry = find_strmap_entry(&map->map, str);
      +	if (entry) {
     -+		intptr_t *whence = (intptr_t*)&entry->item.util;
     ++		intptr_t *whence = (intptr_t*)&entry->value;
      +		*whence += amt;
      +	}
      +	else
     @@ strmap.c: void strmap_remove(struct strmap *map, const char *str, int free_util)
       ## strmap.h ##
      @@ strmap.h: static inline unsigned int strmap_get_size(struct strmap *map)
       		var = hashmap_iter_next_entry_offset(iter, \
     - 						OFFSETOF_VAR(var, ent)))
     + 						     OFFSETOF_VAR(var, ent)))
       
     ++
      +/*
     -+ * Helper functions for using strmap as map of string -> int, using the void*
     -+ * field to store the int instead of allocating an int and having the void*
     -+ * member point to the allocated int.
     ++ * strintmap:
     ++ *    A map of string -> int, typecasting the void* of strmap to an int.
     ++ *
     ++ * Primary differences:
     ++ *    1) Since the void* value is just an int in disguise, there is no value
     ++ *       to free.  (Thus one fewer argument to strintmap_clear)
     ++ *    2) strintmap_get() returns an int; it also requires an extra parameter to
     ++ *       be specified so it knows what value to return if the underlying strmap
     ++ *       has not key matching the given string.
     ++ *    3) No strmap_put() equivalent; strintmap_set() and strintmap_incr()
     ++ *       instead.
      + */
      +
     -+static inline int strintmap_get(struct strmap *map, const char *str,
     -+				int default_value)
     ++struct strintmap {
     ++	struct strmap map;
     ++};
     ++
     ++#define strintmap_for_each_entry(mystrmap, iter, var)	\
     ++	strmap_for_each_entry(&(mystrmap)->map, iter, var)
     ++
     ++static inline void strintmap_init(struct strintmap *map)
      +{
     -+	struct string_list_item *result = strmap_get_item(map, str);
     -+	if (!result)
     -+		return default_value;
     -+	return (intptr_t)result->util;
     ++	strmap_init(&map->map);
     ++}
     ++
     ++static inline void strintmap_ocd_init(struct strintmap *map,
     ++				      int strdup_strings)
     ++{
     ++	strmap_ocd_init(&map->map, strdup_strings);
      +}
      +
     -+static inline void strintmap_set(struct strmap *map, const char *str, intptr_t v)
     ++static inline void strintmap_clear(struct strintmap *map)
      +{
     -+	strmap_put(map, str, (void *)v);
     ++	strmap_clear(&map->map, 0);
      +}
      +
     -+void strintmap_incr(struct strmap *map, const char *str, intptr_t amt);
     ++static inline void strintmap_partial_clear(struct strintmap *map)
     ++{
     ++	strmap_partial_clear(&map->map, 0);
     ++}
     ++
     ++static inline int strintmap_contains(struct strintmap *map, const char *str)
     ++{
     ++	return strmap_contains(&map->map, str);
     ++}
      +
     -+static inline void strintmap_clear(struct strmap *map)
     ++static inline void strintmap_remove(struct strintmap *map, const char *str)
      +{
     -+	strmap_clear(map, 0);
     ++	return strmap_remove(&map->map, str, 0);
      +}
      +
     -+static inline void strintmap_free(struct strmap *map)
     ++static inline int strintmap_empty(struct strintmap *map)
      +{
     -+	strmap_free(map, 0);
     ++	return strmap_empty(&map->map);
      +}
     ++
     ++static inline unsigned int strintmap_get_size(struct strintmap *map)
     ++{
     ++	return strmap_get_size(&map->map);
     ++}
     ++
     ++static inline int strintmap_get(struct strintmap *map, const char *str,
     ++				int default_value)
     ++{
     ++	struct strmap_entry *result = strmap_get_entry(&map->map, str);
     ++	if (!result)
     ++		return default_value;
     ++	return (intptr_t)result->value;
     ++}
     ++
     ++static inline void strintmap_set(struct strintmap *map, const char *str,
     ++				 intptr_t v)
     ++{
     ++	strmap_put(&map->map, str, (void *)v);
     ++}
     ++
     ++void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt);
      +
       #endif /* STRMAP_H */
  -:  ---------- >  9:  490d3a42ad strmap: add a strset sub-type
  4:  b3095d97d8 ! 10:  eca4f1ddba strmap: add strdup_strings option
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    strmap: add strdup_strings option
     +    strmap: enable allocations to come from a mem_pool
      
     -    Just as it is sometimes useful for string_list to duplicate and take
     -    ownership of memory management of the strings it contains, the same is
     -    sometimes true for strmaps as well.  Add the same flag from string_list
     -    to strmap.
     +    For heavy users of strmaps, allowing the keys and entries to be
     +    allocated from a memory pool can provide significant overhead savings.
     +    Add an option to strmap_ocd_init() to specify a memory pool.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## strmap.c ##
     -@@ strmap.c: static struct str_entry *find_str_entry(struct strmap *map,
     - 	return hashmap_get_entry(&map->map, &entry, ent, NULL);
     +@@
     + #include "git-compat-util.h"
     + #include "strmap.h"
     ++#include "mem-pool.h"
     + 
     + static int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
     + 			    const struct hashmap_entry *entry1,
     +@@ strmap.c: static struct strmap_entry *find_strmap_entry(struct strmap *map,
     + 
     + void strmap_init(struct strmap *map)
     + {
     +-	strmap_ocd_init(map, 1);
     ++	strmap_ocd_init(map, NULL, 1);
       }
       
     --void strmap_init(struct strmap *map)
     -+void strmap_init(struct strmap *map, int strdup_strings)
     + void strmap_ocd_init(struct strmap *map,
     ++		     struct mem_pool *pool,
     + 		     int strdup_strings)
       {
     - 	hashmap_init(&map->map, cmp_str_entry, NULL, 0);
     -+	map->strdup_strings = strdup_strings;
     + 	hashmap_init(&map->map, cmp_strmap_entry, NULL, 0);
     ++	map->pool = pool;
     + 	map->strdup_strings = strdup_strings;
       }
       
     - void strmap_free(struct strmap *map, int free_util)
     -@@ strmap.c: void strmap_free(struct strmap *map, int free_util)
     +@@ strmap.c: static void strmap_free_entries_(struct strmap *map, int free_util)
       	if (!map)
       		return;
       
     --	if (free_util) {
     -+	if (map->strdup_strings || free_util) {
     - 		hashmap_for_each_entry(&map->map, &iter, e, ent) {
     --			free(e->item.string);
     ++	if (!free_util && map->pool)
     ++		/* Memory other than util is owned by and freed with the pool */
     ++		return;
     ++
     + 	/*
     + 	 * We need to iterate over the hashmap entries and free
     + 	 * e->key and e->value ourselves; hashmap has no API to
     +@@ strmap.c: static void strmap_free_entries_(struct strmap *map, int free_util)
     + 	hashmap_for_each_entry(&map->map, &iter, e, ent) {
     + 		if (free_util)
     + 			free(e->value);
     +-		if (map->strdup_strings)
     +-			free((char*)e->key);
     +-		free(e);
     ++		if (!map->pool) {
      +			if (map->strdup_strings)
     -+				free(e->item.string);
     - 			if (free_util)
     - 				free(e->item.util);
     - 		}
     -@@ strmap.c: void strmap_free(struct strmap *map, int free_util)
     - void strmap_clear(struct strmap *map, int free_util)
     - {
     - 	strmap_free(map, free_util);
     --	strmap_init(map);
     -+	strmap_init(map, map->strdup_strings);
     ++				free((char*)e->key);
     ++			free(e);
     ++		}
     + 	}
       }
       
     - /*
     -- * Insert "str" into the map, pointing to "data". A copy of "str" is made, so
     -- * it does not need to persist after the this function is called.
     -+ * Insert "str" into the map, pointing to "data".
     -  *
     -  * If an entry for "str" already exists, its data pointer is overwritten, and
     -  * the original data pointer returned. Otherwise, returns NULL.
      @@ strmap.c: void *strmap_put(struct strmap *map, const char *str, void *data)
     - 	} else {
     - 		entry = xmalloc(sizeof(*entry));
     + 		 */
     + 		const char *key = str;
     + 
     +-		entry = xmalloc(sizeof(*entry));
     ++		entry = map->pool ? mem_pool_alloc(map->pool, sizeof(*entry))
     ++				  : xmalloc(sizeof(*entry));
       		hashmap_entry_init(&entry->ent, strhash(str));
     --		entry->item.string = strdup(str);
     -+		/*
     -+		 * We won't modify entry->item.string so it really should be
     -+		 * const, but changing string_list_item to use a const char *
     -+		 * is a bit too big of a change at this point.
     -+		 */
     -+		entry->item.string =
     -+			map->strdup_strings ? xstrdup(str) : (char *)str;
     - 		entry->item.util = data;
     + 
     + 		if (map->strdup_strings)
     +-			key = xstrdup(str);
     ++			key = map->pool ? mem_pool_strdup(map->pool, str)
     ++					: xstrdup(str);
     + 		entry->key = key;
     + 		entry->value = data;
       		hashmap_add(&map->map, &entry->ent);
     - 	}
      @@ strmap.c: void strmap_remove(struct strmap *map, const char *str, int free_util)
     - 	hashmap_entry_init(&entry.ent, strhash(str));
     - 	entry.item.string = (char *)str;
     - 	ret = hashmap_remove_entry(&map->map, &entry, ent, NULL);
     -+	if (map->strdup_strings)
     -+		free(ret->item.string);
     - 	if (ret && free_util)
     - 		free(ret->item.util);
     - 	free(ret);
     + 		return;
     + 	if (free_util)
     + 		free(ret->value);
     +-	if (map->strdup_strings)
     +-		free((char*)ret->key);
     +-	free(ret);
     ++	if (!map->pool) {
     ++		if (map->strdup_strings)
     ++			free((char*)ret->key);
     ++		free(ret);
     ++	}
     + }
     + 
     + void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
      
       ## strmap.h ##
      @@
       
     + #include "hashmap.h"
     + 
     ++struct mempool;
       struct strmap {
       	struct hashmap map;
     -+	unsigned int strdup_strings:1;
     ++	struct mem_pool *pool;
     + 	unsigned int strdup_strings:1;
       };
       
     - struct str_entry {
     -@@ strmap.h: struct str_entry {
     - };
     +@@ strmap.h: void strmap_init(struct strmap *map);
       
       /*
     -- * Initialize an empty strmap
     -+ * Initialize the members of the strmap, set `strdup_strings`
     -+ * member according to the value of the second parameter.
     +  * Same as strmap_init, but for those who want to control the memory management
     +- * carefully instead of using the default of strdup_strings=1.
     ++ * carefully instead of using the default of strdup_strings=1 and pool=NULL.
     +  * (OCD = Obsessive Compulsive Disorder, a joke that those who use this function
     +  * are obsessing over minor details.)
        */
     --void strmap_init(struct strmap *map);
     -+void strmap_init(struct strmap *map, int strdup_strings);
     + void strmap_ocd_init(struct strmap *map,
     ++		     struct mem_pool *pool,
     + 		     int strdup_strings);
       
       /*
     -  * Remove all entries from the map, releasing any allocated resources.
     -@@ strmap.h: void strmap_free(struct strmap *map, int free_values);
     - void strmap_clear(struct strmap *map, int free_values);
     +@@ strmap.h: static inline void strintmap_init(struct strintmap *map)
     + }
       
     - /*
     -- * Insert "str" into the map, pointing to "data". A copy of "str" is made, so
     -- * it does not need to persist after the this function is called.
     -+ * Insert "str" into the map, pointing to "data".
     -  *
     -  * If an entry for "str" already exists, its data pointer is overwritten, and
     -  * the original data pointer returned. Otherwise, returns NULL.
     + static inline void strintmap_ocd_init(struct strintmap *map,
     ++				      struct mem_pool *pool,
     + 				      int strdup_strings)
     + {
     +-	strmap_ocd_init(&map->map, strdup_strings);
     ++	strmap_ocd_init(&map->map, pool, strdup_strings);
     + }
     + 
     + static inline void strintmap_clear(struct strintmap *map)
     +@@ strmap.h: static inline void strset_init(struct strset *set)
     + }
     + 
     + static inline void strset_ocd_init(struct strset *set,
     ++				   struct mem_pool *pool,
     + 				   int strdup_strings)
     + {
     +-	strmap_ocd_init(&set->map, strdup_strings);
     ++	strmap_ocd_init(&set->map, pool, strdup_strings);
     + }
     + 
     + static inline void strset_clear(struct strset *set)

-- 
gitgitgadget
