From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v2 2/2] t: Add test for cloning from ref namespace
Date: Fri, 5 Jun 2015 18:31:35 +0200
Message-ID: <20150605163135.GA26503@leeloo.kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
 <1433513531-13423-1-git-send-email-johannes@kyriasis.com>
 <1433513531-13423-3-git-send-email-johannes@kyriasis.com>
 <xmqqk2vitbjh.fsf@gitster.dls.corp.google.com>
 <20150605161225.GA23368@leeloo.kyriasis.com>
 <xmqq7frit9ad.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 18:31:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0uX0-0000HJ-BP
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbbFEQbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:31:37 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:52890 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789AbbFEQbg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 12:31:36 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id eabd7c90;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=RwCabrcDhEbzO/9OUb2QN9MzdXo=; b=oGLFRV
	d0tOYXpo4enU+hkKP+8AqieWaiGHdKRswsGRnRLmp2zrvzQ9oJSiT9eRNsZHoAv6
	fV/rpApcYmIaT1tm9AOWtNgn/Q/yK9G/39GPOdM4Z4hJySZyEnPl52BsFYuHT+vk
	Zs5hICFZhTmy2Y6GT8ibhvJBQvueNBxSIL5lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=Z9NQDY5BpbIslAAHSxxKI/t4oxoEf5UG
	cgehTyd+yzeCy0zJb0zMNjYteGUQjkQ1HRo7QHsInLw54oFOHQYSzX74iaN/QojA
	wVKfPX7wSAKteHNyIG4qoVFRRPuC8uhk7yBrf/sy4f8SJ0/EnICwI7vvhA/0bSpA
	xtIXBCIL84Y=
Received: from leeloo.kyriasis.com (m77-218-250-201.cust.tele2.se [77.218.250.201]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 4c34ecff;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 16:31:35 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq7frit9ad.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270850>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/06, Junio C Hamano wrote:
>Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:
>
>> Hmm, it seems that git-rev-parse doesn't handle GIT_NAMESPACE yet, so
>> can't check it for the namespaced push right now. Not sure if I can
>> fix that myself though.
>
>I do not see a need for rev-parse to pay attention to GIT_NAMESPACE
>at all, though.
>

The ref namespace has its own HEAD, so I'd expect

  GIT_NAMESPACE=3Dfoo git rev-parse HEAD

to act sensibly

>The destination that accepts the push with the enviornment variable,
>i.e. your ../bare repository after this:
>
>+		git commit -m "commit two"
>+		GIT_NAMESPACE=3Dnew_namespace git push ../bare master
>
>must be saving the result somewhere in ../bare/, and that is what
>you want to check (and also no refs are affected outside that
>hierarchy).
>
>So perhaps along the lines of
>
>        echo $(git rev-parse master) commit \
>        	refs/namespaces/new_namespace/refs/heads/master >expect &&
>	git -C ../bare for-each-ref refs/namespaces/ >actual &&
>	test_cmp expect actual
>
>or something?  You would want to also check that other refs are not
>molested, so
>
>	(
>        	echo $(git rev-parse master^) commit \
>                	refs/heads/master &&
>	        echo $(git rev-parse master) commit \
>	        	refs/namespaces/new_namespace/refs/heads/master
>	) >expect &&
>	git -C ../bare for-each-ref >actual &&
>	test_cmp expect actual
>
>might be a more appropriate test.

Sounds okay.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVcc7kAAoJEJAcHDIOsNRdvVsf/2fBPuDWN+Yvcwt3n3kyoZxA
vKyNKmcGZvCovjEj9Kplq1z6/WTK6gbdoQCs+x6ulr//nUiIDecGY3C6GbXUle5o
TntM+xo5+MZMO83gdSY8/0bjSKU1+k6I+LjnfqgtyzVaAx/M8RLdCxWAWCrkQbnu
GB039g8uO5urmr/icibomvewNROG+i+/UbBLxrM5+FbZlLrJ1qJLEsTKNHeUOS7G
l1qYp6IeN/rgLDqUP7Rv63HsWYufSXwVFZBDnqnOxlT+zeN4mfA34r21hQ4DieFY
rSB6eiarukr7vMjqQHJBe93aA9kLADsEc2An7jtcwheXiKB7s2spz3LQci9AzWtU
JIE8/BAok0CGcI3dAL9UmZxXSOJ7pcjehZFC7zk5Orw33P2yEoQ5KZLgp3y2ALWX
sevRF3gDW7/ydH1gqs1p0yRGuI8zajjQY/l4Sf8XnAb3JoqCYRx0/7CKE/7nmims
q4cxJDgQpSA8l54hOO7qEp1baLQRJ7Dk4mrKxduhmrwOcMjg1gFznL5YOVvacpEs
b+HXU/OXypRzgejvX4n7zUS+Z5jsfOTZ/HUQYBMDpeOMMzQdLYfsraK+nVokwg3X
PhRGqQi6OC3MbmAwMoIWymhuaMF0QmUrdoeL2BHtSU97fQZqwzgXAAVkAqM4AFMK
XeRGu6fmf7p9y4dgN7JR+yvPkWHnBIZJSzkE4H3aJI0Nf0z6om9aXDpE9Y7lorZ9
9xc7ksQV3euF3pV3ArF5jXd7Sz4n6nSzrxv1oZ1kKBFzm+D/WJqhrDeolxHXcNZX
GxKJxgDXnW56ys0x96XzpGuBzzwKhRADFCnQnYCtnXFhoQexcse2n4h21bc4Mf+E
MyToieibxrh/5ec9tEBDBd0DtWxJuW3C88dejpkYJ2Rcdgy0OFc5djvWfsgO8ZKU
4SHOxmZRsZoLdIB1ZLoIVx0fChWNA4P01V95SgOADU2lWgLlvIMVrAUkAR0g0JTx
XVBoUy8iSMKItdV5bEaeEqkS32LTXEn7PBDCleEzoY/RGQYe5WPyKlnMFcx4E1Qw
+WfRntMED/2VHKJQyAkvCcTr+AE+Sxo2ssk9fH0wOz2m6MH6vOgn80GkL1dQfb8Z
bGHNqk2Zl0Z4/OmaZWHNBYPbR2X/EBnupi4Ph8VQcX45BAQ2G3r/5+6x7q/Lmi38
sgo6VkQ0euPHO2C5yUXBY8Lg+WMj+TLnSulkkLovfG7WzcUfR80b7yQSUCNj+N/K
Z5NbZcoph4VcGKVu46A3MBxC2MKlAVEGbmRcBPTJ37FoHOil4vZhqLFiV7T1R5U6
x9DxHC1UFxsAwjgs38bS72bVxrBNZS8Q3j7lYPYMbl+qs28ibxBmFH1k2uPRAoE=
=2zIv
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
