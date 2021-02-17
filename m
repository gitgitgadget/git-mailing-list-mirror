Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9369C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B7464E62
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhBQTYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhBQTYL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:24:11 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC1C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:23:30 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id g24so7891151qts.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eL7yebiNmiY08sQjwGjSpDhhAgZh3tyxyb32ZUPbTUs=;
        b=wwmVzxQyEYFxx+Xx0oxrBA2i2aOai3dLlQWTPUU8WKUU9Ls9wwFW4CUOup1N4fDdnp
         pGV3NJdCmnQjlgcgOo6sv6/6kDeMdVCLmgkjlAa47ac/Bv4Fd6Ing3nPZmPxq5dERxWj
         AoukA0YJ4GyDo7b2MGsSneEEtcPem0EbB6nMA8ILUJvpW+xV1kEgCGF3TpqdBtCFUaD4
         z4m8HUIxMuI6jcZ7lFeu4I6o2wXJyXUZx7i3tZ65me3u7iwW5eZFGCS/OKwqOUfyl68x
         M/0n+cYqygENq/krmmViybR705CutrBeOo+mdZSW2s6G1c81awzijmmxc76sa48IQxgN
         UChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eL7yebiNmiY08sQjwGjSpDhhAgZh3tyxyb32ZUPbTUs=;
        b=fMXvNgmFPS83U8OBD4OAO/uk4S4gK+6rcZazKv9mWGD8yQaGRELk2YQz1pDU/WXytn
         dtYCr08Y2bc7R8eA177TuQhi5JBmbKNUg1mrHZ+6zi77Tpq0OzHAuhUGOy8F2V5II/hx
         UDc2NB1At56raX5+kmjqaKo4ekMdFC3Oj4MHSbtf3ofFf40bkb1x2lY8CTzcbuIVs2Oa
         ChUKrS/smPinW9BmaPmdFF1Z4ifKMRJwzC2fH2cuJ8YmGfVDgOkuGgqXe9Z2X0gbCSs/
         aqrJuJ40vgSTDIKchOu3EmhSdsls+AOmgtIMC5AzNTMaA532a2tDyrBY4JvLiYYwJTQ3
         1fIQ==
X-Gm-Message-State: AOAM530lyh0qY5ppMzMEyk2Z66tJhB33emFCEse3BiU6jnv9ihUSVCUc
        94k0vk5kfXRLAdHwkuNLxBFo3w==
X-Google-Smtp-Source: ABdhPJzQUu9hI5R/sfb0j96HTQZkOYlXwxVtAZVYxHoBkTpe14IvN/qbhCKLSctiqRNk7ion0k1HNQ==
X-Received: by 2002:ac8:d03:: with SMTP id q3mr786151qti.19.1613589809902;
        Wed, 17 Feb 2021 11:23:29 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:aeda:db8b:7233:8f54])
        by smtp.gmail.com with ESMTPSA id a186sm2379221qkd.63.2021.02.17.11.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:23:29 -0800 (PST)
Date:   Wed, 17 Feb 2021 14:23:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 6/8] builtin/pack-objects.c: rewrite honor-pack-keep
 logic
Message-ID: <YC1tLzivHqnoV6U7@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <c3868c7df92484f0527ce500ad1156275be334e8.1612411124.git.me@ttaylorr.com>
 <YC0+wlRksoqm0xLO@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC0+wlRksoqm0xLO@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 11:05:22AM -0500, Jeff King wrote:
> I think just bumping that:
>
>   if (local && !p->pack_local)
> 	return 0;

> above the new code would fix it. Or to lay out the logic more fully, the
> order of checks should be:

>   - does _this_ pack we found the object in disqualify it. If so, we can
>     cheaply return 0. And that applies to both keep and local rules.
>
>   - otherwise, check all packs via has_object_kept_pack(), which is
>     cheaper than continuing to iterate through all packs by returning
>     -1.
>
>   - once we know definitively about keep-packs, then check any shortcuts
>     related to local packs (like !have_non_local_packs)
>
>   - and then if no shortcuts, we return -1

I don't understand what you're suggesting. Is the (local &&
!p->pack_local) a disqualifying condition? Reading the comment, I think
it is, and so we could do something like:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 36c2fa3aff..be3ba60bc2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1205,14 +1205,21 @@ static int want_found_object(const struct object_id *oid, int exclude,
         * make sure no copy of this object appears in _any_ pack that makes us
         * to omit the object, so we need to check all the packs.
         *
-        * We can however first check whether these options can possible matter;
+        * We can however first check whether these options can possibly matter;
         * if they do not matter we know we want the object in generated pack.
         * Otherwise, we signal "-1" at the end to tell the caller that we do
         * not know either way, and it needs to check more packs.
         */

        /*
-        * Handle .keep first, as we have a fast(er) path there.
+        * Objects in packs borrowed from elsewhere are discarded regardless of
+        * if they appear in other packs that weren't borrowed.
+        */
+       if (local && !p->pack_local)
+               return 0;
+
+       /*
+        * Then handle .keep first, as we have a fast(er) path there.
         */
        if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core) {
                /*
@@ -1242,11 +1249,8 @@ static int want_found_object(const struct object_id *oid, int exclude,
         * keep-packs, or the object is not in one. Keep checking other
         * conditions...
         */
-
        if (!local || !have_non_local_packs)
                return 1;
-       if (local && !p->pack_local)
-               return 0;

        /* we don't know yet; keep looking for more packs */
        return -1;

But your "check any shortcuts related to local packs" makes me think
that we should leave the code as-is.

Which are you suggesting?

Thanks,
Taylor
