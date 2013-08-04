From: =?windows-1252?Q?J=F6rn_Hees?= <dev@joernhees.de>
Subject: Re: [bug resolved] remotes-hg: timezones are transformed
Date: Sun, 4 Aug 2013 15:03:51 +0200
Message-ID: <9C887272-8580-4198-B136-CDA45C5E4B2C@joernhees.de>
References: <EDA1C92E-6872-40D5-8C25-89C3FFF62F7A@joernhees.de> <CAMP44s0aiv7rNCFgQ4hz_KOMRJ5F4CXFTXME73biNA4Nv3Vwdw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 15:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5xyq-0007hT-5U
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 15:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab3HDNEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Aug 2013 09:04:11 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:52556 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab3HDNEK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Aug 2013 09:04:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id 60AB2E810D6;
	Sun,  4 Aug 2013 15:04:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fUVGc2o1U0v9; Sun,  4 Aug 2013 15:03:56 +0200 (CEST)
Received: from [192.168.2.12] (xdsl-78-35-59-56.netcologne.de [78.35.59.56])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id 71448E810D5;
	Sun,  4 Aug 2013 15:03:56 +0200 (CEST)
In-Reply-To: <CAMP44s0aiv7rNCFgQ4hz_KOMRJ5F4CXFTXME73biNA4Nv3Vwdw@mail.gmail.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231625>

Hi,

On 4 Aug 2013, at 01:17, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:
> On Sat, Aug 3, 2013 at 11:36 AM, J=F6rn Hees <dev@joernhees.de> wrote=
:
>=20
>> it seems that if you use the 1.8.3.4 remote-helpers/git-remote-hg to=
 clone a mercurial repo the timezone information of commits gets transf=
ormed into your current timezone.
>> (command: git clone hg::=85)
>>=20
>> I noticed this when a colleague in another timezone used Kiln to als=
o export the same mercurial repo that i had cloned from git before.
>> Fetching from his git repo gives me a "second root tree" with all co=
mmits duplicated.
>> A git show of two equivalent commit reveals that the Date: line of t=
he commits changed.
>> Tracking this back into the original mercurial repo reveals that _hi=
s_ times are correct.
>>=20
>> This will also make two or more clones from different timezones all =
using the same hg remote repo incompatible!
>>=20
>>=20
>> Example:
>> Original mercurial commit (timezone: -7200 =3D -4h)
>> https://bitbucket.org/lipis/gae-init/commits/a43078f90e727a13767cf14=
c740157763fb423b5/raw/

sorry, i feel stupid for this now=85 this obviously is -2h:  2*60*60=85=
 not 4
(but see below)


>> Lipis git export via Kiln: (-4h)
>> https://github.com/lipis/gae-init/commit/36b7cabf03fbba784cc41b63430=
433e9fc79ca8c

so is this: it should've said -2h


>> My export via git clone hg::ssh://hg@bitbucket.org/lipis/gae-init (+=
2h)
>> https://github.com/joernhees/git-hg-remote-bug_gae-init/commit/8341b=
f10f1f0a7a924717a8a2c1770f61acd51ae

this one was correct: +2h


> Actually our version is the correct one:
>=20
> % hg commit -m one -d "2012-04-28 11:28 +0200"
> % hg export
> # HG changeset patch
> # User Felipe Contreras <felipe.contreras@gmail.com>
> # Date 1335605280 -7200
> #      Sat Apr 28 11:28:00 2012 +0200


Thanks for clarifying this. I had falsely assumed that no one would dar=
e to flip the sign of the timezone spec.
Turns out that mercurial commits contain the _negative_ timezone offset=
 in seconds, so UTC+2 will actually be saved as -7200!
I was actually still doubtful so i searched for some credible ref and w=
as able to find this insanity documented in "hg help dates":
> - "1165432709 0" (Wed Dec 6 13:18:29 2006 UTC)
>=20
>     This is the internal representation format for dates. The first n=
umber is
>     the number of seconds since the epoch (1970-01-01 00:00 UTC). The=
 second
>     is the offset of the local timezone, in seconds west of UTC (nega=
tive if
>     the timezone is east of UTC).
I use the word insane here, as there are many standards for date times,=
 but not one dares to switch the timezone sign!
https://en.wikipedia.org/wiki/Time_zone
https://upload.wikimedia.org/wikipedia/commons/a/ad/Standard_time_zones=
_of_the_world.png


I'm sorry for reporting this as a bug and instead have to pull my hat.

Cheers,
J=F6rn
