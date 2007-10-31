From: Erik Mouw <mouw@nl.linux.org>
Subject: [PATCH] Get rid of cpio in git-clone (was: Re: cpio command not
	found)
Date: Wed, 31 Oct 2007 21:14:25 +0100
Organization: Eric Conspiracy Secret Labs
Message-ID: <20071031201425.GA29332@gateway.home>
References: <18216.31314.990545.518458@lisa.zopyra.com> <20071031133039.GA29065@diana.vm.bytemark.co.uk> <20071031140655.GA8802@gateway.home> <Pine.LNX.4.64.0710311420330.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Cc: Karl Hasselstr?m <kha@treskal.com>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 21:15:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InJy6-0003Nm-34
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 21:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbXJaUO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 16:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754333AbXJaUO4
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 16:14:56 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:1948 "EHLO
	smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbXJaUO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 16:14:56 -0400
Received: from gateway.home (a82-92-155-199.adsl.xs4all.nl [82.92.155.199])
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9VKEQn1055367;
	Wed, 31 Oct 2007 21:14:31 +0100 (CET)
	(envelope-from mouw@nl.linux.org)
Received: from erik by gateway.home with local (Exim 3.36 #1 (Debian))
	id 1InJxJ-0008D3-00; Wed, 31 Oct 2007 21:14:25 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710311420330.4362@racer.site>
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62861>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 31, 2007 at 02:20:47PM +0000, Johannes Schindelin wrote:
> On Wed, 31 Oct 2007, Erik Mouw wrote:
>=20
> > On Wed, Oct 31, 2007 at 02:30:39PM +0100, Karl Hasselstr?m wrote:
> > > On 2007-10-31 06:51:30 -0600, Bill Lear wrote:
> > >=20
> > > > I don't remember this dependence from earlier versions of git. I=20
> > > > have been running git 1.4.xx on this machine for a while...
> > >=20
> > > When you clone with -l, git uses cpio to hardlink to the original=20
> > > repository. What has changed is that -l is now used by default when=
=20
> > > cloning a repository that's accessed via the file system (as opposed=
=20
> > > to over some network protocol).
> >=20
> > Why cpio? What is wrong with ln(1) (every Unix should have one) or
> > link(2) ?
>=20
> Patch, please?

Here you go.

Remove dependency on cpio for git-clone. Apparently some POSIX systems
out there don't have cpio, just assume cp is there.

Signed-off-by: Erik Mouw <mouw@nl.linux.org>

diff --git a/INSTALL b/INSTALL
index f1eb404..9074563 100644
--- a/INSTALL
+++ b/INSTALL
@@ -79,8 +79,7 @@ Issues of note:
 	- "perl" and POSIX-compliant shells are needed to use most of
 	  the barebone Porcelainish scripts.
=20
-	- "cpio" is used by git-merge for saving and restoring the index,
-	  and by git-clone when doing a local (possibly hardlinked) clone.
+	- "cpio" is used by git-merge for saving and restoring the index.
=20
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
diff --git a/git-clone.sh b/git-clone.sh
index 0ea3c24..061534c 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -294,7 +294,7 @@ yes)
 			fi
 		fi &&
 		cd "$repo" &&
-		find objects -depth -print | cpio -pumd$l "$GIT_DIR/" || exit 1
+		cp -Rp$l objects/ "$GIT_DIR/" || exit 1
 	fi
 	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
 	;;



--=20
They're all fools. Don't worry. Darwin may be slow, but he'll
eventually get them. -- Matthew Lammers in alt.sysadmin.recovery

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHKOIg/PlVHJtIto0RAmm/AJ9+tja3hwhZNnqWNdHOo9jKy/s6yACeNmhL
Lal4+Qq1PnWFd1v7TzsA378=
=4GAq
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
