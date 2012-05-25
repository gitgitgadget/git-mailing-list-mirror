From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Fri, 25 May 2012 09:35:06 +0200
Message-ID: <20120525073506.GD2052@goldbirke>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<4FBC0019.6030702@in.waw.pl>
	<7v4nr72bim.fsf@alter.siamese.dyndns.org>
	<CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
	<CAOnadRF8XyZKi+d=y1fFy2Xvs-3ETVyCbJBj83mK3Q8yuK7oQw@mail.gmail.com>
	<CAMP44s3uW75O_jt2F7POxTAhX+qPyRSjOX9-DuEkg7a7WtnLsA@mail.gmail.com>
	<4FBD5CC1.3060701@tedpavlic.com> <20120524203549.GA2052@goldbirke>
	<CAOnadRFbrhrFz7Ya3Vhgsju9G723Qu0OdJnM31xFmBqQNgj6gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Ville =?iso-8859-1?Q?Skytt=E4?= <ville.skytta@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Dan McGee <dan@archlinux.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Marius Storm-Olsen <mstormo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Fri May 25 09:35:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXp3n-0005o7-VB
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 09:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab2EYHfh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 03:35:37 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:58206 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab2EYHfc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 03:35:32 -0400
Received: from localhost6.localdomain6 (p5B1305E7.dip0.t-ipconnect.de [91.19.5.231])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LdZry-1RpNPd1AhO-00iFMw; Fri, 25 May 2012 09:35:07 +0200
Content-Disposition: inline
In-Reply-To: <CAOnadRFbrhrFz7Ya3Vhgsju9G723Qu0OdJnM31xFmBqQNgj6gA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:EWKlB1bf7JdTjGd+I4H5INK1kKvsDB3Bn/f/MrXsz2E
 d0hDs6+I9OiRuePnu7UYtgOrKCnh8JAF/oUkBelcJnfHigXkBc
 mHdb2EQJWVODdx0L3zLUDVvx6B2sfyDAz60cY3/Grdb+DDM8+o
 91gQYGape8CPYlFu6NyjHPlTz8YKedfrMQIi1nAbNPz/89EczI
 0vl8GK5y0tNyRpjBsghHZvZztC1LDvjlk7e1lRYDCunToh2H6c
 gdXWnjK0LvO4VpUuatVEMwPwJDzFZc5TDH4rFZ49pQqlX1J42E
 vHaK/Amg9XuulDOphLAIDRJ5Y6VoT1jYm6piURU4MpnPrJ2waH
 8zOZPaCPMk6eM+BjG3Cc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198468>

On Thu, May 24, 2012 at 11:36:45PM -0400, Ted Pavlic wrote:
> > You mean a real git command, which does the same as __gitdir()?  I
> > don't like that, because it will always require 2 fork()s and an
> > exec() and would be slow on Windows.
>=20
> Interesting. I guess I didn't realize bash completion was an issue fo=
r most
> Windows users. Is it?

It is.  Emulating fork() and exec() is very expensive, so every
subshell, external command, or especially git command in a command
substitution costs dearly.  And the completion script uses many git
commands and even more subshells.

Case in point is __git_ps1() and __gitdir().  There are scenarios
where displaying the git-specific bash prompt takes more than 400ms on
Windows, while displaying the same prompt takes only about 26ms on
Linux on the same hardware.

  http://thread.gmane.org/gmane.comp.version-control.git/197432


Best,
G=E1bor
