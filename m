From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Limit filename for format-patch
Date: Sat, 24 Feb 2007 12:24:40 +0100
Message-ID: <200702241224.41208.robin.rosenberg@dewire.com>
References: <200702232239.19504.robin.rosenberg@dewire.com> <20070223222606.28660.46208.stgit@lathund.dewire.com> <7vtzxcym3t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 24 12:23:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKv05-0004al-T6
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 12:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbXBXLXQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 24 Feb 2007 06:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933506AbXBXLXQ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 06:23:16 -0500
Received: from [83.140.172.130] ([83.140.172.130]:23072 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932825AbXBXLXP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Feb 2007 06:23:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C2400803393;
	Sat, 24 Feb 2007 12:18:13 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24985-08; Sat, 24 Feb 2007 12:18:13 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 6C25E8027F8;
	Sat, 24 Feb 2007 12:18:11 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <7vtzxcym3t.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40513>

l=F6rdag 24 februari 2007 09:51 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>=20
> > -static void reopen_stdout(struct commit *commit, int nr, int keep_=
subject)
> > +static int reopen_stdout(struct commit *commit, int nr, int keep_s=
ubject)
> >  {
> > -	char filename[1024];
> > +	char filename[PATH_MAX];
> >  	char *sol;
> >  	int len =3D 0;
> > -	int suffix_len =3D strlen(fmt_patch_suffix) + 10; /* ., NUL and s=
lop */
> > +	int suffix_len =3D strlen(fmt_patch_suffix) + 1;
> > =20
> >  	if (output_directory) {
> > -		strlcpy(filename, output_directory, 1000);
> > +		if (strlen(output_directory) >=3D sizeof(filename) - 64 - suffix=
_len)
> > +			return error("name of output directory is too long");
> > +		strlcpy(filename, output_directory, sizeof(filename) - suffix_le=
n);
>=20
> Sorry for a late doubt, but I started wondering if we should use
> NAME_MAX instead of hardcoded 64.  Purists might argue for using
> pathconf() but I think it is an overkill.
I think it'd sane to keep the name much shorter than what is actually p=
ossible. The
patches will have a counter to keep the names unique anyway.

>=20
> NAME_MAX is 255 on Linux, POSIX says it should be 14 at least
> (and further says if the platform supports only smaller max,
> NAME_MAX should not be defined -- heh).  I do not know how
> universal NAME_MAX is defined, and I hate dealing with header
> incompatibility across different systems, so I am tempted to
> just do something like:
>=20
> #define FORMAT_PATCH_NAME_MAX 64
>=20
> locally, and use that instead.
Ok with me.

-- robin
