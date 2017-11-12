Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1958201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 21:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750932AbdKLV3F (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 16:29:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55954 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750761AbdKLV3E (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 16:29:04 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 42B8B60475;
        Sun, 12 Nov 2017 21:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1510522142;
        bh=Ov7HIGpOmvFXY4rpt4G5LJ31Zsx9AwVibXr2JR78xqs=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qyNcD8dbpNKrq6rwLgkr2RB9BLwxMyBGNg3QGEbccFRoDVO/bYQ0wn67qpzIsB3rJ
         SFy8XOn/1k4pzfHb4nnYtpmzOwmdolUMELGxqn5QjRVMaw+kpuMa6qnzicaZT2CqiV
         Qmnpr3zwanjsfeMaiSNCFDIMOkrqAilhVq0Crj+OTmqsVYjmJjRlG4H7yiZYRt0ddU
         JXY33KQCPR+1aNkcqRlwKXDKnOcsHpNBn17b/8qbdWWhRp9vN5Ss0zueaMSeJjVOIr
         ci+ZQDSWPQsGD4pT3NonGERE/8e3yz+WAle32a0br030tl9LmIYCHcrrY/X/lI9av1
         dMhN6Xb3IJXEprnRXyQIq9eFVA4xh2Y/K4APV5xE7GsuN4pBEVnbogLZXzFHb3USX3
         m4cz16trRbbwhgidECUSkz2vWH4YIEFW9u/J7ZSvippP3VwSzqT+Si4uv0xGree4Qh
         V+o6n1d4NX9CQ6lYmu92n0odauVdgWzqfJWX8NIC37iHcuu59uN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/4] Hash abstraction
Date:   Sun, 12 Nov 2017 21:28:50 +0000
Message-Id: <20171112212854.791179-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series proposing a basic abstraction for hash functions.

The full description of the series can be found here:
https://public-inbox.org/git/20171028181239.59458-1-sandals@crustytoothpaste.net/

At the bottom of this message is the output of git tbdiff between v2 and
v3.

Changes from v2:
* Remove inline.
* Add dummy functions that call die for unknown hash implementation.
* Move structure definitions to hash.h and include git-compat-util.h in
  hash.h.
* Rename current_hash to the_hash_algo.
* Use repo_set_hash_algo everywhere we set the hash algorithm for a
  struct repository.

Changes from v1:
* Rebase onto 2.15-rc2.
* Fix the uninitialized value that Peff pointed out.  This fixes the
  error, but leaves the code in the same place, since I think it's where
  it should be.
* Improve commit message to explain the meaning of current_hash WRT the
  transition plan.
* Added an unknown hash algorithm constant and value to better implement
  the transition plan.
* Explain in the commit message why hex size and binary size are both
  provided.
* Add a format_id field to the struct, in coordination with the
  transition plan.
* Improve comments for struct fields and constants.

brian m. carlson (4):
  setup: expose enumerated repo info
  Add structure representing hash algorithm
  Integrate hash algorithm support with repo setup
  Switch empty tree and blob lookups to use hash abstraction

 builtin/am.c       |  2 +-
 builtin/checkout.c |  2 +-
 builtin/diff.c     |  2 +-
 builtin/pull.c     |  2 +-
 cache.h            | 12 +++++++----
 diff-lib.c         |  2 +-
 hash.h             | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 merge-recursive.c  |  2 +-
 notes-merge.c      |  2 +-
 repository.c       |  7 +++++++
 repository.h       |  5 +++++
 sequencer.c        |  6 +++---
 setup.c            | 49 +++++++++++++++++++++++++--------------------
 sha1_file.c        | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.c        |  2 +-
 15 files changed, 174 insertions(+), 36 deletions(-)

git-tbdiff output:

1: 7de9bc96ff = 1: 1ec859c3a8 setup: expose enumerated repo info
2: fb5099972b ! 2: c9c628b745 Add structure representing hash algorithm
    @@ -23,16 +23,29 @@
         accept input from the user that might be in SHA-1 or in the NewHash
         format.  Since we cannot know which the user has provided, add a
         constant representing the unknown algorithm to allow us to indicate that
    -    we must look the correct value up.
    +    we must look the correct value up.  Provide dummy API functions that die
    +    in this case.
    +    
    +    Finally, include git-compat-util.h in hash.h so that the required types
    +    are available.  This aids people using automated tools their editors.
         
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    -diff --git a/cache.h b/cache.h
    ---- a/cache.h
    -+++ b/cache.h
    +diff --git a/hash.h b/hash.h
    +--- a/hash.h
    ++++ b/hash.h
     @@
    - 	unsigned char hash[GIT_MAX_RAWSZ];
    - };
    + #ifndef HASH_H
    + #define HASH_H
    + 
    ++#include "git-compat-util.h"
    ++
    + #if defined(SHA1_PPC)
    + #include "ppc/sha1.h"
    + #elif defined(SHA1_APPLE)
    +@@
    + #include "block-sha1/sha1.h"
    + #endif
      
     +/*
     + * Note that these constants are suitable for indexing the hash_algos array and
    @@ -89,9 +102,7 @@
     +};
     +extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
     +
    - #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
    - #define DTYPE(de)	((de)->d_type)
    - #else
    + #endif
     
     diff --git a/sha1_file.c b/sha1_file.c
     --- a/sha1_file.c
    @@ -100,19 +111,34 @@
      	EMPTY_BLOB_SHA1_BIN_LITERAL
      };
      
    -+static inline void git_hash_sha1_init(void *ctx)
    ++static void git_hash_sha1_init(void *ctx)
     +{
     +	git_SHA1_Init((git_SHA_CTX *)ctx);
     +}
     +
    -+static inline void git_hash_sha1_update(void *ctx, const void *data, size_t len)
    ++static void git_hash_sha1_update(void *ctx, const void *data, size_t len)
     +{
     +	git_SHA1_Update((git_SHA_CTX *)ctx, data, len);
     +}
     +
    -+static inline void git_hash_sha1_final(unsigned char *hash, void *ctx)
    ++static void git_hash_sha1_final(unsigned char *hash, void *ctx)
     +{
     +	git_SHA1_Final(hash, (git_SHA_CTX *)ctx);
    ++}
    ++
    ++static void git_hash_unknown_init(void *ctx)
    ++{
    ++	die("trying to init unknown hash");
    ++}
    ++
    ++static void git_hash_unknown_update(void *ctx, const void *data, size_t len)
    ++{
    ++	die("trying to update unknown hash");
    ++}
    ++
    ++static void git_hash_unknown_final(unsigned char *hash, void *ctx)
    ++{
    ++	die("trying to finalize unknown hash");
     +}
     +
     +const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
    @@ -122,9 +148,9 @@
     +		0,
     +		0,
     +		0,
    -+		NULL,
    -+		NULL,
    -+		NULL,
    ++		git_hash_unknown_init,
    ++		git_hash_unknown_update,
    ++		git_hash_unknown_final,
     +		NULL,
     +		NULL,
     +	},
3: da7ea2e17a ! 3: 30ad79b734 Integrate hash algorithm support with repo setup
    @@ -9,7 +9,7 @@
         read_repository_format.  In the future, we'll enumerate this value from
         the configuration.
         
    -    Add a constant, current_hash, which points to the hash_algo structure
    +    Add a constant, the_hash_algo, which points to the hash_algo structure
         pointer in the repository global.  Note that this is the hash which is
         used to serialize data to disk, not the hash which is used to display
         items to the user.  The transition plan anticipates that these may be
    @@ -33,10 +33,10 @@
      #ifndef platform_SHA_CTX
      /*
     @@
    + 	unsigned char hash[GIT_MAX_RAWSZ];
      };
    - extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
      
    -+#define current_hash the_repository->hash_algo
    ++#define the_hash_algo the_repository->hash_algo
     +
      #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
      #define DTYPE(de)	((de)->d_type)
    @@ -69,7 +69,7 @@
      	if (read_and_verify_repository_format(&format, repo->commondir))
      		goto error;
      
    -+	repo->hash_algo = &hash_algos[format.hash_algo];
    ++	repo_set_hash_algo(repo, format.hash_algo);
     +
      	if (worktree)
      		repo_set_worktree(repo, worktree);
4: d17b67e4ed ! 4: cfe5e8cadd Switch empty tree and blob lookups to use hash abstraction
    @@ -16,7 +16,7 @@
      		tree = lookup_tree(&head);
      	else
     -		tree = lookup_tree(&empty_tree_oid);
    -+		tree = lookup_tree(current_hash->empty_tree);
    ++		tree = lookup_tree(the_hash_algo->empty_tree);
      
      	fp = xfopen(am_path(state, "patch"), "w");
      	init_revisions(&rev_info, NULL);
    @@ -29,7 +29,7 @@
      		tree = parse_tree_indirect(old->commit ?
      					   &old->commit->object.oid :
     -					   &empty_tree_oid);
    -+					   current_hash->empty_tree);
    ++					   the_hash_algo->empty_tree);
      		init_tree_desc(&trees[0], tree->buffer, tree->size);
      		tree = parse_tree_indirect(&new->commit->object.oid);
      		init_tree_desc(&trees[1], tree->buffer, tree->size);
    @@ -42,7 +42,7 @@
      				if (!rev.pending.nr) {
      					struct tree *tree;
     -					tree = lookup_tree(&empty_tree_oid);
    -+					tree = lookup_tree(current_hash->empty_tree);
    ++					tree = lookup_tree(the_hash_algo->empty_tree);
      					add_pending_object(&rev, &tree->object, "HEAD");
      				}
      				break;
    @@ -55,10 +55,10 @@
      	 * branch.
      	 */
     -	if (checkout_fast_forward(&empty_tree_oid, merge_head, 0))
    -+	if (checkout_fast_forward(current_hash->empty_tree, merge_head, 0))
    ++	if (checkout_fast_forward(the_hash_algo->empty_tree, merge_head, 0))
      		return 1;
      
    - 	if (update_ref("initial pull", "HEAD", merge_head->hash, curr_head->hash, 0, UPDATE_REFS_DIE_ON_ERR))
    + 	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
     
     diff --git a/cache.h b/cache.h
     --- a/cache.h
    @@ -68,25 +68,25 @@
      static inline int is_empty_blob_sha1(const unsigned char *sha1)
      {
     -	return !hashcmp(sha1, EMPTY_BLOB_SHA1_BIN);
    -+	return !hashcmp(sha1, current_hash->empty_blob->hash);
    ++	return !hashcmp(sha1, the_hash_algo->empty_blob->hash);
      }
      
      static inline int is_empty_blob_oid(const struct object_id *oid)
      {
     -	return !hashcmp(oid->hash, EMPTY_BLOB_SHA1_BIN);
    -+	return !oidcmp(oid, current_hash->empty_blob);
    ++	return !oidcmp(oid, the_hash_algo->empty_blob);
      }
      
      static inline int is_empty_tree_sha1(const unsigned char *sha1)
      {
     -	return !hashcmp(sha1, EMPTY_TREE_SHA1_BIN);
    -+	return !hashcmp(sha1, current_hash->empty_tree->hash);
    ++	return !hashcmp(sha1, the_hash_algo->empty_tree->hash);
      }
      
      static inline int is_empty_tree_oid(const struct object_id *oid)
      {
     -	return !hashcmp(oid->hash, EMPTY_TREE_SHA1_BIN);
    -+	return !oidcmp(oid, current_hash->empty_tree);
    ++	return !oidcmp(oid, the_hash_algo->empty_tree);
      }
      
      /* set default permissions by passing mode arguments to open(2) */
    @@ -99,7 +99,7 @@
      				   ce_intent_to_add(ce)) {
      				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
     -					       &empty_tree_oid, 0,
    -+					       current_hash->empty_tree, 0,
    ++					       the_hash_algo->empty_tree, 0,
      					       ce->name, 0);
      				continue;
      			}
    @@ -112,7 +112,7 @@
      		struct tree *tree;
      
     -		tree = lookup_tree(&empty_tree_oid);
    -+		tree = lookup_tree(current_hash->empty_tree);
    ++		tree = lookup_tree(the_hash_algo->empty_tree);
      		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
      	}
      
    @@ -125,7 +125,7 @@
      	if (!bases) {
      		base_oid = &null_oid;
     -		base_tree_oid = &empty_tree_oid;
    -+		base_tree_oid = current_hash->empty_tree;
    ++		base_tree_oid = the_hash_algo->empty_tree;
      		if (o->verbosity >= 4)
      			printf("No merge base found; doing history-less merge\n");
      	} else if (!bases->next) {
    @@ -138,7 +138,7 @@
      static struct tree *empty_tree(void)
      {
     -	return lookup_tree(&empty_tree_oid);
    -+	return lookup_tree(current_hash->empty_tree);
    ++	return lookup_tree(the_hash_algo->empty_tree);
      }
      
      static int error_dirty_index(struct replay_opts *opts)
    @@ -147,7 +147,7 @@
      		ptree_oid = &parent->tree->object.oid;
      	} else {
     -		ptree_oid = &empty_tree_oid; /* commit is root */
    -+		ptree_oid = current_hash->empty_tree; /* commit is root */
    ++		ptree_oid = the_hash_algo->empty_tree; /* commit is root */
      	}
      
      	return !oidcmp(ptree_oid, &commit->tree->object.oid);
    @@ -156,10 +156,10 @@
      		unborn = get_oid("HEAD", &head);
      		if (unborn)
     -			oidcpy(&head, &empty_tree_oid);
    -+			oidcpy(&head, current_hash->empty_tree);
    - 		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0, 0))
    ++			oidcpy(&head, the_hash_algo->empty_tree);
    + 		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD",
    + 				       NULL, 0))
      			return error_dirty_index(opts);
    - 	}
     
     diff --git a/submodule.c b/submodule.c
     --- a/submodule.c
    @@ -169,7 +169,7 @@
      		unsigned dirty_submodule)
      {
     -	const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
    -+	const struct object_id *old = current_hash->empty_tree, *new = current_hash->empty_tree;
    ++	const struct object_id *old = the_hash_algo->empty_tree, *new = the_hash_algo->empty_tree;
      	struct commit *left = NULL, *right = NULL;
      	struct commit_list *merge_bases = NULL;
      	struct child_process cp = CHILD_PROCESS_INIT;
