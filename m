Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="F77eVjgY"
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531EC1BC
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:26 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77d895c298eso197719085a.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198505; x=1701803305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3NH9e0B7TEOaLke+IJC8tguC6phHHxMJ1QTwr176tI=;
        b=F77eVjgYi7k3DIP5obR9R3peA73pUO26Y5kNMULYwnwG/XMtwmpvXAuWINf3GrWDeM
         mDxmu7BUcVIgnjgogNUGOazIEm+wQv8Kvdalz/0wM1iQXt3sfnKoXHNubE9RqCc06qo8
         5Kba5/YycW+7I0XqquJUujEFT8/B8sxLINfuN/t/SeDt8a5+WbkLYM444K7gezz5H2Uv
         oRe7UN1S3gMYP/an+RTzCmLtlwpGak2Da/vpQmwYM90klmkz1YXN2pXRbscpWGGJMHVP
         Hyl6tg3ZgeiRVrriQHPxqCxc/FKkLoxvNZbn8w+/cu5T7YwBZyX6kSeYIAfRbyEkqFio
         U+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198505; x=1701803305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3NH9e0B7TEOaLke+IJC8tguC6phHHxMJ1QTwr176tI=;
        b=A3zWpnFUWtXo4BsmZw3VkcfkIWUtSVixnjuKNRRfFv1MkDbWRppWqRpCSB62xhOUTO
         WZnVQJ8r87M/1H7V+eFwJgbF4ucEsCjfWTe1Mr50drP1OrGOaw/wHgHKyCQhwvib6pFb
         5ueoUMshmOLASCWt4MR3xeYsOo/hak4u+Jt6f3o0GTu6ARo85hW1o4GKedKmaYJuHxr2
         vGH79d0pP6RqULMF049RpGp4FoEeVf0HVpr55pw/QOsyG6fSIpNFkgjsh0NW9DhTjnvD
         VZzy9N+tCobc888plIe6EIGnZzLWE86GNsfn8xavfbwFnjXLHjxQE+K4q+ySNy8YHWPZ
         3mSw==
X-Gm-Message-State: AOJu0YyEfC0PafDRcWjYs4q18mi7Podvu559/1nFifOdpC7Bs0PWIlk9
	vdHQ4y5okuGwyB1J9cGLGm0Ky9N7v7X/N3DCr4E=
X-Google-Smtp-Source: AGHT+IE/Jdvi1/gu2vWjA3AwPysC0qMpYuMIOc+27FVn+9ToiXT9Hto4bbVBpfdZCB9NHQwlra4B3w==
X-Received: by 2002:a05:620a:6507:b0:76d:aa3b:ac9c with SMTP id qb7-20020a05620a650700b0076daa3bac9cmr18861838qkn.46.1701198505176;
        Tue, 28 Nov 2023 11:08:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a285300b0077d897deb89sm3345508qkp.127.2023.11.28.11.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:25 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/24] pack-bitmap: simplify
 `reuse_partial_packfile_from_bitmap()` signature
Message-ID: <432854b27c6731bd6ab1fa739b3a086ec0a90be8.1701198172.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701198172.git.me@ttaylorr.com>

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
index 107154db34..2bb1b64e8f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3946,13 +3946,15 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
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
index 2ebe2c314e..614fc09a4e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1988,10 +1988,9 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 	unuse_pack(&w_curs);
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
@@ -2013,7 +2012,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				warning(_("unable to load pack: '%s', disabling pack-reuse"),
 					bitmap_git->midx->pack_names[i]);
 				free(packs);
-				return -1;
+				return;
 			}
 			if (!pack.bitmap_nr)
 				continue; /* no objects from this pack */
@@ -2046,10 +2045,10 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 
 	reuse_partial_packfile_from_bitmap_1(bitmap_git, packs, reuse);
 
-	*entries = bitmap_popcount(reuse);
-	if (!*entries) {
+	if (!bitmap_popcount(reuse)) {
+		free(packs);
 		bitmap_free(reuse);
-		return -1;
+		return;
 	}
 
 	/*
@@ -2059,7 +2058,6 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	bitmap_and_not(result, reuse);
 	*packfile_out = packs[0].p;
 	*reuse_out = reuse;
-	return 0;
 }
 
 int bitmap_walk_contains(struct bitmap_index *bitmap_git,
diff --git a/pack-bitmap.h b/pack-bitmap.h
index b7fa1a42a9..5bc1ca5b65 100644
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
2.43.0.24.g980b318f98

