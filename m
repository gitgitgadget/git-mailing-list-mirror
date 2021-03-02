Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30C4C43332
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD18664ECE
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355350AbhCCGet (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835489AbhCBTJy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 14:09:54 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AC8C061788
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 11:09:14 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id s7so11295257qkg.4
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 11:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A1LBwI7bX2fIZq79zHt/TCmp+nHYr4cd1fUGVplaolQ=;
        b=wA6fjSeUruwojIrPJTEdY36fEvP7k3lajV9HkmFoQ6c9adFkYdhOQ2/xm7JQETF6VA
         jPvxX/InTkiBEliPLDeYe+xyU2xBnZAG/IGMVty8xfyGdGW46R7puJf0/hzpl/fyuOnY
         8o/XOPn9QP1Fuihh0vhfUAfnffW2nLb6qw31bOnGHHcfaRVOWZSXZfpfsmstfGmRTTA7
         y28gKSFPYHx+XHuaSpz+DF+S4D9GlaB6iWuSTcxe2P3cvReFJzINPFJ69PTNM9rSlb6H
         BkTc2i1fkeqLCSZoHR0H9qYAQvQPVq8539Yh5WLRPXm3FJmelE9U2hP82mKOz48RtDLM
         TlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A1LBwI7bX2fIZq79zHt/TCmp+nHYr4cd1fUGVplaolQ=;
        b=uSckpugdJxQk9B5bHHNgbMqqZO3ca/fLUSjIlbyz1t4A1HGHDUk74r65jRDhyfGJpL
         uXnf++6uffGX0TxnsnTfq4t62JcdZGv/yc7Hc8LM36rdrtBGlNLNaPN2mT6dEs/i/7JX
         24BtPxr7BET5gUWAO5Sn/FtuBuLJmZlPIsqiWCqIZONk5VFJHSJIjen7y6dP/vwt2BJa
         6EeZ0iGZhc22xouy2pAXGdw98848/Fc8jpksH5qvDE/xSqdJDIdgG3/oq3NPxPGRkk/R
         +gARMw2c+9EvxxLcNOm4MqsfGIUaaOL3V/0fQEGr5Abe+Ofr4zPNn/ifhAUDs8L/RFI2
         41uA==
X-Gm-Message-State: AOAM531bFClV8xKq/o4wBpx9xFzvOkpk3TVB6ndjomjGnW5obIbMpVEi
        dYjGPmiKaTItY2dIJRXK88egHg==
X-Google-Smtp-Source: ABdhPJwmNfEoPvci5qnOweNx2H8elX/t4Sct/XwP8qSqSl+x6WVrOSz8qaqlEMwtFjw8cOM9nBNIPA==
X-Received: by 2002:ae9:f503:: with SMTP id o3mr8674237qkg.331.1614712153723;
        Tue, 02 Mar 2021 11:09:13 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1582:4add:dc39:710a])
        by smtp.gmail.com with ESMTPSA id y1sm8584008qki.9.2021.03.02.11.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 11:09:13 -0800 (PST)
Date:   Tue, 2 Mar 2021 14:09:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 08/15] midx: allow marking a pack as preferred
Message-ID: <YD6NVxDib8ccf/6Z@nand.local>
References: <223b89909416ec7c5505f9cedaa80bf86ecc7b2e.1614193703.git.me@ttaylorr.com>
 <20210302041753.4037658-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210302041753.4037658-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 01, 2021 at 08:17:53PM -0800, Jonathan Tan wrote:
> I was initially confused that "preferred" was set twice, but this makes
> sense - the first one is when an existing midx is reused, and the second
> one is for objects in packs that the midx (if it exists) does not cover.

Yep. Those two paths permeate a lot of the MIDX writer code, since it
wants to reuse work from an existing MIDX if it can find one.

> > @@ -828,7 +869,19 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> >  	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
> >  		goto cleanup;
> >
> > -	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr);
> > +	if (preferred_pack_name) {
> > +		for (i = 0; i < ctx.nr; i++) {
> > +			if (!cmp_idx_or_pack_name(preferred_pack_name,
> > +						  ctx.info[i].pack_name)) {
> > +				ctx.preferred_pack_idx = i;
> > +				break;
> > +			}
> > +		}
> > +	} else
> > +		ctx.preferred_pack_idx = -1;
>
> Looks safer to put "ctx.preferred_pack_idx = -1" before the "if", just
> in case the given pack name does not exist?

Agreed.

> > @@ -889,6 +942,31 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> >  			pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
> >  	}
> >
> > +	/*
> > +	 * Recompute the preferred_pack_idx (if applicable) according to the
> > +	 * permuted pack order.
> > +	 */
> > +	ctx.preferred_pack_idx = -1;
> > +	if (preferred_pack_name) {
> > +		ctx.preferred_pack_idx = lookup_idx_or_pack_name(ctx.info,
> > +							     ctx.nr,
> > +							     preferred_pack_name);
> > +		if (ctx.preferred_pack_idx < 0)
> > +			warning(_("unknown preferred pack: '%s'"),
> > +				preferred_pack_name);
> > +		else {
> > +			uint32_t orig = ctx.info[ctx.preferred_pack_idx].orig_pack_int_id;
> > +			uint32_t perm = ctx.pack_perm[orig];
> > +
> > +			if (perm == PACK_EXPIRED) {
> > +				warning(_("preferred pack '%s' is expired"),
> > +					preferred_pack_name);
> > +				ctx.preferred_pack_idx = -1;
> > +			} else
> > +				ctx.preferred_pack_idx = perm;
> > +		}
> > +	}
>
> I couldn't figure out why the preferred pack index needs to be
> recalculated here, since the pack entries would have already been
> sorted. Also, the tests still pass when I comment this part out. A
> comment describing what's going on would be helpful.

Funny you mention that; I was wondering the same thing myself the other
day when reading these patches again before deploying them to a couple
of testing repositories at GitHub.

It is totally unnecessary: since we have already marked objects from the
preferred pack in get_sorted_entries(), the rest of the code doesn't
care if the preferred pack was permuted or not.

But we *do* care if the pack which was preferred expired. The 'git
repack --geometric --write-midx' caller (which will appear in a later
series) should never do that, so emitting a warning() is worthwhile. I
think ultimately you want something like this squashed in:

--- >8 ---

diff --git a/midx.c b/midx.c
index d2c56c4bc6..46f55ff6cf 100644
--- a/midx.c
+++ b/midx.c
@@ -582,7 +582,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						  struct pack_info *info,
 						  uint32_t nr_packs,
 						  uint32_t *nr_objects,
-						  uint32_t preferred_pack)
+						  int preferred_pack)
 {
 	uint32_t cur_fanout, cur_pack, cur_object;
 	uint32_t alloc_fanout, alloc_objects, total_objects = 0;
@@ -869,6 +869,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
 		goto cleanup;

+	ctx.preferred_pack_idx = -1;
 	if (preferred_pack_name) {
 		for (i = 0; i < ctx.nr; i++) {
 			if (!cmp_idx_or_pack_name(preferred_pack_name,
@@ -877,8 +878,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				break;
 			}
 		}
-	} else
-		ctx.preferred_pack_idx = -1;
+	}

 	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr,
 					 ctx.preferred_pack_idx);
@@ -942,28 +942,21 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 			pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
 	}

-	/*
-	 * Recompute the preferred_pack_idx (if applicable) according to the
-	 * permuted pack order.
-	 */
-	ctx.preferred_pack_idx = -1;
+	/* Check that the preferred pack wasn't expired (if given). */
 	if (preferred_pack_name) {
-		ctx.preferred_pack_idx = lookup_idx_or_pack_name(ctx.info,
-							     ctx.nr,
-							     preferred_pack_name);
-		if (ctx.preferred_pack_idx < 0)
+		int preferred_idx = lookup_idx_or_pack_name(ctx.info,
+							    ctx.nr,
+							    preferred_pack_name);
+		if (preferred_idx < 0)
 			warning(_("unknown preferred pack: '%s'"),
 				preferred_pack_name);
 		else {
-			uint32_t orig = ctx.info[ctx.preferred_pack_idx].orig_pack_int_id;
+			uint32_t orig = ctx.info[preferred_idx].orig_pack_int_id;
 			uint32_t perm = ctx.pack_perm[orig];

-			if (perm == PACK_EXPIRED) {
+			if (perm == PACK_EXPIRED)
 				warning(_("preferred pack '%s' is expired"),
 					preferred_pack_name);
-				ctx.preferred_pack_idx = -1;
-			} else
-				ctx.preferred_pack_idx = perm;
 		}
 	}

