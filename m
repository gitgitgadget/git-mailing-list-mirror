Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC664C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 22:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346340AbiAKW0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 17:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiAKW0J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 17:26:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D7EC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 14:26:09 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 30so2161173edv.3
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 14:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cb+Z+c3p111w2HACPFREuW/Z8H5FHIHH3G1cIRi6KMI=;
        b=E1+8n+BRVriPJNZRlLBOn/nfCIQqlzKeqNUAMMPXz3L6hNKT/Wg91FmLFGYMugYOHP
         69pFJvlfz3kQvqiwsvLzoKBpAcjs6mI5SWcGRET5cVf4GN9On2Nm5BK9RqRfsCAtLvg4
         8+1AOefCx83RW8YaeVF20/ysVERokLT2oErJo3zqcbd9x6RJmcwkujdPPQXuN7YDuJ7X
         Nt40jIEXQ2/3BqUYVgZX8cRPNcWZKzbqnjoKWAdwiDqAwEiIdBv2kQK2uaeg6j1+cShF
         fKswU3zKXCzTkH7ldyMhelljnD/RylfT9OeDhsqhfQ3EWwzV3Py9CvLo0sZSws46z4mC
         bntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cb+Z+c3p111w2HACPFREuW/Z8H5FHIHH3G1cIRi6KMI=;
        b=BqGdhxHkSY4Qq0HCjLQlRJTjQSIDo41L0bVwvmj8u3S12PEbVMtMmEwBZ3f0Z/XR1h
         a4ErkjU1mJYdkVC6LCKiShlAmvz7LnmM4Eqv3jKAYiZWrUGHCbV9njmCOV1i06zUnrEV
         2WSFDhhPmXriXiEWtFgZ2DeCbyPdNnh7oKqr21iavcQOGw4F7B49aNS4iB04TVdAaeHE
         MRWykv14RPaAVGWQirbXIvdYN6s7jOVTHf1hTM4o3yKeo4+i66bESHh8qgSr6BvUShsw
         h8sy8GPAQiz3y2EjEcQEQQTChOskkR/q5C44t62VhpQBRLB+GbZUbT53AYuQROx+Y+Ys
         JbRg==
X-Gm-Message-State: AOAM530Jd88e2UBLTFjvqqNzxK1f912wdiA2TOeBRmkzGKG4be9VE52Q
        gKivGBtXYDU2dI4+jKRn6DRiUUW7+P6yqqpda1g=
X-Google-Smtp-Source: ABdhPJzXFskVD4v9WMhPQACTS3gPUeMw2Z8Ct+E3JiLQ1ibyWgdfDL6kZCtM4p8TVm/NrIuAqXEBBf8ajIOfuqMNvy8=
X-Received: by 2002:a17:907:3f1b:: with SMTP id hq27mr2608703ejc.613.1641939967650;
 Tue, 11 Jan 2022 14:26:07 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
 <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
 <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
 <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet> <xmqq8rvn1nkw.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2201111439190.1081@tvgsbejvaqbjf.bet> <220111.86mtk2xb1y.gmgdl@evledraar.gmail.com>
In-Reply-To: <220111.86mtk2xb1y.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 Jan 2022 14:25:56 -0800
Message-ID: <CABPp-BFei07srZBgyKs6HCm+G+hmPR-3_EkKjRK8WwGL1Uf2oA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 12:38 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Jan 11 2022, Johannes Schindelin wrote:
>
> > Hi Junio,
> >
> > On Mon, 10 Jan 2022, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
...
> > No, I don't think it is a good idea to keep the original behavior aroun=
d
> > indefinitely, when it is totally unclear whether there actually _is_ an=
y
> > user of this feature out there.
>
> For what it's worth I've used it for some automation at an ex-employer
> at least once. Grepping through my #*git* IRC logs there's a few
> mentions of it, and likewise for StackOverflow.
>
> I'm not opposed to replacing it, and I think that probably in-the-wild
> users of it are almost certainly just grepping for the conflict markers
> to see if there's conflicts, or parsing which files have them etc.
>
> So if we can provide a better interface that they can use (or even make
> git merge-tree a thin wrapper...).
...
> So I'd personally be much more hesitant to remove or change that, but of
> course we might still come up with good reasons for why it's worth it,
> especially with some advertised deprecation period.
>
> And isn't any doubt around that even more reason to just go with
> Elijah's plan of introducing new plumbing? I.e. is it really costing us
> to just leave these "legacy merge" plumbing built-ins

I definitely think it's worth guiding users away from the old `git
merge-tree` behavior in documentation (i.e. deprecating it).  That may
also lead towards its eventual removal, but I'm not as worried about
that.

`git merge-recursive` was actively used in various places, including
in `git cherry-pick`.  I had used it a few times myself in a script.
I don't see a need to deprecate it currently, which naturally would
push its removal (if anyone is pushing for it) even further away.

> and merge-recursive.c etc. in place?

This, however, is different.  I have much stronger opinions here and I
do want to eventually remove merge-recursive.c.  Definitely not now,
because:

  * `ort` has not been the default long enough.  We had one bug
reported this cycle where ort did the wrong thing and using
`recursive` was a good workaround.  There may be a long tail here, so
I'd like to wait a couple years for reports to trickle in.
  * `merge-recursive.c` is still hard-coded in three places in the
code; you can't even set a configuration option to choose merge-ort.c
in those places: builtin/am, builtin/merge-recursive, and
builtin/stash.

More details on that second point: All three of these use
merge_recursive_generic() and need that usage to be replaced.  It's on
my TODO list.  Although it might look like a trivial job of just
copying merge_recursive_generic() and replace its merge_recursive()
call with merge_ort_recursive(), that would only get you something
that would die on assert()s in ort's setup.  If you removed those
assert()s, then you'd merely be copying the bugs in
merge_recursive_generic() usage into the new world (and adding one new
bug).  We should instead fix the problems identified with that usage
and those callers during the review of ort.  So don't try to do this
simplistic translation.
