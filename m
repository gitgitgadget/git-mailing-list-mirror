Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBA4C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 493D2239A1
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbhANI6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 03:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbhANI6K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 03:58:10 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67BC061786
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:57:29 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id l207so5211970oib.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCvu42+xxTmNZ59Xtn9SUbGpKeX8SQ58NHHyY9/01k0=;
        b=DnwhPT7D9llPkxIEyt29tWDU+U0Rh5Ip5S665bbVdBv8aZe4hg8j5gFyWb815AL9sm
         PMrwbTC8MC2Gfoqt+6Q886x9sdiDf0+gkexCVTZvXHb3AMbN2AmytdK4mXYRMCFVzpzj
         vqvfEpD9FGClr0IvUVbcpCal423AL10ZLXy0+k3cf5lNu+a2kP9StCjEuMGuzd/cEjEx
         MloFRqVc9fvttg52w3IFCtH/NR4CeGuxAPWRMqGIlUfxVHomGI64NttAD9vcxrgK8jgu
         hVKtkpyKlMB65UF7/TbRQEcQ+IibaN96JM/6tUDwYBK8C50YBEA3uJtaBnP5JjWSKtUs
         jYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCvu42+xxTmNZ59Xtn9SUbGpKeX8SQ58NHHyY9/01k0=;
        b=NvSYBGtXXuRQt45+gpTtU/gUDqmJoozYdUW3SUu4XQaoPm99XELVcHEXGANtHzA/qu
         QSTnjcP47dAhn1y/9aYzOypxAfTiu5AcmaaE/pOCKMYsD1mi3h6vtTNa2Av1zHJhXlrA
         y+sAL6HxozCP1QKCy/2m1S74SSYbI9+HhWDzVe1Yuk52APVJVwagXwKB1/RtdQnwsYOa
         l4auzI8+yPf9IUHVmIrfeieBirqGZ2GfkuJKVmTLgo+P0KWgcEtzBXabfAsc++xd3vAf
         0ICH0+qu0Pt9+drA36XspS+jHKM3Mh+WOBbnbNkKYWnmCCv9h0c1T0tX6kKkx1Zxe77N
         oYzQ==
X-Gm-Message-State: AOAM533tFegbbBmIOGN6seuyQpCvLARHugXYRUZiBcOYStkLxHsRRPs4
        SuJF4LLQIouF4tg9B3LBJTyNp7wFA7fbzKA/22U=
X-Google-Smtp-Source: ABdhPJwef5tl87rjZX1ljZAb35TpZ2yMRaFKVbd+OEC17yittAhXvrAK2HSEgi/6arDxfvkyAaoTXU39/jGXf+bjzTA=
X-Received: by 2002:a05:6808:617:: with SMTP id y23mr1453786oih.163.1610614649085;
 Thu, 14 Jan 2021 00:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-6-charvi077@gmail.com>
 <X/9GrVjBmnJUZcGn@nand.local>
In-Reply-To: <X/9GrVjBmnJUZcGn@nand.local>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 14 Jan 2021 14:27:17 +0530
Message-ID: <CAPSFM5dje9wi-aSmT+6+1jrxvB9+MHyQuRLY-zataWjy_UFdWA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] sequencer: use const variable for commit message comments
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Jan 2021 at 00:44, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Jan 08, 2021 at 02:53:43PM +0530, Charvi Mendiratta wrote:
> > This makes it easier to use and reuse the comments.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > ---
> >  sequencer.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index cdafc2e0e8..b9295b5a02 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1736,6 +1736,15 @@ static size_t subject_length(const char *body)
> >       return blank_line ? len : i;
> >  }
> >
> > +static const char first_commit_msg_str[] =
> > +N_("This is the 1st commit message:");
> > +static const char nth_commit_msg_fmt[] =
> > +N_("This is the commit message #%d:");
> > +static const char skip_nth_commit_msg_fmt[] =
> > +N_("The commit message #%d will be skipped:");
> > +static const char combined_commit_msg_str[] =
> > +N_("This is a combination of %d commits.");
> > +
>
> Two nit-picks here. The line break after the '=' is a little awkward,
> since two of these lines are less than 80 characters combined, and the
> other two are just slightly longer than 80 characters. The other nitpick
> is that its typical to see 'char *foo' instead of 'char foo[]'.
>
> So, I'd write these as:
>
>     static const char *first_commit_msg_str = N_("This is the 1st commit message:");
>     static const char *nth_commit_msg_fmt = N_("This is the commit message #%d:");
>     static const char *skip_nth_commit_msg_fmt = N_("The commit message #%d will be skipped:");
>     static const char *combined_commit_msg_str = N_("This is a combination of %d commits.");
>

Okay, I will change it and write in the same line,

Also, I agree with Junio and Christian to use array instead of pointer
here as it will take the extra memory for pointer.

> I also noticed that you suffix these with _fmt or _str depending on
> whether or not there are arguments that get filled in later on. That
> makes 'combined_commit_msg_str' labeled incorrectly (it should be
> 'combined_commit_msg_fmt').
>

I admit, I was not aware about the difference of _fmt or _str but now I got
this and will change it.

> I'm curious to see where down the road these messages will be used over
> again, but I'm sure that that is coming in subsequent patch(es).
>
>  static void append_squash_message(struct strbuf *buf, const char *body,
>                                   struct replay_opts *opts)
> >  static void append_squash_message(struct strbuf *buf, const char *body,
> >                                 struct replay_opts *opts)
> >  {
> > @@ -1745,7 +1754,7 @@ static void append_squash_message(struct strbuf *buf, const char *body,
> >       if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
> >               commented_len = subject_length(body);
> >       strbuf_addf(buf, "\n%c ", comment_line_char);
> > -     strbuf_addf(buf, _("This is the commit message #%d:"),
> > +     strbuf_addf(buf, _(nth_commit_msg_fmt),
> >                   ++opts->current_fixup_count + 1);
>
> This and the three below uses are good, since they still translate
> these messages. Nice.
>

Thanks for the reviews,

Thanks and Regards,
Charvi

> Thanks,
> Taylor
