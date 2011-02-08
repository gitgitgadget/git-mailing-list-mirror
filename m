From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Tue, 8 Feb 2011 11:05:18 +0100
Message-ID: <20110208100518.GA9505@neumann>
References: <4D4DEDC4.4080708@hartwork.org>
	<20110206051333.GA3458@sigill.intra.peff.net>
	<4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr>
	<7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
	<20110207055314.GA5511@sigill.intra.peff.net>
	<7vhbcguytf.fsf@alter.siamese.dyndns.org>
	<20110207195035.GA13461@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 11:05:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmkRy-0004ZX-0x
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 11:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab1BHKF2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 05:05:28 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:55904 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab1BHKFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 05:05:25 -0500
Received: from localhost6.localdomain6 (p5B130D29.dip0.t-ipconnect.de [91.19.13.41])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0ME4A3-1PukGO1NnD-00HKX2; Tue, 08 Feb 2011 11:05:19 +0100
Content-Disposition: inline
In-Reply-To: <20110207195035.GA13461@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:QJHHqzd9EY9dpQKsVEfIaVURmzXRf40GIA+quLfY0EW
 J20iJpe/Fkq441DGANoTdejXw3KFLuxgnNRAsRowxpYXKpGDe7
 3lnqB88+tRqWmmgmYCIfuNZwm5jvIlsgm7pg6wdVlGwCdQnQvG
 lPXzSv4PBgDcW2TQLQASzeoAhEESG45B11LrvhT0VpAnLltMfe
 uM1icDMHSRL4qfb9GDQwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166344>

On Mon, Feb 07, 2011 at 02:50:35PM -0500, Jeff King wrote:
> On Sun, Feb 06, 2011 at 10:46:20PM -0800, Junio C Hamano wrote:
>=20
> > I actually do not mind too much myself if all commands that can tak=
e
> > pathspecs consistently defaulted to "full-tree" pathspec given no
> > pathspec.  But if we were to go that route, everybody should join t=
heir
> > voice to defend that decision when outside people say "in 1.8.0 'gi=
t grep'
> > run from a subdirectory shows matches from all the irrelevant parts=
 of the
> > tree; with all the cruft its output is unreadable". I won't be the =
sole
> > champion of such a behaviour when I do not fully believe in it.
>=20
> The problem is that I don't feel comfortable writing an RFC that says
> "in 1.8.0 we will default to full-tree because it is somehow better".
> Because I don't think it is better; it is simply a different way of
> thinking about it, and different people will have different preferenc=
es.
>=20
> I think even the same people may different preferences from project t=
o
> project. For most of my projects, the scope of the repo is well-defin=
ed,
> and I want full-tree semantics (e.g., I hack on a bug, go into t/ to
> tweak and run the tests, and then want to "git add -u" the whole thin=
g
> when everything looks good). But I also recently worked on a gigantic
> project that was split into several sub-components. I would cd 3 or 4
> levels deep into the sub-component that I was working on, and I would
> prefer my "git add -u" to stay in that sub-component, and my "git gre=
p"
> to look only in that sub-component.

It sounds like your work focused solely on the sub-component you cd-d
into.  Did you have any other changes outside of that sub-component?
Because when not, then both the current and the whole-tree "git add -u"
would have the same effect.

The current and the whole-tree "git grep" would behave differently, of
course.  But even then a whole-tree "git grep" would be harmless and
easy to limit in scope, though might be a bit annoying in the "cd deep
down" case.  In that case you would immediately see the matches
outside of cwd, know that you forgot to limit the operation to cwd, so
you hit the up key, simply append the "." to the last command, and you
get what you wanted.

As mentioned in this or other related threads, this is not at all that
simple the other way around, i.e. with current "git grep" when you are
in the sub-component and you happen to need a grep on the whole tree,
because you have to pay attention to use the right number of "../"s.

A whole-tree "git add -u" is just as easy to limit in scope as the
whole-tree "git grep" would be, but certainly more annoying when you
forget to limit it to cwd.  But even in that case there is no harm
done, because all the changes you've made are there, but you have to
unstage changes from the index or split the commit.

Current "git add -u" is worst of all, because it's not just difficult
to circumvent (how many "../" do I need?), but it's downright
dangerous, because you can lose changes when forget that it's limited
in scope.  I managed to do something like this while fixing two
already bisected bugs:

  git checkout deadbeef         # BugA was introduced in that commit
  vim git.c                     # fix BugA
  cd t
  test ; vim test ; test
  git add -u                    # again forgetting that a
                                # fundamentally whole-tree oriented=20
                                # tool has operations with
                                # non-whole-tree defaults...
  git commit -m 'Fix BugA'      # will write proper commit msg later
  git branch fix_BugA           # to find the commit later
  git reset --hard babefeed     # instead of "git checkout babefeed"
                                # BugB was introduced there
                                # goodbye bugfix!
  # hack away to fix BugB       # until realisation sets in
  # Damn.

You could argue that there are several ways I could have prevented
shooting myself in the foot, e.g. using "git checkout" instead of "git
reset --hard", or by using plain "git commit" without the "-m" option
I might have noticed the unstaged changes in the commit template.  I
would even tend to agree, but I still think that git should be
consistent with _itself_ in the first place, and since git's
fundamental concepts are whole-tree oriented and there are many
commands that only make sense on the whole tree, defaulting to
whole-tree operations for commands taking a pathspec is indeed better.
And safer too.


Best,
G=E1bor
