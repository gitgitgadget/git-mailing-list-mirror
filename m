From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v4] receive-pack: Create a HEAD ref for ref namespace
Date: Mon, 15 Jun 2015 22:59:56 +0200
Message-ID: <20150615205956.GA15571@leeloo.kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
 <1433526142-2413-1-git-send-email-johannes@kyriasis.com>
 <xmqqlhfk7l6l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 23:00:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4bUE-0005Mt-Oj
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 23:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbbFOVAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 17:00:03 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:60964 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbbFOVAB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 17:00:01 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id e87b2176;
	for <git@vger.kernel.org>;
	Mon, 15 Jun 2015 20:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=l2bJem6rWY4WxAFR+Hy7wgX26FQ=; b=MDMvsn
	jDbJefpdrm5EfVjMfeWJkEy4BOX0x9We1QMBHA3/QUc6UmJX4tfelEBiw9RsCcH0
	Fp8kgJhovwnn5Cit6vo4xtgggP57/ZGlbwSS9jkfAh8Xfa3Xr2pG18PTXsta993j
	LIh2RSKxe6TuBHDDtyY1CAJGdjM6ulbZx4LyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=mk2mEFiUl3oPSmimPenQ43gsBUopVfVr
	RMF686RbGrWMOOOAnEWf53texGBej05Y2Dizeobsa+PlhqkyiS9JUUVNsXjVaNNS
	F6QCi5wX2YadKGIe8USNM3uk3qQYRN7QXt7WqpoOjt6tf4CFhLV56XlWPrfe3kZ+
	LHc21y3bL6U=
Received: from leeloo.kyriasis.com (h45n5-tb-a13.ias.bredband.telia.com [81.234.145.45]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id a29794c2;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Mon, 15 Jun 2015 20:59:59 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqlhfk7l6l.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271729>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15/06, Junio C Hamano wrote:
>Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:
>>  	else {
>> +		namespace =3D get_git_namespace();
>> +		if (strcmp(namespace, "refs/namespaces/")) {
>> +			strbuf_addf(&namespaced_head_buf, "%s%s", namespace, "HEAD");
>> +			namespaced_head_path =3D strbuf_detach(&namespaced_head_buf, NULL);
>> +
>> +			create_symref(namespaced_head_path, namespaced_name, NULL);
>
>In a normal environment without any namespace, get_git_namespace()
>will return an empty string, which is not "refs/namespaces/", so we
>create a symref HEAD (that is .git/HEAD) that points at whatever
>name the command is about.  And this is done every time any ref is
>updated, flipping the HEAD to point at whatever was pushed the last,
>isn't it?
>
>Why is this a good change?  I am puzzled...
>

This creates a HEAD symref in the namespace itself, since there's no=20
other place that creates it. It could probably be done better, but I'm=20
not very familiar with the Git codebase.

>> +		}
>> +
>>  		struct strbuf err =3D STRBUF_INIT;
>
>This adds decl-after-stmt.
>
>Going back to the proposed log message...
>
>> Each ref namespace have their own separate branches, tags, and HEAD, so
>> when pushing to a namespace we need to make sure that there exists a
>> HEAD ref for the namespace, otherwise you will not be able to check out
>> the repo after cloning from a namespace
>
>What this paragraph describes is entirely correct, I think.  But I
>do not think receive-pack is the "we" in that paragraph.
>
>When setting up a "namespace" a and b, shouldn't you be doing
>essentially
>
>	r=3Drefs/namespaces/
>	for ns in a b
>        do
>		git symbolic-ref $r$ns/HEAD $r$ns/refs/heads/master
>	done
>
>or something, which is an equivalent to what "git init" does to a
>normal repository?
>

The only way to set up a namespace is by pushing to it.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVfzzJAAoJEJAcHDIOsNRdsMYgAKiYRQ+vZPIE8nZq22RLyMWe
uBlEnzpfb2rWYS+vG3e9RsnAw4vudK88N9sHqXJ31lQpGbZC3ZD8/IqRdh+bAg+B
j/mXksJnBNOEp8fJsAy43DIJbk+PVpLXKWnAI2vQIdcVMn6KEybrDQx6Mv1KmE/U
S5BVnPGRzpnqWm69t8FhgO0O+heiI2p24iFw5eYdB7cPNnfRtGrqTin5eJSYQpCg
SiZZZeSJMDZBJxaVFuEZWbc5abzK7GcxKGQ/re1kS17rWlVJu4HuCBgFCY3K2tiL
m2xg1c8kVIhmPWkHlo+OJDdLdiS/3G8bZOcUjlDSXWc4hqeo/STC2wfA7eajnwkv
F39vD638A5KSy9ZY5s5hIGxhWFIXl4BWoERPtVLmPdy0+jBBu8lC7Mbv3Q4nT9cG
fMuynUMqLQ1ztzOUPN8uC87IQZ/0boGnhBYwJRASu/AN2e7lPZ/1WX0mUpBY06L5
i/4w+mprHSLG/Sx5tqsNKL12h1e2zIa0etXWvIrqHFPr58h8MfUfHmGHFNCTNIXT
mXBDrKG/FgMwd2RaoVKZE/gB8+nAx8M9e4ny063G1X77YXqw1ZwIuj/9mBMT8esW
MJF2QsXkwv/pggeetCXP1UWLYsKwWZ1y6oBxGXUtq1TJYmNQbdpApNLLLW8c9P1L
U+qaT4dLnfBGx9QcfG5jqjcuLBNWCcKGz6+gO6d23YWu5AiLcp0bKPdoExefe7cT
kInf/7084fBdyns+Q0uKnmMqMK3PGzP5iu2TnWImbcQdamOSKhsYK02QOEcePfDh
yD8j9vzOPSWQkwjWV6c5ue7bwdZXzIQ/JcqJyOultPEJrHcxxK1DEAnaDNJScN2L
sJyse6opzrPicJ4vzEvYcel5snrsXXO7zJ9nC/xwPOZM+mTtUI+OcjN2Fcu2tsSu
Mpbh2d9gFZdXbvVVBXhidaTO7pvnHoQMhYXHH+F/8WjSjBfCVqvvVDyfn3GVYU/W
LNr/h6xmDi9V1a8SwVw6IjAKNWYbzgBBY54zxtCIR50tg/SvW6I69eOk6dKkPhsD
z1AcC08bu+0CFH51w1q+8aC8vn8rVlnvLQmA8vFapcJHxCtioOdUENWORIVwKzAV
cGU1IhtlVoQO97EHdfohi9wScEaxscJmSVDQHWSEK88cVRCoY+lYuHxWh8a3i24V
sruVtesKh3HP/BodtaL9eZB3C6F+MOV2c1jmvzZllJqXQofZIocHNq0Q7vyP6/ld
5KZw71M5qX3OD2RmCN7UDxrYvZp+EOKnjZV9RAXWTDRwGDELyXzydx5A6DBSc33/
22LGhPg1y2xheEBObJM71nlr2oHKvMRYkju3KBp/1Cn60fFX6bo4IHqFitFFcog=
=ebTX
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
