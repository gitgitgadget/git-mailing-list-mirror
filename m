Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BEBC433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 19:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383955AbiEMTzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378150AbiEMTzL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 15:55:11 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8360215806
        for <git@vger.kernel.org>; Fri, 13 May 2022 12:55:10 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r27so9851433iot.1
        for <git@vger.kernel.org>; Fri, 13 May 2022 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U4FRcoDIMKu+5YASfERSp0PH1UbzYHciFGBG0HSmeiE=;
        b=16iNVkYLobCtywraGtYVH99Knuh+jsphQZ6cQyWXjIqAtKdjWF9eT+5llWKvcvOwzt
         868cHvcR7+LTz8Z4wNrXi5ur1kHD0qWOqJNtnV3O2WmemyvPAIeCUjVuo+fAjFrz1SGw
         YNBCUyR8rKM2uwLCXGdAYRaPmuuYh4ULrXN05k0Z0R1IeUD4nW+dHStlJnSNgd/payNn
         PraFd5Njl4IhDQf1w1Eq7mX91xwYY7Z+yOZTTN89yI9sWed+tP4HcJraxfJ2XavHElj4
         A/vICwDPJsW+LRbjpZi4jW2K1KqTRSKpeZ7hFwQnXcm9wDU8rCYXAUqMieOSr3c3qhYp
         sduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U4FRcoDIMKu+5YASfERSp0PH1UbzYHciFGBG0HSmeiE=;
        b=KuN5j4YmzibagbOgjn1/E7jaOWg8qGmF3t82uO+sSsWcRQIRrT18oR/voszXWJxKeh
         yfCKoQWVVuJNC3oJWjDY/O09KP2EgetxDZdTeKT4IIUrPekyWpRu5opMaKxaDJ2PC20O
         jxx0tgP/bQ4zAHTPvftyBFBvCnV+EHjOr2gB46DG/w56do6Wfop4xliPgUFSX5S/JgDn
         utpATElaPFIuOQc6Hig0LLH/+VzumZU6CzILmpYZttwATBuGQJ17P5qNw7Gt0DHNeE7T
         3ArAJk7hI+Ii+QrVDCWF1A83W6amvAQroTgXUIFX9K71tT/SEb4xJRxUOdtisifV0Lz1
         MqNQ==
X-Gm-Message-State: AOAM531yIC8yHvV0DGq+c92PQi+o1dK6VsN7IQkLLd7D11T+0C55aTIn
        pxVs4LA1ggEwVMBt7Xk7Qe299Q==
X-Google-Smtp-Source: ABdhPJz+ulB6/swE0YjfMHcP3lDDTCPwnzy1Uwsh/74hKul83pfdYs+AEbT7CS6ME8TcOkJdKMftbw==
X-Received: by 2002:a05:6638:18:b0:32a:f83e:166e with SMTP id z24-20020a056638001800b0032af83e166emr3472818jao.4.1652471709857;
        Fri, 13 May 2022 12:55:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f23-20020a056638113700b0032b3a781791sm900274jar.85.2022.05.13.12.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 12:55:09 -0700 (PDT)
Date:   Fri, 13 May 2022 15:55:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        vdye@github.com, jonathantanmy@google.com
Subject: Re: [PATCH 1/2] pack-bitmap: check preferred pack validity when
 opening MIDX bitmap
Message-ID: <Yn63nDhSBIEa3/+/@nand.local>
References: <cover.1652458395.git.me@ttaylorr.com>
 <06eca1fba9d2597906ec342c51ba2bb5c4fde0e4.1652458395.git.me@ttaylorr.com>
 <xmqqpmkh9tye.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmkh9tye.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 13, 2022 at 11:19:05AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > The pack bitmap code does this, too, since prior to bab919bd44
> > (pack-bitmap: check pack validity when opening bitmap, 2015-03-26) it
> > was vulnerable to the same race.
>
> That might be a GitHub internal reference to some other commit?
> dc1daacd (pack-bitmap: check pack validity when opening bitmap,
> 2021-07-23) is what I found.

Oops. dc1daacdcc is the right reference (it's the version of our
bab919bd44 that got submitted upstream).

> > Similar to bab919bd44, we could technically just add this check in
>
> ... here.  But the solution in dc1daacd is quite different from what
> we see here in the posted patch, so perhaps you are referring to
> something different.  I dunno.

They are similar. Both dc1daacdcc and this patch ensure that the pack
we're going to do verbatim reuse from (i.e., the one that gets passed to
`reuse_partial_pack_from_bitmap()`) has an open handle.

In the case of a pack bitmap, there is only one pack to choose from (the
pack corresponding to the bitmap itself). In the case of a multi-pack
bitmap, the preferred pack is the one we choose, since it is the only
pack among those in the MIDX that we attempt verbatim reuse out of.

> The call graph around the functions involved is
>
>   prepare_midx_bitmap_git()
>    -> open_midx_bitmap_1()
>       * opens, mmaps and closes bitmap file
>       -> load_midx_revindex()
>    -> load_bitmap()
>       -> load_reverse_index()
>          -> prepare_midx_pack()
>          -> load_pack_revindex()
>
> And prepare_midx_pack() for these packs is moved from
> load_reverse_index() to open_midx_bitmap_1() in this patch.
>
> In addition, after doing so, we call is_pack_valid() on the single
> preferred pack and return failure.
>
> Because load_bitmap() or load_reverse_index() cannot be done before
> you do open_midx_bitmap_1(), calling prepare_midx_pack() early will
> end up calling add_packed_git() on underlying packs, allowing us to
> access them even when somebody else removed them from the disk?  Is
> that the idea?

Yes, exactly. It's similar to dc1daacdcc in that we need to have an open
handle on the packfile itself in order to reuse chunks of it verbatim.
Having the bitmap open signals pack-objects to say "it is OK to call
reuse_partial_packfile_from_bitmap()", but if that function tries to
open the packfile because it wasn't already opened like above, and in
the meantime it went away, we'll end up in the "cannot be accessed"
scenario.

> > reuse_partial_packfile_from_bitmap(), since it's technically possible to
> > use a MIDX .bitmap without needing to open any of its packs. But it's
> > simpler to do the check as early as possible, covering all direct uses
> > of the preferred pack. Note that doing this check early requires us to
> > call prepare_midx_pack() early, too, so move the relevant part of that
> > loop from load_reverse_index() into open_midx_bitmap_1().
>
> OK.  That matches my observation above, I guess.  I do not quite get
> why it is sufficient to check only the preferred one, though.

Only the preferred pack is the subject of verbatim reuse. We could open
all packs, but see my note in the patch message for why I don't think
that's a great idea.

The subsequent patch more aggressively opens packs handed to us via
traverse_bitmap_commit_list().

> > @@ -353,6 +355,21 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
> >  		warning(_("multi-pack bitmap is missing required reverse index"));
> >  		goto cleanup;
> >  	}
> > +
> > +	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
> > +		if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
> > +			die(_("could not open pack %s"),
> > +			    bitmap_git->midx->pack_names[i]);
> > +	}
> > +
> > +	preferred = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
> > +	if (!is_pack_valid(preferred)) {
> > +		close(fd);
>
> This close() does not look correct.  After calling xmmap() to map
> the bitmap file to bitmap_git->map, we do not need the underlying
> file descriptor in order to use the contents of the file.  We have
> closed it already at this point.

Definitely a mistake, thanks for catching. Will remove it and send
another version after there is some review on the second patch.

Thanks in the meantime for giving it a look over!

Thanks,
Taylor
