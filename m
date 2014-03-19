From: Max Horn <max@quendi.de>
Subject: Re: [PATCH 2/3] remote-hg: allow invalid bookmarks in a few edge cases
Date: Wed, 19 Mar 2014 16:00:53 +0100
Message-ID: <CDB4DDFC-FF7F-4BE0-A0B5-0933A506F690@quendi.de>
References: <1395232399-60112-1-git-send-email-max@quendi.de> <1395232399-60112-2-git-send-email-max@quendi.de> <CALWbr2yb9_Kumm697w2c68xE6JPpkF9OfxvP2acsPjPFq=zboQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_90D5BD50-E95E-46F4-A5E1-283A1D445B12"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 16:01:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQHzJ-0008MR-1v
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 16:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbaCSPA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 11:00:56 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53901 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933897AbaCSPAy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2014 11:00:54 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WQHzA-0001i7-U0; Wed, 19 Mar 2014 16:00:52 +0100
In-Reply-To: <CALWbr2yb9_Kumm697w2c68xE6JPpkF9OfxvP2acsPjPFq=zboQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1395241254;6464f371;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244450>


--Apple-Mail=_90D5BD50-E95E-46F4-A5E1-283A1D445B12
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Antoine,

On 19.03.2014, at 14:07, Antoine Pelisse <apelisse@gmail.com> wrote:

> Hi Max,
>=20
> Thank you for working on this.
> I believe it would be fair that you forget about patch 1/3 as you fix
> it in this patch (2/3).
> Also, I think it would be best NOT to integrate a patch (mine) that
> breaks a test, as it
> would make bisect harder to use.


OK, makes sense. I didn't want to step on anybodies feet by hijacking =
previously made work (however small or big it might be -- I've been =
burned by this before). Anyway, so I'll squash the first two commits =
together (or all three even?), and edit the message. But I'd like to =
properly attribute that you discovered the issue, so perhaps I can add =
something like "Reported-by: Antoine Pelisse" or so?

Max

>=20
> Thanks,
> Antoine
>=20
> On Wed, Mar 19, 2014 at 1:33 PM, Max Horn <max@quendi.de> wrote:
>> Fix the previous commit to workaround issues with edge cases: =
Specifically,
>> remote-hg inserts a fake 'master' branch, unless the cloned hg =
repository
>> already contains a 'master' bookmark. If that 'master' bookmark =
happens
>> to reference the 'null' commit, the preceding fix ignores it. This
>> would leave us in an inconsistent state. Avoid this by NOT ignoring
>> null bookmarks named 'master' or 'default' under suitable =
circumstances.
>>=20
>> Signed-off-by: Max Horn <max@quendi.de>
>> ---
>> contrib/remote-helpers/git-remote-hg | 7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/contrib/remote-helpers/git-remote-hg =
b/contrib/remote-helpers/git-remote-hg
>> index 12d850e..49b2c2e 100755
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>> @@ -626,8 +626,11 @@ def do_list(parser):
>>     repo =3D parser.repo
>>     for bmark, node in bookmarks.listbookmarks(repo).iteritems():
>>         if node =3D=3D '0000000000000000000000000000000000000000':
>> -            warn("Ignoring invalid bookmark '%s'", bmark)
>> -            continue
>> +            if fake_bmark =3D=3D 'default' and bmark =3D=3D =
'master':
>> +                pass
>> +            else:
>> +                warn("Ignoring invalid bookmark '%s'", bmark)
>> +                continue
>>         bmarks[bmark] =3D repo[node]
>>=20
>>     cur =3D repo.dirstate.branch()
>> --
>> 1.9.0.7.ga299b13
>>=20
>=20


--Apple-Mail=_90D5BD50-E95E-46F4-A5E1-283A1D445B12
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlMpsSgACgkQIpJVslrhe1lzFQD/cWIuOedbaVQWZDHT7H46+un4
7pb2ynpEzYxM/4aKHykA/Rqg8y4QeYVZ2z4uusu0TYcPF/YdLY7VyGcyjBZpi8tQ
=96Ki
-----END PGP SIGNATURE-----

--Apple-Mail=_90D5BD50-E95E-46F4-A5E1-283A1D445B12--
