Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29264C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 10:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiAKKO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 05:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbiAKKO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 05:14:57 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54129C061748
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 02:14:57 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g11so54493872lfu.2
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 02:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=03VYvD0RkoR7gRpgOso2C0PP1ale2lbPG9vKaa2Js9E=;
        b=jo3SQ4pS0ikMNIwmYPNn3GbX9LHE/ArxG+BMA+KV4iw1vP0CDQnX5xSK8PODfAxqEU
         4g2o0Vg/gg2n1C8JkA3oVHiCROrU9nhsX5QPR2stb7avK9BBHZCGY5iaGQdnA6JSZYhv
         iA4JuFtU0Ty9t8/qknVIzwJn5NTvUdl/EfL2yGtC6qnGCas0XoM0i/Qyp0K0grSpxP1P
         fdsqHCnVOVI5VpDQyUG7zQ6rjX/u1OEw0M8LgmEocJ2VMiA4g6KnK9GDin0+GteoKQgx
         CbfBHVQZNXFIHnxm4EsdCLCZWqYBaw+ygNmVj0GBBny2YvWrZbpBtaqIZonVsdQchE9G
         B2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=03VYvD0RkoR7gRpgOso2C0PP1ale2lbPG9vKaa2Js9E=;
        b=ohMesZMcrvRqNeBL+vG4Cx+snOX3kYLpXblRZbUJKorJ3oCXvq+SPQYAjt8wgRy5yi
         k8tiAs0J5etyAp21tWELDom4vlOz+kU9AXnWU13TOBpGa9Kvkf05wCDnQU4EuMZOn2oT
         uZy83gPt1w2roapVvZC6A7khX3zU0134gHGHWTiemOj5sjnb8Fo/+JUyWfBqOhiUojNg
         VmiSPk9gvYWnxsmWqRbiLPM/8CZxE/6w28eUw9yAJ47uULnVFmJoHkda6i3rwJnZUEVC
         Wwp7aPxxaDHSRlNe2sl9nY6nnBONuv+K2LEZIQwEOkwL7hCGmW3FMSGEdnXPkUT6mdRN
         kn1w==
X-Gm-Message-State: AOAM5304iqltQcOUPAGgdfH//fhzxVSgAnVJv8JmWb+TTba1KgPIAL7K
        uNzUXApgtB4D5WppGs2/nqUX0l93hE2zzlMOduloNkSCSp+Rn9VU
X-Google-Smtp-Source: ABdhPJwoW3kPDcXTkoYbhV7Q51SAiw5SXe+EwZ+e3scgo5c3DH2XTJOdOwXT4MIQPUpW2Iz5fmgRQkmuOLqS+1F265I=
X-Received: by 2002:a2e:7a0e:: with SMTP id v14mr2586934ljc.481.1641896095648;
 Tue, 11 Jan 2022 02:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20211217112629.12334-1-chiyutianyi@gmail.com> <20220108085419.79682-4-chiyutianyi@gmail.com>
 <6d63d5d2-48db-40e9-8e5c-5b72c3d84414@web.de>
In-Reply-To: <6d63d5d2-48db-40e9-8e5c-5b72c3d84414@web.de>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 11 Jan 2022 18:14:44 +0800
Message-ID: <CAO0brD1qS_E7votGcJ26pSzadauoxA-5pX9eH8WTP6G0Yhr=nw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] object-file.c: remove the slash for directory_size()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 9, 2022 at 1:24 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 08.01.22 um 09:54 schrieb Han Xin:
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > Since "mkdir foo/" works as well as "mkdir foo", let's remove the end
> > slash as many users of it want.
> >
> > Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> > Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> > ---
> >  object-file.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/object-file.c b/object-file.c
> > index 5d163081b1..4f0127e823 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1831,13 +1831,13 @@ static void close_loose_object(int fd)
> >               die_errno(_("error when closing loose object file"));
> >  }
> >
> > -/* Size of directory component, including the ending '/' */
> > +/* Size of directory component, excluding the ending '/' */
> >  static inline int directory_size(const char *filename)
> >  {
> >       const char *s =3D strrchr(filename, '/');
> >       if (!s)
> >               return 0;
> > -     return s - filename + 1;
> > +     return s - filename;
>
> This will return zero both for "filename" and "/filename".  Hmm.  Since
> it's only used for loose object files we can assume that at least one
> slash is present, so this removal of functionality is not actually a
> problem.  But I don't understand its benefit.
>
> >  }
> >
> >  /*
> > @@ -1854,7 +1854,7 @@ static int create_tmpfile(struct strbuf *tmp, con=
st char *filename,
> >
> >       strbuf_reset(tmp);
> >       strbuf_add(tmp, filename, dirlen);
> > -     strbuf_addstr(tmp, "tmp_obj_XXXXXX");
> > +     strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
> >       fd =3D git_mkstemp_mode(tmp->buf, 0444);
> >       do {
> >               if (fd >=3D 0 || !dirlen || errno !=3D ENOENT)
> > @@ -1866,7 +1866,7 @@ static int create_tmpfile(struct strbuf *tmp, con=
st char *filename,
> >                * scratch.
> >                */
> >               strbuf_reset(tmp);
> > -             strbuf_add(tmp, filename, dirlen - 1);
> > +             strbuf_add(tmp, filename, dirlen);
> >               if (mkdir(tmp->buf, 0777) && errno !=3D EEXIST)
>
> This code makes sure that mkdir(2) is called without the trailing slash,
> both with or without this patch.  From the commit message above I
> somehow expected a change in this regard -- but again I wouldn't
> understand its benefit.
>
> Is this change really needed?  Is streaming unpack not possible with the
> original directory_size() function?
>

*nod*
Streaming unpacking still works with the original directory_size().

This patch is more of a code cleanup that reduces the extra handling of
directory size first increasing and then decreasing. I'll seriously conside=
r
if I should remove this patch, or move it to the tail.

Thanks
-Han Xin

> >                       break;
> >               if (adjust_shared_perm(tmp->buf))
