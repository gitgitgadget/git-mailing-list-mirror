Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047D3C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD1D61250
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344949AbhIXR63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344123AbhIXR62 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 13:58:28 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F445C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:56:55 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h3-20020a170902704300b0013dbfc88e14so3620460plt.13
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zesoqfiJ/XbMpiCCNKgthbka6FHUiuBERBbQsdMfKTM=;
        b=RA91smK+Nd4Ej/hi/4GLGLan7VYK790XMFtEgh5Unzo6a1Pmi8O4N700wGjp5oCIxi
         KY+8/s5vKTJUncfEr/YKP/Nf1q90YVkMe2kij9uijd6Am+zYQA4JBovctvEnTMAGkorw
         ScUhOJoo5m3e6dFVxmpgqp3rGdl63xhAdYpQWslxbxumiyU9xiLcaFDagQcUOaiHmRe2
         Yu2k+KsM/V+gDUcfWtyErMtVrgNOgH3EhZ6ZuLhUiLLWLaf8Pbw65eJknaWv6tQsJaPo
         nYtUHZzoBFjfk/xbdxgCPpD0otgS+EuSvpvOJjep4nV6gN1Q72+z9fi+LS8AxaE7wuRa
         c1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zesoqfiJ/XbMpiCCNKgthbka6FHUiuBERBbQsdMfKTM=;
        b=JIyRIVMfCg3V7r8NvTeLNnZM7oUoCDru/ff/pvfg43DdLPyOK4D16jNsklN6CnCqg1
         THxsoeiPID/aBCkDd6pNKk2F+8+rYfZtYdiv6O1yG1kYNd+bPfOIMZr+lPP7S7Kw6t5P
         S0MaHFGdwV3sOjCCz2b+BEDHocwrrGnrecM4a+7q+U3lQRhgrc3wza5ObigPmFl5jIsi
         xe+fKeX0H42ldR8D76GGMPfQ66HbCLONR9CklqHINGt1J3FeTh+L5j6wWrLsIevgyB4G
         Ks3J6hgNJ3hfgCIdmVvhjPQWJozbXCbf63BgBKPsOhJizKybfo054hwlaCnmTUw+Zkid
         NHaw==
X-Gm-Message-State: AOAM530Kv505SHP8TLxv5AaxJP3R1E6Ct3dY/VAqjbRMK01mA1CNU011
        fVR6RLX4fiO66BfGn/Rhy/6f1k2gu/YIbsnjvNaP
X-Google-Smtp-Source: ABdhPJwcZtkPzCyUAXpLF5YWc6QXuXohVYx9QfXHgcIVjCgxUqVAlSwfU78Tsnot/n8jijVpDPTbcbmKTs1cWlmN1DZO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:1252:b0:13d:f3f6:2e1c with
 SMTP id u18-20020a170903125200b0013df3f62e1cmr2346309plh.73.1632506214736;
 Fri, 24 Sep 2021 10:56:54 -0700 (PDT)
Date:   Fri, 24 Sep 2021 10:56:51 -0700
In-Reply-To: <xmqq1r5g3y2j.fsf@gitster.g>
Message-Id: <20210924175651.2918488-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq1r5g3y2j.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: Re: [PATCH 1/9] refs: make _advance() check struct repo, not flag
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > As a first step in resolving both these problems, replace the
> > DO_FOR_EACH_INCLUDE_BROKEN flag with a struct repository pointer. This
> > commit is a mechanical conversion - whenever DO_FOR_EACH_INCLUDE_BROKEN
> > is set, a NULL repository (representing access to no object store) is
> > used instead, and whenever DO_FOR_EACH_INCLUDE_BROKEN is unset, a
> > non-NULL repository (representing access to that repository's object
> > store) is used instead.
> 
> Hmph, so the lack of "include broken" is a signal to validate the
> object the ref points at, and the new parameter is "if this pointer
> is not NULL, then expect to find the object in this repository and
> validate it" that replaces the original "validate it" with a bit
> more detailed instruction (i.e. "how to validate--use the object
> store associated to this repository")?

Yes.

> > @@ -1442,13 +1442,16 @@ struct ref_iterator *refs_ref_iterator_begin(
> >   * Call fn for each reference in the specified submodule for which the
> >   * refname begins with prefix. If trim is non-zero, then trim that
> >   * many characters off the beginning of each refname before passing
> > - * the refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to
> > - * include broken references in the iteration. If fn ever returns a
> > + * the refname to fn. If fn ever returns a
> >   * non-zero value, stop the iteration and return that value;
> >   * otherwise, return 0.
> > + *
> > + * See the documentation of refs_ref_iterator_begin() for more information on
> > + * the repo parameter.
> >   */
> >  static int do_for_each_repo_ref(struct repository *r, const char *prefix,
> > -				each_repo_ref_fn fn, int trim, int flags,
> > +				each_repo_ref_fn fn, int trim,
> > +				struct repository *repo, int flags,
> >  				void *cb_data)
> 
> Confusing.  We are iterating refs that exists in the repository "r",
> right?  Why do we need to have an extra "repo" parameter?  Can they
> ever diverge (beyond repo could be NULL to signal now-lost "include
> broken" bit wanted to convey)?  It's not like a valid caller can
> pass the superproject in 'r' and a submodule in 'repo', right?
> 
> Enhancing an interface this way, and allowing an arbitrary
> repository instance to be passed only to convey one bit of
> information, by adding a "repo" smells like inviting bugs in the
> future.
> 
> I have a feeling that the function signature for this one should
> stay as before, and "repo" should be a local variable that is
> initialized as
> 
> 	struct repository *repo = (flags & DO_FOR_EACH_INCLUDE_BROKEN)
> 				? r
> 				: NULL;
> 
> to avoid such a future bug, but given that there is only one caller
> to this helper, I do not mind
> 
> 	if (repo && r != repo)
> 		BUG(...);
> 
> to catch any such mistake.

(see next answer)

> >  int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
> >  {
> >  	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
> >  				    strlen(git_replace_ref_base),
> > -				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
> > +				    NULL, 0, cb_data);
> >  }
> 
> And this is the only such caller, if I am reading the code right.
> 
> Do we ever pass non-NULL "repo" to do_for_each_repo_ref() in future
> steps?
> 
> If not, perhaps we do not even have to add "repo" as a new parameter
> to do_for_each_repo_ref(), and instead always pass NULL down to
> refs_ref_iterator_begin() from do_for_each_repo_ref()?

do_for_each_repo_ref() does not gain future callers in future steps (so
we never pass non-NULL "repo"). I'll do this (and add a comment to
do_for_each_repo_ref() explaining that we do not check for broken refs).

> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 677b7e4cdd..cd145301d0 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -744,12 +744,6 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
> >  		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
> >  			continue;
> >  
> > -		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
> > -		    !ref_resolves_to_object(iter->iter0->refname,
> > -					    iter->iter0->oid,
> > -					    iter->iter0->flags))
> > -			continue;
> > -
> >  		iter->base.refname = iter->iter0->refname;
> >  		iter->base.oid = iter->iter0->oid;
> >  		iter->base.flags = iter->iter0->flags;
> > @@ -801,9 +795,6 @@ static struct ref_iterator *files_ref_iterator_begin(
> >  	struct ref_iterator *ref_iterator;
> >  	unsigned int required_flags = REF_STORE_READ;
> >  
> > -	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
> > -		required_flags |= REF_STORE_ODB;
> > -
> >  	refs = files_downcast(ref_store, required_flags, "ref_iterator_begin");
> >  
> >  	/*
> 
> Hmph, I am not sure where the lossage in these two hunks are
> compensated.  Perhaps in the backend independent layer in
> refs/iterator.c?  Let's read on.

Yes - the first hunk is compensated in the backend independent layer,
and the second hunk was there to ensure that the first hunk would work
(and since the first hunk is removed, the second hunk no longer needs to
be there). I'll add a note in the commit message.

> > @@ -10,7 +10,23 @@
> >  
> >  int ref_iterator_advance(struct ref_iterator *ref_iterator)
> >  {
> > -	return ref_iterator->vtable->advance(ref_iterator);
> > +	int ok;
> > +
> > +	if (ref_iterator->repo && ref_iterator->repo != the_repository)
> 
> OK. refs_ref_interator_begin() assigned the "repo" parameter that
> tells which repository to consult to validate the objects at the tip
> of refs to the .repo member of the iterator object, and we check it
> here.
> 
> It is a bit surprising that ref_iterator does not know which
> repository it is working in (regardless of "include broken" bit).
> Do you think it will stay that way?  I have this nagging feeling
> that it won't, and having "struct repository *repository" pointer
> that always points at the repository the ref-store belongs to in a
> ref_iterator instance would become necessary in the longer run.

I think it's better if it stays that way, so that callers that don't
want to access the ODB (all the callers that currently use
DO_FOR_EACH_INCLUDE_BROKEN) can be assured that the iterator won't do
that. If we had a non-NULL "struct repository *repository" parameter, a
future code change might inadvertently use it, thus causing a bug.

Right now I think that this is possible, since the only other thing that
accesses the ODB is peeling, and that is handled by the next patch
(patch 2/9). If we think that it won't stay that way in the future,
though, then I agree with you.

> In which case, this .repo member this patch adds would become a big
> problem, no?  If we were to validate objects at the tip of the refs
> against object store, we will always use the object store that
> belongs to the iterator->repository, so the only valid states for
> iterator->repo are either NULL or iterator->repository.  That again
> is the same problem I pointed out already about the parameter the
> do_for_each_repo_ref() helper that is inviting future bugs, it seems
> to me.  Wouldn't it make more sense to add
> 
>  * iterator->repository that points at the repository in which we
>    are iterating the refs
> 
>  * a bit in iterator that chooses between "do not bother checking"
>    and "do check the tip of refs against the object store of
>    iterator->repository
> 
> to avoid such a mess?  Perhaps we already have such a bit in the
> flags word in the ref_iterator but I didn't check.

If we need iterator->repository, then I agree with you. The bit could
then be DO_FOR_EACH_INCLUDE_BROKEN (which currently exists, and which I
am removing in this patch, but if we think we should keep it, then we
should keep it).

Having said all that, it may be better to have a non-NULL repository
reference in the iterator and retain DO_FOR_EACH_INCLUDE_BROKEN - at the
very least, this is a more gradual change and still leaves open the
possibility of turning the repository reference into a nullable one.
Callers that use DO_FOR_EACH_INCLUDE_BROKEN will have to deal with an
API that is unclear about what is being done with the repository object
being passed in, but that is the same as the status quo. I'll try it and
see how it goes (it will probably simplify patch 2 too).
