From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: pack operation is thrashing my server
Date: Fri, 15 Aug 2008 01:39:58 +0200
Message-ID: <20080814233958.GA31225@atjola.homenet>
References: <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141442150.4352@xanadu.home> <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141633080.4352@xanadu.home> <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 01:41:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTmRI-0006or-VF
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 01:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYHNXkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 19:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbYHNXkF
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 19:40:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:52255 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751654AbYHNXkE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 19:40:04 -0400
Received: (qmail invoked by alias); 14 Aug 2008 23:40:01 -0000
Received: from i577B8F96.versanet.de (EHLO atjola.local) [87.123.143.150]
  by mail.gmx.net (mp027) with SMTP; 15 Aug 2008 01:40:01 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/CWxZQJAfCY1X3NqFM+KYv4Jn0Vd/JhomJ2DaFTn
	iJqisHtltjX/ps
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92441>

On 2008.08.14 16:14:26 -0700, Linus Torvalds wrote:
>=20
> On Thu, 14 Aug 2008, Nicolas Pitre wrote:
> >=20
> > Possible.  However, the fact that both the "Compressing objects" an=
d the=20
> > "Writing objects" phases during a repack (without -f) together are=20
> > _faster_ than the "Counting objects" phase is a sign that something=
 is=20
> > more significant than cache misses here, especially when tree=20
> > information is a small portion of the total pack data size.
>=20
> Hmm. I think I may have clue.
>=20
> The size of the delta cache seems to be a sensitive parameter for thi=
s=20
> thing. Not so much for the git archive, but working on the kernel tre=
e,=20
> raising it to 1024 seems to give a 20% performance improvement. That,=
 in=20
> turn, implies that we may be unpacking things over and over again bec=
ause=20
> of bad locality wrt delta generation.=20

Since you mention the delta cache, uau (no idea about his real name) on
#git was talking about some delta cache optimizations lately, although
he was dealing with "git log -S", maybe it affects rev-list in a simila=
r
way. Unfortunately, I can't seem to find any code for that, just a
description of what he did and some numbers on the results in the IRC
logs.

http://colabti.org/irclogger/irclogger_log/git?date=3D2008-08-04,Mon#l6=
5

Maybe that helps in some way.

Bj=F6rn
