From: =?windows-1252?Q?Carlos_Mart=EDn_Nieto?= <cmn@dwim.me>
Subject: Re: branch --set-upstream-to unexpectedly fails with "starting point ... is no branch"
Date: Mon, 23 Nov 2015 18:04:01 +0100
Message-ID: <15ED3D48-282B-44EF-98C6-EA59F18D633E@dwim.me>
References: <5652F2D2.3050902@syntevo.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 18:12:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0uem-0005wX-HJ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 18:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbbKWRL6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2015 12:11:58 -0500
Received: from hessy.dwim.me ([78.47.67.53]:41757 "EHLO hessy.dwim.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbbKWRL5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2015 12:11:57 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2015 12:11:57 EST
Received: from [192.168.1.4] (p4FC5C8E7.dip0.t-ipconnect.de [79.197.200.231])
	by hessy.dwim.me (Postfix) with ESMTPSA id 641DE81626;
	Mon, 23 Nov 2015 18:04:02 +0100 (CET)
In-Reply-To: <5652F2D2.3050902@syntevo.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281587>

Hello Mark,

On 23 Nov 2015, at 12:04, Marc Strapetz <marc.strapetz@syntevo.com> wro=
te:

> There is a strange "branch --set-upstream-to" failure for "clones" wh=
ich haven't been created using "git clone" but constructed using "git i=
nit", "git remote add" and "git fetch".
>=20
> Following script first creates a "main" repository and then construct=
s the clone. Finally, in the clone branches origin/1 and origin/2 will =
be present, however it's not possible to invoke "git branch --set-upstr=
eam-to" for origin/2 (it works fine for origin/1).
>=20
> I guess the behavior is related to following line in .git/config:
>=20
> fetch =3D refs/heads/1:refs/remotes/origin/1
>=20
> However, I don't understand what's the problem for Git here? Definite=
ly the error "starting point 'origin/2' is not a branch" is wrong.
>=20

That is indeed the issue. The configuration which is stored in the conf=
iguration is a remote+branch pair. If there is no fetch refspec configu=
red which would create the =91origin/2=92 remote-tracking branch, the c=
ommand does not know which remote and branch that would correspond to.

If you had =91refs/heads/2:refs/remotes/origin/2=92 then it would know,=
 but other remote-tracking branches (e.g. =91origin/3=92) would still h=
ave an unknown source.

The error message is indeed bogus; it=92s likely one of the functions a=
ssuming how it=92s going to be used.

   cmn
