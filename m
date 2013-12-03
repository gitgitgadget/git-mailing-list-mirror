From: =?utf-8?B?UGF3ZcWC?= Sikora <pawel.sikora@agmk.net>
Subject: Re: slow git-cherry-pick.
Date: Tue, 03 Dec 2013 20:31:26 +0100
Message-ID: <2679995.THr9ekVpkO@localhost.localdomain>
References: <2142926.gg3W3MsbJZ@localhost.localdomain> <32998962.pucYdvRloz@localhost.localdomain> <xmqqd2loz92n.fsf@gitster.dls.corp.google.com>
Reply-To: pawel.sikora@agmk.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:31:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnvhF-0002Sa-E1
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab3LCTbp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 14:31:45 -0500
Received: from adamg.eu ([91.192.224.99]:33658 "EHLO adamg.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610Ab3LCTbn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Dec 2013 14:31:43 -0500
Received: from mail.agmk.net ([91.192.224.71]:37470)
	by adamg.eu with esmtp (Exim 4.82)
	(envelope-from <pluto@agmk.net>)
	id 1Vnvh1-0000tK-Nq; Tue, 03 Dec 2013 20:31:36 +0100
Received: from localhost.localdomain (unknown [185.28.248.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pluto@agmk.net)
	by mail.agmk.net (Postfix) with ESMTPSA id 2F37A1EE65E5;
	Tue,  3 Dec 2013 20:31:20 +0100 (CET)
User-Agent: KMail/4.11.3 (Linux/3.11.10-300.fc20.x86_64; KDE/4.11.3; x86_64; ; )
In-Reply-To: <xmqqd2loz92n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238723>

On Monday 25 of November 2013 09:26:40 Junio C Hamano wrote:
> Pawe=C5=82 Sikora <pawel.sikora@agmk.net> writes:
> > On Sunday 24 of November 2013 19:47:10 Duy Nguyen wrote:
> >> On Sun, Nov 24, 2013 at 5:45 PM, Pawe=C5=82 Sikora <pawel.sikora@a=
gmk.net>=20
wrote:
> >> > i've recently reinstalled a fresh system (fc20-beta) on my works=
tation
> >> > and observing a big slowdown on git cherry-pick operation
> >> > (git-1.8.4.2-1).
> >> > the previous centos installation with an old git version works f=
aster
> >> > (few seconds per cherry pick). now the same operation takes >1 m=
in.
> >>=20
> >> What is the git version before the reinstallation?
> >=20
> > git-1.7.11.3-1.el5.rf.
> >=20
> > i've checked this version on another machine with centos-5.$latest
> > and it does similar amout of stat/read operation quickly (~6s).
> > this "fast" centos-5 machine has /home on raid-0 (2x500GB) while
> > my "slow (>1min)" workstation has /home on linear lvm (250G+1T).
> >=20
> > so, i suppose that my "slow" working copy crosses disks boundary
> > or spread over 1TB drive and the random git i/o impacts performance=
=2E
> >=20
> > the question still remains - does the git need to scan whole checko=
ut
> > during picking well defined set of files?
>=20
> We do update-index to see what local changes you have upfront in
> order to avoid stomping on them (and we do not know upfront what
> paths the cherry-picked commit would change, given that there may be
> renames involved), so the answer is unfortunately yes, we would need
> to do lstat(2) the whole thing.

this is quite weird for me (user). git pull also fetches objects from
server and aborts user's action if working copy contains uncommitted
modifications on files that will be modified by incoming objects.

from the other side, the cherry-pick needs to stat() the whole working
copy to achieve similar precondition. looks like suboptimal implementat=
ion.

> Doing that lstat(2) more lazily and do away with the update-index
> might be possible, but I suspect that may be quite a lot of work.

maybe you can use the existing implementation used by 'pull' ?


--=20
gpg key fingerprint =3D 60B4 9886 AD53 EB3E 88BB  1EB5 C52E D01B 683B 9=
411
