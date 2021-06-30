Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD805C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 14:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B340761433
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 14:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhF3OIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 10:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbhF3OIu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 10:08:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFA3C061766
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 07:06:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso1692516wmj.4
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+mVnzkIDS9d75sWMOWLF/RtdvghppwdnXYddba4/dY=;
        b=j1fzJbKEgF7LtgSGs9kWg4Uoaen9C/vROjfEIgRCZNKyFCbvd/VsTWnhA8YGi3kxw0
         ctAWzGShADfs2lEf9sSeE2LP1ZV+A6LAluUJLqePj9AKLToOE17l43kKPE8d0UEisovs
         wxLortK4nsjG/5loOl5dOvRtADCxCirFPr5InV4aJGgOJxl+XgTuP3dPY8FsNhllDJm6
         b6K7+Lai7AQs9DfCFW8RW1CJtcllR0M4xJwXVEhx0JNto6e09QCR2LZOW03AXrjVWfZZ
         mHns4xEEx2R52D8vEybfwhVOcEgEGg01AZR3cX879e+XAwqT7XUgv05nHYxPC3DmEWZ/
         5W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+mVnzkIDS9d75sWMOWLF/RtdvghppwdnXYddba4/dY=;
        b=bKz0TGE4pThZpwKQjP0DjA2YuQ9vVhV4LlrrXGyt6rnI2Xz8ZA1xFNXXZUMdb7EEYZ
         uCfEcuihSzzYl+wuKRTjJyN3LpcCUV1qjIUpugY2XDygMRa1jSrErkmz1uOr2mhsyHCt
         Nkw2w5NPI7TQekLvBAQOf0AtO+qv1DDepoFpxQXBom4L8kextQwb1McfMAG1HAs21yzf
         T7uLmeMK2OwuexmWoxfI6qndk5abtPZ2SEQlmmEgGRKM7LRJL82DtOX/KI0b0m5MpIsh
         JKqhhA0nunMWcBrkHGCRPBztH8DowWJqKNkk0AJs+A7LBiSd57XQcRFzlhmMlb7UvwBz
         RxOg==
X-Gm-Message-State: AOAM530pL2pQ6CnNxvZczXARKUR/ADsFg2dZsdaHC4XE9Bgw/A+B50xX
        lHWF7lAd+UxFnjPcEY6EVHrl+4AAncf9dg==
X-Google-Smtp-Source: ABdhPJyxgDQwf5gJwnKvF5HGRbisc/ZiNhIU4uQzX9tyAAA0QvyZafZ4OPD/sAiw9KzXIivLvq5Q5g==
X-Received: by 2002:a1c:e486:: with SMTP id b128mr4813517wmh.58.1625061979205;
        Wed, 30 Jun 2021 07:06:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b20sm4763814wmj.7.2021.06.30.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 07:06:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] 
Date:   Wed, 30 Jun 2021 16:06:13 +0200
Message-Id: <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g8e17abc2eb
In-Reply-To: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the bundle API to use the string_list API instead of its own
version of a similar API. See [1] for v2.

Addresses comments by Jeff King about us being too overzelous in
trying not to leak memory (the 'die_no_repo' is gone), and other
flow/style comments of his.

I also added a bundle_header_init() function for use in transport.c,
and noticed a redundant call to string_list_clear() there.

1. https://lore.kernel.org/git/cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  bundle cmd: stop leaking memory from parse_options_cmd_bundle()
  bundle.c: use a temporary variable for OIDs and names
  bundle: remove "ref_list" in favor of string-list.c API

 builtin/bundle.c | 74 ++++++++++++++++++++++++++++++------------------
 bundle.c         | 65 ++++++++++++++++++++++++++----------------
 bundle.h         | 21 +++++++-------
 transport.c      | 10 +++++--
 4 files changed, 105 insertions(+), 65 deletions(-)

Range-diff against v2:
1:  6a8b20a7cf3 < -:  ----------- upload-pack: run is_repository_shallow() before setup_revisions()
2:  d88b2c04102 < -:  ----------- revision.h: unify "disable_stdin" and "read_from_stdin"
3:  d433d7b24a3 < -:  ----------- pack-objects.c: do stdin parsing via revision.c's API
4:  e59a06c3148 < -:  ----------- pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
5:  f4191088ac3 ! 1:  3d0d7a8e8b5 bundle cmd: stop leaking memory from parse_options_cmd_bundle()
    @@ Commit message
         about those fixes if valgrind runs cleanly at the end without any
         leaks whatsoever.
     
    +    An earlier version of this change went out of its way to not leak
    +    memory on the die() codepaths here, but that was deemed too verbose to
    +    worry about in a built-in that's dying anyway. The only reason we'd
    +    need that is to appease a mode like SANITIZE=leak within the scope of
    +    an entire test file.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/bundle.c ##
    @@ builtin/bundle.c: static int cmd_bundle_create(int argc, const char **argv, cons
      	struct strvec pack_opts;
      	int version = -1;
     -
    -+	int die_no_repo = 0;
     +	int ret;
      	struct option options[] = {
      		OPT_SET_INT('q', "quiet", &progress,
    @@ builtin/bundle.c: static int cmd_bundle_create(int argc, const char **argv, cons
      	argc = parse_options_cmd_bundle(argc, argv, prefix,
      			builtin_bundle_create_usage, options, &bundle_file);
     @@ builtin/bundle.c: static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
    - 	if (progress && all_progress_implied)
    - 		strvec_push(&pack_opts, "--all-progress-implied");
      
    --	if (!startup_info->have_repository)
    -+	if (!startup_info->have_repository) {
    -+		die_no_repo = 1;
    -+		goto cleanup;
    -+	}
    -+	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
    -+cleanup:
    -+	free(bundle_file);
    -+	if (die_no_repo)
    + 	if (!startup_info->have_repository)
      		die(_("Need a repository to create a bundle."));
     -	return !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
    ++	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
    ++	free(bundle_file);
     +	return ret;
      }
      
    @@ builtin/bundle.c: static int cmd_bundle_create(int argc, const char **argv, cons
      	struct bundle_header header;
      	int bundle_fd = -1;
     -
    -+	int die_no_repo = 0;
     +	int ret;
      	struct option options[] = {
      		OPT_END()
    @@ builtin/bundle.c: static int cmd_bundle_create(int argc, const char **argv, cons
      	memset(&header, 0, sizeof(header));
     -	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0)
     -		return 1;
    --	if (!startup_info->have_repository)
    --		die(_("Need a repository to unbundle."));
    --	return !!unbundle(the_repository, &header, bundle_fd, 0) ||
     +	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0) {
     +		ret = 1;
     +		goto cleanup;
     +	}
    -+	if (!startup_info->have_repository) {
    -+		die_no_repo = 1;
    -+		goto cleanup;
    -+	}
    + 	if (!startup_info->have_repository)
    + 		die(_("Need a repository to unbundle."));
    +-	return !!unbundle(the_repository, &header, bundle_fd, 0) ||
     +	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
      		list_bundle_refs(&header, argc, argv);
     +cleanup:
    -+	if (die_no_repo)
    -+		die(_("Need a repository to unbundle."));
     +	free(bundle_file);
     +	return ret;
      }
6:  f297fd0432a ! 2:  e47646d3a98 bundle.c: use a temporary variable for OIDs and names
    @@ bundle.c: int verify_bundle(struct repository *r,
      	for (i = 0; i < p->nr; i++) {
      		struct ref_list_entry *e = p->list + i;
     -		struct object *o = parse_object(r, &e->oid);
    ++		const char *name = e->name;
     +		struct object_id *oid = &e->oid;
     +		struct object *o = parse_object(r, oid);
      		if (o) {
      			o->flags |= PREREQ_MARK;
    - 			add_pending_object(&revs, o, e->name);
    -@@ bundle.c: int verify_bundle(struct repository *r,
    +-			add_pending_object(&revs, o, e->name);
    ++			add_pending_object(&revs, o, name);
    + 			continue;
      		}
      		if (++ret == 1)
      			error("%s", message);
     -		error("%s %s", oid_to_hex(&e->oid), e->name);
    -+		error("%s %s", oid_to_hex(oid), e->name);
    ++		error("%s %s", oid_to_hex(oid), name);
      	}
      	if (revs.pending.nr != p->nr)
      		return ret;
    @@ bundle.c: int verify_bundle(struct repository *r,
      	for (i = 0; i < p->nr; i++) {
      		struct ref_list_entry *e = p->list + i;
     -		struct object *o = parse_object(r, &e->oid);
    ++		const char *name = e->name;
     +		struct object_id *oid = &e->oid;
     +		struct object *o = parse_object(r, oid);
      		assert(o); /* otherwise we'd have returned early */
    @@ bundle.c: int verify_bundle(struct repository *r,
      		if (++ret == 1)
      			error("%s", message);
     -		error("%s %s", oid_to_hex(&e->oid), e->name);
    -+		error("%s %s", oid_to_hex(oid), e->name);
    ++		error("%s %s", oid_to_hex(oid), name);
      	}
      
      	/* Clean up objects used, as they will be reused. */
    @@ bundle.c: int verify_bundle(struct repository *r,
     
      ## transport.c ##
     @@ transport.c: static struct ref *get_refs_from_bundle(struct transport *transport,
    + 
      	for (i = 0; i < data->header.references.nr; i++) {
      		struct ref_list_entry *e = data->header.references.list + i;
    - 		struct ref *ref = alloc_ref(e->name);
    +-		struct ref *ref = alloc_ref(e->name);
     -		oidcpy(&ref->old_oid, &e->oid);
    ++		const char *name = e->name;
    ++		struct ref *ref = alloc_ref(name);
     +		struct object_id *oid = &e->oid;
     +		oidcpy(&ref->old_oid, oid);
      		ref->next = result;
7:  887313d3b02 ! 3:  f1066ee1b9a bundle: remove "ref_list" in favor of string-list.c API
    @@ builtin/bundle.c: static int cmd_bundle_list_heads(int argc, const char **argv,
     -	struct bundle_header header;
     +	struct bundle_header header = BUNDLE_HEADER_INIT;
      	int bundle_fd = -1;
    - 	int die_no_repo = 0;
      	int ret;
    + 	struct option options[] = {
     @@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
      			builtin_bundle_unbundle_usage, options, &bundle_file);
      	/* bundle internals use argv[1] as further parameters */
    @@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, co
      		ret = 1;
      		goto cleanup;
     @@ builtin/bundle.c: static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
    - 	}
    + 		die(_("Need a repository to unbundle."));
      	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
      		list_bundle_refs(&header, argc, argv);
     +	bundle_header_release(&header);
      cleanup:
    - 	if (die_no_repo)
    - 		die(_("Need a repository to unbundle."));
    + 	free(bundle_file);
    + 	return ret;
     
      ## bundle.c ##
     @@ bundle.c: static struct {
    @@ bundle.c: static struct {
      
     -static void add_to_ref_list(const struct object_id *oid, const char *name,
     -		struct ref_list *list)
    --{
    ++void bundle_header_init(struct bundle_header *header)
    + {
     -	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
     -	oidcpy(&list->list[list->nr].oid, oid);
     -	list->list[list->nr].name = xstrdup(name);
     -	list->nr++;
    --}
    --
    - static int parse_capability(struct bundle_header *header, const char *capability)
    - {
    - 	const char *arg;
    -@@ bundle.c: static int parse_bundle_header(int fd, struct bundle_header *header,
    - 	/* The bundle header ends with an empty line */
    - 	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
    - 	       buf.len && buf.buf[0] != '\n') {
    --		struct object_id oid;
    -+		struct object_id *oid;
    - 		int is_prereq = 0;
    - 		const char *p;
    ++	memset(header, 0, sizeof(*header));
    ++	string_list_init(&header->prerequisites, 1);
    ++	string_list_init(&header->references, 1);
    ++}
    ++
    ++void bundle_header_release(struct bundle_header *header)
    ++{
    ++	string_list_clear(&header->prerequisites, 1);
    ++	string_list_clear(&header->references, 1);
    + }
      
    + static int parse_capability(struct bundle_header *header, const char *capability)
     @@ bundle.c: static int parse_bundle_header(int fd, struct bundle_header *header,
    - 		 * Prerequisites have object name that is optionally
    - 		 * followed by SP and subject line.
    - 		 */
    --		if (parse_oid_hex_algop(buf.buf, &oid, &p, header->hash_algo) ||
    -+		oid = xmalloc(sizeof(struct object_id));
    -+		if (parse_oid_hex_algop(buf.buf, oid, &p, header->hash_algo) ||
    - 		    (*p && !isspace(*p)) ||
    - 		    (!is_prereq && !*p)) {
    - 			if (report_path)
    - 				error(_("unrecognized header: %s%s (%d)"),
    - 				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
      			status = -1;
    -+			free(oid);
      			break;
      		} else {
    --			if (is_prereq)
    ++			struct object_id *dup = oiddup(&oid);
    + 			if (is_prereq)
     -				add_to_ref_list(&oid, "", &header->prerequisites);
    --			else
    ++				string_list_append(&header->prerequisites, "")->util = dup;
    + 			else
     -				add_to_ref_list(&oid, p + 1, &header->references);
    -+			const char *string = is_prereq ? "" : p + 1;
    -+			struct string_list *list = is_prereq
    -+				? &header->prerequisites
    -+				: &header->references;
    -+			string_list_append(list, string)->util = oid;
    ++				string_list_append(&header->references, p + 1)->util = dup;
      		}
      	}
      
    @@ bundle.c: int verify_bundle(struct repository *r,
      	repo_init_revisions(r, &revs, NULL);
      	for (i = 0; i < p->nr; i++) {
     -		struct ref_list_entry *e = p->list + i;
    +-		const char *name = e->name;
     -		struct object_id *oid = &e->oid;
     +		struct string_list_item *e = p->items + i;
    ++		const char *name = e->string;
     +		struct object_id *oid = e->util;
      		struct object *o = parse_object(r, oid);
      		if (o) {
      			o->flags |= PREREQ_MARK;
    --			add_pending_object(&revs, o, e->name);
    -+			add_pending_object(&revs, o, e->string);
    - 			continue;
    - 		}
    - 		if (++ret == 1)
    - 			error("%s", message);
    --		error("%s %s", oid_to_hex(oid), e->name);
    -+		error("%s %s", oid_to_hex(oid), e->string);
    - 	}
    - 	if (revs.pending.nr != p->nr)
    - 		return ret;
     @@ bundle.c: int verify_bundle(struct repository *r,
      			i--;
      
      	for (i = 0; i < p->nr; i++) {
     -		struct ref_list_entry *e = p->list + i;
    +-		const char *name = e->name;
     -		struct object_id *oid = &e->oid;
     +		struct string_list_item *e = p->items + i;
    ++		const char *name = e->string;
     +		const struct object_id *oid = e->util;
      		struct object *o = parse_object(r, oid);
      		assert(o); /* otherwise we'd have returned early */
      		if (o->flags & SHOWN)
    - 			continue;
    - 		if (++ret == 1)
    - 			error("%s", message);
    --		error("%s %s", oid_to_hex(oid), e->name);
    -+		error("%s %s", oid_to_hex(oid), e->string);
    - 	}
    +@@ bundle.c: int verify_bundle(struct repository *r,
      
      	/* Clean up objects used, as they will be reused. */
      	for (i = 0; i < p->nr; i++) {
    @@ bundle.c: int verify_bundle(struct repository *r,
      
      		r = &header->references;
      		printf_ln(Q_("The bundle contains this ref:",
    -@@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
    - 		return error(_("index-pack died"));
    - 	return 0;
    - }
    -+
    -+void bundle_header_release(struct bundle_header *header)
    -+{
    -+	string_list_clear(&header->prerequisites, 1);
    -+	string_list_clear(&header->references, 1);
    -+}
     
      ## bundle.h ##
     @@
    @@ bundle.h
     +	.prerequisites = STRING_LIST_INIT_DUP, \
     +	.references = STRING_LIST_INIT_DUP, \
     +}
    ++void bundle_header_init(struct bundle_header *header);
    ++void bundle_header_release(struct bundle_header *header);
     +
      int is_bundle(const char *path, int quiet);
      int read_bundle_header(const char *path, struct bundle_header *header);
      int create_bundle(struct repository *r, const char *path,
    -@@ bundle.h: int unbundle(struct repository *r, struct bundle_header *header,
    - 	     int bundle_fd, int flags);
    - int list_bundle_refs(struct bundle_header *header,
    - 		int argc, const char **argv);
    -+void bundle_header_release(struct bundle_header *header);
    - 
    - #endif
     
      ## transport.c ##
     @@ transport.c: static struct ref *get_refs_from_bundle(struct transport *transport,
    @@ transport.c: static struct ref *get_refs_from_bundle(struct transport *transport
      
      	for (i = 0; i < data->header.references.nr; i++) {
     -		struct ref_list_entry *e = data->header.references.list + i;
    --		struct ref *ref = alloc_ref(e->name);
    --		struct object_id *oid = &e->oid;
    +-		const char *name = e->name;
     +		struct string_list_item *e = data->header.references.items + i;
    -+		struct ref *ref = alloc_ref(e->string);
    -+		const struct object_id *oid = e->util;
    ++		const char *name = e->string;
    + 		struct ref *ref = alloc_ref(name);
    +-		struct object_id *oid = &e->oid;
    ++		struct object_id *oid = e->util;
      		oidcpy(&ref->old_oid, oid);
      		ref->next = result;
      		result = ref;
    - 	}
    -+	string_list_clear(&data->header.references, 1);
    - 	return result;
    - }
    - 
     @@ transport.c: static int close_bundle(struct transport *transport)
      	struct bundle_transport_data *data = transport->data;
      	if (data->fd > 0)
    @@ transport.c: struct transport *transport_get(struct remote *remote, const char *
      		die(_("git-over-rsync is no longer supported"));
      	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url, 1)) {
      		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
    -+		string_list_init(&data->header.prerequisites, 1);
    -+		string_list_init(&data->header.references, 1);
    ++		bundle_header_init(&data->header);
      		transport_check_allowed("file");
      		ret->data = data;
      		ret->vtable = &bundle_vtable;
-- 
2.32.0.613.g8e17abc2eb

