Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9260C4743C
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 02:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6C0613D2
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 02:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFECSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 22:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFECSF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 22:18:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547BAC061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 19:16:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v63-20020a2561420000b029053606377441so14317467ybb.15
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 19:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S2N3zgpB4vNiEYhpDKyymRXJNFlsOO0hr5ihbhirKsA=;
        b=uxeCkwQkARbUasOljzRM+ulnMXMo4ywbb/yjVHqrmlqhzI1K5DCMV5pnkXZD0SQ741
         iZIhueNn9M95CKXcuSVgy/yXXDAP9+jmlCrv/kjUm+OEMeBtlIj5mxuXREoYm7D7KVYb
         XrmxV8rTedn2DwGdnFhODLeGKH4mwZH7pKfpnO5gigXP2BgaLQXJratSOLgkpTtpVL6S
         oTwTEWwkwtXb8u5m/MzmtDgbL8YH0isbi7oxatE3QDW1Vl8nj0n2UO3KmXTizIQsFGPR
         lNqr86hFxztIjZBdLtfRxNVI4K0qoeLd/26VnqaJ1+DK4LyUN9CDKZgUZRxCtsHC2O74
         25Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S2N3zgpB4vNiEYhpDKyymRXJNFlsOO0hr5ihbhirKsA=;
        b=P6Gb6NIcvHn8fr3RSYtqfwHT1QzQ6faqBnemfFY+ecgpJsGsbQxxbZVLh7Qx0HxsPG
         D9MWtEfb56F7j4aeo4GbZRGpI3yPNlon8Hn8SRaLnlkAKA2dhD3jjPS+1xWULBm5BkBy
         IhcdZmXsKb5hiobDjPTqM/HlVFP/D3K2u8agDAYtPQ32s6ck4HgIgAm6XP38u1/N6xFh
         G7CsTo6MsPOggwsq9z77EY6x4rY45znuP29P2p2Aju1urllD8b8YIzmgOZGa2T/9PNNp
         0NdGtAY6t1auinvjqi2eUQG6QSZhvCA7P/Un0acBFFWjWGL0JHS/77Om4GZtexPjqvah
         Dthg==
X-Gm-Message-State: AOAM532xB/nG72rFGhmOSaymA+J2fCdAruu+RSIdpEijshL5Qv19M3lF
        F0mp0cqkJ+Ac+20v6ON5VVI+Fc5YPzsIAIl4SPrB
X-Google-Smtp-Source: ABdhPJweU9aWPwvRZ2hTv4LKRvnKit4RdW+MWKyO+d1uN7XSD+SvyR0oObsHIUtB6pb7/LsM96f1QxHyEDI3tXOegCtQ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:bbd1:: with SMTP id
 c17mr9596724ybk.507.1622859377579; Fri, 04 Jun 2021 19:16:17 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:16:15 -0700
In-Reply-To: <CABPp-BGeOVQokV+zg2-PUcmjEQ8+jmn6e=UeE=cOn=-Qm32p_Q@mail.gmail.com>
Message-Id: <20210605021615.609989-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BGeOVQokV+zg2-PUcmjEQ8+jmn6e=UeE=cOn=-Qm32p_Q@mail.gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH 4/4] promisor-remote: teach lazy-fetch in any repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > diff --git a/object-file.c b/object-file.c
> > index f233b440b2..ebf273e9e7 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1570,15 +1570,12 @@ static int do_oid_object_info_extended(struct repository *r,
> >                 }
> >
> >                 /* Check if it is a missing object */
> > -               if (fetch_if_missing && has_promisor_remote() &&
> > -                   !already_retried && r == the_repository &&
> > +               if (fetch_if_missing && repo_has_promisor_remote(r) &&
> > +                   !already_retried &&
> 
> So here you removed the special check against the_repository while
> looking for promisor_remotes.  There are other such special checks in
> the code; I also see:
> 
> diff.c: if (options->repo == the_repository && has_promisor_remote() &&
> diffcore-break.c:       if (r == the_repository && has_promisor_remote()) {
> diffcore-rename.c:      if (r == the_repository && has_promisor_remote()) {
> 
> and a series I'm planning to submit soon will add another to merge.ort.c.
> 
> Do these need to all be fixed as part of the partial clone submodule
> support as well?  Do I need to change anything about my series?  I
> guess since I'm asking that, I should probably submit it first so you
> can actually see it and answer my question.  (And the timing may be
> good since the area is fresh in your memory...)

Thanks for raising this. Looking at the 3 you listed, they all have to
do with prefetching. This is fine both now and later. Now, since partial
clones in submodules still don't work, any fetching of any sort (pre- or
not) will not work. Later, since this prefetching is just an
optimization. (Of course, we should come back and add prefetching for
submodule partial clones, but that is an optimization, not a correctness
issue.)

> >                     !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
> >                         /*
> >                          * TODO Investigate checking promisor_remote_get_direct()
> >                          * TODO return value and stopping on error here.
> > -                        * TODO Pass a repository struct through
> > -                        * promisor_remote_get_direct(), such that arbitrary
> > -                        * repositories work.
> 
> Odd, it appears that when this comment was added (in commit b14ed5adaf
> ("Use promisor_remote_get_direct() and has_promisor_remote()",
> 2019-06-25)), a repository was passed to promisor_remote_get_direct().
> Sure, it was just a transliteration of the comment that was there
> before when fetch_objects() was the function being called, but since
> the code was being changed and the comment being updated, it seems the
> TODO should have been removed back then.
> 
> Oh, well, good to update it now at least.

Yes - perhaps the comment was emphasizing the "such that arbitrary
repositories work" part. But anyway, yes, it is now removed.

[snip]

> Looks good to me.

Thanks for taking a look.
