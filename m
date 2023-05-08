Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8633AC7EE25
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjEHWMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEHWMl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:12:41 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30A09012
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:12:04 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55a10577911so73873397b3.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583924; x=1686175924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6HWH3UY0oNOSpsgIoIp46QCKi5rC/l0W0n1J1saVgE=;
        b=PKmXtpXJSankd/tqRx8MREeojNaLj2oWGL5X8PMvMFvC11LITBHTN14OlQZSGPKqL3
         vz+x/S/PNTftXSCOn4pHPdpR3QGIldH6BPhdmK4Mgub5iQ090LhNGck+UeIduaPBF1Lz
         UfS6xMhyb9WqFjfvFQQLWAkHrAgOk4PbKkOsNznxoCsI1T2eYHdAOFdKKiuvxA32A1gT
         njhO7OVefYOiL8lJ6q04rjibzVaeeQbS96HCAA1BKPmE2nDLPK45t2x04kIfkGCv6mbd
         iz7hoM1w6mpDcrbZZiTnfElJtYK14EpqCtcWZ8j+TIJBrlIgtgqgt3arhmqMY+OW557d
         sMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583924; x=1686175924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6HWH3UY0oNOSpsgIoIp46QCKi5rC/l0W0n1J1saVgE=;
        b=hWk5PqoXjyq7uKYclDxXh7IUsUOGfl+nX9W/+LMhYhiY6PdiScueQHzqHs1z+2GWo8
         WhKxS7CUjQ0uPdKLqG+5XLdicHqxZCrwsPGU1HlVIJv5LjLeYo63E2kFCjozuAHqoNVu
         q6aFhWHEbJ2tmC4diYeJUhIYaCu5xvl4+Cn3DjeajVTP2UiIwcUCC3WX9z/4XlqjTeEy
         zfFWcPr7Mzk4lF3bSFxG7tdiv5P6QZMjXoL9VdRdtzF0sUlH9BkXH57oxt05gia75Zwv
         gbko2oS5rbDUxi1l5WUphb/5eCURSGIx3dmkD2r3gt0xzqb1VJyDKYccwtcytM9z+pgQ
         LGJA==
X-Gm-Message-State: AC+VfDwKY/l6Ul1unS7SxeJAHt7QjSFm0y5YxFS15+ORx1CSJaA+q6VJ
        d3ksiq4LRKOgQweDQLOh+qnH5g==
X-Google-Smtp-Source: ACHHUZ7SUS1JlWEmAbrqS58uvu9C7QmYb0ElCmiqC8evEGg0BpJj6KmjBnRaoNdwj+ULvhIUqWhL8w==
X-Received: by 2002:a81:d54b:0:b0:55a:105e:1a1 with SMTP id l11-20020a81d54b000000b0055a105e01a1mr13360613ywj.13.1683583923784;
        Mon, 08 May 2023 15:12:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i68-20020a0dc647000000b00545a08184edsm2807076ywd.125.2023.05.08.15.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:12:02 -0700 (PDT)
Date:   Mon, 8 May 2023 18:12:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] pack-bitmap.c: use commit boundary during bitmap
 traversal
Message-ID: <ZFlzsYAREyA+6NLX@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683567065.git.me@ttaylorr.com>
 <8a8f41e0c410f9160b8ff922333c13ed68f7334b.1683567065.git.me@ttaylorr.com>
 <673a2b60-0556-fc2b-edf7-f2a19ef5dcbe@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <673a2b60-0556-fc2b-edf7-f2a19ef5dcbe@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2023 at 04:53:35PM -0400, Derrick Stolee wrote:
> On 5/8/2023 1:38 PM, Taylor Blau wrote:
>
> > -	/*
> > -	 * if we have a HAVES list, but none of those haves is contained
> > -	 * in the packfile that has a bitmap, we don't have anything to
> > -	 * optimize here
> > -	 */
> > -	if (haves && !in_bitmapped_pack(bitmap_git, haves))
> > -		goto cleanup;
> > +	use_boundary_traversal = git_env_bool(GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL, -1);
> > +	if (use_boundary_traversal < 0) {
> > +		prepare_repo_settings(revs->repo);
> > +		use_boundary_traversal = revs->repo->settings.pack_use_bitmap_boundary_traversal;
> > +	}
> > +
> > +	if (!use_boundary_traversal) {
> > +		/*
> > +		 * if we have a HAVES list, but none of those haves is contained
> > +		 * in the packfile that has a bitmap, we don't have anything to
> > +		 * optimize here
> > +		 */
> > +		if (haves && !in_bitmapped_pack(bitmap_git, haves))
> > +			goto cleanup;
> > +	}
>
> I was reading along, nodding my head, until I came across this comment.
> I recognize that it's moved from an existing place, but this seems very
> strange and incorrect.
>
> Is this implying that if the 'haves' are not in the bitmapped pack, then
> we _can't_ construct a bitmap representing the objects they can reach?
>
> Do we not have the ability to extend the object order beyond the bitmapped
> pack in-memory in a way that allows us to provide bit positions for the
> objects not in the bitmapped pack?

It is a strange heuristic indeed, and I had the same thought as you the
first time I remember encountering this part of the code.

in_bitmapped_pack() asks whether there is at least one of the given set
of objects which appears in the pack/MIDX corresponding with our bitmap.
In other words, this heuristic causes us to bail when none of the
objects listed as haves appear in the corresponding pack/MIDX.

Strictly speaking, there isn't a fundamental limitation preventing us
from using the bitmap traversal in cases where none of the tips exist in
the bitmapped pack/MIDX. That's what the extended index is for (see
`bitmap_position_extended()` and `ext_index_add_object()` for more
details).

AFAICT, the heuristic here is another way of saying, "if none of these
haves appear in the corresponding pack or MIDX, my bitmap coverage is
likely bad enough that it's not worth trying to construct a full bitmap
on the haves side (and we should fall back to the ordinary object
traversal)".

> I can understand saying "it might be more expensive to construct a bitmap
> here, because we need to walk into the bitmapped pack before we have a
> hope of hitting a bitmap." However, that's far from "we don't have anything
> to optimize".

Agreed.

> Something to think about removing in the future, but not a blocker for
> this series. Getting it out of the way for the boundary-based walk makes
> even more sense because the commits to check are those in the boundary,
> not the haves themselves.

Yeah. I think that what we do here will end up depending on the
performance of the boundary based approach. If it's a clear enough win
in a majority of cases, I'd just as soon drop the classic traversal (and
with it, this heuristic).

But if we do end up keeping the classic traversal around for a while, I
absolutely agree that we should investigate and consider dropping this
optimization, which I have long-suspected as not being very useful.

> > +test_expect_success 'boundary-based traversal is used when requested' '
> > +	git repack -a -d --write-bitmap-index &&
> > +
> > +	for argv in \
> > +		"git -c pack.useBitmapBoundaryTraversal=true" \
> > +		"git -c feature.experimental=true" \
> > +		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 git"
> > +	do
> > +		eval "GIT_TRACE2_EVENT=1 $argv rev-list --objects \
> > +			--use-bitmap-index second..other 2>perf" &&
> > +		grep "\"region_enter\".*\"label\":\"haves/boundary\"" perf ||
> > +			return 1
> > +	done &&
> > +
> > +	for argv in \
> > +		"git -c pack.useBitmapBoundaryTraversal=false" \
> > +		"git -c feature.experimental=true -c pack.useBitmapBoundaryTraversal=false" \
> > +		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=0 git -c pack.useBitmapBoundaryTraversal=true" \
> > +		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=0 git -c feature.experimental=true"
>
> This ordering (GIT_TEST_*=0 overrides config) seems backwards to me, but
> it doesn't really matter since it's a GIT_TEST_* variable. Thanks for
> including tests so the order is documented.

Now that you mention it, I think it's backwards too ;-). But I agree
that documenting it here is sufficient (and ideally, we don't have to
live with this GIT_TEST variable for more than a release or two,
anyway).

> > +	do
> > +		eval "GIT_TRACE2_EVENT=1 $argv rev-list --objects \
> > +			--use-bitmap-index second..other 2>perf" &&
> > +		grep "\"region_enter\".*\"label\":\"haves/classic\"" perf ||
> > +			return 1
>
> nit: you should be able to use 'test_region' here. Probably not worth
> a re-roll, as everything else looks good to me.

Ah, I didn't know of `test_region` before. I'll keep it in mind, thanks!

Thanks,
Taylor
