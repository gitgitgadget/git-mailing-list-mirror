From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [SOLVED] `git fetch tag NAME' into mirror repo does not update HEAD, what to do?
Date: Thu, 12 Aug 2010 15:22:54 +0200
Message-ID: <201008121522.55020.brian.foster@innova-card.com>
References: <201008120954.27648.brian.foster@innova-card.com> <201008121416.35887.brian.foster@innova-card.com> <4C63E9E9.7070105@dbservice.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 15:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjXkx-0006TP-Jo
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 15:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760112Ab0HLNXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 09:23:34 -0400
Received: from 6-61.252-81.static-ip.oleane.fr ([81.252.61.6]:60826 "EHLO
	zebulon.innova-card.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760107Ab0HLNXe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 09:23:34 -0400
Received: from localhost ([127.0.0.1])
	by zebulon.innova-card.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 12 Aug 2010 15:23:02 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.28-15-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <4C63E9E9.7070105@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153373>

On Thursday 12 August 2010 14:32:41 Tomas Carnecky wrote:
> On 8/12/10 2:16 PM, Brian Foster wrote:
> >[ ... ]  This _does_ work:
> >=20
> >     git reset --soft FETCH_HEAD
> >[ ... ]=20
> >  Given that git-reset(1)'s purpose is to change the branch's
> >  head (or to change HEAD as I've been incorrectly describing
> >  it), that does make sense.
>=20
> I expected git checkout to work even in a bare repo - as you can
> see I don't work that often inside bare repos :).

 <<<giggles>>>  No problem!  (I don't either, this situation was
 unexpected, but as SLAVE lagging behind ORIG is anticipated as
 being the usual case, we need to understand it.)

> You should use update-ref instead of reset. The problem with reset is
> that it changes the branch and not HEAD. Say initially your mirror ha=
d
> HEAD as symref pointing to refs/heads/master.

 Correct, it does.

>                                               When you run reset --so=
ft
> v2 your master branch will now point to the same commit as the tag v2
> (and HEAD will be still pointing to refs/heads/master).

 Correct, that is what happens.  It also looks Ok to me,
 nor have any tests hit any snags.  It also happens to
 match how we (eventually) manually repaired SLAVE.

>                                                         When you use
> 'git update-ref --no-deref HEAD v2' it will modify HEAD

 NO, it gets an error (following is from a modified version
 of my previously-posted script):
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
 ...
+ cd ../SLAVE.git                                          =20
+ git fetch --verbose origin tag v2                        =20
 ...
=46rom /work/tmp/git/ORIG                     =20
 * [new tag]         v2         -> v2       =20
+ git update-ref --no-deref HEAD v2         =20
error: Trying to write non-commit object 2bc324e6a68cb3704448c9f63ddc3b=
c0260c0b48 to branch HEAD                                              =
                                 =20
fatal: Cannot update the ref 'HEAD'.                                   =
                =20
$=20
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80

 Using =E2=80=98git update-ref --no-deref HEAD FETCH_HEAD=E2=80=99 does
 not error, and, as you say (below), does seem to give
 me a detached head.

> 'git update-ref --no-deref HEAD v2' it will modify HEAD directly and
> have it point directly to the same commit as v2 (also called detached=
 HEAD).

 I do_not_ want a detached head!  This has perhaps been
 confused by my improperly saying =E2=80=9Cupdate HEAD=E2=80=9D when I
 meant =E2=80=9Cupdate the master branch=E2=80=9D.  If you look back at
 my originally-posted diagrams, it's a reasonable guess
 I don't want a detached head.  Having HEAD continue to
 be a symref to refs/heads/master (which, in this case,
 is the same commit as v2) is correct.

 Thanks for your help, advice, and hints.
cheers!
	-blf-
