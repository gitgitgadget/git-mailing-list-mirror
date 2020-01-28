Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E694BC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 20:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F1621739
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 20:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pt56kESX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA1UsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:48:14 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40926 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgA1UsO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 15:48:14 -0500
Received: by mail-vs1-f66.google.com with SMTP id g23so9027199vsr.7
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ewVybyfM3FGeaXC8Qd+Dd/tdOHD3ay7Ut1wahS9l8Xs=;
        b=pt56kESXSd6N6ubW+KWvdVV8m6eni78gkjQkUsBvpJKSGQVGT1bNh+a+2xQjaYTB2W
         QZg6n1pQE4zCtDsKI8KWFBYq3W88suEBFytpbLXKk8xv14Ixb0/3dmRHqUn4RkiKVnYn
         Uj/wvMJt+SIwj80VTrb5bkFPavuPrVpfNXNnZhEODMumD9/QZUmixf/9fkdsyGlez+mO
         RmKgLk/SzlO8LZnUdBr/agRG86VZT7nZKaPmDR9rvVeBL8Gst80h/IpT1sZE1t8W34Gk
         Z5gie9eRNQ03KHTEW4/Ys5E/ObEJqxebcq9X6uxlqUvP+vChg+KPhf4IcVYrpfm/sDQa
         z3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ewVybyfM3FGeaXC8Qd+Dd/tdOHD3ay7Ut1wahS9l8Xs=;
        b=Bw/0bckjJ3iMfn+BmDedU/QI1kJmZc9E5Kz1q4SrOhYPz0g8nolcchHjiNLBMa4/6P
         k/XqxzHi+M1MNpXzvDIagTuB/dNZP2qqULvO+ONvOn2uQ0Wa4D9CtFjYgmRgl4ZX9i8h
         FrGdWd91vONL/za3E0pQe6J6x6MStrzuPkZrkuthDEFstbrUJXvsNx1xT0TTG7LeKDH3
         3lmDQ+Di8Igv3yhnUebYEqvBo9hZyrgF7GGdaKQHOalKJE6hXm+OmEoYdegwNPAv/By8
         NAqDgzgkIgKnWAZ/ivszRSZjbA4c+VrdgaE2EfScq7NtYRWCuUxlV9rQNudbIMahnT+d
         N/vw==
X-Gm-Message-State: APjAAAWV12rwgNIWtBnttPRLlnbbh0aITaZsHiXpmafQDR3UkfLgZgF4
        nGhJdtSY/p3/FKjB0I9+qOO2NJQI+q8dMIMLg6NSoQ==
X-Google-Smtp-Source: APXvYqyPFpivbELN1kYiNiHr5HThogaVfaJyqSkNUBAp/EGEYNtdtX37C61A6f4IFvqLrCW20LImKFRiJXkkHU6W/eA=
X-Received: by 2002:a67:1983:: with SMTP id 125mr14355122vsz.63.1580244493685;
 Tue, 28 Jan 2020 12:48:13 -0800 (PST)
MIME-Version: 1.0
References: <ed9a0485-1e6c-79ae-6a59-655105203728@googlemail.com>
 <20200125003836.GA568952@coredump.intra.peff.net> <b4c31e50-6da5-7699-1069-d94091f768bd@googlemail.com>
 <20200125200554.GC5519@coredump.intra.peff.net> <d8007df9-002b-6db1-4769-d6bf8c338cdf@googlemail.com>
 <dfcf0201-b634-2274-f041-a6ec4491825a@googlemail.com> <20200127231459.GD19360@coredump.intra.peff.net>
In-Reply-To: <20200127231459.GD19360@coredump.intra.peff.net>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 28 Jan 2020 21:48:02 +0100
Message-ID: <CAKPyHN3g9egige5Sac9nogu7JA2n5wov_mDabsj80Ti+kVH6Cw@mail.gmail.com>
Subject: Re: [PATCH] doc: clarify "explicitly given" in push.default
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 12:15 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 27, 2020 at 08:48:01PM +0100, Bert Wesarg wrote:
>
> > > > There's another way of doing this, which is when you have a "triang=
ular"
> > > > flow: you might pull changes from origin/master into your local bra=
nch
> > > > X, but then push them elsewhere. Usually this would be pushing to a
> > > > branch named X on a different remote than origin (e.g., your public=
 fork
> > > > of upstream on a server). And for that you can set branch.X.pushRem=
ote.
> >
> > =E2=80=A6 it does not play well if you have have both flows in one repo=
sitory.
> > And I do have both flows. I track the upstream 'master' in the local
> > branch 'Y' and I have also a branch 'X' which is based on 'Y' but
> > should be pushed to a different remote as branch 'Y'. I have
> > configured 'branch.X.pushRemote =3D triangular' but with 'push.default'
> > set to 'upstream' I get this when:
> >
> >     $ git push triangular
> >     fatal: You are pushing to remote 'triangular', which is not the ups=
tream of
> >     your current branch 'X', without telling me what to push
> >     to update which remote branch.
> >
> > In this simple case, without a renaming, I would expect that 'git
> > push' just works. May be just fallback to 'simple' if 'upstream' does
> > not resolve to a fully qualified push?
>
> I thought the point of "simple" was to be even more restrictive than
> "upstream".
>
> At any rate, your setup is sufficiently complicated that I think you'd
> be better off adding a branch.X.pushRef feature (essentially a refspec
> to be used just on branch X, though since the source side is implied,
> it's really just a destination ref).

thanks. I will try to come up with a patch.

Bert

>
> -Peff
