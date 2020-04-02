Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440E8C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 23:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A41A2077D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 23:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ujot+5pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389651AbgDBXJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:09:42 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:52655 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbgDBXJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 19:09:42 -0400
Received: by mail-pl1-f201.google.com with SMTP id 64so3921075plf.19
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Pfi0LQq33wDDLYoY9eZ/VOhmJ/OgBm36C0B1ikApUHY=;
        b=Ujot+5ppjQTFhwGOAWxruG+Pq8FaZrw53Pz0oV9WMcH5k5gldQif0E7zdrXgk0d9Ne
         cVU8Se4tI3jUPa+c7nzYr0XwupAPvpC8sNqsr1cyhM3bxlJhv/5CfUs4mFDQR3d6QVQH
         vb87h6pZ2QO3oMN/UsWuxoyT1yj1mw2tCEk/I5aV6STfVSW+dnAQwY8cm5nLEa73ebdB
         FqV2RLUxruKrfmLOEGq+xstaJRxYrKrKjIWw2YUEGoux1HMmNSOSDZWBH7xf99tWvtKG
         9Xf0U9xfZOodb+997nD69acZckyFkvISWa/icaey3hYsHGPEkOg2MsqQr/ruJwyhw2b/
         r+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pfi0LQq33wDDLYoY9eZ/VOhmJ/OgBm36C0B1ikApUHY=;
        b=FoIMpMqI3MMKQsCRe0Xy13C9S3bfa40phqg+v6snqbTuQL8zCWkLRetrEUIK3vuwlf
         NNkLLQpSqUlsFL7+2/2bN5AuoeTUICm+eTNZkdTXythrBH1GfsPlt2LAwxCErdyNdCkh
         WZpoJxEYOhtqOg3sAeXdPA45Mq0A2oolFbQDVV9+XQtcqJWxReGIzqj1brBnE2CN+CMj
         Sc8brNjaGMowqgxWTS986TQukXzZvS0s0/sq5yGB0Vf9UdvgV7srNuttxK0gOz03leQb
         lvsiuz1HMZk7376CwGUCWX9ShIdMtmtplOmTrxRhb2RGpHa3m7BcF8n5YNeVviME/0P0
         aW+g==
X-Gm-Message-State: AGi0Pubk8Tvs4Sad5t0y74QoHknigdYkViH5D4IKpMuYEaImE+20RUlS
        jrq9cD+OnAfVWyTR60ZO4O1FXTVGE2/8E5Jm6gu7
X-Google-Smtp-Source: APiQypL6dPapt6m2STe928oqeRt1uvLXnDgvSDliN9G8e4rkJf+6I29kt7GlW+QszN8Gd9zdAndEHuGqgCm706CGhra5
X-Received: by 2002:a65:6250:: with SMTP id q16mr5698790pgv.9.1585868979985;
 Thu, 02 Apr 2020 16:09:39 -0700 (PDT)
Date:   Thu,  2 Apr 2020 16:09:37 -0700
In-Reply-To: <xmqq7dyx3b1o.fsf@gitster.c.googlers.com>
Message-Id: <20200402230937.47323-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq7dyx3b1o.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: Re: [PATCH v2 2/2] diff: restrict when prefetching occurs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +	int output_formats_to_prefetch = DIFF_FORMAT_DIFFSTAT |
> > +		DIFF_FORMAT_NUMSTAT |
> > +		DIFF_FORMAT_PATCH |
> > +		DIFF_FORMAT_SHORTSTAT |
> > +		DIFF_FORMAT_DIRSTAT;
> 
> Would this want to be a "const int" (or even #define), I wonder.  I
> do not care too much between the two, but leaving it as a variable
> makes me a bit nervous.

OK, will switch to "const int".

> > +	if (options->repo == the_repository && has_promisor_remote() &&
> > +	    (options->output_format & output_formats_to_prefetch ||
> > +	     (!options->found_follow && options->break_opt != -1))) {
> >  		int i;
> >  		struct diff_queue_struct *q = &diff_queued_diff;
> >  		struct oid_array to_fetch = OID_ARRAY_INIT;
> >  
> >  		for (i = 0; i < q->nr; i++) {
> >  			struct diff_filepair *p = q->queue[i];
> > -			add_if_missing(options->repo, &to_fetch, p->one);
> > -			add_if_missing(options->repo, &to_fetch, p->two);
> > +			diff_add_if_missing(options->repo, &to_fetch, p->one);
> > +			diff_add_if_missing(options->repo, &to_fetch, p->two);
> >  		}
> > +
> > +		prefetched = 1;
> > +
> 
> Wouldn't it logically make more sense to do this after calling
> promisor_remote_get_direct() and if to_fetch.nr is not 0, ...
> 
> >  		/*
> >  		 * NEEDSWORK: Consider deduplicating the OIDs sent.
> >  		 */
> >  		promisor_remote_get_direct(options->repo,
> >  					   to_fetch.oid, to_fetch.nr);
> > +
> 
> ... namely, here?
> 
> When (q->nr != 0), to_fetch.nr may not be zero, I suspect, but the
> original code before [1/2] protected against to_fetch.nr==0 case, so
> ...?

My idea is that this prefetch is a superset of what diffcore_rebase()
wants to prefetch, so if we have already done the necessary logic here
(even if nothing gets prefetched - which might be the case if we have
all objects), we do not need to do it in diffcore_rebase().

> > +	if (!prefetched) {
> > +		/*
> > +		 * At this point we know there's actual work to do: we have rename
> > +		 * destinations that didn't find an exact match, and we have potential
> > +		 * sources. So we'll have to do inexact rename detection, which
> > +		 * requires looking at the blobs.
> > +		 *
> > +		 * If we haven't already prefetched, it's worth pre-fetching
> > +		 * them as a group now.
> > +		 */
> 
> This comment makes me wonder if it would be even better to
> 
>  - prepare an empty to_fetch OID array in the caller,
> 
>  - if the output format is one of the ones that wants prefetch, add
>    object names to to_fetch in the caller, BUT not fetch there.
> 
>  - pass &to_fetch by the caller to this function, and this code here
>    may add even more objects,
> 
>  - then do the prefetch here (so a single promisor interaction will
>    grab objects the caller would have fetched before calling us and
>    the ones we want here), and then clear the to_fetch array.
> 
>  - the caller, after seeing this function returns, checks to_fetch
>    and if it is not empty, fetches (i.e. the caller prepared list of
>    objects based on the output type, we ended up not calling this
>    helper, and then finally the caller does the prefetch).
> 
> That way, the "unless we have already prefetched" logic can go, and
> we can lose one indentation level, no?

This means that the only prefetch occurs in diffcore_rename()? I don't
think this will work for 2 reasons:

 - diffcore_std() calls diffcore_break() (which also reads blobs) before
   diffcore_rename()
 - (more importantly) there's a code path in diffcore_std() that does
   not call diffcore_rename(), so we would still need some prefetching
   logic in diffcore_std() in case diffcore_rename() is not called

> > +		if (to_fetch.nr)
> > +			promisor_remote_get_direct(options->repo,
> > +						   to_fetch.oid, to_fetch.nr);
> 
> You no longer need the if(), no?

Ah...I'll remove the if().
