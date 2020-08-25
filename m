Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35642C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 02:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28DD20706
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 02:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="w8Lsn3Ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgHYChP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYChO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 22:37:14 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065CDC061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 19:37:14 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 6so8021788qtt.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 19:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4XsSMzweC2hce3gBZFupK62xUvqVZpQs6NijFrSeMbg=;
        b=w8Lsn3JuEBurFskBvMdG8PEv3vT6lHr83mUoIfDyWcHd50yxDtBBn/mEGWrn4SQBAo
         sLRdD1ZYBw0PbEe1u5z8wCO8uI00fpTmyiy98kgVUZ1EwQfzE0M7LyCSifjX9jnkJJGf
         T/6cLx0qnioNWDnX1pCSjbi3HhP1zlEvIb7bpbpq4byC+u9mgsaKE/UBe/MoLEiLnHHi
         Vl8piqdvoTok+f5UviMcNi438X963RlDbdCzdwJnCDegRqXipl6dzX5eBzAUSJFHL67g
         FEcStcFqGlJdTmdtHNPfcVpOnkNubsFjW3oBhWIqjbFbQTJ51aPSOLGv73K0nIOiiOFf
         ktAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4XsSMzweC2hce3gBZFupK62xUvqVZpQs6NijFrSeMbg=;
        b=GTTdn93AYTaYdQ4IGdCzzjjQwA6nUjQvLXv7ojg3508X0+zjg06FR5SdWx+gI5cC9J
         K/MMaMBps0Ops4BvlNmZXEWE17OiU+E3O5diRP3Ft3bbSn6xqaJqvun4eIxBafo2vWNM
         3WjmbfN5vtckMSfLH9+gLLGTW5kduyiwmR6nOJufVKFvIpNQMztrZZITcnkyKYosrrQ+
         ND2EBEwFYhozhitmpbLk9/5h7F3eKAWt8wv/GZrPgjaZtvuIPTpGyysm0kK7Ge/qSQVb
         eRB8ZzGedp4HLtEvoKJMjj2wbKskalA9+eWFtVtAUfuklqQ89D2A3K0HMAoLVAWoKXYd
         Q7oQ==
X-Gm-Message-State: AOAM531eLIZzYSuLn4Atw3wbfp8H0Jz4lZt07F+MSCs31KzYQQepClYm
        u0rmc+EqCdDMJ2wSqVfYp7gCtA==
X-Google-Smtp-Source: ABdhPJyUZwGIpP6D1iOrO4Z75GuJSw0+WOmTzYhUvHBjiuztpIiz7VtxhI+0HdK1LAVuN4xBBEtAZw==
X-Received: by 2002:aed:2f44:: with SMTP id l62mr7249716qtd.207.1598323033098;
        Mon, 24 Aug 2020 19:37:13 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1558:8dc0:5209:36ba])
        by smtp.gmail.com with ESMTPSA id n4sm11677006qtr.73.2020.08.24.19.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:37:12 -0700 (PDT)
Date:   Mon, 24 Aug 2020 22:37:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825023710.GA98081@syl.lan>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825022614.GA1391422@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 24, 2020 at 10:26:14PM -0400, Jeff King wrote:
> On Mon, Aug 24, 2020 at 10:01:04PM -0400, Taylor Blau wrote:
>
> > In 525e18c04b (midx: clear midx on repack, 2018-07-12), 'git repack'
> > learned to remove a multi-pack-index file if it added or removed a pack
> > from the object store.
> >
> > This mechanism is a little over-eager, since it is only necessary to
> > drop a MIDX if 'git repack' removes a pack that the MIDX references.
> > Adding a pack outside of the MIDX does not require invalidating the
> > MIDX, and likewise for removing a pack the MIDX does not know about.
>
> Does "git repack" ever remove just one pack? Obviously "git repack -ad"
> or "git repack -Ad" is going to pack everything and delete the old
> packs. So I think we'd want to remove a midx there.
>
> And "git repack -d" I think of as deleting only loose objects that we
> just packed. But I guess it could also remove a pack that has now been
> made redundant? That seems like a rare case in practice, but I suppose
> is possible.

Yeah, the patch message makes this sound more likely than it actually
is, which I agree is very rare. I often write 'git repack' instead of
'git pack-objects' to slurp up everything loose into a new pack without
having to list loose objects by name.

That's the case that I really care about here: purely adding a new pack
should not invalidate the existing MIDX.

> Not exactly related to your fix, but kind of the flip side of it: would
> we ever need to retain a midx that mentions some packs that still exist?
>
> E.g., imagine we have a midx that points to packs A and B, and
> git-repack deletes B. By your logic above, we need to remove the midx
> because now it points to objects in B which aren't accessible. But by
> deleting it, could we be deleting the only thing that mentions the
> objects in A?
>
> I _think_ the answer is "no", because we never went all-in on midx and
> allowed deleting the matching .idx files for contained packs. So we'd
> still have that A.idx, and we could just use the pack as normal. But
> it's an interesting corner case if we ever do go in that direction.

Agreed. Maybe a (admittedly somewhat large) #leftoverbits.

> If you'll let me muse a bit more on midx-lifetime issues (which I've
> never really thought about before just now):
>
> I'm also a little curious how bad it is to have a midx whose pack has
> gone away. I guess we'd answer queries for "yes, we have this object"
> even if we don't, which is bad. Though in practice we'd only delete
> those packs if we have their objects elsewhere. And the pack code is
> pretty good about retrying other copies of objects that can't be
> accessed. Alternatively, I wonder if the midx-loading code ought to
> check that all of the constituent packs are available.
>
> In that line of thinking, do we even need to delete midx files if one of
> their packs goes away? The reading side probably ought to be able to
> handle that gracefully.

I think that this is probably the right direction, although I've only
spend time in the MIDX code over the past couple of weeks, so I can't
say with authority. It seems like it would be pretty annoying, though.
For example, code that cares about listing all objects in a MIDX would
have to check first whether the pack they're in still exists before
emitting them. On top of that, there are more corner cases when object X
exists in more than one pack, but some strict subset of those packs
containing X have gone away.

I don't think that it couldn't be done, though.

> And the more interesting case is when you repack everything with "-ad"
> or similar, at which point you shouldn't even need to look up what's in
> the midx to see if you deleted its packs. The point of your operation is
> to put it all-into-one, so you know the old midx should be discarded.
>
> > Teach 'git repack' to check for this by loading the MIDX, and checking
> > whether the to-be-removed pack is known to the MIDX. This requires a
> > slightly odd alternation to a test in t5319, which is explained with a
> > comment.
>
> My above musings aside, this seems like an obvious improvement.
>
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 04c5ceaf7e..98fac03946 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -133,7 +133,11 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
> >  static void remove_redundant_pack(const char *dir_name, const char *base_name)
> >  {
> >  	struct strbuf buf = STRBUF_INIT;
> > -	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
> > +	struct multi_pack_index *m = get_multi_pack_index(the_repository);
> > +	strbuf_addf(&buf, "%s.pack", base_name);
> > +	if (m && midx_contains_pack(m, buf.buf))
> > +		clear_midx_file(the_repository);
> > +	strbuf_insertf(&buf, 0, "%s/", dir_name);
>
> Makes sense. midx_contains_pack() is a binary search, so we'll spend
> O(n log n) effort deleting the packs (I wondered if this might be
> accidentally quadratic over the number of packs).

Right. The MIDX stores packs in lexographic order, so checking them is
O(log n), which we do at most 'n' times.

> And after we clear, "m" will be NULL, so we'll do it at most once. Which
> is why you can get rid of the manual "midx_cleared" flag from the
> preimage.

Yep. I thought briefly about passing 'm' as a parameter, but then you
have to worry about a dangling reference to
'the_repository->objects->multi_pack_index' after calling
'clear_midx_file()', so it's easier to look it up each time.

> So the patch looks good to me.

Thanks.

> -Peff

Thanks,
Taylor
