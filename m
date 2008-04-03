From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] git-p4: Fix race between p4_edit and p4_change
Date: Thu, 3 Apr 2008 20:32:32 +0200
Message-ID: <200804032032.39860.simon@lst.de>
References: <20080401222856.GA22542@morganstanley.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2138526.IpU1O9jCkL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Green <Kevin.T.Green@morganstanley.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 20:33:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhUFf-00030s-5X
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 20:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbYDCScs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 14:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbYDCScs
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 14:32:48 -0400
Received: from hoat.troll.no ([62.70.27.150]:59797 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbYDCScr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 14:32:47 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 67F7D20AED;
	Thu,  3 Apr 2008 20:32:42 +0200 (CEST)
Received: from luria.local (unknown [172.20.1.59])
	by hoat.troll.no (Postfix) with ESMTP id 52B1320AB4;
	Thu,  3 Apr 2008 20:32:42 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080401222856.GA22542@morganstanley.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78769>

--nextPart2138526.IpU1O9jCkL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 02 April 2008 00:28:56 Kevin Green wrote:
> Hi,
>
> Ran into a nasty race today with git-p4.  The changelist Files: section w=
as
> showing up empty and it turned out to be a race between the p4_edit and
> p4_change -o, e.g.
>
> $ p4 edit $file && p4 change -o
>
> will show no files in the Files: section.
>
> I attach a patch after my .sig as a suggested fix.  It simply loops over
> the p4_changes -o as long as we're not finding any files (and we always
> should since we just did a p4_edit!); sleeping for 3 secs in between to
> allow Perforce to catch up with itself.

I don't mind the workaround in general as I agree this race is a bit nasy, =
but=20
shouldn't the sleep only happen if we didn't find any files? Right now even=
=20
if the server reacted immediately we still sleep for three seconds.

Another condition could be to verify that the list of files in the files=20
section is identical to the list of files we called 'p4 edit' on.

Last but not least we could of course also generate the entire Files: secti=
on=20
ourselves, using 'p4 change -o' just to get the rest of the template right.

I almost prefer the last approach, since we know the base depot path and th=
e=20
relative paths of all edited/added files.

What do you think?


Simon

--nextPart2138526.IpU1O9jCkL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH9SLHWXvMThJCpvIRAkKlAKDq635P0W4Hp+qAItAI3T5UC1/3jQCgr62F
lY1aeop+5PTlh2VHM5JtvjY=
=IHNx
-----END PGP SIGNATURE-----

--nextPart2138526.IpU1O9jCkL--
