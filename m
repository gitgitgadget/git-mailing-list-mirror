From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Tue, 06 Jan 2009 14:52:00 -0800
Organization: Slide, Inc.
Message-ID: <1231282320.8870.52.camel@starfruit>
References: <20081209093627.77039a1f@perceptron>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-/NM5M7bDPv20DOP4yrEI"
Cc: Git ML <git@vger.kernel.org>
To: Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue Jan 06 23:53:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKKnj-00010m-Ha
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 23:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935AbZAFWwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 17:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbZAFWwF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 17:52:05 -0500
Received: from mx0.slide.com ([208.76.68.7]:57144 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbZAFWwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 17:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=P
	u5luBCz2X+xS1PjcSmljgeDDR4jr6FrOkY4dhuXLAA=; b=DJqpJxCK2IcTsBcny
	KUOyaIetQB3gLefVMpfeszkbFjpjs7e4gVAJXxf4RuTDFwVRAIF8lC3fIjzTayEl
	k+gPDZ/4hFAaCiZ561IKj8YP2pzPxAkfGjhDVi1oTVei/iQSGT6czdcImWv7jX5t
	Du4AFDydVEXXycnhQz3mA7FIK4=
Received: from nat3.slide.com ([208.76.69.126]:38388 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKKmH-00066V-7d; Tue, 06 Jan 2009 14:52:01 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 35A1DA6F0002;
	Tue,  6 Jan 2009 14:52:01 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.832
X-Spam-Level: 
X-Spam-Status: No, score=-3.832 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.567, BAYES_00=-2.599]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BPU8gswNepjL; Tue,  6 Jan 2009 14:52:00 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id 89077A6F0003;
	Tue,  6 Jan 2009 14:52:00 -0800 (PST)
In-Reply-To: <20081209093627.77039a1f@perceptron>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104735>


--=-/NM5M7bDPv20DOP4yrEI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-09 at 09:36 +0100, Jan Kr=C3=BCger wrote:
> For fixing a corrupted repository by using backup copies of individual
> files, allow write_sha1_file() to write loose files even if the object
> already exists in a pack file, but only if the existing entry is marked
> as corrupted.

I figured I'd reply to this again, since the issue cropped up again.

We started experiencing *large* numbers of corruptions like the ones
that started the thread (one developer was receiving them once or twice
a day) with v1.6.0.4

We went ahead and upgraded to a custom build of v1.6.1 with Jan's patch
(below) and the issues /seem/ to have resolved themselves. I'm not
certain whether Jan's patch was really responsible, or if there was
another issue that caused this to correct itself in v1.6.1.=20

As it stands, I think it's safe to assume that given the frequency of
the occurances that they were not tied to a memory or disk error (or
other levels of the machine's stack would be suffering as well). The
only thing I can think of is that /some/ developers who've experienced
the issue are using Samba mount points and changing files in Mac OS X,
but using Git on the mounted share (i.e. TextMate changes a file hosted
on Samba, changes are committed in an SSH session on that machine), but
that doesn't account for everything.

If there was something else included in the v1.6.1 release please let me
know so I can back Jan's patch out.


Cheers


>=20
> Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
> ---
>=20
> On IRC I talked to rtyler who had a corrupted pack file and plenty of
> object backups by way of cloned repositories. We decided to try
> extracting the corrupted objects from the other object database and
> injecting them into the broken repo as loose objects, but this failed
> because sha1_write_file() refuses to write loose objects that are
> already present in a pack file.
>=20
> This patch expands the check to see if the pack entry has been marked
> as corrupted and, if so, allows writing a loose object with the same
> ID. Unfortunately, when Tyler tried a merge while using this patch,
> something we didn't manage to track down happened and now git doesn't
> consider the object corrupted anymore. I'm not sure enough that it
> wasn't caused by the patch to submit this patch without hesitation.
>=20
> Apart from that, I think the change is not all too great since it makes
> write_sha1_file() walk the list of pack entries twice. That's a bit of
> a waste.
>=20
> So those are the reasons why I wanted a few opinions first. Another
> reason is that there might be a way smarter method to fix this kind of
> problem, in which case I'd love hearing about it for future reference.
>=20
>  sha1_file.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/sha1_file.c b/sha1_file.c
> index 6c0e251..17085cc 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2373,14 +2373,17 @@ int write_sha1_file(void *buf, unsigned long len,=
 const char *type, unsigned cha
>  	char hdr[32];
>  	int hdrlen;
> =20
> -	/* Normally if we have it in the pack then we do not bother writing
> -	 * it out into .git/objects/??/?{38} file.
> -	 */
>  	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
>  	if (returnsha1)
>  		hashcpy(returnsha1, sha1);
> -	if (has_sha1_file(sha1))
> -		return 0;
> +	/* Normally if we have it in the pack then we do not bother writing
> +	 * it out into .git/objects/??/?{38} file. We do, though, if there
> +	 * is no chance that we have an uncorrupted version of the object.
> +	 */
> +	if (has_sha1_file(sha1)) {
> +		if (has_loose_object(sha1) || !has_packed_and_bad(sha1))
> +			return 0;
> +	}
>  	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
>  }
> =20
--=20
-R. Tyler Ballance
Slide, Inc.

--=-/NM5M7bDPv20DOP4yrEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklj4JAACgkQFCbH3D9R4W96mgCeJ5Y9mCh1ln0xmHF+/0r5I4BF
bI8Ani+9BlSl81jqFmigtMYIv7PjiVUz
=/h4A
-----END PGP SIGNATURE-----

--=-/NM5M7bDPv20DOP4yrEI--
