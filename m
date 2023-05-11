Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC1C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 23:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbjEKX23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 19:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjEKX2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 19:28:25 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8AB199C
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:28:23 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-547303fccefso6104606eaf.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683847703; x=1686439703;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+qeQo0AQ5gWQsQ3GwZzBv2/I3TjWv1V8f+pSKjbVBc=;
        b=j/cV7gcNJfNXxO5iNAUi4B3M5v3GQ8Lew8uUXtXBmaJc5wQcLOiLCpDbanBT6jPAoK
         exxC8llTPNC9bbRVkUfQMHet7wrdxosUHV7UI89L0GKqsnjY9sEZ54QmKwxQMM6wI5tm
         lw76XgvvbkM7o49imV+sScwZ2AehDLjn0XKeygUPgkrD6JnWxpFUA9HMnJqNvraZS0Iz
         32/YxDLGOSnjhJvD1BgYKL96+EnHHAabJIl0Kz9rnJCFWwbqldsNVZIpdGb2z5pa+qfm
         ZFhtgfH54cRLB/4qvQePcG14ku2yHmrx8sgt1y/MflAeNjAujCUaCRz2CAktv4AJ1I7D
         5gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683847703; x=1686439703;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+qeQo0AQ5gWQsQ3GwZzBv2/I3TjWv1V8f+pSKjbVBc=;
        b=UiRyDIIKgve9nd+hrs7Of1nP956AwdAXfvljHdAeAP7EmNrtyWctTnK/rt1Bniyenb
         EzS0YfFMDG+FD9P/cYyzX0vM/XX1ed72/GHp0m7zmt3XVeAUpKD6dv75u4POCzuqDAsB
         Rp3+cgiRgIqbDNnuVXku0QNZ2aq7FkG1/AtH5dbOcJkwSJ8zqQiZV7JgzdpBIWG3xuja
         VSVIQpwB/e+Emmyi90TADkO4pWwFZ1uFIZ5MKlEwBP5ZFSyXsDMseb2ASfk+FWNyMuLb
         UtZ00rM2GRBOMgg/QOBIMhoD1abJumTOWNxR3SaP78EkU6bL671FRdjTBakE2I8p8xCY
         /X0w==
X-Gm-Message-State: AC+VfDw6OqII1clEKfeQNxgiGZ7ohqxNnpHG5ULMHja6+z/LK3MnUx9P
        eFTmiBGr9h3hNnWUyNsOBx1iw8gVJXg=
X-Google-Smtp-Source: ACHHUZ44qEV45JV/u/LBS41irzLSAM7bxUSa0XyoNkDsrvEOHCmdOlCfUqMV9MFUlUVcab9J/pkwYQ==
X-Received: by 2002:a05:6808:4287:b0:38e:8e21:d042 with SMTP id dq7-20020a056808428700b0038e8e21d042mr5531908oib.58.1683847702804;
        Thu, 11 May 2023 16:28:22 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s130-20020acac288000000b0038e8efd297fsm3930432oif.9.2023.05.11.16.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:28:22 -0700 (PDT)
Date:   Thu, 11 May 2023 17:28:21 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Message-ID: <645d7a153ac66_1ba85a29451@chronos.notmuch>
In-Reply-To: <87fs82zdny.fsf@osv.gnss.ru>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <645d28e112294_26011a294b2@chronos.notmuch>
 <877cte200m.fsf@osv.gnss.ru>
 <645d3dbf785a5_26069229463@chronos.notmuch>
 <87wn1ezms9.fsf@osv.gnss.ru>
 <645d480be344d_260ff5294c@chronos.notmuch>
 <87mt2azkdp.fsf@osv.gnss.ru>
 <645d572a47e5b_57c4e294dc@chronos.notmuch>
 <87fs82zdny.fsf@osv.gnss.ru>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Sergey Organov wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> > Sergey Organov wrote:
> >> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> >> > Sergey Organov wrote:
> >> >> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> >> >> > Sergey Organov wrote:
> >> >> >> >
> >> >> >> >> I'd rather think about generic interface for setting/clearing
> >> >> >> >> (multiple) bits through CI than resorting to such convenience
> >> >> >> >> tricks. Once that is in place, one will be able to say "I need these
> >> >> >> >> bits only", "I need to turn these bit(s) on", and "I need to turn
> >> >> >> >> these bit(s) off" conveniently and universally in any part of Git CI
> >> >> >> >> where it's needed.
> >> >> >> >
> >> >> >> > It's possible to achieve both.
> >> >> >> >
> >> >> >> > Imagine your ideal explicit interface. In that interface the default
> >> >> >> > is no output, so you *have* to specify all the bits, for example:
> >> >> >> >
> >> >> >> >   git show --patch
> >> >> >> 
> >> >> >> No, that's not what I meant. There is no point in making "git show" to
> >> >> >> have no output by default, please see below.
> >> >> >> 
> >> >> >> >
> >> >> >> > Or:
> >> >> >> >
> >> >> >> >   git show --raw
> >> >> >> >
> >> >> >> > In this ideal interface it's clear what the user wants to do, because
> >> >> >> > it's explicit.
> >> >> >> >
> >> >> >> >   git show --patch --raw --no-patch
> >> >> >> >
> >> >> >> > Agreed?
> >> >> >> >
> >> >> >> > My proposal achieves your ideal explicit interface, except when no
> >> >> >> > format is specified (e.g. `git show`), a default format is chosen for
> >> >> >> > the user, but that's *only* if the user hasn't specified any format.
> >> >> >> 
> >> >> >> My point is that the default format should be selected as if it has been
> >> >> >> provided by existing options, rather than by some magic hidden in the
> >> >> >> code.
> >> >> >
> >> >> > But why?
> >> >> >
> >> >> > I don't see any benefit, only drawbacks.
> >> >> >
> >> >> >> > If you explicitely specify the output format that you want, then the
> >> >> >> > default is irrelevant to you, thus you have your ideal explicit
> >> >> >> > interface.
> >> >> >> 
> >> >> >> That's not what I had in mind, sorry. It'd rather be something like:
> >> >> >> 
> >> >> >>   --raw: set "raw" bit and clear all the rest
> >> >> >>   --+raw set "raw" bit  (== current --raw)
> >> >> >>   ---raw clear "raw" bit (== --no-raw)
> >> >> >> 
> >> >> >> In this model
> >> >> >> 
> >> >> >>   git show
> >> >> >> 
> >> >> >> would be just an alias for
> >> >> >> 
> >> >> >>   git log -n1 --patch --cc
> >> >> >> 
> >> >> >> and no support for a separate command would be need in the first place.
> >> >> >> 
> >> >> >>   git show --raw
> >> >> >> 
> >> >> >> would then produce expected output that makes sense due to the common
> >> >> >> option processing rules, not because somebody had implemented some
> >> >> >> arbitrary "defaults" for the command.
> >> >> >
> >> >> > But now you are at the mercy of those "arbitrary defaults".
> >> >> 
> >> >> No, see below.
> >> >> 
> >> >> >
> >> >> > Let's say those defaults change, and now the default output of `git show` is
> >> >> > `--stat`.
> >> >> >
> >> >> > Now to generate the same output you have to do:
> >> >> >
> >> >> >   git show --raw
> >> >> >
> >> >> > in one version of git, and:
> >> >> >
> >> >> >   git show --no-stat --patch --raw
> >> >> >
> >> >> > in another.
> >> >> 
> >> >> No: --raw in my model clears all the flags but --raw, so
> >> >> 
> >> >>   git show --raw
> >> >> 
> >> >> will produce exactly the same result: raw output only.
> >> >
> >> > But that {--,--+,---} notion doesn't exist, and I think it's safe to say it
> >> > will never exist. So, could we limit or solution-space to those solutions that
> >> > could have the potential to be merged?
> >> 
> >> I didn't expect it to exist any time soon, just showed a different way
> >> of options design.
> >> 
> >> >
> >> > What you suggest could be easily achieved with:
> >> >
> >> >   git show --silent --raw
> >> >
> >> > But because no other format is explicitely specified, following my notion of
> >> > defaults, that's the same as:
> >> 
> >> The problem that I tried to fight is this notion of defaults that is
> >> somewhat special, so, if I allow for it, the rest of my suggestions
> >> becomes pointless,
> >
> > No, they don't, all you need to do is specify the default explicitely.
> >
> >> and without the "defaults" with non-trivial behavior[*]
> >> 
> >>    git show --raw
> >> 
> >> won't work as expected provided --raw still just sets "raw" bit and
> >> doesn't clear all the rest.
> >
> > It works perfectly fine. There are no bits to clear, because there are no bits
> > set.
> 
> When I set default value to a variable in C, it does have bits set, and
> they are kept unless overwritten, so they are set by default as well.
> Exactly the bits that I've set. Here I've proposed the same principle
> for handling of options.
> 
> What you have in mind is exactly the current behavior

No, it's very different.

 cur: git diff --raw --no-patch # no output
 new: git diff --raw --no-patch # raw output

 cur: git diff -s --raw # no output
 new: git diff -s --raw # raw output

 cur: git diff -s --patch --raw --no-patch # no output
 new: git diff -s --patch --raw --no-patch # raw output

I've no idea what makes you think these are exactly the same.

> > That's the whole point of defaults: you don't have to use them. If you don't
> > like the notion of defaults, then don't use them.
> 
> Once again, the defaults in this form seem to be not needed to me. I
> already got it that you like them, and it looks like we need to agree to
> disagree.

What I (or anyone) think of the defaults is irrelevant. You don't have to use
them.

> > If you specify *any* format option, then the defaults are ignored and no bits
> > are set other than the ones that you explicitly specified.
> 
> That's exactly how it works now,

No, it's not.

Right now the code cannot distinguish between `git diff` and `git diff
--no-patch`, which is precisely why the code can't turn off the
DIFF_FORMAT_PATCH field.

> >> [*] Defaults with trivial behavior is just initializing of internal
> >> variable holding flags with specific value, that is exactly the same as
> >> putting corresponding option(s) at the beginning.
> >
> > Those are not default arguments, those are initial arguments. In many cases
> > they behave the same, but not all.
> 
> In my model they are both. When you set a bit initially, it's then on by
> default.
> 
> In your model all initial bits are effectively cleared just before any
> bit is changed by option, and this is an additional rule. What I'm
> trying to explain is that this additional rule is not needed,

I know it's not needed, but it's better for the end-user, as it doesn't require
any mental baggage.

> as all the functionality could be achieved without it.

All the functionality can be achieved with it as well.

"It can be done" is not an argument in favor of a change, the question is not
if it _can_ be done, the question is if it *should*.

> From all the correct solutions of a problem the simplest one is the
> best.

All absolutist claims are wrong...

* almost all

I think I'll have to send the patches implementing everything so you can see
how my proposal is different from the status quo, not just with code, but with
examples.

Cheers.

-- 
Felipe Contreras
