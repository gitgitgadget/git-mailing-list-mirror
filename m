Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E82AC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3520C610FB
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhJAWj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 18:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhJAWj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 18:39:57 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B793BC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 15:38:12 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id y17so3812199ilb.9
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WIdro63SoKw8iqdwOveKpBwFON50D6L3U3N4OKx0dtM=;
        b=xVG+awobqFE6FNRkS9n5/65OssbT20RVyF4A0HWXbPGUiD7pI7LOvUPByXDs3Qac2i
         7j/7MR3XVGsTWTarKGLbp19jMeHzTuijJmtJCkDPeRwvou2Pu3BUgq1/E7LRurx4VHvD
         BGDwxH2T29LB6iTHOROJYe8s11A40nqq0zMZ1wG0NMb3YYmAazo2Ip0AaAddJBzbtDp3
         KRqhUm0vIW00kNpe4nNluiKY4bBO8cRyWzErbj4CxpDE4DFbW4eR1x5HI1MRTrV7dOzx
         s5hUd538rB7Q6COMDakCllShoiXGzrByI7f+AamQp111ZRqqlKU40ZMQL6pRw2ZmPoGP
         G/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WIdro63SoKw8iqdwOveKpBwFON50D6L3U3N4OKx0dtM=;
        b=zh8eQzdmgpxu55D/Jy7m6gW3MzVwcsNXJeZXBySEdSbtQ1jMgMsdAGYSXIBhuqY3CJ
         A4eMs8zr2FX4CiENtr9oQVrOhC9CGo3OXgcasdw2AjLFYbrf41C0cJ6zY4SdQJeXBOPv
         wmhJme1coajYxiLJB4VDMbX0LEcxEHCVpqGFZQKm9Y/WLfYuy2C5l+B3D2oq1hk1/nLV
         NueG+GLwZO7tOmq/gnCFcmCy2zPxGiIGLnKs02bLqYrBOL9WToWuBdTgRK7x+GEDNOyK
         iHjCakVPs99eYR1SuN1o0hC7cr7oEgYWevMBlbutD6SrwSxvoLzNbIrtGElell36l5mX
         OeWg==
X-Gm-Message-State: AOAM531LFFXXtXUr6sSFf4WpT1iWser1dVWjac5+vr2b1EPP5tpZQIG8
        3GnL83FAi6/ctxlEsdWFSJOxlA==
X-Google-Smtp-Source: ABdhPJxBd88eUEfI/ZxAes4NBJKafmy8h9YBLUweouwD9Sk7uPZuV60FaW5e4pmxkHg+wocGtnaayw==
X-Received: by 2002:a05:6e02:b46:: with SMTP id f6mr302767ilu.100.1633127892094;
        Fri, 01 Oct 2021 15:38:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i14sm4404254iol.27.2021.10.01.15.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 15:38:11 -0700 (PDT)
Date:   Fri, 1 Oct 2021 18:38:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 8/8] builtin/repack.c: pass `--refs-snapshot` when
 writing bitmaps
Message-ID: <YVeN0mXqYvTHtNB+@nand.local>
References: <eb24b308ecdbd7736fc63927130540abd0a668db.1631730270.git.me@ttaylorr.com>
 <20210924182247.2922561-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210924182247.2922561-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 11:22:47AM -0700, Jonathan Tan wrote:
> > +static void midx_snapshot_refs(struct tempfile *f)
> > +{
> > +	struct midx_snapshot_ref_data data;
> > +	const struct string_list *preferred = bitmap_preferred_tips(the_repository);
> > +
> > +	data.f = f;
> > +	oidset_init(&data.seen, 0);
> > +
> > +	if (!fdopen_tempfile(f, "w"))
> > +		 die(_("could not open tempfile %s for writing"),
> > +		     get_tempfile_path(f));
> > +
> > +	if (preferred) {
> > +		struct string_list_item *item;
> > +
> > +		data.preferred = 1;
> > +		for_each_string_list_item(item, preferred)
> > +			for_each_ref_in(item->string, midx_snapshot_ref_one, &data);
> > +		data.preferred = 0;
> > +	}
> > +
> > +	for_each_ref(midx_snapshot_ref_one, &data);
>
> One small thing here - I think "data.preferred = 0;" needs to be moved
> to right above this for_each_ref line. As it is, if preferred is NULL,
> data.preferred wouldn't be initialized.
>
> Other than that (and the minor changes I've suggested in previous
> patches), this series looks good to me.

Eek. Great catch. I was wondering why this didn't bite us at GitHub by
marking all refs as preferred, but it doesn't because we always get back
a non-NULL string list from bitmap_preferred_tips(), which causes us to
set data.preferred back to 0.

Here's a replacement patch which adds the missing `data.preferred = 0`
while initializing data in this function, as well as calls
oidset_clear() and adds a test. Unfortunately, the new test in t7700 is
basically a smoke test, because of the way that bitmap selection works

If Junio would rather I send a reroll of the topic instead, I'm happy to
do that, too.

--- 8< ---

Subject: [PATCH] builtin/repack.c: pass `--refs-snapshot` when writing bitmaps

To prevent the race described in an earlier patch, generate and pass a
reference snapshot to the multi-pack bitmap code, if we are writing one
from `git repack`.

This patch is mostly limited to creating a temporary file, and then
calling for_each_ref(). Except we try to minimize duplicates, since
doing so can drastically reduce the size in network-of-forks style
repositories. In the kernel's fork network (the repository containing
all objects from the kernel and all its forks), deduplicating the
references drops the snapshot size from 934 MB to just 12 MB.

But since we're handling duplicates in this way, we have to make sure
that we preferred references (those listed in pack.preferBitmapTips)
before non-preferred ones (to avoid recording an object which is pointed
at by a preferred tip as non-preferred).

We accomplish this by doing separate passes over the references: first
visiting each prefix in pack.preferBitmapTips, and then over the rest of
the references.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c  | 82 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t7700-repack.sh | 42 ++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 1577f0d59f..9354b2bd93 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -15,6 +15,8 @@
 #include "promisor-remote.h"
 #include "shallow.h"
 #include "pack.h"
+#include "pack-bitmap.h"
+#include "refs.h"

 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -453,6 +455,68 @@ static void clear_pack_geometry(struct pack_geometry *geometry)
 	geometry->split = 0;
 }

+struct midx_snapshot_ref_data {
+	struct tempfile *f;
+	struct oidset seen;
+	int preferred;
+};
+
+static int midx_snapshot_ref_one(const char *refname,
+				 const struct object_id *oid,
+				 int flag, void *_data)
+{
+	struct midx_snapshot_ref_data *data = _data;
+	struct object_id peeled;
+
+	if (!peel_iterated_oid(oid, &peeled))
+		oid = &peeled;
+
+	if (oidset_insert(&data->seen, oid))
+		return 0; /* already seen */
+
+	if (oid_object_info(the_repository, oid, NULL) != OBJ_COMMIT)
+		return 0;
+
+	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
+		oid_to_hex(oid));
+
+	return 0;
+}
+
+static void midx_snapshot_refs(struct tempfile *f)
+{
+	struct midx_snapshot_ref_data data;
+	const struct string_list *preferred = bitmap_preferred_tips(the_repository);
+
+	data.f = f;
+	data.preferred = 0;
+	oidset_init(&data.seen, 0);
+
+	if (!fdopen_tempfile(f, "w"))
+		 die(_("could not open tempfile %s for writing"),
+		     get_tempfile_path(f));
+
+	if (preferred) {
+		struct string_list_item *item;
+
+		data.preferred = 1;
+		for_each_string_list_item(item, preferred)
+			for_each_ref_in(item->string, midx_snapshot_ref_one, &data);
+		data.preferred = 0;
+	}
+
+	for_each_ref(midx_snapshot_ref_one, &data);
+
+	if (close_tempfile_gently(f)) {
+		int save_errno = errno;
+		delete_tempfile(&f);
+		errno = save_errno;
+		die_errno(_("could not close refs snapshot tempfile"));
+	}
+
+	oidset_clear(&data.seen);
+}
+
 static void midx_included_packs(struct string_list *include,
 				struct string_list *existing_nonkept_packs,
 				struct string_list *existing_kept_packs,
@@ -488,6 +552,7 @@ static void midx_included_packs(struct string_list *include,

 static int write_midx_included_packs(struct string_list *include,
 				     struct pack_geometry *geometry,
+				     const char *refs_snapshot,
 				     int show_progress, int write_bitmaps)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -517,6 +582,9 @@ static int write_midx_included_packs(struct string_list *include,
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
 			     pack_basename(largest));

+	if (refs_snapshot)
+		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
+
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
@@ -539,6 +607,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
+	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
 	FILE *out;
 	int show_progress = isatty(2);
@@ -627,6 +696,18 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));

+	if (write_midx && write_bitmaps) {
+		struct strbuf path = STRBUF_INIT;
+
+		strbuf_addf(&path, "%s/%s_XXXXXX", get_object_directory(),
+			    "bitmap-ref-tips");
+
+		refs_snapshot = xmks_tempfile(path.buf);
+		midx_snapshot_refs(refs_snapshot);
+
+		strbuf_release(&path);
+	}
+
 	if (geometric_factor) {
 		if (pack_everything)
 			die(_("--geometric is incompatible with -A, -a"));
@@ -809,6 +890,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				    &existing_kept_packs, &names, geometry);

 		ret = write_midx_included_packs(&include, geometry,
+						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
 						show_progress, write_bitmaps > 0);

 		string_list_clear(&include, 0);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 6792531dfd..0260ad6f0e 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -330,4 +330,46 @@ test_expect_success 'cleans up MIDX when appropriate' '
 	)
 '

+test_expect_success '--write-midx with preferred bitmap tips' '
+	git init midx-preferred-tips &&
+	test_when_finished "rm -fr midx-preferred-tips" &&
+	(
+		cd midx-preferred-tips &&
+
+		test_commit_bulk --message="%s" 103 &&
+
+		git log --format="%H" >commits.raw &&
+		sort <commits.raw >commits &&
+
+		git log --format="create refs/tags/%s/%s %H" HEAD >refs &&
+		git update-ref --stdin <refs &&
+
+		git repack --write-midx --write-bitmap-index &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+		test-tool bitmap list-commits | sort >bitmaps &&
+		comm -13 bitmaps commits >before &&
+		test_line_count = 1 before &&
+
+		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
+		rm -fr $midx-$(midx_checksum $objdir).rev &&
+		rm -fr $midx &&
+
+		# instead of constructing the snapshot ourselves (c.f., the test
+		# "write a bitmap with --refs-snapshot (preferred tips)" in
+		# t5326), mark the missing commit as preferred by adding it to
+		# the pack.preferBitmapTips configuration.
+		git for-each-ref --format="%(refname:rstrip=1)" \
+			--points-at="$(cat before)" >missing &&
+		git config pack.preferBitmapTips "$(cat missing)" &&
+		git repack --write-midx --write-bitmap-index &&
+
+		test-tool bitmap list-commits | sort >bitmaps &&
+		comm -13 bitmaps commits >after &&
+
+		! test_cmp before after
+	)
+'
+
 test_done
--
2.33.0.96.g73915697e6

