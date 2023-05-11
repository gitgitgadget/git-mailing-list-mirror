Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC027C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 23:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbjEKXKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 19:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEKXKf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 19:10:35 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8069B2D4A
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:10:34 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55a010774a5so141806277b3.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683846633; x=1686438633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Mp4tp7jl3ZU1mCpQuLQWxeZS2HovNzTHRa9FzS3hEg=;
        b=LXKJxu6nD7Iw/LFeJkdNXhhjtQ8GbHnGkZUVKCKFr68e2kUxDfUx8diWJtvHWhGjv7
         72J5OpJ7gwd0wPea+jJ0OJ83wFgqJjayTG6G/GxRnTOrilK+s9/pHB+gpcS2fqQ6l4EQ
         NbEfcVvKPU+Ki3X1X7o2l+tawujrZk15pMgRPsC0GzjeX+Vh2Scm+6zmCeBw8fbMJV7Z
         xHfsbgVYLSWFiWHkPlc8cd/IyyoLLeXniZp/iDP0PIViovGbrtgEOcygZVYB+Yuw+jY+
         W6HYElUjFXzTO+9uxJ7MAXYg78ydiigBk4o6wQrNwWTuUcVVUV9Q5mNNCFI+XzGb4K4A
         A5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683846633; x=1686438633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Mp4tp7jl3ZU1mCpQuLQWxeZS2HovNzTHRa9FzS3hEg=;
        b=Rpp5rjXhi0LLRj5CwfbtApt4LPGFyTJPdOYHuIChmAphoP5kWtoBzX4VGDetBxdxQZ
         /fv1OuGqzxk6HHJfPhBw6pioVkLWXRvHIrj1ChB/nTygkYE743Jx9EXyDxMUYykapakj
         2VPR9Z8VCCnm4gb0Tl6mb4ag2KT+l4MArmoR7VO8t67dTIFdha83MbubqYt2wmVcxz7L
         PKJsS61pIJEvVmnV+ddMvnfTwKJpHewLPwodtScGXfVU+9lAP5XgeT2BuXY3pxfpGzme
         fvcsSSwxcvuB+W9+ts3yOn1l61kkjR1+21h0JZ/BTsg9DsYmKllc/XhTLL1cZTETRmZO
         h7tQ==
X-Gm-Message-State: AC+VfDzVpXc2zuNhOgvDWX5YBwMOZjWDb7c2vMRzSb7MIN+m+xl3aCjC
        3eGaRSZQp/OGC++gqFzRUC1qk1MgFYhW5+G1pL5HLw==
X-Google-Smtp-Source: ACHHUZ7kVKiP976czdX6FT31bLO77Wiy2eWoP3W2g+TE1fGFkoZQft10fXkkUxQX2qchzVy/vCMN3A==
X-Received: by 2002:a0d:c206:0:b0:55a:3718:5270 with SMTP id e6-20020a0dc206000000b0055a37185270mr21804093ywd.14.1683846633630;
        Thu, 11 May 2023 16:10:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u75-20020a81844e000000b0055a7ff0a5cdsm5216631ywf.27.2023.05.11.16.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:10:33 -0700 (PDT)
Date:   Thu, 11 May 2023 19:10:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: Changed path filter hash differs from murmur3 if char is signed
Message-ID: <ZF116EDcmAy7XEbC@nand.local>
References: <20230511224101.972442-1-jonathantanmy@google.com>
 <xmqqjzxetrbv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzxetrbv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 03:51:16PM -0700, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> > So...how do we proceed? I can see at least 2 ways:
> >
> >  - Decide that we're going to stick with the details of the existing
> >    implementation and declare that "data" is always interpreted as signed.
> >    In that case, I would put "signed" wherever necessary, rename the
> >    function to something that is not "murmur3", and change the names of
> >    byte1 etc. to indicate that they are not constrained to be less than or
> >    equal to 0xff.
> >
> >  - Bump the version number to 2 and correct the implementation to
> >    match murmur3 (so, "data" is unsigned). Then we would have to think of
> >    a transition plan. One possible one might be to always reject version
> >    1 bloom filters, which I'm personally OK with, but it may seem too
> >    heavy a cost to some since in the perhaps typical case where a repo has
> >    filenames restricted to 0x7f and below, the existing bloom filters are
> >    still correct.
>
> If path filter hashing were merely advisory, in the sense that if a
> matching data is found, great, the processing goes faster, but if
> not, we would get correct results albeit not so quickly, a third
> option would be to just update the implementation without updating
> the version number.  But we may not be so lucky---you must have seen
> a wrong result returned quickly, which is not what we want to see.

Right; from my understanding of Jonathan's message, I believe that we
would get the wrong results if the implementation of not-quite-murmur3
were corrected without updating the on-disk Bloom filters.

We already have the bloom_filter_settings struct, which could also
encode whether or not the data was computed with sign extension or not.
If we are consistent in computing the hashes when we write Bloom filters
and when we re-compute hashes to query them, I'd think we would be able
to reuse the existing filters.

That would be nice to do if we could. Unfortunately, I don't think there
is an easy way to determine the signed-ness of an existing set of Bloom
filters, nor a guarantee that they all have the same signed-ness (IOW,
the Bloom filters could have been built up across multiple copies of
Git, each with different compiler settings).

So I'm not sure that that is a productive direction for us to take.

> But if I recall correctly we made the file format in such a way that
> bumping the version number is cheap in that transition can appear
> seamless.  An updated implementation can just be told to _ignore_
> old and possibly incorrect Bloom filters until it gets told to
> recompute, at which time it can write a correct one with a new
> version number.  So I would prefer your "Bump the version number and
> ignore the old and possibly wrong data".

Version numbers are easy to increment, as is the case when adding new
chunks to the chunked file format used by commit-graph,
multi-pack-index, etc.

However, computing Bloom filters en-masse from scratch is fairly
expensive. At GitHub when we were rolling out Bloom filters to all
repositories a few years ago, I wrote 809e0327f5
(builtin/commit-graph.c: introduce '--max-new-filters=<n>', 2020-09-18)
to avoid spending too much time computing new filters from scratch.

If we do have to re-compute all of the filters from scratch, it may be
worth considering enumerating all of the repository's paths first and
seeing if any of them are >0xff. If none are, we can propagate the
existing filters forward without having to compute new ones.

Better yet, we should be able to reuse existing Bloom filter data for
paths that have all characters <=0xff, and only recompute them where
necessary. That makes much more sense than the previous paragraph.

Thanks,
Taylor
