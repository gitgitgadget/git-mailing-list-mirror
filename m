Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C8FC433FE
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354077AbiETX01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354072AbiETX0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:26:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1857368FB6
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:26:21 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id 11so6657426qtp.9
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=flNAyu6DBYDgwqo1LxKpS3cuF8VVAHvu7THmZcueriY=;
        b=KAlfYFGNk5qxLSgBPNprlYcHWaKSO9504nierkbzqbTCRQp6Q5FvXPFuvfUBZHX2zR
         hTApxSbmOJGkbVwEewrrnQ4fz94HZ39Sqsj+J5Co0ecXcKxPNpWeLeDMG9qFeXlYrykA
         JOIFCIouMdVdqD1pPWdszcUsxrY8DDtce8ABNW6bdrNr/DfQ3fw3+hZh16qp7UsWXRMC
         5td98SO2ZET19Uu8alAPjAzc+vuehPeP9XPkZs8e0NytNrpMYpbwNwkXZGXgGRa1GhK/
         74OvNkPWbcl+kChDZNFiDXaDzucUMka2YX3Gnm2a6fzHJY1+lhnquejYOy3lPaYx2nK6
         M8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=flNAyu6DBYDgwqo1LxKpS3cuF8VVAHvu7THmZcueriY=;
        b=Oe+Cg2tAV3OUBaKdZ7TTTbNeH86pXmX1y43ANnV0quBy9iGchzLHpPYdE3g937P0po
         n6GEcPrJX2Gv3pRENaHuGt/36h7XVxWX664I2FfBMmBpqJFG8gWuJOXoXLFZA4m6E1+N
         lbr/VQlki1E5V3nHeL+ssVFXbrbe4zb273uRO/loFRi3U5Qq9+8bI1M8VjFLCx5Bflhc
         tVbtuF0sYj8TDKboXcHfHfb3KfdU2ZbMjokklbkIIxnuJRBnnPXpPyKptqIxNaQCY2c8
         rKvbmGIahuM1o6HLZ3sFpWicsAX1tofIKy5Vr7pWI9Glff0CjkNKDIY4CJ3R6/7A9/wF
         c0Lw==
X-Gm-Message-State: AOAM530Aucn26a3SWblS7gEgd9kIwlBaP/WjBfzfpx1BpBGH6YTBMBpU
        OAvmG0IBVFKA9P+nLmdJjwpdVw==
X-Google-Smtp-Source: ABdhPJzfm4d5PDWbpMs3v3FMniYAZxktvbn+5G4+bN0VAGvn9dh72e3d/baosdV3HIsvQzmRp/kXNQ==
X-Received: by 2002:a05:622a:40c:b0:2f4:aa26:4e9e with SMTP id n12-20020a05622a040c00b002f4aa264e9emr9305168qtx.302.1653089180219;
        Fri, 20 May 2022 16:26:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h11-20020a05620a21cb00b006a36b7e55b3sm28752qka.4.2022.05.20.16.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:26:19 -0700 (PDT)
Date:   Fri, 20 May 2022 19:26:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] repack: respect --keep-pack with geometric repack
Message-ID: <Yogjmn9BcOBc/5ed@nand.local>
References: <pull.1235.git.1653064572170.gitgitgadget@gmail.com>
 <YofJLv8+x5J7yPmf@nand.local>
 <xmqqr14oey2a.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr14oey2a.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2022 at 01:41:49PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >>  	*geometry_p = xcalloc(1, sizeof(struct pack_geometry));
> >>  	geometry = *geometry_p;
> >>
> >> +	string_list_sort(existing_kept_packs);
> >
> > Would it be worth sorting this as early as in collect_pack_filenames()?
> > For our purposes in this patch, this works as-is, but it may be
> > defensive to try and minimize the time that list has unsorted contents.
>
> It does not matter too much but after reading the latest one before
> coming back to this original thread, I actually thought that sorting
> it too early was questionable.  Nobody other than this code cares
> about the list being sorted, and if it turns out that the look-up in
> the loop need to be optimized, it is plausible that we do not need
> this list sorted when we populate a hashmap out of its contents, for
> example.

My thinking was simply that sorting it as often as possible (by doing so
immediately after appending all of our newly written packs into it) was
the most defensive approach that we could take. At least in the sense of
another caller which _does_ depend on `names` sorted, and makes the same
mistake of forgetting to call `string_list_sort()` itself.

I suspect that this is mostly academic anyway, and that either would be
fine, so if others feel strongly I'm happy to send an updated version
(though TBH I would be just as happy with what we already have in the
series I posted here).

> >>  	for (p = get_all_packs(the_repository); p; p = p->next) {
> >> -		if (!pack_kept_objects && p->pack_keep)
> >> -			continue;
> >> +		if (!pack_kept_objects) {
> >> +			if (p->pack_keep)
> >> +				continue;
> >
> > (You mentioned this to me off-list, but I'll repeat it here since it
> > wasn't obvious to me on first read): this check for `p->pack_keep` isn't
> > strictly necessary, since any packs that have their `pack_keep` bit set
> > will appear in the `existing_kept_packs` list.
> >
> > But it does give us a fast path to avoid having to check that list, so
> > it's worth checking that bit to avoid a slightly more expensive check
> > where possible.
>
> That invites a related but different question.  Doesn't p->pack_keep
> and string_list_has_string(existing_kept_packs, name_of_pack(p))
> mirror each other?  Can a pack appear on the existing_kept_packs
> list without having .pack_keep bit set and under what condition?

Unfortunately not. `repack` is much more keen to manipulate the results
of calling readdir() over $GIT_DIR/objects/pack than it is to, say, call
`get_all_packs()` and mark `p->pack_keep_in_core`.

In a future where `repack` does not interact with the packdir at such a
low level, I don't think we would have a use for a function like
`collect_pack_filenames()` at all. But that is a much larger change than
this one ;).

> It is answered by the comment below, I presume?
>
> >> +			/*
> >> +			 * The pack may be kept via the --keep-pack option;
> >> +			 * check 'existing_kept_packs' to determine whether to
> >> +			 * ignore it.
> >> +			 */
>
> OK.  So there are two classes of packs we want to exclude from the
> geometry repacking.  Those that already have .pack_keep bit set, and
> those that are _are_ newly making into kept packs that do not yet
> have .pack_keep bit set.  Makes sense.

Yep (and also "yep" to your note below about adding cruft packs into the
mix).

Thanks,
Taylor
