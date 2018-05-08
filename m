Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82997200B9
	for <e@80x24.org>; Tue,  8 May 2018 19:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755356AbeEHTho (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 15:37:44 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34884 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeEHThm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 15:37:42 -0400
Received: by mail-pg0-f41.google.com with SMTP id j11-v6so21598653pgf.2
        for <git@vger.kernel.org>; Tue, 08 May 2018 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ryEd0qQ5nLu9nf6rVVgP97c7RBeLTY+Ry3CMgHXcoT0=;
        b=Ynw9Tpwa0save/o0pDRL2YVp+9Aye9/NDX48veqy0iGks1jIKxkZmjjmHUqAIPUTi/
         h/SXDC9c+YlQKbh7Wg/5c9S/2Nuhz4i63QdjExynfPeDjnEc9CPsf32TMXfUGEa8D9+g
         pnoDS8HAuvUlplSTphDmWLi2j9XpFRZSzNSLSYGRAp34K/hDva12zQk6iSlScGWGMdye
         pAvt57GyR/kW+tvXiLEymUmulrd1qRKsB9CBjwIK8ZsYE9mD5qJkWxdHspdsaW2B2VRO
         PNmMybLiY5sVVUNRwL9cvGZ/LHNqPZcFwKaGKt563y5GTUUNWhLpZ4rLcMTkReLxJyZJ
         JssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ryEd0qQ5nLu9nf6rVVgP97c7RBeLTY+Ry3CMgHXcoT0=;
        b=NeCrUQutUuQa/vEemFKdhS7pvxlGoNlDEq77VLHI5bAHIjO4iQCGZmDTfwqT6S6gVA
         LsSj1GM8Gbid1epdhOcmyYUoEF8EIXmsChYEyk5FH4AS2NJ3KznTqLMfEicS9wsW0KV0
         JNypeF/R6qGD4/u8MQUZ7zSXkff5JxiECw2zmniaPA/L7Hm+NDcS1G2wQdntwTD2SAFg
         mtLuBy71VmVVhT2hVXI922tGlXZSxpINCRoAMQTz0+nV3J7rQGJNugEKSqVlNGamO45N
         4zBEGFbIBwa24MzcCbild/8oVPmTDPPeZegqFYeRT09jSVmot5cgtXlMWMkrQF5dcVZA
         yPYw==
X-Gm-Message-State: ALQs6tC5wWbov5Q2Ju1lCoEV+xNr1j2er4voCcN/LFZKxvx8sJFmKsBY
        mXanscPpV+MfDQQx1Oks3b3RVLc5kAI=
X-Google-Smtp-Source: AB8JxZpWd2JVxYole5oudyMp/919jetVfIo5+1nKzbd/o63opC9qm8m1mr2fKxv4RdjTCZayUBqXLg==
X-Received: by 2002:a65:4d44:: with SMTP id j4-v6mr17733733pgt.344.1525808261870;
        Tue, 08 May 2018 12:37:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v23sm45759276pfe.166.2018.05.08.12.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 12:37:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: [PATCH v3 00/13] object store: alloc
Date:   Tue,  8 May 2018 12:37:23 -0700
Message-Id: <20180508193736.14883-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180507225916.155236-1-sbeller@google.com>
References: <20180507225916.155236-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:

* I used the (soon to be renamed?) branch-diff tool to attach a diff below
  between v2 and v3 
  
* fixed comment in patch 1
* correctly free objects and its hashmap in the last patch.
* drop free'ing the commit->util pointer as we do not know where
  it points to.

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

 alloc.c           |  79 ++++++++++++++++++++++-----------
 alloc.h           |  23 ++++++++++
 blame.c           |   3 +-
 blob.c            |   5 ++-
 cache.h           |   9 ----
 commit.c          |   4 +-
 merge-recursive.c |   3 +-
 object.c          | 108 ++++++++++++++++++++++++++++++++++------------
 object.h          |  18 +++++++-
 repository.c      |   7 +++
 repository.h      |   9 ++++
 tag.c             |   4 +-
 tree.c            |   4 +-
 13 files changed, 208 insertions(+), 68 deletions(-)
 create mode 100644 alloc.h

-- 
2.17.0.255.g8bfb7c0704

1:  9efc685875b ! 1:  f8e521c7c11 repository: introduce parsed objects field
    @@ -15,7 +15,6 @@
         discussed on the mailing list lately, this series doesn't implement this.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/object.c b/object.c
     --- a/object.c
    @@ -224,13 +223,6 @@
     --- a/repository.h
     +++ b/repository.h
     @@
    - 	char *commondir;
    - 
    - 	/*
    --	 * Holds any information related to accessing the raw object content.
    -+	 * Holds any information needed to retrieve the raw content
    -+	 * of objects. The object_parser uses this to get object
    -+	 * content which it then parses.
      	 */
      	struct raw_object_store *objects;
      
2:  0d41290a9e6 = 2:  55c555b32eb object: add repository argument to create_object
3:  0242ec870f5 = 3:  f1661c9e46a object: add repository argument to grow_object_hash
4:  9a6aeee10db = 4:  f72b25db946 alloc: add repository argument to alloc_blob_node
5:  f7ed8da3909 = 5:  87b7ddda195 alloc: add repository argument to alloc_tree_node
6:  253f1bf5c2a = 6:  4480e916bdf alloc: add repository argument to alloc_commit_node
7:  4f8d3dfd460 = 7:  c3aa2a7c252 alloc: add repository argument to alloc_tag_node
8:  6ce5d5b0f0e = 8:  59d33cfaff2 alloc: add repository argument to alloc_object_node
9:  104f158fc37 = 9:  2ba78c289c1 alloc: add repository argument to alloc_report
10:  38d90052c29 = 10:  10ce6c44d4b alloc: add repository argument to alloc_commit_index
11:  eae3dea5763 = 11:  eae95e75b0b object: allow grow_object_hash to handle arbitrary repositories
12:  d08b382662f = 12:  c6d86c8b5db object: allow create_object to handle arbitrary repositories
13:  f87e600c439 ! 13:  2a56520e7af alloc: allow arbitrary repositories for alloc functions
    @@ -139,6 +139,25 @@
      	return c;
      }
      
    ++void release_tree_node(struct tree *t)
    ++{
    ++	free(t->buffer);
    ++}
    ++
    ++void release_commit_node(struct commit *c)
    ++{
    ++	free_commit_list(c->parents);
    ++	/* TODO: what about commit->util? */
    ++}
    ++
    ++void release_tag_node(struct tag *t)
    ++{
    ++	free(t->tag);
    ++}
    ++
    + static void report(const char *name, unsigned int count, size_t size)
    + {
    + 	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
     @@
      }
      
    @@ -161,6 +180,10 @@
     +#ifndef ALLOC_H
     +#define ALLOC_H
     +
    ++struct tree;
    ++struct commit;
    ++struct tag;
    ++
     +void *alloc_blob_node(struct repository *r);
     +void *alloc_tree_node(struct repository *r);
     +void *alloc_commit_node(struct repository *r);
    @@ -172,6 +195,10 @@
     +void *allocate_alloc_state(void);
     +void clear_alloc_state(struct alloc_state *s);
     +
    ++void release_tree_node(struct tree *t);
    ++void release_commit_node(struct commit *c);
    ++void release_tag_node(struct tag *t);
    ++
     +#endif
     
     diff --git a/blame.c b/blame.c
    @@ -241,25 +268,25 @@
     --- a/merge-recursive.c
     +++ b/merge-recursive.c
     @@
    - #include "tree-walk.h"
      #include "diff.h"
      #include "diffcore.h"
    -+#include "alloc.h"
      #include "tag.h"
    ++#include "alloc.h"
      #include "unpack-trees.h"
      #include "string-list.h"
    + #include "xdiff-interface.h"
     
     diff --git a/object.c b/object.c
     --- a/object.c
     +++ b/object.c
     @@
    - #include "blob.h"
      #include "tree.h"
      #include "commit.h"
    -+#include "alloc.h"
      #include "tag.h"
    ++#include "alloc.h"
      #include "object-store.h"
      #include "packfile.h"
    + 
     @@
      {
      	struct parsed_object_pool *o = xmalloc(sizeof(*o));
    @@ -294,14 +321,17 @@
     +		if (!obj)
     +			continue;
     +
    -+		if (obj->type == OBJ_TREE) {
    -+			free(((struct tree*)obj)->buffer);
    -+		} else if (obj->type == OBJ_COMMIT) {
    -+			free_commit_list(((struct commit*)obj)->parents);
    -+			free(&((struct commit*)obj)->util);
    -+		}
    ++		if (obj->type == OBJ_TREE)
    ++			release_tree_node((struct tree*)obj);
    ++		else if (obj->type == OBJ_COMMIT)
    ++			release_commit_node((struct commit*)obj);
    ++		else if (obj->type == OBJ_TAG)
    ++			release_tag_node((struct tag*)obj);
     +	}
     +
    ++	FREE_AND_NULL(o->obj_hash);
    ++	o->obj_hash_size = 0;
    ++
     +	clear_alloc_state(o->blob_state);
     +	clear_alloc_state(o->tree_state);
     +	clear_alloc_state(o->commit_state);
