Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1732C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 19:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjEJTwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 15:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEJTwv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 15:52:51 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9B54487
        for <git@vger.kernel.org>; Wed, 10 May 2023 12:52:50 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-618a8632655so10357916d6.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683748369; x=1686340369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XgfLiKJL1U8WBTByIRmnPCI7OS2MbI5XxZWLvcnaiM=;
        b=O5wilpnRRhJVb5AY7KP7g2vCkV8JJSRux3HmffdQQznB/lzsgtmMGYxam34EsnLqY+
         jXBd9H+DD1NG2yi85HD8TdG09GlFLLy8NDEsAzDizrUSvBrVao/d0uc99mFhb9/jsVrM
         LuedPQ/JdRkDGciOZVZdesy+BRwz6cmiUiamN7lH9PK7p7QByXj0QA/UrGjCVxYX5zWv
         t2tkUUUn2/PmBCLxEpLGE9lNNxL9U+dSlPqUZi7jEXnx90h/EF0k0n5U+wvGgPmVmxQy
         N8itRQSMLZm0DqoCYa4D1byfz7EhgmaYixbimjkNgz6VHmp9bv86nxtctG40gm8kqfc0
         CHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683748369; x=1686340369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XgfLiKJL1U8WBTByIRmnPCI7OS2MbI5XxZWLvcnaiM=;
        b=hTBr73tSxFW/WkP/U9I4WBNsqq0/O26lT1zo9nGIucLhkEBmsJu5BL9svqXIN4spxv
         bHR9dCS9fDi3fQq4nSD/DlTD7td+9pgzdjWD8us5TmJbuIyHA/u1kJyMjrSFXLe4WzGC
         +GrWZx7jnsuP9gVqLIXYKgwtKNPBtp1iDI07rtqnd2MZ2x4wtZ2T4rd2vMoY+iST+MhU
         R05htQOZwrqAXPhvWboFwUt0EGv1ub5ok+vak68S6cz1dwISm3hJda3+PX6lR7+au3/s
         CoZH/JSadoUftXXgnp29O8GdovDsPCBEwy3YRea4wtLIeJHy+hk5oGOK9bOd6rQu8XhU
         TLUw==
X-Gm-Message-State: AC+VfDyGehxL8k/V0MzkSboseFqaA0k/TPLepjKEO4eo0lCd5KjYSP6h
        fdcfn8GF1tXl9P2SDrZnSmo=
X-Google-Smtp-Source: ACHHUZ6xaCE035Cyg+WppZX0jvpAiy5nHcPxPXvGD0P8DzTQioYsrzTuyap8Bt7InV0JxjxIgctoVQ==
X-Received: by 2002:a05:6214:4108:b0:621:4549:106 with SMTP id kc8-20020a056214410800b0062145490106mr6657847qvb.2.1683748369072;
        Wed, 10 May 2023 12:52:49 -0700 (PDT)
Received: from localhost (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id nd22-20020a056214421600b0061b63237be3sm1755418qvb.131.2023.05.10.12.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 12:52:48 -0700 (PDT)
Date:   Wed, 10 May 2023 15:52:47 -0400
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 3/3] pack-refs: teach pack-refs --include option
Message-ID: <20230510195247.aj2vpzzxzdkvuzff@pop-os>
References: <pull.1501.git.git.1683215331910.gitgitgadget@gmail.com>
 <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
 <03950e8f120e48b7df68f3273bbb2f7bb1e9073d.1683659931.git.gitgitgadget@gmail.com>
 <xmqqo7mturi1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo7mturi1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/05/09 02:25PM, Junio C Hamano wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > +--include <pattern>::
> > +
> > +Pack refs based on a `glob(7)` pattern. Repetitions of this option
> > +accumulate inclusion patterns. If a ref is both included in `--include` and
> > +`--exclude`, `--exclude` takes precedence. Using `--include` does not preclude
> > +all tags from being included by default. Symbolic refs and broken refs will never
> > +be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
> > +and reset the list of patterns.
> 
> Hmph, that was a bit unexpected.  exclude taking precedence over
> include is very much in line with how negative pathspec works and
> the end-users should be familiar with it, but when the user bothers
> to specify with --include what to include, I would have expected
> that the "pack tags by default" would be defeated.
> 
> In other words, I would have expected that the program acts as if
> the machinery works this way (iow, the code does not have to exactly
> implement it this way---it just has to behave as if it did):
> 
>  - it maintains two pattern list, positive and negative,
>    both start empty.
>  - "--exclude" are accumulated to the negative list.
>  - "--include" are accumulated to the positive list.
>  - "--all" adds "*" to the positive list.
>  - after parsing command line options, if the positive list is
>    empty, then "refs/tags/*" is added to the positive list.
>  - refs that match positive list but does not match negative list
>    are shown.
> 
> > +When used with `--include`, it will use what is provided to `--include` as well
> > +as the the default of all tags and already packed refs, minus refs that are
> > +provided to `--exclude`.
> 
> IOW, I would expect that the use of "--include" alone is enough to
> defeat the default; the end user does not have to figure out that
> they have to pass "--exclude=refs/tags/*" to do so when they are
> specifying a specific hierarchy to include.

Hm yeah, I think that is a nicer user experience.

> 
> > @@ -66,6 +66,7 @@ struct worktree;
> >  struct pack_refs_opts {
> >  	unsigned int flags;
> >  	struct ref_exclusions *exclusions;
> > +	struct string_list *included_refs;
> 
> It is unfortunate that the struct is called ref_exclusions to imply
> as if it is only usable for excluding refs from listing.  It has
> other members for handling hidden refs, and it would have been very
> natural to extend it to also add included_refs pattern next to
> excluded_refs string list.  After all, the struct is used to tweak
> which refs are included and which refs are excluded, and
> historically everything was included unless listed on the excluded
> pattern.  We are now allowing the "everything is included" part to
> be customizable with this step.  If the struct were named with a
> more neutral term, like ref_visibility to hint that it is about
> setting visibility, then this patch wouldn't have added a separate
> string list to this structure---instead it would have extended the
> ref_exclusions (with a better name) struct and placed included_refs
> string list there.

Thanks for calling this out. I was thinking along very similar lines when
working on this patch, but was too lazy to make the change :)

> 
> >  };
> >  
> >  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 6a51267f379..3f8974a4a32 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -1181,6 +1181,17 @@ static int should_pack_ref(const char *refname,
> >  	    REF_WORKTREE_SHARED)
> >  		return 0;
> >  
> > +	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
> > +		return 0;
> > +
> > +	if (opts->included_refs && opts->included_refs->nr) {
> > +		struct string_list_item *item;
> > +
> > +		for_each_string_list_item(item, opts->included_refs)
> > +			if (!wildmatch(item->string, refname, 0))
> > +				return 1;
> > +	}
> 
> We can see why the initial placement of exclusion logic in the
> earlier step was suboptimal here.
> 
> >  	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
> >  	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
> >  		return 0;
> > @@ -1193,9 +1204,6 @@ static int should_pack_ref(const char *refname,
> >  	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
> >  		return 0;
> >  
> > -	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
> > -		return 0;
> > -
> >  	return 1;
> >  }
> 
> 
> Other than that, the changes look mostly expected and no surprises.
> 
> Thanks.

thanks
John
