Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620C0C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 20:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1BF6109E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 20:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhIAUfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 16:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhIAUfB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 16:35:01 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE585C061757
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 13:34:03 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h29so609748ila.2
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zxnoQxzdvKHm0UaK5rO03n8tthYlG8fDqi3yTCeDiO8=;
        b=SVLWbbxztXvdUWTcKwxTZMyVyxXl00BFjaGFlb27eLBgzn8gqfGOAWliej5zcMTNPh
         6gPCkvYqUdrosrCYGBMxM1hFIv+K8BPnCk7T9JxW6AEcgGxwuMbiT1seejiqxhP9rWmh
         u3HnQNscKdPl1/+jZ0TT8R5qMp9qEJChTfXHjz/LtscQzaYJSInZ3wAt22JWndyadreo
         GHXrOz7QwVmOHN3f4JwscRcu6X2P3ifoVFBHFesb/3FAIW0SgGYA9qMSZM31a8z49itD
         48TVOhAb+qFwGzUCuwz56b1y6n3HCiFdVBAn3RGfn/95DYOJosNCY7kYr1ty8B8dPdVn
         KrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxnoQxzdvKHm0UaK5rO03n8tthYlG8fDqi3yTCeDiO8=;
        b=RrQ0f2KT3rNP/RCTveJUrg+bvrwtoAS4xb//HIsNJl/tbIepZg7f5Pey4kde5Xb2Mz
         2QN1+QjWp1WSFT26hIqYsB32pj/1FzATHR8LUKDQ2Vvs9Qnbh5AqcSA8frVK91UfZpVm
         yStG5TPXm79A69LeEyhaqe3J5i4ji6CsKda3dEUBojn5wIryUeKqab9bmYwZEZ6/q95C
         6XESLDcON5OQ2hC5sOOUeIiLaiX+wDU/w9vi9P2ly9VUL3u9hkl7NFwJxeJ5DbxTbyck
         GN1a4qAJYso5NeBW3pBtxyOHNdlrLcFUuHvsVahH+ujLrTJmghzhJDli3CN1hKUC7NZp
         207Q==
X-Gm-Message-State: AOAM532JerD01kZ1ZKTgmOnyTCNjgiMtRnZ5ug4Zq17jKvcsFehGkepZ
        +gZ2KF7DCUVunSDhZEQKElozfw==
X-Google-Smtp-Source: ABdhPJzG0GluCuKbDtEIt6fGhGBIKnnSB3UWIVXNSZg7K19u/IYkmP/NEuF2khmELq1vegCL8T0Fug==
X-Received: by 2002:a92:c60b:: with SMTP id p11mr918663ilm.65.1630528443142;
        Wed, 01 Sep 2021 13:34:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a14sm348440iol.24.2021.09.01.13.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:34:02 -0700 (PDT)
Date:   Wed, 1 Sep 2021 16:34:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 00/27] multi-pack reachability bitmaps
Message-ID: <YS/juRg9N/cCoR0d@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
 <xmqq5yvkqidc.fsf@gitster.g>
 <YS/Pqc7lkMlnlBYR@nand.local>
 <xmqq1r68qevl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r68qevl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 12:23:26PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I'm comfortable with saying what's written in the documentation, since
> > even though it happens to work today, we should leave ourselves open to
> > not supporting directories which aren't alternates.
> >
> > But I'm equally OK if you would rather drop this hunk from the
> > documentation when staging.
>
> Oh, no, don't get me wrong.  I am comfortable with the documented
> limitation, as that is what the area experts have agreed that is
> reasonable given the expected use case.
>
> I however am much less comfortable with a documented limitation that
> we make no attempt to enforce, and that is why the first thing I
> looked for after seeing the documentation update was new code to
> make sure we reject a random directory that is not our alternate
> object store.

Sure, I don't mind getting more strict here in this series. If you want,
the below could be queued instead of the original 11/27:

--- 8< ---

Subject: [PATCH] midx: avoid opening multiple MIDXs when writing

Opening multiple instance of the same MIDX can lead to problems like two
separate packed_git structures which represent the same pack being added
to the repository's object store.

The above scenario can happen because prepare_midx_pack() checks if
`m->packs[pack_int_id]` is NULL in order to determine if a pack has been
opened and installed in the repository before. But a caller can
construct two copies of the same MIDX by calling get_multi_pack_index()
and load_multi_pack_index() since the former manipulates the
object store directly but the latter is a lower-level routine which
allocates a new MIDX for each call.

So if prepare_midx_pack() is called on multiple MIDXs with the same
pack_int_id, then that pack will be installed twice in the object
store's packed_git pointer.

This can lead to problems in, for e.g., the pack-bitmap code, which does
something like the following (in pack-bitmap.c:open_pack_bitmap()):

    struct bitmap_index *bitmap_git = ...;
    for (p = get_all_packs(r); p; p = p->next) {
      if (open_pack_bitmap_1(bitmap_git, p) == 0)
        ret = 0;
    }

which is a problem if two copies of the same pack exist in the
packed_git list because pack-bitmap.c:open_pack_bitmap_1() contains a
conditional like the following:

    if (bitmap_git->pack || bitmap_git->midx) {
      /* ignore extra bitmap file; we can only handle one */
      warning("ignoring extra bitmap file: %s", packfile->pack_name);
      close(fd);
      return -1;
    }

Avoid this scenario by not letting write_midx_internal() open a MIDX
that isn't also pointed at by the object store. So long as this is the
case, other routines should prefer to open MIDXs with
get_multi_pack_index() or reprepare_packed_git() instead of creating
instances on their own. Because get_multi_pack_index() returns
`r->object_store->multi_pack_index` if it is non-NULL, we'll only have
one instance of a MIDX open at one time, avoiding these problems.

To encourage this, drop the `struct multi_pack_index *` parameter from
`write_midx_internal()`, and rely instead on the `object_dir` to find
(or initialize) the correct MIDX instance.

Likewise, replace the call to `close_midx()` with
`close_object_store()`, since we're about to replace the MIDX with a new
one and should invalidate the object store's memory of any MIDX that
might have existed beforehand.

Note that this now forbids passing object directories that don't belong
to alternate repositories over `--object-dir`, since before we would
have happily opened a MIDX in any directory, but now restrict ourselves
to only those reachable by `r->objects->multi_pack_index` (and alternate
MIDXs that we can see by walking the `next` pointer).

As far as I can tell, supporting arbitrary directories with
`--object-dir` was a historical accident, since even the documentation
says `<alt>` when referring to the value passed to this option.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt |  2 ++
 builtin/commit-graph.c                 | 22 -------------------
 midx.c                                 | 29 ++++++++++++++++----------
 object-file.c                          | 21 +++++++++++++++++++
 object-store.h                         |  1 +
 t/t5319-multi-pack-index.sh            | 10 ++++++++-
 6 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index c9b063d31e..0af6beb2dd 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -23,6 +23,8 @@ OPTIONS
 	Use given directory for the location of Git objects. We check
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
 	`<dir>/packs` for the pack-files to index.
++
+`<dir>` must be an alternate of the current repository.

 --[no-]progress::
 	Turn progress on/off explicitly. If neither is specified, progress is
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index cd86315221..003eaaac5c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -43,28 +43,6 @@ static struct opts_commit_graph {
 	int enable_changed_paths;
 } opts;

-static struct object_directory *find_odb(struct repository *r,
-					 const char *obj_dir)
-{
-	struct object_directory *odb;
-	char *obj_dir_real = real_pathdup(obj_dir, 1);
-	struct strbuf odb_path_real = STRBUF_INIT;
-
-	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		strbuf_realpath(&odb_path_real, odb->path, 1);
-		if (!strcmp(obj_dir_real, odb_path_real.buf))
-			break;
-	}
-
-	free(obj_dir_real);
-	strbuf_release(&odb_path_real);
-
-	if (!odb)
-		die(_("could not find object directory matching %s"), obj_dir);
-	return odb;
-}
-
 static int graph_verify(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
diff --git a/midx.c b/midx.c
index e83f22b5ee..25906044ff 100644
--- a/midx.c
+++ b/midx.c
@@ -893,7 +893,7 @@ static int midx_checksum_valid(struct multi_pack_index *m)
 	return hashfile_checksum_valid(m->data, m->data_len);
 }

-static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
+static int write_midx_internal(const char *object_dir,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
 			       unsigned flags)
@@ -904,20 +904,26 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
+	struct multi_pack_index *cur;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
 	struct chunkfile *cf;

+	/* Ensure the given object_dir is local, or a known alternate. */
+	find_odb(the_repository, object_dir);
+
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name))
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name);

-	if (m)
-		ctx.m = m;
-	else
-		ctx.m = load_multi_pack_index(object_dir, 1);
+	for (cur = get_multi_pack_index(the_repository); cur; cur = cur->next) {
+		if (!strcmp(object_dir, cur->object_dir)) {
+			ctx.m = cur;
+			break;
+		}
+	}

 	if (ctx.m && !midx_checksum_valid(ctx.m)) {
 		warning(_("ignoring existing multi-pack-index; checksum mismatch"));
@@ -1119,7 +1125,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));

 	if (ctx.m)
-		close_midx(ctx.m);
+		close_object_store(the_repository->objects);

 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
@@ -1182,8 +1188,7 @@ int write_midx_file(const char *object_dir,
 		    const char *preferred_pack_name,
 		    unsigned flags)
 {
-	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
-				   flags);
+	return write_midx_internal(object_dir, NULL, preferred_pack_name, flags);
 }

 struct clear_midx_data {
@@ -1461,8 +1466,10 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla

 	free(count);

-	if (packs_to_drop.nr)
-		result = write_midx_internal(object_dir, m, &packs_to_drop, NULL, flags);
+	if (packs_to_drop.nr) {
+		result = write_midx_internal(object_dir, &packs_to_drop, NULL, flags);
+		m = NULL;
+	}

 	string_list_clear(&packs_to_drop, 0);
 	return result;
@@ -1651,7 +1658,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}

-	result = write_midx_internal(object_dir, m, NULL, NULL, flags);
+	result = write_midx_internal(object_dir, NULL, NULL, flags);
 	m = NULL;

 cleanup:
diff --git a/object-file.c b/object-file.c
index a8be899481..a4d720b4f5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -820,6 +820,27 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }

+struct object_directory *find_odb(struct repository *r, const char *obj_dir)
+{
+	struct object_directory *odb;
+	char *obj_dir_real = real_pathdup(obj_dir, 1);
+	struct strbuf odb_path_real = STRBUF_INIT;
+
+	prepare_alt_odb(r);
+	for (odb = r->objects->odb; odb; odb = odb->next) {
+		strbuf_realpath(&odb_path_real, odb->path, 1);
+		if (!strcmp(obj_dir_real, odb_path_real.buf))
+			break;
+	}
+
+	free(obj_dir_real);
+	strbuf_release(&odb_path_real);
+
+	if (!odb)
+		die(_("could not find object directory matching %s"), obj_dir);
+	return odb;
+}
+
 static void fill_alternate_refs_command(struct child_process *cmd,
 					const char *repo_path)
 {
diff --git a/object-store.h b/object-store.h
index d24915ced1..250aa5f33c 100644
--- a/object-store.h
+++ b/object-store.h
@@ -38,6 +38,7 @@ KHASH_INIT(odb_path_map, const char * /* key: odb_path */,

 void prepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
+struct object_directory *find_odb(struct repository *r, const char *obj_dir);
 typedef int alt_odb_fn(struct object_directory *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
 typedef void alternate_ref_fn(const struct object_id *oid, void *);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index d7e4988f2b..bd09c3194b 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -582,7 +582,15 @@ test_expect_success 'force some 64-bit offsets with pack-objects' '
 	idx64=objects64/pack/test-64-$pack64.idx &&
 	chmod u+w $idx64 &&
 	corrupt_data $idx64 $(test_oid idxoff) "\02" &&
-	midx64=$(git multi-pack-index --object-dir=objects64 write) &&
+	# objects64 is not a real repository, but can serve as an alternate
+	# anyway so we can write a MIDX into it
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+		( cd ../objects64 && pwd ) >.git/objects/info/alternates &&
+		midx64=$(git multi-pack-index --object-dir=../objects64 write)
+	) &&
 	midx_read_expect 1 63 5 objects64 " large-offsets"
 '

--
2.33.0.96.g73915697e6

