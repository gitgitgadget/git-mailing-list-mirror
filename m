Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFDCC0015E
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 23:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbjHOXJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 19:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbjHOXJM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 19:09:12 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A867BC
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 16:09:11 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-589bcdaa8a4so50881447b3.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692140950; x=1692745750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WU1Z60zAmQJUhkjRprKZBuVvj20xvU+mHKrcEqgf9A4=;
        b=f/HdDhG/61Qgm664rWGiqTfRX5yXPbEEA41rYLhowziV/ija19Xr75e+4peiSolt1K
         luGjjogq0T8yOFlvY0hkSTOQTBsCqrn3Z5cndpZBgdi2WXjyofU08IdZxQidKLkf9feI
         G0C8tGZonELQkRSLyDKlqqktOr5Ce6wwTMe/egs3CSYr+SvJOwgojNuPtJh4UCj3Labo
         50IClObhKICao2D4TagL/2Uogc4LsTft80lcMwsUEVQkfRVSvf/29lJAM4Lset7Ihter
         sOOEwyz2d0P3/XDYQCqfk58itbvaoDZ4pzBgTWXWlXOcV/wRWK0ZgI6whJ+4jIoSbJ2/
         X0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692140950; x=1692745750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU1Z60zAmQJUhkjRprKZBuVvj20xvU+mHKrcEqgf9A4=;
        b=fcSQKilTJwjUx1lzRV/gcPtWeIjUFxHXva4rup+BledheY1BXIXYImVaqWpngv34xL
         zzUSBhUvim/cwe2wKFdCTK3qtIipKKwYUwWGHocacvKggyWgBxN8CGz1lD2PuOlJilKj
         S2k5hcMOWHlokoq8yLRn8bkURi0gaMy9e1HSm9mlZv4FTtghwaN7Yt7jO670taMrqO77
         7CM/Xg128HijpmWjSPRLFU5QIbdjSx+1JbaWPMTVX/b4kZBnVF5NdC01Bki08vQgPHsQ
         v0sOLxGF9GjpIjYTT4ZIklJ6dVlgUscCvKvE9lzr3DcxLktV43VkvJ8GBanQMhUeChMK
         vymQ==
X-Gm-Message-State: AOJu0YwZzMdSHuq5qZBfJ3v+4Aau5ESm+baXScZgvq1epSepJCTrE4Qy
        Xk8kq8CaJlqQ3PWGT6e42L9yhw==
X-Google-Smtp-Source: AGHT+IGWKpH5yLppmhB8Bg7dgHsF4Tw5okzzTe30/8PHNXgAq7AkCxPtVVBGZwsEiRZrDIcpBMAu1Q==
X-Received: by 2002:a81:a012:0:b0:578:1937:868b with SMTP id x18-20020a81a012000000b005781937868bmr48254ywg.11.1692140950271;
        Tue, 15 Aug 2023 16:09:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c7-20020a814e07000000b005843155e284sm3700136ywb.49.2023.08.15.16.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:09:09 -0700 (PDT)
Date:   Tue, 15 Aug 2023 19:09:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/8] Repack objects into separate packfiles based on a
 filter
Message-ID: <ZNwFlcS3SOS9h77N@nand.local>
References: <20230808082608.582319-1-christian.couder@gmail.com>
 <20230812000011.1227371-1-christian.couder@gmail.com>
 <xmqqv8dhjfgm.fsf@gitster.g>
 <ZNvxg7BVJ+C5XFY4@nand.local>
 <xmqqjztwgcnc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjztwgcnc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2023 at 03:32:23PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I think the reason that this succeeds is that we already have a bitmap,
> > and it likely reuses all of the existing bitmaps before discovering that
> > the pack we wrote doesn't contain all objects.
>
> Now I am confused.
>
> We were asked to write bitmap index when we are going to create an
> incomplete pack, and the packfile we generate with the filter will
> not have full set of objects, and generating a bitmap with such an
> incomplete knowledge of what objects are reachable from what would
> be a disaster, so we should turn it off.  But the posted patch
> lacked such a "we should abort when bitmap is asked to be written
> while filtering" logic.

I was similarly confused, and started writing a patch to detect when we
see objects in one bitmap but not the other when remapping. But we
already handle that case, see the call to `rebuild_bitmap()` from
`fill_bitmap_commit()` in pack-bitmap-write.c.

So I don't think we'd ever end up reusing an existing bitmap that refers
to objects that we don't have.

But something is definitely strange here. The bitmap generated by this
test claims to have three commits:

    $ ~/src/git/t/helper/test-tool bitmap list-commits
    95a9e53327b06212dcf98bd44794b0e2b913deab
    3677360288c631b6b2e1f0e1f081b1e518605e9f
    6f105e6234717c52e9b117b08840926910a68314

...but none of them actually appear to exist in the bitmap:

    $ git rev-list --test-bitmap 95a9e53327b06212dcf98bd44794b0e2b913deab
    Bitmap v1 test (3 entries loaded)
    Found bitmap for '95a9e53327b06212dcf98bd44794b0e2b913deab'. 64 bits / 8b3b6ee7 checksum
    fatal: object not in bitmap: 'ac3e272b72bbf89def8657766b855d0656630ed4'

I think what's going on here is that we attempt to create bitmaps for
all three of those commits. We then try and reuse the existing bitmaps,
but fail, because we are missing some objects.

So then we try and generate the bitmap from scratch, and when we get
down to fill_bitmap_tree() we look up the bit position of the tree
itself, and find a non-zero answer, indicating that we have already
marked that tree.

And fill_bitmap_tree() correctly assumes that if we have marked the bit
corresponding to the tree, that everything reachable from that tree has
also been marked. So we never try and locate the bit position for the
blob, since we already think that we have a blob marked in the resulting
bitmap!

But why is that tree marked in the first place? It's because we attempt
to rebuild the bitmap from the existing .bitmap file, but fail part of
the way through (when we look up the first blob object in the reposition
table). But that happens *after* we see the tree object, so its bit
position is marked, even though we didn't rebuild a complete bitmap.

I don't think this matters outside of filtered repacks, but it would be
a serious bug to not catch this earlier up like suggested in the
(quoted) patch below.

> > but I wonder if a more complete fix would be something like:
> > ...
> > @@ -966,6 +972,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >  	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
> >  		die(_(incremental_bitmap_conflict_error));
> >
> > +	if (write_bitmaps && po_args.filter_options.choice)
> > +		die(_(filtered_bitmap_conflict_error));
> > +
>
> It sounds like the most direct fix.

I agree.

I think that we would be OK to not change the implementation of
rebuild_bitmap(), or its caller in fill_bitmap_commit(), since this only
bites us when bitmapping a filtered pack, and we should catch that case
well before getting this deep into the bitmap code.

But it does seem suspect that we rebuild right into ent->bitmap, so we
may want to consider doing something like:

--- >8 ---
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index f6757c3cbf..f4ecdf8b0e 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -413,15 +413,19 @@ static int fill_bitmap_commit(struct bb_commit *ent,

 		if (old_bitmap && mapping) {
 			struct ewah_bitmap *old = bitmap_for_commit(old_bitmap, c);
+			struct bitmap *remapped = bitmap_new();
 			/*
 			 * If this commit has an old bitmap, then translate that
 			 * bitmap and add its bits to this one. No need to walk
 			 * parents or the tree for this commit.
 			 */
-			if (old && !rebuild_bitmap(mapping, old, ent->bitmap)) {
+			if (old && !rebuild_bitmap(mapping, old, remapped)) {
+				bitmap_or(ent->bitmap, remapped);
+				bitmap_free(remapped);
 				reused_bitmaps_nr++;
 				continue;
 			}
+			bitmap_free(remapped);
 		}

 		/*
--- 8< ---

on top.

Applying that patch and then rerunning the tests with the appropriate
TEST variables causes the 'git repack' to fail as expected, ensuring
that the containing test passes.

Thanks,
Taylor
