Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02B920373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbdCMVgh (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:36:37 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:43796 "EHLO
        homiemail-a23.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751686AbdCMVgf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Mar 2017 17:36:35 -0400
Received: from homiemail-a23.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a23.g.dreamhost.com (Postfix) with ESMTP id 738ED4B008F;
        Mon, 13 Mar 2017 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=I0sHJ
        52azG0XHmqxMRdhgJu02NE=; b=NFZphLBvozBBXIDHto3hGjislpWu8g2hTjZy8
        M9UXE9Lkq8ihndL65EtcOCJjFgSdXc6eNJY9kmL8iC9WTesj9yY+gj/J4ACqCNZz
        oULVjCaajZZsAMjGByFZJpG4Vm7Bu69CgAaf6HgRXcnx/Ehbe5130zgYLwnh63k0
        K9UUAI=
Received: from corey (gzac12-mdf2-1.aoa.twosigma.com [208.77.215.155])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a23.g.dreamhost.com (Postfix) with ESMTPSA id 23BDC4B0089;
        Mon, 13 Mar 2017 14:36:34 -0700 (PDT)
Message-ID: <1489440993.10192.58.camel@novalis.org>
Subject: Re: bug?: git reset --mixed ignores deinitialized submodules
From:   David Turner <novalis@novalis.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Mon, 13 Mar 2017 17:36:33 -0400
In-Reply-To: <CAGZ79ka=OwSWGDBqiZ5X9LvOXphFe5=QjmH9DoeWLu2svmVtyg@mail.gmail.com>
References: <1489180018.10192.45.camel@novalis.org>
         <CAGZ79kZmWaobW9e4iPY05y0N6PLcFphGnZmDHtrGKeV0Up70vg@mail.gmail.com>
         <1489430233.10192.56.camel@novalis.org>
         <CAGZ79ka=OwSWGDBqiZ5X9LvOXphFe5=QjmH9DoeWLu2svmVtyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-03-13 at 14:19 -0700, Stefan Beller wrote:
> > > The change is not really lost, as you can get it via
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0git checkout HEAD@{1}
> > > =C2=A0=C2=A0=C2=A0=C2=A0git submodule update --init
> >=20
> > Sure, the commit isn't lost entirely.=C2=A0=C2=A0But a mixed reset is=
 often
> > used
> > to mean "go back to before I committed", and here, that's not
> > precisely
> > what's happening.
>=20
> Well, you ran the deinit after the commit, so I don't think
> we expect to undo everything up to "just before the commit".

Sure, but other workdir changes after the commit would have been blown
away; so why not this one?

> > > * lack of --recurse-submodules in git-reset? (and that not
> > > =C2=A0 being default, see prior point)
> >=20
> > Or possibly this.
>=20
> Well even in this case a reset recursing into submodules doesn't
> change the (de-)init status of a submodule. All it would alter is the
> submodule HEAD pointing to, IMHO.

That's OK with me.  It's weird, but at least it's explicable.=20

> > For me, the bug (if any) is the bad user experience of doing a
> > mixed
> > reset and expecting to be able to commit (possibly with some git-
> > add
> > operations) from there and get back something like the commit to
> > which
> > the user had git-reset.
>=20
> Technically this is also doable,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0git reset --mixed HEAD^ # as in the original em=
ail
> =C2=A0=C2=A0=C2=A0=C2=A0git update-index --add --cacheinfo \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0160000,$(git -C .git/mo=
dules/sub1 rev-parse HEAD),sub1
> =C2=A0=C2=A0=C2=A0=C2=A0git add another_file
> =C2=A0=C2=A0=C2=A0=C2=A0git commit -m "recreate the commit"

Yeah, unless the user had done various other operations that messed
with .git/modules/sub1 (e.g. if they had first checked out another
branch with --recurse-submodules).

Also, this updates the index, which a mixed reset isn't supposed to
touch.=20

> > That's why I have the question mark there -- it's not clear that
> > this
> > is a reasonable expectation.
>=20
> Fuzzing around with gitlinks that are non-populated submodules is
> a messy business.

Agreed.

> So another way would be to populate the submodule manually
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0GIT_DIR=3D.git/modules/sub1 \
> =C2=A0=C2=A0=C2=A0=C2=A0GIT_WORKTREE=3Dsub1 \
> =C2=A0=C2=A0=C2=A0=C2=A0git checkout -f # implies last HEAD
>=20
> and then continue in the superproject.

(see above for why this is not a general solution)

> I am making up excuses for poor UX here, though.
> I do agree that the expectations may vary wildly because of poor UX
> in submodules.

I agree that it's not quite clear what to expect.  I can just say that
I was quite surprised when my colleague demoed this one for me.

