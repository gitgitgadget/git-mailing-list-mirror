From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash: support user-supplied completion scripts for
	user's git commands
Date: Fri, 29 Jan 2010 21:00:33 +0100
Message-ID: <20100129200033.GA32636@neumann>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
	<20100129151127.GA21821@spearce.org>
	<7v4om4kdt3.fsf@alter.siamese.dyndns.org>
	<20100129175950.GE21821@spearce.org>
	<7vockciyb8.fsf@alter.siamese.dyndns.org>
	<20100129190642.GA31303@neumann>
	<20100129191326.GD22101@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Rhodes Clymer <david@zettazebra.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 21:00:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nax1L-00079Q-LG
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab0A2UAl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 15:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754445Ab0A2UAl
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:00:41 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:51345 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab0A2UAk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 15:00:40 -0500
Received: from [127.0.1.1] (p5B130E12.dip0.t-ipconnect.de [91.19.14.18])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MgYEB-1NO4ZS45p9-00NNQN; Fri, 29 Jan 2010 21:00:35 +0100
Content-Disposition: inline
In-Reply-To: <20100129191326.GD22101@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1+QjGdRvdHujHCMDODTeOarSPKX7rC54PwkmZv
 7vtZT8IU/kijN04tlz9VFbj0OGAXZN5RKls5ELsc4qFSE+BRya
 QvaiShJypyfYBHb6m0y/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138342>

Hi Shawn,

On Fri, Jan 29, 2010 at 11:13:26AM -0800, Shawn O. Pearce wrote:
> SZEDER G?bor <szeder@ira.uka.de> wrote:
> > How about something like this for subcommands (not aliases)?  It's =
a
> > good code size reduction anyway.
>=20
> Hmm, I like this.  I just didn't know how to implement it...  :-)
>=20
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
>=20
> > +	local completion_func=3D"_git_${command//-/_}"
> > +	declare -F $completion_func >/dev/null && $completion_func
>=20
> Yay for knowing bash.  :-)

Heh.  I've found out about this 'declare -F' thing about two hours ago
(;


However.

I thought this should actually "Just Work" for aliases, too.  e.g.
Junio could use the following completion function to get 'git log's
options for his lgm alias:

_git_lgm () {
        _git_log
}

Unfortunately, it doesn't work at all.

In _git() first we have 'lgm' in $command, which is ok, but then comes
this alias handling thing

        local expansion=3D$(__git_aliased_command "$command")
        [ "$expansion" ] && command=3D"$expansion"

which writes '!sh' into $command, and that doesn't look quite right
for me, although I admit that I can't seem to figure out how this
__git_aliased_command() is supposed to work (so much about knowing
bash ;).  Any insight?


Best,
G=E1bor
