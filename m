Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0313204F78
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968820; cv=none; b=Cmn1lifo8c7DnlJeBHm+dSjIHXDjhPyjOzibWtXJVNtydTdRnzUIXmzhAhHUGiawBqb6OoN2aeyD+J2WPcQMIS+8IKoak2VB3UotaUZ5DfRSC7Vl7+Efu9u+uciuw81i7P2GN8yqPvCBolz93rfKemraJQJ+Kx7pPkNybRk4QxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968820; c=relaxed/simple;
	bh=WXOde81U/8prSzqCNz7cMZ1/pChu3COvR5zUu8/fT4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnuJ56x1eFz6BfegQs7xB0xo2gqvEZZNzeE0lUI0PsC4Hs2H+WWaxDNJMciYapSFReGTrlCPufVCBnuk2JA/de/MxILdkZA5HiIxP5M0HsNhEKdn8JuNCOQYr35VGNbVcEQ4dzRfWI3YbOEtwxAG/fT0KyiR7H6/knwvP6BsMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y+A6ijl0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y+A6ijl0"
Received: (qmail 16316 invoked by uid 109); 18 Apr 2025 09:33:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WXOde81U/8prSzqCNz7cMZ1/pChu3COvR5zUu8/fT4o=; b=Y+A6ijl0dGlJE4MsCfII2+uEYk+DcLd13vWNp1oUmy2NdOSsHTUAtpgAMCfJx4/GJLPcL3vCELKQOFSoymZ4QOANke61zgYqThyWowoGF6VeflTbXuzknsnXXLm6tcbFdCJM4QnwUaq8uyS3aukfKINCR0xVdolQDCAlOPUOC6k5hqQyD1qs7LSFK+tlcttA77QrBHKph5t8mfCjfoQHnXWqyS9HjOlfkrUZEgSPst5I2u0sB7htqux6rKbxWOgqbhzr8yspwxhEwPbaicRcjLOMFSX3gTXbxwxwuXC21bTU6G3dGUzja2ScANqYJRgc4ha+7iUg6JIQ83722tBYSQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Apr 2025 09:33:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31195 invoked by uid 111); 18 Apr 2025 09:33:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Apr 2025 05:33:41 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Apr 2025 05:33:35 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/4] pack-bitmap: write lookup table extension by default
Message-ID: <20250418093335.GB10441@coredump.intra.peff.net>
References: <cover.1744924321.git.me@ttaylorr.com>
 <b7cfb1267fdd7f50f414c9f79377cb338a0c1ab0.1744924321.git.me@ttaylorr.com>
 <xmqqmscee97z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmscee97z.fsf@gitster.g>

On Thu, Apr 17, 2025 at 03:04:00PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> > index 2a938466f5..6ad6f814e3 100644
> > --- a/builtin/multi-pack-index.c
> > +++ b/builtin/multi-pack-index.c
> > @@ -142,6 +142,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
> >  	int ret;
> >  
> >  	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
> > +	opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;
> >  
> >  	git_config(git_multi_pack_index_write_config, NULL);
> >  
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 3973267e9e..384fefbb1d 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -239,7 +239,7 @@ static enum {
> >  	WRITE_BITMAP_QUIET,
> >  	WRITE_BITMAP_TRUE,
> >  } write_bitmap_index;
> > -static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
> > +static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE | BITMAP_OPT_LOOKUP_TABLE;
> 
> Are these two hunks required to be kept in sync?

They're not technically required to be in sync. It is OK for the midx
bitmaps to have different options than the ones we make for packs. And
in theory they could intentionally diverge, though in practice I don't
think we (yet) have any extensions or options that would be more
appropriate for one or the other.

So if we did want to join them, I think it would make sense to still be
able to use different flags for each situation, but initialize them from
a common definition.

> If so, I am wondering what is the right approach to make sure they
> are.  The definition of MIDX_WRITE_BITMAP_* flag bits in midx.h and
> BITMAP_OPT_* flag bits in write_bitmap_index enum are distinct two
> sets, and we need a way to somehow convert between them back and
> forth if we really wanted to ensure that these "default" values are
> kept in sync automatically.

Yeah, I think that would be much simpler if the bitmap options were held
separately from the other midx flags, and then we could use the same
values for each (and a common "defaults" definition). Which is
conceptually simple, but means we have to plumb a separate variable
through a bunch of intermediate functions. See the (untested) patch
below.

I dunno if it's worth it for something that doesn't really change all
that often. OTOH, it does remove the extra layer of translation in
write_midx_bitmap().

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 2a938466f5..fb073a946a 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -10,6 +10,7 @@
 #include "object-store-ll.h"
 #include "replace-object.h"
 #include "repository.h"
+#include "pack-bitmap.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]" \
@@ -54,6 +55,7 @@ static struct opts_multi_pack_index {
 	char *refs_snapshot;
 	unsigned long batch_size;
 	unsigned flags;
+	uint16_t bitmap_options;
 	int stdin_packs;
 } opts;
 
@@ -89,16 +91,16 @@ static int git_multi_pack_index_write_config(const char *var, const char *value,
 {
 	if (!strcmp(var, "pack.writebitmaphashcache")) {
 		if (git_config_bool(var, value))
-			opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
+			opts.bitmap_options |= BITMAP_OPT_HASH_CACHE;
 		else
-			opts.flags &= ~MIDX_WRITE_BITMAP_HASH_CACHE;
+			opts.bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
 
 	if (!strcmp(var, "pack.writebitmaplookuptable")) {
 		if (git_config_bool(var, value))
-			opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;
+			opts.bitmap_options |= BITMAP_OPT_LOOKUP_TABLE;
 		else
-			opts.flags &= ~MIDX_WRITE_BITMAP_LOOKUP_TABLE;
+			opts.bitmap_options &= ~BITMAP_OPT_LOOKUP_TABLE;
 	}
 
 	/*
@@ -141,7 +143,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	};
 	int ret;
 
-	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
+	opts.bitmap_options |= BITMAP_OPT_HASH_CACHE;
 
 	git_config(git_multi_pack_index_write_config, NULL);
 
@@ -167,7 +169,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 		ret = write_midx_file_only(repo, opts.object_dir, &packs,
 					   opts.preferred_pack,
-					   opts.refs_snapshot, opts.flags);
+					   opts.refs_snapshot, opts.flags,
+					   opts.bitmap_options);
 
 		string_list_clear(&packs, 0);
 		free(opts.refs_snapshot);
@@ -177,7 +180,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	}
 
 	ret = write_midx_file(repo, opts.object_dir, opts.preferred_pack,
-			      opts.refs_snapshot, opts.flags);
+			      opts.refs_snapshot, opts.flags,
+			      opts.bitmap_options);
 
 	free(opts.refs_snapshot);
 	return ret;
@@ -236,7 +240,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 
 	FREE_AND_NULL(options);
 
-	return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
+	return expire_midx_packs(the_repository, opts.object_dir, opts.flags,
+				 opts.bitmap_options);
 }
 
 static int cmd_multi_pack_index_repack(int argc, const char **argv,
@@ -269,7 +274,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 	FREE_AND_NULL(options);
 
 	return midx_repack(the_repository, opts.object_dir,
-			   (size_t)opts.batch_size, opts.flags);
+			   (size_t)opts.batch_size, opts.flags,
+			   opts.bitmap_options);
 }
 
 int cmd_multi_pack_index(int argc,
diff --git a/builtin/repack.c b/builtin/repack.c
index f3330ade7b..69c9a8bc4c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1562,7 +1562,7 @@ int cmd_repack(int argc,
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
 		write_midx_file(the_repository, repo_get_object_directory(the_repository),
-				NULL, NULL, flags);
+				NULL, NULL, flags, 0);
 	}
 
 cleanup:
diff --git a/midx-write.c b/midx-write.c
index 48a4dc5e94..5729b989cb 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -841,10 +841,10 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 			     struct packing_data *pdata,
 			     struct commit **commits,
 			     uint32_t commits_nr,
-			     unsigned flags)
+			     unsigned flags,
+			     uint16_t options)
 {
 	int ret, i;
-	uint16_t options = 0;
 	struct bitmap_writer writer;
 	struct pack_idx_entry **index;
 	struct strbuf bitmap_name = STRBUF_INIT;
@@ -859,12 +859,6 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 		get_midx_filename_ext(ctx->repo->hash_algo, &bitmap_name,
 				      object_dir, midx_hash, MIDX_EXT_BITMAP);
 
-	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
-		options |= BITMAP_OPT_HASH_CACHE;
-
-	if (flags & MIDX_WRITE_BITMAP_LOOKUP_TABLE)
-		options |= BITMAP_OPT_LOOKUP_TABLE;
-
 	/*
 	 * Build the MIDX-order index based on pdata.objects (which is already
 	 * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
@@ -1070,7 +1064,8 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
 			       const char *refs_snapshot,
-			       unsigned flags)
+			       unsigned flags,
+			       uint16_t bitmap_options)
 {
 	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
@@ -1433,7 +1428,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 		if (write_midx_bitmap(&ctx, object_dir,
 				      midx_hash, &pdata, commits, commits_nr,
-				      flags) < 0) {
+				      flags, bitmap_options) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			result = 1;
 			clear_packing_data(&pdata);
@@ -1529,23 +1524,27 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 int write_midx_file(struct repository *r, const char *object_dir,
 		    const char *preferred_pack_name,
-		    const char *refs_snapshot, unsigned flags)
+		    const char *refs_snapshot, unsigned flags,
+		    uint16_t bitmap_options)
 {
 	return write_midx_internal(r, object_dir, NULL, NULL,
 				   preferred_pack_name, refs_snapshot,
-				   flags);
+				   flags, bitmap_options);
 }
 
 int write_midx_file_only(struct repository *r, const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot, unsigned flags)
+			 const char *refs_snapshot, unsigned flags,
+			 uint16_t bitmap_options)
 {
 	return write_midx_internal(r, object_dir, packs_to_include, NULL,
-				   preferred_pack_name, refs_snapshot, flags);
+				   preferred_pack_name, refs_snapshot, flags,
+				   bitmap_options);
 }
 
-int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
+int expire_midx_packs(struct repository *r, const char *object_dir,
+		      unsigned flags, uint16_t bitmap_options)
 {
 	uint32_t i, *count, result = 0;
 	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
@@ -1603,7 +1602,8 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 
 	if (packs_to_drop.nr)
 		result = write_midx_internal(r, object_dir, NULL,
-					     &packs_to_drop, NULL, NULL, flags);
+					     &packs_to_drop, NULL, NULL, flags,
+					     bitmap_options);
 
 	string_list_clear(&packs_to_drop, 0);
 
@@ -1718,7 +1718,8 @@ static void fill_included_packs_batch(struct repository *r,
 	free(pack_info);
 }
 
-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
+		unsigned flags, uint16_t bitmap_options)
 {
 	int result = 0;
 	uint32_t i, packs_to_repack = 0;
@@ -1801,7 +1802,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	}
 
 	result = write_midx_internal(r, object_dir, NULL, NULL, NULL, NULL,
-				     flags);
+				     flags, bitmap_options);
 
 cleanup:
 	free(include_pack);
diff --git a/midx.h b/midx.h
index 9d1374cbd5..5a79302a7a 100644
--- a/midx.h
+++ b/midx.h
@@ -81,8 +81,6 @@ struct multi_pack_index {
 #define MIDX_PROGRESS     (1 << 0)
 #define MIDX_WRITE_REV_INDEX (1 << 1)
 #define MIDX_WRITE_BITMAP (1 << 2)
-#define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
-#define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
 #define MIDX_WRITE_INCREMENTAL (1 << 5)
 
 #define MIDX_EXT_REV "rev"
@@ -131,15 +129,16 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
  */
 int write_midx_file(struct repository *r, const char *object_dir,
 		    const char *preferred_pack_name, const char *refs_snapshot,
-		    unsigned flags);
+		    unsigned flags, uint16_t bitmap_options);
 int write_midx_file_only(struct repository *r, const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot, unsigned flags);
+			 const char *refs_snapshot, unsigned flags,
+			 uint16_t bitmap_options);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
-int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);
-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags);
+int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags, uint16_t bitmap_options);
+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags, uint16_t bitmap_options);
 
 void close_midx(struct multi_pack_index *m);
 
