From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v3] receive-pack: Create a HEAD ref for ref namespace
Date: Fri, 5 Jun 2015 19:27:36 +0200
Message-ID: <20150605172736.GA30419@leeloo.kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
 <1433523731-25172-1-git-send-email-johannes@kyriasis.com>
 <xmqqh9qmrs2j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 19:27:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0vPE-0004uc-Ob
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 19:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbbFER1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 13:27:40 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:53066 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927AbbFER1j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 13:27:39 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 88b745f6;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=CcmV37XhQdr1wybsRB4IibGWwXU=; b=bfZ7IE
	Ve8GQw9dW+uu07IqrcGvgxT6iCyx2L75JXHKxdxdg25/8rs1FWW87TmwcGqjcSqk
	SJN6E0iAtsfrNJhv1rCTgyoFBywGKKhnKivC/cGa0KcP89okL4AYilwLIoYheTog
	XCfPPEKyAJRaoMqZ4qiAfaE1HPrg+DVH8CCic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=mj3kTCOoEyyhYE74DJ+n5IhoDPE60kTK
	losetQmuJj7pogAyTP1ww18UnnoLaa5394ucwUmC6yo01IZ7yFQsqZB93sryqT8q
	nltHPQrqLVDI/oMnuMC+HfcuO8IPk6opLIo1oDT4Vs2VplcwkL+yUHdgxjYMt+DV
	sA4awLPa+LA=
Received: from leeloo.kyriasis.com (m77-218-250-201.cust.tele2.se [77.218.250.201]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 57564e24;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 17:27:37 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqh9qmrs2j.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270864>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/06, Junio C Hamano wrote:
>Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:
>
>> +
>> +		echo "ref: refs/namespaces/new_namespace/refs/heads/master" >expect &&
>> +		test_cmp expect ../bare/refs/namespaces/new_namespace/HEAD  &&
>
>Use "symbolic-ref refs/namespaces/new_namespace/HEAD"; HEAD is not
>required to be expressed as a textual symref.
>

Gotcha.

>> +
>> +		(
>> +			printf "%s commit\t%s\n" $(git rev-parse master^) \
>> +			                         refs/heads/master &&
>> +			printf "%s commit\t%s\n" $(git rev-parse master) \
>> +			                         refs/namespaces/new_namespace/HEAD &&
>> +			printf "%s commit\t%s\n" $(git rev-parse master) \
>> +			                         refs/namespaces/new_namespace/refs/heads/ma=
ster
>> +		) >expect &&
>
>Use of 'printf' is clever and I like it.  Have you considered
>letting it do the iteration as well?  I.e.
>
>	printf "%s commit\t%s\n" \
>        	one two \
>                three four \
>                five six \
>	>expect &&
>
>might be easier to read.
>

Didn't think about that actually. Will do.

>> +		git -C ../bare for-each-ref refs/ >actual &&
>> +		test_cmp expect actual
>> +	) &&
>> +	GIT_NAMESPACE=3Dnew_namespace git clone bare clone &&
>> +	(
>> +		cd clone &&
>> +		git show
>
>We can accept any random commit at HEAD as long as it exists at this
>point?  Don't we need to make sure that a ref whose tip is still "one"
>is not propagated to this new clone?
>

Oh crap, I just remembered that I forgot to address that part, sorry.

>> +	)
>> +'
>> +
>> +
>>  test_done

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVcdwFAAoJEJAcHDIOsNRdYI4f/3lGdSp9kwed5mphyx/7d2Cs
1OkL3uCOFRdMzcO8ly7TMDc615M3K5K++yqfNdxoJP7gxaWeEekZPQnUC4TO/KjB
9yc7ifzMxkD0+6FNYfFDm1yt4la3JacK85rLZC8j1DtYcS/RXL8+gNkb/tlgkXyu
AIMO/xowafz98CpjVgLYQg1v9Gd+c/xPrTQllmXGl9tgmusJqY+EDia6VqWCjdZL
mXWMyDivs/CMvNpMSum9GK8M5c/p3n4ZYafPlbho+FyFnKLaI+9xDyg/G///Q9vE
TK2+Mt9nC58RfUgjFDPrdCtsclZED5SUWOOqMHXxVFZNbULvJ+xVOKfogxqqBbbO
Rq41+boAHFx5Fa+sC25yAkhvePh+vLqK7XoO0c1O+SMsKwmVQfLImTJsVM4/tR4G
92pH9NWcuHL+J4HgtWDE7d3KLwOeKqOBpNEOzLh/k7u6mvDP9Jmz3ZwbWKdaV2+F
hzrVJG0EY7XK+fnvk4rJteSS8p6KPsGR2mPY5FpqpQJ6c8dpb/+FeCKI24pA++IW
6TX2KExJ2PbtjTvNrQEMA1zJ0Ep49yiSmQlI7orxI7ddhx+RNcv/08GW1HZXp41L
A4GPKbv97iKxHmYcqmx06xj72v88BWpGnYKXJ6uQRXWEdEnTT+a144Mf//OkGH9r
PyuIaaiLZhkm5qY75MwT6JJVAQS6lSATzplb0YY2wBJzmIKD+4oBPGOTVajdFIUp
ODPcptj2zD1Rx0GWylK6a/R3EhTqTHXtWF5fgUoLEbdPzrlqaNekyOeav6naokQy
W6iW00IH1Atd13VjVmjh5KI2g+171OatqHKTThE8K7DhxxLln/O1X7ZQJjCTD788
z0GvYNxNs+/cisFg1JS8rRBzy67gsLkNG0gUE45oTGlk9PSj8ydK1W1CWBgcr/qo
WgfTWV2SzqlX0W07wTkP0NIi7eEmtidU+f/sAO6dGxIn/OZV9ochnnHKIuDvPGii
o2mPhq3stG1kD9sBU2lEIFD1TEGFD2xSKKm2XHN7wGfyi51ThN+s3WShYzEQL97m
g0fFLXQsyF9gf/r9VrNvTvQbfjMUGZ78LTPQlALndJDXmfnQZJ766k4guX+CAo4Q
Qrtu9Q846UpI1e4aJ5GJcriOqCM5NiNvbc/xFsuFM7Nle/JuBl5pJUB7dqVu4f2b
TbahSsZxJYqHNqPg8m8AUHbxNhgoCvlwEDVCYJCPjrPEFc6UR7Ro33vgy9+WnnUi
LxXonvkwUlcYtHw3y7lwrprmRKS/2DjBhUfCEBkH3V7p0w33dQMQGepXWydgDBBW
jhDAPOlLCBOMhShN2P/gON+lGV1kXpqcV+CSLan0kousyy4QGKifJIoHBpfjdQ0=
=c/qf
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
