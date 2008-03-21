From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Why rebase with preserve merges asks for merged commits
Date: Fri, 21 Mar 2008 13:56:50 +0100
Message-ID: <20080321125650.GA4587@alea.gnuu.de>
References: <alpine.LSU.1.00.0803201208080.3983@racer.site> <1206018070-3402-1-git-send-email-joerg@alea.gnuu.de> <alpine.LSU.1.00.0803210040270.4124@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 21 14:06:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcgwZ-000300-IU
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 14:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912AbYCUNFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 09:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600AbYCUNFS
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 09:05:18 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3370 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011AbYCUNFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 09:05:16 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 204EA488024; Fri, 21 Mar 2008 14:05:12 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JcgnB-0006HL-55; Fri, 21 Mar 2008 13:56:21 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jcgni-0005lB-Aa; Fri, 21 Mar 2008 13:56:50 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803210040270.4124@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77736>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Johannes,

Johannes Schindelin schrieb am Fri 21. Mar, 00:46 (+0100):
> On Thu, 20 Mar 2008, J=F6rg Sommer wrote:
>=20
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
> > index 62e65d7..c849415 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -362,4 +362,56 @@ test_expect_success 'rebase with a file named HEAD=
 in worktree' '
> > =20
> >  '
> > =20
> > +test_expect_success 'squash and preserve merges' '
> > +	test_tick &&
> > +	git checkout -b squash-and-preserve-merges master &&
> > +	echo A > file1 &&
> > +	git commit -m SaPM-1 file1 &&
> > +	echo B > file1 &&
> > +	git commit -m SaPM-2 file1 &&
> > +	git merge to-be-preserved &&
> > +	echo C > file1 &&
> > +	git commit -m SaPM-3 file1
> > +'
> > +
> > +# This test should fail, because the prompt includes the commit from t=
he
> > +# merge not only the merge:
> > +# -> pick 9604163 unrelated
> > +#    pick 5ef0364 SaPM-1
> > +#    pick 22aadcf SaPM-2
> > +#    pick 828f7d8 Merge branch 'to-be-preserved' into squash-and-prese=
rve-merges
> > +#    pick 2a15a54 SaPM-3
> > +test_expect_failure 'expect preserve merges shown not commits from mer=
ge' '
> > +        EXPECT_COUNT=3D4 FAKE_LINES=3D"1 2 squash 4 3" \
> > +          git rebase -i -p --onto branch1 master ||
> > +        { git rebase --abort;
> > +          EXPECT_COUNT=3D5 FAKE_LINES=3D"1 2 3 squash 5 4" \
> > +          git rebase -i -p --onto branch1 master;
> > +          false; }
> > +'
>=20
> I'm sorry, but I have to tell you: I do not like that style at all (for=
=20
> one, your expect_failure can succeed for all kind of reasons, the exit=20
> value of git rebase --abort is not even checked).

Yes, it's ugly. So, let me step back. Think of the following situation:

M----------U          to-be-preserved
 \          \
  `--A---B---+---C    squash-and-preserve-merges

When I do a rebase M..C with preserve merges I can decide about all commits
including U which came in with the merge.

U  pick 9604163 unrelated
A  pick 5ef0364 SaPM-1
B  pick 22aadcf SaPM-2
+  pick 828f7d8 Merge branch 'to-be-preserved' into squash-and-preserve-mer=
ges
C  pick 2a15a54 SaPM-3

Why I can decide about the commit U from the branch to-be-preserved? I
expect to see not the commit from the merged branches, because they
aren't related to the branch to be rebased.

Let's take a different situation:

M--U1--U2--U3
 \           \
  `---A---B---+---C

A rebase M..C with preserve merges asks you about the commits M..U3, too.
Why? I preserve the merge that pulls in these commmits.

Bye, J=F6rg.
--=20
Die meisten Menschen wollen lieber durch Lob ruiniert
als durch Kritik gerettet werden.

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH47CSwe0mZwH1VIARAhsOAJ9nGn/OYRiUNV/teRuA6oK95S7X7gCglxv/
sNnPr3fLYBa690L4zB5ZAgI=
=74iG
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
