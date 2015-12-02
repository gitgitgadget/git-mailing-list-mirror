From: huebbe <nathanael.huebbe@informatik.uni-hamburg.de>
Subject: Re: Bug: Incorrect stripping of the [PATCH] prefix in git-am
Date: Wed, 2 Dec 2015 13:38:18 +0100
Message-ID: <565EE63A.3040006@informatik.uni-hamburg.de>
References: <5655D3DA.1050403@informatik.uni-hamburg.de>
 <5655D755.8060503@atlas-elektronik.com>
 <5655DAE7.2000008@informatik.uni-hamburg.de>
 <20151202005826.GE28197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hcgg9rd3kK57ce54cX4bxAIMswWeGlLLJ"
Cc: stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 13:38:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a46g4-0002KY-VM
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 13:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056AbbLBMi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 07:38:28 -0500
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:62835 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755928AbbLBMi1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2015 07:38:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id DC082D09;
	Wed,  2 Dec 2015 13:38:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
	by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fJs+oA-eyozA; Wed,  2 Dec 2015 13:38:23 +0100 (CET)
Received: from [136.172.14.25] (unknown [136.172.14.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: huebbe)
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 875E7D05;
	Wed,  2 Dec 2015 13:38:23 +0100 (CET)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <20151202005826.GE28197@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281887>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hcgg9rd3kK57ce54cX4bxAIMswWeGlLLJ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/02/2015 01:58 AM, Jeff King wrote:
> On Wed, Nov 25, 2015 at 04:59:35PM +0100, huebbe wrote:
>=20
>> Yes, it looks like the `--keep-non-patch` option works around this.
>>
>> However, shouldn't that be the default behaviour?
>> I mean, what is the point in stripping stuff that is not proven to be =
inserted by `git` itself?
>> That's not what I expect a tool to do which I trust.
>=20
> The "[]" convention is a microformat used by Linux kernel folks. So it'=
s
> not "whoops, we are stripping stuff not added by git". It is respecting=

> a microformat used by the tool's authors.
>=20
> That being said, if we were choosing a default from scratch today, it
> might go the other way. But we aren't, and we have to deal with the
> burden of breaking existing scripts by flipping it.
>=20
> -Peff

Ok, I think I understand the reason for this behavior now.
However, I still believe that the `git format-patch`/`git am` combo
should retain the original commit messages by default.

As such, I would like to ask whether it would be possible/sensible
to somehow escape square brackets, or mark the beginning
of the original commit message in the `git format-patch` output?
This would allow `git am` to reproduce the exact commit message by defaul=
t
without breaking the "[]" convention.


For example, I could imagine to use this behavior:

  * `git format-patch` produces a message of the format "[PATCH ...]: ori=
ginal commit message".

  * `git am` strips the longest prefix that consists entirely of brackete=
d stuff
    and ends with the string "]: ". If that terminator is not found -> ol=
d behavior.

  * Users could insert any "[FOO]" strings they like before the ":",
    which would still be stripped from the commit message by `git am`.

Of course, any such change would not be without pitfalls. With the rule a=
bove,
we would get ": " prepended to commit messages if a patch is created with=
 a `git` version
that has the change, and applied with an older version that does not know=
 about the terminator.


What do you guys think? Is there anything I missed?


Cheers,
Nathanael


--=20
Please be aware that the enemies of your civil rights and your freedom
are on CC of all unencrypted communication. Protect yourself.



--hcgg9rd3kK57ce54cX4bxAIMswWeGlLLJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWXuY+AAoJEO3tJW5NCfoM7nMQALFSTEobKrG9BaAuop3YUdGj
J5HfuAbkBXJv7UF7FQL87GycPhzOi/hblW4ayXKpiS7l9GWKAVZoEprNUv05um0T
9UJiHBHFD5FHkxXKSj4a9TCLc2mkEDEBaIBltIeCrIy13xW7NZw4grWrvkd/kJC3
T2umHprJiaILeXCCSzmQMN0H/YSu4cEYPX19BuFdHPpUmWQg65+CTcMiOFN7dawY
068YDbooLfr+VZ76pqBhtS84SvqAMxddkWn5QzkfyhX7M6/iEJ8BR35zHVNkwKRD
EaPSTSfG5XWNdB5C5YkoTLPcEXlyCMgfZX680KzFm2Znh+0G7svowkoTHZNqQ34t
QwrBSFQf0ACsJwoszpa8BDh6rUL6YCrT2+4PveXjuflgK+jhrZqWiXnGudPlsek/
ILtXC18x1id2qi53vN5DYCfWvO+Iu1qI+HrOGZr2PegMDJNXg3rsXHATAUlkbpdh
ZJ/0nnK1Q7nHTizJtJbbo6ACMBRekXoz+qQ8C3yJwOOn7945uyjSFsd1Ra7nNqxP
M4NAHFTlfvT2QH4C4vO6lW/JXgsX+hYZopP/5Wo6VLbpoiGImMv2vIwgcKt+N25a
Cl/MXHYfa3VmhzBPhwBprzBj0UJZGOOR6x5f4yH5Cqlk5zq5lbjhFVx30k1E9rML
pVtRGOIR+QLCWbFTl5Tn
=UEPR
-----END PGP SIGNATURE-----

--hcgg9rd3kK57ce54cX4bxAIMswWeGlLLJ--
