From: Max Horn <max@quendi.de>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Wed, 19 Mar 2014 11:53:57 +0100
Message-ID: <906CACC0-FB16-4BB8-812D-59067DE0CC89@quendi.de>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com> <53240C0F.2050204@web.de> <xmqqha6wg3o1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_340105AB-B7DA-49E6-8888-34B52BAF719D"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 11:54:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQE8R-0003nZ-GD
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 11:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758262AbaCSKyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 06:54:06 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53004 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757893AbaCSKyE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2014 06:54:04 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WQE8H-0007rd-5r; Wed, 19 Mar 2014 11:54:01 +0100
In-Reply-To: <xmqqha6wg3o1.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1395226444;2c89f9e7;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244429>


--Apple-Mail=_340105AB-B7DA-49E6-8888-34B52BAF719D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1


On 17.03.2014, at 18:01, Junio C Hamano <gitster@pobox.com> wrote:

> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
>> On 2014-03-14 23.09, Junio C Hamano wrote:
>>> * ap/remote-hg-skip-null-bookmarks (2014-01-02) 1 commit
>>> - remote-hg: do not fail on invalid bookmarks
>>>=20
>>> Reported to break tests ($gmane/240005)
>>> Expecting a reroll.
>> I wonder what should happen here.
>> The change breaks all the tests in test-hg-hg-git.sh
>> (And the breakage may prevent us from detecting other breakages)
>>=20
>> The ideal situation would be to have an extra test case for the =
problem
>> which we try to fix with this patch.
>>=20
>> Antoine, is there any way to make your problem reproducable ?
>> And based on that, to make a patch which passes all test cases ?
>=20
> After re-reading the thread briefly (there're just five messages)
>=20
>  =
http://thread.gmane.org/gmane.comp.version-control.git/239797/focus=3D2400=
69

For some reason, that link does not contain all messages from that =
conversation (unfortunately, I have seen GMane do that on multiple =
occasions. I hence try not to rely on it for reviewing email history -- =
I just don't trust it). In particular, it misses this crucial post:
  http://thread.gmane.org/gmane.comp.version-control.git/239830

I call it crucial because it describes how to make a reproducible test =
cases out of this, in which a legitimate hg repository leads to a =
remote-hg error preventing the user from normal operation.


>=20
> I think the "breakage" the patch tries to fix seems to be of dubious
> nature in the first place ("I don't know how I ended-up with such a
> bookmark", Antoine says in $gmane/239800), and it has been in
> "Expecting a reroll" state in response to "I will try to come-up
> with an improved version" in $gmane/240069 but nothing has happened
> for a few months.
>=20
> At this point I think it would be OK for me to discard the topic
> (without prejudice); if the root cause of the issue (if there is
> one) and a proper fix is discovered in the future, the topic can
> come back with a fresh patch, but it appears to me that keeping the
> above patch in my tree would not help anybody.

The (or at least "a") root cause has actually been discovered. Would a =
patch that adds an xfail test case for it be acceptable?

As to the why the proposed patch causes test failures: I think this is =
due to the fact that remote-hg inserts a fake "master" branch (resp. =
"bookmark" in the hg terminology). Now, in those test cases, a hg =
repository gets created that actually contains a "null" bookmark named =
"master". When the proposed fix for the problem is added, this bookmarks =
gets ignored. But at that point, remote-hg already determined that there =
is a hg bookmark named "master", and adjusts how it works accordingly -- =
when we then remove that bookmarks, things go awry.

But I might be wrong here, and in any case, did not yet have time to =
come up with a proper fix. What I do have is a test case, that I could =
turn into an xfail test. As a matter of fact, I a know a few more bugs =
in remote-hg for which I could produce xfail test cases. Of course I'd =
prefer to put them in together with a fix, but I don't know when I can =
get to that, if ever. So, would such changes be welcome?




--Apple-Mail=_340105AB-B7DA-49E6-8888-34B52BAF719D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlMpd0kACgkQIpJVslrhe1l6jAD/Uf1kWOK0CsgYo1YJ40n41SOu
Dt53FJ+M6+sT9FI4pXIA/365lmz29EwPJOuY/BqpTjSY5Ci9GkBK4KzBn63XYPIm
=H2tw
-----END PGP SIGNATURE-----

--Apple-Mail=_340105AB-B7DA-49E6-8888-34B52BAF719D--
