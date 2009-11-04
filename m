From: "Joshua J. Kugler" <joshua@eeinternet.com>
Subject: Re: Problem signing a tag
Date: Wed, 04 Nov 2009 10:47:49 -0800
Organization: EE Internet
Message-ID: <200911040947.50226.joshua@eeinternet.com>
References: <200911021558.17550.joshua@eeinternet.com>
 <200911030911.47030.joshua@eeinternet.com>
 <4AF18F7A.2000904@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:48:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ktu-0002NZ-B8
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbZKDSr7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 13:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbZKDSr6
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:47:58 -0500
Received: from msgmmp-2.gci.net ([209.165.130.12]:47336 "EHLO msgmmp-2.gci.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbZKDSr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 13:47:57 -0500
Received: from hyperion.eeinternet.com ([206.174.62.163])
 by msgmmp-1.gci.net (Sun Java System Messaging Server 6.2-3.03 (built Jun 27
 2005)) with ESMTP id <0KSL00IIALJSAH40@msgmmp-1.gci.net> for
 git@vger.kernel.org; Wed, 04 Nov 2009 09:47:52 -0900 (AKST)
Received: from hosanna.eeinternet.com (unknown [192.168.100.194])
	by hyperion.eeinternet.com (Postfix) with ESMTP id 1F56A3F21D; Wed,
 04 Nov 2009 09:47:52 -0900 (AKST)
X-Face: %RQZkR-ZZZ/},^dzp$qPotQ8:EI[dl6TX^9<K):};#rjcB`apZ95_e*NbqV8Db$,=?utf-8?q?r=7C7x=5FK=0A=09TOpQkS5A?=>=R9nGN)Qva<p+^;@rEbe*bA5XUd<=?utf-8?q?csl=3BT0d=5FP=3AdH21=2EuJAZ=24iao=26H!K=3A9u=7E=7B9=0A=09WV4=5BX4?=
 =?utf-8?q?*=7B=60=5Evlz=5FIVZ?=)R^X5{:l6#=%fLpM^!}~B"CN.R%wwU-Ni-L2TgD](24jBa=_G@
 =?utf-8?q?Zga=0A=09KNcSq4/Lv=3AJm!z=5D=2Ee5=25IgMb=5Cl-xGs=2EN5M4=5D=3A?=
 =?utf-8?q?vz2?="XrHM]j$h/aNM2J_1}}i@"
 =?utf-8?q?l=26Phy5=3FU1=0A=09mfdxMpo=7D?=)/ixNj03,scN>w*od72RYo9i+XAj
In-reply-to: <4AF18F7A.2000904@drmicha.warpmail.net>
Content-disposition: inline
User-Agent: KMail/1.9.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132114>

On Wednesday 04 November 2009, Michael J Gruber said something like:
> > gpg: problem with the agent - disabling agent use
> > error: gpg failed to sign the tag
> > error: unable to sign the tag
> > $ echo $?
> > 128
> >
> > And when I sign at the prompt:
> >
> > $ gpg -sa
> >
> > You need a passphrase to unlock the secret key for
> > user: "Joshua J. Kugler <joshua@azariah.com>"
> > 1024-bit DSA key, ID 14EA086E, created 2009-08-09
> >
> > gpg: problem with the agent - disabling agent use
> > Blah blah blah blah
> > Blah blah blah blah
> > $ echo $?
> > 2
>
> [...]
>
> I assume you don't want to use gpg-agent, that should be the easy way
> out.

Well, I could, but I just haven't set it up. :)

> If that helps you can put "--no-use-agent" in your gpg config.

I commented out use-agent in the config. That worked. THANKS!

> 2 is a non-fatal error, 128 a fatal one, btw.

Well, the 2 was from running gpg alone, and 128 was from git erroring=20
out.  According to the gpg docs:

"The program returns 0 if everything was fine, 1 if at least a signatur=
e=20
was bad, and other error codes for fatal errors."

So, the docs consider 2 a fatal error, even though it appears it isn't.=
 =20
It seems that=20
http://github.com/git/git/blob/a6dbf8814f433a7fbfa9cde6333c98019f6db1e4=
/builtin-tag.c#L202=20
needs to be patched to something along the lines of:

rv =3D finish_command(&gpg)
if ((rv && rv !=3D2)  || !len || len < 0)

Probably digging in to the gpg source code to figure out what errors ar=
e=20
and aren't fatal would be in order.

Thanks again for your help! Glad to know what I needed to do to sign my=
=20
tags!

j

--=20
Joshua Kugler
Part-Time System Admin/Programmer
http://www.eeinternet.com
PGP Key: http://pgp.mit.edu/ =C2=A0ID 0x14EA086E
