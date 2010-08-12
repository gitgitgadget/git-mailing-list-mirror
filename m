From: Brian Foster <brian.foster@innova-card.com>
Subject: [SOLVED] `git fetch tag NAME' into mirror repo does not update HEAD, what to do?
Date: Thu, 12 Aug 2010 14:16:35 +0200
Message-ID: <201008121416.35887.brian.foster@innova-card.com>
References: <201008120954.27648.brian.foster@innova-card.com> <201008121238.51983.brian.foster@innova-card.com> <4C63D579.507@dbservice.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 14:17:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjWil-0003zQ-6g
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 14:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759770Ab0HLMRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 08:17:13 -0400
Received: from 6-61.252-81.static-ip.oleane.fr ([81.252.61.6]:53268 "EHLO
	zebulon.innova-card.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759564Ab0HLMRN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 08:17:13 -0400
Received: from localhost ([127.0.0.1])
	by zebulon.innova-card.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 12 Aug 2010 14:16:43 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.28-15-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <4C63D579.507@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153367>

On Thursday 12 August 2010 13:05:29 Tomas Carnecky wrote:
> On 8/12/10 12:38 PM, Brian Foster wrote:
> > On Thursday 12 August 2010 10:33:13 Tomas Carnecky wrote:
> >[ ... ]
> >> Fetch only fetches commits. It doesn't update any local refs (othe=
r than
> >> FETCH_HEAD). If you want to switch HEAD to that new tag, use check=
out.
>=20
> Oh boy, that explanation is really bad -.- What I meant is that if
> you don't supply the <dst> part of the refspec it will only update
> FETCH_HEAD. So 'git fetch origin master' will not update anything
> but FETCH_HEAD.

 I concur.  However, the =E2=80=9Crefspec=E2=80=9D in this case is the =
obscure
 =E2=80=98tag TAGNAME=E2=80=99 (where the =E2=80=98tag=E2=80=99 is a ke=
yword); see get-fetch(1)
 at the end of =C2=A7OPTIONS where it describes =E2=80=9Cshort-cut nota=
tions=E2=80=9D.
 That does not seem to accept a :<dst>, nor would I be too sure
 what it meant if it did.

> >  No, a fetch in a mirror, when fetching all the way
> >  to the HEAD (e.g., a simple `git fetch origin'),
> >  does update the branch.  [ ... ]
>=20
> There are different ways to invoke git fetch. Either way, fetch will
> never modify HEAD. However, it can modify the branch that HEAD is
> pointing to (in case HEAD is a symref).=20

 Point taken, I was being sloppy.  We want the head of the
 relevant branch (master) to be updated in our bare (mirror)
 repository.

>                                         But you are not fetching a
> branch, you are fetching a tag. So you need to use checkout after you
> fetch it. Either 'git checkout FETCH_HEAD' or 'git checkout v2'.

 NO.  =E2=80=98get checkout ...=E2=80=99 does not work in a bare reposi=
tory.
 (You can modify my trivial posted script to prove this.)

 However, your comment got me to thinking.  This _does_ work:

    git reset --soft FETCH_HEAD

 (And, I presume without testing, so would =E2=80=98... v2=E2=80=99 ?)
 Given that git-reset(1)'s purpose is to change the branch's
 head (or to change HEAD as I've been incorrectly describing
 it), that does make sense.

cheers!
	-blf-
