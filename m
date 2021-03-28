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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F77C433E2
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDBD6197C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhC1COH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhC1COH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:14:07 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A054CC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j7so9353774wrd.1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vROPjs54CIOnSLxfDisvdsjodRMdMcNMR/ECJmpu6oU=;
        b=ZnQDbOZLN2Bv+clgoz/yFrmAJPW1SYilQAUnSfVG4/ZOF9vwtUhU+Pl2j/czcOndXY
         kyFC68u87qX8+NGR06+NvKLZhgJtVaqxReUIQv99cbm3JGWrlJS04RVKdhdCq2mmdbdY
         DdwRv7+kF59oXQBxuzKwNQbfsl3ZvEBiS4uiagWWYPsC2X+01O1d5Dd7zAEIaDVFkw8+
         Hj+IXF5+QQAdXolQZzYAa0I14SpLrpvArBDX6fo5WtvNJGjnUh/TJ4/QzhYiRLYYxQXQ
         aDYm9mKaxc/647T/jZayBZUye9GdIzQzot6DevSXkyQQXtI9dqr/Gn0bK7/tIdPnailE
         tkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vROPjs54CIOnSLxfDisvdsjodRMdMcNMR/ECJmpu6oU=;
        b=uOZaB1pQdidv1Dz9C1dqmcZgM3YjS6ZdrcanGZ7N0xcT0N8zM/4LBmQk8GVhPJ4/nL
         z3iW6iyh3qd5wcc31OiUZu+se8VzqJ/w1lzevoK1dgGdJtZV/+trweOfrqwVLqQPlWqF
         Z6qx/67RuQpA0RbZuMVLWTsv/F84G5IoWrISJp1fF60J/6awtmz10L8KGL6hp9YD69Eo
         NIw5O2RbFcA1wx/8HDaCvK8wBo+GCAInshLBhDtQTvSIKDsf9z+kJSGo6JmbUW590vZ6
         ANBwdb/x5kesYDUlxF2CFDL9cWq8GKtjm1RacHJMDGQV6a7UQ8Lozt1p2CRxKrgms0XP
         lZ2Q==
X-Gm-Message-State: AOAM533eBGJyc0ySeYX+iXMsDboYL14YdpSXqgixC0SQKyQ/f+C/gfUh
        dy1ecrslP97jFkzRJcXp0QrO1kTUSSkFlw==
X-Google-Smtp-Source: ABdhPJwWK9dSFGOw4IK/UMi56BvlX1E9fRGV26gLxDcOE94wmBGw12RLdTXrR/koCvown2ieNESzaw==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr21783764wrq.143.1616897644673;
        Sat, 27 Mar 2021 19:14:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm11291524wrt.47.2021.03.27.19.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:14:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] improve reporting of unexpected objects
Date:   Sun, 28 Mar 2021 04:13:30 +0200
Message-Id: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
In-Reply-To: <20210308200426.21824-1-avarab@gmail.com>
References: <20210308200426.21824-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in v1[1] this is some s/int/enum object_type/ refactoring,
and finally fixing an issue with our error reporting about corrupt
tags being wrong.

This should address all the feedback I got about the v1. Thanks
everyone, and sorry about the time it took to re-roll this.

1. http://lore.kernel.org/git/20210308200426.21824-1-avarab@gmail.com

*** BLURB HERE ***

Ævar Arnfjörð Bjarmason (10):
  object.c: stop supporting len == -1 in type_from_string_gently()
  object.c: refactor type_from_string_gently()
  object.c: make type_from_string() return "enum object_type"
  object-file.c: make oid_object_info() return "enum object_type"
  object-name.c: make dependency on object_type order more obvious
  tree.c: fix misindentation in parse_tree_gently()
  object.c: add a utility function for "expected type X, got Y"
  object.c: add and use oid_is_type_or_die_msg() function
  object tests: add test for unexpected objects in tags
  tag: don't misreport type of tagged objects in errors

 blob.c                                 |  16 +++-
 blob.h                                 |   3 +
 builtin/blame.c                        |   2 +-
 builtin/index-pack.c                   |  11 +--
 combine-diff.c                         |   3 +-
 commit.c                               |  24 ++++--
 commit.h                               |   2 +
 fsck.c                                 |   2 +-
 merge-recursive.c                      |   5 +-
 object-file.c                          |  10 +--
 object-name.c                          |  25 +++---
 object-store.h                         |   4 +-
 object.c                               |  65 +++++++++++---
 object.h                               |  12 ++-
 packfile.c                             |   2 +-
 t/t6102-rev-list-unexpected-objects.sh | 113 ++++++++++++++++++++++++-
 tag.c                                  |  14 ++-
 tag.h                                  |   2 +
 tree.c                                 |  27 ++++--
 tree.h                                 |   2 +
 20 files changed, 279 insertions(+), 65 deletions(-)

Range-diff:
 -:  ----------- >  1:  e51c860a65d object.c: stop supporting len == -1 in type_from_string_gently()
 1:  1f50a33ab5c !  2:  3e3979b6b35 object.c: refactor type_from_string_gently()
    @@ Commit message
         detecting an error, 2014-09-10) in preparation for its use in
         fsck.c.
     
    -    Since then no callers of this function have passed a "len < 0" as was
    -    expected might happen, so we can simplify its invocation by knowing
    -    that it's never called like that.
    +    Simplifying this means we can move the die() into the simpler
    +    type_from_string() function.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ object.c: const char *type_name(unsigned int type)
      {
      	int i;
      
    --	if (len < 0)
    --		len = strlen(str);
    --
    - 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
    +@@ object.c: int type_from_string_gently(const char *str, ssize_t len, int gentle)
      		if (!strncmp(str, object_type_strings[i], len) &&
      		    object_type_strings[i][len] == '\0')
      			return i;
    -+	return -1;
    -+}
    - 
    +-
     -	if (gentle)
     -		return -1;
     -
     -	die(_("invalid object type \"%s\""), str);
    -+int type_from_string(const char *str)
    -+{
    -+	size_t len = strlen(str);
    ++	return -1;
    + }
    + 
    + int type_from_string(const char *str)
    + {
    + 	size_t len = strlen(str);
    +-	int ret = type_from_string_gently(str, len, 0);
     +	int ret = type_from_string_gently(str, len);
     +	if (ret < 0)
     +		die(_("invalid object type \"%s\""), str);
    -+	return ret;
    + 	return ret;
      }
      
    - /*
     
      ## object.h ##
     @@ object.h: struct object {
    @@ object.h: struct object {
      
      const char *type_name(unsigned int type);
     -int type_from_string_gently(const char *str, ssize_t, int gentle);
    --#define type_from_string(str) type_from_string_gently(str, -1, 0)
     +int type_from_string_gently(const char *str, ssize_t len);
    -+int type_from_string(const char *str);
    + int type_from_string(const char *str);
      
      /*
    -  * Return the current number of buckets in the object hashmap.
 2:  a4e444f9274 !  3:  5615730f023 object.c: make type_from_string() return "enum object_type"
    @@ Commit message
         object.c: make type_from_string() return "enum object_type"
     
         Change the type_from_string*() functions to return an "enum
    -    object_type", and refactor their callers to check for "== OBJ_BAD"
    -    instead of "< 0".
    +    object_type", but don't refactor their callers to check for "==
    +    OBJ_BAD" instead of "< 0".
     
    -    This helps to distinguish code in object.c where we really do return
    -    -1 from code that returns an "enum object_type", whose OBJ_BAD happens
    -    to be -1.
    +    Refactoring the check of the return value to check == OBJ_BAD would
    +    now be equivalent to "ret < 0", but the consensus on an earlier
    +    version of this patch was to not do that, and to instead use -1
    +    consistently as a return value. It just so happens that OBJ_BAD == -1,
    +    but let's not put a hard reliance on that.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## fsck.c ##
    -@@ fsck.c: int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
    - 		goto done;
    - 	}
    - 	*tagged_type = type_from_string_gently(buffer, eol - buffer);
    --	if (*tagged_type < 0)
    -+	if (*tagged_type == OBJ_BAD)
    - 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
    - 	if (ret)
    - 		goto done;
    -
    - ## object-file.c ##
    -@@ object-file.c: static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
    - 	 */
    - 	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
    - 		type = 0;
    --	else if (type < 0)
    -+	else if (type == OBJ_BAD)
    - 		die(_("invalid object type"));
    - 	if (oi->typep)
    - 		*oi->typep = type;
    -
      ## object.c ##
     @@ object.c: const char *type_name(unsigned int type)
      	return object_type_strings[type];
    @@ object.c: const char *type_name(unsigned int type)
      
      	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
      		if (!strncmp(str, object_type_strings[i], len) &&
    - 		    object_type_strings[i][len] == '\0')
    - 			return i;
    --	return -1;
    -+	return OBJ_BAD;
    +@@ object.c: int type_from_string_gently(const char *str, ssize_t len)
    + 	return -1;
      }
      
     -int type_from_string(const char *str)
    @@ object.c: const char *type_name(unsigned int type)
      {
      	size_t len = strlen(str);
     -	int ret = type_from_string_gently(str, len);
    --	if (ret < 0)
     +	enum object_type ret = type_from_string_gently(str, len);
    -+	if (ret == OBJ_BAD)
    + 	if (ret < 0)
      		die(_("invalid object type \"%s\""), str);
      	return ret;
    - }
     
      ## object.h ##
     @@ object.h: struct object {
 3:  309fb7b71e7 !  4:  c10082f4fac oid_object_info(): return "enum object_type"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    oid_object_info(): return "enum object_type"
    +    object-file.c: make oid_object_info() return "enum object_type"
     
    -    Change oid_object_info() to return an "enum object_type", this is what
    -    it did anyway, except that it hardcoded -1 instead of an
    -    OBJ_BAD.
    -
    -    Let's instead have it return the "enum object_type", at which point
    -    callers will expect OBJ_BAD. This allows for refactoring code that
    -    e.g. expected any "< 0" value, but would only have to deal with
    -    OBJ_BAD (= -1).
    +    Change oid_object_info() to return an "enum object_type". Unlike
    +    oid_object_info_extended() function the simpler oid_object_info()
    +    explicitly returns the oi.typep member, which is itself an "enum
    +    object_type".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/blame.c: static int peel_to_commit_oid(struct object_id *oid_ret, void *
      			oidcpy(oid_ret, &oid);
      			return 0;
     
    - ## builtin/cat-file.c ##
    -@@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
    - 
    - 	case 'p':
    - 		type = oid_object_info(the_repository, &oid, NULL);
    --		if (type < 0)
    -+		if (type == OBJ_BAD)
    - 			die("Not a valid object name %s", obj_name);
    - 
    - 		/* custom pretty-print here */
    -
      ## builtin/index-pack.c ##
     @@ builtin/index-pack.c: static unsigned check_object(struct object *obj)
      
      	if (!(obj->flags & FLAG_CHECKED)) {
      		unsigned long size;
     -		int type = oid_object_info(the_repository, &obj->oid, &size);
    --		if (type <= 0)
     +		enum object_type type = oid_object_info(the_repository, &obj->oid, &size);
    -+		if (type == OBJ_BAD)
    + 		if (type <= 0)
      			die(_("did not receive expected object %s"),
      			      oid_to_hex(&obj->oid));
    - 		if (type != obj->type)
    -@@ builtin/index-pack.c: static void sha1_object(const void *data, struct object_entry *obj_entry,
    - 		unsigned long has_size;
    - 		read_lock();
    - 		has_type = oid_object_info(the_repository, oid, &has_size);
    --		if (has_type < 0)
    -+		if (has_type == OBJ_BAD)
    - 			die(_("cannot read existing object info %s"), oid_to_hex(oid));
    - 		if (has_type != type || has_size != size)
    - 			die(_("SHA1 COLLISION FOUND WITH %s !"), oid_to_hex(oid));
    -
    - ## builtin/mktree.c ##
    -@@ builtin/mktree.c: static void mktree_line(char *buf, int nul_term_line, int allow_missing)
    - 
    - 	/* Check the type of object identified by sha1 */
    - 	obj_type = oid_object_info(the_repository, &oid, NULL);
    --	if (obj_type < 0) {
    -+	if (obj_type == OBJ_BAD) {
    - 		if (allow_missing) {
    - 			; /* no problem - missing objects are presumed to be of the right type */
    - 		} else {
    -
    - ## builtin/pack-objects.c ##
    -@@ builtin/pack-objects.c: unsigned long oe_get_size_slow(struct packing_data *pack,
    - 
    - 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
    - 		packing_data_lock(&to_pack);
    --		if (oid_object_info(the_repository, &e->idx.oid, &size) < 0)
    -+		if (oid_object_info(the_repository, &e->idx.oid, &size) == OBJ_BAD)
    - 			die(_("unable to get size of %s"),
    - 			    oid_to_hex(&e->idx.oid));
    - 		packing_data_unlock(&to_pack);
    -@@ builtin/pack-objects.c: static int add_loose_object(const struct object_id *oid, const char *path,
    - {
    - 	enum object_type type = oid_object_info(the_repository, oid, NULL);
    - 
    --	if (type < 0) {
    -+	if (type == OBJ_BAD) {
    - 		warning(_("loose object at %s could not be examined"), path);
    - 		return 0;
    - 	}
    -
    - ## builtin/replace.c ##
    -@@ builtin/replace.c: static int edit_and_replace(const char *object_ref, int force, int raw)
    - 		return error(_("not a valid object name: '%s'"), object_ref);
    - 
    - 	type = oid_object_info(the_repository, &old_oid, NULL);
    --	if (type < 0)
    -+	if (type == OBJ_BAD)
    - 		return error(_("unable to get object type for %s"),
    - 			     oid_to_hex(&old_oid));
    - 
    -
    - ## builtin/tag.c ##
    -@@ builtin/tag.c: static void create_tag(const struct object_id *object, const char *object_ref,
    - 	char *path = NULL;
    - 
    - 	type = oid_object_info(the_repository, object, NULL);
    --	if (type <= OBJ_NONE)
    -+	if (type == OBJ_BAD)
    - 		die(_("bad object type."));
    - 
    - 	if (type == OBJ_TAG)
    -
    - ## builtin/unpack-objects.c ##
    -@@ builtin/unpack-objects.c: static int check_object(struct object *obj, int type, void *data, struct fsck_op
    - 	if (!(obj->flags & FLAG_OPEN)) {
    - 		unsigned long size;
    - 		int type = oid_object_info(the_repository, &obj->oid, &size);
    --		if (type != obj->type || type <= 0)
    -+		if (type == OBJ_BAD)
    -+			die(_("unable to get object type for %s"),
    -+			    oid_to_hex(&obj->oid));
    -+		if (type != obj->type)
    -+			/* todo to new function */
    - 			die("object of unexpected type");
    - 		obj->flags |= FLAG_WRITTEN;
    - 		return 0;
     
      ## object-file.c ##
     @@ object-file.c: int oid_object_info_extended(struct repository *r, const struct object_id *oid,
    + 	return ret;
      }
      
    - 
    +-
     -/* returns enum object_type or negative */
     -int oid_object_info(struct repository *r,
     -		    const struct object_id *oid,
    @@ object-file.c: int oid_object_info_extended(struct repository *r, const struct o
      {
      	enum object_type type;
      	struct object_info oi = OBJECT_INFO_INIT;
    -@@ object-file.c: int oid_object_info(struct repository *r,
    - 	oi.sizep = sizep;
    - 	if (oid_object_info_extended(r, oid, &oi,
    - 				      OBJECT_INFO_LOOKUP_REPLACE) < 0)
    --		return -1;
    -+		return OBJ_BAD;
    - 	return type;
    - }
    - 
    -@@ object-file.c: int read_pack_header(int fd, struct pack_header *header)
    - void assert_oid_type(const struct object_id *oid, enum object_type expect)
    - {
    - 	enum object_type type = oid_object_info(the_repository, oid, NULL);
    --	if (type < 0)
    -+	if (type == OBJ_BAD)
    - 		die(_("%s is not a valid object"), oid_to_hex(oid));
    - 	if (type != expect)
    - 		die(_("%s is not a valid '%s' object"), oid_to_hex(oid),
     
      ## object-name.c ##
     @@ object-name.c: static int disambiguate_committish_only(struct repository *r,
    @@ object-name.c: static int disambiguate_committish_only(struct repository *r,
      {
      	struct object *obj;
     -	int kind;
    -+	enum object_type kind;
    ++	enum object_type kind = oid_object_info(r, oid, NULL);
      
    - 	kind = oid_object_info(r, oid, NULL);
    +-	kind = oid_object_info(r, oid, NULL);
      	if (kind == OBJ_COMMIT)
    + 		return 1;
    + 	if (kind != OBJ_TAG)
     @@ object-name.c: static int disambiguate_tree_only(struct repository *r,
      				  const struct object_id *oid,
      				  void *cb_data_unused)
    @@ object-store.h: static inline void *repo_read_object_file(struct repository *r,
      
      /* Read and unpack an object file into memory, write memory to an object file */
     -int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
    -+enum object_type oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
    ++enum object_type oid_object_info(struct repository *r,
    ++				 const struct object_id *,
    ++				 unsigned long *);
      
      int hash_object_file(const struct git_hash_algo *algo, const void *buf,
      		     unsigned long len, const char *type,
    @@ packfile.c: static int retry_bad_packed_offset(struct repository *r,
      	uint32_t pos;
      	struct object_id oid;
      	if (offset_to_pack_pos(p, obj_offset, &pos) < 0)
    -@@ packfile.c: static int retry_bad_packed_offset(struct repository *r,
    - 	nth_packed_object_id(&oid, p, pack_pos_to_index(p, pos));
    - 	mark_bad_packed_object(p, oid.hash);
    - 	type = oid_object_info(r, &oid, NULL);
    --	if (type <= OBJ_NONE)
    --		return OBJ_BAD;
    - 	return type;
    - }
    - 
    -
    - ## reachable.c ##
    -@@ reachable.c: static void add_recent_object(const struct object_id *oid,
    - 	 * commits and tags to have been parsed.
    - 	 */
    - 	type = oid_object_info(the_repository, oid, NULL);
    --	if (type < 0)
    --		die("unable to get object info for %s", oid_to_hex(oid));
    - 
    - 	switch (type) {
    - 	case OBJ_TAG:
    -@@ reachable.c: static void add_recent_object(const struct object_id *oid,
    - 	case OBJ_BLOB:
    - 		obj = (struct object *)lookup_blob(the_repository, oid);
    - 		break;
    -+	case OBJ_BAD:
    -+		die("unable to get object info for %s", oid_to_hex(oid));
    -+		break;
    - 	default:
    - 		die("unknown object type for %s: %s",
    - 		    oid_to_hex(oid), type_name(type));
 -:  ----------- >  5:  1ebcf1416b8 object-name.c: make dependency on object_type order more obvious
 4:  e93881ed264 =  6:  464c9e35256 tree.c: fix misindentation in parse_tree_gently()
 5:  bed81215646 !  7:  4bf29cbb383 object.c: add a utility function for "expected type X, got Y"
    @@ builtin/index-pack.c: static int mark_link(struct object *obj, int type, void *d
      	obj->flags |= FLAG_LINK;
      	return 0;
     @@ builtin/index-pack.c: static unsigned check_object(struct object *obj)
    - 		if (type == OBJ_BAD)
    + 		if (type <= 0)
      			die(_("did not receive expected object %s"),
      			      oid_to_hex(&obj->oid));
     -		if (type != obj->type)
    @@ builtin/index-pack.c: static unsigned check_object(struct object *obj)
      		return 1;
      	}
     
    + ## combine-diff.c ##
    +@@ combine-diff.c: static char *grab_blob(struct repository *r,
    + 		free_filespec(df);
    + 	} else {
    + 		blob = read_object_file(oid, &type, size);
    +-		if (type != OBJ_BLOB)
    +-			die("object '%s' is not a blob!", oid_to_hex(oid));
    ++		oid_is_type_or_die(oid, OBJ_BLOB, &type);
    + 	}
    + 	return blob;
    + }
    +
      ## commit.c ##
     @@ commit.c: const void *repo_get_commit_buffer(struct repository *r,
      		if (!ret)
    @@ commit.c: int repo_parse_commit_internal(struct repository *r,
      
      	ret = parse_commit_buffer(r, item, buffer, size, 0);
     
    + ## merge-recursive.c ##
    +@@ merge-recursive.c: static int read_oid_strbuf(struct merge_options *opt,
    + 	if (!buf)
    + 		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
    + 	if (type != OBJ_BLOB) {
    ++		const char* msg = oid_is_type_or_die_msg(oid, OBJ_BLOB, &type);
    + 		free(buf);
    + 		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
    + 	}
    +
      ## object.c ##
    -@@ object.c: static const char *object_type_strings[] = {
    - 	"tag",		/* OBJ_TAG = 4 */
    - };
    - 
    -+static const char *oid_is_a_X_not_a_Y = N_("object %s is a %s, not a %s");
    -+
    - const char *type_name(unsigned int type)
    - {
    - 	if (type >= ARRAY_SIZE(object_type_strings))
     @@ object.c: void *create_object(struct repository *r, const struct object_id *oid, void *o)
      	return obj;
      }
      
    -+static int oid_is_type_or(const struct object_id *oid,
    -+			  enum object_type want,
    -+			  enum object_type type,
    -+			  int err)
    -+{
    -+	if (want == type)
    -+		return 0;
    -+	if (err)
    -+		return error(_(oid_is_a_X_not_a_Y),
    -+			     oid_to_hex(oid), type_name(type),
    -+			     type_name(want));
    -+	else
    -+		die(_(oid_is_a_X_not_a_Y), oid_to_hex(oid),
    -+		    type_name(type), type_name(want));
    -+}
    ++static const char *object_type_mismatch_msg = N_("object %s is a %s, not a %s");
     +
     +void oid_is_type_or_die(const struct object_id *oid,
     +			enum object_type want,
     +			enum object_type *type)
     +{
    -+	oid_is_type_or(oid, want, *type, 0);
    ++	if (want == *type)
    ++		return;
    ++	die(_(object_type_mismatch_msg), oid_to_hex(oid),
    ++	    type_name(*type), type_name(want));
     +}
     +
     +int oid_is_type_or_error(const struct object_id *oid,
     +			 enum object_type want,
     +			 enum object_type *type)
     +{
    -+	return oid_is_type_or(oid, want, *type, 1);
    ++	if (want == *type)
    ++		return 0;
    ++	return error(_(object_type_mismatch_msg),
    ++		     oid_to_hex(oid), type_name(*type),
    ++		     type_name(want));
     +}
     +
      void *object_as_type(struct object *obj, enum object_type type, int quiet)
    @@ object.c: void *object_as_type(struct object *obj, enum object_type type, int qu
      	else {
      		if (!quiet)
     -			error(_("object %s is a %s, not a %s"),
    -+			error(_(oid_is_a_X_not_a_Y),
    ++			error(_(object_type_mismatch_msg),
      			      oid_to_hex(&obj->oid),
      			      type_name(obj->type), type_name(type));
      		return NULL;
 -:  ----------- >  8:  351a8ec79c8 object.c: add and use oid_is_type_or_die_msg() function
 6:  6d34b2b80db =  9:  6a43bf897ae object tests: add test for unexpected objects in tags
 7:  f93236c25fd ! 10:  a84f670ac24 tag: don't misreport type of tagged objects in errors
    @@ Commit message
     
         Hence the non-intuitive solution of adding a
         lookup_{blob,commit,tag,tree}_type() function. It's to distinguish
    -    parse_object_buffer() where we actually know the type from
    -    parse_tag_buffer() where we're just guessing about the type.
    +    calls from parse_object_buffer() where we actually know the type, from
    +    a parse_tag_buffer() where we're just guessing about the type.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
-- 
2.31.1.442.g6c06c9fe35c

