Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A56C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFA260551
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhHKHqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhHKHqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 03:46:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F93AC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j1so2057524pjv.3
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qnew8SVjdxwBSdhvp7iLhy5q9WFwf9znTIwImuPBCnw=;
        b=rh+Rl3J7GBaq3FN1M1WIJALeTAaq0pFyaAJUlEePxgJCutdAwFLD8+nmSjrHpCbgix
         UgDbNCSNBgxl2meNgUxoyoWVtCbx1ICPD10CoRk9RG58xwxMpegU81bWCdP35EUk/6pc
         gYyDb/J+8MEtI4hKO2aAVmW6APfhgNzRzVycmVl6Zo/6gjU9i7uMv8sepOI+DGJQqgVZ
         2F8D/1qgOZKKFsi3X+dLZJWoHqVl+mCGNu+O1DinHNl1CaFfQXycVujel3JaWSVHuFvq
         07g7ACUtLBXEGztIv6zkr9rvTn6/Wrc68Id28jDadavWAl4zBn/6udkJr58rK7f1iTCN
         6wUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qnew8SVjdxwBSdhvp7iLhy5q9WFwf9znTIwImuPBCnw=;
        b=IL0zKVaaWsRwfpJeezh769ZUAgjisRRg/aZa9kVTpEqEiRKXA1lBh4w9O+rKSRaNL9
         5g/CtYf9g9ou1SNj4xqeJMXlSRePNL1zbMgQwmO4+odShO9l37HK6AWyKj2ObPm211j9
         k9vbWQaoVJSFztVpKe7+S4swYbQXPU7x97MVRG4gEHlmuozkF0ZM64TfRhgSQzi3QOGb
         0VXdaiT7+1SMBdJTbJS24Zld15tcVad5Em23AR4BlXR69iGMGe7wAapA248YV5yiUuio
         bXWhoH9gsbONv6ZNTEH416vm9ZViW0UQK7chZn04LWl9L0ijGxlKqBQ6ugRVDjWwZHPf
         MWJg==
X-Gm-Message-State: AOAM531UBC+aT2cadqN/rgqSl4dhyNUSMnDMgIEto9gI1vrXUDgSfURb
        RXwXaC7AtIHjKuDWlckFP74=
X-Google-Smtp-Source: ABdhPJxQ36jVmlwtEMxrzipj9j7kAchqkC77G3SbiN4QYrhhJOBh2g28cUb9DkcsHnoe7SpObHoxgQ==
X-Received: by 2002:a17:90b:3b83:: with SMTP id pc3mr9181486pjb.42.1628667972504;
        Wed, 11 Aug 2021 00:46:12 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id u13sm26179672pfi.51.2021.08.11.00.46.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 00:46:11 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v4 0/7] packfile-uris: commits and trees exclusion
Date:   Wed, 11 Aug 2021 15:45:47 +0800
Message-Id: <cover.1628666093.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.449.gb2aa5456a8.dirty
In-Reply-To: <cover.1627292424.git.dyroneteng@gmail.com>
References: <cover.1627292424.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v4:

* Remove subjective words in commit message.
* Add background descriptions in commit message.
* Big commit split.
* Fix `t/t5702-protocol-v2.sh` indent problems.
* Test commit split(cleanup and new test case).
* Remove hint deprecation words in documentation.
* Support tree object exclusion.
* Add details about recursive exclusion of commits and trees in documentation.

Teng Long (7):
  pack-objects.c: introduce new method `match_packfile_uri_exclusions`
  Add new parameter "carry_data" for "show_object" function
  packfile-uri: support for excluding commit objects
  packfile-uri: support for excluding tree objects
  packfile-uri.txt: support for excluding commits and trees
  t5702: replace with "test_when_finished" for cleanup
  t5702: support for excluding commit objects

 Documentation/technical/packfile-uri.txt |  32 ++-
 builtin/describe.c                       |   4 +-
 builtin/pack-objects.c                   | 104 +++++---
 builtin/rev-list.c                       |   2 +-
 list-objects.c                           |  41 +--
 list-objects.h                           |   2 +-
 object.c                                 |  19 +-
 object.h                                 |  15 +-
 pack-bitmap.c                            |   8 +-
 reachable.c                              |   8 +-
 revision.c                               |  34 ++-
 revision.h                               |   3 +
 t/t5702-protocol-v2.sh                   | 312 ++++++++++++++++++++---
 upload-pack.c                            |   7 +
 14 files changed, 466 insertions(+), 125 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  73a5b4ccc1 pack-objects.c: introduce new method `match_packfile_uri_exclusions`
-:  ---------- > 2:  bc8fea97e3 Add new parameter "carry_data" for "show_object" function
1:  f324359ec8 ! 3:  f71b310842 packfile-uris: support for excluding commit objects
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    packfile-uris: support for excluding commit objects
    +    packfile-uri: support for excluding commit objects
     
    -    On the server, more sophisticated means of excluding objects should be
    -    supported, such as commit object. This commit introduces a new
    -    configuration `uploadpack.excludeobject` for this.
    +    Currently packfile-uri supports the exclusion of blob objects, but in
    +    some scenarios, users may wish to exclude more types of objects, such as
    +    commit and tree objects, not only because packfile itself supports
    +    storing these object types, but also on the other hand, to make
    +    configuration items maintainable and simpler.
    +
    +    This commit is used to support the recursive exclusion of a commit
    +    object, which means that if the exclusion of a commit is configured as
    +    packfile-uri, the commit itself and all the objects it contains will
    +    also be recursively excluded. In addition, to support this feature, a
    +    new configuration  `uploadpack.excludeobject` is introduced.
     
         The reason for bringing a new configuration is for two considerations.
         First, the old configuration supports a single object type (blob), which
    @@ Commit message
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    - ## builtin/describe.c ##
    -@@ builtin/describe.c: static void process_commit(struct commit *commit, void *data)
    - 	pcd->current_commit = commit->object.oid;
    - }
    - 
    --static void process_object(struct object *obj, const char *path, void *data)
    -+static void process_object(struct object *obj, const char *path, void *show_data, void *carry_data)
    - {
    --	struct process_commit_data *pcd = data;
    -+	struct process_commit_data *pcd = show_data;
    - 
    - 	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
    - 		reset_revision_walk();
    -
      ## builtin/pack-objects.c ##
    -@@ builtin/pack-objects.c: static int have_duplicate_entry(const struct object_id *oid,
    - 	return 1;
    - }
    - 
    -+static int match_packfile_uri_exclusions(struct configured_exclusion *ex)
    -+{
    -+	int i;
    -+	const char *p;
    -+
    -+	if (ex) {
    -+		for (i = 0; i < uri_protocols.nr; i++) {
    -+			if (skip_prefix(ex->uri,
    -+					uri_protocols.items[i].string,
    -+					&p) &&
    -+			    *p == ':')
    -+				return 1;
    -+
    -+		}
    -+	}
    -+	return 0;
    -+}
    -+
    - static int want_found_object(const struct object_id *oid, int exclude,
    - 			     struct packed_git *p)
    - {
     @@ builtin/pack-objects.c: static int want_object_in_pack_one(struct packed_git *p,
      static int want_object_in_pack(const struct object_id *oid,
      			       int exclude,
    @@ builtin/pack-objects.c: static int want_object_in_pack_one(struct packed_git *p,
      	struct multi_pack_index *m;
     +	struct configured_exclusion *ex;
     +	struct configured_exclusion *referred_ex;
    -+
      
      	if (!exclude && local && has_loose_object_nonlocal(oid))
      		return 0;
    @@ builtin/pack-objects.c: static int want_object_in_pack(const struct object_id *o
      	if (uri_protocols.nr) {
     -		struct configured_exclusion *ex =
     -			oidmap_get(&configured_exclusions, oid);
    --		int i;
    --		const char *p;
    --
    --		if (ex) {
    --			for (i = 0; i < uri_protocols.nr; i++) {
    --				if (skip_prefix(ex->uri,
    --						uri_protocols.items[i].string,
    --						&p) &&
    --				    *p == ':') {
    --					oidset_insert(&excluded_by_config, oid);
    --					return 0;
    --				}
    --			}
     +		if (referred_commit) {
     +			referred_ex = oidmap_get(&configured_exclusions, &referred_commit->oid);
     +			if (referred_ex && match_packfile_uri_exclusions(referred_ex))
     +				return 0;
     +		}
    -+		ex = oidmap_get(&configured_exclusions, oid);
    -+		if (ex && match_packfile_uri_exclusions(ex)) {
    -+			oidset_insert(&excluded_by_config, oid);
    -+			return 0;
    - 		}
    - 	}
      
    ++		ex = oidmap_get(&configured_exclusions, oid);
    + 		if (ex && match_packfile_uri_exclusions(ex)) {
    + 			oidset_insert(&excluded_by_config, oid);
    + 			return 0;
     @@ builtin/pack-objects.c: static const char no_closure_warning[] = N_(
      );
      
    @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
      		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||
      		    *pack_end != ' ')
     -			die(_("value of uploadpack.blobpackfileuri must be "
    --			      "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
    -+                        die(_("value of uploadpack.excludeobject or uploadpack.blobpackfileuri must be "
    -+                              "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
    ++			die(_("value of uploadpack.excludeobject or uploadpack.blobpackfileuri must be "
    + 			      "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"), v);
      		if (oidmap_get(&configured_exclusions, &ex->e.oid))
     -			die(_("object already configured in another "
     -			      "uploadpack.blobpackfileuri (got '%s')"), v);
    -+                        die(_("object already configured by an earlier "
    -+                              "uploadpack.excludeobject or uploadpack.blobpackfileuri (got '%s')"), v);
    ++			die(_("object already configured by an earlier "
    ++			      "uploadpack.excludeobject or uploadpack.blobpackfileuri (got '%s')"), v);
      		ex->pack_hash_hex = xcalloc(1, pack_end - oid_end);
      		memcpy(ex->pack_hash_hex, oid_end + 1, pack_end - oid_end - 1);
      		ex->uri = xstrdup(pack_end + 1);
    @@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct objec
      		return 0;
      
      	oi.typep = &type;
    -@@ builtin/pack-objects.c: static void show_commit_pack_hint(struct commit *commit, void *_data)
    - }
    - 
    - static void show_object_pack_hint(struct object *object, const char *name,
    --				  void *_data)
    -+				  void *show_data, void *carry_data)
    - {
    - 	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
    - 	if (!oe)
     @@ builtin/pack-objects.c: static void read_object_list_from_stdin(void)
      			die(_("expected object ID, got garbage:\n %s"), line);
      
    @@ builtin/pack-objects.c: static void read_object_list_from_stdin(void)
      
      	if (write_bitmap_index)
     @@ builtin/pack-objects.c: static void show_commit(struct commit *commit, void *data)
    - 		propagate_island_marks(commit);
    - }
      
    --static void show_object(struct object *obj, const char *name, void *data)
    -+static void show_object(struct object *obj, const char *name, void *show_data, void *carry_data)
    + static void show_object(struct object *obj, const char *name, void *show_data, void *carry_data)
      {
     +	struct object *referred_commit = carry_data;
      	add_preferred_base_object(name);
    @@ builtin/pack-objects.c: static void show_commit(struct commit *commit, void *dat
      	obj->flags |= OBJECT_ADDED;
      
      	if (use_delta_islands) {
    -@@ builtin/pack-objects.c: static void show_object(struct object *obj, const char *name, void *data)
    - 	}
    - }
    - 
    --static void show_object__ma_allow_any(struct object *obj, const char *name, void *data)
    -+static void show_object__ma_allow_any(struct object *obj, const char *name, void *show_data, void *carry_data)
    - {
    - 	assert(arg_missing_action == MA_ALLOW_ANY);
    - 
    -@@ builtin/pack-objects.c: static void show_object__ma_allow_any(struct object *obj, const char *name, void
    - 	if (!has_object(the_repository, &obj->oid, 0))
    - 		return;
    - 
    --	show_object(obj, name, data);
    -+	show_object(obj, name, show_data, carry_data);
    - }
    - 
    --static void show_object__ma_allow_promisor(struct object *obj, const char *name, void *data)
    -+static void show_object__ma_allow_promisor(struct object *obj, const char *name, void *show_data, void *carry_data)
    - {
    - 	assert(arg_missing_action == MA_ALLOW_PROMISOR);
    - 
    -@@ builtin/pack-objects.c: static void show_object__ma_allow_promisor(struct object *obj, const char *name,
    - 	if (!has_object(the_repository, &obj->oid, 0) && is_promisor_object(&obj->oid))
    - 		return;
    - 
    --	show_object(obj, name, data);
    -+	show_object(obj, name, show_data, carry_data);
    - }
    - 
    - static int option_parse_missing_action(const struct option *opt,
     @@ builtin/pack-objects.c: static void add_objects_in_unpacked_packs(void)
      		QSORT(in_pack.array, in_pack.nr, ofscmp);
      		for (i = 0; i < in_pack.nr; i++) {
    @@ builtin/pack-objects.c: static int add_loose_object(const struct object_id *oid,
      	return 0;
      }
      
    -@@ builtin/pack-objects.c: static int get_object_list_from_bitmap(struct rev_info *revs)
    - 
    - static void record_recent_object(struct object *obj,
    - 				 const char *name,
    --				 void *data)
    -+				 void *show_data,
    -+				 void *carry_data)
    - {
    - 	oid_array_append(&recent_objects, &obj->oid);
    - }
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const char *prefix)
      			 N_("respect islands during delta compression")),
      		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
      				N_("protocol"),
     -				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
     +				N_("exclude any configured uploadpack.excludeobject or "
    -+				   	"uploadpack.blobpackfileuri with this protocol")),
    ++				   "uploadpack.blobpackfileuri with this protocol")),
      		OPT_END(),
      	};
      
     
    - ## builtin/rev-list.c ##
    -@@ builtin/rev-list.c: static int finish_object(struct object *obj, const char *name, void *cb_data)
    - 	return 0;
    - }
    - 
    --static void show_object(struct object *obj, const char *name, void *cb_data)
    -+static void show_object(struct object *obj, const char *name, void *cb_data, void *carry_data)
    - {
    - 	struct rev_list_info *info = cb_data;
    - 	struct rev_info *revs = info->revs;
    -
    - ## fetch-pack.c ##
    -@@
    - #include "fetch-negotiator.h"
    - #include "fsck.h"
    - #include "shallow.h"
    -+#include "strmap.h"
    - 
    - static int transfer_unpack_limit = -1;
    - static int fetch_unpack_limit = -1;
    -@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    - 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
    - 	int i;
    - 	struct strvec index_pack_args = STRVEC_INIT;
    -+	struct strset uris;
    - 
    - 	negotiator = &negotiator_alloc;
    - 	fetch_negotiator_init(r, negotiator);
    -@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    - 		}
    - 	}
    - 
    -+	strset_init(&uris);
    - 	for (i = 0; i < packfile_uris.nr; i++) {
    - 		int j;
    - 		struct child_process cmd = CHILD_PROCESS_INIT;
    -@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    - 		const char *uri = packfile_uris.items[i].string +
    - 			the_hash_algo->hexsz + 1;
    - 
    -+		if (!strset_add(&uris, uri))
    -+			continue;
    - 		strvec_push(&cmd.args, "http-fetch");
    - 		strvec_pushf(&cmd.args, "--packfile=%.*s",
    - 			     (int) the_hash_algo->hexsz,
    -@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
    - 						 get_object_directory(),
    - 						 packname));
    - 	}
    -+	strset_clear(&uris);
    - 	string_list_clear(&packfile_uris, 0);
    - 	strvec_clear(&index_pack_args);
    - 
    -
      ## list-objects.c ##
     @@ list-objects.c: struct traversal_context {
      static void process_blob(struct traversal_context *ctx,
    @@ list-objects.c: static void process_blob(struct traversal_context *ctx,
      	if (r & LOFR_MARK_SEEN)
      		obj->flags |= SEEN;
      	if (r & LOFR_DO_SHOW)
    --		ctx->show_object(obj, path->buf, ctx->show_data);
    +-		ctx->show_object(obj, path->buf, ctx->show_data, NULL);
     +		ctx->show_object(obj, path->buf, ctx->show_data, referred_commit);
      	strbuf_setlen(path, pathlen);
      }
    @@ list-objects.c: static void process_tree(struct traversal_context *ctx,
      	if (r & LOFR_MARK_SEEN)
      		obj->flags |= SEEN;
      	if (r & LOFR_DO_SHOW)
    --		ctx->show_object(obj, base->buf, ctx->show_data);
    +-		ctx->show_object(obj, base->buf, ctx->show_data, NULL);
     +		ctx->show_object(obj, base->buf, ctx->show_data, referred_commit);
      	if (base->len)
      		strbuf_addch(base, '/');
    @@ list-objects.c: static void process_tree(struct traversal_context *ctx,
      	if (r & LOFR_MARK_SEEN)
      		obj->flags |= SEEN;
      	if (r & LOFR_DO_SHOW)
    --		ctx->show_object(obj, base->buf, ctx->show_data);
    +-		ctx->show_object(obj, base->buf, ctx->show_data, NULL);
     +		ctx->show_object(obj, base->buf, ctx->show_data, referred_commit);
      
      	strbuf_setlen(base, baselen);
    @@ list-objects.c: void mark_edges_uninteresting(struct rev_info *revs,
      }
      
     -static void add_pending_tree(struct rev_info *revs, struct tree *tree)
    -+static void add_pending_tree(struct rev_info *revs,  struct tree *tree, struct object *referred_commit)
    ++static void add_pending_tree(struct rev_info *revs, struct tree *tree, struct object *referred_commit)
      {
     -	add_pending_object(revs, &tree->object, "");
     +	add_pending_object_with_referred_commit(revs, &tree->object, "", referred_commit);
    @@ list-objects.c: static void traverse_trees_and_blobs(struct traversal_context *c
      			continue;
      		if (obj->type == OBJ_TAG) {
      			obj->flags |= SEEN;
    --			ctx->show_object(obj, name, ctx->show_data);
    +-			ctx->show_object(obj, name, ctx->show_data, NULL);
     +			ctx->show_object(obj, name, ctx->show_data, referred_commit);
      			continue;
      		}
    @@ list-objects.c: static void do_traverse(struct traversal_context *ctx)
      			die(_("unable to load root tree for commit %s"),
      			      oid_to_hex(&commit->object.oid));
     
    - ## list-objects.h ##
    -@@ list-objects.h: struct object;
    - struct rev_info;
    - 
    - typedef void (*show_commit_fn)(struct commit *, void *);
    --typedef void (*show_object_fn)(struct object *, const char *, void *);
    -+typedef void (*show_object_fn)(struct object *, const char *, void *, void *);
    - void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
    - 
    - typedef void (*show_edge_fn)(struct commit *);
    -
      ## object.c ##
     @@ object.c: void object_list_free(struct object_list **list)
       */
    @@ object.c: void add_object_array_with_path(struct object *obj, const char *name,
     
      ## object.h ##
     @@ object.h: struct object_array {
    - 	unsigned int alloc;
    - 	struct object_array_entry {
    - 		struct object *item;
    + 		char *name;
    + 		char *path;
    + 		unsigned mode;
     +		struct object *referred_commit;
    - 		/*
    - 		 * name or NULL.  If non-NULL, the memory pointed to
    - 		 * is owned by this object *except* if it points at
    + 	} *objects;
    + };
    + 
     @@ object.h: void object_list_free(struct object_list **list);
      /* Object array handling .. */
      void add_object_array(struct object *obj, const char *name, struct object_array *array);
      void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
    +-
     +void add_object_array_with_path_and_referred_commit(struct object *obj, const char *name, struct object_array *array,
    -+						    unsigned mode, const char *path,
    -+						    struct object *referred_commit);
    - 
    ++						    unsigned mode, const char *path, struct object *referred_commit);
      /*
       * Returns NULL if the array is empty. Otherwise, returns the last object
    -
    - ## pack-bitmap.c ##
    -@@ pack-bitmap.c: struct bitmap_show_data {
    - 	struct bitmap *base;
    - };
    - 
    --static void show_object(struct object *object, const char *name, void *data_)
    -+static void show_object(struct object *object, const char *name, void *show_data, void *carry_data)
    - {
    --	struct bitmap_show_data *data = data_;
    -+	struct bitmap_show_data *data = show_data;
    - 	int bitmap_pos;
    - 
    - 	bitmap_pos = bitmap_position(data->bitmap_git, &object->oid);
    -@@ pack-bitmap.c: struct bitmap_test_data {
    - };
    - 
    - static void test_show_object(struct object *object, const char *name,
    --			     void *data)
    -+			     void *show_data, void *carry_data)
    - {
    --	struct bitmap_test_data *tdata = data;
    -+	struct bitmap_test_data *tdata = show_data;
    - 	int bitmap_pos;
    - 
    - 	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
    -
    - ## reachable.c ##
    -@@ reachable.c: static int add_one_ref(const char *path, const struct object_id *oid,
    -  * The traversal will have already marked us as SEEN, so we
    -  * only need to handle any progress reporting here.
    -  */
    --static void mark_object(struct object *obj, const char *name, void *data)
    -+static void mark_object(struct object *obj, const char *name, void *show_data, void *carry_data)
    - {
    --	update_progress(data);
    -+	update_progress(show_data);
    - }
    - 
    --static void mark_commit(struct commit *c, void *data)
    -+static void mark_commit(struct commit *c, void *show_data)
    - {
    --	mark_object(&c->object, NULL, data);
    -+	mark_object(&c->object, NULL, show_data,  NULL);
    - }
    - 
    - struct recent_data {
    +  * after removing its entry from the array. Other resources associated
     
      ## revision.c ##
     @@ revision.c: void mark_parents_uninteresting(struct commit *commit)
    @@ revision.c: static void add_pending_object_with_path(struct rev_info *revs,
      	}
     -	add_object_array_with_path(obj, name, &revs->pending, mode, path);
     +	add_object_array_with_path_and_referred_commit(obj, name, &revs->pending, mode, path, referred_commit);
    -+}
    -+
    + }
    + 
     +static void add_pending_object_with_path(struct rev_info *revs,
     +					 struct object *obj,
     +					 const char *name, unsigned mode,
    -+					 const char *path) {
    ++					 const char *path)
    ++{
     +	add_pending_object_with_path_and_referred_commit(revs, obj, name, mode, path, NULL);
    - }
    - 
    ++}
      static void add_pending_object_with_mode(struct rev_info *revs,
      					 struct object *obj,
     -					 const char *name, unsigned mode)
     +					 const char *name, unsigned mode,
     +					 struct object *referred_commit)
    - {
    --	add_pending_object_with_path(revs, obj, name, mode, NULL);
    -+
    ++{
     +	add_pending_object_with_path_and_referred_commit(revs, obj, name, mode, NULL, referred_commit);
     +}
     +
     +void add_pending_object_with_referred_commit(struct rev_info *revs,
     +					     struct object *obj, const char *name,
     +					     struct object *referred_commit)
    -+{
    + {
    +-	add_pending_object_with_path(revs, obj, name, mode, NULL);
     +	add_pending_object_with_mode(revs, obj, name, S_IFINVALID, referred_commit);
      }
      
    @@ revision.c: static void add_pending_object_with_path(struct rev_info *revs,
      }
      
      void add_head_to_pending(struct rev_info *revs)
    -@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
    - 			continue;
    - 		}
    - 
    --
    - 		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
    - 			int j;
    - 			if (seen_dashdash || *arg == '^')
     @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
      		if (get_oid_with_context(revs->repo, revs->def, 0, &oid, &oc))
      			diagnose_missing_default(revs->def);
    @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
     
      ## revision.h ##
     @@ revision.h: void show_object_with_name(FILE *, struct object *, const char *);
    +  */
      void add_pending_object(struct rev_info *revs,
      			struct object *obj, const char *name);
    - 
     +void add_pending_object_with_referred_commit(struct rev_info *revs,
     +					     struct object *obj, const char *name,
     +					     struct object *referred_commit);
    -+
    + 
      void add_pending_oid(struct rev_info *revs,
      		     const char *name, const struct object_id *oid,
    - 		     unsigned int flags);
     
      ## upload-pack.c ##
     @@ upload-pack.c: int upload_pack_advertise(struct repository *r,
2:  7ce99a0f31 < -:  ---------- t5702: support for excluding commit objects
-:  ---------- > 4:  bbb0413cc4 packfile-uri: support for excluding tree objects
3:  36b9a92132 ! 5:  8e5bf4010c packfile-uri.txt: support for excluding commit objects
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    packfile-uri.txt: support for excluding commit objects
    +    packfile-uri.txt: support for excluding commits and trees
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ Documentation/technical/packfile-uri.txt: include some sort of non-trivial imple
     -downloaded in this way only contain single blobs.
     +server to be configured by one or more entries with the format:
     +
    -+    uploadpack.excludeobject=<object-hash> <recursively> <pack-hash> <uri>
    ++    uploadpack.excludeobject=<object-hash> <pack-hash> <uri>
     +
    -+Value <object-hash> is the key of entry, and the object type can be a blob
    -+or commit. Whenever the list of objects to be sent is assembled, all such
    -+objects are excluded, replaced with URIs. At the same time, for the old
    -+configuration `uploadpack.blobPackfileUri=<sha1> <pack-hash> <uri>` is
    -+still compatible for now, but this configuration only supports the
    -+exclusion of blob objects.
    ++Value <object-hash> is the key of entry, and the object type can be a blob,
    ++tree, or commit. The exclusion of tree and commit is recursive by default,
    ++which means that when a tree or commit object is excluded, the object itself
    ++and all reachable objects of the object will be excluded recursively. Whenever
    ++the list of objects to be sent is assembled, all such objects are excluded,
    ++replaced with URIs.
    ++
    ++Configuration compatibility
    ++-------------
    ++
    ++The old configuration of packfile-uri:
    ++
    ++	`uploadpack.blobPackfileUri=<object-hash> <pack-hash> <uri>`
    ++
    ++For the old configuration is compatible with the new one, but it only
    ++supports the exclusion of blob objects.
      
      Client design
      -------------
    @@ Documentation/technical/packfile-uri.txt: The protocol design allows some evolut
       * On the client, resumption of clone. If a clone is interrupted, information
         could be recorded in the repository's config and a "clone-resume" command
         can resume the clone in progress. (Resumption of subsequent fetches is more
    +@@ Documentation/technical/packfile-uri.txt: There are some possible features that will require a change in protocol:
    + 
    +  * Additional HTTP headers (e.g. authentication)
    +  * Byte range support
    +- * Different file formats referenced by URIs (e.g. raw object)
    ++ * Different file formats referenced by URIs (e.g. raw object)
    + \ No newline at end of file
-:  ---------- > 6:  f3b1cba7e1 t5702: replace with "test_when_finished" for cleanup
-:  ---------- > 7:  3b5f9732b8 t5702: support for excluding commit objects
-- 
2.31.1.449.gb2aa5456a8.dirty

