Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CF3C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57AB60E97
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhIOS0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhIOS0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:26:08 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B139C061575
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:49 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a15so4699288iot.2
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qp5eBIGs9+0M+4CFvWwQjzU3Hs+IxWPIKYDg4GeHLX4=;
        b=BA3MJNa0Di+eYjsMn2CLnggOwmfW5lkUwDK09HWTOO9V3n6BV2u76NeYWCifGYnbHM
         qVAY7QGyYy0PYHjg+EdGT8ajSUL5vZlzCCg9noPaFs29sJZVW4NF2eWMYybEW/gWfzVM
         S51W+bIGwRxDBTxygxI+MzNVPpCYgw+Fo8gxm+rOpZT3T3Et4BHgRJqX/DTOcR2SqtuC
         BZa65FoyG3FGsPZsUAnPCH71VfhwKAlGaW1ic0BSNS+agPY93+dyJcr2uyyIMxi6FSwr
         CxHOXxC26z1J23F8Fl03PPQYsXTiqRjfUi3o+QEfWCoxlzswmd1DmVovynVOSeb/muu4
         2N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qp5eBIGs9+0M+4CFvWwQjzU3Hs+IxWPIKYDg4GeHLX4=;
        b=3T8GWL/Udv+QLiT36Kl6VvJ1+m86QJ4w3vL7b+y5nHqOYGcpN6dbEdWsTVXQzoAzvm
         y7q4zhfBbugcSEMKdaY6WqassqULuY9ENgr46q9U+d/iztVeLND75y8mTLJNaV+vtCka
         THOT+uuGOseW9TSrtcKRnpT0pJiglrGfYat7kOE5Ikfs31P3q2lZagMxo4w98qs/lVsk
         C38jJRCWOpN9ALXH7ojmthgvg+H67BsF1bCxwD0ADNJzJ1R8+TFzXieMpHwt854Lzfrt
         XqSmbM7c6U2w+m0buQQWm5AouevQCmtL4vWqUkNLkf4DZjD1oGZBJJKfpmPTuiO0tts1
         oC1g==
X-Gm-Message-State: AOAM532MbKVoA/79T+UmtOiNY5AfqSA327/ZK6mIjQeR38p+QOsVvQbK
        rnSyewj+2Mg5jDbjstBZDV0nn1FatIhUyQAL
X-Google-Smtp-Source: ABdhPJyJazsrJuKEnxHjCtziUYKKYAkBS6bVcBMwNKubzyWH0em8pODrLNMdKZK1Z9hx+GMF/VYalg==
X-Received: by 2002:a02:11c1:: with SMTP id 184mr1193385jaf.70.1631730288678;
        Wed, 15 Sep 2021 11:24:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z15sm402559ils.50.2021.09.15.11.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:24:48 -0700 (PDT)
Date:   Wed, 15 Sep 2021 14:24:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 6/8] builtin/repack.c: support writing a MIDX while
 repacking
Message-ID: <83dfdb8b125efe970659eeea1e5e88b09546c81e.1631730270.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631730270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach `git repack` a new `--write-midx` option for callers that wish to
persist a multi-pack index in their repository while repacking.

There are two existing alternatives to this new flag, but they don't
cover our particular use-case. These alternatives are:

  - Call 'git multi-pack-index write' after running 'git repack', or

  - Set 'GIT_TEST_MULTI_PACK_INDEX=1' in your environment when running
    'git repack'.

The former works, but introduces a gap in bitmap coverage between
repacking and writing a new MIDX (since the repack may have deleted a
pack included in the existing MIDX, invalidating it altogether).

Setting the 'GIT_TEST_' environment variable is obviously unsupported.
In fact, even if it were supported officially, it still wouldn't work,
because it generates the MIDX *after* redundant packs have been dropped,
leading to the same issue as above.

Introduce a new option which eliminates this race by teaching `git
repack` to generate the MIDX at the critical point: after the new packs
have been written and moved into place, but before the redundant packs
have been removed.

This option is compatible with `git repack`'s '--bitmap' option (it
changes the interpretation to be: "write a bitmap corresponding to the
MIDX after one has been generated").

There is a little bit of additional noise in the patch below to avoid
repeating ourselves when selecting which packs to delete. Instead of a
single loop as before (where we iterate over 'existing_packs', decide if
a pack is worth deleting, and if so, delete it), we have two loops (the
first where we decide which ones are worth deleting, and the second
where we actually do the deleting). This makes it so we have a single
check we can make consistently when (1) telling the MIDX which packs we
want to exclude, and (2) actually unlinking the redundant packs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.txt |  14 ++--
 builtin/repack.c             | 129 +++++++++++++++++++++++++++++------
 t/lib-midx.sh                |   8 +++
 t/t7700-repack.sh            |  96 ++++++++++++++++++++++++++
 4 files changed, 224 insertions(+), 23 deletions(-)
 create mode 100644 t/lib-midx.sh

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 24c00c9384..0f2d235ca5 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
 
 DESCRIPTION
 -----------
@@ -128,10 +128,11 @@ depth is 4095.
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
-	only makes sense when used with `-a` or `-A`, as the bitmaps
+	only makes sense when used with `-a`, `-A` or `-m`, as the bitmaps
 	must be able to refer to all reachable objects. This option
-	overrides the setting of `repack.writeBitmaps`.  This option
-	has no effect if multiple packfiles are created.
+	overrides the setting of `repack.writeBitmaps`. This option
+	has no effect if multiple packfiles are created, unless writing a
+	MIDX (in which case a multi-pack bitmap is created).
 
 --pack-kept-objects::
 	Include objects in `.keep` files when repacking.  Note that we
@@ -190,6 +191,11 @@ to change in the future. This option (implying a drastically different
 repack mode) is not guaranteed to work with all other combinations of
 option to `git repack`.
 
+-m::
+--write-midx::
+	Write a multi-pack index (see linkgit:git-multi-pack-index[1])
+	containing the non-redundant packs.
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index be470546e6..ca18d3dd2e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -433,6 +433,73 @@ static void clear_pack_geometry(struct pack_geometry *geometry)
 	geometry->split = 0;
 }
 
+static void midx_included_packs(struct string_list *include,
+				struct string_list *existing_packs,
+				struct string_list *existing_kept_packs,
+				struct string_list *names,
+				struct pack_geometry *geometry)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, existing_kept_packs)
+		string_list_insert(include, xstrfmt("%s.idx", item->string));
+	for_each_string_list_item(item, names)
+		string_list_insert(include, xstrfmt("pack-%s.idx", item->string));
+	if (geometry) {
+		struct strbuf buf = STRBUF_INIT;
+		uint32_t i;
+		for (i = geometry->split; i < geometry->pack_nr; i++) {
+			struct packed_git *p = geometry->pack[i];
+
+			strbuf_addstr(&buf, pack_basename(p));
+			strbuf_strip_suffix(&buf, ".pack");
+			strbuf_addstr(&buf, ".idx");
+
+			string_list_insert(include, strbuf_detach(&buf, NULL));
+		}
+	} else {
+		for_each_string_list_item(item, existing_packs) {
+			if (item->util)
+				continue;
+			string_list_insert(include, xstrfmt("%s.idx", item->string));
+		}
+	}
+}
+
+static int write_midx_included_packs(struct string_list *include,
+				     int show_progress, int write_bitmaps)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct string_list_item *item;
+	FILE *in;
+	int ret;
+
+	cmd.in = -1;
+	cmd.git_cmd = 1;
+
+	strvec_push(&cmd.args, "multi-pack-index");
+	strvec_pushl(&cmd.args, "write", "--stdin-packs", NULL);
+
+	if (show_progress)
+		strvec_push(&cmd.args, "--progress");
+	else
+		strvec_push(&cmd.args, "--no-progress");
+
+	if (write_bitmaps)
+		strvec_push(&cmd.args, "--bitmap");
+
+	ret = start_command(&cmd);
+	if (ret)
+		return ret;
+
+	in = xfdopen(cmd.in, "w");
+	for_each_string_list_item(item, include)
+		fprintf(in, "%s\n", item->string);
+	fclose(in);
+
+	return finish_command(&cmd);
+}
+
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -456,6 +523,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int no_update_server_info = 0;
 	struct pack_objects_args po_args = {NULL};
 	int geometric_factor = 0;
+	int write_midx = 0;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -498,6 +566,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("do not repack this pack")),
 		OPT_INTEGER('g', "geometric", &geometric_factor,
 			    N_("find a geometric progression with factor <N>")),
+		OPT_BOOL('m', "write-midx", &write_midx,
+			   N_("write a multi-pack index of the resulting packs")),
 		OPT_END()
 	};
 
@@ -514,8 +584,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		die(_("--keep-unreachable and -A are incompatible"));
 
 	if (write_bitmaps < 0) {
-		if (!(pack_everything & ALL_INTO_ONE) ||
-		    !is_bare_repository())
+		if (!write_midx &&
+		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
 			write_bitmaps = 0;
 	} else if (write_bitmaps &&
 		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0) &&
@@ -525,7 +595,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps > 0;
 
-	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
+	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));
 
 	if (geometric_factor) {
@@ -567,10 +637,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 	if (has_promisor_remote())
 		strvec_push(&cmd.args, "--exclude-promisor-objects");
-	if (write_bitmaps > 0)
-		strvec_push(&cmd.args, "--write-bitmap-index");
-	else if (write_bitmaps < 0)
-		strvec_push(&cmd.args, "--write-bitmap-index-quiet");
+	if (!write_midx) {
+		if (write_bitmaps > 0)
+			strvec_push(&cmd.args, "--write-bitmap-index");
+		else if (write_bitmaps < 0)
+			strvec_push(&cmd.args, "--write-bitmap-index-quiet");
+	}
 	if (use_delta_islands)
 		strvec_push(&cmd.args, "--delta-islands");
 
@@ -683,22 +755,41 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 	/* End of pack replacement. */
 
+	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
+		const int hexsz = the_hash_algo->hexsz;
+		string_list_sort(&names);
+		for_each_string_list_item(item, &existing_packs) {
+			char *sha1;
+			size_t len = strlen(item->string);
+			if (len < hexsz)
+				continue;
+			sha1 = item->string + len - hexsz;
+			item->util = (void*)(intptr_t)!string_list_has_string(&names, sha1);
+		}
+	}
+
+	if (write_midx) {
+		struct string_list include = STRING_LIST_INIT_NODUP;
+		midx_included_packs(&include, &existing_packs,
+				    &existing_kept_packs, &names, geometry);
+
+		ret = write_midx_included_packs(&include,
+						show_progress, write_bitmaps > 0);
+
+		string_list_clear(&include, 0);
+
+		if (ret)
+			return ret;
+	}
+
 	reprepare_packed_git(the_repository);
 
 	if (delete_redundant) {
 		int opts = 0;
-		if (pack_everything & ALL_INTO_ONE) {
-			const int hexsz = the_hash_algo->hexsz;
-			string_list_sort(&names);
-			for_each_string_list_item(item, &existing_packs) {
-				char *sha1;
-				size_t len = strlen(item->string);
-				if (len < hexsz)
-					continue;
-				sha1 = item->string + len - hexsz;
-				if (!string_list_has_string(&names, sha1))
-					remove_redundant_pack(packdir, item->string);
-			}
+		for_each_string_list_item(item, &existing_packs) {
+			if (!item->util)
+				continue;
+			remove_redundant_pack(packdir, item->string);
 		}
 
 		if (geometry) {
diff --git a/t/lib-midx.sh b/t/lib-midx.sh
new file mode 100644
index 0000000000..1261994744
--- /dev/null
+++ b/t/lib-midx.sh
@@ -0,0 +1,8 @@
+# test_midx_consistent <objdir>
+test_midx_consistent () {
+	ls $1/pack/pack-*.idx | xargs -n 1 basename | sort >expect &&
+	test-tool read-midx $1 | grep ^pack-.*\.idx$ | sort >actual &&
+
+	test_cmp expect actual &&
+	git multi-pack-index --object-dir=$1 verify
+}
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 98eda3bfeb..6792531dfd 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -3,6 +3,8 @@
 test_description='git repack works correctly'
 
 . ./test-lib.sh
+. "${TEST_DIRECTORY}/lib-bitmap.sh"
+. "${TEST_DIRECTORY}/lib-midx.sh"
 
 commit_and_pack () {
 	test_commit "$@" 1>&2 &&
@@ -234,4 +236,98 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	test_must_be_empty actual
 '
 
+objdir=.git/objects
+midx=$objdir/pack/multi-pack-index
+
+test_expect_success 'setup for --write-midx tests' '
+	git init midx &&
+	(
+		cd midx &&
+		git config core.multiPackIndex true &&
+
+		test_commit base
+	)
+'
+
+test_expect_success '--write-midx unchanged' '
+	(
+		cd midx &&
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack &&
+		test_path_is_missing $midx &&
+		test_path_is_missing $midx-*.bitmap &&
+
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack --write-midx &&
+
+		test_path_is_file $midx &&
+		test_path_is_missing $midx-*.bitmap &&
+		test_midx_consistent $objdir
+	)
+'
+
+test_expect_success '--write-midx with a new pack' '
+	(
+		cd midx &&
+		test_commit loose &&
+
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack --write-midx &&
+
+		test_path_is_file $midx &&
+		test_path_is_missing $midx-*.bitmap &&
+		test_midx_consistent $objdir
+	)
+'
+
+test_expect_success '--write-midx with -b' '
+	(
+		cd midx &&
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack -mb &&
+
+		test_path_is_file $midx &&
+		test_path_is_file $midx-*.bitmap &&
+		test_midx_consistent $objdir
+	)
+'
+
+test_expect_success '--write-midx with -d' '
+	(
+		cd midx &&
+		test_commit repack &&
+
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Ad --write-midx &&
+
+		test_path_is_file $midx &&
+		test_path_is_missing $midx-*.bitmap &&
+		test_midx_consistent $objdir
+	)
+'
+
+test_expect_success 'cleans up MIDX when appropriate' '
+	(
+		cd midx &&
+
+		test_commit repack-2 &&
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb --write-midx &&
+
+		checksum=$(midx_checksum $objdir) &&
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$checksum.bitmap &&
+		test_path_is_file $midx-$checksum.rev &&
+
+		test_commit repack-3 &&
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb --write-midx &&
+
+		test_path_is_file $midx &&
+		test_path_is_missing $midx-$checksum.bitmap &&
+		test_path_is_missing $midx-$checksum.rev &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
+
+		test_commit repack-4 &&
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb &&
+
+		find $objdir/pack -type f -name "multi-pack-index*" >files &&
+		test_must_be_empty files
+	)
+'
+
 test_done
-- 
2.33.0.96.g73915697e6

