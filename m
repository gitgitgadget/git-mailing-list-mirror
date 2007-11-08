From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] Re: git-svn fetch doesn't like spaces in branch names
Date: Thu, 8 Nov 2007 09:49:04 +0100
Message-ID: <06671B5D-DF06-448E-A3BD-D936C1DE6BAA@lrde.epita.fr>
References: <654A4D1D-712F-4978-9812-E8FA411FAE0D@mac.com> <B28A099B-1BC8-4CED-856A-5FFD7F6711FC@mac.com> <20071108072918.GC3170@steel.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-83--691303582"
Content-Transfer-Encoding: 7bit
Cc: "Michael J. Cohen" <michaeljosephcohen@mac.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:49:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq34t-0007oK-8L
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbXKHItQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbXKHItQ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:49:16 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:41682 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbXKHItP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:49:15 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Iq34b-00023i-5A; Thu, 08 Nov 2007 09:49:13 +0100
In-Reply-To: <20071108072918.GC3170@steel.home>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63968>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-83--691303582
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

On Nov 8, 2007, at 8:29 AM, Alex Riesen wrote:

> Michael J. Cohen, Thu, Nov 08, 2007 01:53:07 +0100:
>>> mini:TextMateBundles mjc$ git-svn fetch
>>> Found possible branch point:
>>> http://macromates.com/svn/Bundles/trunk/Tools/Dialog PlugIn =3D>
>>> http://macromates.com/svn/Bundles/branches/Dialog PlugIn =20
>>> Completion Menu,
>>> 8089
>>> Initializing parent: Dialog PlugIn Completion Menu@8089
>>> Bad URL passed to RA layer: Malformed URL for repository at
>>> /opt/local/bin/git-svn line 1607
>>>
>>> looks like that might need to be %20 ?
>>
>>
>> Hacky, but it works.
>>
>> Signed-off-by: Michael J. Cohen <mjc@cruiseplanners.com>
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index dd93e32..5dc3b9c 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -1976,6 +1976,7 @@ sub find_parent_branch {
>> 	my $r =3D $i->{copyfrom_rev};
>> 	my $repos_root =3D $self->ra->{repos_root};
>> 	my $url =3D $self->ra->{url};
>> +	$branch_from =3D~ s@([\s])@sprintf("%%%02X", ord($1))@seg;
>
> You don't need "[" and "]".

You don't even need the "(" and ")"

$branch_from =3D~ s@\s@sprintf("%%%02X", ord($&))@seg;

But I think it'd be better to fix this properly.  I guess some people =20=

use branch names with accentuated characters such as =E9 =E8 =FC =
whatever.  =20
What about this instead (untested):

$branch_from =3D~ s@[^\w\d_]@sprintf("%%%02X", ord($&))@seg;

Otherwise there are various existing Perl modules such as http://=20
search.cpan.org/dist/URI/URI/Escape.pm but this seems overkill / not =20
portable (unless we distribute these files along with Git).

Cheers,

--=20
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-83--691303582
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHMs2AwwE67wC8PUkRAp04AJ4u+2BtK8fnCz1ubXG5srfNhK2CNwCgkinJ
icys+0b5hJy1ULP6YyUccDI=
=LLY+
-----END PGP SIGNATURE-----

--Apple-Mail-83--691303582--
