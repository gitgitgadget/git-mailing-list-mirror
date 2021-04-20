Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD396C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C293613CE
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhDTMvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTMvU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:51:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD5FC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n2so58062322ejy.7
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uL2MpLGKY/1AOETgL7RV7uC8IeCSKgPOTZmp7V6j4LE=;
        b=O4wjvkrJuIu0OzXdjRK7vRR8zR/aKeVTQr5AP+nKPfut3t3VbbZKAVcc4m50/mJ5wg
         +CMVLoa5iaE1LImP3ienq/jw2KtcxR6+zDrNtF7gHAnDfdQ/Zlt9LpykxRRt+GZwDEaV
         Jlgp/y+nhCRMDcyCWCu+Ap4wAEbjnjnWjGARVFgcnFp6q7piS8+5ZUy46i/HIqHY/LbD
         noY3iu12IQpmN+K9QOZGXVnywNPbwWSM2+odacIOG73vDSTOO7HltpdvB3vroSuniqGg
         2MNMkCmbjBYDJbQ1Qvfs6XuFFNTVGRJn+cSpa4saQVsqmOnIxQPETfbO7mUgRqtQ0jQh
         X3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uL2MpLGKY/1AOETgL7RV7uC8IeCSKgPOTZmp7V6j4LE=;
        b=koGgK5tUC0nicXVWHySxBS5II6vbZL9Wolr0pCgoeWxRfD54LMSqct5NvwjnS6p5nq
         VmF8iYm09k5C7Tp8Krdy8JMa4Ij8GidHDsu7n9D3RNtyxmdGmE/tZHf9+4ZcE3oIjnTg
         ZHOFLH9ztAOjn2ilaxIwQl7dKLN5IYJR1foy67Gtsgb0VIZXil9bK0HsMSyhRGT0Xvo7
         0ufqWYF7DJKXhWGAFiT3NsISfiZyaFHpNXKlrY7dUItLHCRlDvsFgd19tuwtyvZG77e7
         D/+ffvEngc7lwUib1eMicSjO/fzKep0M21CcktVSrHhLUgO2pM3cDBE4JPWDHVvKNAao
         iX2Q==
X-Gm-Message-State: AOAM531uO0nP9ef5iv21SdStl+LQrRbySkzo+pFUFjJ0bD7nv22X3f3q
        9iWI6Rt/2u+mJhBhb1B+uLk3lRdk1XgZEA==
X-Google-Smtp-Source: ABdhPJy7xoYM4fRgCzF01Qd/dLjrE+ZyfC0qKbspK8aDDfCswRB6keG6VyybhTIdY6ffnv0kd/Iagw==
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr27599412ejf.25.1618923045802;
        Tue, 20 Apr 2021 05:50:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f3sm12630900eje.45.2021.04.20.05.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:50:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] object.c et al: tests, small bug fixes etc.
Date:   Tue, 20 Apr 2021 14:50:33 +0200
Message-Id: <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of my v1 "blob/object.c: trivial readability
improvements"[1] which has grown from 2 patches to 10. As suggested by
Jeff King in v1 we can entirely get rid of parse_blob_buffer(), so we
now do that.

The other reason this has grown is to resolve a semantic conflict that
came up with type_from_string() and type_from_string_gently() early,
between this and the series I'm about to re-roll on top of it we'll
also remove the "emit an error" argument to type_from_string_gently().

This involves going through some existing callers ande improving their
error messages, and fixing some subtle existing bugs.

1. https://lore.kernel.org/git/cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (10):
  cat-file tests: test for bogus type name handling
  hash-object tests: more detailed test for invalid type
  mktree tests: add test for invalid object type
  object-file.c: take type id, not string, in
    read_object_with_reference()
  {commit,tree,blob,tag}.c: add a create_{commit,tree,blob,tag}()
  blob.c: remove parse_blob_buffer()
  object.c: simplify return semantic of parse_object_buffer()
  object.c: don't go past "len" under die() in type_from_string_gently()
  mktree: stop setting *ntr++ to NIL
  mktree: emit a more detailed error when the <type> is invalid

 blob.c                      | 13 ++++++-------
 blob.h                      | 12 +-----------
 builtin/cat-file.c          |  7 ++++---
 builtin/fast-import.c       |  6 +++---
 builtin/grep.c              |  4 ++--
 builtin/mktree.c            | 23 ++++++++++++++++-------
 builtin/pack-objects.c      |  2 +-
 cache.h                     |  2 +-
 commit-graph.c              |  2 +-
 commit.c                    |  7 ++++++-
 commit.h                    |  1 +
 object-file.c               |  7 +++----
 object.c                    | 26 +++++++++++++-------------
 t/helper/test-fast-rebase.c |  4 ++--
 t/t1006-cat-file.sh         | 16 ++++++++++++++++
 t/t1007-hash-object.sh      | 12 ++++++++++--
 t/t1010-mktree.sh           | 10 ++++++++++
 tag.c                       |  7 ++++++-
 tree-walk.c                 |  6 +++---
 tree.c                      |  7 ++++++-
 20 files changed, 111 insertions(+), 63 deletions(-)

Range-diff against v1:
 -:  ---------- >  1:  5818eca45d cat-file tests: test for bogus type name handling
 -:  ---------- >  2:  0b48389325 hash-object tests: more detailed test for invalid type
 -:  ---------- >  3:  cd585017a9 mktree tests: add test for invalid object type
 -:  ---------- >  4:  48aca62864 object-file.c: take type id, not string, in read_object_with_reference()
 -:  ---------- >  5:  5213d500b9 {commit,tree,blob,tag}.c: add a create_{commit,tree,blob,tag}()
 1:  68a7709fe5 !  6:  02c8d2a9ba blob.c: remove buffer & size arguments to parse_blob_buffer()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    blob.c: remove buffer & size arguments to parse_blob_buffer()
    +    blob.c: remove parse_blob_buffer()
     
         As noted in the comment introduced in 837d395a5c0 (Replace
         parse_blob() with an explanatory comment, 2010-01-18) the old
    -    parse_blob() function and the current parse_blob_buffer() exist merely
    -    to provide consistency in the API.
    +    parse_blob() function and the parse_blob_buffer() existed to provide
    +    consistency in the API.
    +
    +    See bd2c39f58f9 ([PATCH] don't load and decompress objects twice with
    +    parse_object(), 2005-05-06) for the introduction of
    +    parse_blob_buffer().
     
         We're not going to parse blobs like we "parse" commits, trees or
    -    tags. So let's not have the parse_blob_buffer() take arguments that
    -    pretends that we do. Its only use is to set the "parsed" flag.
    +    tags. So we should not have the parse_blob_buffer() take arguments
    +    that pretends that we do. Its only use is to set the "parsed" flag.
     
    -    See bd2c39f58f9 ([PATCH] don't load and decompress objects twice with
    -    parse_object(), 2005-05-06) for the introduction of parse_blob_buffer().
    +    So let's entirely remove the function, and use our newly created
    +    create_blob() for the allocation. We can then set the "parsed" flag
    +    directly in parse_object_buffer() and parse_object() instead.
     
    -    I'm moving the prototype of parse_blob_buffer() below the comment
    -    added in 837d395a5c0 while I'm at it. That comment was originally
    -    meant to be a replacement for the missing parse_blob() function, but
    -    it's much less confusing to have it be above the parse_blob_buffer()
    -    function it refers to.
    +    At this point I could move the comment added in 837d395a5c0 to one or
    +    both of those object.c function, but let's just delete it instead. I
    +    think it's obvious from the flow of the code what's going on
    +    here. Setting the parsed flag no longer happens at a distance, so why
    +    we're doing it isn't unclear anymore.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## blob.c ##
    +@@
    + 
    + const char *blob_type = "blob";
    + 
    +-static struct blob *create_blob(struct repository *r, const struct object_id *oid)
    ++struct blob *create_blob(struct repository *r, const struct object_id *oid)
    + {
    + 	return create_object(r, oid, alloc_blob_node(r));
    + }
     @@ blob.c: struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
    + 		return create_blob(r, oid);
      	return object_as_type(obj, OBJ_BLOB, 0);
      }
    - 
    +-
     -int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
    -+int parse_blob_buffer(struct blob *item)
    - {
    - 	item->object.parsed = 1;
    - 	return 0;
    +-{
    +-	item->object.parsed = 1;
    +-	return 0;
    +-}
     
      ## blob.h ##
     @@ blob.h: struct blob {
    + 	struct object object;
    + };
      
    ++struct blob *create_blob(struct repository *r, const struct object_id *oid);
      struct blob *lookup_blob(struct repository *r, const struct object_id *oid);
      
     -int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
     -
    - /**
    -  * Blobs do not contain references to other objects and do not have
    -  * structured data that needs parsing. However, code may use the
    -@@ blob.h: int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
    -  * parse_blob_buffer() is used (by object.c) to flag that the object
    -  * has been read successfully from the database.
    -  **/
    -+int parse_blob_buffer(struct blob *item);
    - 
    +-/**
    +- * Blobs do not contain references to other objects and do not have
    +- * structured data that needs parsing. However, code may use the
    +- * "parsed" bit in the struct object for a blob to determine whether
    +- * its content has been found to actually be available, so
    +- * parse_blob_buffer() is used (by object.c) to flag that the object
    +- * has been read successfully from the database.
    +- **/
    +-
      #endif /* BLOB_H */
     
      ## object.c ##
    @@ object.c: struct object *parse_object_buffer(struct repository *r, const struct
      		struct blob *blob = lookup_blob(r, oid);
      		if (blob) {
     -			if (parse_blob_buffer(blob, buffer, size))
    -+			if (parse_blob_buffer(blob))
    - 				return NULL;
    +-				return NULL;
    ++			blob->object.parsed = 1;
      			obj = &blob->object;
      		}
    + 	} else if (type == OBJ_TREE) {
     @@ object.c: struct object *parse_object(struct repository *r, const struct object_id *oid)
    + 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
    + 	    (!obj && repo_has_object_file(r, oid) &&
    + 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
    ++		if (!obj) {
    ++			struct blob *blob = create_blob(r, oid);
    ++			obj = &blob->object;
    ++		}
    + 		if (check_object_signature(r, repl, NULL, 0, NULL) < 0) {
      			error(_("hash mismatch %s"), oid_to_hex(oid));
      			return NULL;
      		}
     -		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
    -+		parse_blob_buffer(lookup_blob(r, oid));
    - 		return lookup_object(r, oid);
    +-		return lookup_object(r, oid);
    ++		obj->parsed = 1;
    ++		return obj;
      	}
      
    + 	buffer = repo_read_object_file(r, oid, &type, &size);
 2:  f1fcc31717 !  7:  ee0b572f7d object.c: initialize automatic variable in lookup_object()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object.c: initialize automatic variable in lookup_object()
    +    object.c: simplify return semantic of parse_object_buffer()
     
    -    Initialize a "struct object obj*" variable to NULL explicitly and
    -    return it instead of leaving it uninitialized until the "while"
    -    loop.
    +    Remove the local "obj" variable from parse_object_buffer() and return
    +    the object directly instead.
     
    -    There was no bug here, it's just less confusing when debugging if the
    -    "obj" is either NULL or a valid object, not some random invalid
    -    pointer.
    +    The reason this variable was introduced was to free() a variable
    +    before returning in bd2c39f58f9 ([PATCH] don't load and decompress
    +    objects twice with parse_object() 2005-05-06). But that was when
    +    parse_object_buffer() didn't exist, there was only the parse_object()
    +    function.
     
    -    See 0556a11a0df (git object hash cleanups, 2006-06-30) for the initial
    -    implementation.
    +    Since the split-up of the two in 9f613ddd21c (Add git-for-each-ref:
    +    helper for language bindings, 2006-09-15) we have not needed this
    +    variable, and as demonstrated here not having to set it to (re)set it
    +    to NULL simplifies the function.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object.c ##
    -@@ object.c: static void insert_obj_hash(struct object *obj, struct object **hash, unsigned i
    - struct object *lookup_object(struct repository *r, const struct object_id *oid)
    +@@ object.c: struct object *lookup_unknown_object(const struct object_id *oid)
    + 
    + struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
      {
    - 	unsigned int i, first;
     -	struct object *obj;
    -+	struct object *obj = NULL;
    + 	*eaten_p = 0;
      
    - 	if (!r->parsed_objects->obj_hash)
    --		return NULL;
    -+		return obj;
    +-	obj = NULL;
    + 	if (type == OBJ_BLOB) {
    + 		struct blob *blob = lookup_blob(r, oid);
    + 		if (blob) {
    + 			blob->object.parsed = 1;
    +-			obj = &blob->object;
    ++			return &blob->object;
    + 		}
    + 	} else if (type == OBJ_TREE) {
    + 		struct tree *tree = lookup_tree(r, oid);
    + 		if (tree) {
    +-			obj = &tree->object;
    + 			if (!tree->buffer)
    + 				tree->object.parsed = 0;
    + 			if (!tree->object.parsed) {
    +@@ object.c: struct object *parse_object_buffer(struct repository *r, const struct object_id
    + 					return NULL;
    + 				*eaten_p = 1;
    + 			}
    ++			return &tree->object;
    + 		}
    + 	} else if (type == OBJ_COMMIT) {
    + 		struct commit *commit = lookup_commit(r, oid);
    +@@ object.c: struct object *parse_object_buffer(struct repository *r, const struct object_id
    + 				set_commit_buffer(r, commit, buffer, size);
    + 				*eaten_p = 1;
    + 			}
    +-			obj = &commit->object;
    ++			return &commit->object;
    + 		}
    + 	} else if (type == OBJ_TAG) {
    + 		struct tag *tag = lookup_tag(r, oid);
    + 		if (tag) {
    + 			if (parse_tag_buffer(r, tag, buffer, size))
    + 			       return NULL;
    +-			obj = &tag->object;
    ++			return &tag->object;
    + 		}
    + 	} else {
    + 		warning(_("object %s has unknown type id %d"), oid_to_hex(oid), type);
    +-		obj = NULL;
    + 	}
    +-	return obj;
    ++	return NULL;
    + }
      
    - 	first = i = hash_obj(oid, r->parsed_objects->obj_hash_size);
    - 	while ((obj = r->parsed_objects->obj_hash[i]) != NULL) {
    + struct object *parse_object_or_die(const struct object_id *oid,
 -:  ---------- >  8:  f652d0fb5c object.c: don't go past "len" under die() in type_from_string_gently()
 -:  ---------- >  9:  e463fe5f6a mktree: stop setting *ntr++ to NIL
 -:  ---------- > 10:  fe75526a65 mktree: emit a more detailed error when the <type> is invalid
-- 
2.31.1.723.ga5d7868e4a

