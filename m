Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECE6C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A868620870
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Zrf4BW+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD3T3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgD3T3e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:29:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EBCC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:29:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id y6so1224928pjc.4
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LL0VqXuH9/XxICaNoDLb6G50LZS9H73qooUxv9wvHk4=;
        b=Zrf4BW+MkISkER6WDeRaBZjnE+2IjRXtRRjcM4OPh3nDC6rP1WfsMv4uJ54gelUMlr
         Z/+TMq0QcmBt+ymdyWGcHH6PUnb50/bm6dwA3i0+XrJxIrRfT+c5UOS4vdHQelgU/nWo
         r6HqBhCKGl7imDTXZYPkRXhysayBNxmYvPaUOcHnAJyIQdEvkI7sl1EwG8IZJ9/51v1g
         UVY3fAQ6PY5z+YJH/XUsHQzwv2QMKp2aC616wzACJn6mACqvzOqoBDYEvPl0dNgwK+LW
         98o3itBqy3hk7pkmrKq1Z2XgFDB8bmhZtwrKpRT7EayxrstZtGl0y2meKyfqhzMwEtUY
         hRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LL0VqXuH9/XxICaNoDLb6G50LZS9H73qooUxv9wvHk4=;
        b=bmXiaFgHaDIlu3sBym6yn1XdxBla7GHZPJ5QkYiI7Gofp0pdAxOa0JGsWVZX6l2ozu
         33FJPY5hk8RPUkK9uTwy8/zAwHDD0YmrgiJWXQ0+qhocVSe4qpfup/UjRxmiepCoM2qI
         caXL+SwznjTcEmNc//7CgibbbBIy3rohgJVogBZkphmMrvSsh3LmvlcR0tdnQxUCIjAc
         6XDZtNW5hQ4PtmX5n9beR1j9zAkPcj5X81Cjmzj74W60zmzbYiw36DdsJhvEfNJQ2c7s
         XkE+INOS8gOy3S8JWXiU9xvhPQ5tARFSzj4bCZvcbrf27gf4JY7rss1hvVJGOz4aK+aC
         SVag==
X-Gm-Message-State: AGi0Pub9JSuoqEhBm7R0bPYjziWcxF40HdgW0yBcBjOodHl4S+bcOEtb
        4R97T8uqI7oxgvXPxD13lUOxvw==
X-Google-Smtp-Source: APiQypLajHNMbpeu0eqM+2nc9gPI8+j4elFZqRatGbv1meMo82lRa+BiNc0olDE8L7aZJnWEh+4K0A==
X-Received: by 2002:a17:90a:2526:: with SMTP id j35mr404038pje.98.1588274973524;
        Thu, 30 Apr 2020 12:29:33 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id n9sm487844pjt.29.2020.04.30.12.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:29:32 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:29:31 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH 3/5] commit: move 'unregister_shallow' to 'shallow.h'
Message-ID: <20200430192931.GB6280@syl.local>
References: <cover.1588199705.git.me@ttaylorr.com>
 <65ecfeaba56807926fbe532f94921c98298e50d5.1588199705.git.me@ttaylorr.com>
 <20200430031350.GD115238@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430031350.GD115238@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 08:13:50PM -0700, Jonathan Nieder wrote:
> Taylor Blau wrote:
>
> > In the last commit, we introduced a header for the functions defined in
> > 'shallow.c'. There is one remaining shallow-related function in
> > commit.c which should be moved, too. This patch moves that function.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  commit.c  | 13 -------------
> >  shallow.c | 13 +++++++++++++
> >  shallow.h |  1 +
> >  3 files changed, 14 insertions(+), 13 deletions(-)
>
> Yes, an obviously good thing to do.
>
> Perhaps could be squashed with patch 1 (but also see my review of that
> one).

Do you mean patch 2/5? If so, I think that it probably makes more sense
to go there than in the first patch.

(I originally thought that it would be useful for people reading the
diff to have this change broken out into its own patch, but I think that
it's more juggling to do in terms of figuring out which headers to
include than is worth.)

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Should this take a "struct repository" parameter?

Probably, but I'd rather leave this series to be just focused on moving
this code around while being minimally invasive.

Thanks,
Taylor
