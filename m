Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51102C433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 02:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbhL2CQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 21:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhL2CQH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 21:16:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D0BC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 18:16:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id q14so72857251edi.3
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 18:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IuD4BR3pH41e7kXfxK01kCwIjpsvaQ/gzikk7w5y0aw=;
        b=MF4kEqiWA3ENCq0kBgzsDXmtTEHqZZSaRAyDCsmbwDaWwc6rJz/YVKBoARh7XGWyK1
         gJAIa0wP9Mp5K3HT6JjWKx56ulTAgAcNlymiZKS5CDfT2o+oY7R7fFXinvsLM78uRXN2
         S6QUtuJgg/N8NRPreBYgp1M67B7stTnHXYpMEs6gHpLtpnae+SqmV/fayQQH0TdUU28m
         ZHcCHP+UooTjSJroABVKd2LQ0osnirLhMn55k/Rj63A3rXg4P5ixowIN1oDBfgbLuPX2
         Y1uBxDWkRrdtcr3WCJoALhk5WeOLUqPAl3hiexyfXiZCtJmXn/CPUGR++HH4K/34isG0
         h9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IuD4BR3pH41e7kXfxK01kCwIjpsvaQ/gzikk7w5y0aw=;
        b=lDoYgoCqbLXNQHLoklqGYR+AuxDjswDq2OaJYZlqWWEjoY3MZ0ILmymn3tSvTx/cR3
         Qz8PF26bv1kRG1fiODRPhyFIyGrxcdVIE75UfGNSMdL6kEj4k7re1J0ceXF5xzS3r7hI
         dcyrVCxHic7xNNZyqEutXowvGw5elcBQLgVzACSrs3nG0KMDYoDYcP/KO2HunVMzxPOJ
         DKte6wfMUuhW97q2MpOFV0CrqETPUagdxsjhkG51WkfxwmU599Gi046Bc0cmXuSopUzT
         j4uw16g33bNfsceiaZF6SXY4e0JhqXb8Z/CcpA+gt+x5l1A5DIlSZJKU9CSbWjzPJcw4
         24Og==
X-Gm-Message-State: AOAM5309H7yWh7AodKsRqmikkPizsIbTydigxHLeJbbxMtAmAHqXQUJy
        Mszk0xeDQLdIS2tOnDIAp+OIMQEJuCkyxeK+OA0=
X-Google-Smtp-Source: ABdhPJyu0UMtpNHeHn+RvWmNlYxgT58R6eX0rS128WMr68/5+b9lvndVVQ3T5dyOBGVki3ZAFkpix8D8fJmdiSF23zo=
X-Received: by 2002:a17:907:3f1e:: with SMTP id hq30mr19146230ejc.613.1640744165253;
 Tue, 28 Dec 2021 18:16:05 -0800 (PST)
MIME-Version: 1.0
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
 <RFC-patch-19.21-0bbca8cca8e-20211115T220831Z-avarab@gmail.com>
 <66b25f23-7349-1540-76b8-c9f0a64660ac@jeffhostetler.com> <211228.861r1xk40d.gmgdl@evledraar.gmail.com>
 <9952005b-9174-7578-7718-e9576b27b4ce@jeffhostetler.com> <CABPp-BHxVTjLFZkM5MBCwymFTzBbyNaoj=hOPYJVV4hBv49eXA@mail.gmail.com>
 <211229.864k6si8w5.gmgdl@evledraar.gmail.com>
In-Reply-To: <211229.864k6si8w5.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Dec 2021 18:15:54 -0800
Message-ID: <CABPp-BFt+BpJpkV9ZPcJOw5R_cUjouu1oYsMZTy0WS49i8VkBw@mail.gmail.com>
Subject: Re: [RFC PATCH 19/21] usage API: use C99 macros for {usage,usagef,die,error,warning,die}*()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 3:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Dec 28 2021, Elijah Newren wrote:
>
> > On Tue, Dec 28, 2021 at 8:32 AM Jeff Hostetler <git@jeffhostetler.com> =
wrote:
> >> >      If you'd like a semi-stable grouping across similar git version=
s the
> >> >      "file/func" pair should be Good Enough for most purposes. Some =
functions
> >> >      might emit multiple errors, but you'd probably want to group th=
em as
> >> >      similar enough anyway.
> >
> > Why would we want to group different errors?  Isn't the point to
> > figure out which error is being triggered the most (or which errors)?
> > This sounds like it'd leave us with more investigation work to do.
>
> Ideally you wouldn't, i.e. the goal here is to get some approximation of
> a unique ID for an error across versions.
>
> But unless we're going to assign something like MySQL's error ID's
> manually any automatic method we pick is only going to be an
> approximation.

I like this way that you frame it.  I agree.

> So the question is whether we can have something that's good enough. The
> current "fmt" feature is fragmented by i18n. That's fixable (at the cost
> of quite a lot of lines changed), but would something even more succinct
> be good enough?
>
> Which is why I suggested file/function, i.e. it'll have some
> duplication, but for an error dashboard using trace2 data I'd think it's
> probably good enough.
>
> But maybe not. I just wanted to ask about it as a quick question...

I think for determining the most frequently triggered errors,
fragmentation is a minor issue, so you are right to call it out.  In
particular, having the counts of issues separated by language might
mean that when we pick the top N errors, some of those in the top N
wouldn't really be in the top N if we had them correctly combined with
the other translations (and we also might get duplicates within our
chosen top N, since an english and a german translation of the same
error are both in the top N of the fragmented counts).  Pretty
unlikely to be a problem in practice, though, and rather trivial to
work around once we have the data collected and are looking into it.
Even in the really unlikely event that I was trying to fix a "top N"
problem and accidentally ended up with a "top N+2" problem, I'm still
dealing with a "real error" that users are hitting.  Any work I do to
fix it will help people facing a real problem.

In contrast, coalescing of errors to me would be a major issue.  Let's
say I look at the top error, as reported by file/function.  But that
one error is from a function that has four error paths.  If I take a
guess at one of those error paths and try to fix it, I might be
chasing ghosts and completely wasting my time.  My first step should
be to go back to the drawing board and attempt to collect data about
what error the user was actually hitting (a rather lengthy process,
especially in attempting over a period of weeks/months to cajole users
to upgrade their git versions to get the new logging) -- but that was
exactly what this trace2 stuff was supposed to be doing in the first
place, so the file/function approximation choice defeats the purpose
of this error logging.  It sounds like a deal breaker to me.

My gut instinct is that I'd take nearly any level of fragmentation
over the possible coalescing of separate errors.

I think the fragmentation solutions probably fall under the "good
enough" category.  So, for example, the file/line number might be good
enough.  It's a lot more fragmentation than different languages,
though, and it also suffers from the problem that it's hard to tell if
new git versions are fixing some of the "top N" problems (because new
git versions would have different line numbers and thus represent the
top N problems differently, whereas the fmt-based fragmentation will
at least be relatively consistent in its representation of errors
across git versions).  But if the fmt solution was super problematic
for some other reasons, I'd gladly take file/line-number over
file/function.

So, of the solutions presented so far, the "fmt" feature seems to me
to be the best reasonable effort approximation.

Anyway, just my $0.02...
