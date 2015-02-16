From: Fairuzan Roslan <fairuzan.roslan@gmail.com>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Tue, 17 Feb 2015 02:41:24 +0800
Message-ID: <340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com> <vpqtwyl90mx.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: multipart/signed; boundary="Apple-Mail=_2715EE70-FEE2-44C1-B7A1-AA1B5DB94BA2"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 16 19:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNQbv-0000nr-JF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 19:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbbBPSlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 13:41:31 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:40956 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbbBPSla (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 13:41:30 -0500
Received: by paceu11 with SMTP id eu11so269963pac.7
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 10:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=lJdEcXW+Bkr9DbBcxRjEh16UQOHsvBbIoU1PSSuvEY4=;
        b=VkRPZWY7H1A+TeVxISlSS42W+66L3vvrXVPvVeKegKRLQCXKCNfdJOmvSoXwRX9SQa
         2M+EW6+Zuzs23xSRT3bFaby8lN7ijkKEp9ePRJLabsiVyLMB3DUHt4CC60kRwOtfZgb7
         PeV/NIOyZv7+0fBijexth847tl5K+TXd69P7GBoXEg/JrlNMsm0xZwd+Ue/NCvLKmwZs
         tOxqs2guzIUH54BjB8Kijw35twTqSozLRMovImZpGgHm4sLUglZmlVAQDo54e07kBLZr
         T1p5UkD+Cx0sBN2u9OTsPL3zxUgf3iw69pIPu2TBvDixKMLHERIsEjyuoVk8FR6KmDFP
         bchQ==
X-Received: by 10.66.120.236 with SMTP id lf12mr43169770pab.67.1424112089960;
        Mon, 16 Feb 2015 10:41:29 -0800 (PST)
Received: from [192.168.88.200] (brk-24-241.tm.net.my. [202.188.24.241])
        by mx.google.com with ESMTPSA id ao5sm6009306pbc.66.2015.02.16.10.41.27
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Feb 2015 10:41:28 -0800 (PST)
X-Pgp-Agent: GPGMail 2.5b5
In-Reply-To: <vpqtwyl90mx.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263911>


--Apple-Mail=_2715EE70-FEE2-44C1-B7A1-AA1B5DB94BA2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I don=E2=80=99t see the issue for the owner of his/her own file to have =
write access.
Setting tmp idx & pack files to read-only even for the file owner is not =
a safety feature.

The real issue here is that in AFP file system can=E2=80=99t even unlink =
or rename or delete the tmp idx and pack file with no write access after =
it done, while other file system like ext4,hfs+, etc can.

You should at least give the user the option to set the permission in =
the config file and not hardcoded the permission in the binary.

Regards,
Fairuzan


> On Feb 17, 2015, at 2:23 AM, Matthieu Moy =
<Matthieu.Moy@grenoble-inp.fr> wrote:
>=20
> Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:
>=20
>> Hi,
>>=20
>> Somehow the =E2=80=9Cint mode =3D 0444;=E2=80=9D in odb_mkstemp =
(environment.c) are
>> causing a lot of issues (unable to unlink/write/rename) to those
>> people who use AFP shares.
>=20
> Is it a problem when using Git (like "git gc" failing to remove old
> packs), or when trying to remove files outside Git?
>=20
>> The issue was first introduced in
>> =
https://github.com/git/git/blob/f80c7ae8fe9c0f3ce93c96a2dccaba34e456e33a/w=
rapper.c
>> line 284.
>=20
> I don't think so. The code before this commit did essentially a chmod
> 444 on the file, so object files were already read-only before.
>=20
> The pack files have been read-only since d83c9af5c6a437ddaa9dd27 =
(Junio,
> Apr 22 2007).
>=20
>> To fix these issues the permission need to be adjusted to =E2=80=9Cint =
mode =3D
>> 0644;=E2=80=9D in odb_mkstemp (environment.c)
>=20
> The issue is that having object and pack files read-only on the
> filesystem is a safety feature to prevent accidental modifications =
(even
> though it's actually not that effective, since brute-force "sed -i" or
> "perl -i" still accept to modify read-only files).
>=20
> So, I'd be a bit reluctant to remove this safety feature for all users
> if it's only for the benefit of a minority of users. Not that I think
> the problem shouldn't be fixed, but I'd rather investigate alternate
> solutions before using this mode =3D 0644.
>=20
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/


--Apple-Mail=_2715EE70-FEE2-44C1-B7A1-AA1B5DB94BA2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJU4jnVAAoJEKrU1IvC77KVIAwH/R4hBlkG0SrhK1yqnKANnF4i
n4ulhpUyXQ+hc3BGhdw+uqwcDSN/YdmIpO0bTQu+Sde8sYnP9GOh5mOQTO69AraX
IgCvs0hMJH+BLtxGlbzIL3KjsMm+V6elgxXIyEmeEiYLgEPgxdY62OOi9hixFhpp
qWmUvrF/XQseQp6H8KdZ1jX08YcFvSvjTxrGcG5JmPRZb2Cj4VHk5JFRpiQCLkI1
wl6wKi/p+jXOcHkcnzXz86w76YCHaveZKdbZI4bkfFETDqlvT13sGIFrVqcGOxl/
qtxIBU3iVeOLeVFttz5b4wNGk96m+pn2ijYPfaXhZfPpUHljveyTUfD2DKNkYEM=
=iT37
-----END PGP SIGNATURE-----

--Apple-Mail=_2715EE70-FEE2-44C1-B7A1-AA1B5DB94BA2--
