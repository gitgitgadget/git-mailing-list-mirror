From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 6/6] completion: clarify ls-tree, archive, show completion
Date: Mon, 3 Jun 2013 21:25:55 +0200
Message-ID: <20130603192555.GK2192@goldbirke>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
 <1370181822-23450-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 21:26:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjaOH-0002Ws-Nm
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 21:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756949Ab3FCTZ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 15:25:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:63592 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833Ab3FCTZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 15:25:57 -0400
Received: from localhost6.localdomain6 (f051128111.adsl.alicedsl.de [78.51.128.111])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MXXss-1Uw9Ar41lm-00WYH3; Mon, 03 Jun 2013 21:25:56 +0200
Content-Disposition: inline
In-Reply-To: <1370181822-23450-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:xOg+eisl8s9bJ3ARXWVEDamQU5LPwGaxsb6b+SG3um7
 wYOOTUOky5iKdFNj50wTF41w8YnKeRre28XtGHDlmNxZVejEV8
 euL+HqqGndAxGrff8q1GRPBuJwuOcLo7sIN2kuglwRVyR+YqYR
 fezHNUFslSJbuHafT70cBStbJotUKLeCt4Vc/EFX4wUqyj/ua2
 oWSf3/13hUxZoEenUEmoDnuaK/OxPk8y9yKY4ds5yMmvM+4Kye
 Ra1tYioCYkhuU27yp3XkvG5E+pq/YkBZyAMpRMs3OFMd6/YnMz
 BhOfpS96tSqgZKNfAg1hyw1x0jHVVPee1jx6ems11B1w4JxUYs
 ug0CU+/IMEUX9dTI+zgF5gnVDt3Erw661H5/3EUwn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226272>

On Sun, Jun 02, 2013 at 07:33:42PM +0530, Ramkumar Ramachandra wrote:
> Currently, the 'git ls-tree', 'git archive', and 'git show' completio=
ns
> use __git_complete_file (aliased to __git_complete_revlist_file).
>=20
> In the case of 'git ls-tree' and 'git archive', they necessarily requ=
ire
> a tree-ish argument (and optionally a pathspec filter, or "file
> argument"):
>=20
>   $ git ls-tree hot-branch git.c
>   $ git archive HEAD~4 git.c
>=20
> So, __git_complete_file is a misleading name.
>=20
> In the case of 'git show', it can take a pathspec and default the
> revision to HEAD like:
>=20
>   $ git show git.c
>=20
> (which is useful if git.c was modified in HEAD)
>=20
> However, this usage is not idiomatic at all.  The more common usage i=
s
> like:
>=20
>   $ git show HEAD~1
>   $ git show origin/pu:git.c
>=20
> So, __git_complete_file is again a poor name.
>=20
> Replace these three instances of __git_complete_file with
> __git_complete_revlist_file, without making any functional changes.
>=20
> Remove __git_complete_file, as it has no other callers.
>=20

Well, people out there might have completion scriplets for their
aliases or custom git commands which use __git_complete_file().
Removing this function would break those scripts.

Arguably the name of __git_complete_file() could describe better what
the function does, or what it did, i.e. it used to provide completion
for the master:Doc<TAB> notation.  But that's only the name.  Since
both git ls-tree and git archive understand this notation, calling the
helper for master:Doc<TAB> in their completion functions is not
misleading at all.

Now, __git_complete_revlist_file() provides completion both for this
master:Doc<TAB> notation and for revision ranges, i.e. for
master..n<TAB> and master...n<TAB>.  However, since neither git
ls-tree nor git archive accept revision ranges, calling
__git_complete_revlist_file() in their completion function would be
misleading.

git show is special, as it understands both the master:Doc<TAB>
notation and revision ranges, and even the combination of the two, so
calling __git_complete_revlist_file() there would indeed be better.


G=E1bor
