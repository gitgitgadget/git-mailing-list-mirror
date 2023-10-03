Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC627E7AD77
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 16:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbjJCQ16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbjJCQ15 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 12:27:57 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87A7AD
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 09:27:53 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d81b42a3108so1251802276.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696350472; x=1696955272; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uftPPbZa4i4B4QO8OvnT9UMXV63ivEzsmomY1ND3J14=;
        b=aZcdhIAiM9w+Wl0O7qN0DM6UeHJX4N5YiGwqmlzkhlE4mUUr29Bj8vCgalOt0ynKzb
         HUpmREhYnFHP9iNhn35shrdN8LyHeuqPxR8kXBpmagA5lnOswI8YpxnQuJnsVEW5WgBe
         YDuok9g1bW/mRM5oOqWhsCf3ZjTTrfevwoE4dlCLx4lBR1QlQrFtcsAYYGdU25vIV2Im
         wELN5/h19sHJFP5zCjX+BPQRe6d+5X5kKylkzzO2a0wMzDDUQ3v/ilVJ0Y35buEd4H8l
         scDG5T9+Ky2xq1meuIK3FOXS/G9CmDLjjmC12HBVMt3XErx3m75h76THjpzm+vaddW2t
         prdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350472; x=1696955272;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uftPPbZa4i4B4QO8OvnT9UMXV63ivEzsmomY1ND3J14=;
        b=DvSui0tmYbUnilMUjWgw/p0c5Beg1pzsraMODb0PyAoHaHaZImBMkdX2eoGM7vKLMV
         9mDFI/+amcIPwNLUreODrgdc4XEJHRklnGfrANBtjQQilNo5bTm03HF7lQC+va5EFwEA
         XIuRFMuNDu2ZlYXDXV+LKxG9OnIP5MmNFUaQCBwWgMOuku8Pgc5r2h+LxiyM3sYdTmJ6
         KT43jtI9+eraM/ARM4+ukYGHAYhsfDnPqXWlC8HzeZ71CjvEQ3oQcoxPzz6CRqZkgJ7o
         Jv59JhY50P+l+x8EylKzgasMtV8BK9IfEVq0GXRzsldbyM1ieItqw/50Unep8B57vmDu
         u0Jg==
X-Gm-Message-State: AOJu0YyohyZWheDe0dFJDQAJsiBkG/f4t0lB3tj9QYbiA26kdwRooYt/
        2yqTqNoh4U+FS//ncnIs8o6sW4g4VfUIrVR07I/VZg==
X-Google-Smtp-Source: AGHT+IH43KqAEaToAq53SxZh1sdZpyNV5RKXBPXG10d6stkctFUglmICnmqjjqd6rqdvC+3Ce1/POw==
X-Received: by 2002:a25:2344:0:b0:d7b:97e0:14ab with SMTP id j65-20020a252344000000b00d7b97e014abmr12476709ybj.57.1696350472580;
        Tue, 03 Oct 2023 09:27:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e21-20020a0caa55000000b0065b2167fd63sm601849qvb.65.2023.10.03.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:27:52 -0700 (PDT)
Date:   Tue, 3 Oct 2023 12:27:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] builtin/repack.c: avoid making cruft packs preferred
Message-ID: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing a `--geometric` repack, we make sure that the preferred pack
(if writing a MIDX) is the largest pack that we *didn't* repack. That
has the effect of keeping the preferred pack in sync with the pack
containing a majority of the repository's reachable objects.

But if the repository happens to double in size, we'll repack
everything. Here we don't specify any `--preferred-pack`, and instead
let the MIDX code choose.

In the past, that worked fine, since there would only be one pack to
choose from: the one we just wrote. But it's no longer necessarily the
case that there is one pack to choose from. It's possible that the
repository also has a cruft pack, too.

If the cruft pack happens to come earlier in lexical order (and has an
earlier mtime than any non-cruft pack), we'll pick that pack as
preferred. This makes it impossible to reuse chunks of the reachable
pack verbatim from pack-objects, so is sub-optimal.

Luckily, this is a somewhat rare circumstance to be in, since we would
have to repack the entire repository during a `--geometric` repack, and
the cruft pack would have to sort ahead of the pack we just created.

Note that this behavior is usually just a performance regression. But
it's possible it could be a correctness issue.

Suppose an object was duplicated among the cruft and non-cruft pack. The
MIDX will pick the one from the pack with the lowest mtime, which will
always be the cruft one. But if the non-cruft pack happens to sort
earlier in lexical order, we'll treat that one as preferred, but not all
duplicates will be resolved in favor of that pack.

So if we happened to have an object which appears in both packs
(e.g., due to a cruft object being freshened, causing it to appear
loose, and then repacking it via the `--geometric` repack) it's possible
the duplicate would be picked from the non-preferred pack.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
I've had this sitting in my patch queue for a while now. It's a
non-critical performance fix that avoids the repack/MIDX machinery from
ever choosing a cruft pack as preferred when writing a MIDX bitmap
without a given --preferred-pack.

There is no correctness issue here, but choosing a pack with few/no
reachable objects means that our pack reuse mechanism will rarely kick
in, resulting in performance degradation.

 builtin/repack.c        | 47 ++++++++++++++++++++++++++++++++++++++++-
 t/t7704-repack-cruft.sh | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 04770b15fe..a1a893d952 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -355,6 +355,18 @@ static struct generated_pack_data *populate_pack_exts(const char *name)
 	return data;
 }

+static int has_pack_ext(const struct generated_pack_data *data,
+			const char *ext)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		if (strcmp(exts[i].name, ext))
+			continue;
+		return !!data->tempfiles[i];
+	}
+	BUG("unknown pack extension: '%s'", ext);
+}
+
 static void repack_promisor_objects(const struct pack_objects_args *args,
 				    struct string_list *names)
 {
@@ -772,6 +784,7 @@ static void midx_included_packs(struct string_list *include,

 static int write_midx_included_packs(struct string_list *include,
 				     struct pack_geometry *geometry,
+				     struct string_list *names,
 				     const char *refs_snapshot,
 				     int show_progress, int write_bitmaps)
 {
@@ -801,6 +814,38 @@ static int write_midx_included_packs(struct string_list *include,
 	if (preferred)
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
 			     pack_basename(preferred));
+	else if (names->nr) {
+		/* The largest pack was repacked, meaning that either
+		 * one or two packs exist depending on whether the
+		 * repository has a cruft pack or not.
+		 *
+		 * Select the non-cruft one as preferred to encourage
+		 * pack-reuse among packs containing reachable objects
+		 * over unreachable ones.
+		 *
+		 * (Note we could write multiple packs here if
+		 * `--max-pack-size` was given, but any one of them
+		 * will suffice, so pick the first one.)
+		 */
+		for_each_string_list_item(item, names) {
+			struct generated_pack_data *data = item->util;
+			if (has_pack_ext(data, ".mtimes"))
+				continue;
+
+			strvec_pushf(&cmd.args, "--preferred-pack=pack-%s.pack",
+				     item->string);
+			break;
+		}
+	} else {
+		/*
+		 * No packs were kept, and no packs were written. The
+		 * only thing remaining are .keep packs (unless
+		 * --pack-kept-objects was given).
+		 *
+		 * Set the `--preferred-pack` arbitrarily here.
+		 */
+		;
+	}

 	if (refs_snapshot)
 		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
@@ -1360,7 +1405,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		struct string_list include = STRING_LIST_INIT_NODUP;
 		midx_included_packs(&include, &existing, &names, &geometry);

-		ret = write_midx_included_packs(&include, &geometry,
+		ret = write_midx_included_packs(&include, &geometry, &names,
 						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
 						show_progress, write_bitmaps > 0);

diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index dc86ca8269..be3735dff0 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -372,4 +372,43 @@ test_expect_success '--max-cruft-size ignores non-local packs' '
 	)
 '

+test_expect_success 'reachable packs are preferred over cruft ones' '
+	repo="cruft-preferred-packs" &&
+	git init "$repo" &&
+	(
+		cd "$repo" &&
+
+		# This test needs to exercise careful control over when a MIDX
+		# is and is not written. Unset the corresponding TEST variable
+		# accordingly.
+		sane_unset GIT_TEST_MULTI_PACK_INDEX &&
+
+		test_commit base &&
+		test_commit --no-tag cruft &&
+
+		non_cruft="$(echo base | git pack-objects --revs $packdir/pack)" &&
+		# Write a cruft pack which both (a) sorts ahead of the non-cruft
+		# pack in lexical order, and (b) has an older mtime to appease
+		# the MIDX preferred pack selection routine.
+		cruft="$(echo pack-$non_cruft.pack | git pack-objects --cruft $packdir/pack-A)" &&
+		test-tool chmtime -1000 $packdir/pack-A-$cruft.pack &&
+
+		test_commit other &&
+		git repack -d &&
+
+		git repack --geometric 2 -d --write-midx --write-bitmap-index &&
+
+		# After repacking, there are two packs left: one reachable one
+		# (which is the result of combining both of the existing two
+		# non-cruft packs), and one cruft pack.
+		find .git/objects/pack -type f -name "*.pack" >packs &&
+		test_line_count = 2 packs &&
+
+		# Make sure that the pack we just wrote is marked as preferred,
+		# not the cruft one.
+		pack="$(test-tool read-midx --preferred-pack $objdir)" &&
+		test_path_is_missing "$packdir/$(basename "$pack" ".idx").mtimes"
+	)
+'
+
 test_done
--
2.42.0.311.ga7f7a0e966.dirty
