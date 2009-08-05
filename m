From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: blame on a deleted/renamed file
Date: Wed, 5 Aug 2009 14:37:54 +0200
Message-ID: <20090805123754.GA13340@atjola.homenet>
References: <449c10960908050516k25ef0a92sd8616de29a93ea5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 14:38:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYflA-0000VC-16
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 14:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934274AbZHEMiK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 08:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934268AbZHEMiI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 08:38:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:39185 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933674AbZHEMiD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 08:38:03 -0400
Received: (qmail invoked by alias); 05 Aug 2009 12:38:01 -0000
Received: from i59F55BB1.versanet.de (EHLO atjola.homenet) [89.245.91.177]
  by mail.gmx.net (mp067) with SMTP; 05 Aug 2009 14:38:01 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/YtysJ3MHYIwctoQ6hU9rOazsHjbu5yumYpjcZ/A
	37r8eagQT/Rf/j
Content-Disposition: inline
In-Reply-To: <449c10960908050516k25ef0a92sd8616de29a93ea5f@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124901>

On 2009.08.05 07:16:13 -0500, Dan McGee wrote:
> Is there no easy way in git to get a blame on a file that has either
> been renamed or deleted? I'll step through my thought process, and a
> quick google and read of the manpage returned nothing obvious. Here i=
s
> the repository in question if it matters:
> git://projects.archlinux.org/pacman.git. I located a particular commi=
t
> I was interested using a plain git-blame:
> $ git blame scripts/makepkg.sh.in
>=20
> OK, looks like lines moved around enough that we got stuck here, let'=
s

How did it get stuck? The output I see follows the changes the whole wa=
y
back through scripts/makepkg.in, scripts/makepkg.in and scripts/makepkg=
=2E

> see what this patch did:
> $ git show e19d7da4
>=20
> OK, it did a move of a bunch of lines into functions that GIT couldn'=
t
> quite track:
> $ git annotate --follow "scripts/makepkg.in" e19d7da4~1
> fatal: cannot stat path 'scripts/makepkg.in': No such file or directo=
ry

Where does that --follow come from? I don't see that in the man page.

And scripts/makepkg.in got added in e19d7da4, so its parent didn't have
it.

> $ git annotate --follow "scripts/makepkg.sh.in" e19d7da4~1
> fatal: no such path scripts/makepkg.sh.in in e19d7da4~1

Same deal, scripts/makepkg.sh.in didn't exist in e19d7da4~1 either, it
got renamed from scripts/makepkg.in in b5f8a44be

> Help? Or do I need to think about writing some sort of patch for it?
> This is the first thing I have seen svn be able to do[1] that git
> can't. :)

Uhm, no, svn fails in the exact same way, not quite unexpected.

doener@atjola:~ $ mkdir h
doener@atjola:~ $ cd h
doener@atjola:h $ svnadmin create repo
doener@atjola:h $ svn co file://$PWD/repo wc
Checked out revision 0.
doener@atjola:h $ cd wc

doener@atjola:wc $ touch foo; svn add foo; svn commit -m init
A         foo
Adding         foo
Transmitting file data .
Committed revision 1.
doener@atjola:wc $ svn mv foo bar; svn commit -m rename
A         bar
D         foo
Adding         bar
Deleting       foo

Committed revision 2.
doener@atjola:wc $ cd ..

doener@atjola:h $ svn blame file://$PWD/repo/bar
doener@atjola:h $ svn blame file://$PWD/repo/bar@1
svn: '/bar' is not a file in revision 1

Bj=F6rn
