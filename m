Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA055C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 23:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CBD2173E
	for <git@archiver.kernel.org>; Fri,  8 May 2020 23:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IqgJvzZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgEHXpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 19:45:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:45389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbgEHXpS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 19:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588981502;
        bh=Kkjru1qhe3Jl2mD/t6RloeAZDqZ9YEkY+uwOeeXRpOI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IqgJvzZHkG57hzj11IZG4PsrApeYoAAz5VxAY7yaKNvydl1zGqLT1JBK7N/lcK21t
         FVVRJIttxWD8wEuGi1pYMdD7l3Y+Y5FWAPtntCg+jFI0V6FIFKaV03LkLXDw7XVcLU
         QE2sqExlSj+bdttjaVJlYOjZFtXQTC2//tYVnEPA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([213.196.212.13]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49lD-1j6I1P1qXR-0106yg; Sat, 09
 May 2020 01:45:02 +0200
Date:   Sat, 9 May 2020 01:45:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
In-Reply-To: <20200507191714.GA25306@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2005090112530.56@tvgsbejvaqbjf.bet>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com> <20200504213326.GA31037@coredump.intra.peff.net> <20200504220916.GF45250@syl.local> <xmqqv9la9lbn.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2005062334170.56@tvgsbejvaqbjf.bet>
 <20200507191714.GA25306@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yQGK/rOJv5cP2CN4/dipC99t8lD5WG9HohyAu7IH+2yG7LWJ7GL
 Hkm63D9GHL18IHUBR4lmYwi4cXNc440rPY1sPD2SDosOWuicJAnSWltkkbgID8zzcktqNpO
 fnVLLBvxaePOpp9XM6y21V9v2Y3nKB4WOeVVFM5hC1es9XjCPdFZBMPISy64HQ72+ssT00t
 lUKcY17LM+NtNVsueht8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/BgHoNPYf2g=:CcYq6oZ6cMZlCxscl15wB7
 UrDw6l7Q/kqNXDjKsB8fXBzb1v8M15eAfLtcAmscAakhkraBchC10/4QkKBTYVHKHr3AompsD
 abFEquTqturSVQKZWkWDN9OAsA5fJgedm0Ks/uUTtXNeQ1mRYoknDmNt7PGi9kdsmK9y+b8f/
 Ueo+6clwlhBSt69fphfUUKB3Z/I76fGgmfWaYhwolxzHcsuOd8L9GyYmj8R5FRSB7+BjE6lMg
 /yQ4h/5LhYMIkm4+EpsGoQHbhcnUfC6X5VRqVjRXFvzJZOF0i4aS8dDygPQ+D0j6cOfuxomyS
 4pKV+X5gjE1mVAAHAAS1ZBekTGI6PxWcJbLsBXlt8Z3QLc7dyAWkgL0S2x5FSNqn7EOcYl2Dj
 sVstyVC59IUPPSBiuMq9ymJZfEHNNzghYPkNt/W6Fp/FUfNDVt5VOWLRVlqnWtmpiaWHkm5c9
 y09yOgSFOnOpYSj4mh784UaLWmLfuh16zYXxAgeb1eRrOKK6V5W34NCxhx7f6dk4O5vBPGSzY
 QIaov45OjwefMG1Xmp1l7sj0JR8LHr7pVtzzzrDLXg1s/fMc4wXHzbI45ZJHSFZMW5QFEvHLE
 FiUKAqugfkT8ODB+iYQ9857ylzOW1vFKTo+eXBH9XSFeIipe0j0Bnfj0nI1PvkcpXBL38W45y
 9KkG1a+E8SAcFnE2aPpxrXH/2MY0ePESBz5hPy9H0eDuIJmT9zWNgmQAA1X+KyM3Dwa2B/AYT
 FPJWIVCceSKvKS8pOF/rZ0zI+GgjRDAn9fXGxy6/ctnE0n156tuzg1gXlvDMS/bknQH9YBRaN
 Ngfs3bWTkLkR7YqDFthyR531DXL7tbJlfsCSzNImXoNcgNj09tVo1Y3jml2EhFMQ5T9LL7u+4
 NLvvPg9SOdj9NtpFOpmO/a7YeEtFEIY6mdnZ257490swYQWPiHGmqsRobQ+Bh9PE6+vuI889W
 2e+meO4kdLANaZxODkNdVAX+Xi79rUL0MMkEaTBfWIcPh9BIeJbOt2/6Pm/hAK9k6h1Obu9sQ
 qtrFw9TvBkjRKS9ZTqdyAlWOkczw3Cw9x62KOMLN8NDTi1VXk0YCjfHdcIPXZHfatvrIbMP6c
 M/SymsPMzdRWHTEl+wmqiuf85WhSI43dl5Gxzwz20HEBmupk9wT3yFBzjGNKihK3MiycHiOV4
 NChkd//EygcM2wLJVro2KDFqHkqjKCMRXo1JviI90FoLrkkMSfRhDPdyDCXHhmR/AbEtzPTvR
 2Uwp5IyzOaBNLzU97
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,


On Thu, 7 May 2020, Jeff King wrote:

> On Wed, May 06, 2020 at 11:35:48PM +0200, Johannes Schindelin wrote:
>
> > > >> > +				next[i] =3D next[i2];
> > > >> > +				next[i2] =3D i;
> > > >> > +				continue;
> > > >> > +			}
> > > >>
> > > >> I do have one question, though. What happens if we add a second
> > > >> fixup-of-a-fixup?
> > > >
> > > > Thanks for asking this question, I was a little curious about it, =
too.
> > >
> > > Interesting that three people looked at the same patch and asked the
> > > same question in different ways ;-)
> >
> > Indeed!
> >
> > I am very grateful, as I had missed that, and it helped me figure out =
a
> > better way to do it, and v2 looks a lot nicer, too.
>
> OK, so your v2 addresses that. Does that mean it was broken in v1?

Yes.

> If so, then why didn't my test reveal it?

Let's disect this:

 i  hash oneline
#0  1234 foo
#1  5678 !fixup foo
#2  abcd !fixup 5678
#3  dbaf !fixup 5678

Let's follow the original code, i.e. before my v1:

When #1 is processed, i.e. when `i =3D=3D 1`, it finds `i2 =3D=3D 0` as ta=
rget. So
it sets `next[0]` as well as `tail[0]` to 1.

Then #2 is processed, i.e. `i =3D=3D 2`, and it finds `i2 =3D=3D 1` as tar=
get. It
sets `next[1]` as well as `tail[1]` to 2.

Now #3 is processed, i.e. it also finds `i2 =3D=3D 1` as target, so it loo=
ks
at next[1], sees that it is already non-negative, so it sets
`next[tail[1]]`, i.e. `next[2]` to 3. It also sets `tail[1]` to 3, but
nobody cares about that because there is no further todo command.

Now, let's follow the code with my v1:

It actually does the same as before! Why, you ask? Because at no stage is
there any non-negative `next[j]` whose corresponding `tail[j]` is
negative. (Except after #3 was processed, at that stage, `next[2]` is
non-negative but `tail[2]` still is negative, but as I said, noone cares
because there are no remaining todo commands.)

So the crucial part to trigger this bug is to have a regular `fixup!
<oneline>` _between_ the `fixup! <oneline>` and the `fixup! <hash>`
targeting the latter. So I think I can modify your example accordingly:

	1234 foo
	5678 fixup! foo
	90ab fixup! foo
	abcd fixup! 5678
	dbaf fixup! 5678

Or using your actual shell commands:

  git commit -m base --allow-empty
  git commit --squash HEAD -m 'this is the first squash' --allow-empty
  s=3D$(git rev-parse HEAD)
  git commit --fixup HEAD^ --allow-empty # This is the crucial command
  git commit -m "squash! $s" -m 'this is the second squash' --allow-empty
  git commit -m "squash! $s" -m 'this is the third squash' --allow-empty
  git rebase -ki --autosquash --root

Note the cricual command `git commit --fixup HEAD^`. When processing that,
`i =3D=3D 2` and `i2 =3D=3D 0` (as for `i =3D=3D 1`), and before v1, this =
would have
set `next[1]` but `tail[0]`! With v1, this would have led to #4 and #5
being exchanged. With v2, the role of `tail` would have been extended to
not only talk about the beginning of a fixup/squash chain, but about _any_
target of a fixup/squash, even if it is in the middle of a chain.

So why does this work? Why does it still do the right thing _even after_
inserting a fixup in the middle of a chain?

That's the beauty: if I insert anything in the middle of it, the `tail` of
the actual beginning of the fixup/squash chain won't need to be changed.
It still points to the end of that chain.

All I need to ensure is that item `i` is not just appended to the "chain"
starting at `i2`, but that it is _inserted_ at the end of that chain in
case that it is actually part of a larger chain, i.e. that its `next[i]`
is set correctly before making it the immediate successor of the target
commit. Since all of the elements in `next` and `tail` are initialized to
`-1` (i.e. "no next fixup/squash item after this"), it will even do the
right thing when it should actually append: it will set `next[i]` to `-1`
in that case.

> I'm not really doubting that your v2 works so much as trying to
> un-confuse myself about the whole situation (which in turn might lead to
> a more intelligent review).

I wish I was quicker in my responses because I think that this is really
helpful a conversation. By "forcing my hand" on a thorough explanation,
you really help me get clarity for myself about the actual underlying
issues. So even if I still think that v2 is correct after writing up the
above explanation, the degree of my confidence increased substantially.

Thanks,
Dscho
