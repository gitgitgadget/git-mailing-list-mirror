Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11453C2BA19
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 00:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44D820936
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 00:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="NCGuF08i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391845AbgDPA5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391755AbgDPA4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 20:56:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0474C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 17:56:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a22so619926pjk.5
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 17:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OxJO5PJ++NuJw9Ls544drlDjZtdR2JIYwv/b+N5n+jo=;
        b=NCGuF08ipllyUhsMy0DiQw9d8MDotDCS9d173AvsR3qqSpDDFFhnlom4o+lIFLlDIc
         eUW/clFXYuVaANV2BK0Cq0RhsPE93AO/ZShA50hDO4xKGPErGJdgSTIey1i6WWhJcfHU
         YYdvmLkbXeH0GzgtUthLopxKyQd3AV0OHoNOakFv2vPKyY9vDgfuZXCzUilJOIdjoDTw
         1kFB1Fk59uWpWf6dKjHYEQaUswR8W14xirR481D9lubOzK+BZe/nFKBaAmu0YqUIoo1w
         w1MYVfuWSsXbK+z9gbGEzP5N/Rw9VMFt4Qoylykb5SFERTqENTxuYfHZ1Fx4K6688Wdx
         4Znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OxJO5PJ++NuJw9Ls544drlDjZtdR2JIYwv/b+N5n+jo=;
        b=KTtL4K1oux3Vo00FqDQ4Z2brAgGu78OisMFZoODqhGBuEW5aMjjmFcOyJprXQbLCBA
         XFwKJt9BYr0XdCxgLg/gkQkojysEwFFaYi6Gu11OXVTHyfhdPOuGdGCWkmTvbttEuW6K
         tpEOcHbVRtx+qwxG2SR/gUE9zM7tu/ZYejiHfUyrcht5/y7XGzNsbnBn4vjlQ4FIBOSw
         dLDyY0uRzZTYhS54nZbdTj92aZPV76xW+JyiPUu/e1rat5cdLEbWKcHO3kcF1XSTDqEg
         3W7uGbpOD/bOhamALJY2JiQjUo39X5BDzcRLuFCgJ41KXfY/0Z+4yfynuk5+mtQoKbDu
         8XZQ==
X-Gm-Message-State: AGi0PuZGTSfPF2+AjcWnuJ4hjzX45g3WUQ0AvJsv4T3RIWHe6fpwHsxA
        lP/pa69R7eTYGMoQVCQ+vfYZnQ==
X-Google-Smtp-Source: APiQypKYK8F3QzlItqIVfCk9kubLDsYM5xdwLXGPuplyzRnhe7Ar7OxKNYS2RsZaAcvi42RoX8GiXQ==
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr7835299plt.82.1586998602280;
        Wed, 15 Apr 2020 17:56:42 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id x7sm394154pfn.165.2020.04.15.17.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:56:41 -0700 (PDT)
Date:   Wed, 15 Apr 2020 18:56:40 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
Message-ID: <20200416005640.GC36156@syl.local>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
 <xmqqeesthfbf.fsf@gitster.c.googlers.com>
 <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
 <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
 <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
 <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com>
 <xmqq8siw5tlv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8siw5tlv.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 02:25:48PM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
> > THIS IS A BREAKING CHANGE. Commit-graph files with changed-path
> > Bloom filters computed by a previous commit will not be compatible
> > with the filters computed in this commit, nor will we get correct
> > results when testing across these incompatible versions. Normally,
> > this would be a completely unacceptable change, but the filters
> > have not been released and hence are still possible to update
> > before release.
>
> Sure, it hasn't even hit 'next' yet.
>
> But I think we are both sort-of leaning towards concluding that it
> does not help all that much.  So I think it is OK.

Yeah, I think that the only thing that it is potentially helping is the
:(icase) magic. In a repository that doesn't have colliding paths in
case-insensitive filesystems (i.e., having both 'foo' and 'FOO' in the
same tree), this doesn't seem to be obviously hurting anything.

But, it is at least semi-harmful to repositories that do have such
trees, since we now can't answer "probably yes" or "definitely not" for
colliding paths unless both produce the same fingerprint. That seems
like a clear downside.

Now, how common is that against people who would benefit from
changed-path Bloom filters in their commit-graphs? I don't know one way
or the other. But, the upside seems to be minimal compared to the
potential cost, so I think that it may be better to just leave this one
alone.

> > TODO: If we decide to move in this direction, then the following
> > steps should be done (and some of them should be done anyway):
>
> Even if we decide not to do this "downcase before hashing" thing, we
> should document how exactly we compute, I think.
>
> And if we decide do change our mind later, it is not the end of the
> world.  We should be able to use a different chunk type to store the
> filters computed over downcased paths.
>
> > * We need to document the Bloom filter format to specify exactly
> >   how we compute the filter data. The details should be careful
> >   enough that someone can reproduce the exact file format without
> >   looking at the C code.
> >
> > * That document would include the tolower() transformation that is
> >   being done here.
>
> As the tree-diff comparison done internally while running "git
> blame" does not take an end-user specified pathspec in any
> meaningful way, this does not matter in practice, but there is
> another possible complication we would want to consider when we
> extend the support to "git log" and friends---negative pathspecs
> (e.g. "git log ':(exclude)COPYING'").  A commit that cannot possibly
> have touched the COPYING file would be eligible for output without
> actually running tree-diff between it and its parent (as long as the
> trees of the two commits are different, we know it must be shown).
>
> Thanks.

Thanks,
Taylor
