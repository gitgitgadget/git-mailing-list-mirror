Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150C5C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34E364E58
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBRDPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBRDPk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 22:15:40 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5168AC061793
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:44 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id y10so329044qvo.6
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jIKEo2HdKBnmzff+hMCzUOjthefC0qH1JpG0EkVyRzw=;
        b=t6MvI+93GC/zGxYKHilRCU3udHmEHH9gNR3997RXYNlaosHZsuClMpVUrkroIRjMJS
         3uMp24bNIkfZThZ+PXbEj0mhkjuN7RXQy9C9uh1wFVkyS38uf+AyoSlKtaFWM6yXELyo
         7Ke8UskW/YpPM2dzV9dsMscFAEMeimOKXf1zg+whB+reCP00x2KjIGur+kTzyuwhV6Pn
         aAqJ3u/CT5ftS7PCIKOmZfc22s0v0R7Rl4sp7QvGF5IYgKK6mP1GZPSi3zfZZX5JWmU8
         xQwRqS1NfV+Uh9a5Ka4zb4xBq2fMNJlK1kWr9/IuATqvFikFaOGJxPpOtnHSlzDqQUQs
         rpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jIKEo2HdKBnmzff+hMCzUOjthefC0qH1JpG0EkVyRzw=;
        b=cype8aZnGZOqmZRwAWw/tnJWFUSpkdRSW0Ny+VVPKafT8vqtuxCXibyJCXIMZfsiz0
         4Q7FKaRwxqWsqn1G89Xxp7tS3z2Vc07lU4AxPc+7S19zTn2Jq2m64N1NlaS/SUJRZzot
         SX+q3FwjuW+/O/kH37KjAEos0iAM1RmmKtgPwVtXoLYOYKC+GX5t2Rkzg5ohnp9zs22c
         d0JdaQB/FS7oZix0b+G7O2QB+/3y4M3zJd4zAr5GcONpbY5P6VdgEAuZaQzKxGNFOE/d
         ktdHMAArqpsZi+YOygBdn98LFt3CGQgxOSIoJw64KqzrctPRX33XTg+ObSPNr65kL/rO
         b+aw==
X-Gm-Message-State: AOAM532H9yUTZkcmAXsQ8coKkl7z1VftugLdqErA66I/64KwN6wGZhse
        ASGpHnXEmSRz6vw4EGFdn14YVpvXcvDdY1JN
X-Google-Smtp-Source: ABdhPJwUEc1LGY+/4NJ7kPgnJCicpocaDEO0mNS818U3HZdkmQp+XccUO/3LVz5YhrqT79zJ3WPwLw==
X-Received: by 2002:ad4:55aa:: with SMTP id f10mr2577230qvx.46.1613618083013;
        Wed, 17 Feb 2021 19:14:43 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1f29:6ff9:b466:8c60])
        by smtp.gmail.com with ESMTPSA id v12sm1352362qtw.73.2021.02.17.19.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:14:42 -0800 (PST)
Date:   Wed, 17 Feb 2021 22:14:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v3 8/8] builtin/repack.c: add '--geometric' option
Message-ID: <bd492ec1429e86a5fc836a474f3dbf87b8723be5.1613618042.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1613618042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1613618042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Often it is useful to both:

  - have relatively few packfiles in a repository, and

  - avoid having so few packfiles in a repository that we repack its
    entire contents regularly

This patch implements a '--geometric=<n>' option in 'git repack'. This
allows the caller to specify that they would like each pack to be at
least a factor times as large as the previous largest pack (by object
count).

Concretely, say that a repository has 'n' packfiles, labeled P1, P2,
..., up to Pn. Each packfile has an object count equal to 'objects(Pn)'.
With a geometric factor of 'r', it should be that:

  objects(Pi) > r*objects(P(i-1))

for all i in [1, n], where the packs are sorted by

  objects(P1) <= objects(P2) <= ... <= objects(Pn).

Since finding a true optimal repacking is NP-hard, we approximate it
along two directions:

  1. We assume that there is a cutoff of packs _before starting the
     repack_ where everything to the right of that cut-off already forms
     a geometric progression (or no cutoff exists and everything must be
     repacked).

  2. We assume that everything smaller than the cutoff count must be
     repacked. This forms our base assumption, but it can also cause
     even the "heavy" packs to get repacked, for e.g., if we have 6
     packs containing the following number of objects:

       1, 1, 1, 2, 4, 32

     then we would place the cutoff between '1, 1' and '1, 2, 4, 32',
     rolling up the first two packs into a pack with 2 objects. That
     breaks our progression and leaves us:

       2, 1, 2, 4, 32
         ^

     (where the '^' indicates the position of our split). To restore a
     progression, we move the split forward (towards larger packs)
     joining each pack into our new pack until a geometric progression
     is restored. Here, that looks like:

       2, 1, 2, 4, 32  ~>  3, 2, 4, 32  ~>  5, 4, 32  ~> ... ~> 9, 32
         ^                   ^                ^                   ^

This has the advantage of not repacking the heavy-side of packs too
often while also only creating one new pack at a time. Another wrinkle
is that we assume that loose, indexed, and reflog'd objects are
insignificant, and lump them into any new pack that we create. This can
lead to non-idempotent results.

Suggested-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.txt |  22 +++++
 builtin/repack.c             | 187 ++++++++++++++++++++++++++++++++++-
 t/t7703-repack-geometric.sh  | 137 +++++++++++++++++++++++++
 3 files changed, 342 insertions(+), 4 deletions(-)
 create mode 100755 t/t7703-repack-geometric.sh

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 92f146d27d..21c7068925 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -165,6 +165,28 @@ depth is 4095.
 	Pass the `--delta-islands` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
 
+-g=<factor>::
+--geometric=<factor>::
+	Arrange resulting pack structure so that each successive pack
+	contains at least `<factor>` times the number of objects as the
+	next-largest pack.
++
+`git repack` ensures this by determining a "cut" of packfiles that need
+to be repacked into one in order to ensure a geometric progression. It
+picks the smallest set of packfiles such that as many of the larger
+packfiles (by count of objects contained in that pack) may be left
+intact.
++
+Unlike other repack modes, the set of objects to pack is determined
+uniquely by the set of packs being "rolled-up"; in other words, the
+packs determined to need to be combined in order to restore a geometric
+progression.
++
+Loose objects are implicitly included in this "roll-up", without respect
+to their reachability. This is subject to change in the future. This
+option (implying a drastically different repack mode) is not guarenteed
+to work with all other combinations of option to `git repack`).
+
 Configuration
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 01440de2d5..bcf280b10d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -297,6 +297,124 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
 
+struct pack_geometry {
+	struct packed_git **pack;
+	uint32_t pack_nr, pack_alloc;
+	uint32_t split;
+};
+
+static uint32_t geometry_pack_weight(struct packed_git *p)
+{
+	if (open_pack_index(p))
+		die(_("cannot open index for %s"), p->pack_name);
+	return p->num_objects;
+}
+
+static int geometry_cmp(const void *va, const void *vb)
+{
+	uint32_t aw = geometry_pack_weight(*(struct packed_git **)va),
+		 bw = geometry_pack_weight(*(struct packed_git **)vb);
+
+	if (aw < bw)
+		return -1;
+	if (aw > bw)
+		return 1;
+	return 0;
+}
+
+static void init_pack_geometry(struct pack_geometry **geometry_p)
+{
+	struct packed_git *p;
+	struct pack_geometry *geometry;
+
+	*geometry_p = xcalloc(1, sizeof(struct pack_geometry));
+	geometry = *geometry_p;
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		if (!pack_kept_objects && p->pack_keep)
+			continue;
+
+		ALLOC_GROW(geometry->pack,
+			   geometry->pack_nr + 1,
+			   geometry->pack_alloc);
+
+		geometry->pack[geometry->pack_nr] = p;
+		geometry->pack_nr++;
+	}
+
+	QSORT(geometry->pack, geometry->pack_nr, geometry_cmp);
+}
+
+static void split_pack_geometry(struct pack_geometry *geometry, int factor)
+{
+	uint32_t i;
+	uint32_t split;
+	off_t total_size = 0;
+
+	if (geometry->pack_nr <= 1) {
+		geometry->split = geometry->pack_nr;
+		return;
+	}
+
+	split = geometry->pack_nr - 1;
+
+	/*
+	 * First, count the number of packs (in descending order of size) which
+	 * already form a geometric progression.
+	 */
+	for (i = geometry->pack_nr - 1; i > 0; i--) {
+		struct packed_git *ours = geometry->pack[i];
+		struct packed_git *prev = geometry->pack[i - 1];
+		if (geometry_pack_weight(ours) >= factor * geometry_pack_weight(prev))
+			split--;
+		else
+			break;
+	}
+
+	if (split) {
+		/*
+		 * Move the split one to the right, since the top element in the
+		 * last-compared pair can't be in the progression. Only do this
+		 * when we split in the middle of the array (otherwise if we got
+		 * to the end, then the split is in the right place).
+		 */
+		split++;
+	}
+
+	/*
+	 * Then, anything to the left of 'split' must be in a new pack. But,
+	 * creating that new pack may cause packs in the heavy half to no longer
+	 * form a geometric progression.
+	 *
+	 * Compute an expected size of the new pack, and then determine how many
+	 * packs in the heavy half need to be joined into it (if any) to restore
+	 * the geometric progression.
+	 */
+	for (i = 0; i < split; i++)
+		total_size += geometry_pack_weight(geometry->pack[i]);
+	for (i = split; i < geometry->pack_nr; i++) {
+		struct packed_git *ours = geometry->pack[i];
+		if (geometry_pack_weight(ours) < factor * total_size) {
+			split++;
+			total_size += geometry_pack_weight(ours);
+		} else
+			break;
+	}
+
+	geometry->split = split;
+}
+
+static void clear_pack_geometry(struct pack_geometry *geometry)
+{
+	if (!geometry)
+		return;
+
+	free(geometry->pack);
+	geometry->pack_nr = 0;
+	geometry->pack_alloc = 0;
+	geometry->split = 0;
+}
+
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -304,6 +422,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_packs = STRING_LIST_INIT_DUP;
+	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
 	int i, ext, ret;
 	FILE *out;
@@ -316,6 +435,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	int no_update_server_info = 0;
 	struct pack_objects_args po_args = {NULL};
+	int geometric_factor = 0;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -356,6 +476,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
+		OPT_INTEGER('g', "geometric", &geometric_factor,
+			    N_("find a geometric progression with factor <N>")),
 		OPT_END()
 	};
 
@@ -382,6 +504,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
 		die(_(incremental_bitmap_conflict_error));
 
+	if (geometric_factor) {
+		if (pack_everything)
+			die(_("--geometric is incompatible with -A, -a"));
+		init_pack_geometry(&geometry);
+		split_pack_geometry(geometry, geometric_factor);
+	}
+
 	packdir = mkpathdup("%s/pack", get_object_directory());
 	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
 
@@ -396,9 +525,19 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_pushf(&cmd.args, "--keep-pack=%s",
 			     keep_pack_list.items[i].string);
 	strvec_push(&cmd.args, "--non-empty");
-	strvec_push(&cmd.args, "--all");
-	strvec_push(&cmd.args, "--reflog");
-	strvec_push(&cmd.args, "--indexed-objects");
+	if (!geometry) {
+		/*
+		 * 'git pack-objects' will up all objects loose or packed
+		 * (either rolling them up or leaving them alone), so don't pass
+		 * these options.
+		 *
+		 * The implementation of 'git pack-objects --stdin-packs'
+		 * makes them redundant (and the two are incompatible).
+		 */
+		strvec_push(&cmd.args, "--all");
+		strvec_push(&cmd.args, "--reflog");
+		strvec_push(&cmd.args, "--indexed-objects");
+	}
 	if (has_promisor_remote())
 		strvec_push(&cmd.args, "--exclude-promisor-objects");
 	if (write_bitmaps > 0)
@@ -429,17 +568,37 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				strvec_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
 			}
 		}
+	} else if (geometry) {
+		strvec_push(&cmd.args, "--stdin-packs");
+		strvec_push(&cmd.args, "--unpacked");
 	} else {
 		strvec_push(&cmd.args, "--unpacked");
 		strvec_push(&cmd.args, "--incremental");
 	}
 
-	cmd.no_stdin = 1;
+	if (geometry)
+		cmd.in = -1;
+	else
+		cmd.no_stdin = 1;
 
 	ret = start_command(&cmd);
 	if (ret)
 		return ret;
 
+	if (geometry) {
+		FILE *in = xfdopen(cmd.in, "w");
+		/*
+		 * The resulting pack should contain all objects in packs that
+		 * are going to be rolled up, but exclude objects in packs which
+		 * are being left alone.
+		 */
+		for (i = 0; i < geometry->split; i++)
+			fprintf(in, "%s\n", pack_basename(geometry->pack[i]));
+		for (i = geometry->split; i < geometry->pack_nr; i++)
+			fprintf(in, "^%s\n", pack_basename(geometry->pack[i]));
+		fclose(in);
+	}
+
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		if (line.len != the_hash_algo->hexsz)
@@ -507,6 +666,25 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			if (!string_list_has_string(&names, sha1))
 				remove_redundant_pack(packdir, item->string);
 		}
+
+		if (geometry) {
+			struct strbuf buf = STRBUF_INIT;
+
+			uint32_t i;
+			for (i = 0; i < geometry->split; i++) {
+				struct packed_git *p = geometry->pack[i];
+				if (string_list_has_string(&names,
+							   hash_to_hex(p->hash)))
+					continue;
+
+				strbuf_reset(&buf);
+				strbuf_addstr(&buf, pack_basename(p));
+				strbuf_strip_suffix(&buf, ".pack");
+
+				remove_redundant_pack(packdir, buf.buf);
+			}
+			strbuf_release(&buf);
+		}
 		if (!po_args.quiet && isatty(2))
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
@@ -528,6 +706,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_packs, 0);
+	clear_pack_geometry(geometry);
 	strbuf_release(&line);
 
 	return 0;
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
new file mode 100755
index 0000000000..96917fc163
--- /dev/null
+++ b/t/t7703-repack-geometric.sh
@@ -0,0 +1,137 @@
+#!/bin/sh
+
+test_description='git repack --geometric works correctly'
+
+. ./test-lib.sh
+
+GIT_TEST_MULTI_PACK_INDEX=0
+
+objdir=.git/objects
+midx=$objdir/pack/multi-pack-index
+
+test_expect_success '--geometric with no packs' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		git repack --geometric 2 >out &&
+		test_i18ngrep "Nothing new to pack" out
+	)
+'
+
+test_expect_success '--geometric with an intact progression' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		# These packs already form a geometric progression.
+		test_commit_bulk --start=1 1 && # 3 objects
+		test_commit_bulk --start=2 2 && # 6 objects
+		test_commit_bulk --start=4 4 && # 12 objects
+
+		find $objdir/pack -name "*.pack" | sort >expect &&
+		git repack --geometric 2 -d &&
+		find $objdir/pack -name "*.pack" | sort >actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--geometric with small-pack rollup' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		test_commit_bulk --start=1 1 && # 3 objects
+		test_commit_bulk --start=2 1 && # 3 objects
+		find $objdir/pack -name "*.pack" | sort >small &&
+		test_commit_bulk --start=3 4 && # 12 objects
+		test_commit_bulk --start=7 8 && # 24 objects
+		find $objdir/pack -name "*.pack" | sort >before &&
+
+		git repack --geometric 2 -d &&
+
+		# Three packs in total; two of the existing large ones, and one
+		# new one.
+		find $objdir/pack -name "*.pack" | sort >after &&
+		test_line_count = 3 after &&
+		comm -3 small before | tr -d "\t" >large &&
+		grep -qFf large after
+	)
+'
+
+test_expect_success '--geometric with small- and large-pack rollup' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		# size(small1) + size(small2) > size(medium) / 2
+		test_commit_bulk --start=1 1 && # 3 objects
+		test_commit_bulk --start=2 1 && # 3 objects
+		test_commit_bulk --start=2 3 && # 7 objects
+		test_commit_bulk --start=6 9 && # 27 objects &&
+
+		find $objdir/pack -name "*.pack" | sort >before &&
+
+		git repack --geometric 2 -d &&
+
+		find $objdir/pack -name "*.pack" | sort >after &&
+		comm -12 before after >untouched &&
+
+		# Two packs in total; the largest pack from before running "git
+		# repack", and one new one.
+		test_line_count = 1 untouched &&
+		test_line_count = 2 after
+	)
+'
+
+test_expect_success '--geometric ignores kept packs' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		test_commit kept && # 3 objects
+		test_commit pack && # 3 objects
+
+		KEPT=$(git pack-objects --revs $objdir/pack/pack <<-EOF
+		refs/tags/kept
+		EOF
+		) &&
+		PACK=$(git pack-objects --revs $objdir/pack/pack <<-EOF
+		refs/tags/pack
+		^refs/tags/kept
+		EOF
+		) &&
+
+		# neither pack contains more than twice the number of objects in
+		# the other, so they should be combined. but, marking one as
+		# .kept on disk will "freeze" it, so the pack structure should
+		# remain unchanged.
+		touch $objdir/pack/pack-$KEPT.keep &&
+
+		find $objdir/pack -name "*.pack" | sort >before &&
+		git repack --geometric 2 -d &&
+		find $objdir/pack -name "*.pack" | sort >after &&
+
+		# both packs should still exist
+		test_path_is_file $objdir/pack/pack-$KEPT.pack &&
+		test_path_is_file $objdir/pack/pack-$PACK.pack &&
+
+		# and no new packs should be created
+		test_cmp before after &&
+
+		# Passing --pack-kept-objects causes packs with a .keep file to
+		# be repacked, too.
+		git repack --geometric 2 -d --pack-kept-objects &&
+
+		find $objdir/pack -name "*.pack" >after &&
+		test_line_count = 1 after
+	)
+'
+
+test_done
-- 
2.30.0.667.g81c0cbc6fd
