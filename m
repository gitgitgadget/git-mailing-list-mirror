Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82404C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 19:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbiECTYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 15:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiECTYq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 15:24:46 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B426ADD
        for <git@vger.kernel.org>; Tue,  3 May 2022 12:21:13 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id l16so11939165oil.6
        for <git@vger.kernel.org>; Tue, 03 May 2022 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8J2cYq0O6Xt/fZoWmr4MOFzwC88PS5brB9rotLdulGw=;
        b=HztKTi5OUowFtafkU+UunP6MPqOIfGfXDMLgMUa2o50TL44XtCFtZrSlukv0akD/LG
         i7GbkgGpOsoXJ/1wYkxXt6T+E/axSx7N4POZLGWfF+O7VoEq+6bi7zun/2FkbzANuiCm
         7ROPUKrGwzFEuW0zEi6PDvOa/PbZqE94EJtwYS8OXhitDw2qURObjb+luAhns1FceC7p
         pXHMGAb/9NvnRJn3l9qWirESHD7MLeSH9eR4zVJ88m25ogFCjaEjBAZ1tdJpkPjaqGgJ
         QT+7CLA1cEZ6NS2aT33N0PFzU1h/i53Kw1Y1qwsm19dm4cLaqv4IGN/oBK87Bp6eB8WM
         7SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8J2cYq0O6Xt/fZoWmr4MOFzwC88PS5brB9rotLdulGw=;
        b=ZIZ5Kh3EUJh5xv7qukr4clasLn1KzEzOiaCHarwQtPrtw6bXP0AAhQLwQE6Wyq0Vxk
         TEhkD5JJI9OigkpqY5ogOPK3hQn4ftLDxB5VzPP53OvABxMPJ3vojGpPcAntzhfoF8Gk
         vkNEVosXCc23Oj0KLAbz6ndfVG1FJELpIWo+K3Cb/JQoFhTIXG8NfWqC+TDDGVN9nKUY
         eanQOgkS8kvIiuvy3Rp9M4XLBo2J5qhCx3mWi0kD9HZFsGLnO0RN+vyekJSbDnsZD5XM
         SJx324A29oQjK9vGQFHuJrO+MHpAYT7mwmkkyPJAcg8Tfv3fVDnWagj1IVlp5BF4xwrH
         6wzg==
X-Gm-Message-State: AOAM532DOERaZrWH+Ukd6eww0XB/q9AxA8m0iHLbFbIRwNWh+/EtSXqC
        +3BfHCPRkVJhK1rWspnx/kO8gsVaY3EL/9F0W2ea7jgBjbj+sg==
X-Google-Smtp-Source: ABdhPJyFko58EjQbgpi1Uo1YKJ8qPFxrL7waHGcPzdrQIFKAgnDf3ZUQbjQrFJjhlt8EVySP2vtZhf8aONZVubu40wA=
X-Received: by 2002:a05:6808:1387:b0:325:93d:eb4b with SMTP id
 c7-20020a056808138700b00325093deb4bmr2581226oiw.213.1651605672161; Tue, 03
 May 2022 12:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com>
 <20220502170904.2770649-1-calvinwan@google.com> <20220502170904.2770649-5-calvinwan@google.com>
 <xmqqee1btr8b.fsf@gitster.g>
In-Reply-To: <xmqqee1btr8b.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 3 May 2022 12:21:01 -0700
Message-ID: <CAFySSZDdhD19Czh31HB2V+FNWYB-Xon68_qZNSmeSNzA8Od=PQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] object-info: send attribute packet regardless of
 object ids
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Now, an updated server side with this patch would respond with
> "size" and no other response.  Does it mean it does not understand
> "frotz", it does not understand "nitfol", or neither?  Did we get no
> response because we didn't feed objects, or because we asked for
> something they don't know about?

Patches 4-6 describe the following design idea I had:
 - Send initial request with only attributes
 - If server can fulfill object-info attributes, then go ahead
 - Else fallback to fetch

I responded to your comments on patch 5 regarding not needing
that first request, and sending the entire request from the beginning
so I imagine v5 would look something like this instead:
 - Send full request
 - Server either responds with a fulfilled request or only the attributes
   it can return.
 - Fallback to fetch if request is unfulfilled

> How well does the current client work with today's server side and
> the server side updated with this patch?  I _think_ this change is
> essentially a no-op when there is no version skew

You are correct that this change is essentially a no-op when there is
no version skew, which is intended. There is no current client; it's
implemented in patch 5.

> Am I correct to assume that those who are talking with today's
> server side are all out-of-tree custom clients?

> I am wondering how much damage we are causing them with this change
> in behaviour, especially with the lack of "You asked for X, but I
> don't understand X", which is replaced by no output, which would be
> totally unexpected by them.

Internally we don't have anyone using this yet. If we want to be
totally safe, I am also OK with having object-info return everything
it understands about the request rather than nothing. This was
intended to be an optimization since we would be defaulting back
to fetch to get object-info rather than only returning what object-info
knows.

> Wow.  We have been using info uninitialized?  Is this a silent
> bugfix?

Yes unfortunately.
On Mon, May 2, 2022 at 5:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > Currently on the server side of object-info, if the client does not send
> > any object ids in the request or if the client requests an attribute the
> > server does not support, the server will either not send any packets
> > back or error out.
>
> There is an early return when oid_str_list->nr (i.e. number of
> objects we are queried) is zero, and we return without showing the
> "size" token in the output (called "attribute").  The change in this
> patch changes the behaviour and makes such a request responded with
> "size" but without any size information for no objects.
>
> It is unclear why that is a good change, though.
>
> The loop that accepts requests in today's code sends an error when
> it sees a line that it does not understand.  The patch stops doing
> so.  Also, after ignoring such an unknown line, the requests that
> were understood are responded to by send_info() function.  The patch
> instead refuses to give any output in such a case.
>
> It is unclear why either of these two makes it a good change,
> though.
>
> > Consider the scenario where the client git version is
> > ahead of the server git version, and the client can request additional
> > object-info besides 'size'. There needs to be a way to tell whether the
> > server can honor all of the client attribute requests before the client
> > sends a request with all of the object ids.
>
> Yes.  If we want to learn about "size", "frotz", and "nitfol"
> attributes about these objects, we can send "size", "frotz",
> "nitfol", and then start feeding object names.  Then we can observe
> that "frotz" were not liked to learn that this old server does not
> understand it, and the same for "nitfol".  At least we would have
> learned about size of these objects, without this patch.
>
> Now, an updated server side with this patch would respond with
> "size" and no other response.  Does it mean it does not understand
> "frotz", it does not understand "nitfol", or neither?  Did we get no
> response because we didn't feed objects, or because we asked for
> something they don't know about?
>
> How well does the current client work with today's server side and
> the server side updated with this patch?  I _think_ this change is
> essentially a no-op when there is no version skew (i.e. we do not
> ask for anything today's server does not know about and we do not
> necessarily ask today's server about zero objects).
>
> Am I correct to assume that those who are talking with today's
> server side are all out-of-tree custom clients?
>
> I am wondering how much damage we are causing them with this change
> in behaviour, especially with the lack of "You asked for X, but I
> don't understand X", which is replaced by no output, which would be
> totally unexpected by them.
>
> It totally is possible that this "object-info" request is treated as
> an experimental curiosity that is not ready for production and has
> no existing users.  If this were in 2006, I would just _declare_
> such is a case and move on, breaking the protocol for existing users
> whose number is zero.  But I am afraid that we no longer live in
> such a simpler world, so...
>
> > In a future patch, if the
> > client were to make an initial command request with only attributes, the
> > server would be able to confirm which attributes it could return.
> >
> > ---
> >  protocol-caps.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/protocol-caps.c b/protocol-caps.c
> > index bbde91810a..bc7def0727 100644
> > --- a/protocol-caps.c
> > +++ b/protocol-caps.c
> > @@ -11,6 +11,7 @@
> >
> >  struct requested_info {
> >       unsigned size : 1;
> > +     unsigned unknown : 1;
> >  };
>
> OK.
>
> >  /*
> > @@ -40,12 +41,12 @@ static void send_info(struct repository *r, struct packet_writer *writer,
> >       struct string_list_item *item;
> >       struct strbuf send_buffer = STRBUF_INIT;
> >
> > -     if (!oid_str_list->nr)
> > -             return;
> > -
> >       if (info->size)
> >               packet_writer_write(writer, "size");
> >
> > +     if (info->unknown || !oid_str_list->nr)
> > +             goto release;
> > +
> >       for_each_string_list_item (item, oid_str_list) {
> >               const char *oid_str = item->string;
> >               struct object_id oid;
> > @@ -72,12 +73,13 @@ static void send_info(struct repository *r, struct packet_writer *writer,
> >               packet_writer_write(writer, "%s", send_buffer.buf);
> >               strbuf_reset(&send_buffer);
> >       }
> > +release:
> >       strbuf_release(&send_buffer);
> >  }
>
> OK, except for the bypass for info->unknown case, which I am not
> sure about.
>
> >  int cap_object_info(struct repository *r, struct packet_reader *request)
> >  {
> > -     struct requested_info info;
> > +     struct requested_info info = { 0 };
>
> Wow.  We have been using info uninitialized?  Is this a silent
> bugfix?
>
> If info.size bit was on due to on-stack garbage, we would have given
> our response with "size" attribute prefixed, even when the client
> side never requested it.
>
> > @@ -92,9 +94,7 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
> >               if (parse_oid(request->line, &oid_str_list))
> >                       continue;
> >
> > -             packet_writer_error(&writer,
> > -                                 "object-info: unexpected line: '%s'",
> > -                                 request->line);
> > +             info.unknown = 1;
>
