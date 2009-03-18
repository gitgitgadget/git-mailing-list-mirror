From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: fetch and pull
Date: Wed, 18 Mar 2009 09:58:49 +0100
Message-ID: <20090318085849.GA8118@atjola.homenet>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEF9A@EXCHANGE.trad.tradestation.com> <76718490903161303h45e47a8co83159e32ae749352@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A2AF023@EXCHANGE.trad.tradestation.com> <76718490903161514ubbdc948o1a0251212fe65fea@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A2AF0A9@EXCHANGE.trad.tradestation.com> <76718490903161709v6d8d09f6k17d2fe1a5e56fb03@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A2AF22F@EXCHANGE.trad.tradestation.com> <76718490903170921r36843c11y5aac537d53384298@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A3FC0A5@EXCHANGE.trad.tradestation.com> <20090318063103.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 10:00:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjrdR-0003kf-95
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 10:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbZCRI64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 04:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbZCRI6z
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 04:58:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:58184 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751016AbZCRI6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 04:58:54 -0400
Received: (qmail invoked by alias); 18 Mar 2009 08:58:51 -0000
Received: from i59F5482F.versanet.de (EHLO atjola.local) [89.245.72.47]
  by mail.gmx.net (mp057) with SMTP; 18 Mar 2009 09:58:51 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19etQsRZi5ekaeCfLLffdWewzrKibwtMBYGb0OLW9
	REBJr7jKVcXNXt
Content-Disposition: inline
In-Reply-To: <20090318063103.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113599>

On 2009.03.18 06:31:03 +0900, Nanako Shiraishi wrote:
> Quoting John Dlugosz <JDlugosz@TradeStation.com>:
> > I think the documentation for git-pull might also be garbled from
> > text being of different eras.  "Normally the branch merged is the
> > HEAD of the remote"?  That will be basically random since the last
> > thing the upstream repo user did will control what his HEAD is.
>=20
> That's how it's supposed to work, and the documentation isn't from a
> different era, either. Majority of users clone from a central
> repository and keep pulling to update their clones, and in that kind
> of setting, HEAD will never change. A HEAD in a bare repository tells
> people which branch is the primary branch of the project.

But _if_ HEAD changes in the remote repo, that has normally no effect o=
n
the behaviour of pull. Especially since the examples in the man page ar=
e
"git pull" and "git pull origin".

AFAICT the remote's HEAD affects the pull behaviour when:

1) You do "git pull git://host/repo.git" or similar, i.e. you don't use
a remote. Because then, no refspec is given to fetch, and it defaults t=
o
fetching HEAD.

2) You do "git pull origin" and there's no remote.origin.fetch set, sam=
e
as above then.

3) You do "git pull" and either is branch.<name>.remote set to an url
(same as 1) then) or to a remote that has no default fetch refspec set
(same as 2) then).


1) probably isn't that common for most users, and even if, it's not
one of the commands given as examples to which the paragraph applies.

2) I don't think that's a common setup, and it's not a default setup, s=
o
that hardly qualifies for "normally".

3) I've actually seen cases of the first form of this setup (remote set
to an url), but usually that was paired with a confused user.


So while it's true that the remote's HEAD might be what you merge, it's
not quite what happens "normally". Of course it's true that the most
common setup is probably that HEAD references master and that
branch.<name>.merge is also set to refs/heads/master, but while the
outcome is basically the same, I'd rather say that that is a coincidenc=
e
rather than what the text means to the reader.


I'm unsure about how to improve that section though. Basically, the las=
t
paragraph ("When no refspec was given ...") above the EXAMPLES section
needs to be repeated, but that feels wrong. Anyone got a better idea?

Well, at least I finally realised that pull _might_ default to the
remote's HEAD, and for that part, I'll send a patch.

Bj=F6rn
