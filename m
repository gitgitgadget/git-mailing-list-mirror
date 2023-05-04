Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F6EC77B73
	for <git@archiver.kernel.org>; Thu,  4 May 2023 21:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjEDV0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 17:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDV0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 17:26:51 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D441E1737
        for <git@vger.kernel.org>; Thu,  4 May 2023 14:26:49 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3ef4aa5e8a4so1636981cf.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683235609; x=1685827609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lbWJhTN6TFA0U8l7O/eWV6vZMxqjVVnW5Rc4Uib8Fmc=;
        b=K5r1tksLY9mf3cnhCECBcgZLf7pnX/j/2tVPIav8yWvMk751/LC/7TZ/yFrMb4sw0n
         VjVyH1FQ12tbE2he74ZSkTtlWUk9bAbg2jXLMX8p71zaEw+hTK3PuJEb/jXlL3RzD7ld
         wyzJl1Uh8azPR4IxYxKf5nknRlnTjrMhkmtpYhnV2+2MawRCa7jhpm6CV2l/2ltzrIwM
         4oNMQyYcprfCgePPY/dgEXk5csyHw1j6epS8Mf1KMpjvz/+FpQNjPYBpLnRtOFMq6HkV
         Hk112VAexYd5fqsCtdfM7YXESOQxLzhDiSPCQvL2+tRxyMdQEO/J4k2lXT4D0PpPME/z
         PtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683235609; x=1685827609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbWJhTN6TFA0U8l7O/eWV6vZMxqjVVnW5Rc4Uib8Fmc=;
        b=iLw01nS9DaA0YdddTwkWh347W00DWvTTKlnvTs+R9F+Drp/bbmfUawNnEnGNBZwep5
         EKSBczbEHx/2m0O0bDKijd+vPY/ZL2KTWlTokhs06yKqMBUNi2T4dJieQ8CizixMRzX0
         g1PhytVRlz20YXNTkYSFclxdQat2E3BuYeAd0LU0FmVjz9yKmdyPpQWXcR0d6ypbpgpU
         qNB0gHi4USCrQqC2lMh1fs+sQRTXuknuDZUQritsTuVxQ6sLnreuXAc1UcUbmFUB9Nyq
         +xt7C1Wun3s+Y+EGD05UfWHk/ipK12kd53tbMrRm3x43y8XCVdFghX2GTtqK6NwavrSF
         zSkQ==
X-Gm-Message-State: AC+VfDyHRP+hN5eqOQacS6O8c4qR4z4WgKPybcUDu7yf5a0QYC8tSk6s
        D0ygcXIMR2ib20qDYpImWzw=
X-Google-Smtp-Source: ACHHUZ4KqefvTbOofEwOYEp+JkxJc6Bv7oe4bF6h4Sx5Kar6cBn+iK6o/CRtV5ZdpkAzkhEfe0xgEw==
X-Received: by 2002:a05:622a:30d:b0:3ef:4a8e:cb84 with SMTP id q13-20020a05622a030d00b003ef4a8ecb84mr34635791qtw.2.1683235608828;
        Thu, 04 May 2023 14:26:48 -0700 (PDT)
Received: from localhost (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id c1-20020ac81e81000000b003e97fe68511sm15822qtm.3.2023.05.04.14.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:26:48 -0700 (PDT)
Date:   Thu, 4 May 2023 17:26:47 -0400
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <jcai@gitlab.com>
Subject: Re: [PATCH] pack-refs: teach --exclude option to exclude refs from
 being packed
Message-ID: <20230504212647.hdozs6sxewry2hay@pop-os>
References: <pull.1501.git.git.1683215331910.gitgitgadget@gmail.com>
 <xmqq4joskpom.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4joskpom.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/05/04 09:48AM, Junio C Hamano wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>

Hi Junio,

> > From: John Cai <jcai@gitlab.com>
> >
> > Currently once refs are packed into a pack-refs file, deleting them can be
> > slow since it involves a full file scan of the entire pack-refs file. At
> 
> "pack-refs" -> "packed-refs".
> 
> But performing a full file scan of 100MB file would take how many
> milliseconds?  Having to remove many refs from a single packed-refs
> file would be costly if it is done one-by-one, though.  I wonder how
> effective our batched update mechanism is these days...
> 
> Sorry for straying to a tangent.  In any case, I do not think the
> first sentence is necessary; just start it with "At GitLab, ..." to
> say that you have a need to be more selective than "is it a tag or
> not?" to choose refs to be and not to be packed.  The reason why we
> may want to leave a ref loose is not limited to ref deletion
> performance, and the benefit of this new feature is not limited to
> it, either.

Good point

> 
> > GitLab, we have a system that creates ephemeral internal refs that don't
> > live long before getting deleted. Having an option to not include certain
> > refs from a pack-refs file allows these internal references to be deleted
> > much more efficiently.
> 
> I think that is a valid use case.
> 
> If we step back a bit, we can see "pack-refs" has an option "--all"
> that was added by b3d4204f (git-pack-refs --all, 2006-10-08), to
> allow us pack only tags by default, because packing branches that
> are meant to be updated often and also removed more often than tags
> were found to be detrimental.  We can view this new option a
> follow-up work for the commit, to allow the users to define what to
> be and what not to be packed, depending on their workflow.
> 
> This observation also makes us realize that we should consider the
> opposite.  It would benefit us to include some refs that we normally
> do not pack and be more selective than "--all" ("--exclude" proposed
> here is a way to leave some refs that we normally pack and be more
> selective than not running pack-refs at all).  A set of branches
> that are only occasionally used may want to be packed while the rest
> of branches want to be left loose because they are more active, or
> something.

Yeah, that's a good observation. It would be nice to add an --include option to
give the user full flexibility of which refs to include.

> 
> > Add an --exclude option to the pack-refs builtin, and use the ref
> > exclusions API to exclude certain refs from being packed into the final
> > pack-refs file
> 
> "pack-refs" appears here, too.
> 
> >  Documentation/git-pack-refs.txt |  8 +++++++-
> >  builtin/pack-refs.c             | 17 +++++++++++++++--
> >  refs.c                          |  4 ++--
> >  refs.h                          |  6 +++++-
> >  refs/debug.c                    |  4 ++--
> >  refs/files-backend.c            | 13 ++++++++++---
> >  refs/packed-backend.c           |  3 ++-
> >  refs/refs-internal.h            |  4 +++-
> >  t/helper/test-ref-store.c       |  3 ++-
> >  t/t3210-pack-refs.sh            | 18 ++++++++++++++++++
> >  10 files changed, 66 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
> > index 154081f2de2..d80e0a1562d 100644
> > --- a/Documentation/git-pack-refs.txt
> > +++ b/Documentation/git-pack-refs.txt
> > @@ -8,7 +8,7 @@ git-pack-refs - Pack heads and tags for efficient repository access
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git pack-refs' [--all] [--no-prune]
> > +'git pack-refs' [--all] [--no-prune] [--exclude <pattern>]
> >  
> >  DESCRIPTION
> >  -----------
> > @@ -59,6 +59,12 @@ a repository with many branches of historical interests.
> >  The command usually removes loose refs under `$GIT_DIR/refs`
> >  hierarchy after packing them.  This option tells it not to.
> >  
> > +--exclude <pattern>::
> > +
> > +Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
> > +accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
> > +patterns.
> 
> The interaction of this option with "--all" needs to be described
> somewhere.  If we are to be adding "--include" for completeness,
> that one also needs to interact with "--all".

Sounds good

> 
> > diff --git a/refs.c b/refs.c
> > index d2a98e1c21f..637810347a0 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2132,9 +2132,9 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
> >  }
> >  
> >  /* backend functions */
> > -int refs_pack_refs(struct ref_store *refs, unsigned int flags)
> > +int refs_pack_refs(struct ref_store *refs, unsigned int flags, struct pack_refs_opts *pack_opts)
> >  {
> > -	return refs->be->pack_refs(refs, flags);
> > +	return refs->be->pack_refs(refs, flags, pack_opts);
> 
> That's a curious choice of the API.  It is not like backend methods
> all share the same "flags" bitset (they share "refs" pointer to the
> ref_store), so I would have expected that it would become part of
> the pack_refs_opts structure.  Do not call the parameter pack_opts;
> either spell it out as "pack_refs_opts", or just use "opts".  The
> latter is probably more preferrable as I do not expect it to be
> ambiguous with other kinds of "opts".

I didn't notice this, but it makes sense. We can move flags into the
pack_refs_opts struct.

> 
> The rest of the pack I found nothing unexpected or surprising.

thanks
John
