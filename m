Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60947C2D0E4
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 01:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5B022403
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 01:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osBG+7Sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgKUBmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKUBmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 20:42:00 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61133C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 17:42:00 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so12215188wme.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 17:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUaDQQB/e6G/dV/Pf2HDm4h9fJ+UZsZvd9wYMJKlBwE=;
        b=osBG+7SdA9Szore7DzRnj/onGn8jx22JpnZqnZ6Juj2PDIuHhofPtpssu7OW9BRYaa
         NzF+cvaUQ7OKySUSX3LA5+h/TpGC4eGMvKkzgvDWB4KWW2uDUapi9Z8/xBNl3Cr5GUPE
         4qgDBfi6x3q6SxfL5ots1RX6Wzf53/QxR0T6dsQN+6XVquH8Q8JRsZBPHAbYjiICvrGP
         gbxEtGzah0NLXlFwFWn58G8tuTrRYA0F79HKzj/xSGjvRRkfKfGBDx0tJxv9fonTO+Al
         NwlWoCbkpTmJBiSvh7251I3adJ7b5yQUAhNv5gCS3BkiKNz0Qnyt8mT1uZvHyb5+w2uv
         6ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUaDQQB/e6G/dV/Pf2HDm4h9fJ+UZsZvd9wYMJKlBwE=;
        b=sNVVCzbkjAr7uMYwxN2AGHnWWT7An0oVPgn2Il7ulojsskf5tJFMNmeeEPUTrmfRSY
         RUXx62smUR6ys5MNPYQadL4ars6KTvQEjtgYrbLPdJd+oCmCd3xeOyomXJRwSg6HVHte
         HeynD2IY6IQI4QRovmqOWbo2p7O6SyLDW2X0U3sktL+Hc6CqMRFjSWm4hOtpGk4zZRG1
         lrwVGrcANTV2WKBNBaSLyx6qe8SPihlEAM+Cjmfaux3tIhca/tnlXMawezzuoTf0/Nrl
         Hh3sy93rSJ5jn2ba4wf+7uQX7cQ/+3u3WTstIDWJ2ngPwN3t1oRtDNN0QUvgZbOw0SU3
         K1Qw==
X-Gm-Message-State: AOAM532WdwkFQMexT9P7my6QO8b1y+BlyQ0E26JHolpfXzs0P+f1NL9K
        BxBWWpMoIxCor7mqd04wSk1rXjiVio6dGGg8b9M=
X-Google-Smtp-Source: ABdhPJxmiUK5oAkVdOI+a/i8vyIhNpnd/dycj2+L0464WReDCluhfVfGEGloSUi1XhwQudZEanT16HycPo2BY6jTt3k=
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr12147393wmj.37.1605922918858;
 Fri, 20 Nov 2020 17:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20201118091219.3341585-1-felipe.contreras@gmail.com> <20201120235203.GA353076@coredump.intra.peff.net>
In-Reply-To: <20201120235203.GA353076@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 20 Nov 2020 19:41:48 -0600
Message-ID: <CAMP44s1LwYCMa3a7QyUBX2GRAu3XkRYPF1yy0DTQbUh+9eHxcg@mail.gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 5:52 PM Jeff King <peff@peff.net> wrote:
> On Wed, Nov 18, 2020 at 03:12:19AM -0600, Felipe Contreras wrote:

> > +static void update_head(int config, const struct ref *head, const struct remote *remote)
> > +{
> > +     struct strbuf ref = STRBUF_INIT, target = STRBUF_INIT;
> > +     const char *r, *head_name = NULL;
> > +
> > +     if (!head || !head->symref || !remote)
> > +             return;
>
> I'd expect us to return early here, as well, if the config is set to
> "never". I think your function will usually still do the right thing
> (because we return early before writing), but it makes a pointless
> lookup of the current origin/HEAD. But see below.

If the config is set to "never", the function update_head is never
called, since the boolean need_update_head is never set in the outer
function.

I don't like the convolutedness of this approach, but couldn't think
of anything better.

> > +     strbuf_addf(&ref, "refs/remotes/%s/HEAD", remote->name);
> > +     skip_prefix(head->symref, "refs/heads/", &head_name);
>
> Should we bail or complain if this skip_prefix() doesn't match? I think
> it would be a sign of weirdness on the remote side, since HEAD is never
> supposed to point to anything except refs/heads/. But if we ever did see
> it, it's probably better to bail than to point to
> refs/remotes/origin/refs/foo/bar or whatever.

OK. An extra check doesn't hurt.

> > +     strbuf_addf(&target, "refs/remotes/%s/%s", remote->name, head_name);
> > +
> > +     r = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> > +             ref.buf, RESOLVE_REF_READING,
> > +             NULL, NULL);
>
> This won't resolve a symref pointing to an unborn branch, so it would
> count as "missing". I.e.:
>
>   git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/nope
>   git -c fetch.updatehead=missing fetch
>
> will update it based on the remote HEAD.  I guess I could see some
> argument for defining "missing" in that way, but I suspect it is not
> what somebody in this situation would expect.
>
> I think it's hard to get into this situation intentionally. If you clone
> an empty repo, we won't write the symref at all (since we have nothing
> to write into it), so both sides would be missing. But it's easy enough
> to do the right thing; see symbolic-ref.c's check_symref() function
> (basically drop the READING flag).
>
> Likewise, I'd not expect to see a non-symref at that name, but what
> should we do if we see one? I think overwrite it for "always", but not
> for "missing". You can tell the difference by checking REF_ISSYMREF in
> the returned flags, though the distinction may not matter if we follow
> the semantics I just said.

All right. So, still checking if REF_ISSYMREF is set, just in case.

> > +     if (r) {
> > +             if (config == FETCH_UPDATE_HEAD_MISSING)
> > +                     /* already present */
> > +                     return;
> > +             else if (config == FETCH_UPDATE_HEAD_ALWAYS && !strcmp(r, target.buf))
> > +                     /* already up-to-date */
> > +                     return;
> > +             else
> > +                     /* should never happen */
> > +                     return;
> > +     }
> > +
> > +     if (create_symref(ref.buf, target.buf, "remote update head"))
> > +             warning(_("could not set remote head"));
> > +}
>
> If we do update the symref, we should probably tell the user. Better
> still if we can print it as part of the usual fetch output table.

Agreed.

> > @@ -1382,8 +1420,18 @@ static int do_fetch(struct transport *transport,
> >                               break;
> >                       }
> >               }
> > -     } else if (transport->remote && transport->remote->fetch.nr)
> > +     } else if (transport->remote && transport->remote->fetch.nr) {
> > +             if (transport->remote->update_head)
> > +                     update_head_config = transport->remote->update_head;
> > +             else
> > +                     update_head_config = fetch_update_head;
> > +
> > +             need_update_head = update_head_config && update_head_config != FETCH_UPDATE_HEAD_NEVER;
> > +
> > +             if (need_update_head)
> > +                     strvec_push(&ref_prefixes, "HEAD");
> >               refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
> > +     }
>
> Good catch. We need this for:
>
>   git fetch origin
>
> since otherwise it doesn't ask about HEAD in a v2 exchange. What about:
>
>   git fetch origin master
>
> That won't report on HEAD either, even with your patch, because it hits
> the part of the conditional before your "else if". What should it do?  I
> can see an argument for "nothing, we only update head on full configured
> fetches", but if so we should definitely make that clear in the
> documentation. I can also see an argument for "always, if we happen to
> have heard about it" (just like we opportunistically update tracking
> refs even if they are fetched by name into FETCH_HEAD).

I don't see the point in complicating the code for those corner-cases.

And I also don't see how HEAD can be fetched unless we specifically
ask for it. What would that command look like?


Also, there's two optimizations that apparently went unnoticed:

1. In the case of "missing". We could preemptively check if there's
already an "origin/HEAD" before adding "HEAD" to the prefixes (and
setting need_update_head). That would probably complicate the code.

2. Also in the case of "missing". There's no point in building the
"target" string buffer, since we are never going to compare it to
anything. Again, this would complicate the code.

I decided against these in v1 because as I already stated: it
complicates the code.

Plus, I forgot to release the string buffers (I'm glad nobody
noticed). That will be in v2.

Cheers.

Cheers.

-- 
Felipe Contreras
