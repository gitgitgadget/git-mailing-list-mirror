Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1101FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbdCMShR (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:37:17 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:36841 "EHLO
        homiemail-a17.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751563AbdCMShP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Mar 2017 14:37:15 -0400
Received: from homiemail-a17.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a17.g.dreamhost.com (Postfix) with ESMTP id 8E3C82B206E;
        Mon, 13 Mar 2017 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=B5QC/
        0lvI9hxi/DR+I8jnZpevjc=; b=o0Pkpp2L7xiAnHjjKAI7d2cKOpbSjHVYiEyP3
        VhjtOT48UJsTCMOfCpOQVXTU+ZHWE5uZizx+5c8477x5AuyIC7HBqhVhkgVNCU6s
        ABpkhTKBhrx88SeQMHk33bYnLfd+ySytU8C9E3JN/ry8VeIllNQRPe4ldizZkLCW
        hP/12Q=
Received: from corey (gzac12-mdf2-1.aoa.twosigma.com [208.77.215.155])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a17.g.dreamhost.com (Postfix) with ESMTPSA id 4000E2B206A;
        Mon, 13 Mar 2017 11:37:14 -0700 (PDT)
Message-ID: <1489430233.10192.56.camel@novalis.org>
Subject: Re: bug?: git reset --mixed ignores deinitialized submodules
From:   David Turner <novalis@novalis.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Mon, 13 Mar 2017 14:37:13 -0400
In-Reply-To: <CAGZ79kZmWaobW9e4iPY05y0N6PLcFphGnZmDHtrGKeV0Up70vg@mail.gmail.com>
References: <1489180018.10192.45.camel@novalis.org>
         <CAGZ79kZmWaobW9e4iPY05y0N6PLcFphGnZmDHtrGKeV0Up70vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-03-13 at 10:51 -0700, Stefan Beller wrote:
> On Fri, Mar 10, 2017 at 1:06 PM, David Turner <novalis@novalis.org>
> wrote:
> > Git reset --mixed ignores submodules which are not
> > initialized.=C2=A0=C2=A0I've
> > attached a demo script.
> >=20
> > On one hand, this matches the documentation ("Resets the index but
> > not
> > the working tree").=C2=A0=C2=A0But on the other hand, it kind of does=
n't:
> > "(i.e.,
> > the changed files are preserved but not marked for commit)".
> >=20
> > It's hard to figure out what a mixed reset should do.=C2=A0=C2=A0It w=
ould be
> > weird for it to initialize the submodule.=C2=A0=C2=A0Maybe it should =
just
> > refuse
> > to run?=C2=A0=C2=A0Maybe there should be an option for it to initiali=
ze the
> > submodule for you?=C2=A0=C2=A0Maybe it should drop a special-purpose =
file
> > that
> > git understands to be a submodule change?=C2=A0=C2=A0For instance (an=
d this
> > is
> > insane, but, like, maybe worth considering) it could use extended
> > filesystem attributes, where available.
> >=20
> > #!/bin/bash
> > mkdir demo
> > cd demo
> >=20
> > git init main
> >=20
> > (
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git init sub1 &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cd sub1 &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dd if=3D/dev/urandom =
of=3Df bs=3D40 count=3D1 &&
>=20
> We prefer reproducability in tests, so if we take this into
> a (regression) test later we may want to
> =C2=A0=C2=A0=C2=A0=C2=A0s/dd.../echo "determinism!" >f/

Yeah, that was leftover from some previous version of this script, I
think.   This wasn't intended to be a t/ test, since I don't know what
the right answer is -- just a demo in case my prose was unclear.

> > # commit that change on main,=C2=A0=C2=A0deinit the submodule and do =
a mixed
> > reset
> > (
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cd main &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git add sub1 &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git commit -m 'update=
 sub1' &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git submodule deinit =
sub1 &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git reset --mixed HEA=
D^ &&
>=20
> As of now most commands (including reset)
> are unaware of submodules to begin with.
> They are ignored in most cases, i.e. git-status
> has some tack-on to (pseudo-)report changes
> in submodules, but it's not really builtin.
>=20
> A submodule that is not initialized
> ( i.e. submodule.<name>.url is unset) ought
> to not be touched at all. This is spelled out in
> the man page for "submodule update" only at this
> point.
>=20
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git status # change t=
o sub1 is lost
>=20
> The change is not really lost, as you can get it via
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0git checkout HEAD@{1}
> =C2=A0=C2=A0=C2=A0=C2=A0git submodule update --init

Sure, the commit isn't lost entirely.  But a mixed reset is often used
to mean "go back to before I committed", and here, that's not precisely
what's happening.  In other words, it's not confusing to the user.

> This works most of the time, but it is unreliable as the
> submodule may have had some gc inbetween which
> threw away important objects.

Sure; that's a separate issue.

> Steping back a bit, rereading the subject line,
> what do you think is the bug here?
>=20
> * git-status not reporting about uninitialized submodules?

Here, I think git-status is correctly reporting the state of the repo.

> * git reset --mixed not touching the submodule worktree

Yes, possibly.

> * lack of --recurse-submodules in git-reset? (and that not
> =C2=A0 being default, see prior point)

Or possibly this.

> * submodules being in detached HEAD all the time?

In this case, the submodule is not initialized, so it is not in any
state at all.


For me, the bug (if any) is the bad user experience of doing a mixed
reset and expecting to be able to commit (possibly with some git-add
operations) from there and get back something like the commit to which
the user had git-reset. =20

That's why I have the question mark there -- it's not clear that this
is a reasonable expectation.

