From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Sat, 26 Apr 2014 00:26:29 +0200
Message-ID: <480ACEB0-7629-44DF-805F-E9543E66241B@quendi.de>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com> <1398112633-23604-3-git-send-email-felipe.contreras@gmail.com> <38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de> <5358286ba756e_24448772ec82@nysa.notmuch> <EFCABE07-971C-4699-9A03-C5076B3B45ED@quendi.de> <53585996ae447_3c7abff31065@nysa.notmuch>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_1196BE38-CAAF-4BF2-81C1-6E952CD0413D"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 00:42:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdopO-0003Nc-BN
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 00:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbaDYWmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 18:42:31 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:57479 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752312AbaDYWm3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 18:42:29 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Apr 2014 18:42:28 EDT
Received: from mailgw82.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP; Sat, 26 Apr 2014 00:27:08 +0200
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de [134.176.2.3])
	by mailgw82.hrz.uni-giessen.de (Postfix) with ESMTP id C625B4800081;
	Sat, 26 Apr 2014 00:26:34 +0200 (CEST)
Received: from [134.176.2.3] by merkurneu.hrz.uni-giessen.de with ESMTP; Sat, 26 Apr 2014 00:26:34 +0200
In-Reply-To: <53585996ae447_3c7abff31065@nysa.notmuch>
X-Mailer: Apple Mail (2.1510)
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-Envelope-From: max@quendi.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247121>


--Apple-Mail=_1196BE38-CAAF-4BF2-81C1-6E952CD0413D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

I am going to step away from this painful discussion and also this =
mailing
list, but I owed it to send one last reply with two of the problems I am
still seeing, simply in the hope that this will benefit some future
git-remote-hg users, but also to dispel any claims I was "hoarding" bugs =
to
somehow hurt Felipe.

Beyond that, I refuse to further "discuss" with Felipe on anything. It =
leads
nowhere, and he is so full of himself that it seems impossible to reason
with him. I will also refrain from countering everything he said, even
though I am sure he'll construe this as me admitting that he is right. I
don't care enough to try to keep up the flames *shrug*.  In the end,
everybody here can interpret this in whichever way they like.

Ah well, OK, I can't resist one last retort to one point Felipe wrote:

On 24.04.2014, at 02:23, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:

> Max Horn wrote:
[...]
>=20
>> Out of curiosity: How do you yourself use git-remote-hg in your daily =
work?
>=20
> I don't.

So you don't eat your own dog-food (at most you sometimes snack on it)?
That would explain a lot...



Now to the issues: The following results are based on git "next" at =
revision
e8486314780a4. In addition, I cobbled together fixes from Felipe's
repository, namely the commit [1] he claimed to have fixed the multi =
head
issue I mentioned, as well as the changes from the fc/remote/fixes =
branch on
his github repository [2].

It is very well possible that this is still not the latest and greatest, =
and
that I missed some important patch that changes everything -- it's hard =
to
tell given the multitude of branches in Felipe's repository. Anyway, to
avoid confusion, I put my merged version of the script into a Gist [3], =
so
if I made a mistake there, it should be easy to discover.

Given that, the following script (which Felipe already knows from his
issue tracker [4]) still causes a fast-import crash after which "git =
pull"
from the remote hg repository is impossible, and the user has no idea
how to recover.

-- 8< --
#!/bin/sh -ex
rm -rf hgrepo gitrepo

# Create a multi-head repository
hg init hgrepo
cd hgrepo
echo a > a && hg add a && hg commit -m a
echo b > b && hg add b && hg commit -m b
hg update 0
echo c > c && hg add c && hg commit -m c
cd ..

# Clone it via remote-hg
git clone "hg::hgrepo" gitrepo

cd gitrepo
git gc --prune=3Dnow
git pull  # error
-- 8< --

Which results in this:

WARNING: Branch 'default' has more than one head, consider merging
fatal: object not found: 61780798228d17af2d34fce4cfbdf35556832472
fast-import: dumping crash report to .git/fast_import_crash_78219
fatal: Error while running fast-import

Any subsequent pulls then give something like this:

WARNING: Branch 'default' has more than one head, consider merging
fatal: mark :6 not declared
fast-import: dumping crash report to .git/fast_import_crash_78834
fatal: Error while running fast-import


What happens here is that a hg branch with two heads is created; this
repository is cloned via git-remote-hg. Both heads of the hg branch are
imported to git, but only one is referenced by a git ref. We then prune, =
and
end up with a "missing" commit that is still referenced by the marks =
file.

Note that the "next" version I used has =
fc/transport-helper-sync-error-fix,
but this did not stop "git fast-import" from trashing the marks file. =
:-(



The second script is similar but uses a closed branch to trigger =
essentially
the same issue. Background: closed branches are ignored by =
git-remote-hg,
meaning that no git ref is created for them, which can again lead to a
commit without a git ref but referenced by the marks file(s). However,
reproducing the bug in this case is a bit more complicated, because the
problem is obscured by another bug (?): Namely, if a hg branch is =
closed,
then git-remote-hg starts ignoring it, but does not seem to remove the =
ref
created for that branch.  So, the git user will not see that the remote
branch was closed (which is a bug, I'd say); on the upside, since the =
ref is
still around, no dangling commit is produced.

But we can "work around" this by re-opening the hg branch at a different
position, i.e. as child of an unrelated commit, which does *not* have =
the
commits of the original branch as parents. If we do that, git-remote-hg
moves the git ref to point to the new branch tip, and again we end up =
with a
dangling commit (the git commit corresponding to the former hg branch =
tip).

Again, this is something me and also colleagues "discovered" in real =
life
usage. So don't be fooled by the somewhat convoluted test script. This =
*does*
happen.

-- 8< ---
#!/bin/sh -ex

rm -rf hgrepo gitrepo

# Create a repository with two branches
hg init hgrepo
cd hgrepo
echo a > a && hg add a && hg commit -m a
hg update 0
hg branch foobar
echo b > b && hg add b && hg commit -m b
hg update default
cd ..

# Clone it via remote-hg
git clone "hg::hgrepo" gitrepo
cd gitrepo
git gc --prune=3Dnow
git pull
cd ..

# close the branch
cd hgrepo
hg update foobar
hg commit --close-branch -m "close branch"
hg update default
cd ..

cd gitrepo
git gc --prune=3Dnow
git pull
# This pull should trigger the issue, but for some reason, the ref
# origin/branches/foobar is still around, and so nothing happens.
cd ..

cd hgrepo
hg update default
hg branch -f foobar
echo c > c && hg add c && hg commit -m c
hg update default
cd ..

cd gitrepo
git gc --prune=3Dnow
git pull
# at this point, origin/branches/foobar is gone
git gc --prune=3Dnow
git pull      # now we get the error
-- 8< --


Goodbye,
Max


[1] =
https://github.com/felipec/git/commit/fbaae8caa51804a655fd6bc5727763b64e3c=
2e9f
[2] =
https://github.com/felipec/git/commit/1bf5fc892ebaa4a07dcd71ef96f8a8f5c876=
cb5f
[3] https://gist.github.com/fingolfin/11296352
[4] https://github.com/felipec/git/issues/56#issuecomment-40305442


--Apple-Mail=_1196BE38-CAAF-4BF2-81C1-6E952CD0413D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlNa4RoACgkQIpJVslrhe1lTbwD/V2aDr/ihLc2BXslnQ5506RXo
/kwdQw//UyQwvTvE/X0BAJaFL2CxY5FvaxGqYi5vln1BY6s68YHm3MxfpKIqyldH
=LLk4
-----END PGP SIGNATURE-----

--Apple-Mail=_1196BE38-CAAF-4BF2-81C1-6E952CD0413D--
