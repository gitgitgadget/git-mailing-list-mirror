From: Charles McGarvey <chazmcgarvey@brokenzipper.com>
Subject: Re: [PATCH] instaweb: make the perl path configurable
Date: Wed, 12 Jun 2013 12:48:17 -0600
Organization: Sevenology
Message-ID: <51B8C271.9030105@brokenzipper.com>
References: <20130611201400.GA28010@compy.Home> <loom.20130612T155755-338@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2HJTFNRXWCWGMHLUNFJLU"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 20:48:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umq5p-0000Cz-El
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 20:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451Ab3FLSsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 14:48:21 -0400
Received: from romulus.brokenzipper.com ([71.19.157.142]:64631 "EHLO
	romulus.brokenzipper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757393Ab3FLSsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 14:48:20 -0400
Received: from vulcan.local (unknown [IPv6:2602:61:7edf:e300:0:ff:fe00:7701])
	by romulus.brokenzipper.com (Postfix) with ESMTP id 2C01A52CE4;
	Wed, 12 Jun 2013 12:48:20 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=brokenzipper.com;
	s=romulus; t=1371062900;
	bh=4ND+7TMtVAn6dZcb8A/5Ish4QPa7XEjC+XFXXPUHUeY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Co3MpGktFLDnZb2bDGMH9fFnxUQHk9XfzsmARYae1tcyYU0qPbvgcTsVCzgdm0bXP
	 25A/TqV0WJjURPRFJmf/nZct7qHvyzjnde0NpDKXGc/XERySNJJc4PQvU66RjMP75b
	 Aov43UdL8JdTALfcsIqV6T1AKDPmQNYaGM89Vl14=
Received: from [2602:61:7edf:e300:0:ff:fe00:7700]
	by vulcan.local with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <chazmcgarvey@brokenzipper.com>)
	id 1Umq6S-0007sA-5V; Wed, 12 Jun 2013 12:49:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130523 Thunderbird/17.0.6
In-Reply-To: <loom.20130612T155755-338@post.gmane.org>
X-Enigmail-Version: 1.6a1pre
OpenPGP: url=https://www.brokenzipper.com/chaz.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227664>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2HJTFNRXWCWGMHLUNFJLU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/12/2013 08:00 AM, Jakub Narebski wrote:
> Charles McGarvey <chazmcgarvey <at> brokenzipper.com> writes:
>=20
>> It is convenient for the user to be able to customize the path to perl=
 if they
>> do not want to use the system perl.  This may be the case, for example=
, if the
>> user wants to use the plackup httpd but its extra dependencies are not=

>> installed in the system perl; they can set the perl path to a perl tha=
t they
>> install and have control over in their own home directory.
>=20
> Is it really necessary?  There is always PERL5LIB if one wants to use P=
erl
> modules installed in one's own home directory.  If one is using local::=
lib
> one has it "for free".

Yes, that's right.  Using PERL5LIB would solve the example problem in the=

commit message, and it would even be pretty simple to set up using local:=
:lib.
 So, no, this isn't strictly necessary.

> If they do not want to use system perl there is always perlbrew.

Well, perlbrew is actually what I had in mind for this patch.  Without it=
, it
seems like the perl path -- which is configured while building git.git so=
 is
not easily changed by the user -- is "hard-coded" in the shebang line of =
the
plackup script file which is then made executable and exec'd, to start th=
e
httpd.  Given that process, I don't see how that code allows the user to =
use
any other perl, or am I missing something?

If adding a new config variable seems too heavy-handed for such a trivial=

problem, another approach would be to use the first perl in PATH and fall=
 back
on the git.git build system-configured perl if there is no perl in PATH.
However, considering the nature of perlbrew, the user may have many diffe=
rent
perls installed and multiple terminals open with shells configured for
different perls.  To make the instaweb command search the PATH for perl w=
ould
introduce some unpredictability; the command would succeed or fail depend=
ing
on whether or not the perl being "used" in the current shell has the plac=
kup
httpd dependencies installed.  So I think I prefer the ability to configu=
re
which perl to have git always use for instaweb over this approach.

In short summary, this patch isn't necessary because everyone could use
local::lib to manage dependencies not installed at the system level, but =
I
think this patch is desirable for those of us who use perlbrew and not
local::lib.  Of course, I'm open to alternatives and other suggestions.

Thanks Jakub,

--=20
Charles McGarvey


------enig2HJTFNRXWCWGMHLUNFJLU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlG4wnEACgkQNi05PrCndfvhdgCgitk4s7yMBnrrtg76R0ncGqHn
Sx0AnjoH64OtLkSfDWc+/zmmjeZbrVL6
=+rId
-----END PGP SIGNATURE-----

------enig2HJTFNRXWCWGMHLUNFJLU--
