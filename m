From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] Support output ISO 8601 format dates
Date: Sun, 15 Jul 2007 23:23:59 +0200
Message-ID: <20070715212359.GB18293@efreet.light.src>
References: <20070713202258.14107.18196.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Cc: junkio@cox.net, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 23:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IABZc-0000dQ-0K
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 23:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbXGOVYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 17:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbXGOVYG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 17:24:06 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:41674 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbXGOVYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 17:24:05 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id F1ABA57577;
	Sun, 15 Jul 2007 23:24:02 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id aGr8zg7jYLoG; Sun, 15 Jul 2007 23:24:01 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id B0F13572F9;
	Sun, 15 Jul 2007 23:24:01 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IABZP-0006rN-M1; Sun, 15 Jul 2007 23:23:59 +0200
Content-Disposition: inline
In-Reply-To: <20070713202258.14107.18196.stgit@lathund.dewire.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52585>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 13, 2007 at 22:22:58 +0200, Robin Rosenberg wrote:
> +	else if (mode =3D=3D DATE_ISO8601)
> +		sprintf(timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
> +				tm->tm_year + 1900,
> +				tm->tm_mon + 1,
> +				tm->tm_mday,
> +				tm->tm_hour, tm->tm_min, tm->tm_sec,
> +				tz);

I apologise for nitpicking, but ISO 8601 (and RFC 3339) says separator betw=
een
date and time is 'T' and there is no separator between time and timezone. So
this should be

+		sprintf(timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%+05d",

for 100% conformance to the standard. RFC 3339 explicitely mentions using
space instead of 'T' as separator as allowed, but does not seem to mention
space before time zone. There may be applications that would stop at such
space and assume no timezone information.

Furthermore RFC 3339 seems to require colon in the timezone, so it would be:

+		sprintf(timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%+03d:%02d",
+				tm->tm_year + 1900,
+				tm->tm_mon + 1,
+				tm->tm_mday,
+				tm->tm_hour, tm->tm_min, tm->tm_sec,
+				tz / 100, abs(tz % 100));

ISO 8601 makes separators optional, so simple 4-digit timezone is OK.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmpBvRel1vVwhjGURAo9sAKCxj5qsghl3fdgmatzC/WVG5IhDPwCfeUEp
Zyk0sBfEbMggOW8DVWjpsNc=
=OYhT
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
