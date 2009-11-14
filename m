From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] Speed up bash completion loading
Date: Sat, 14 Nov 2009 15:43:03 +0100
Message-ID: <20091114144303.GA31540@neumann>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
	<fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
	<20091111220832.GA31620@progeny.tock> <4AFCFF50.5080401@gmail.com>
	<20091113070652.GA3907@progeny.tock> <4AFD06CD.7090003@gmail.com>
	<20091113085028.GA4804@progeny.tock>
	<20091113090343.GA5355@progeny.tock> <4AFDC4F3.1050607@gmail.com>
	<20091114110141.GB1829@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 15:43:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9JqQ-0007nW-Kx
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 15:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbZKNOnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Nov 2009 09:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbZKNOnG
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 09:43:06 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:53636 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbZKNOnF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 09:43:05 -0500
Received: from [127.0.1.1] (p5B1301DB.dip0.t-ipconnect.de [91.19.1.219])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MgI6w-1Mlcoo2iyk-00NnuL; Sat, 14 Nov 2009 15:43:07 +0100
Content-Disposition: inline
In-Reply-To: <20091114110141.GB1829@progeny.tock>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/tS7Wrhb5MoefZhpaLUuNpcMAjMn88aYyqISf
 RrRtJFt95/h9rSPR8U1fsLFeCodY6A5OPsNSDB6fp67SPutjcQ
 Mhdsefr5LmvCmrJagY/tQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132874>

Hi,


On Sat, Nov 14, 2009 at 05:01:41AM -0600, Jonathan Nieder wrote:
> Stephen Boyd wrote:
>=20
> > I see a small problem, but it can be fixed in another patch. git
> > merge -s <TAB><TAB> the first time when you're not in a git
> > directory will make git merge -s <TAB><TAB> after never complete
> > correctly even in a git directory.
>=20
> Not good.  I think the sanest thing to do is avoid caching the merge
> strategy list entirely.  Listing merge strategies takes about 100 ms
> here, which is short enough not to be annoying.
>=20
> > I guess this become more serious
> > if git isn't in your path initially and you do git <TAB><TAB> and
> > then git becomes part of your path and you try again. Here you lose
> > porcelain completion. This is probably never going to happen though=
,
> > right?
>=20
> Right, if this happened to me I would not be too surprised.  A simila=
r
> problem occurs when someone installs a new git subcommand in the
> middle of a session.  Starting a new session fixes the completion, bu=
t
> should the completion script do something to help people before then?
>=20
> It could provide a shell function with a slightly friendlier name tha=
n
> "__git_compute_porcelain_commands" for the user to invoke explicitly.
>=20
> It could retry "git help -a" each time completion was needed if it
> gave no results last time (i.e. use "${__git_all_commands:=3D" instea=
d
> of "${__git_all_commands=3D").  This would help with the missing git
> problem (which seems unusual), but not the missing git-svn.
>=20
> Maybe it could detect signs of user frustration (repeated attempts to
> complete the same thing?) and add to the frustration by silently
> fixing the cache.

Why?  Don't get overly creative here, the command

  . /path/to/git-completion.bash

already does that, plus it fixes the merge strategy completion issue,
and it's friendly enough for the users.


Best,
G=E1bor
