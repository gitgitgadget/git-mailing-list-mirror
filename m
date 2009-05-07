From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Tracking the untracked
Date: Thu, 7 May 2009 11:16:56 +0200
Message-ID: <200905071117.00162.trast@student.ethz.ch>
References: <93c3eada0905051819l92dc7ey331d69f009cc9c8b@mail.gmail.com> <200905061522.56981.trast@student.ethz.ch> <93c3eada0905070058g7f619a56jfb9b49f02bb92f9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7623390.lVbZ3vAOlv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Thu May 07 11:18:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1zjs-0003t2-56
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 11:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbZEGJRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 05:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbZEGJRw
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 05:17:52 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:54375 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443AbZEGJRv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 05:17:51 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 May 2009 11:17:50 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 May 2009 11:17:50 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.27.21-0.1-default; KDE/4.2.2; x86_64; ; )
In-Reply-To: <93c3eada0905070058g7f619a56jfb9b49f02bb92f9b@mail.gmail.com>
X-OriginalArrivalTime: 07 May 2009 09:17:50.0135 (UTC) FILETIME=[B1750C70:01C9CEF4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118455>

--nextPart7623390.lVbZ3vAOlv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Geoff Russell wrote:
>

Please keep the Cc list, it's customary around here and helps us find
the mails addressed to us.

> On 5/6/09, Thomas Rast <trast@student.ethz.ch> wrote:
> >  Your build products became tracked (w.r.t. the then-state of the
> >  repository, on branch B1) the second you added them to the index with
> >  'git add'.  Git then cares about them, and among many other things
> >  will look at them whenever you change branches.  Since they're not
> >  present in the target branch 'master', they are removed from the work
> >  tree.
[...]
> Ok, its clearly a policy choice.  But suppose I have an untracked
> file and I do "git some-command" then I don't expect git to touch what
> it doesn't know about. I.e., "git add x" shouldn't delete the untracked
> file y. That seems sensible. But now "git checkout branch" behaves
> quite differently in just deleting stuff that it doesn't own (i.e., is
> untracked).
>=20
> Anyway, I'll rethink.

They weren't untracked!

This is roughly what Dscho said, but I'll try to explain it in more
detail:

=2D In the first step, when switching from master to B1, your build
  products were indeed untracked (not part of either master or B1 or
  the index).  So Git leaves them alone.

=2D By adding (git add $file) your files to the index, you made them
  tracked.[1]

=2D By making a commit, you let the files "officially" belong to the
  current branch (B1).  So with respect to the _current_ branch B1,
  they _were_ tracked.

=2D When you switch branches in the last step, Git sees that B1 has
  these files, but master doesn't, so it removes them to bring the
  worktree into the state that master has.

=2D Consider what happens if you were to recompile at this point, so
  that you again have the _untracked_ (w.r.t. the 'master' branch)
  build products, and then check out B1 again.  Git faces the choice
  of either overwriting your worktree files (and losing them) or not
  overwriting (and not doing the checkout right), so it will abort.
  This is a corollary of what Jakub pointed out, Git will not lose
  information unless told to.


[1] If you were to switch branches at this point, without making a
commit, Git tries to "carry over" the addition of files to the target
branch, unless it conflicts with files in that target branch, so the
index is in a slightly different position than the HEAD.  Still,
anything that is listed in the index is considered tracked.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart7623390.lVbZ3vAOlv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkoCpwwACgkQqUud07tmzP1k4QCfRiio/7ReMPJ5JqUivfre2pQ8
eDMAoIVCh930YTeGjc9CJHW6crkqamux
=1mOX
-----END PGP SIGNATURE-----

--nextPart7623390.lVbZ3vAOlv--
