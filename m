Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5F9C433F5
	for <git@archiver.kernel.org>; Sat, 14 May 2022 13:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiENNRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 May 2022 09:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiENNR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 May 2022 09:17:29 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAF73F88E
        for <git@vger.kernel.org>; Sat, 14 May 2022 06:17:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id fu47so9168110qtb.5
        for <git@vger.kernel.org>; Sat, 14 May 2022 06:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IzcO3erWb69vizQCxbC6t6jEkUBKOh13lLvItXoVhlE=;
        b=Bz0PhN1jjl/pPWPB8SSRtICgBAbtqlyRc2SH6xgCbyvuBaWUKkZhnk3AFNZHtXl4wj
         Ks702ZcSmKjtAuok2YV4b4TgTrGjvgFKrZpcfoHSz4t81i3HXpfq7N62ChBs9auHkGoE
         Xm1yUVE5NBlqPlVG/SatuMql6a+z+4vhgCEHub+mtlhFAAQE9PXNw2jt8a1TI4UIIvFR
         NFL8DSRjS5ZoKgoPoZes7gzpLG8BVJk2sWrvJ5ZXytUR352/5vsbocGvOco1kpZ/+FhO
         EPgNkC5xAfV1udAkCUPLzFERMukvVd9Z/bmFs06BS7b023XrXX55gROHk5doQu/zzYFf
         JpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IzcO3erWb69vizQCxbC6t6jEkUBKOh13lLvItXoVhlE=;
        b=Z2BN9PyzgJKGBOLmkpblxj85LFYf5F5wvHrviLDiUFXwdqN+/A5h3LwLqr4pCJ+r54
         1XBC0KFQ+0LI6253j6f242HiKNnLvvIm4UV47uGeADVAqI9xvqv3RniW+YX6nwlQysG0
         NkcnbO/FAepDLZNALUZYnqOyaInbZJlgnAdo2r+CuwVPsStrhscUt2qlRIeEual1ErUR
         p0MqDViIuYAcEAvyPhwdPQa8xLZ/HLml1Q3TcYeG8IfZoafRWqBjYyDceAZIix58/A6E
         /EYS1cAPIEhaSz3nu5v0jlr7mfa/93F0FvV+uGdKEoIN1UKjT2OKEInySh48bd/BpbOE
         irKA==
X-Gm-Message-State: AOAM530+Zwyr5I25gFD83P2N6CsxT2NlwDgOagvpAcFuGeLEgc0/WINk
        EsrnuY/AcE754BgK235sGrjIJA==
X-Google-Smtp-Source: ABdhPJyjyrCpDsfrp9zs4so0HgXugTF+FqubUTXv0ozhRoGcFGE7SHiNCTYJf+5B6lJVE0BRAMC0IA==
X-Received: by 2002:ac8:58ca:0:b0:2f3:da32:ab1 with SMTP id u10-20020ac858ca000000b002f3da320ab1mr8499446qta.308.1652534244558;
        Sat, 14 May 2022 06:17:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t203-20020a37aad4000000b0069fc55f2ff3sm2890397qke.9.2022.05.14.06.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 06:17:23 -0700 (PDT)
Date:   Sat, 14 May 2022 09:17:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, vdye@github.com, gitster@pobox.com
Subject: Re: [PATCH 2/2] builtin/pack-objects.c: ensure pack validity from
 MIDX bitmap objects
Message-ID: <Yn+r4lPi8vNK/qFG@nand.local>
References: <bcc48004450769410d7e6d8a6e56f08bfa9a02a3.1652458395.git.me@ttaylorr.com>
 <20220513230639.1099955-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220513230639.1099955-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 13, 2022 at 04:06:39PM -0700, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > An alternative approach to closing this race would have been to call
> > `is_pack_valid()` on _all_ packs in a multi-pack bitmap on load. This
> > has a couple of problems:
> >
> >   - it is unnecessarily expensive in the cases where we don't actually
> >     need to open any packs (e.g., in `git rev-list --use-bitmap-index
> >     --count`)
> >
> >   - more importantly, it means any time we would have hit this race,
> >     we'll avoid using bitmaps altogether, leading to significant
> >     slowdowns by forcing a full object traversal
>
> This answers a question I had about why we're only opening the preferred
> pack instead of all packs. (You mention in [1] that it's also answered
> in that patch message, but I didn't see it.) In any case, it might be
> clearer to move this part to the 1st commit.
>
> [1] https://lore.kernel.org/git/Yn63nDhSBIEa3%2F+%2F@nand.local/

Makes sense, will do. In [1] I was referring to why we wanted to call
`is_pack_valid()` as early as we did, and not in
`reuse_partial_packfile_from_bitmap()`.

But the quoted part here is useful context for the first patch, too, so
I moved it up.

> > Work around this by calling `is_pack_valid()` from within
> > `want_found_object()`, matching the behavior in
> > `want_object_in_pack_one()` (which has an analogous call). Most calls to
> > `is_pack_valid()` should be basically no-ops, since only the first call
> > requires us to open a file (subsequent calls realize the file is already
> > open, and return immediately).
> >
> > This does require us to make a small change in
> > `want_object_in_pack_one()`, since `want_found_object()` may return `-1`
> > (indicating "keep searching for other packs containing this object")
> > when `*found_pack` is non-NULL. Force `want_object_in_pack_one()` to
> > call `is_pack_valid()` when `p != *found_pack`, not just when
> > `*found_pack` is non-NULL.
>
> It took me a while to realize that the relevant want_found_object()
> invocation that may return -1 is not the one in
> want_object_in_pack_one(), but in the latter's caller
> want_object_in_pack(). But even in this case, couldn't
> want_found_object() return -1 (see the very end of the function) even
> before this patch?

Perhaps changing the parenthetical to be:

    (indicating that `want_object_in_pack()` should continue searching
    for other packs containing this object)

Yes, `want_found_object()` could have returned -1 before, but the only
time when `*found_pack != NULL` and `want_found_object()` would have returned
-1 is when given `--local` with at least one non-local pack.

I actually think it's possible we have a bug there, since AFAICT the
pre-image of this patch would have left the non-NULL `*found_pack` alone
but picked a copy of the given object from a _different_ pack. So I
think this change inadvertently resolves that bug.

> > @@ -1424,14 +1427,15 @@ static int want_object_in_pack_one(struct packed_git *p,
> >  				   off_t *found_offset)
> >  {
> >  	off_t offset;
> > +	int use_found = p == *found_pack;
> >
> > -	if (p == *found_pack)
> > +	if (use_found)
> >  		offset = *found_offset;
> >  	else
> >  		offset = find_pack_entry_one(oid->hash, p);
> >
> >  	if (offset) {
> > -		if (!*found_pack) {
> > +		if (!use_found) {
> >  			if (!is_pack_valid(p))
> >  				return -1;
> >  			*found_offset = offset;
>
> My understanding of the purpose of this code change is that if we reach
> here with a non-NULL *found_pack, it is likely that *found_pack contains
> an invalid pack, and this part overwrites *found_pack (and
> *found_offset) if it finds a valid pack. This seems like a good change,
> but I don't see how this is a result of something that "does require
> us" (as far as I can tell, *found_pack could have already been invalid
> before this patch, so the downstream code should already be able to
> handle it). Maybe it's just that we couldn't tell if the pack is invalid
> previously, but now we can; but if so, it would be better to say "use
> this added information to overwrite *found_pack when it makes sense" or
> something like that.

I think my reply above indicates why this change is necessary, but if
we're talking about separate issues, let me know.

Thanks,
Taylor
