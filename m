From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] Documentation: rev-list-options: clarify history simplification with paths
Date: Tue, 12 Aug 2008 01:51:46 +0200
Message-ID: <200808120151.56067.trast@student.ethz.ch>
References: <1218375840-4292-1-git-send-email-trast@student.ethz.ch> <7vprofwat0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1907933.fNJQHes3p6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 01:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KShBz-0002Q1-Fz
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbYHKXvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753943AbYHKXvt
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:51:49 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:8627 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558AbYHKXvs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:51:48 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 01:51:46 +0200
Received: from [192.168.0.4] ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 01:51:46 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vprofwat0.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 11 Aug 2008 23:51:46.0182 (UTC) FILETIME=[36A81A60:01C8FC0D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92026>

--nextPart1907933.fNJQHes3p6
Content-Type: multipart/mixed;
  boundary="Boundary-01=_SCNoI/GZT7d8lhm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_SCNoI/GZT7d8lhm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano <gitster@pobox.com> wrote:
>

Thanks for taking the time to look into this!

> What was the meaning of the double-dash at the beginning of line in
> AsciiDoc markup?  I forgot.

I wish I knew.  I simply copied that from elsewhere in the docs to
make it shut up about an error.  It would seem that it is required to
end the list before a title, except if there's already an 'if' doing
the split, unless on a full moon, except if it's wednesday.  I've
tried to make the patches compile with asciidoc (8.2.5 here), but
that's about as far as it goes.

I haven't found any mention of the magic features of '^--' in the user
manual, though the cheat sheet

  http://powerman.name/doc/asciidoc

has nice examples how to interrupt lists, which I used for the
upcoming patch contents.

> Please draw it a bit more consistently with pictures in other existing
> documentation, perhaps like this:

Hmm.  I've tried to give the new examples a more compact and round
appearance, like in your example.  Tell me if that works for you.

> I'd rather make this the part of the base text.  In other words, remove
> the "--prune-merges" header, dedent the description and start the sentence
> with "By default, parents of a merge is rewritten with the following
> rules:".
>=20
> Then before listing the options, say something like "You can influence how
> simplification works using the following options".

I dropped the "--prune-merges" since it would be a new option.
However, I would like to keep some sort of "Default mode" header (not
necessarily as a list header, if you have better ideas).  Otherwise,
upon encountering "--full-history ... differs from the default", the
reader would have to (tediously) scan several paragraph breaks to
discover where the default begins.


I completely rewrote it along the outlines given in my own followup.
I also devised a better example that shows the differences between
all-TREESAME merges, one-TREESAME merges, and (!)TREESAME commits.  I
am open for further suggestions of course.  (I'm also violating the
"no patches after midnight" rule, so feel free to point out obvious
mistakes too.)

I furthermore split the patch into two halves:

* 2/3 applies on top of master, so that it is independent of
  --simplify-merges.

* 3/3 replaces the docs coming with --simplify-merges with an extra
  paragraph in 'History Simplification'.

I hope that's the right way to proceed.  This does mean you will get a
merge conflict when merging jc/post-simplify, but it's a fairly
obvious one.

1/3 is just a one-character typo that I discovered along the way.

=46inally, I'm attaching a script that generates a repository with the
history used in the example.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--Boundary-01=_SCNoI/GZT7d8lhm
Content-Type: application/x-shellscript;
  name="make-test-repo"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="make-test-repo"

#!/bin/bash

git init

# I
touch unrelated
echo asdf > foo
git add unrelated foo
git ci -m initial

# A
echo foo > foo
git add foo
git ci -m 'A'

# B
git co -b M HEAD^
echo foo > foo
git add foo
git ci -m 'B'

# merge B to A
git co master
git merge M

# C
git co -b N M^
echo blah > bar
git add bar
git ci -m C

# merge C to B with changes
git co master
git merge -s ours N
echo foobar > foo
git add foo
git commit --amend -C HEAD

# D
git co -b O M^
echo baz > foo
git add foo
git ci -m D

# merge D to C with conflict
git co master
git merge O
echo foobarbaz > foo
git add foo
GIT_EDITOR=true git ci

# E
git co -b P M^
echo unrelated > unrelated 
git add unrelated
git ci -m E

# merge E to D with changes
git co master
git merge P
echo but O >> unrelated 
git add unrelated
git commit --amend -C HEAD

# clean up
git branch -d M
git branch -d N
git branch -d O
git branch -d P


--Boundary-01=_SCNoI/GZT7d8lhm--

--nextPart1907933.fNJQHes3p6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkig0JwACgkQqUud07tmzP3/wQCfWhrwLSkCFMEWG6JrzlIdM+Sj
hTIAnjtJZ65Wjj88q6cYJxk92WqVWgzT
=XFbu
-----END PGP SIGNATURE-----

--nextPart1907933.fNJQHes3p6--
