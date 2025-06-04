Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB271D7E4A
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749032762; cv=none; b=utnOohu5QyHEiw0Y3peU2lCMqXEZgc9U2vXaN7Nrn3hPHggYFRPNYTqxORnRP0u7/l0KUFSsQAbHUvYlTb6ZFouD+ScP5WCXU2pMNiHXAEjbXCR0ia6B9y3EcbZssDaZ5mYPMwHIoYvGSkND7wmQQWJjf7juyrAuXX9DYvTEqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749032762; c=relaxed/simple;
	bh=fD6Duba9bQaD+zr4yfLqGJxAMSkNmSBl3hKvHz27fSQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Tr4sqRh28VWDufnUEQHWDMZb98eHyWmh5L9jOeDAPlDKGg99Hh8xCB9D8s69bFZTGS1/n5QeOL2pXHk6cJFZas+bkB9X3bBOv0K6qWi4D6ygBxwRI8QqGo8qUM8IM0AVuJJEbdCrnTraZwOOgCLvH2q7TGRWmG4AtSUCw/28hKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz19t1749032725t81bcad7f
X-QQ-Originating-IP: 2KICQvLEIsKAYUFp4fA1r5y4+Gqg8XyMBtIZ/8bSObo=
Received: from smtpclient.apple ( [202.119.41.185])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Jun 2025 18:25:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9434384788836237407
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] revision: fix memory leak in prepare_show_merge()
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aD_-io1eppd1Rnq5@pks.im>
Date: Wed, 4 Jun 2025 18:25:13 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9669AE9-7A0B-43C1-A1E7-99B6EAF5F6C1@smail.nju.edu.cn>
References: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
 <aD_6T0lUOsqrb5sH@pks.im>
 <F36BE5E5-6754-4E31-9988-B4D0B3078B29@smail.nju.edu.cn>
 <aD_-io1eppd1Rnq5@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NyuCELaSACDhw0nUZT59UfPpg8wuCdR+LsMUx4ZivBYEDMsJhCqJoKcp
	HDmUQc3qVq/+NwZKv+727ifl7xXZqQHj/0DjIzBHJBTPbHefYuci/vw68oMQ8KKo/8ZZ03E
	HB4Lr5g6xdwfCADLpBAPBltqj2Rnbo+dPRr15ffC937rHkKQt8+FygDC9dXdltDSFp2S2EF
	P7d23Eu1Mxo4PDcTQ9m99DiOzFktNcOSumC+s0KYqdccDwiFgmxgqUwSDuORDOZkFW2ZKvm
	QU6HVb/zIJKsqrH0yNUCfKlQZpA9lUmtJ/OK65UqtHYieSzDnJcjdSd4I97RiotcfJ3lgZF
	7NN4wLloR5+0/M7Irqyn+S5ORpZhVS60E11mvwWnkcW5KlarFRrGq9UlVABhZFHxWI4a/w4
	5Gc67TvdBGSIlPjeCht2nv4KQK4ehQj9E3pUC4k2NMtl2Lg+MnPOmX4Rtb96klwEGIkomsy
	fgmw5wjh1N38mYoCO4n2A4s8uISrD4aRf2PQa1nHsepF1qyMB1hMsb9aJsQZILMG+CFToIf
	EgeIjTtBLtHQxz2anNlFY4JGjJsdK3/QP089O1bGwUNvIId9w2FTBQh/7btMIErwgF5POK2
	Su8o/pbMHfg0kh82ifI6zvj5qo1KxTJqIoPnl6shOa2TpYaTNzNAfnhWA1bWs6neNKa2HZE
	N8LW9LC/MFKE6ZRBepdPZ34snnwPuiiy9O0LwE0pOMZe4u6XA3wCvnAYtoMKCkg2g9kFKNH
	aTtX05dvifmAH9otoegFIzWEpfNKqKf8YnuMIZA3D528cVuc8AKJTfhfQly8iG74OQZJFfo
	bCyyYZpDKRPuPA2U3hS8PTeM/gPI6AxukQrRSiCZ+pu6M15M5i65i5wmVFXHlSlqFIunLnA
	GpKUly3zlBi7dCgI12JUUvBD5qjpJcs+mPeJgYYl6tzOhrqRsq5N2vBOnU/Cos5jcMD0i0D
	QcYJ9+f0NAKo5sdTAk0q4TVUK3hu260Aqfujw3mi3bIMmlaFdf7IOmXwc9bi43gSQW1cFmz
	JIjD1gXg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B46=E6=9C=884=E6=97=A5 16:06=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 04, 2025 at 03:53:44PM +0800, lidongyan wrote:
>> 2025=E5=B9=B46=E6=9C=884=E6=97=A5 15:48=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Wed, Jun 04, 2025 at 03:08:56AM +0000, Lidong Yan via =
GitGitGadget wrote:
>>>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>>>=20
>>>> In revision.c:prepare_show_merge(), we allocated an array in prune
>>>> but forget to free it. Since parse_pathspec is not responsible to
>>>> free prune, we should add `free(prune)` in the end of =
prepare_show_merge().
>>>=20
>>> That is a rather obvious memory leak indeed. Do you know why we =
never
>>> detected the leak in our CI? Is this code path not exercised at all =
by
>>> our tests?
>>>=20
>>> Patrick
>>>=20
>>=20
>> I don=E2=80=99t know why CI test doesn=E2=80=99t cover this leak, but =
I am happy to add
>> a prereq test for this case.
>>=20
>> p.s. I also like to ask that it there anyway to run test locally? How =
do you
>> developers normally run test without open an pull request.
>=20
> Do you mean the test suite in general or leak tests in particular? In
> any case, you can of course run both of these locally. You can do so
> either by using Make:
>=20
>    # Run tests.
>    $ make test
>    # Run tests with the leak checking enabled.
>    $ make test SANITIZE=3Dleak
>=20
> Or with Meson:
>=20
>    # Create the build directory and execute tests.
>    $ meson setup build
>    $ meson test -C build
>=20
>    # Create a second build directory, this time with leak checking
>    # enabled.
>    $ meson setup build-leaks -Db_sanitize=3Dleak
>    $ meson test -C build-leaks
>=20
> Patrick

Got it, thank you
Lidong



