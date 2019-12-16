Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D20C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 16:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C939420726
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 16:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx1YAhdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLPQNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:13:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34867 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfLPQNg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 11:13:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so7352615wmb.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 08:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aq2WMrua80tQCqYGkrLLXqAjgDKbgS/5UCigH1FPhYM=;
        b=jx1YAhdGhluq02WrqZvwyDFzCfYpyfJ0EQFUO+uBkcvNtHYGrzQxVoYMKtp7o0ho/f
         KR8HGt0u860db71PP9Ib1KLsDLZFBjVICVbVsD/ZxcsRi+2EOdT97IukACM0vof/lm5o
         JONdHi/ZOIh+7xnF5tq8wb/f9Bctfdqe/gk1BW2SrifV0T3V9cmqhoKVIoKL8tb83NeM
         Focq48AGvAm6CGdptfKip5BS/aSrrPItdfli+eahq3sMKDq10JknKv+/vYoTrZWADMAX
         rChPpsCXGPrk+8QtfBMJeNOgOrY/RaChrG46AN1fRW/NYUNWQl4BJMp2mcgroVhPoegI
         dt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aq2WMrua80tQCqYGkrLLXqAjgDKbgS/5UCigH1FPhYM=;
        b=djfg97Sp3cfFO/04SezfGy1Ln53tXTQy/gIbQ6BFE04CXImNmcObmDtVqTDv+vZbS4
         zFkFs2JRufmk0IR2S3pM0LQ8QdgeMXKgLXB76c74AYvettEsJfeRXo/ykhnYX0b79dBm
         PTpRdZDj8+SyTdxV1eTQAFuyLzDF08wBCBrOZmiKlyDsY6TJBPo3UvWqGLO99wWm9Ipz
         pl/xBwUGffe+SlLhJv+Bg3WGzZga+/mhC+MnryhnJPv9ZgU3Hj7/6SbqWE98DR/OM5w1
         g/fLHhd3DMstfC+2tvEABPAEXMyZ183wJKXbClU5ACdusj4bZib5URtg7gAIOyKnRqYE
         b3FQ==
X-Gm-Message-State: APjAAAVDgUft971harlUkXB78dAdHI/HyZNuYnDWlwj8EI2LVdHkWoUT
        euxTb8nzvjcoQx1NezLrz3ietAh7bK61Rj7Mmmo=
X-Google-Smtp-Source: APXvYqxYT9WSxMFdm7NdUlI4HFGhlzYd9vr/1eM0e7OUyNABx7q2jMgvICTjYC9urBErrg4jfDz5xbjJXMBTsN85Z9o=
X-Received: by 2002:a05:600c:149:: with SMTP id w9mr30163944wmm.132.1576512814748;
 Mon, 16 Dec 2019 08:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20191208180439.19018-1-otalpster@gmail.com> <CAHd-oW4MzH9Wrb2zNPF0JBN8+FRB4NtDX0166Qt2Kbqs0mDgcw@mail.gmail.com>
 <xmqqv9qptcyz.fsf@gitster-ct.c.googlers.com> <CAHd-oW5tVNP=yNZqPANkk4JLWKJyPkb4g4AeUerrd1O=xdLKXQ@mail.gmail.com>
In-Reply-To: <CAHd-oW5tVNP=yNZqPANkk4JLWKJyPkb4g4AeUerrd1O=xdLKXQ@mail.gmail.com>
From:   otalpster <otalpster@gmail.com>
Date:   Mon, 16 Dec 2019 18:12:12 +0200
Message-ID: <CAEKpa1QqrxyS1jeAUoSEAM2bC5h+trPJc_Mm1M18NVA73sCWKQ@mail.gmail.com>
Subject: Re: [PATCH] entry.c: use dir-iterator to avoid explicit dir traversal
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 6:38 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Mon, Dec 9, 2019 at 6:18 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
> >
> > >> The changes pass the test suite t/ and Travis CI.
> > >> Please point out any mistakes.
> > >> ...
> > >> -               strbuf_addch(path, '/');
> > >> -               strbuf_addstr(path, de->d_name);
> > >> -               if (lstat(path->buf, &st))
> > >> -                       die_errno("cannot lstat '%s'", path->buf);
> > >> -               if (S_ISDIR(st.st_mode))
> > >> -                       remove_subtree(path);
> > >> -               else if (unlink(path->buf))
> > >> -                       die_errno("cannot unlink '%s'", path->buf);
> > >> -               strbuf_setlen(path, origlen);
> > >> +               if (unlink(iter->path.buf)) {
> > >
> > > unlink()-ing a directory in Linux will return a EISDIR error. So I
> > > think you still need to use S_ISDIR() to check if iter->path.buf is a
> > > directory and call rmdir(), in this case.
> > >
> > > However, note that the dir-iterator API gives entries in pre-order.
> > > I.e. a directory appears before its subentries. In the use case of
> > > remove_subtree(), though, we need to traverse in post-order, since we
> > > have to remove the subentries before removing the directory where they
> > > reside. My suggestion is that you add a preliminary patch,
> > > implementing a new DIR_ITERATOR_POST_ORDER flag to dir-iterator.h, and
> > > then use it in this patch.
> >
> > Thanks for a review and a few hints to nudge a new contributor in
> > the right direction.  Very much appreciated.
> >
> > I wonder why the bugs in this patch weren't caught by self test we
> > already have, by the way.  We need a bit better test coverage,
> > perhaps?
>
> I think there is no current test that covers remove_subtree() being
> called with nested directories. But we could use the test proposed by
> Daniel[1], which does fail when this current patch is applied. So,
> maybe, Plato could also include this test in v2, before performing the
> dir-iterator convertion.
>
> [1]: https://public-inbox.org/git/1493226219-33423-3-git-send-email-bnmvco@gmail.com/

Hello!
Thanks for the warm welcome and sorry for the late reply.
Your review and hints you provided were very helpful and appreciated.

Yes, I can work and include the test in v2, as well as performing the
dir-iterator conversion. The required process and the necessary
changes I need to make were very clear.

This week I'm very busy. I'll work on this in great detail from next week.

Thanks,
Plato
