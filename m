From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] completion: Add '--edit-todo' to rebase
Date: Thu, 30 Jul 2015 12:29:40 +0100
Message-ID: <20150730112940.GL14935@serenity.lan>
References: <1436786876.6619.0.camel@virtuell-zuhause.de>
 <20150713131107.GC1451@serenity.lan>
 <1064256694.3063.1438019649384.JavaMail.open-xchange@app07.ox.hosteurope.de>
 <20150730132403.Horde.qnEThoM2W0qI-S5EDFXGDg3@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jul 30 13:30:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKm2x-000531-64
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 13:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbbG3Lai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jul 2015 07:30:38 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:59449 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbbG3LaK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2015 07:30:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 7E67D866004;
	Thu, 30 Jul 2015 12:30:06 +0100 (BST)
X-Quarantine-ID: <hv6imAOXYSOE>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hv6imAOXYSOE; Thu, 30 Jul 2015 12:30:00 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id E684FCDA571;
	Thu, 30 Jul 2015 12:29:42 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20150730132403.Horde.qnEThoM2W0qI-S5EDFXGDg3@webmail.informatik.kit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274984>

On Thu, Jul 30, 2015 at 01:24:03PM +0200, SZEDER G=E1bor wrote:
>=20
> Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:
>=20
> > Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> > ---
> >> John Keeping <john@keeping.me.uk> hat am 13. Juli 2015 um 15:11 ge=
schrieben:
> >> git-rebase.sh contains:
> >>
> >> 	if test "$action" =3D "edit-todo" && test "$type" !=3D "interacti=
ve"
> >> 	then
> >> 		die "$(gettext "The --edit-todo action can only be used during i=
nteractive
> >> rebase.")"
> >> 	fi
> >>
> >> I wonder if it's worth doing a similar check here, which presumabl=
y
> >> means testing if "$dir"/interactive exists.
> >
> > Good point. Thanks for the hint.
>=20
> Perhaps the subject line could say "completion: offer '--edit-todo' =20
> during interactive rebase" to be a bit more specific.
>=20
> > contrib/completion/git-completion.bash | 6 +++++-
> > 1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/completion/git-completion.bash
> > b/contrib/completion/git-completion.bash
> > index c97c648..b03050e 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1668,7 +1668,11 @@ _git_rebase ()
> > {
> > 	local dir=3D"$(__gitdir)"
> > 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
> > -		__gitcomp "--continue --skip --abort"
> > +		if [ -d "$dir"/interactive ]; then
>=20
> This doesn't work for me, I think it looks for the right file at the =
=20
> wrong place.  During an interactive rebase I have no =20
> '.git/interactive' file but a '.git/rebase-merge/interactive', so I =20
> never get '--edit-todo'.
>=20
> After some playing around and a cursory look at the source it seems t=
o =20
> me that I have '.git/rebase-apply' during a "regular" rebase and =20
> '.git/rebase-merge' during an interactive rebase, and git-rebase.sh =20
> checks the presence of the 'interactive' file only in =20
> '.git/rebase-merge'.  It's not clear to me yet whether it's possible =
=20
> to have a '.git/rebase-merge' without the file 'interactive' in it.  =
=20
> If it is possible, then I'd like to know with which commands and unde=
r =20
> what circumstances.  If it isn't, then we wouldn't have to look for =20
> the file at all, because checking the presence of the directory would=
 =20
> be enough.

"git rebase --merge" will use ".git/rebase-merge" without creating the
"interactive" flag.
