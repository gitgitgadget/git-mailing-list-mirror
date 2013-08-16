From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] lookup_object: split up displacement penalty for hash
 collisions
Date: Fri, 16 Aug 2013 11:41:07 +0200
Message-ID: <520DF3B3.3050900@googlemail.com>
References: <1376595306-6335-1-git-send-email-stefanbeller@googlemail.com> <87haeqdop3.fsf@linux-k42r.v.cablecom.net> <8761v6dm0r.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6158060FDC53289F9DE48818"
Cc: git@vger.kernel.org, peff@peff.net
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 16 11:41:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAGXF-0006Sv-8h
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 11:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab3HPJlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 05:41:24 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:65039 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab3HPJlT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 05:41:19 -0400
Received: by mail-ea0-f169.google.com with SMTP id z7so900159eaf.28
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=Xj7xmMLGw38jyhRTbBTMTzcGKQEGmH+qtqTLB5hvo8s=;
        b=HcTpwRO7QARYUa/4DD6CqUi6ifyAzE8UVVrlCFqqfabF5lAnwgU7ksfMBRNQAR0lFR
         l5VO2lAbeTk1SFzniW/SO6+SuFM/Zg8tWLcUxfocLwPpJAEIIySPsact10LnX5gh30Pn
         qr5mErh5HRDl1QNUcLszobl/OVBBirEm8p8d7Bfkle/UKb2gQA1/JJFcQlImHJb8HM5v
         1mCzUTBsjdA0Lee5Zx/L9KOa5jMjs1AGH1mY4p0A8o4vY7KywPBlXQMdm0ih4Jdv5la3
         c0KgpxlFo2GS6A/JcTedhBUUhwrm69nM8SXFvrY68xT4hDXUTkhuIrQrRpE5rQ986EZF
         keuA==
X-Received: by 10.15.24.129 with SMTP id j1mr1077921eeu.17.1376646078002;
        Fri, 16 Aug 2013 02:41:18 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k3sm1317128een.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 02:41:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <8761v6dm0r.fsf@linux-k42r.v.cablecom.net>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232406>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6158060FDC53289F9DE48818
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/16/2013 11:26 AM, Thomas Rast wrote:
> Thomas Rast <trast@inf.ethz.ch> writes:
>=20
>> Stefan Beller <stefanbeller@googlemail.com> writes:
>>
>>> However please do check if this patch brings the promised performance=

>>> on your own, as you're likely using different hardware and another
>>> software setup. Feel free to share your performance differences.
>>
>> I get this on an i7-M620 laptop from t/perf/p0001-rev-list.sh:
>>
>>   Test                               HEAD                next         =
          =20
>>   --------------------------------------------------------------------=
-----------
>>   0001.1: rev-list --all             6.29(6.03+0.22)     6.33(6.06+0.2=
4) +0.6%  =20
>>   0001.2: rev-list --all --objects   53.22(52.48+0.54)   54.90(54.15+0=
=2E55) +3.2%*
>>   --------------------------------------------------------------------=
-----------
>>   Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001
> [...]
>> I trust the laptop numbers less because it has far more thermal (and
>> thus throttling) issues, but the runs do show a significant difference=
,
>> though less than you claimed.
>=20
> Well, as I feared... another run on the same laptop:
>=20
> Test                               HEAD                next            =
                               =20
> -----------------------------------------------------------------------=
-------
> 0001.1: rev-list --all             6.41(6.14+0.24)     6.36(6.10+0.23) =
-0.9%*=20
> 0001.2: rev-list --all --objects   54.60(53.84+0.55)   54.23(53.50+0.53=
) -0.7%
> -----------------------------------------------------------------------=
-------
> Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001
>=20

I did some more tests as well, and I seem to have just been lucky with
the results initially posted. Now I got a negative impact as well on one
test, so that patch is not worth for includsion.

Thanks,
Stefan


--------------enig6158060FDC53289F9DE48818
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSDfO7AAoJEJQCPTzLflhqehcP/A8S21uWxgbWhzAI0R8E5t3k
FZKVCi7vA0STjWCSaQC+h1WbhvTAWunzUNzl8cxO/GyI//siPPbGe4hpPS0NI0Q9
q+CSOvTgTgRA/I4fWkhQpvA2mviZms+GfPbVDh1uxjb1zJ8UgSmUuyl3uGUdbKiU
8BR8vQ1Vqfm3xv0DELNmU4jZzWJajnzLzRNNqa2iIjbhaJYvHwYn8y8OwW+p/Bbb
az4wiBzMsDjfGcmg2gLc00i3o394g5VRDjyrdnfaCd+3iIzdzRK2zbL5YTnv5xvL
wYoJWMuw3VEECQfYv0UUXIjYJX/awJlaW612aKE3imdPjRBz7YlMhItp/ziIdu4a
qtf5FfCkh4a7xXvxLkiTGGiLXKA2J1hcUIQLYGA2Le60xuqyT+Y/CeHlSGbIj1rq
rrzPqFkhl5/upkBICJGkrOCOko/lrbroMGfu/bdrbUXL2zUxtlhF6C2EYgpamYC3
8cgMOvs84brnFN8EOf0+V0F5KZnJrQLPw2CjUOnqu6cIKJbgaIMwu/PX5Vr2PfxO
rvEP1bL3WjlTP/iZ5stBCp56KH2jff6q+4+LwY43bWRUJfX9W4jliDyJnccmOWsr
hKjJ0w2TZc3WeJRl+2yS3mU6cPPRt/JSWPdQo3u9e/DJD8D5zo5W8ppU8ReJWNLn
pXtLNYrTaRQFpp0E36xm
=G4S+
-----END PGP SIGNATURE-----

--------------enig6158060FDC53289F9DE48818--
