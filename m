From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Mon, 24 Nov 2014 11:29:43 +0100
Message-ID: <54730897.3000507@drmicha.warpmail.net>
References: <546F5CC7.8060904@drmicha.warpmail.net> <b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net> <20141121180105.GB26650@peff.net> <5470A4C0.3070501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 11:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsqtx-0007Ul-UR
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 11:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbaKXK3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 05:29:46 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59316 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751033AbaKXK3p (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2014 05:29:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 51A8F20795
	for <git@vger.kernel.org>; Mon, 24 Nov 2014 05:29:45 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 24 Nov 2014 05:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=tle3qA9XbhcovPAOhnnSSz
	EQSfc=; b=cfhd+nxFZo3YtrdWXb74pWrDzNi9hytVufmMIhGxI2jnldJs/MpgmW
	O5AfLpgXtiqmc6RceUcGNenkWzu0joYALK374O1ivM0cuVu+qwMIkKlQF3bKt5AO
	CgJf/LgqC6ubYkvLcbvTObCXnIGARrTY4BwCan0u3phvQjelOnTCs=
X-Sasl-enc: rP/QfewE/VdxU6XdY1BmOAv+EkFhXDOsXJXBCiF/DNEr 1416824985
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 926056800BB;
	Mon, 24 Nov 2014 05:29:44 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <5470A4C0.3070501@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260121>

Torsten B=C3=B6gershausen schrieb am 22.11.2014 um 15:59:
>>> +test_expect_success 'error out when attempting to add ignored ones=
 but add others' '
>>> +	touch a.if &&
>>> +	test_must_fail git add a.?? &&
>>> +	! (git ls-files | grep "\\.ig") &&
>>> +	(git ls-files | grep a.if)
>>> +'
>>
>> I am somewhat allergic to pipes in our test suite, because they can =
mask
>> errors (especially with a negated grep, because we do not know if th=
ey
>> correctly produced any output at all). But I guess this is matching =
the
>> surrounding code, and it is quite unlikely for `ls-files` to fail in=
 any
>> meaningful way here. So I think it's fine.
>>
>> -Peff
>=20
> 2 small comments:
> Why the escaped "\\.ig" and the unescaped "a.if"  ?

Well, the first one is copied straight from another test and the second
one is by me. ;)

I want to test that no files ending in .ig are added, but that one file
a.if is added. Knowing how the test is structured, it is higly unlikely
that other people will add a file where the dot in a.if matches
something other than a dot, but in the case of .ig I wouldn't be so
sure. We could take the extra safety measure and quote "a\\.if" also,
but to me that seems to make the test less readable.

> The other question, this is a more general one, strikes me every time=
 I see
> ! grep
>=20
> Should we avoid it by writing "test_must_fail" instead of "!" ?
> (The current code base has a mixture of both)
>=20
> The following came into my mind when working on another grepy thing,
> and it may be unnecessary clumsy:
>=20
> test_expect_success 'error out when attempting to add ignored ones bu=
t add others' '
> 	touch a.if &&
> 	test_must_fail git add a.?? &&
> 	git ls-files >files.txt &&
> 	test_must_fail grep a.ig files.txt >/dev/null &&
> 	grep a.if files.txt >/dev/null &&
> 	rm files.txt
> '
>=20
> (It feels as if there should be a "grepnot" ;-)
>=20

I guess that was clarified in the ongoing discussion.

> The 3rd comment:
> Thanks for taking this up!

Just scratching my own itches mostly these days :)

Michael
