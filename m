From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v2 2/2] t: Add test for cloning from ref namespace
Date: Fri, 5 Jun 2015 18:12:25 +0200
Message-ID: <20150605161225.GA23368@leeloo.kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
 <1433513531-13423-1-git-send-email-johannes@kyriasis.com>
 <1433513531-13423-3-git-send-email-johannes@kyriasis.com>
 <xmqqk2vitbjh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 18:12:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0uET-0002bM-LJ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222AbbFEQM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:12:29 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:52834 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbbFEQM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 12:12:28 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 73a2a7b5;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=mRy7LLsyUtM162V8463Bb4jVzfA=; b=UGTewN
	FT6YpkWDB5lBau9yram8wcNOkGhCXE0tfWpo9EA051lrPORSGS/AjSF6AYq1FAmS
	Y4/J7somrjHqETrWftAr5Ccp7cFzo7qB9E6k5r8fmtHFNf34idis2c0VCbxk4cyw
	hCQpdvDXXzMl88F1rPuNUvSYKBmUUlUTW0dR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=DEn15isM+NUUPhy+W9V8n5Fm+YjKvhqu
	yePtYxlD+L9mECf/16/F07p3MwHTeAWM4GTrFapDhcdziYA/RXEgfW0j54BYESC8
	egj7LzqiYJ1cNGPn86F4pH0HKjJslSfy8p0k0TeRYtH/ngsbejcZcYdoMvxhgE+/
	kYQuObmawGY=
Received: from leeloo.kyriasis.com (m77-218-250-201.cust.tele2.se [77.218.250.201]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 08f83a08;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 16:12:26 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqk2vitbjh.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270846>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/06, Junio C Hamano wrote:
>Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:
>>  +++++++++++++++++++++++++++++++++
>
>It seems that 5509 already has a few tests for namespaced transfer
>in both directions.  Perhaps this new test would fit there better?
>

Missed that, will move it there.

>Also I think it probably is better to have these as a single patch.
>

As you wish.

>> +		git add file &&
>> +		git commit -m "commit one" &&
>> +		git push ../bare master &&
>
>You want to make sure not just "push" does not complain, but that it
>left ../bare with the right result, i.e. something along the lines
>of
>
>		git -C ../bare symbolic-ref HEAD >actual &&
>		echo refs/heads/master >expect &&
>                test_cmp expect actual &&
>
>		git -C ../bare rev-parse HEAD >actual &&
>                git rev-parse HEAD >expect &&
>                test_cmp expect actual &&
>
>

Hmm, it seems that git-rev-parse doesn't handle GIT_NAMESPACE yet, so=20
can't check it for the namespaced push right now. Not sure if I can fix=20
that myself though.

>> +	) &&
>> +	GIT_NAMESPACE=3Dnew_namespace git clone bare clone &&
>> +	(
>> +		cd clone &&
>> +		git show
>
>Likewise on checking the result of the clone; not just it has HEAD
>to cause "show" to succeed, you would want it shows the right commit
>(i.e. not "one", but "two").  There may be other things you may want
>to check, too.
>

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVccpmAAoJEJAcHDIOsNRdcEUgAL/bT2zn5GfFjQjf/bl8+yGz
JdJ5Etp7p9VNDx5fL/s8e+KoTz0b96lXuJAJFLzXrauF+KxgoWtknRbBxIdqV+fw
kH7AVi/zNiwwGPKrOCsYHywBrHF4eywXX9duCvzZrBfPu9HjOLDE56Hb+nguyzky
CesB+amzJXu78WrP3owOo6HDfd+bdArrlkxmbwlw11kz9L3HTA5UeeQ+gncV37BC
8SIov0zuytgGBosJDVFtVzVCXuqssZiuPfS7CoK5k67QSRjhhv2Fw+ijyviGRAec
7A3IbvHmeOvfMHbuWuSnlx0vxNRv5lDkoGuEuLqEUDxi935tBy1d4EuM2DARoM3M
pw4NV17idex3aQB4spavWuX9tIzrgzqCy7vq5o5hsBzebxAG54eEjSQVY9GGwd7m
149/Hg9Q2OaDXKDz7LqGT+V8LxB18i1k4kNT2gnDMXWRQ5Yo0sh4NRqxVcABTjVm
wo//VRmJRTjet6PuSy3OvW0/ThELqOapXBTZcnR/PFIJQIg/DAfenZYA8mKRGlnl
YT71ucGgp9ATmgsUR6q4lJmpOLql6ULVk9zgiFZ1hYXtNMEk28LR3wYgld46UT6k
+zzOGZzikrincfNr4qj9hYyQ9CatRoBTMivEuOAwYcV5MMnGYBYJ/SUJ8g3DYh0V
QJQcSoEQ5vre6KEbhr2y+TMayxwRKqYsbmjL0iOqZyuFfdFs1tRZNJPy83I4wFX0
kzO5gj/yWGfPAwyurKCSx/4XsJTCY7kYFGK45gWUzrmGxUHynzorT4nZAuJMRvbj
8BEXsEqve1Z88HTEfOoOOTUjpCv+WS/T3l0ANxvXR2hOrUG5g73s3MGZUkWrQuM+
ZGHZjhACp11FpE3OM1iQIJp/oYI0egTgGm5/JWuP1VjdqllKGxOeIzb6E28iSirz
vJUx6Nn3YxXMsT9FN9Qr6zUiHTEj4oF9mCNjFHFHLMD97vgkLbvhZ+8LAtbWKlUX
Dh3Pb6ySz1KoQzs4YKEqDHS4dG94zQKMDDi190MFLOrW6miMWaAw/RHa5y/1KvZy
Oscx6nU63wfF39GTgpite1ogcZH1B56wgibbjOFvfnFCuiO7sXknQr3pjV8sSjRQ
zNATVJCjVLatMs3W2kj6LROVp3Z/qDWkc92ZMoMGj6oQ8AsTUv+xalEv8Bpdri3e
F0bNOptDeqA9iVAwqGAHJcHB+OvdrhH9uMF3tfucPH4X19CDkvvdg91lofWo195W
PCGLofX33CbPRXNLV2Ks+a+LX3I8sdXAgYunN5Naizu5NZKA0jlscefE2WVYU0DO
Le1kEnm9WVtRXheWsf/RhiqMavssZ/zVUlUq/44AKQuhWqi2R/mAQCz6vOF3UvY=
=o0ZZ
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
