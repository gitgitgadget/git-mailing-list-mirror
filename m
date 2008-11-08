From: Francis Galiegue <fg@one2team.net>
Subject: Re: [RFC] Configuring (future) committags support in gitweb
Date: Sun, 9 Nov 2008 00:27:14 +0100
Organization: One2team
Message-ID: <200811090027.14343.fg@one2team.net>
References: <200811082007.55045.jnareb@gmail.com> <200811082102.44919.fg@one2team.net> <200811082335.49505.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 00:31:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyxGv-0006tj-NK
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 00:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbYKHX3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 18:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbYKHX3w
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 18:29:52 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:39582 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753347AbYKHX3v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2008 18:29:51 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-131-122.w90-24.abo.wanadoo.fr [90.24.50.122])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id D8F0792C011;
	Sun,  9 Nov 2008 00:29:36 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200811082335.49505.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100429>

Le Saturday 08 November 2008 23:35:48 Jakub Narebski, vous avez =C3=A9c=
rit=C2=A0:

> >
> > What do you mean with "not having to write whole replacement rule"?
>
> Like in example with 'link' rule, not having to write whole
> <a href=3D"http://example.com/bugzilla.php?id=3D$1">$&</a>
> (or something like that).
>

OK, good one.

> >> I think it would be good idea to use repository config file for
> >> setting-up repository-specific committags, and use whatever Perl
> >> structure for global configuration. The config language can be
> >> borrowed from "drivers" in gitattributes (`diff' and `merge' drive=
rs).
> >>
> >> So the example configuration could look like this:
> >>
> >>   [gitweb]
> >>   	committags =3D sha1 signoff bugzilla
> >>
> >>   [committag "bugzilla"]
> >>   	match =3D "\\b(?:#?)(\\d+)\\b"
> >>   	link  =3D "http://your.bugzilla.fqdn.here/show_bug.cgi?id=3D$1"
> >>
> >> where 'sha1' and 'signoff' are built-in committags, committags are
> >> applied in the order they are put in gitweb.committags;
> >
> > I don't understand what the "signoff" builtin is : is that a link t=
o see
> > only commits "Signed-off-by:" a particular person?
>
> Committags doesn't need to be replaced by links. In this case I meant
> here using 'signoff' class for Signed-off-by: (and the like) lines, b=
y
> wrapping it in '<span class=3D"signoff">' ... '</a>'.
>

Well, this would also mean to update gitweb.css, wouldn't it?

> > And also, what about the sha1 builtin? AFAIK, a SHA1 can point to a
> > commit, a tree, and others... In fact, it points to any of these ri=
ght
> > now, but how would you tell apart these different SHA1s in a commit
> > message? The only obvious use I see for it is the builtin "Revert .=
=2E."
> > commit message, that the commiter _can_ override...
>
> SHA1 (or shortened SHA1 from 8 charasters to 40 characters, or to be
> even more exact something that looks like SHA1) is replaced by link
> to 'object' view, which in turn finds type of object and _redirect_
> to proper view, be it 'commit' (most frequent), 'tag', 'blob' or 'tre=
e'.
>
> We could have used instead gitweb link with 'h' (hash) parameter, but
> without 'a' (action) parameter, which currently finds type of object
> and _uses_ correct view...
>

OK, you lost me somewhat.

What I understand is that right now, the SHA1 links are "pre-processed"=
 by=20
gitweb so that the 'a' parameter is correct, right?

Out of curiosity, I just went to the kernel git repository (I don't kno=
w the=20
git version that git.kernel.org uses offhand) and altered the 'a' param=
eter=20
to something which is not even an 'a' command at all: 500...

However, if I try a VALID 'a' command with an "irrelevant" 'h' paramete=
r, it=20
acts quite funny: it just looks like it wants to try the closest match,=
 but=20
takes some time figuring it out... Sometimes to something relevant, som=
etimes=20
to nothing really relevant. See for instance [1], in which 'a' was=20
originally "commit".

Ow.

 [1]
http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.27.y.git;a=
=3Dtag;h=3D788a5f3f70e2a9c46020bdd3a195f2a866441c5d

> > Finally, is there any reason to think that a sha1 or signoff commit=
tag
> > will ever need to be overriden in some way?
>
> One might not want to link SHA1, for example if there are lots of fal=
se
> positives because of commit message conventions or something, or refi=
ne
> 'signoff' committag to use different styles for different types of
> signoff: Signed-off-by, Acked-by, Tested-by, other.  Having explicit
> 'signoff' committag allows us also to put some committags _after_ it,
> for example SPAM-protection of emails, or add some committag before
> 'sha1' to filter out some SHA1 match false positives.
>

Hmmm, so this means you'd want to make styles customizable somewhat (si=
gnoff).=20
In fact, what you really want is span for CSS! Then why not, just, maki=
ng a=20
document to say "This is what you can do with CSS for gitweb", and say =
"these=20
are the available CSS tags", and then be done with it?

I mean, when comes the day that someone will WANT other spans to be def=
ined,=20
badly, it's not like it will be unheard of, won't it?=20

>
> > And I don't see what you '_a_' and '_b_' are about...
>
> For example in link match, the text of the link can be further refine=
d
> by committags later in sequence.

I still don't get it. Can you give an example?

[personal thoughts: it would be really, really nice if, somewhat, gitwe=
b.perl=20
were splitted somewhat into different modules, and ideally use more=20
of "what's out there on CPAN". I'm convinced that some CPAN modules wou=
ld be=20
of GREAT help to gitweb, as well as I'm convinced that not many people =
out=20
there use Windows to run gitweb anyway :p]

--=20
fge
