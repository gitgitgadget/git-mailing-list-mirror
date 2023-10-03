Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83748E8FDBB
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 21:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjJCVyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241282AbjJCVyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 17:54:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2BFAC
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 14:54:21 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7741b18a06aso105325485a.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696370061; x=1696974861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qJLWfz9fCJIr/3Lq4nf/gMwnx8EALDwY0YP3f5HSq8=;
        b=l0SjwJUJS+b0/37uSkiIY/yQmMjaeBH0flVr+Ax8y29fkV/eEl/3PEdhnl9k0p7B9D
         xCEmH1/wibJVIanj5Laa7ECnOaYpg/OaH+A77s3ktsnGlbpz23AQ+rM2Ccgh3Wo/4U8J
         EODSmfDbt8O8Gj32j6n53tgCQ6flM8HJBA5oP8aeI8JVuZGLmlhRhhdsYnGTbgI8/f9j
         fdbVxZnj3cikWKogcT+g4Ns81JZbL1rrR4clsUvofEYw6NDEB2V6/1sVOFTOTFwEV0Ps
         mU3Tv0pW0oIM5iSobh3NEpBVRto65C//rKNJYi8Piv1wuc2kSlxXZZPYFqlkCsqwcsHP
         gOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696370061; x=1696974861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qJLWfz9fCJIr/3Lq4nf/gMwnx8EALDwY0YP3f5HSq8=;
        b=fdIMM3i57wvtDssr279Pus0EZ6UD2C+Q/lmfycTfI2i3qotl07O/Gkn8IajMKQSLEO
         fQq0vsKZ8IYZoY1GdUTfDNGhlT9RZgcydMDUSHFTkujK6mfwSXl7s6mtS7m7YXHJ63Dh
         VGmVOcz5ktyMIfzed0H1tWI145B3l17pTj3XsH7HPAxuPUW+yfEY40B2NEcEmY2NUAzY
         0K6s2YcQbSH1CtiomgVRxya9iZ+1VYvltzx2b7OmXB7d55CBkBT1iw3XrvW9E2FeR5VD
         oaNHtlxObsmU97wpMz5MBvFjAAJHXQxO4eRecsDro4mn9Y8I2FLhE73O/TJKynlrijiX
         I7og==
X-Gm-Message-State: AOJu0Yw3bKFaJ70LC/4s+rLfZcjLNwFWDJxNLHAR5kwVfKe966OJU9Qb
        nTTmn8N8p1tKvnywRPqEH/IsVVpzXCENiiN16GFl3Q==
X-Google-Smtp-Source: AGHT+IEdHwQveh/wUvSD3mbCl87XEooNpvsWW+TorGR0X8QBv7+53vzRuSu2vwUr2AlanRdUW4bZLg==
X-Received: by 2002:a05:6214:328b:b0:658:2857:ed6a with SMTP id mu11-20020a056214328b00b006582857ed6amr654532qvb.43.1696370060741;
        Tue, 03 Oct 2023 14:54:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v14-20020a0ccd8e000000b0065b2be40d58sm806315qvm.25.2023.10.03.14.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:54:20 -0700 (PDT)
Date:   Tue, 3 Oct 2023 17:54:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] builtin/repack.c: avoid making cruft packs preferred
Message-ID: <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com>
References: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19d9aae08eab05c6b5dda4c2090236b1c3f62998.1696349955.git.me@ttaylorr.com>
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

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
A small re-roll of the original patch, removing a few paragraphs from
the proposed log message that are irrelevant and impossible to produce
in today's git.git.

For more details, see <ZRyNHRf+tQwV+T6P@nand.local>.

Range-diff against v1:
1:  19d9aae08e ! 1:  0353939351 builtin/repack.c: avoid making cruft packs preferred
    @@ Commit message
         have to repack the entire repository during a `--geometric` repack, and
         the cruft pack would have to sort ahead of the pack we just created.

    -    Note that this behavior is usually just a performance regression. But
    -    it's possible it could be a correctness issue.
    -
    -    Suppose an object was duplicated among the cruft and non-cruft pack. The
    -    MIDX will pick the one from the pack with the lowest mtime, which will
    -    always be the cruft one. But if the non-cruft pack happens to sort
    -    earlier in lexical order, we'll treat that one as preferred, but not all
    -    duplicates will be resolved in favor of that pack.
    -
    -    So if we happened to have an object which appears in both packs
    -    (e.g., due to a cruft object being freshened, causing it to appear
    -    loose, and then repacking it via the `--geometric` repack) it's possible
    -    the duplicate would be picked from the non-preferred pack.
    -
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## builtin/repack.c ##

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
2.42.0.341.g9d86323b73.dirty
