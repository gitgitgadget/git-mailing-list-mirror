Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54FDC433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D7560EFF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhIOS0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhIOS0B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:26:01 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F5FC061764
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:42 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id i13so3945914ilm.4
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YceJJApZPM5JNp0+3w3H4RtvURIOA6ZBkzXObTFs2Dk=;
        b=blWTYl6WzMb5mRjqljH+SuPZApZSoATgX3dZSTr5UTnmCj2uQM2u6RUW1kMbq5Ys2v
         irlB6T3CZ9/XwOEjaxID6aWeEQ7VJDnmz5K9/kocrjW4pzxKlXGcpcopr5E0y5+KS2I2
         LSkVrI74KGWDX6yuSVr7eZx3rQTuP3WJr9m6JcYNIx7bVw276cELc1WhIhZgAJzfwD8A
         2TxTv16E+5DfW3uvzmFTqNui5LGvb0S3t9nRFXI7uq5ri9FhtXQ1XMpIELssJ+1eqhXm
         2rhX9+BmqngAXahqXY+IisZzBHrquIgS6e8Ee+YtVPEGEjY2+uGG6w0cE5ucSbOdL1DK
         SPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YceJJApZPM5JNp0+3w3H4RtvURIOA6ZBkzXObTFs2Dk=;
        b=AqaYGrWTnoAr+QtdzLlPY9iO1siqTGxTnXOfHCjM7NpQ7CT4Kk5qFXmFq08klykcfi
         bfM4FAp1rM89BPOlCFI/yc285/cRWvX4Zi3E9XfJzKGsWfI+MPZuDCj/M+kHDOX0lrza
         Fe/GYmxPeH9VsT1B1Ud8nrjVi1tZVW2HTqY5biv+bRsI+mjo62fQV3sB0/Rx+leDb7D6
         gdavbo6lArUGLuSuyKN0CtI+M4lZKNiwxarMHqNiZy+hZU/VWpkVvHlATOpR+dxJ6ovk
         XtLdjDGlWWkt44heULi/r3FBP83gPIhhS7Od5/9wz86ab/p91ejxFcU4RUNq0/qJk7Qy
         C7HA==
X-Gm-Message-State: AOAM533mg+fK/6KI/MlXIhHzLjvqo5jyikpAf5086opEjr2ayt/DQ57i
        6ALX3u6za3do4D6bMfl0pNGoi5idv0QnuyN3
X-Google-Smtp-Source: ABdhPJyZrvgNHnZgw9isx2QJ1GxSiCMeJULfP718CDkZjlUouTXl268rvwO5O4gZ5ZyVUxy3DKbRng==
X-Received: by 2002:a92:d11:: with SMTP id 17mr1102418iln.153.1631730281635;
        Wed, 15 Sep 2021 11:24:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x21sm318194ioh.55.2021.09.15.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:24:41 -0700 (PDT)
Date:   Wed, 15 Sep 2021 14:24:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 3/8] midx: preliminary support for `--refs-snapshot`
Message-ID: <42f1ae9edeb55d8e1b0c8f2c3110e9c8326a5fc1.1631730270.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631730270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To figure out which commits we can write a bitmap for, the multi-pack
index/bitmap code does a reachability traversal, marking any commit
which can be found in the MIDX as eligible to receive a bitmap.

This approach will cause a problem when multi-pack bitmaps are able to
be generated from `git repack`, since the reference tips can change
during the repack. Even though we ignore commits that don't exist in
the MIDX (when doing a scan of the ref tips), it's possible that a
commit in the MIDX reaches something that isn't.

This can happen when a multi-pack index contains some pack which refers
to loose objects (which by definition aren't included in the multi-pack
index).

By taking a snapshot of the references before we start repacking, we can
close that race window. In the above scenario (where we have a packed
object pointing at a loose one), we'll either (a) take a snapshot of the
references before seeing the packed one, or (b) take it after, at which
point we can guarantee that the loose object will be packed and included
in the MIDX.

This patch does just that. It writes a temporary "reference snapshot",
which is a list of OIDs that are at the ref tips before writing a
multi-pack bitmap. References that are "preferred" (i.e,. are a suffix
of at least one value of the 'pack.preferBitmapTips' configuration) are
marked with a special '+'.

The format is simple: one line per commit at each tip, with an optional
'+' at the beginning (for preferred references, as described above).

When provided, the reference snapshot is used to drive bitmap selection
instead of the MIDX code doing its own traversal. When it isn't
provided, the usual traversal takes place instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt | 15 +++++
 builtin/multi-pack-index.c             | 11 +++-
 builtin/repack.c                       |  2 +-
 midx.c                                 | 60 ++++++++++++++++---
 midx.h                                 |  6 +-
 t/t5326-multi-pack-bitmaps.sh          | 82 ++++++++++++++++++++++++++
 6 files changed, 163 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 009c989ef8..27f83932e4 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -49,6 +49,21 @@ write::
 	--stdin-packs::
 		Write a multi-pack index containing only the set of
 		line-delimited pack index basenames provided over stdin.
+
+	--refs-snapshot=<path>::
+		With `--bitmap`, optionally specify a file which
+		contains a "refs snapshot" taken prior to repacking.
++
+A reference snapshot is composed of line-delimited OIDs corresponding to
+the reference tips, usually taken by `git repack` prior to generating a
+new pack. A line may optionally start with a `+` character to indicate
+that the reference which corresponds to that OID is "preferred" (see
+linkgit:git-config[1]'s `pack.preferBitmapTips`.)
++
+The file given at `<path>` is expected to be readable, and can contain
+duplicates. (If a given OID is given more than once, it is marked as
+preferred if at least one instance of it begins with the special `+`
+marker).
 --
 
 verify::
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 047647b5f2..4b827a07c0 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -7,7 +7,8 @@
 #include "object-store.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
-	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]")
+	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]" \
+	   "[--refs-snapshot=<path>]")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -45,6 +46,7 @@ static char const * const builtin_multi_pack_index_usage[] = {
 static struct opts_multi_pack_index {
 	const char *object_dir;
 	const char *preferred_pack;
+	const char *refs_snapshot;
 	unsigned long batch_size;
 	unsigned flags;
 	int stdin_packs;
@@ -83,6 +85,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			 N_("write multi-pack index containing only given indexes")),
+		OPT_FILENAME(0, "refs-snapshot", &opts.refs_snapshot,
+			     N_("refs snapshot for selecting bitmap commits")),
 		OPT_END(),
 	};
 
@@ -106,7 +110,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 		read_packs_from_stdin(&packs);
 
 		ret = write_midx_file_only(opts.object_dir, &packs,
-					   opts.preferred_pack, opts.flags);
+					   opts.preferred_pack,
+					   opts.refs_snapshot, opts.flags);
 
 		string_list_clear(&packs, 0);
 
@@ -114,7 +119,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 
 	}
 	return write_midx_file(opts.object_dir, opts.preferred_pack,
-			       opts.flags);
+			       opts.refs_snapshot, opts.flags);
 }
 
 static int cmd_multi_pack_index_verify(int argc, const char **argv)
diff --git a/builtin/repack.c b/builtin/repack.c
index 82ab668272..27158a897b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -733,7 +733,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0))
 			flags |= MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX;
-		write_midx_file(get_object_directory(), NULL, flags);
+		write_midx_file(get_object_directory(), NULL, NULL, flags);
 	}
 
 	string_list_clear(&names, 0);
diff --git a/midx.c b/midx.c
index 0330202fda..97ba3421f2 100644
--- a/midx.c
+++ b/midx.c
@@ -968,7 +968,42 @@ static void bitmap_show_commit(struct commit *commit, void *_data)
 	data->commits[data->commits_nr++] = commit;
 }
 
+static int read_refs_snapshot(const char *refs_snapshot,
+			      struct rev_info *revs)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct object_id oid;
+	FILE *f = xfopen(refs_snapshot, "r");
+
+	while (strbuf_getline(&buf, f) != EOF) {
+		struct object *object;
+		int preferred = 0;
+		char *hex = buf.buf;
+		const char *end = NULL;
+
+		if (buf.len && *buf.buf == '+') {
+			preferred = 1;
+			hex = &buf.buf[1];
+		}
+
+		if (parse_oid_hex(hex, &oid, &end) < 0)
+			die(_("could not parse line: %s"), buf.buf);
+		if (*end)
+			die(_("malformed line: %s"), buf.buf);
+
+		object = parse_object_or_die(&oid, NULL);
+		if (preferred)
+			object->flags |= NEEDS_BITMAP;
+
+		add_pending_object(revs, object, "");
+	}
+
+	fclose(f);
+	return 0;
+}
+
 static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr_p,
+						    const char *refs_snapshot,
 						    struct write_midx_context *ctx)
 {
 	struct rev_info revs;
@@ -977,8 +1012,12 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	cb.ctx = ctx;
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	setup_revisions(0, NULL, &revs, NULL);
-	for_each_ref(add_ref_to_pending, &revs);
+	if (refs_snapshot) {
+		read_refs_snapshot(refs_snapshot, &revs);
+	} else {
+		setup_revisions(0, NULL, &revs, NULL);
+		for_each_ref(add_ref_to_pending, &revs);
+	}
 
 	/*
 	 * Skipping promisor objects here is intentional, since it only excludes
@@ -1007,6 +1046,7 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 
 static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 			     struct write_midx_context *ctx,
+			     const char *refs_snapshot,
 			     unsigned flags)
 {
 	struct packing_data pdata;
@@ -1018,7 +1058,7 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 
 	prepare_midx_packing_data(&pdata, ctx);
 
-	commits = find_commits_for_midx_bitmap(&commits_nr, ctx);
+	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);
 
 	/*
 	 * Build the MIDX-order index based on pdata.objects (which is already
@@ -1066,6 +1106,7 @@ static int write_midx_internal(const char *object_dir,
 			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
+			       const char *refs_snapshot,
 			       unsigned flags)
 {
 	char *midx_name;
@@ -1359,7 +1400,8 @@ static int write_midx_internal(const char *object_dir,
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name, midx_hash, &ctx);
 	if (flags & MIDX_WRITE_BITMAP) {
-		if (write_midx_bitmap(midx_name, midx_hash, &ctx, flags) < 0) {
+		if (write_midx_bitmap(midx_name, midx_hash, &ctx,
+				      refs_snapshot, flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			result = 1;
 			goto cleanup;
@@ -1394,19 +1436,21 @@ static int write_midx_internal(const char *object_dir,
 
 int write_midx_file(const char *object_dir,
 		    const char *preferred_pack_name,
+		    const char *refs_snapshot,
 		    unsigned flags)
 {
 	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
-				   flags);
+				   refs_snapshot, flags);
 }
 
 int write_midx_file_only(const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
+			 const char *refs_snapshot,
 			 unsigned flags)
 {
 	return write_midx_internal(object_dir, packs_to_include, NULL,
-				   preferred_pack_name, flags);
+				   preferred_pack_name, refs_snapshot, flags);
 }
 
 struct clear_midx_data {
@@ -1686,7 +1730,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr) {
-		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, flags);
+		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, NULL, flags);
 		m = NULL;
 	}
 
@@ -1877,7 +1921,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, NULL, NULL, NULL, flags);
+	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
 	m = NULL;
 
 cleanup:
diff --git a/midx.h b/midx.h
index 80f502d39b..c0b4e21df4 100644
--- a/midx.h
+++ b/midx.h
@@ -62,10 +62,14 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
 int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
-int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
+int write_midx_file(const char *object_dir,
+		    const char *preferred_pack_name,
+		    const char *refs_snapshot,
+		    unsigned flags);
 int write_midx_file_only(const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
+			 const char *refs_snapshot,
 			 unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 4ad7c2c969..069dab3e17 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -283,4 +283,86 @@ test_expect_success 'pack.preferBitmapTips' '
 	)
 '
 
+test_expect_success 'writing a bitmap with --refs-snapshot' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit one &&
+		test_commit two &&
+
+		git rev-parse one >snapshot &&
+
+		git repack -ad &&
+
+		# First, write a MIDX which see both refs/tags/one and
+		# refs/tags/two (causing both of those commits to receive
+		# bitmaps).
+		git multi-pack-index write --bitmap &&
+
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+		test-tool bitmap list-commits | sort >bitmaps &&
+		grep "$(git rev-parse one)" bitmaps &&
+		grep "$(git rev-parse two)" bitmaps &&
+
+		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
+		rm -fr $midx-$(midx_checksum $objdir).rev &&
+		rm -fr $midx &&
+
+		# Then again, but with a refs snapshot which only sees
+		# refs/tags/one.
+		git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
+
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+		test-tool bitmap list-commits | sort >bitmaps &&
+		grep "$(git rev-parse one)" bitmaps &&
+		! grep "$(git rev-parse two)" bitmaps
+	)
+'
+
+test_expect_success 'write a bitmap with --refs-snapshot (preferred tips)' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit_bulk --message="%s" 103 &&
+
+		git log --format="%H" >commits.raw &&
+		sort <commits.raw >commits &&
+
+		git log --format="create refs/tags/%s %H" HEAD >refs &&
+		git update-ref --stdin <refs &&
+
+		git multi-pack-index write --bitmap &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+
+		test-tool bitmap list-commits | sort >bitmaps &&
+		comm -13 bitmaps commits >before &&
+		test_line_count = 1 before &&
+
+		(
+			grep -vf before commits.raw &&
+			# mark missing commits as preferred
+			sed "s/^/+/" before
+		) >snapshot &&
+
+		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
+		rm -fr $midx-$(midx_checksum $objdir).rev &&
+		rm -fr $midx &&
+
+		git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
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

