From: Yann Droneaud <yann@droneaud.fr>
Subject: Re: [PATCH] t9129: fix UTF-8 locale detection
Date: Tue, 18 May 2010 19:08:06 +0200
Message-ID: <1274202486.4228.22.camel@localhost>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr>
	 <4BF2BABC.2010405@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 18 19:08:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEQHb-0006nI-5Y
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 19:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757588Ab0ERRIP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 13:08:15 -0400
Received: from smtp2a.orange.fr ([80.12.242.139]:18949 "EHLO smtp2a.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756029Ab0ERRIL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 13:08:11 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2a13.orange.fr (SMTP Server) with ESMTP id 621738000BAD;
	Tue, 18 May 2010 19:08:08 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2a13.orange.fr (SMTP Server) with ESMTP id 553458000C15;
	Tue, 18 May 2010 19:08:08 +0200 (CEST)
Received: from iago.mandriva.com (LPuteaux-156-16-100-40.w80-12.abo.wanadoo.fr [80.12.80.40])
	by mwinf2a13.orange.fr (SMTP Server) with ESMTP id 4688B8000C16;
	Tue, 18 May 2010 19:08:08 +0200 (CEST)
X-ME-UUID: 20100518170808289.4688B8000C16@mwinf2a13.orange.fr
Received: by iago.mandriva.com (Postfix, from userid 10001)
	id 95FF2501; Tue, 18 May 2010 19:08:07 +0200 (CEST)
In-Reply-To: <4BF2BABC.2010405@drmicha.warpmail.net>
X-Mailer: Evolution 2.28.2-1.1mdv2010.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147291>

Le mardi 18 mai 2010 =C3=A0 18:05 +0200, Michael J Gruber a =C3=A9crit =
:
> Yann Droneaud venit, vidit, dixit 18.05.2010 16:41:
> > Since I don't have en_US.utf8, some tests failed:

> >=20
> > On my system locale -a reports:
> >=20
> >    en_US
> >    en_US.ISO-8859-1
> >    en_US.UTF-8
> >=20
>=20
> locale -a|grep en_US
> en_US
> en_US.iso88591
> en_US.iso885915
> en_US.utf8
>=20
> This is on Fedora 13, which is not exactly exotic. What is your syste=
m?
>=20

Mandriva Linux 2009.1 and 2010.0, see results of locale -a :

http://pastebin.mandriva.com/18557
http://pastebin.mandriva.com/18555

I've double check with Mandriva's developers who have

  en_US
  en_US.iso88591
  en_US.utf8
  en_US.UTF-8

> > According to Wikipedia utf8 is not a correct name
> > for the UTF-8 encoding:
> > http://en.wikipedia.org/wiki/UTF-8#Official_name_and_incorrect_vari=
ants
> >=20

UTF-8 seems to be the correct name.

> > =20
> > -if locale -a |grep -q en_US.utf8; then
> > +if locale -a |grep -q en_US.UTF-8; then
> >  	test_set_prereq UTF8
> >  else
> >  	say "UTF-8 locale not available, test skipped"
>=20
> Funny thing is the test succeeds for me, even when run within
> LANG=3Den_US.iso88591.

> So I'd suggest to use
>=20
> -if locale -a |grep -q en_US.utf8; then
> +if locale -a |egrep -q 'en_US.utf8|en_US.UTF-8'; then
>=20
> and embrace for more variants to appear down the road...
>=20

Using en_US.UTF-8 seems more accurate when I wrote the patch since, as =
I
wrote before, compare_svn_head_with() is using LC_ALL=3Den_US.UTF-8.
So en_US.UTF-8 is an alias for en_US.utf8, whatever the canonical
version is.

So let's go for another version.

--=20
Yann Droneaud
