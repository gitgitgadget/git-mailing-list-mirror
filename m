Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAE82C6B7
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IByVytpN"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b9fd22bb1aso41410b6e.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592643; x=1703197443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqgbEuvVcDmJPtDsqf7xfDXiJRrRES42+XUwX9wFkfI=;
        b=IByVytpN1d6IHafe3hxB7VcqUrBzoYNeH8TH0E/+kx/bPA+BKE0i1kZzKdmlqzWhEf
         1adAwEoO+yg0Uw40hivX1uxWsMfKc9W0/EewOZ9e4Fdey17TmV1U/r/AWQ/VqFEohi5T
         eu7L4h37NTGN1YrJbypbbNmrHQXjKjVchye7hRrnpNwylp0ie4Slic5Fw43wTjcCAfd1
         hoY/swfdaFX4LxRDDmglTzG1HF1Y1dB89JRGElqZdqmQ7xO7wuiaNyetwAPcSEvI78pm
         6J/JGCLiimE2TB1fEhIGdqcdQW6ZvzoFjNyKBmVX6d5aYw3AJQqtQnmYR5CoZVGK2m8t
         ThBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592643; x=1703197443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqgbEuvVcDmJPtDsqf7xfDXiJRrRES42+XUwX9wFkfI=;
        b=vMumIgnv2BR1JjU/DLI6oOij+G4EtZGu9exj9RzIn+KSnuPM2CehBWRspV4JsEymSU
         +gHl/PzTDQltW4jD+lw5xTuQBGRnqkloOkeAnOyNYG5EkqvLEitJu2L5UhEEpweGimH6
         rYXe5HDSTJkVdCcHWYMMh3s9wroPZHROUdGtF6SArQ5uGlIjEQTAxl9YTLLERW4PZWOd
         QyEX70/42wLpul89iLk1HSnwqY3kD0lT6rlnFEJ07e2cLxyZ4KJCFbnUzqhy1z33ckCl
         EuNsM92rf//1uiONHQNhVC5ZR17u9qAX31GxAVYW3aH0UJYdTrcjp3VhKbtahvl4cp9A
         xQSA==
X-Gm-Message-State: AOJu0YziIK7CxqKtaMKwc14rDAWCPrcsD/PLFmPSVwmmBYrCyU80BWEp
	izA/mjG0bEwU9EwhGW9dhE3o6aiTAR5lKDgvzhrGSA==
X-Google-Smtp-Source: AGHT+IGWsoUe+BmOtlTCdIZ0odAYAkhJuO6cK5h0tAPGwgCQmsIk2yv6a69wMOLR2nNiqKUJOktLUA==
X-Received: by 2002:a05:6808:30a3:b0:3b9:e8f4:a488 with SMTP id bl35-20020a05680830a300b003b9e8f4a488mr12710045oib.26.1702592642895;
        Thu, 14 Dec 2023 14:24:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l3-20020a056808020300b003b8388ffaffsm3535219oie.41.2023.12.14.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:02 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/26] pack-bitmap: simplify
 `reuse_partial_packfile_from_bitmap()` signature
Message-ID: <d851f821fc1c1fa6af8532b7780b2587899b16d8.1702592604.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1702592603.git.me@ttaylorr.com>

The signature of `reuse_partial_packfile_from_bitmap()` currently takes
in a bitmap, as well as three output parameters (filled through
pointers, and passed as arguments), and also returns an integer result.

The output parameters are filled out with: (a) the packfile used for
pack-reuse, (b) the number of objects from that pack that we can reuse,
and (c) a bitmap indicating which objects we can reuse. The return value
is either -1 (when there are no objects to reuse), or 0 (when there is
at least one object to reuse).

Some of these parameters are redundant. Notably, we can infer from the
bitmap how many objects are reused by calling bitmap_popcount(). And we
can similar compute the return value based on that number as well.

As such, clean up the signature of this function to drop the "*entries"
parameter, as well as the int return value, since the single caller of
this function can infer these values themself.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 16 +++++++++-------
 pack-bitmap.c          | 16 +++++++---------
 pack-bitmap.h          |  7 +++----
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 321d7effb0..c3df6d9657 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3943,13 +3943,15 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
 		return -1;
 
-	if (pack_options_allow_reuse() &&
-	    !reuse_partial_packfile_from_bitmap(
-			bitmap_git,
-			&reuse_packfile,
-			&reuse_packfile_objects,
-			&reuse_packfile_bitmap)) {
-		assert(reuse_packfile_objects);
+	if (pack_options_allow_reuse())
+		reuse_partial_packfile_from_bitmap(bitmap_git, &reuse_packfile,
+						   &reuse_packfile_bitmap);
+
+	if (reuse_packfile) {
+		reuse_packfile_objects = bitmap_popcount(reuse_packfile_bitmap);
+		if (!reuse_packfile_objects)
+			BUG("expected non-empty reuse bitmap");
+
 		nr_result += reuse_packfile_objects;
 		nr_seen += reuse_packfile_objects;
 		display_progress(progress_state, nr_seen);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d64a80c30c..c75a83e9cc 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2000,10 +2000,9 @@ static int bitmapped_pack_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
-				       struct packed_git **packfile_out,
-				       uint32_t *entries,
-				       struct bitmap **reuse_out)
+void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
+					struct packed_git **packfile_out,
+					struct bitmap **reuse_out)
 {
 	struct repository *r = the_repository;
 	struct bitmapped_pack *packs = NULL;
@@ -2025,7 +2024,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				warning(_("unable to load pack: '%s', disabling pack-reuse"),
 					bitmap_git->midx->pack_names[i]);
 				free(packs);
-				return -1;
+				return;
 			}
 			if (!pack.bitmap_nr)
 				continue; /* no objects from this pack */
@@ -2059,10 +2058,10 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 
 	reuse_partial_packfile_from_bitmap_1(bitmap_git, packs, reuse);
 
-	*entries = bitmap_popcount(reuse);
-	if (!*entries) {
+	if (bitmap_is_empty(reuse)) {
+		free(packs);
 		bitmap_free(reuse);
-		return -1;
+		return;
 	}
 
 	/*
@@ -2072,7 +2071,6 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	bitmap_and_not(result, reuse);
 	*packfile_out = packs[0].p;
 	*reuse_out = reuse;
-	return 0;
 }
 
 int bitmap_walk_contains(struct bitmap_index *bitmap_git,
diff --git a/pack-bitmap.h b/pack-bitmap.h
index b68b213388..ab3fdcde6b 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -78,10 +78,9 @@ int test_bitmap_hashes(struct repository *r);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 int filter_provided_objects);
 uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
-int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
-				       struct packed_git **packfile,
-				       uint32_t *entries,
-				       struct bitmap **reuse_out);
+void reuse_partial_packfile_from_bitmap(struct bitmap_index *,
+					struct packed_git **packfile,
+					struct bitmap **reuse_out);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
 void free_bitmap_index(struct bitmap_index *);
-- 
2.43.0.102.ga31d690331.dirty

