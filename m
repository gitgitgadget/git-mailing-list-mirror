Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A63C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 18:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbhL1Svi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 13:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbhL1Svh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 13:51:37 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3140EC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 10:51:37 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l5so42490320edj.13
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 10:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KkoPnnCSoCQXVcwCtn/fCY0/UAGFrGcpYbp1J48JxnY=;
        b=JwuzCqT/9hNI4BUh97wZ/DY00Q8rUYZIxYyB8OJpzq3Hi77xvXCOs5GLfqy9vxa013
         4xkURlnwUDsj1aBCou7EHdeQmwqbvgTSNB8PrVkpJbhu+tCusT1aIeqkPG5pyCJMV1IE
         Bpos6e4VlawiBXesfKpHfEusQoNuhdI1CBOeM7cRpAFl8N7gKXudwZwekuK9ODHnk95+
         DJSA2HDXIhAbGBkHUYBsiWdZJ9WoHVjd8RG41DRQiW92yoBU8hMCjisvxzTwmtX/IE1l
         ntEQbSwv7+db88ndszhwkk9cFmCFnjEuqMBnmc4hGlEx5sSXXsKxTeDZdmfqGzx/Movi
         eUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KkoPnnCSoCQXVcwCtn/fCY0/UAGFrGcpYbp1J48JxnY=;
        b=cNLAUXcYLFchdMhGIWm3mQhLdGa9gthMKT3xk9/4+CNHD6WQQz1iLbsm9Z3zgjUbPx
         E1YR0c95ZP0c6EFKhbvtPNRVwOCxlG3E5acBxxTb2eF0PRCIfHooiSwh65PiMP+EVQfZ
         Wc2NbGctOtBC3lk3SzQzmpKM8OrGQoXO9tnZ/coC8xbNXq9O0Os6X4Pw8ixOM/RBv6Me
         NjGp3cR0GMLNnywzCv2kbptO7iCusQWIHe74NJH0PrsRPM7hNbwT56Ld2aXNPGEViQzc
         zHCnfxC5pShsrdEJBi2dlnnc6YALMoSEFw4GoyUQ8A1LXk7UUBOHtyOV98tqVgQGh/hv
         yriw==
X-Gm-Message-State: AOAM533n5lY9t26+q9vw6DtXjYNqfhq11gZE2qDNeR0pWwCHXLB6407w
        /4Bp5jHlEzCC3dXlCqkMdOrC3EUHnZ4N+qlejYc=
X-Google-Smtp-Source: ABdhPJwoUvFEqe+M0z523Vr8Q343RgrxGoVZAlaluyC26ZAiSUnZE3EkgGywicFeMRQNtjcRDOBC/BYI44H1HYnK0D0=
X-Received: by 2002:a17:907:3f1e:: with SMTP id hq30mr18004151ejc.613.1640717495547;
 Tue, 28 Dec 2021 10:51:35 -0800 (PST)
MIME-Version: 1.0
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
 <RFC-patch-19.21-0bbca8cca8e-20211115T220831Z-avarab@gmail.com>
 <66b25f23-7349-1540-76b8-c9f0a64660ac@jeffhostetler.com> <211228.861r1xk40d.gmgdl@evledraar.gmail.com>
 <9952005b-9174-7578-7718-e9576b27b4ce@jeffhostetler.com>
In-Reply-To: <9952005b-9174-7578-7718-e9576b27b4ce@jeffhostetler.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Dec 2021 10:51:23 -0800
Message-ID: <CABPp-BHxVTjLFZkM5MBCwymFTzBbyNaoj=hOPYJVV4hBv49eXA@mail.gmail.com>
Subject: Re: [RFC PATCH 19/21] usage API: use C99 macros for {usage,usagef,die,error,warning,die}*()
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
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

Just adding another datapoint...

At my $DAYJOB, we've been collecting trace2 information but have only
used it very lightly so far.  We've been meaning to use it more.
Anyway, I have a couple (possibly not fully informed) opinions based
on that...

On Tue, Dec 28, 2021 at 8:32 AM Jeff Hostetler <git@jeffhostetler.com> wrot=
e:
>
> On 12/27/21 6:01 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > On Mon, Dec 27 2021, Jeff Hostetler wrote:
> >
> >> On 11/15/21 5:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> [...]
> >>> It might be a good change to remove the "fmt" key from the "error"
> >>> events as a follow-up change. As these few examples from running the
> >>> test suite show it's sometimes redundant (same as the "msg"), rather
> >>> useless (just a "%s"), or something we could now mostly aggregate by
> >>> file/line instead of the normalized printf format:
> >>>         1 file":"builtin/gc.c","line":1391,"msg":"'bogus' is not a
> >>> valid task","fmt":"'%s' is not a valid task"}
> >>>         1 file":"builtin/for-each-ref.c","line":89,"msg":"format: %(t=
hen) atom used more than once","fmt":"%s"}
> >>>         1 file":"builtin/fast-import.c","line":411,"msg":"Garbage aft=
er mark: N :202 :302x","fmt":"Garbage after mark: %s"}
> >>> "Mostly" here assumes that it would be OK if the aggregation changed
> >>> between git versions, which may be what all users of trace2 want. The
> >>> change that introduced the "fmt" code was ee4512ed481 (trace2: create
> >>> new combined trace facility, 2019-02-22), and the documentation chang=
e
> >>> was e544221d97a (trace2: Documentation/technical/api-trace2.txt,
> >>> 2019-02-22).
> >>> Both are rather vague on what problem "fmt" solved exactly, aside
> >>> from
> >>> the obvious one of it being impossible to do meaningful aggregations
> >>> due to the "file" and "line" being the same everywhere, which isn't
> >>> the case now.
> >>> In any case, let's leave "fmt" be for now, the above summary was
> >>> given
> >>> in case it's interesting to remove it in the future, e.g. to save
> >>> space in trace2 payloads.
> >>
> >> I added the "fmt" field so that we could do aggregations
> >> of error messages across multiple users without regard
> >> to what branch or filename or percentage or whatever was
> >> formatted into the actual "msg" written to stderr.
> >>
> >> The actual file:line wasn't useful (primarily because it
> >> was probably something in usage.c), but even if we fix that
> >> it might not be useful if we have users running 10 different
> >> versions of Git (because some people don't upgrade immediately).
> >>
> >> So I'd rather not kill it right now.
> >
> > Thanks. I'm not trying to kill it, but just poking at what it was for
> > exactly.
> >
> > Depending on the answer to that perhaps we didn't need it anymore, but
> > the explanation you provide (mostly) makes sense.
> >
> > The "mostly" being because I'm assuming that you only need to deal with
> > LC_ALL=3DC users?
> >
> > I.e. the documented promise that you can group things by "fmt" doesn't
> > hold if you're processing even streams from users who are using a
> > translated git, because we'll get the translated format string, not the
> > original.
>
> I just did a query on the data we've collected over the last
> few weeks and there are only English error messages in the
> database, so yes LC_ALL=3DC seems to be the norm.
>
> > For that we'd need to change the API from/to to:
> >
> >      - error(_("some format %s"), ...)
> >      + error(N_("some format %s"), ...)
>
> So no, I don't think it is worth the complexity to change
> this.  Besides, wouldn't you need to more machinery under
> the hood -- to emit the untranslated string to trace2 and
> the translated string to stderr?  (As in, move the translation
> down a layer??)
>
> My "fmt" field is not worth that effort.
>
> And besides, my goal was only to get the "top 10 or 20 errors"
> across a large set of users.  I guess I'm thinking of it as a
> sample rather than an exhaustive list, so it is OK if we don't
> capture the translated strings.

This makes sense to me.

> Something else to consider is the GDPR.  The "fmt" string is
> generic (e.g. "path '%s' exists on disk, but not in the index")
> but doesn't leak an PII or otherwise sensitive data.  Whereas
> the corresponding "msg" field does include the pathname in this
> example.  So if someone is post-processing the data and aggregating,
> they may want to relay only the "fmt" field and not the "msg" field
> to their database.
>
> (Granted, there are lots of PII and GDPR problematic fields in
> the data stream that a post-processor would need to be aware of,
> but all of that is outside of the scope of the Trace2 logging.
> I only mention it here because the "fmt" field may be useful for
> reasons not previously discussed.)
>
> >
> > So being able to say "just group on file/line" would be simpler.
> >
> > And also "mostly" because the "fmt" case also won't handle these and
> > other duplicate formats (but maybe you haven't run into them in
> > practice):
> >
> >      $ git grep -E '\b(usage|die|error|warning)(_errno)?\("%s\"' -- '*.=
[ch]' | wc -l
> >      90
> >
> > So I was somewhat hoping for future work that you'd be OK with the new
> > file/line grouping.
> >
> > Because keeping "fmt" would eventually need some massive coccinelle
> > search/replacement for "_(...)" -> "N_(...)" per the above, even then
> > consumers of the stream would get duplicate grouping for the likes of
> > "%s".
> >
> > Do you think if as a follow-up we had "__func__"[1] along with
> > "file/line" that the "file/__func__" combination would be good enough?
> > The advantage of that would be that we could punt that "fmt"
> > change/complexity and document:
> >
> >      If you'd like to group errors the "file/line" pair will be unique
> >      enough within a given git version to do so (sans a few codepaths t=
hat
> >      relay errors from elsewhere).

I don't actually like the file/line pair technique so much.  We have a
little influence but no control over deployed git versions.  We've
collected data about git versions in use, and we've got every single
git version going back several years in use (plus, some people took
the copy of Git I built with ort and other stuff included early but
they haven't all upgraded as I've updated it leaving us with an even
greater sprawl of file/line numbers).  That means file/line pairs
would split messages much more than the number of languages would.
(We do have developers in over a dozen different countries, though we
have a strong majority in English-speaking countries.)

> >      If you'd like a semi-stable grouping across similar git versions t=
he
> >      "file/func" pair should be Good Enough for most purposes. Some fun=
ctions
> >      might emit multiple errors, but you'd probably want to group them =
as
> >      similar enough anyway.

Why would we want to group different errors?  Isn't the point to
figure out which error is being triggered the most (or which errors)?
This sounds like it'd leave us with more investigation work to do.

> > But I realize that those things don't give you exactly the same things
> > that "fmt" does, but maybe they're good enough (or even better?), or
> > not.

I think "fmt" is strictly better, personally.
