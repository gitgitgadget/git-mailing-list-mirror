Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A073C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 18:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjEESns (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjEESnq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 14:43:46 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE9B3C10
        for <git@vger.kernel.org>; Fri,  5 May 2023 11:43:44 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so15537519276.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683312224; x=1685904224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3wt0+a2XUk8beb9zE87xPZwf1h93D7uRhlTVygM/N24=;
        b=zUq1sIoGwgDQ8Gc5lPXIo9IGW+RM8fBgKjKom/f/nTcCpJblVCvaan0+r52Js9sNBC
         hyoYYKxDJoh0rl1VQ3mfskJVIYnWMv3BDXBRAKY1XvcuYUjAhs6TmMa8wMeVX+Kfhv8v
         e/+DYmyp6AFhmehw+7qBlv2m7YxORkL7zuuD2HcQ72SauNMIdX0qdhts9KeauZcBR3Sx
         R0n1ukb2b/Q4/2tLGC0wLL9XqrtXioVmnIDnsYLJT/R+Os9Iu1v4Gl/mc0y0YKtAmZxC
         eKx8I/7KgwD7Yts6clqXnmsWgbOWLkiomU7Yprt02Ue4gFf8f0Ub2UxMolHSnjruzqJe
         ostQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312224; x=1685904224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wt0+a2XUk8beb9zE87xPZwf1h93D7uRhlTVygM/N24=;
        b=Zjm/1Ch8Tz0i1o8zyd4i6whVSVwdlD/kVlXrlQzJqYzsmDLAWj7bgB8eilUPMI00QD
         QKdTy3WNSzB/aErooYSraH+gD0IniuMpaxevUrd6EIcrxbR+6svpusjbRPOzfKtKHOdi
         keGPOziCUXuFl802YYN3df6IDTTv3YeUec6KRFwcFph3M/T2VfPz+QjEH5ngSRbDd2Va
         D2Qv5BYKGYY/nMAyyGjNMxX5Pith3nKPjyL61qx94/PFdTxdfFqiaj9JV3lHiCEXGuwS
         gkU0ow4xrw/BFxA5jf1pKMyg0MFS7wq5ZW4nC7Xar2I7SU1vgJgyZ1QKGbgSevxzr0dw
         HlIA==
X-Gm-Message-State: AC+VfDycqzjq6L90MKi04dGcTFLmgjI14UHTigF0mSR9faENF3YkQpbU
        12+2EwPiUTg0UsehyF2F67sEUQ==
X-Google-Smtp-Source: ACHHUZ6nl6SMHldRB+rwQYiDJYdO7MT52hG9wA+ASV0r95vVfbYqiqz/I/hFZa2MTrO7+A4t24AXcw==
X-Received: by 2002:a0d:dbcf:0:b0:55a:88f4:be96 with SMTP id d198-20020a0ddbcf000000b0055a88f4be96mr2682277ywe.7.1683312222594;
        Fri, 05 May 2023 11:43:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l186-20020a0dc9c3000000b0055d8768408dsm619158ywd.105.2023.05.05.11.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 11:43:42 -0700 (PDT)
Date:   Fri, 5 May 2023 14:43:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] pack-bitmap.c: use commit boundary during bitmap
 traversal
Message-ID: <ZFVOXc6qvVWsI/2C@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683307620.git.me@ttaylorr.com>
 <1993af00cba3af83755da557816c1c7a8b52c844.1683307620.git.me@ttaylorr.com>
 <e6e2401a-519a-4859-d20b-6b947e94e1ec@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6e2401a-519a-4859-d20b-6b947e94e1ec@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2023 at 02:13:45PM -0400, Derrick Stolee wrote:
> On 5/5/2023 1:27 PM, Taylor Blau wrote:
>
> > +static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
> > +					    struct rev_info *revs,
> > +					    struct object_list *roots)
> > +{
> > +	struct bitmap_boundary_cb cb = { .bitmap_git = bitmap_git };
> > +	unsigned int i;
> > +	unsigned int tmp_blobs, tmp_trees, tmp_tags;
> > +	int any_missing = 0;
> > +
> > +	revs->ignore_missing_links = 1;
> > +
> > +	/*
> > +	 * OR in any existing reachability bitmaps among `roots` into `base`.
> > +	 */
> > +	while (roots) {
> > +		struct object *object = roots->item;
> > +		roots = roots->next;
> > +
> > +		if (object->type == OBJ_COMMIT &&
> > +		    !obj_in_bitmap(bitmap_git, object, cb.base) &&
> > +		    add_commit_to_bitmap(bitmap_git, &cb.base,
> > +					 (struct commit *)object)) {
> > +			object->flags |= SEEN;
> > +			continue;
> > +		}
> > +
> > +		any_missing = 1;
> > +	}
> > +
> > +	if (!any_missing)
> > +		goto cleanup;
>
> Here, we check if the list of roots are completely covered by existing
> bitmaps. This prevents doing the commit-only walk as well as the boundary
> checks.
>
> There's another confusing bit here: if we have a bitmap for the commit,
> then we mark it as SEEN. Does that mean that the later commit walk will
> skip walking its history? Would we then get a boundary that is actually
> further in history than necessary? ("A --not B C" would walk all of
> B..A if C has a bitmap, even if a lot of that region is reachable from C.)
>
> My initial thought here was that this is an unlikely case, so the
> optimization isn't worth the code complexity. But now, I'm a little
> concerned that it actually hurts the later walk in the case of multiple
> roots.

The point about commits with existing bitmaps as SEEN hurting the
boundary traversal is a good one that I hadn't considered. I agree with
what you're saying here, though I think that the optimization still
makes sense (without touching the SEEN bit).

If all of the haves have existing bitmaps, we don't want to bother
starting the boundary traversal at all, since we can just OR those
together and be done. So I think we'd just want to drop the SEEN bits
there, but let me know if I am missing something.

> > +	revs->boundary = 0;
> > +	revs->blob_objects = tmp_blobs;
> > +	revs->tree_objects = tmp_trees;
> > +	revs->tag_objects = tmp_tags;
>
> These would seem more natural if they were after the trace2_region_leave().

Good suggestion, thanks.

> > +			} else {
> > +				add_pending_object(revs, obj, "");
> > +				needs_walk = 1;
> > +			}
> > +		}
> > +
> > +		if (needs_walk)
> > +			cb.base = fill_in_bitmap(bitmap_git, revs, cb.base, NULL);
>
> I wonder if fill_in_bitmap() already does "the right thing" when there
> are no pending objects or when all pending objects are already in the
> bitmap. Do we need to do these checks, or should we just put all boundary
> commits in the pending set?

Great suggestion. It does do the right thing via its `should_include`
checks, which see if the commit we're trying to process is already in
the bitmap, and if so, propagates SEEN to it and its parents.

Here's a diff that I generated after reading through this message, let
me know if you think I'm missing anything:

--- >8 ---
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 634fc10156..f57b74bcc0 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1141,7 +1141,6 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 		    !obj_in_bitmap(bitmap_git, object, cb.base) &&
 		    add_commit_to_bitmap(bitmap_git, &cb.base,
 					 (struct commit *)object)) {
-			object->flags |= SEEN;
 			continue;
 		}

@@ -1175,13 +1174,14 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 				      show_boundary_object,
 				      &cb, NULL);
 	revs->boundary = 0;
+	trace2_region_leave("pack-bitmap", "boundary-traverse", the_repository);
+
 	revs->blob_objects = tmp_blobs;
 	revs->tree_objects = tmp_trees;
 	revs->tag_objects = tmp_tags;

 	reset_revision_walk();
 	clear_object_flags(UNINTERESTING);
-	trace2_region_leave("pack-bitmap", "boundary-traverse", the_repository);

 	/*
 	 * Then add the boundary commit(s) as fill-in traversal tips.
@@ -1189,26 +1189,21 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	trace2_region_enter("pack-bitmap", "boundary-fill-in", the_repository);
 	if (cb.boundary.nr) {
 		struct object *obj;
-		int needs_walk = 0;
-
 		for (i = 0; i < cb.boundary.nr; i++) {
 			obj = cb.boundary.objects[i].item;

-			if (obj_in_bitmap(bitmap_git, obj, cb.base)) {
+			if (obj_in_bitmap(bitmap_git, obj, cb.base))
 				obj->flags |= SEEN;
-			} else {
+			else
 				add_pending_object(revs, obj, "");
-				needs_walk = 1;
-			}
 		}

-		if (needs_walk)
-			cb.base = fill_in_bitmap(bitmap_git, revs, cb.base, NULL);
+		cb.base = fill_in_bitmap(bitmap_git, revs, cb.base, NULL);
 	}
 	trace2_region_leave("pack-bitmap", "boundary-fill-in", the_repository);

-
 cleanup:
+	object_array_clear(&cb.boundary);
 	revs->ignore_missing_links = 0;

 	return cb.base;
--- 8< ---

Thanks,
Taylor
