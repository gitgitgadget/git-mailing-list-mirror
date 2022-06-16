Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0677FC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378169AbiFPUlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiFPUli (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:41:38 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479305DBE4
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:41:37 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id f13so2303915vsp.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsdSTnH+mBJ0SEQHNrR2BlPHFnLBS09qCKkfbtaKR90=;
        b=XfC4VZoLz1oWAaHSUb3NC7NcNiikQ6ZVC0eO00XbTjvlKFCOXzV4JqXHGYPRwkf8X7
         90a2eV+xdp3IceJb/pzeZQ66zY6dl1CflOjaBfsXnCHrRj8Dd97nQDF2iuiPZjH72ItW
         vDsr2SMaYt7lwivjjFNuidDx37fY7c39SXEabgnb1Fz1RnLsyqqJHVTqDfYW+W872j5V
         SfYcXNScd4Uzx0B2AXmtylPhmeriI+N0VEG/rII5L6oVHj3dHhvaJ0chjkPszO+4zU6/
         jT0YTbZw2NYFv/b+QhJi9C+Ac9xQfI1zjTHavmsZukuczovoX4hblTpCB/oKpOyHV28B
         /vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsdSTnH+mBJ0SEQHNrR2BlPHFnLBS09qCKkfbtaKR90=;
        b=WWV8B+lV4SXB4arT1wkfdgetsNqr7VbZtZ6DybzTIam3te6XSd55qJi+ukbIomtL7G
         HFuA72Xu7/AZKDQJaCtmS5qrN9C9A4bEhuc5w7RNW2V/15xslonHIcrJcx1DhoauG4vw
         K2LWpYYmUFl8aJV6WYwubs2G0q96eNlwMhK6U9Sr48wR1PdRFdmwbaLr3nbaq+QLeiOs
         FDTI2MtUdgjW2QmTylRiaCEFLSCS7yMP+UaDNu9K9B02hTTP0ndrxRbHa/vhjQ8D0YTa
         O4u5FlrfRCElVw8SbQQHKnVRVVZIXb/Zymm8K0O6gF6TCqLMZE/lTCigUMMHO8BjM+Rr
         fMcw==
X-Gm-Message-State: AJIora9G1tC43lJ20XWu5lYao5olRVd0t1C5/1GzmcOkrHj3/cNnTeRD
        aQgdS0crhcETmq8zHv8jbziRNEdXDsGw8Nnk3Q4=
X-Google-Smtp-Source: AGRyM1s4Y67Dw3X0ye0QqcsNGEB53KZEaSRsTfv7xkauSAs8r2KbWG5Kw26utjBwGdMCgZEbcMTC9jsgMdWckPxkNnc=
X-Received: by 2002:a05:6102:3126:b0:349:f1a7:fe32 with SMTP id
 f6-20020a056102312600b00349f1a7fe32mr3520658vsh.55.1655412096264; Thu, 16 Jun
 2022 13:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220614003251.16765-1-jacob.e.keller@intel.com> <xmqqzgidy52c.fsf@gitster.g>
In-Reply-To: <xmqqzgidy52c.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Jun 2022 13:41:26 -0700
Message-ID: <CA+P7+xpS0v9Oi3t4S76AcNRazdzJEEj6HxzO+z+dAFDPJ=yHJA@mail.gmail.com>
Subject: Re: [PATCH] remote: handle negative refspecs in git remote show
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 2:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> > Fix this by checking negative refspecs inside of get_ref_states. For
> > each ref which matches a negative refspec, copy it into a "skipped" list
> > and remove it from the fetch map. This allows us to show the following
> > output instead:
> >
> >   * remote jdk19
> >     Fetch URL: git@github.com:openjdk/jdk19.git
> >     Push  URL: git@github.com:openjdk/jdk19.git
> >     HEAD branch: master
> >     Remote branches:
> >       master tracked
> >       pr/1   skipped
> >       pr/2   skipped
> >       pr/3   skipped
> >     Local ref configured for 'git push':
> >       master pushes to master (fast-forwardable)
> >
> > By showing the refs as skipped, it helps clarify that these references
> > won't actually be fetched. Alternatively, we could simply remove them
> > entirely.
>
> Very sensible.
>
> > @@ -367,6 +368,24 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
> >                       die(_("Could not get fetch map for refspec %s"),
> >                               states->remote->fetch.raw[i]);
> >
> > +     /* handle negative refspecs first */
> > +     for (tail = &fetch_map; *tail; ) {
> > +             ref = *tail;
> > +
> > +             if (omit_name_by_refspec(ref->name, &states->remote->fetch)) {
> > +                     string_list_append(&states->skipped, abbrev_branch(ref->name));
> > +
> > +                     /* Matched a negative refspec, so remove this ref from
> > +                      * consideration for being a new or tracked ref.
> > +                      */
> > +                     *tail = ref->next;
> > +                     free(ref->peer_ref);
> > +                     free(ref);
> > +             } else {
> > +                     tail = &ref->next;
> > +             }
> > +     }
>
>
> This is somewhat curious.  Do we really need to destroy the
> fetch_map like the above?  I know by removing skipped items from the
> list, the existing loop (below) can stop having to worry about them,
> but the caller of get_ref_states() may later want to iterate over
> the full fetch_map for other reasons (even if the current one does
> not, a future version of the caller may have a reason to do so that
> we do not know right now yet).
>

Good point. I'll fix this. I think we can just move the
omit_name_by_refspec into the other loop.

> > +
> >       for (ref = fetch_map; ref; ref = ref->next) {
> >               if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
> >                       string_list_append(&states->new_refs, abbrev_branch(ref->name));
>
> IOW, is adding a new condition to this existing loop insufficient?
>

The tricky part here is that we don't have a simple check, and we're
currently iterating over all of the refspecs each time. But we have to
do that regardless so I think this makes sense. Will fix.

>         for (ref = fetch_map; ref; ref = ref->next) {
> -               if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
> +               if (omit_name_by_refspec(ref->name, &states->remote->fetch))
> +                       string_list_append(&states->skipped, abbrev_branch(ref->name));
> +               else if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
>                         string_list_append(&states->new_refs, abbrev_branch(ref->name));
>                 else
>                         string_list_append(&states->tracked, abbrev_branch(ref->name));
>         }
>
>
> Thanks.
