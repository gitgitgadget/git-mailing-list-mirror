Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E10DC433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 01:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbhLKBn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 20:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhLKBn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 20:43:26 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9512C061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 17:39:50 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id j21so10023625ila.5
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 17:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=120UqNt5o1/h0UWdkL0vLC+9Mb7JHucXpGcbLbHosqY=;
        b=nflkTlcvlGkGIylxOHRvVuc4OJVFONAJgaAoFvv0+jZjnzAxVnpg1HYeyUq6/TFyuA
         myjDGdq2ZXQuQeps/+SFeLDeZVzaWSGqWC1OWHpF2HFOq6rgleJfMj8ujCWDm/aYejB3
         HDqC4pZ38WiQ/AEDjsACFpT7hGkZRB+VCWuIVHql6OIBQObTnKRQzv6wxhA5cdkMt+bi
         dTEw2+nmVmEAiybzaPVNho9VvIHJBXWqSmf3iroNruo2iTHpPMfkQxlQkokkZKewisq4
         BtXNzOqNLS3w3nhlk2ZReITGxRX1rgTYDtNNJKs4z1oqRS1w+lR8miuEmwNGn3PEfXGR
         3gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=120UqNt5o1/h0UWdkL0vLC+9Mb7JHucXpGcbLbHosqY=;
        b=jiU2iuUVyJYL9LYqPi6wyr6dlFa/cNRzmifqesFne3e7GFKAIny3zB9CRAlPqtiECa
         0HalQNShqb0epBniyuct6kAjZQGvwARuv366sF6RiiO+8hP23Ht8djWASImP//Cz6pTW
         Y2lv4BKfwDS3lo54OpFsh+IapbdEvTde3z58WpykmHU0LwNbGc5KCz6Rbnjz2u95/8dN
         q4twTEpNlxzphTqWcLyENH1iV6JS3h7oO7fSdnEs+CW2zUveIC3VyxYJYLGhDrNJqFjp
         e6a9JNBKcfzWZ0smhfxocRZsqAf7ANDetRX7WQ9u/GJ84B9cRFE6rEIYkfEMfiehp+o9
         QpVg==
X-Gm-Message-State: AOAM5321zGwZNs7SHepW6KNUB3/Twmow7UDolDCnXg0nhaG8rjzynbnu
        UYtYvmuVO1w40z0L3roTUDVZeECgSbfhuTZ2
X-Google-Smtp-Source: ABdhPJwHvgz2LIxpDDKsK5+k1xoxrue1dIvmZKF/cTEetnYLl2LDEBXHZ1BO0HU3aABIGFfrkE0hrA==
X-Received: by 2002:a05:6e02:170f:: with SMTP id u15mr22900977ill.191.1639186790170;
        Fri, 10 Dec 2021 17:39:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k10sm3597313ilu.80.2021.12.10.17.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 17:39:49 -0800 (PST)
Date:   Fri, 10 Dec 2021 20:39:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 0/2] midx: prevent bitmap corruption when permuting pack
 order
Message-ID: <YbQBZX+Wo3zlOcWc@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <bf100d0c-66c7-d402-4790-9c5797e8baf3@gmail.com>
 <YbENofRtY0BPMEUd@coredump.intra.peff.net>
 <YbOeEjNic5ETGcdy@nand.local>
 <YbPVP0BvYcVsfOrf@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbPVP0BvYcVsfOrf@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 05:31:27PM -0500, Taylor Blau wrote:
> I had originally imagined that storing the preferred pack's identity
> alone would be enough to solve this bug. But that isn't quite so,
> because we break ties among duplicate objects first by prefered-ness,
> then by their pack's mtime. So that could change too, and it would cause
> us to break in the same way.
>
> At the bare minimum you need an ordering of all of the packs in the
> MIDX (like I had originally imagined here). At most, we could do
> something like what is unintentionally written here, which would allow
> us to get rid of MIDX .rev files entirely. I think doing the former is
> simpler, and I am not sure if there are practical advantages to the
> latter.

Thinking on it more, I don't think this "at minimum you would need..."
is quite right either. It would suffice to know the identity of the
preferred pack, and the mtimes of all of the other packs, since that
alone is enough to reconstruct the object order.

That is pretty appealing, too, because knowing the order of packs would
require some major surgery (the order of packs isn't really something
the MIDX code thinks about, it's inferred from the way it sorts
objects).

So here I'd imagine we'd have two chunks:

  - `PREF`: a 4-byte network order integer identifier of the preferred
    pack
  - `MTME`: an array of 4-byte network order integers containing the
    mtimes of each pack in lexical order of the pack checksums.

Unless I'm missing something, I'm pretty sure that these two would be
sufficient to uniquely identify the object order (and, importantly, to
cause the MIDX's checksum to change when the object order does).

And these are vastly easier to write down than the ordering of the packs
themselves, while also being a much more incremental step forward. So I
think I'm more comfortable with this direction than anything discussed
so far.

Thanks,
Taylor
