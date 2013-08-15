From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] create_delta_index: simplify condition always evaluating
 to true
Date: Fri, 16 Aug 2013 00:04:25 +0200
Message-ID: <520D5069.5090905@googlemail.com>
References: <1376595460-6546-1-git-send-email-stefanbeller@googlemail.com> <7vzjsipr3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4D3EACEB667B4188F98D5C87"
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 00:04:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA5ea-00063P-28
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 00:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab3HOWEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 18:04:20 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:63377 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab3HOWET (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 18:04:19 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so625582eek.30
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 15:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=Zrh9Nq1xPji9OCtC6R0qI+hS5GDR/1IuyQx4/x/dncI=;
        b=WzJkitCc3JsdYgaHE16a9r/S6SG2weGpzPUpaMar4QHVE42+9i4uNAW31oMOAYcqyg
         AzCjSfolx2cD1e3SqakKv+d674eGTaMtq3hKdDrgu6ylIPWUfu4Z7zcy/rPv4yCJu+Tr
         on/VIw215V4lgj0ZarjRtNo80P5pDEGr9FMe3YpxRyecEzGs5ybVIdy2YdqTfP/1dRIe
         4B5ggoBYMhahZlQhseZDvzr1XPdMtW2Q4LKAILGfRHnh3UTmBe/XmB0DCceTGAH8oz/M
         NAX6uhQzmR32QTdk6r0GyiYVOfIKF8ww/riw15xCYwQ2G4jd3lmRejCpHXU9P9fS++2n
         V4nQ==
X-Received: by 10.14.9.72 with SMTP id 48mr25016488ees.42.1376604257855;
        Thu, 15 Aug 2013 15:04:17 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id z12sm2172913eev.6.2013.08.15.15.04.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 15:04:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <7vzjsipr3s.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232377>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D3EACEB667B4188F98D5C87
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Nicolas,

I am sorry for not including you in the first mail.
Just before Junio included you, there were these 2 mails
http://www.mail-archive.com/git@vger.kernel.org/msg34101.html
http://www.mail-archive.com/git@vger.kernel.org/msg34103.html

Stefan

On 08/15/2013 11:43 PM, Junio C Hamano wrote:
> Forwarding to the area expert...
>=20
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> When checking the previous lines in that function, we can deduct that
>> hsize must always be smaller than (1u<<31), since 506049c7df2c6
>> (fix >4GiB source delta assertion failure), because the entries is
>> capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
>> value of 0x3fffffff, which is smaller than (1u<<31), so i will never
>> be larger than 31.
>>
>> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
>> ---
>>  diff-delta.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/diff-delta.c b/diff-delta.c
>> index 93385e1..54da95b 100644
>> --- a/diff-delta.c
>> +++ b/diff-delta.c
>> @@ -154,8 +154,15 @@ struct delta_index * create_delta_index(const voi=
d *buf, unsigned long bufsize)
>>  		 */
>>  		entries =3D 0xfffffffeU / RABIN_WINDOW;
>>  	}
>> +
>> +	/*
>> +	 * Do not check i < 31 in the loop, because the assignement
>> +	 * previous to the loop makes sure, hsize is definitely
>> +	 * smaller than 1<<31, hence the loop will always stop
>> +	 * before i exceeds 31 resulting in an infinite loop.
>> +	 */
>>  	hsize =3D entries / 4;
>> -	for (i =3D 4; (1u << i) < hsize && i < 31; i++);
>> +	for (i =3D 4; (1u << i) < hsize; i++);
>>  	hsize =3D 1 << i;
>>  	hmask =3D hsize - 1;



--------------enig4D3EACEB667B4188F98D5C87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSDVBpAAoJEJQCPTzLflhq0LwQALPNK18F5d+mmTsrOTycLJ5U
bCrrVvrrohdrgUTSyn7dIliHBzwbbtooLed/+mZDzQEPZC7PKMAqxHDlhj8apX1e
sM6zImCuPzi7L0iiqx5e2Jh9WfDuZw2xnFt+jSPnQchExRiz15DmRiNmYsJZC3sT
J71k0dDbi/Hl/HBHMoLk9Gj20p5FBAvbEOvSMheumhVzoHFcZoHOBqMmEeOhynMN
Q8p7zkVJuIXG5RA8bkEDjpBniMcTroa8UUoCd7tq2F+bnJJZIIo0vdm7rhbnZnCN
oDqEhirDGy6rdIklqP7r7ZT/nTqsRtsWZCZS8piSDFvQZUo4EARdMnjNClel7j7c
n8G5A9nDn6Lfh9zxmrjRxCQsBLUANdudlmcMK6isD+e3PY/b5RZ0PJw0GnrnwoeY
6hZCpqeJiaMmP1Fx4E8Hpzp8+J5J01jKN0WOAddA8TQI6yw8nFMlxKXwXhBPI9aU
suE/f6kV6Sal0bdP16kDR02GCKRp2SBSuU8jRQzCGLR4Dyd++xTFNmBJH0OYSYRx
r98/CQIUWKjm/OnrmX4almxYjdfH6iQNFHQVrJvkWCbMTb3759Ffl+hu7rlkEuok
CyaRzwR1ZxUMMt7QFkAYnQNhGYuDJ751Dmt6tBuQBoQz7TEGik1WwFop6ZhiEXf9
vF8tm7ZF5HegPWlp3sik
=Z2Hl
-----END PGP SIGNATURE-----

--------------enig4D3EACEB667B4188F98D5C87--
