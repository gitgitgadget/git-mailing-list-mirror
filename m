Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E403C001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 00:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjHCABU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 20:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHCABS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 20:01:18 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAEE30D2
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 17:01:17 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-57026f4bccaso2806077b3.2
        for <git@vger.kernel.org>; Wed, 02 Aug 2023 17:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691020876; x=1691625676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=prDyGXE7omC+0BysTEtf+Ij/+DKKIcRhv682gcX8ODg=;
        b=bbrglW8AonHvku0wSS6bRk0gll4+RRFl792Nx8CZbeZ31sE2npPC5oFCH9tjPz2WpD
         b3gY5tHdH97mjp7CR6LkyIPY2+xjhAKqU8iefSJh0WutCQKvBm4FqL6NXB1703n00pLg
         iAy+a1zRiX17H0wvmI+7Z054/TAWgMzeeQwK3VQ5aw2kVrXDR87MZhuEQUXFX+ZRtV4W
         79bxJPw9t3JC0LDtF8uCriMY1xpkOL8jiNXLjt9WvOqUnsiRj3/7nZJZ+QK2Z8X7yYdL
         4JUH2G9uqFpaA2uH+A0LM/4VVTrNwSbSmMjvma8SU4SXxjqG60d+dy/BHpvCyzX87Tju
         tW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691020876; x=1691625676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prDyGXE7omC+0BysTEtf+Ij/+DKKIcRhv682gcX8ODg=;
        b=Qr5frc75Uz8xK9W14M2mydBJ2zqlPh8FgCpbER5+vkCPPmc5CRUfbS3we/OB6l2J1m
         I5elaR24CkbAzC3UKlVm+DNft/1fDikcpQCR8twcZ6EjMyBipQ+4XEk/fEpPlzEGFPhj
         0IbjB0Vk2LasBzH7qt3qjzpzBrxYE3iM/9CKzNK7g+nE9SuYOOUrIbxpSkamUZivzvUS
         5W3sCEH/akvO/QKPkibaws9fui6X02nwchW5dODc0otNNf+E1t8x0yxo+n1Bkf738Md0
         cDmZnndj0X1hGSjd1ZR0w2z3rx8Rkxf6iZ/MYLT4kDT/gpcsWAi3dhWR5HvQW3vIK68Y
         iVFg==
X-Gm-Message-State: ABy/qLZe+hO5qN/3vVaLa52r9oHqjqGcHNbxD9sWdICPLQVI1qmEcJqn
        2nPASWgpvlf/y4H6gDr14QDRuHYdrvfyOXshSwt0Zg==
X-Google-Smtp-Source: APBJJlH2RIkCv80qC3nx/VoFlQVqlejMDv+GWXJfgtiqYG0WwQ9jWINmPX82SnvkwMVm33Zxog1I8g==
X-Received: by 2002:a81:844a:0:b0:577:3cd0:384 with SMTP id u71-20020a81844a000000b005773cd00384mr17207389ywf.15.1691020876648;
        Wed, 02 Aug 2023 17:01:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j2-20020a25d202000000b00babcd913630sm4212065ybg.3.2023.08.02.17.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:01:15 -0700 (PDT)
Date:   Wed, 2 Aug 2023 20:01:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
Message-ID: <ZMruSSAGQWS8crvi@nand.local>
References: <ZMKvsObx+uaKA8zF@nand.local>
 <20230727205308.401364-1-jonathantanmy@google.com>
 <ZMlKMmAs3wKULAOd@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMlKMmAs3wKULAOd@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 01, 2023 at 02:08:50PM -0400, Taylor Blau wrote:
> On Thu, Jul 27, 2023 at 01:53:08PM -0700, Jonathan Tan wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> > > > The intention in the current patch set was to not load it at all when we
> > > > have incompatible Bloom settings because it appeared quite troublesome
> > > > to notate which Bloom filter in memory is of which version. If we want
> > > > to copy forward existing results, we can change that, but I don't know
> > > > whether it's worth doing that (and if we think it's worth doing, this
> > > > should probably go in another patch set).
> > >
> > > Yeah, I think having Bloom filters accessible from a commit-graph
> > > regardless of whether or not it matches our Bloom filter version is
> > > prerequisite to being able to implement something like this.
> > >
> > > I feel like this is important enough to do in the same patch set, or the
> > > same release to avoid surprising operators when their commit-graph write
> > > suddenly recomputes all of its Bloom filters.
> >
> > Suddenly reading many (or most) of the repo's trees would be a similar
> > surprise, right?
>
> That's a good point. I think in general I'd expect Git to avoid
> recomputing Bloom filters where that work can be avoided, if the work in
> order to detect whether or not we need to recompute a filter is cheap
> enough to carry out.

I spent some time implementing this (patches are available in the branch
'tb/path-filter-fix-upgrade' from my fork). Handling incompatible Bloom
filter versions is kind of tricky, but do-able without having to
implement too much on top of what's already there.

But I don't think that it's enough to say that we can reuse a commit's
Bloom filter iff that commit's tree has no paths with characters >=
0x80. Suppose we have such a tree, whose Bloom filter we believe to be
reusable. If its first parent *does* have such a path, then that path
would appear as a deletion relative to its first parent. So that path
*would* be in the filter, meaning that it isn't reusable.

So I think the revised condition is something like: a commit's Bloom
filter is reusable when there are no paths with characters >= 0x80 in
a tree-diff against its first parent. I think that ensuring that there
are no such paths in both a commit's root tree, as well as its first
parent's root tree is equivalent, since that removes the possibility of
such a path showing up in its tree-diff.

As long as we aren't generating a commit-graph with --stdin-packs, then
we process commits in generation order, so we will see parents before
their children. I think we could reuse existing filters in that case,
but the condition is slightly more complex than I originally thought.

Thanks,
Taylor
