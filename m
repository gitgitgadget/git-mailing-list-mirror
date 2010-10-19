From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: fetch and bundle don't work in (semi-)broken repo
Date: Tue, 19 Oct 2010 22:11:39 +0200
Message-ID: <20101019201139.GB28166@pengutronix.de>
References: <20101019160957.GK11713@pengutronix.de> <20101019183925.GF25139@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 22:12:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8IXe-0005nj-DS
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 22:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058Ab0JSUMD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 16:12:03 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34236 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023Ab0JSUMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 16:12:01 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8IXJ-0004M4-KH; Tue, 19 Oct 2010 22:11:53 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8IX5-0001cY-Cq; Tue, 19 Oct 2010 22:11:39 +0200
Content-Disposition: inline
In-Reply-To: <20101019183925.GF25139@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159361>

Hi Jonathan,

On Tue, Oct 19, 2010 at 01:39:25PM -0500, Jonathan Nieder wrote:
> Uwe Kleine-K=F6nig wrote:
>=20
> > 	ukl@hostname:~/path1/linux-2.6$ git fetch ~/path2/linux-2.6 sectio=
nmismatches
> > 	remote: Counting objects: 118, done.
> > 	remote: error: unable to find 40aaeb204dc04d3cf15c060133f65538b43b=
13b0
> > 	remote: Compressing objects: 100% (83/83), done.
> > 	remote: fatal: unable to read 40aaeb204dc04d3cf15c060133f65538b43b=
13b0
> > 	error: git upload-pack: git-pack-objects died with error.
> > 	fatal: git upload-pack: aborting due to possible repository corrup=
tion on the remote side.
>=20
> Sounds like alternates or workdir allowed gc to be overzealous, indee=
d.
>=20
> Could you:
>=20
>  1. Make a copy of the corrupted repo, just in case.
>  2. Explode all backs with "git unpack-objects"
I did:

	mv .git/objects/pack .git/objects/pack.bak
	rm .git/objects/info/alternates
	for p in .git/objects/pack.bak/*.pack ~/path1/linux-2.6/.git/objects/p=
ack/*.pack; do
		git unpack-objects < $p
	done


>  3. Identify the missing object, as explained in
>     Documentation/howto/recover-corrupted-blob-object.txt?

and I'm running git-fsck --full now over night as it's bedtime here.
=20
> With that information, it would be easier to examine whether and how
> pack-objects could be smarter about fetching the non-missing objects.
>=20
> > I don't know what 40aaeb204dc04d3cf15c060133f65538b43b13b0 is, but =
I
> > think it's not necessary for the sectionmismatches branch:
> >=20
> > 	ukl@hostname:~/path2/linux-2.6$ git format-patch linus/master..sec=
tionmismatches
> > 	0001-wip-enable-DEBUG_SECTION_MISMATCH.patch
> [...]
> > and linus/master is contained in ~/path1/linux-2.6, too.
>=20
> Cc-ing Nico, pack-objects wizard.
>=20
> Thanks for reporting.
Thanks for helping

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
