Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89B7C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 12:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244764AbhLVMCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 07:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhLVMCV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 07:02:21 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4EBC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 04:02:21 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id i63so3434934lji.3
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 04:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6+WCVMmo02T0mDFslFz7zJpkCy+/9eJCS8ckpBiz0ys=;
        b=G4kJjjlgHn4FeFyqPBh9Tm/OPUbQ/tFNXjgfKF/SpVABm2Ea6woKf4de5p77hwTRVD
         NIHUOO+pkZfoO1XmYTlb6fQUKgkZFLrWQ2hBSQkjN+06ba5Zk1OuHlXz+MWSItJxsDvL
         S+6kMW0zQd+7AsQavnOCdjqnvVJo6p2t4dOYWXj/XS69HA/flqxVFqaFqgxQ7zqmerPl
         u+lqMphC7X+1AI5cQqepwJyy/DBq6vidiZyxMUu84s0X+THDOolshEwqJG93zimz4ecJ
         xb6CRuBw0vqnKOKjlVY6x24ENydNuYWMip0kLY1HXgjrQTXo0pkGgwVKB32M6cronIem
         ZTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6+WCVMmo02T0mDFslFz7zJpkCy+/9eJCS8ckpBiz0ys=;
        b=Bq4wZBDnH7+PLofT3/GyHbS9FmpMaT9k5wf2EK/I6T9o7rn/Gafg2yxwht1BswLjjo
         XGPyA5vvOVL8KrjqMxPRzr6pKCbKEcqL6mWTMgA2EVvBL5Ie0Oue+oMriBgtOT8KSQ8r
         +w9Al7DG+DyXM+PWWdaRzpG4IhJ33kGQbX5A9/YxmdTISfEsQ5N7IxAkE420jO7IKAaa
         UwiaKo+RZuUfsbpfbr8TDhEiimGKdJuoXK+0kiyl/G6Mv2/VEZvYv0N7bIj6B4CY3rC2
         /aasmj6alO6q/Uy3009QLHhSuNCR5M6ThgAneG81Tsy6zEFGMS8/xAZmLQ+LntLwzW8v
         rQNw==
X-Gm-Message-State: AOAM530OoEyKr2uhpIFb9ILFul593k1RAah0+fAuooCAEljX9hreq0/o
        2xymu6V44CikcAl4orq9hSD9JdAcusqtjmYTZLk=
X-Google-Smtp-Source: ABdhPJy/s1VRYkPq5BqJPk22Rkir3sshwDLdgYqRbGNBPEZ/yLt+PPi27xUzSaZFgUDF0kLJMo7omiddKklT2ABvuMY=
X-Received: by 2002:a2e:b171:: with SMTP id a17mr1871674ljm.56.1640174539717;
 Wed, 22 Dec 2021 04:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20211217112629.12334-1-chiyutianyi@gmail.com> <20211221115201.12120-4-chiyutianyi@gmail.com>
 <211221.867dbyrqe9.gmgdl@evledraar.gmail.com>
In-Reply-To: <211221.867dbyrqe9.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 22 Dec 2021 20:02:08 +0800
Message-ID: <CANYiYbFN4fn6hG8_=kLDENnvUtGCsXnksgTeBNG=VYzyaM9yrQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] object-file.c: refactor write_loose_object() to
 reuse in stream version
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 8:40 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Dec 21 2021, Han Xin wrote:
>
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> > [...]
> > @@ -1854,17 +1876,48 @@ static int create_tmpfile(struct strbuf *tmp, c=
onst char *filename)
> >               strbuf_reset(tmp);
> >               strbuf_add(tmp, filename, dirlen - 1);
> >               if (mkdir(tmp->buf, 0777) && errno !=3D EEXIST)
> > -                     return -1;
> > +                     break;
> >               if (adjust_shared_perm(tmp->buf))
> > -                     return -1;
> > +                     break;
> >
> >               /* Try again */
> >               strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
> >               fd =3D git_mkstemp_mode(tmp->buf, 0444);
> > +     } while (0);
> > +
> > +     if (fd < 0 && !(flags & HASH_SILENT)) {
> > +             if (errno =3D=3D EACCES)
> > +                     return error(_("insufficient permission for addin=
g an "
> > +                                    "object to repository database %s"=
),
> > +                                  get_object_directory());
>
> This should be an error_errno() instead, ...

We already know the errno (EACCESS) and output a decent error message,
so using error() is OK.  BTW, it's just a refactor by copy & paste.

>
> > +             else
> > +                     return error_errno(_("unable to create temporary =
file"));
>
> ...and we can just fold this whole if/else into one condition with a
> briefer message, e.g.:
>
>     error_errno(_("unable to add object to '%s'"), get_object_directory()=
);
>
> Or whatever, unless there's another bug here where you inverted these
> conditions, and the "else" really should not use "error_errno" but
> "error".... (I don't know...)
