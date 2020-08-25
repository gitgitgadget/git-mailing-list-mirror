Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F90C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10972076C
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mP1Vkl5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHYRef (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgHYRe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 13:34:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EB5C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 10:34:27 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t23so9581413qto.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7UvCSY1ZDaI0DkA6xYlmABmuMICOvK6bGq10tdU3Pio=;
        b=mP1Vkl5x4S1eGCZVWb9AWo09h0h+lxOOJaF9QQb6XeavBclPHbgn2+9OqGa58xkDp3
         v8IoTzrq92pcQzpHLWDmYVLH3Wwn6unYzHXghVNAetF/uG0G9V5yF4d/GfRKqGGNzb8m
         MI4JdZDryxozAIRjR7NPOGCdsg/fBiYlW+fEj7IUDnNXxjqampLs4UtSjOlVrirbI9wO
         1ofC4pmFqUPDkJvqbPVO6amnjMsOWf8aKAMe75e7ZmdUpLxiSZkqWK1sLDUhJTu/1Dx8
         RDPfybbXpjKU+NGUnvhCYpUOlJKChlo8CmvY55KWrdU3nQFcdLsq2vZ0nznL1j9QH8IK
         m+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7UvCSY1ZDaI0DkA6xYlmABmuMICOvK6bGq10tdU3Pio=;
        b=baWITBYzpK2x/GE812UVx8dSKdqzR9fEzD6/pHorhHMzMZgGRQ7fSL0xMDO+cJa/xu
         zMW3ID8I7iqAMLiz3wOrJw0kKapeOrwMl+Y0uLIvPms2ymIME+SZHdpJCgH6MK9wI0kU
         Bgqwj7SMPqvRgFc/eqjYebTd1j/JY58eNJt7xMeQI+Ye8AqXJWxfBrjCxcKMKSk+LdxK
         Zy51cbC6DzDaymcATTTx6CbwHounADWhjo/04g8iRTpxZSJ1RQAtaasQTFoeRM7REn5l
         FNh9Q6EjaKJ1Vrbjla2PAea3514WZWCiSfSWbXa0+EhF7uQ/CoKSwTiupZBDRWcgLKG+
         LnoQ==
X-Gm-Message-State: AOAM533jWIhhOfjrHbUs4Id+JliY7TCNjyVJqt3sbk6iJYORCWBhOZlQ
        EP3y2S4GPoZWVw/1xtlE26Pbaw==
X-Google-Smtp-Source: ABdhPJwi3HT02mLecQnMTfAKz1SYpHZfKwcK02yWFYNtiw1o/OnFrRDu3Q7BUV3858y2y3zm770icA==
X-Received: by 2002:ac8:4c8e:: with SMTP id j14mr9736323qtv.330.1598376866868;
        Tue, 25 Aug 2020 10:34:26 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1558:8dc0:5209:36ba])
        by smtp.gmail.com with ESMTPSA id b2sm13612889qto.82.2020.08.25.10.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:34:26 -0700 (PDT)
Date:   Tue, 25 Aug 2020 13:34:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        git <git@vger.kernel.org>, dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825173425.GA16844@syl.lan>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <CB6B70D3-5FC6-43FE-8460-33F6CFC123E6@gmail.com>
 <20200825144515.GB7671@syl.lan>
 <20200825164721.GA1414394@coredump.intra.peff.net>
 <45921233-ac6c-05f2-e108-0ab2aeb56104@gmail.com>
 <20200825172901.GD1414394@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825172901.GD1414394@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 01:29:01PM -0400, Jeff King wrote:
> On Tue, Aug 25, 2020 at 01:10:13PM -0400, Derrick Stolee wrote:
>
> > > If we do care, though, that implies some cooperation between the
> > > deletion process and the midx code. Perhaps it even argues that repack
> > > should refuse to delete such a single pack at all, since it _isn't_
> > > redundant. It's part of a midx, and the caller should rewrite the midx
> > > first itself, and _then_ look for redundant packs.
> >
> > It is worth noting that we _do_ have a way to integrate the delete and
> > write code using 'git multi-pack-index expire'. One way to resolve this
> > atomicity would be to do the following inside the repack command:
> >
> >  1. Create and index the new pack.
> >  2. git multi-pack-index write
> >  3. git multi-pack-index expire
>
> Given that discussion elsewhere points to git-repack only really
> deleting packs in all-in-one mode (and not ever a single pack), it seems
> like we can really be much simpler here. If we're not deleting packs via
> all-in-one, there's no need to touch the midx at all. If we are, then
> it's reasonable to delete the midx immediately (after having written our
> new pack but before deleting) since our new single pack idx is as good
> or better.
>
> I.e., drop step 2 above, and make step 3 just clear_midx_file(). Which
> is roughly what the code does now, isn't it? Or is there some reason
> that "expire" is more interesting than just clearing?

It's not clear to me whether you're talking about my patch, or what a
more full integration with 'git repack' looks like.

If you are talking about my patch, I disagree: checking that the MIDX
doesn't know about a pack we're dropping *is* useful even without
all-in-one, because of '.keep' packs (as demonstrated by the new test in
my patch).

To me, this patch seems like an incremental step in the direction that
we ultimately want to be going, but it's hard to untangle whether the
ensuing discussion is targeted at my patch, or the ultimate goal.

> And if anybody does want to drop single packs, etc, they can do so by
> generating a sensible midx separately from the repack operation (and
> probably doing so before dropping the packs for atomicity).
>
> -Peff

Thanks,
Taylor
