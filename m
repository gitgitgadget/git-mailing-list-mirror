Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3582FE06
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XYXG103Y"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE7FD6E
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 14:56:35 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d0ea3e5b8so32948116d6.0
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 14:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699311394; x=1699916194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jR12zIc/T0ZwMYnH0WA7WIxwACKUGUCgecLVT4TLNqg=;
        b=XYXG103YosjH5cRaynDjd26xvi7Sx5aagad2fs1w9lFOk6BPQa9l3vpkBT9UD3Ra0U
         GP0cCgB+pZVcl3Fj/G2fTPTejH+B7B+Y5ifpjA0uai4I77neo73asiZ/78PvbpahZ6ii
         wplW99g4FdFQIaje9QXfyCJvd48P6QdPvQ5AtJIFr85YL+8Z5tWBziYZuq1PdqcUl+oq
         8AyAfEaMS3tLVKkEGBdany5i1SppguU69Ns08Ny739clgrg46/HA2Cc3iMWu9wYAfP1l
         L/h0Q/0tYmxZwceDYfIGYnM7aoVf6o291Y2l5q+mPBdgzgz73mt517EcUTg85z5pJJtE
         z5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699311394; x=1699916194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR12zIc/T0ZwMYnH0WA7WIxwACKUGUCgecLVT4TLNqg=;
        b=anAMvxD8rpogqBfr8v3nbZfdjFadf/yEhfQKKFkh6ImokP941TzYnuITfcQrDAymBh
         /8YtPGHBaw+NU38ipCESITchqWjYB/mIt3Wj8zgtjopleYFd5Osc73/fPP74L1mYUOOB
         TlZnnGukw42cqxbCzH05YVkXgzKPefneQfzKWQfmdG37bNz9uIN2E/gHsD/BSCIkUwXI
         gPGJNOuT3lKfwRIhiVWx9mSe6RLW0hByW3ixAHn33tGxPKUideOGZN1Z0wSzk7qIduBh
         ukab00LhUH4KYUrTSB+Jd7wexa/13WAmZylk/LQi2YaOmcGznWY9rQlCk5iA2bQu0963
         reHA==
X-Gm-Message-State: AOJu0YzhkgmIdW9sLKOc8kjzP6aFfS3ZgVTZTFY2Wbjqet+2KSiIswVI
	Gsj2Dlfxp64YSSQonCIQGqp9JvDuWnP38iqOD1g/pw==
X-Google-Smtp-Source: AGHT+IFSNVlanpLxKwgFYIQ3P54V53N9F81oiXF5lVGcejiMTMbSLRlU5BCk744ZKEgVvOCftLLWRQ==
X-Received: by 2002:a05:6214:2507:b0:66d:36fb:474d with SMTP id gf7-20020a056214250700b0066d36fb474dmr39381863qvb.1.1699311394179;
        Mon, 06 Nov 2023 14:56:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x3-20020a0ceb83000000b0067095b0c473sm3868574qvo.11.2023.11.06.14.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:56:33 -0800 (PST)
Date: Mon, 6 Nov 2023 17:56:33 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] pack-bitmap: drop --unpacked non-commit objects from
 results
Message-ID: <7492dc699052a392d2fb394e1dcfabebac82ded0.1699311386.git.me@ttaylorr.com>
References: <cover.1699311386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699311386.git.me@ttaylorr.com>

When performing revision queries with `--objects` and
`--use-bitmap-index`, the output may incorrectly contain objects which
are packed, even when the `--unpacked` option is given. This affects
traversals, but also other querying operations, like `--count`,
`--disk-usage`, etc.

Like in the previous commit, the fix is to exclude those objects from
the result set before they are shown to the user (or, in this case,
before the bitmap containing the result of the traversal is enumerated
and its objects listed).

This is performed by a new function in pack-bitmap.c, called
`filter_packed_objects_from_bitmap()`. Note that we do not have to
inspect individual bits in the result bitmap, since we know that the
first N (where N is the number of objects in the bitmap's pack/MIDX)
bits correspond to objects which packed by definition.

In other words, for an object to have a bitmap position (not in the
extended index), it must appear in either the bitmap's pack or one of
the packs in its MIDX.

This presents an appealing optimization to us, which is that we can
simply memset() the corresponding number of `eword_t`'s to zero,
provided that we handle any objects which spill into the next word (but
don't occupy all 64 bits of the word itself).

We only have to handle objects in the bitmap's extended index. These
objects may (or may not) appear in one or more pack(s). Since these
objects are known to not appear in either the bitmap's MIDX or pack,
they may be stored as loose, appear in other pack(s), or both.

Before returning a bitmap containing the result of the traversal back to
the caller, drop any bits from the extended index which appear in one or
more packs. This implements the correct behavior for rev-list operations
which use the bitmap index to compute their result.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c                      | 27 +++++++++++++++++++++++++++
 t/t6113-rev-list-bitmap-filters.sh | 13 +++++++++++++
 t/t6115-rev-list-du.sh             |  7 +++++++
 3 files changed, 47 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ca8319b87c..0260890341 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1666,6 +1666,30 @@ static int can_filter_bitmap(struct list_objects_filter_options *filter)
 	return !filter_bitmap(NULL, NULL, NULL, filter);
 }
 
+
+static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
+					      struct bitmap *result)
+{
+	struct eindex *eindex = &bitmap_git->ext_index;
+	uint32_t objects_nr;
+	size_t i, pos;
+
+	objects_nr = bitmap_num_objects(bitmap_git);
+	pos = objects_nr / BITS_IN_EWORD;
+
+	if (pos > result->word_alloc)
+		pos = result->word_alloc;
+
+	memset(result->words, 0x00, sizeof(eword_t) * pos);
+	for (i = pos * BITS_IN_EWORD; i < objects_nr; i++)
+		bitmap_unset(result, i);
+
+	for (i = 0; i < eindex->count; ++i) {
+		if (has_object_pack(&eindex->objects[i]->oid))
+			bitmap_unset(result, objects_nr + i);
+	}
+}
+
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 int filter_provided_objects)
 {
@@ -1788,6 +1812,9 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 		      wants_bitmap,
 		      &revs->filter);
 
+	if (revs->unpacked)
+		filter_packed_objects_from_bitmap(bitmap_git, wants_bitmap);
+
 	bitmap_git->result = wants_bitmap;
 	bitmap_git->haves = haves_bitmap;
 
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
index 4d8e09167e..86c70521f1 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -141,4 +141,17 @@ test_expect_success 'combine filter with --filter-provided-objects' '
 	done <objects
 '
 
+test_expect_success 'bitmap traversal with --unpacked' '
+	git repack -adb &&
+	test_commit unpacked &&
+
+	git rev-list --objects --no-object-names unpacked^.. >expect.raw &&
+	sort expect.raw >expect &&
+
+	git rev-list --use-bitmap-index --objects --all --unpacked >actual.raw &&
+	sort actual.raw >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index d59111dede..c0cfda62fa 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -48,6 +48,13 @@ check_du HEAD
 check_du --objects HEAD
 check_du --objects HEAD^..HEAD
 
+test_expect_success 'setup for --unpacked tests' '
+	git repack -adb &&
+	test_commit unpacked
+'
+
+check_du --all --objects --unpacked
+
 # As mentioned above, don't use hardcode sizes as actual size, but use the
 # output from git cat-file.
 test_expect_success 'rev-list --disk-usage=human' '
-- 
2.43.0.rc0.2.gef6b2154a3
