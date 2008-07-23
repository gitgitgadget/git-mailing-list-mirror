From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 12:56:07 +0200
Message-ID: <20080723105607.GB9888@atjola.homenet>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet> <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>, spearce@spearce.org,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 12:57:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLc1t-0005jH-C0
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 12:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbYGWK4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 06:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbYGWK4L
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 06:56:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:47355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750893AbYGWK4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 06:56:10 -0400
Received: (qmail invoked by alias); 23 Jul 2008 10:56:08 -0000
Received: from i577BBDAB.versanet.de (EHLO atjola.local) [87.123.189.171]
  by mail.gmx.net (mp003) with SMTP; 23 Jul 2008 12:56:08 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18mor04xyAmFpH5sM2r6LOQu8Umcj6MC7zJg2drBl
	iwu8KFGCY0mVhP
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89628>

On 2008.07.23 12:49:04 +0200, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 23 Jul 2008, Bj=C3=B6rn Steinbrink wrote:
>=20
> > On 2008.07.23 01:17:45 +0200, Pierre Habouzit wrote:
> > >   Hi, here is a manual painful down-secting (opposed to a bisect =
;P) I
> > > did, since git in next cannot fetch on a regular basis for me. Th=
e
> > > culprit seems to be commit  92392b4:
> > >=20
> > >     =E2=94=8C=E2=94=80(1:11)=E2=94=80=E2=94=80<~/dev/scm/git 9239=
2b4...>=E2=94=80=E2=94=80
> > >     =E2=94=94[artemis] git fetch
> > >     remote: Counting objects: 461, done.
> > >     remote: Compressing objects: 100% (141/141), done.
> > >     remote: Total 263 (delta 227), reused 155 (delta 121)
> > >     Receiving objects: 100% (263/263), 95.55 KiB, done.
> > >     fatal: Out of memory, malloc failed
> > >     fatal: index-pack failed
> > >     [2]    16674 abort (core dumped)  git fetch
> > >=20
> > >     =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 9239=
2b4...>=E2=94=80=E2=94=80
> > >     =E2=94=94[artemis] git checkout -m HEAD~1; make git-index-pac=
k
> > >     Previous HEAD position was 92392b4... index-pack: Honor core.=
deltaBaseCacheLimit when resolving deltas
> > >     HEAD is now at 03993e1... index-pack: Track the object_entry =
that creates each base_data
> > >     GIT_VERSION =3D 1.5.6.3.3.g03993
> > > 	CC index-pack.o
> > > 	LINK git-index-pack
> > >=20
> > >     =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 0399=
3e1...>=E2=94=80=E2=94=80
> > >     =E2=94=94[artemis] git fetch
> > >     remote: Counting objects: 461, done.
> > >     remote: Compressing objects: 100% (141/141), done.
> > >     remote: Total 263 (delta 227), reused 155 (delta 121)
> > >     Receiving objects: 100% (263/263), 95.55 KiB, done.
> > >     Resolving deltas: 100% (227/227), completed with 153 local ob=
jects.
> > >     From git://git.kernel.org/pub/scm/git/git
> > >        5ba2c22..0868a30  html       -> origin/html
> > >        2857e17..abeeabe  man        -> origin/man
> > >        93310a4..95f8ebb  master     -> origin/master
> > >        559998f..e8bf351  next       -> origin/next
> > >=20
> > > You can see the commit sha's in the prompt. 03993e1 is fine, 9239=
2b4 is
> > > broken, I've absolutely no clue about what happens.
> > >=20
> > > All I can say is that at some point in get_data_from_pack, obj[1]=
=2Eidx
> > > points to something that is *not* a sha so it's probably corrupte=
d.
> > > (from index-pack.c).
> >=20
> > Here's how to reproduce:
>=20
> Funny.  That does not reproduce the bug here at all.
>=20
> But then, it is unsurprising, since both Pierre and me did something=20
> similar yesterday, fetching _just_ the pre-fetch refs into a freshly=20
> initted Git repository, and then fetching from kernel.org.
>=20
> Tested on x86_64.

Weird. Same arch here. And it's 100% reproducable so far (around 25
times now, I guess).

Bj=C3=B6rn
