Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7A4C433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 21:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B2720758
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 21:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="iSvBUBwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIBVCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 17:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBVCS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 17:02:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B975C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 14:02:16 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w16so1105483qkj.7
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LdLSCzypjzurf/EsyD/rz2UHOk5M4ZsFpPFpQwrp4Lk=;
        b=iSvBUBwEtLP5KY5zO9ravdEj8VR1PRWDpmMrcN/BbHr7Ko77gzI8B9wYRq3AzoOy5Q
         14GC6ZRj/lKzVVNingUTHoO/i6Gk3ahlrZFK2N2H1umUHM6UpaAicW/vCEtAcgzCM44+
         7sAwoTGKVHJIsC4/66WBkxCBEW221k33QowWsT9+tUSr0f8uR/85cIN5QnYHaj3VY5SZ
         dLUCtRPF8T7mvCLwEqV2BJx0xCj3I5lkqlQWDks1nbnjadtbhvbxQ6+/pIUqXThOl0q/
         u0Nl0uJp7fXOR8j6zP23zxzrfxLs+a3q037YOEa3mdhQeATFuNt3CRs0PWO5n9ZKVFqs
         kBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LdLSCzypjzurf/EsyD/rz2UHOk5M4ZsFpPFpQwrp4Lk=;
        b=SK5kli97HXz6dCNwYyN7NwImJCPkUKJ4DgKsituL/DR8DIBTeruJ1nLmJslwqb8jQM
         EQ3jtrKR5MxsrhFatA8a8Ae8EB5noQzBpnzlXAjqJUwwKrRSfgmoqxvmslXhSUIaYVdr
         NDCsnVf0Tz0WcgTjvQFhQoBpW6o5Nw8Uwtm+l6MGIhpzQne7HZ8gudQfDHu8bfzkXuRw
         P/r4ewhfRVVLElayiDulL/sCHB2C7KTsMUAamMXslyPXTRcdj3UoM/MyjaJnj2z4zFtp
         k0Yk6wybp+PEajZUmXKipcwHpDK11uVmhyxF+/djnD3VCZlUU7/h0uAjZ8ATAFTvGHDO
         sKDA==
X-Gm-Message-State: AOAM530vkhIJWUre4pa6Y+98pNpToACXkKe295GA9/SgOIMHO9SD428+
        +aWjisdBB7kEDy3DDhPBQgCY1w==
X-Google-Smtp-Source: ABdhPJzil40vc/7op6Qq5tBrELb/uuudXtue9WkUkEbhFVYNghH8El55cYNBb3MBmy5TZtSxQDJN1A==
X-Received: by 2002:a37:d95:: with SMTP id 143mr8937791qkn.224.1599080536032;
        Wed, 02 Sep 2020 14:02:16 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:945e:14e0:5690:8262])
        by smtp.gmail.com with ESMTPSA id m196sm581686qke.87.2020.09.02.14.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 14:02:15 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:02:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 13/14] commit-graph: rename 'split_commit_graph_opts'
Message-ID: <20200902210212.GC5281@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <b2e33ecba880f4b49af7a94fb0decb08929dff36.1597178915.git.me@ttaylorr.com>
 <20200819095656.GD29528@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819095656.GD29528@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 19, 2020 at 11:56:56AM +0200, SZEDER Gábor wrote:
> On Tue, Aug 11, 2020 at 04:52:11PM -0400, Taylor Blau wrote:
> > In the subsequent commit, additional options will be added to the
> > commit-graph API which have nothing to do with splitting.
> >
> > Rename the 'split_commit_graph_opts' structure to the more-generic
> > 'commit_graph_opts' to encompass both.
>
> Good.  Note, however, that write_commit_graph() has a 'flags'
> parameter as well, and when a feature is enabled via this 'flags',
> then first a corresponding 'ctx->foo' field is set, and that
> 'ctx->foo' is checked while computing and writing the commit-graph.
> With the generic options struct some other feature will be enabled via
> the 'opts->bar' field, so simply 'ctx->opts->bar' is checked while
> writing the commit-graph.
>
> With the generic options struct there really is no need for a separate
> flags parameter, the values in the flags can be stored in the options
> struct, and we can eliminate this inconsistency instead of adding even
> more.

I like the direction that you're headed in, but I'm not entirely sure
what you're suggesting. Do you want to make the
'enum commit_graph_write_flags flags' part of the new options struct?
Break out the fields into individual bits on that struct?

I'm not opposed to either, but note that there is also already a 'flags'
field on the options structure related to splitting, so that would have
to be untangled, too.

What I'm trying to say is that I think there's more complexity here than
you're giving it credit for. I'd rather press on with what we have here,
and devote adequate time to unraveling the complexity appropriately than
try to shove in another patch that takes a half-step in the right
direction.

>
> > diff --git a/commit-graph.h b/commit-graph.h
> > index ddbca1b59d..af08c4505d 100644
> > --- a/commit-graph.h
> > +++ b/commit-graph.h
> > @@ -109,7 +109,7 @@ enum commit_graph_split_flags {
> >  	COMMIT_GRAPH_SPLIT_REPLACE          = 2
> >  };
> >
> > -struct split_commit_graph_opts {
> > +struct commit_graph_opts {
> >  	int size_multiple;
> >  	int max_commits;
> >  	timestamp_t expire_time;
>         enum commit_graph_split_flags flags;
>
> While this was 'struct split_commit_graph_opts *split_opts' it was
> clear what kind of flags were in this 'flags' field.  Now that the
> struct is generic it's not clear anymore, so perhaps it should be
> renamed as well (e.g. 'split_flags'), or even turned into a couple of
> bit fields.

This I can definitely vouch for, so I'll 's/flags/split_flags' in the
next revision.

Thanks,
Taylor
