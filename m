Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 6728 invoked by uid 107); 24 Aug 2009 07:53:57 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 03:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbZHXHxc (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 03:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbZHXHxc
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 03:53:32 -0400
Received: from fn.samba.org ([216.83.154.106]:59754 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbZHXHxb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 03:53:31 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Aug 2009 03:53:31 EDT
Received: from ip6-localhost (localhost [127.0.0.1])
	by lists.samba.org (Postfix) with ESMTP id 11A3DACFAE;
	Mon, 24 Aug 2009 01:39:10 -0600 (MDT)
From:	Kai Blin <kai@samba.org>
Organization: Samba Team
To:	Sanjiv Gupta <sanjiv.gupta@microchip.com>
Subject: Re: Pulling one commit at a time.
Date:	Mon, 24 Aug 2009 09:46:46 +0200
User-Agent: KMail/1.9.10
Cc:	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com> <20090824060710.6117@nanako3.lavabit.com> <4A92318F.6050105@microchip.com>
In-Reply-To: <4A92318F.6050105@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6996735.Z8dXZz5SVX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200908240946.52813.kai@samba.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

--nextPart6996735.Z8dXZz5SVX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 24 August 2009 08:22:07 Sanjiv Gupta wrote:

> > In general the public history isn't necessarily a single straight line
> > like this picture and it doesn't make sense to merge one at a time for
> > all the commits on the public branch, but if that is what you really wa=
nt
> > to do, you can do so.
>
> Excellent description. Thanks for that. I want to merge commits one by
> one because I want to run a regression suite on each commit and
> therefore know if any one is causing failures.

What I do for a case like this is using rebase. I'm not sure if I get the=20
explanation right enough to please all the git gurus on the list, but I'll=
=20
try. What this basically does is to back out all the commits you did on you=
r=20
branch to the point you diverged from the branch you're rebasing on now.

So assuming you had a structure like this:

           your 'master' HEAD
             |
     A---B---C
    /
=2D--X---U---V---W---Y
                   |
                public 'master' HEAD

git would back out commits A-C, so your local branch HEAD would be at X. Th=
en,=20
if forwards your branch to the branch you're rebasing on, so your local=20
branch HEAD is at Y now, like the public branch HEAD.

After that, git applies all of your patches back to your local branch,=20
producing a tree that looks like this:

                           your 'master' HEAD
                             |
                     A---B---C
                    /
=2D--X---U---V---W---Y
                   |
              public 'master' head

Personally I prefer that solution as it keeps the history linear. Of course=
=20
this means that all of your commits change sha1s, and you should not do thi=
s=20
on public branches with tags. But if you're still developing, it's much=20
easier to wrap your head around a history like this. It's also nice to=20
present feature branches to other people, as all of your commits are in one=
=20
block, without lots of annoying merge commits between them.

rebase also handles more complicated cases of merging, but from the way I=20
understood your issue, this should already help.

Cheers,
Kai
=2D-=20
Kai Blin
WorldForge developer  http://www.worldforge.org/
Wine developer        http://wiki.winehq.org/KaiBlin
Samba team member     http://www.samba.org/samba/team/
=2D-
Will code for cotton.

--nextPart6996735.Z8dXZz5SVX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBKkkVsEKXX/bF2FpQRAjPdAJsGdw6q5sqHW3PZBBT+5gNvlQedygCeNqeX
Im0HdSqRnHxEpPOkfDSpIlM=
=J7gH
-----END PGP SIGNATURE-----

--nextPart6996735.Z8dXZz5SVX--
