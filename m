From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Bug?: import-tars misbehaves on Subversion tarballs
Date: Tue, 24 Apr 2007 10:40:37 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070424084037.GA8906@informatik.uni-freiburg.de>
References: <20070424073907.GA22121@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Michael Loeffler <zvpunry@zvpunry.de>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 10:40:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgGZr-0007Ix-FR
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 10:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031038AbXDXIko convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Apr 2007 04:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031046AbXDXIko
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 04:40:44 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63124 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031038AbXDXIkm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2007 04:40:42 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HgGZk-0004Q7-LB; Tue, 24 Apr 2007 10:40:40 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l3O8ecMu009199;
	Tue, 24 Apr 2007 10:40:38 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l3O8ebvg009198;
	Tue, 24 Apr 2007 10:40:37 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Michael Loeffler <zvpunry@zvpunry.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070424073907.GA22121@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45431>

Hello Karl,

Karl Hasselstr=F6m wrote:
> import-tars behaves very oddly when I try to import the Subversion
> tarballs. (For example,
> http://subversion.tigris.org/downloads/subversion-1.4.3.tar.bz2
> triggers this problem.) It creates two toplevel directories,
> subversion-1.4.3 and subversion-1.4.3subversion. The former seems to
> contain at least almost all files; the latter has only a handful of
> files, all with very long names.
>=20
> When I unpack it with GNU tar, I get all the files under a single
> "subversion-1.4.3" directory, as expected.
>=20
> Could it simply be that import-tars can't handle long filenames
> somehow? (This is pure speculation, since I know absolutely nothing
> about the tar format.)
I don't know much, but there are two locations that make up the name
(i.e. prefix + name).  Can you try the following patch:

---
 contrib/fast-import/import-tars.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import=
/import-tars.perl
index 5585a8b..5f3f742 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -64,7 +64,7 @@ foreach my $tar_file (@ARGV)
 		}
 		print FI "\n";
=20
-		my $path =3D "$prefix$name";
+		my $path =3D "$prefix/$name";
 		$files{$path} =3D [$next_mark++, $mode];
=20
 		$commit_time =3D $mtime if $mtime > $commit_time;
--=20
1.5.1.1.190.g74474

If it works, we still need a commit log ...

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D5%2B7
