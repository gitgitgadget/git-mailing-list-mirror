Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C7C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 14:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FD822C9F
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 14:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX/XFaxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHGOId (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHGOI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 10:08:28 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC755C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 07:08:27 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j188so482105vsd.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bYJkNz6iOgCCNYWBap6lD12DJR71B+s3jSMzz8iCiUI=;
        b=bX/XFaxI/naPsL3vyaK4lJ5y/+60rBw1WhZp5VpgNKQKCcYr67v1aP/A+MomFGJEUn
         rNAyHd6CzolDeeC4fSsueXNVlUvu8/Bb1OFz7ZizCmcurRzvXC32b74ZqpEzRJL1G3WC
         5FytitJv1zDkevQmGqRzbv7RP1ncEVtiAoeX1eJU3lXX6MvWM/R5tleynLgRfpX3+udj
         8ZDsQcDOzUxal4rYYqMoFbDFpxQbreVIw8ZEK6fgcsq4M0RNG+g0Gk5cU1MN5Hypp5YM
         KUrCtNsWshrrqav8SnfRq6WXRIPD+OxpSZmroRvalLnnzeej9VuCRcp72iOaeKYLI5xG
         Pvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=bYJkNz6iOgCCNYWBap6lD12DJR71B+s3jSMzz8iCiUI=;
        b=HyuEQqrf4lQll9WsgvHhrNxgdNDy9jG0Z6DKjH+10u1cepQ+ijDdITrBw/xMlgXMIc
         ak053mvC2g68zj3LJLqIDcEUR0Tj7TaWpdtEOZvHnIzCA15rsQSQ/1HZRsZyhegT6sD4
         d5xFyvcB3VweEJx2Nw2qiwU00gbbzH0/2l72c2bDmIWc79BH4TrPAUgkC5pN3Uav5nv6
         SNIYMjQ+cn3bWM3sLjWFlYKJyDJTYYNyaQz0BgS3cBTTCslwFkFB49MJV8JRXtbDGJHg
         O/ez+dsNrM7QF/yqgRzPvIYGJOyLqX/5kVQF5i4cJEWBNCi54kKdwgdcpeUvoMXH6XFP
         zyPA==
X-Gm-Message-State: AOAM530fN7PztVWfC1kxRg37Esszv9VrSdqJBVHqCHHAaq6sgxOIccz3
        5aFxtCgku2+GJeMTmHos/ruXuI72XBa249JqbD0=
X-Google-Smtp-Source: ABdhPJz/P04ULN0zRjOddwEd0NluFgeQ+VSnkb3KkY5EBmT6Wf2NDCj4ig0So6Acq/cZMaQWN1CiWmCWxurk3TEdpuk=
X-Received: by 2002:a67:7fc8:: with SMTP id a191mr10201449vsd.85.1596809303552;
 Fri, 07 Aug 2020 07:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200806202358.2265705-1-martin.agren@gmail.com> <20200806230837.GA8085@camp.crustytoothpaste.net>
In-Reply-To: <20200806230837.GA8085@camp.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 7 Aug 2020 16:08:10 +0200
Message-ID: <CAN0heSptiJL9d86ZeNPMUaZeTA68juwTyf3K-uWR=K-vt=1Hrg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: mark `--object-format=sha256` as experimental
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 7 Aug 2020 at 01:08, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-08-06 at 20:23:58, Martin =C3=85gren wrote:
> > After eff45daab8 ("repository: enable SHA-256 support by default",
> > 2020-07-29), vanilla builds of Git enable the user to run, e.g.,
> >
> >   git init --object-format=3Dsha256
> >
> > and hack away. [...]
[...]
> > Similarly, "push + pull" should work, but you really will be operating
> > mostly offset from the rest of the world. That might be ok by the time
> > you initialize your repository, and it might be ok for several months
> > after that, but there might come a day when you're starting to regret
> > your use of `git init --object-format=3Dsha256` and have dug yourself i=
nto
> > a fairly deep hole.
>
> I do agree that they don't interoperate right now, and that we'd like it
> to in the future.  But there are definitely people who can use SHA-256
> support for new projects without problems.  I'm aware of certain
> government agencies who very much do not want to use SHA-1 at all (and
> at some point will be legally prohibited from doing so), and they will
> be completely fine with the status quo.  Some of those same
> organizations are unhappy about prohibited algorithms even being linked
> into the binaries they use.  These folks can use a suitably new version
> of Git everywhere and not care about the lack of backwards
> compatibility.
>
> I am, of course, in favor of abandoning SHA-1 as fast as practically
> possible, but I understand that backwards compatibility is obviously a
> concern.

Yeah, I'd prefer them to know that they are early adopters and that they
should be prepared for a situation where there's some incompatibility
across versions. I don't just mean "I can't read my old SHA-1 data any
more", I mean "I used Git v2.29.0 to create a SHA-256 repo and now Git
v3.15.0 won't read it". (Or v2.31.0?)

I've followed the work on the commit graph functionality and file format
mostly from the sidelines. It's been lots of good work with lots of good
outcome, but there also seems to have been (of course) a few
incompatibilities, bugs and "argh, if only we'd have done it like this
from the beginning". I'd assume the effort -- and potential for bugs and
"ooh, we should have done it that way" -- for SHA-256--SHA-1
interoperability to be larger than what's been put into the commit graph
so far.

> > Workflows aside, let's consider a more technical aspect. Pack index
> > files (pack-*.idx) exist in two flavours: v1 and v2. [...]
[...]
> > We could certainly (re)define v2 to match our SHA-256 behavior, but we
> > do foresee v3 for a reason. And that would still just fix this specific
> > issue. And even when everything around SHA-256 is well-defined and we
> > have SHA-1--SHA-256 interoperability, there's a risk, at least
> > initially, that somewhere we'd be permeating buggy data that we'd then
> > feel responsible for and need to be able to handle for a long time to
> > come.
>
> These are valid index v1 and v2 files, just with a different hash
> algorithm.

I claim that they are not valid, precisely because they use a different
hash algorithm.

> v3 is there for the point where we do interoperate and need
> to store hash values of multiple algorithms at once.  There's little to
> no benefit to v3 if you don't need multiple algorithm support, other
> than the fact that they declare the algorithms in them.

One additional benefit: they'd correspond to a specification. :-)

> This is no different than saying that our commit or tree objects are in
> a different form; they are syntactically identical, just with a
> different hash algorithm.  That's how everything is in the .git
> directory.

For objects, I could perhaps accept that the format outlined in the hash
transition document is the specification.

That document says that pack indices "use a new v3 format that supports
multiple hash functions." It then goes on to draft such a format. (Maybe
it's a specification, but until there exists at least one
implementation, I'd rather see it as a draft.) No mention of v2 pack
indices with SHA-256 data, neither in that document, nor anywhere else
in our documentation that I could find.

The "v2 but with SHA-256" packfile index format we're producing contains
lots of 32 B SHA-256s instead of 20 B SHA-1s, ok, that much can be
guessed in one try. The index file ends with a 32 B SHA-256, after
referencing the 32 B packfile SHA-256. Ok, maybe that could also be
guessed. If we're committed to maintaining that format, we should put it
down in writing. And if we're not committed to it, we should make that
clear.

The hash transition document foresees a packfile index format v3.
Notably, it uses a _20_ B SHA-256 checksum and references a _20_ B
SHA-256 packfile SHA-256. In light of that, are we certain that the "v2
with SHA-256" format outlined above is not a maintenance burden? Or that
if there is any kind of cost, that it's worth it? Or, for that matter,
that guessing the details of "v2 but with SHA-256" is trivial?

I fully respect the effort that has gone into making the test suite
run with 32 B SHA-256 instead of 20 B SHA-1. But do we really intend to
support for many years to come the new file formats that such a test run
produces and consumes?

Bundles v3, yeah I guess so. Thanks for making that move!

Pack index "v2 but with SHA-256", maybe. At the very least, we should
set down our feet consciously.

> > +THIS OPTION IS EXPERIMENTAL! SHA-256 support is experimental and still
> > +in an early stage.  A SHA-256 repository will in general not be able t=
o
> > +share work with "regular" SHA-1 repositories.  It should be assumed
> > +that, e.g., Git internal file formats in relation to SHA-256
> > +repositories may change in backwards-incompatible ways.  Only use
> > +`--object-format=3Dsha256` for testing purposes.
>
> I'm fine with marking the functionality experimental for a few releases,
> since it is possible we have bugs people haven't found, and adding a
> note about interoperability after that point, since I think that's a
> fair and valuable issue.  I think if we go a few releases without any
> major issues, we can change this to the following:
>
>   Note that a SHA-256 repository cannot yet share work with "regular"
>   SHA-1 repositories.  Many tools do not yet understand SHA-256
>   repositories, so users may wish to take this into account when
>   creating new repositories.

With respect, I think that's too aggressive. By that time, we may
conclude that, e.g., the "v2 pack indices with SHA-256" file handling is
robust. But I'd be surprised if using `git init --object-format=3Dsha256`
in June 2021 won't cause *some* extra work for users or ourselves
further down the line compared to using a regular SHA-1 `git init`.
Pushing to a SHA-1 hosting service will become *possible* at some point,
but maybe it won't be *efficient enough to be practical in the real
world* until some time after that.

All those other, *new* file formats outlined in the hash
transition document won't exist at that time (at least not in master).

Now would probably be a good time to update the hash transition
documents, first of all to tick off what we've already done, and second,
to reassess the rest. Quoting:

  The first user-visible change is the introduction of the objectFormat
  extension (without compatObjectFormat). This requires:
  - implementing the loose-object-idx
  - teaching fsck about this mode of operation
  - using the hash function API (vtable) when computing object names
  - signing objects and verifying signatures
  - rejecting attempts to fetch from or push to an incompatible
    repository

I don't think we're there yet. Maybe, e.g., the new loose-object-idx
isn't strictly needed, in which case this part of the plan could be
updated. (Or maybe who wrote the above thought there'd be some value in
knowing that *all* SHA-256 repos *always* have loose-object-idx tables
to save us from some file-discovery dancing?) We do say elsewhere in the
document that

  Alongside the packfile, a SHA-256 repository stores a bidirectional
  mapping between SHA-256 and SHA-1 object names.

So at the time we do not seem to be producing correct, proper,
as-specified (or at least as-drafted) SHA-256 repositories. Or maybe in
2030, we can stop insisting on such a mapping, because everyone uses
SHA-256 anyway, so then maybe it shouldn't be mandatory now, either.

"Signing objects" is a bit vague, but under "Signed Commits", I see:

  [...]

  This means commits can be signed
  1. using SHA-1 only, as in existing signed commit objects
  2. using both SHA-1 and SHA-256, by using both gpgsig-sha256 and gpgsig
     fields.
  3. using only SHA-256, by only using the gpgsig-sha256 field.

Right now, we can do either 1 or 3. Maybe that's enough. I do think
there's a bug in git-replace where we'll only remove the last signature,
but as we'll currently only create one signature, that's perhaps "ok".
I still believe we should think hard before saying (even if we only say
so by omission) that, e.g., file structures are known-good and will be
supported for a long time to come.

Martin
