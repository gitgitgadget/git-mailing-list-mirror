Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052CFC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 22:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378591AbiFPWKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiFPWKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 18:10:06 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EC35F8CF
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 15:10:05 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id x187so2505775vsb.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1xXM0kU3pLXF6oQ/J4mwMYQYFAQYBeQeD3CZi6wBrrI=;
        b=L8OfYs9shNtivJmZrfXjg4f4OgWfgrdMEDKlXFNLKFDrR1i8aR8dnfPVhsDhG01ELm
         k5VNZcvk28veBnXvept2HgE5fS9FzL8BUxq7TOpzM96jgDzD5NkjyEVVELWlJth8Qi8I
         E0vT/a+slj0YbwMDzjo5oqjE5F8MnuTQuTwACtoUfqr9SqdymgymzxCt5HMomqoYruNY
         qFAoTeSBh2ErXWHqLPGByZZbRU6Sg6WZIBKzzgMnNzKXmp8+TRY89df7qMzP4+olma9J
         v2axEFOQbg3OAkZf1Jl2ooTQlCqtWKxeHflGfwtQwTATkHYonHTIakRYhlHQ6rbAF0Sd
         KiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1xXM0kU3pLXF6oQ/J4mwMYQYFAQYBeQeD3CZi6wBrrI=;
        b=L3QYXVy+6d5SuwyPQ4jWt9oL/EVXJqHOW6EW4NmJ72kPshMCe2l8PrVRmQVIC6NmcK
         5eHSKjbRON481861k9W9fN20W0fgFDhnVOTwG+QTKKbMUlfeMa+o62va5tO73jFvlH5L
         ufPn8wM4Bz3w5xkHekNhy3g9IDmK5Cxt1MHqMGOlWLpxUBtwdRCDmi1lmMrFva7F9J2k
         mORv0q50mrxn4Q0WphN/IU6woIPDwl/hkXhHVAuYGkpyVV9G3c4P3m+DdUnJNusnNbcw
         LJM3KX+v2CpiNLaAeZfbcTZmWnhqfn+NNSHznpTAQZGKEVAy5EASiY4nLEoYO936F+3H
         wiRA==
X-Gm-Message-State: AJIora8xyApHjn12SvplzKLK8YB8J2EcrQ1Ll+GjWEtNzgyI9LucXf+Y
        ZFPWfabTYKm1A78NFqMIVBbQq1mbjizuJyKXSGc=
X-Google-Smtp-Source: AGRyM1uKovg63DCfhUKRtoZLLtNdKLuYtn5SaAFCOPANAJcSehQFykLHx9F6dMT7kaaYGuEpFS/ouAJouc6WMryFTT0=
X-Received: by 2002:a05:6102:215c:b0:34c:1e12:afa with SMTP id
 h28-20020a056102215c00b0034c1e120afamr3273003vsg.29.1655417404480; Thu, 16
 Jun 2022 15:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220614003251.16765-1-jacob.e.keller@intel.com>
 <xmqqzgidy52c.fsf@gitster.g> <CA+P7+xpS0v9Oi3t4S76AcNRazdzJEEj6HxzO+z+dAFDPJ=yHJA@mail.gmail.com>
 <xmqqletwqnse.fsf@gitster.g>
In-Reply-To: <xmqqletwqnse.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Jun 2022 15:09:54 -0700
Message-ID: <CA+P7+xrx-Cec0mUJvDtWn0Fxu5vLdVkTbteWKiZyouH=64pWvA@mail.gmail.com>
Subject: Re: [PATCH] remote: handle negative refspecs in git remote show
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 2:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> >> This is somewhat curious.  Do we really need to destroy the
> >> fetch_map like the above?  I know by removing skipped items from the
> >> list, the existing loop (below) can stop having to worry about them,
> >> but the caller of get_ref_states() may later want to iterate over
> >> the full fetch_map for other reasons (even if the current one does
> >> not, a future version of the caller may have a reason to do so that
> >> we do not know right now yet).
> >>
> >
> > Good point. I'll fix this. I think we can just move the
> > omit_name_by_refspec into the other loop.
> >
> >> > +
> >> >       for (ref = fetch_map; ref; ref = ref->next) {
> >> >               if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
> >> >                       string_list_append(&states->new_refs, abbrev_branch(ref->name));
> >>
> >> IOW, is adding a new condition to this existing loop insufficient?
> >>
> >
> > The tricky part here is that we don't have a simple check, and we're
> > currently iterating over all of the refspecs each time. But we have to
> > do that regardless so I think this makes sense. Will fix.
>
> Another thing that worries me is that get_stale_heads() will not see
> the filtered refs with your original implementation, because you cull
> them from the fetch_map in the extra loop upfront.
>

I think the new implementation fixed this, but I'll see about adding a test!

> I do not know offhand what its effect would be, but it probably is
> worth testing.  In your original scenario, if we locally have
> refs/remotes/jdk19/old and refs/remotes/jdk19/pr/1 (perhaps obtained
> before we configured ^refs/pr/* negative refspec), we'd want to see
> that pr/1 exists here but will not be updated.
>

Yea, I will see if I can check that.

>   * remote jdk19
>     Fetch URL: git@github.com:openjdk/jdk19.git
>     Push  URL: git@github.com:openjdk/jdk19.git
>     HEAD branch: master
>     Remote branches:
>       master tracked
>       old    stale
>       pr/1   stale
>       pr/2   skipped
>       pr/3   skipped
>     Local ref configured for 'git push':
>       master pushes to master (fast-forwardable)
