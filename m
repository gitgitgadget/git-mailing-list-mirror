Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0497A200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeEGW71 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:59:27 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45425 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeEGW70 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:59:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id bi12-v6so1008138plb.12
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=332Fk0bXRuYw7hUkGDWd+N+sus8WvFZYyVRKBGm/d4M=;
        b=gdIyqBCO7Tfdbc5Bum1Q8uEma24IDNGIQ7qYfqlfx5ACJQqQym7Ehn1LZpk3pqgZm9
         L5u68bpwXZSE2O2RiiRpJulK4g+Ya6sMkk79eSFaAu7UJanu2UyIXSUdW5yXHHbWRQoe
         AplV5funHhfmsyWo///g+oMh4mpF+96lgE+WpAjZ67p3l7wREnAoePIdvkhzDupBgZ71
         ue5g8jHi9HUSOU3M4wTVNyvVjFP1wFmSXYW3n3et8JKk+EAQSC1WaZ//NRe8qigxldAJ
         GPK0pa7KPcjRUXFmHutleMAhRK+hyjtbAxNV6uKYi3kgtTPIzSssSJgeoM2hJ7ypfQXk
         x4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=332Fk0bXRuYw7hUkGDWd+N+sus8WvFZYyVRKBGm/d4M=;
        b=sihPhMJymtKr0HHMcw7uXLXLmQMyeNLORLxYHXjxwOobAHL112VnshJx1fjlyeIz+x
         cae8Wyq25snG8mmMjbnkCU49Zku19gpJkl8Pt7HE/aEx6cgHJEM77Kaiknh+tcYsKw1O
         TanSV7gSuGGycdpQ8epaCU+cx3snmZ/CEQ2to4DwIcWzBS5ZVP62iJfpzBqmEGZy2cP3
         Xupe/9qbUnGMlrC5Dn6k29dZ6PnvsrecoWdQYoJw8Tl90MU0GYQYuUIfAmLXzFO2UrN0
         akStlBbCUDw9F6R2tD3YPI2TrjeIgZMzFjStwGp7hN74u/eHyxNOGbA2SRFOZ0b9mzFc
         q7sA==
X-Gm-Message-State: ALQs6tDtsYEnBtZ/E6u3pOhhp9m8o9vlp2i9xXYuPALK/dcUpJZxwvpm
        tfXqp4EHvFMVl/okFJfB7siJC7pOzxs=
X-Google-Smtp-Source: AB8JxZrN1zp8RqDgad/joGwJxNXZyCv0JlKfEkxufm/Um/mPk0Ahm6L6x47DSGQdjEYReJtpnKWuPQ==
X-Received: by 2002:a17:902:9898:: with SMTP id s24-v6mr38980771plp.51.1525733964429;
        Mon, 07 May 2018 15:59:24 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id s9sm48665776pfa.141.2018.05.07.15.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 15:59:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, jonathantanmy@google.com, gitster@pobox.com,
        jamill@microsoft.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 00/13] object store: alloc
Date:   Mon,  7 May 2018 15:59:03 -0700
Message-Id: <20180507225916.155236-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180501213403.14643-1-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* I decided to stick with alloc.c and not migrate it to the mem-pool for now.
  The reasoning for that is that mem-pool.h would introduce some alignment
  waste, which I really did not want to.
* renamed to struct parsed_object_pool;
* free'd the additional memory of trees and commits.
* do not special case the_repository for allocation purposes
* corrected&polished commit messages
* I used the (soon to be renamed?) branch-diff tool to attach a diff below.
  (I still need to get used to that format, I find an interdiff of the
   branches easier to read, but that would not yield the commit messages)
   
   

v1:
This applies on top of sb/oid-object-info and is the logical continuum of
the series that it builds on; this brings the object store into more of
Gits code, removing global state, such that reasoning about the state of
the in-memory representation of the repository is easier.

My original plan was to convert lookup_commit_graft as the next series,
which would be similar to lookup_replace_object, as in sb/object-store-replace.
The grafts and shallow mechanism are very close to each other, such that
they need to be converted at the same time, both depending on the
"parsed object store" that is introduced in this commit.

The next series will then convert code in {object/blob/tree/commit/tag}.c
hopefully finishing the lookup_* functions.

I also debated if it is worth converting alloc.c via this patch series
or if it might make more sense to use the new mem-pool by Jameson[1].

I vaguely wonder about the performance impact, as the object allocation
code seemed to be relevant in the past.

[1] https://public-inbox.org/git/20180430153122.243976-1-jamill@microsoft.com/

Any comments welcome,
Thanks,
Stefan

Jonathan Nieder (1):
  object: add repository argument to grow_object_hash

Stefan Beller (12):
  repository: introduce parsed objects field
  object: add repository argument to create_object
  alloc: add repository argument to alloc_blob_node
  alloc: add repository argument to alloc_tree_node
  alloc: add repository argument to alloc_commit_node
  alloc: add repository argument to alloc_tag_node
  alloc: add repository argument to alloc_object_node
  alloc: add repository argument to alloc_report
  alloc: add repository argument to alloc_commit_index
  object: allow grow_object_hash to handle arbitrary repositories
  object: allow create_object to handle arbitrary repositories
  alloc: allow arbitrary repositories for alloc functions

 alloc.c           |  63 +++++++++++++++++-----------
 alloc.h           |  15 +++++++
 blame.c           |   3 +-
 blob.c            |   5 ++-
 cache.h           |   9 ----
 commit.c          |   4 +-
 merge-recursive.c |   3 +-
 object.c          | 105 +++++++++++++++++++++++++++++++++-------------
 object.h          |  18 +++++++-
 repository.c      |   7 ++++
 repository.h      |  13 +++++-
 tag.c             |   4 +-
 tree.c            |   4 +-
 13 files changed, 184 insertions(+), 69 deletions(-)
 create mode 100644 alloc.h


1:  94a4aa2a825 ! 1:  c40aae31a1e repository: introduce object parser field
    @@ -1,23 +1,20 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    repository: introduce object parser field
    +    repository: introduce parsed objects field
     
    -    Git's object access code can be thought of as containing two layers:
    -    the raw object store provides access to raw object content, while the
    -    higher level obj_hash code parses raw objects and keeps track of
    -    parenthood and other object relationships using 'struct object'.
    -    Keeping these layers separate should make it easier to find relevant
    -    functions and to change the implementation of one without having to
    -    touch the other.
    +    Convert the existing global cache for parsed objects (obj_hash) into
    +    repository-specific parsed object caches. Existing code that uses
    +    obj_hash are modified to use the parsed object cache of
    +    the_repository; future patches will use the parsed object caches of
    +    other repositories.
     
    -    Add an object_parser field to 'struct repository' to prepare obj_hash
    -    to be handled per repository.  Callers still only use the_repository
    -    for now --- later patches will adapt them to handle arbitrary
    -    repositories.
    +    Another future use case for a pool of objects is ease of memory management
    +    in revision walking: If we can free the rev-list related memory early in
    +    pack-objects (e.g. part of repack operation) then it could lower memory
    +    pressure significantly when running on large repos. While this has been
    +    discussed on the mailing list lately, this series doesn't implement this.
     
    -    Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/object.c b/object.c
     --- a/object.c
    @@ -139,9 +136,9 @@
      	}
      }
      
    -+struct object_parser *object_parser_new(void)
    ++struct parsed_object_pool *parsed_object_pool_new(void)
     +{
    -+	struct object_parser *o = xmalloc(sizeof(*o));
    ++	struct parsed_object_pool *o = xmalloc(sizeof(*o));
     +	memset(o, 0, sizeof(*o));
     +	return o;
     +}
    @@ -154,7 +151,7 @@
      	o->packed_git = NULL;
      }
     +
    -+void object_parser_clear(struct object_parser *o)
    ++void parsed_object_pool_clear(struct parsed_object_pool *o)
     +{
     +	/*
     +	 * TOOD free objects in o->obj_hash.
    @@ -171,13 +168,13 @@
      #ifndef OBJECT_H
      #define OBJECT_H
      
    -+struct object_parser {
    ++struct parsed_object_pool {
     +	struct object **obj_hash;
     +	int nr_objs, obj_hash_size;
     +};
     +
    -+struct object_parser *object_parser_new(void);
    -+void object_parser_clear(struct object_parser *o);
    ++struct parsed_object_pool *parsed_object_pool_new(void);
    ++void parsed_object_pool_clear(struct parsed_object_pool *o);
     +
      struct object_list {
      	struct object *item;
    @@ -198,7 +195,7 @@
      
      	the_repo.index = &the_index;
      	the_repo.objects = raw_object_store_new();
    -+	the_repo.parsed_objects = object_parser_new();
    ++	the_repo.parsed_objects = parsed_object_pool_new();
     +
      	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
      }
    @@ -207,7 +204,7 @@
      	memset(repo, 0, sizeof(*repo));
      
      	repo->objects = raw_object_store_new();
    -+	repo->parsed_objects = object_parser_new();
    ++	repo->parsed_objects = parsed_object_pool_new();
      
      	if (repo_init_gitdir(repo, gitdir))
      		goto error;
    @@ -215,7 +212,7 @@
      	raw_object_store_clear(repo->objects);
      	FREE_AND_NULL(repo->objects);
      
    -+	object_parser_clear(repo->parsed_objects);
    ++	parsed_object_pool_clear(repo->parsed_objects);
     +	FREE_AND_NULL(repo->parsed_objects);
     +
      	if (repo->config) {
    @@ -237,11 +234,13 @@
      	struct raw_object_store *objects;
      
     +	/*
    -+	 * State for the object parser. This owns all parsed objects
    -+	 * (struct object) so callers do not have to manage their
    -+	 * lifetime.
    ++	 * All objects in this repository that have been parsed. This structure
    ++	 * owns all objects it references, so users of "struct object *"
    ++	 * generally do not need to free them; instead, when a repository is no
    ++	 * longer used, call parsed_object_pool_clear() on this structure, which
    ++	 * is called by the repositories repo_clear on its desconstruction.
     +	 */
    -+	struct object_parser *parsed_objects;
    ++	struct parsed_object_pool *parsed_objects;
     +
      	/* The store in which the refs are held. */
      	struct ref_store *refs;
2:  9ddead5bb7e ! 2:  4ce05bb8b04 object: add repository argument to create_object
    @@ -7,14 +7,8 @@
         mechanical change; it doesn't change the implementation to handle
         repositories other than the_repository yet.
     
    -    As with the previous commits, use a macro to catch callers passing a
    -    repository other than the_repository at compile time.
    -
    -    Add the cocci patch that converted the callers.
    -
         Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/blob.c b/blob.c
     --- a/blob.c
3:  5ec44fe74de ! 3:  27e1d2621c4 object: add repository argument to grow_object_hash
    @@ -7,12 +7,8 @@
         mechanical change; it doesn't change the implementation to handle
         repositories other than the_repository yet.
     
    -    As with the previous commits, use a macro to catch callers passing a
    -    repository other than the_repository at compile time.
    -
         Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/object.c b/object.c
     --- a/object.c
4:  2a1d0220eb9 ! 4:  f8c7fc9b26f alloc: add repository argument to alloc_blob_node
    @@ -2,8 +2,12 @@
     
         alloc: add repository argument to alloc_blob_node
     
    +    This is a small mechanical change; it doesn't change the
    +    implementation to handle repositories other than the_repository yet.
    +    Use a macro to catch callers passing a repository other than
    +    the_repository at compile time.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/alloc.c b/alloc.c
     --- a/alloc.c
5:  286cde18ff2 ! 5:  b682e50bd80 alloc: add repository argument to alloc_tree_node
    @@ -2,8 +2,12 @@
     
         alloc: add repository argument to alloc_tree_node
     
    +    This is a small mechanical change; it doesn't change the
    +    implementation to handle repositories other than the_repository yet.
    +    Use a macro to catch callers passing a repository other than
    +    the_repository at compile time.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/alloc.c b/alloc.c
     --- a/alloc.c
6:  b05f0588f37 ! 6:  c89a3f0ca8b alloc: add repository argument to alloc_commit_node
    @@ -2,8 +2,12 @@
     
         alloc: add repository argument to alloc_commit_node
     
    +    This is a small mechanical change; it doesn't change the
    +    implementation to handle repositories other than the_repository yet.
    +    Use a macro to catch callers passing a repository other than
    +    the_repository at compile time.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/alloc.c b/alloc.c
     --- a/alloc.c
7:  e8e25cf61fc ! 7:  59e74c6ef43 alloc: add repository argument to alloc_tag_node
    @@ -2,8 +2,12 @@
     
         alloc: add repository argument to alloc_tag_node
     
    +    This is a small mechanical change; it doesn't change the
    +    implementation to handle repositories other than the_repository yet.
    +    Use a macro to catch callers passing a repository other than
    +    the_repository at compile time.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/alloc.c b/alloc.c
     --- a/alloc.c
8:  dbd4e184121 ! 8:  6c11cf164b1 alloc: add repository argument to alloc_object_node
    @@ -2,8 +2,12 @@
     
         alloc: add repository argument to alloc_object_node
     
    +    This is a small mechanical change; it doesn't change the
    +    implementation to handle repositories other than the_repository yet.
    +    Use a macro to catch callers passing a repository other than
    +    the_repository at compile time.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/alloc.c b/alloc.c
     --- a/alloc.c
9:  ca4a23489b7 ! 9:  eb824871f17 alloc: add repository argument to alloc_report
    @@ -2,8 +2,12 @@
     
         alloc: add repository argument to alloc_report
     
    +    This is a small mechanical change; it doesn't change the
    +    implementation to handle repositories other than the_repository yet.
    +    Use a macro to catch callers passing a repository other than
    +    the_repository at compile time.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/alloc.c b/alloc.c
     --- a/alloc.c
10:  f0f84627ce8 ! 10:  76e214a2254 alloc: add repository argument to alloc_commit_index
    @@ -2,8 +2,12 @@
     
         alloc: add repository argument to alloc_commit_index
     
    +    This is a small mechanical change; it doesn't change the
    +    implementation to handle repositories other than the_repository yet.
    +    Use a macro to catch callers passing a repository other than
    +    the_repository at compile time.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/alloc.c b/alloc.c
     --- a/alloc.c
11:  60f4e269bb8 ! 11:  3a13500d480 object: allow grow_object_hash to handle arbitrary repositories
    @@ -2,9 +2,9 @@
     
         object: allow grow_object_hash to handle arbitrary repositories
     
    +    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/object.c b/object.c
     --- a/object.c
12:  5c0b35cfabf ! 12:  8e06fb06d60 object: allow create_object to handle arbitrary repositories
    @@ -2,9 +2,9 @@
     
         object: allow create_object to handle arbitrary repositories
     
    +    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/object.c b/object.c
     --- a/object.c
13:  10de7382d15 ! 13:  d15807445ad alloc: allow arbitrary repositories for alloc functions
    @@ -12,7 +12,6 @@
         the_repository.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/alloc.c b/alloc.c
     --- a/alloc.c
    @@ -26,11 +25,15 @@
     + * it maintains all the allocation infrastructure, but even more because it ends
       * up with maximal alignment because it doesn't know what the object alignment
       * for the new allocation is.
    -+ *
    -+ * TODO: Combine this with mem-pool?
       */
    - #include "cache.h"
    - #include "object.h"
    +@@
    + #include "tree.h"
    + #include "commit.h"
    + #include "tag.h"
    ++#include "alloc.h"
    + 
    + #define BLOCKING 1024
    + 
     @@
      	int count; /* total number of nodes allocated */
      	int nr;    /* number of nodes left in current allocation */
    @@ -58,19 +61,24 @@
      {
      	void *ret;
     @@
    + 	if (!s->nr) {
    + 		s->nr = BLOCKING;
    + 		s->p = xmalloc(BLOCKING * node_size);
    ++
    ++		ALLOC_GROW(s->slabs, s->slab_nr + 1, s->slab_alloc);
    ++		s->slabs[s->slab_nr++] = s->p;
    + 	}
    + 	s->nr--;
    + 	s->count++;
      	ret = s->p;
      	s->p = (char *)s->p + node_size;
      	memset(ret, 0, node_size);
    -+
    -+	ALLOC_GROW(s->slabs, s->slab_nr + 1, s->slab_alloc);
    -+	s->slabs[s->slab_nr++] = ret;
     +
      	return ret;
      }
      
     -static struct alloc_state blob_state;
     -void *alloc_blob_node_the_repository(void)
    -+struct alloc_state the_repository_blob_state;
     +void *alloc_blob_node(struct repository *r)
      {
     -	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
    @@ -81,7 +89,6 @@
      
     -static struct alloc_state tree_state;
     -void *alloc_tree_node_the_repository(void)
    -+struct alloc_state the_repository_tree_state;
     +void *alloc_tree_node(struct repository *r)
      {
     -	struct tree *t = alloc_node(&tree_state, sizeof(struct tree));
    @@ -92,7 +99,6 @@
      
     -static struct alloc_state tag_state;
     -void *alloc_tag_node_the_repository(void)
    -+struct alloc_state the_repository_tag_state;
     +void *alloc_tag_node(struct repository *r)
      {
     -	struct tag *t = alloc_node(&tag_state, sizeof(struct tag));
    @@ -103,7 +109,6 @@
      
     -static struct alloc_state object_state;
     -void *alloc_object_node_the_repository(void)
    -+struct alloc_state the_repository_object_state;
     +void *alloc_object_node(struct repository *r)
      {
     -	struct object *obj = alloc_node(&object_state, sizeof(union any_object));
    @@ -123,7 +128,6 @@
      }
      
     -void *alloc_commit_node_the_repository(void)
    -+struct alloc_state the_repository_commit_state;
     +void *alloc_commit_node(struct repository *r)
      {
     -	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
    @@ -167,12 +171,6 @@
     +void *allocate_alloc_state(void);
     +void clear_alloc_state(struct alloc_state *s);
     +
    -+extern struct alloc_state the_repository_blob_state;
    -+extern struct alloc_state the_repository_tree_state;
    -+extern struct alloc_state the_repository_commit_state;
    -+extern struct alloc_state the_repository_tag_state;
    -+extern struct alloc_state the_repository_object_state;
    -+
     +#endif
     
     diff --git a/blame.c b/blame.c
    @@ -262,40 +260,47 @@
      #include "object-store.h"
      #include "packfile.h"
     @@
    - 	}
    - }
    - 
    --struct object_parser *object_parser_new(void)
    -+struct object_parser *object_parser_new(int is_the_repo)
      {
    - 	struct object_parser *o = xmalloc(sizeof(*o));
    + 	struct parsed_object_pool *o = xmalloc(sizeof(*o));
      	memset(o, 0, sizeof(*o));
     +
    -+	if (is_the_repo) {
    -+		o->blob_state = &the_repository_blob_state;
    -+		o->tree_state = &the_repository_tree_state;
    -+		o->commit_state = &the_repository_commit_state;
    -+		o->tag_state = &the_repository_tag_state;
    -+		o->object_state = &the_repository_object_state;
    -+	} else {
    -+		o->blob_state = allocate_alloc_state();
    -+		o->tree_state = allocate_alloc_state();
    -+		o->commit_state = allocate_alloc_state();
    -+		o->tag_state = allocate_alloc_state();
    -+		o->object_state = allocate_alloc_state();
    -+	}
    ++	o->blob_state = allocate_alloc_state();
    ++	o->tree_state = allocate_alloc_state();
    ++	o->commit_state = allocate_alloc_state();
    ++	o->tag_state = allocate_alloc_state();
    ++	o->object_state = allocate_alloc_state();
    ++
      	return o;
      }
      
     @@
    - void object_parser_clear(struct object_parser *o)
    + void parsed_object_pool_clear(struct parsed_object_pool *o)
      {
      	/*
     -	 * TOOD free objects in o->obj_hash.
     -	 *
      	 * As objects are allocated in slabs (see alloc.c), we do
      	 * not need to free each object, but each slab instead.
    ++	 *
    ++	 * Before doing so, we need to free any additional memory
    ++	 * the objects may hold.
      	 */
    ++	unsigned i;
    ++
    ++	for (i = 0; i < o->obj_hash_size; i++) {
    ++		struct object *obj = o->obj_hash[i];
    ++
    ++		if (!obj)
    ++			continue;
    ++
    ++		if (obj->type == OBJ_TREE) {
    ++			free(((struct tree*)obj)->buffer);
    ++		} else if (obj->type == OBJ_COMMIT) {
    ++			free_commit_list(((struct commit*)obj)->parents);
    ++			free(&((struct commit*)obj)->util);
    ++		}
    ++	}
    ++
     +	clear_alloc_state(o->blob_state);
     +	clear_alloc_state(o->tree_state);
     +	clear_alloc_state(o->commit_state);
    @@ -307,7 +312,7 @@
     --- a/object.h
     +++ b/object.h
     @@
    - struct object_parser {
    + struct parsed_object_pool {
      	struct object **obj_hash;
      	int nr_objs, obj_hash_size;
     +
    @@ -320,33 +325,7 @@
     +	unsigned commit_count;
      };
      
    --struct object_parser *object_parser_new(void);
    -+struct object_parser *object_parser_new(int is_the_repo);
    - void object_parser_clear(struct object_parser *o);
    - 
    - struct object_list {
    -
    -diff --git a/repository.c b/repository.c
    ---- a/repository.c
    -+++ b/repository.c
    -@@
    - 
    - 	the_repo.index = &the_index;
    - 	the_repo.objects = raw_object_store_new();
    --	the_repo.parsed_objects = object_parser_new();
    -+	the_repo.parsed_objects = object_parser_new(1);
    - 
    - 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
    - }
    -@@
    - 	memset(repo, 0, sizeof(*repo));
    - 
    - 	repo->objects = raw_object_store_new();
    --	repo->parsed_objects = object_parser_new();
    -+	repo->parsed_objects = object_parser_new(0);
    - 
    - 	if (repo_init_gitdir(repo, gitdir))
    - 		goto error;
    + struct parsed_object_pool *parsed_object_pool_new(void);
     
     diff --git a/tag.c b/tag.c
     --- a/tag.c
14:  12e8de9e65c < -:  ----------- alloc.c: include alloc.h


-- 
2.17.0.255.g8bfb7c0704

