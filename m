From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] t3600: fix broken "choking git rm" test
Date: Wed, 16 Oct 2013 02:38:46 +0200
Message-ID: <20131016003846.GU19704@goldbirke>
References: <1381881687-11179-1-git-send-email-szeder@ira.uka.de>
 <20131016001804.GJ9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 02:38:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWF8W-0008Iy-FC
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 02:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759887Ab3JPAis convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 20:38:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:53160 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759792Ab3JPAir (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 20:38:47 -0400
Received: from localhost6.localdomain6 (g226140223.adsl.alicedsl.de [92.226.140.223])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MJHCg-1VUbVc15vm-0032Z6; Wed, 16 Oct 2013 02:38:46 +0200
Content-Disposition: inline
In-Reply-To: <20131016001804.GJ9464@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:bZj7qoOGvZr+ya+zun7zH318fwhNr7H8QHJecvdMIsJ
 HlwYU3x5Y3Y+lOi8pbH8In8Si/VY/Bc4rv8H+pKo//4OkTX9oU
 eMODD3mPFr6xYTBZK93ztjySswhomXAHx85SeW/libE1YZdxVX
 zVUKdSQXAlQ79kOdZuhkEd5zz3/FvaLspoHEMnFtJSmrAIGj9B
 xP2vveAyuOffore8VFEH73WT8VLyEKcjOA93/8PqJpVnLo0tRl
 QOPZXH3rO1KrXpYg2+vVMLKK3I8oZG8l/tlwTaKQcqlHQl03bY
 v/91hEP70XE1p6OIhpepu98w9kOWk1lbA5t7DJJepp+cwn4ZcL
 txkJrJy1TrvF3V4ucWRzLsGIrlVkNgntvgWB7KOIh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236226>

On Tue, Oct 15, 2013 at 05:18:04PM -0700, Jonathan Nieder wrote:
> SZEDER G=E1bor wrote:
> > --- a/t/t3600-rm.sh
> > +++ b/t/t3600-rm.sh
> > @@ -240,18 +240,15 @@ test_expect_success 'refresh index before che=
cking if it is up-to-date' '
> > =20
> >  test_expect_success 'choking "git rm" should not let it die with c=
ruft' '
> >  	git reset -q --hard &&
> > +	test_when_finished "rm -f .git/index.lock ; git reset -q --hard" =
&&
>=20
> I'd use "&&" here --- the test_cleanup checks the exit status from
> this scriptlet, so it's a good habit.

OK.  My motivation for the ';' was that we should make sure that both
steps of the cleanup are executed.  However, now thinking about it if
regular 'rm -f' can't remove the lock file then all bets are off
anyway.

> [...]
> > -	test -f .git/index.lock
> > -	status=3D$?
> > -	rm -f .git/index.lock
> > -	git reset -q --hard
> > -	test "$status" !=3D 0
> > +	test ! -f .git/index.lock
>=20
> Gah.  Thanks for cleaning it up.
>=20
> Maybe test_path_is_missing would make sense here?  (It would notice a
> .git/index.lock directory, which is not very likely :), but more
> importantly, it says why it is failing the test when it fails.)

I was not aware of the test_path_is_missing helper.  I don't think it
matters whether it's a file or a directory, because a stale
=2Egit/index.lock directory would be just as bad.
