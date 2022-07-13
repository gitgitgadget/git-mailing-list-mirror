Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D768C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiGMN3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiGMN3n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:29:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DAEF0B
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:29:40 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id h62so16623466ybb.11
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eLopXmBnwIJzfKkIDD05qk11OPQPWK6Ff8Y6XqfGCGw=;
        b=fdiSGj0oaqRR0dlLLLVr/LeBRegBfousMlIWeH4/u93dF987bMmbf1KeDW9pAeBkBT
         D38Om7FwajNImKXSyX42jlVg/s/eaOA2KT+/S5MdWbzPVnEvbKMGN48DuuLyXxIIhcQB
         G1uvwO2UIdqeOS9XvMeNxDSD2uAYqNoxAncCE0N1gpHAnvRwIv6DuO7sS2K1WN1epZwG
         pJ6SXOwHT88F8A8J7efAWeH9WxshFxUemdNCEyo40+3pGvEsq3l4cc6GKOC9ixvrPWUL
         szvtMkR7pRT6BLXXBXUUkwJF0z9t9vXKM/TMoR3j7cQ52qUhW85eqyUnP0igm0Wz13HA
         Kh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eLopXmBnwIJzfKkIDD05qk11OPQPWK6Ff8Y6XqfGCGw=;
        b=rHUpT/5w79/zImp762PLmMMQ/IPhaaeRhscqdgYAI+Xmjc/FDP6f425AADp4aZuGF+
         G3l47c4H6gC6N8m2pJ4DNNMCQI9yYyLQsPsrbLVQvAqu5uu8xw6JqW4DYSLy+X+2Uh5g
         iThu4Y0TRetEtCa8sR4PoAD3fcEj1F/hTaEFJ/IrDeuLzwEtPdaNpPC1Me/OmTxIhumF
         p2jnkX+jygWzNSr9N4T5Uiehl9n8hPpw/Y5WMiCba2bICa9dEap3TG43e2uOtucXJM9r
         R13912467b4cGpiYC2pONH4Sk00xO02JpYmnoHEOsnqNvOra6gmmgKPOtOARoALuVJcT
         jKfQ==
X-Gm-Message-State: AJIora9C6TSBap3bUmNz0K6bA1X8TqhuEgoEy0Pqw7fFS7wBPQda8ozW
        jFrkT/qXDEndt3SjwCUzaJp3zYSIrX9PkK6zEWY=
X-Google-Smtp-Source: AGRyM1soFEhvMNLgebSjM9tnb4Q1KDsG0NthJ1Dca9SFRm/hZRab4srT1rkqwjQIg66E0Til9eY7ZiqXdgOY2o0tbTg=
X-Received: by 2002:a5b:487:0:b0:664:3c15:7e19 with SMTP id
 n7-20020a5b0487000000b006643c157e19mr3553751ybp.105.1657718979739; Wed, 13
 Jul 2022 06:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220709154149.165524-1-siddharthasthana31@gmail.com>
 <20220712160634.213956-1-siddharthasthana31@gmail.com> <20220712160634.213956-4-siddharthasthana31@gmail.com>
 <220713.86ilo14wqq.gmgdl@evledraar.gmail.com>
In-Reply-To: <220713.86ilo14wqq.gmgdl@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 13 Jul 2022 15:29:28 +0200
Message-ID: <CAP8UFD0zAk0dEhTibh24tPuRusSrPaYGWVFdBD3B1XmUG7dk_w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] ident: rename commit_rewrite_person() to apply_mailmap_to_header()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2022 at 3:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jul 12 2022, Siddharth Asthana wrote:

> > diff --git a/revision.c b/revision.c> > index 14dca903b6..6ad3665204 10=
0644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -3792,7 +3792,7 @@ static int commit_match(struct commit *commit, st=
ruct rev_info *opt)
> >               if (!buf.len)
> >                       strbuf_addstr(&buf, message);
> >
> > -             commit_rewrite_person(&buf, commit_headers, opt->mailmap)=
;
> > +             apply_mailmap_to_header(&buf, commit_headers, opt->mailma=
p);
> >       }
> >
> >       /* Append "fake" message parts as needed */
>
> I can live with this so far, but I really think this is cementing the
> wrong approach into place here.
>
> We only use commit_match() to feed a commit to grep.c, which if you look
> at the "header_field" struct there we take this pre-formatted output and
> parse this out *again*, i.e. find "author", "reflog", "committer" etc.,
> and eventually point the regex engine at that buffer.
>
> So we really don't need to get a strbuf here, and munge the whole thing
> in place to feed it to grep.c, instead we can:
>
>  1. Not munge it at all, pass it as-is
>  2. Pass the mailmap along to grep.c itself
>  3. It's already parsing out the headers, so at some point it will have
>     "author foo <bar>\n"
>  4. In that code, we can just consult the mailmap, and then map the "foo
>    <bar>" bart to "Baz <bar>" or whatever
>  5. Thean search that string.
>
> So no need for any in-place rewriting, or no?

This patch series is about improving `git cat-file` and it seems to be
far fetched to ask it to rewrite how grep handles mailmap first.

> Even with this approach this seems a bit odd, e.g. isn't your
> commit_rewrite_person() largely a re-invention of find_commit_header()
> in commit.c, can't we use that function there?

find_commit_header() seems to be searching for only one header, while
we want to search for more than one. Also we want only one pass to be
made over the object buffer. So I think we cannot really reuse
find_commit_header().

> The replace_idents_using_mailmap() in 4/4 seems like it could be
> improved in a similar way.
>
> I.e. can't we just loop over the the object, then as we find "author"
> consult the mailmap, and potentially emit a replacement, otherwise the
> existing content as-is up until the next \n etc.

That's what we do except that we replace the existing ident instead of
emitting a replacement.

> We should be able to "stream" all of this, instead of in-place modifying
> a potentially large commit buffer, which involves memmove() etc.

I am not sure if streaming is really much better, especially if there
are a small number of commit or tag objects where an ident must be
replaced.
