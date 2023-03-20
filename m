Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDF4C7619A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 18:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjCTSJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCTSJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 14:09:09 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929EB132FE
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:03:00 -0700 (PDT)
Date:   Mon, 20 Mar 2023 18:01:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679335300; x=1679594500;
        bh=xF3Bc1YiY/w8610t8pkv1qzOHnIK3tJSURzx4ARQ3Hk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=yv5uZUWH3hCIOYaoH1KaoyH/mwgyY5q0UDVQJIMKyQDDv88dc9ri1fQAC3kNTxg2H
         0NqLAdgY2eSCRowj5qke53DAhzEkTrHHv/PoViDqifMRHsm7ugEAkk/cIbQXQZ8vGx
         wuy6USphYU1dQ8mPZZERyw1I/fhwZLV8sVz6JfLBlNFpTv/++aJ82y1DqPbEfHXpYX
         LsrpPusuInIzhnYJSWzNWuTXp97BNM4kKzBVFxruWny+YdoxxtfbuhFsZIjRmKxeug
         21+uMnGQLcrjxSsLVcgOKF5GTleusrY/OerMWG9VECiVf57h/ydc2s8jXW8AOTWR2R
         Blhcl7ZatIKQg==
To:     Jeff King <peff@peff.net>
From:   dooagain <dooagain@protonmail.com>
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: git pull output and case sensitivity.
Message-ID: <_XGWc87b9HPBCDZ95pSmwNOFcZO21Y6bVyNnhhNuowPcM2Fhs5HmCynAqq2nME257bMhQ4w7Qta1dICTCHTlxbQ2NHN_iPYO0NkBYmS9vTI=@protonmail.com>
In-Reply-To: <20230320171602.GB2615782@coredump.intra.peff.net>
References: <-Va6f9aA736sZCXChvTLaUUSpAq9-ooSELLBrqRSXR5zAQwT7QSRryN1SGBWQj7J_KowBmZuhDHwIwAkrFFfyelwtkXJ-ri4yLPpmDpBqBU=@protonmail.com> <20230319062239.w37x64knfhfapbsn@tb-raspi4> <20230320171602.GB2615782@coredump.intra.peff.net>
Feedback-ID: 5666827:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not sure if this is helpful, but I documented a simple way to recreate =
the issue I am seeing in the README in the https://github.com/spencerdcarls=
on/test-casing repository.

------- Original Message -------
On Monday, March 20th, 2023 at 11:16 AM, Jeff King <peff@peff.net> wrote:


> On Sun, Mar 19, 2023 at 07:22:40AM +0100, Torsten B=C3=B6gershausen wrote=
:
>=20
> > On Sat, Mar 18, 2023 at 07:21:10PM +0000, dooagain wrote:
> >=20
> > > Thank you for filling out a Git bug report!
> > > Please answer the following questions to help us understand your issu=
e.
> > >=20
> > > What did you do before the bug happened? (Steps to reproduce your iss=
ue)
> > >=20
> > > I configured my git repository to ignore case by executing `git confi=
g core.ignorecase true` then I executed `git pull` multiple times.
> >=20
> > What do you mean by "I configured my git repository" ?
> > The answer is already there, so let's re-rephrase it:
> > Are you working on a case-insensitive file system ?
> >=20
> > What happens if you create a test directory, like this:
> > mkdir test-case
> > cd test-case
> > git init
> > git config --get core.ignorecase
>=20
>=20
> I think this is kind of a red herring, isn't it? The bug report is about
> refs, and I don't think those really respect core.ignorecase either way,
> and inconsistencies are known to happen on case-insensitive filesystems
> (because the refs are sometimes case-sensitive and sometimes not
> depending on whether they are packed or loose in the filesystem).
>=20
> So I think this is just a known gotcha, and the path forward is probably
> a new ref storage format that doesn't rely on storing names directly in
> the filesystem (reftable, or some system based on packed-ref slices).
>=20
> -Peff
