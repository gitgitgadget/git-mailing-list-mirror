Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22E1A5B90
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023668; cv=none; b=X3l+jXp9ravzGWJ8vOWwm5cULs24DTfOGqmeEiDBci5/i81rhpSYJIjyMFlimvhwmh4fMiyb9KtowlGMt/J4HdoIEmWhmjxM14y0x6PuHTCZUelKYKf2NRSJrVcgD3oJHczSpM7I9tvkZYje1mMP/yJ2V+2gCR2Imt95IqSXN1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023668; c=relaxed/simple;
	bh=fWuxSfOyiPAQ5EAuPnCFZYKhPSRZsGCOYgJgbo8K7b0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p4tiI/w1Y7lUhdgLHhyjQEBbOrlvu35xzZLM+ICAMUL+E9KcatqzPflpNlR/5t0Ix5+voOrExTOZaADH2Dbc2Qdytqwjp/9L9hhffgWDsEAWgVHKoZZIlQeuhPKL+CSXU6jT6AjVfLEDzH2+6Gb0370U8Z3c3hju4TTyePedIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz18t1749023636t8ba0eb60
X-QQ-Originating-IP: pjLb7tYxlH2LLeYjH5e+G2BQSbnTZ0iZp367XBdgejM=
Received: from smtpclient.apple ( [218.94.142.86])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Jun 2025 15:53:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13653396715585505073
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
In-Reply-To: <aD_6T0lUOsqrb5sH@pks.im>
Date: Wed, 4 Jun 2025 15:53:44 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F36BE5E5-6754-4E31-9988-B4D0B3078B29@smail.nju.edu.cn>
References: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
 <aD_6T0lUOsqrb5sH@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M7dxyDFn9MPmjMd0oMYqlJHiRX+IwhCKUAGUa5XG9jkQxzla1fdA7Xb+
	hVULiGBTkruvLqP+4WIuOm7owgB9OisbYEIi9hstmn99Yn6Mv6ZZnWlolTtEDqd0H1k9cF2
	Eutz+/imnKn3zE6riBO3VwVYAoctD37LvQd+00QxM6wAig7erNHZqw7IvLccnqMJWN9I/8I
	sciGr8hnZQiRECpgOHZh0FG0hJZ+d7p7Hp2o30ct6Ijv7UWMX9U4NzMBIwBCXNp6wx3sS0C
	ul9bAJzNtI/xdgbDU8FfRldO3LZYV16k/iUlaTLFrx+QhdXsjg3J4gZICFEZr44M9qV1eb/
	BZffBnood+jxY2Qa6Pk+kiQDeEeIab0Mhm2rsgxa+5N8HayhBa95SIexAEzNNe85rhf6Fkp
	daCahfpKBXrqNaeeRgO71y09AVmY0kzqLKgX+YBv6Tl3/ElUyNzMBMIfRhZ6Bhfh3gUl7g5
	UNk5tnpcKzalJYQoC1rQ6iYS92Hk1UceNXtsiRGLAIMBWAfNWEdsrDCHVmxDhCRxBzcWgTZ
	n0Ur0RC57SHK2rqqhRfu9LUlD4hLATXLh+A4msqXZluwTEJxN9XzwS4V2Qxh5SeNX3FXgmk
	MQcVfKkv1oSKDJX9UIhatTTNM9kvyiLOntzv0wPfahvaH9F47bVT0kVopd5WGIDXjc4Tgyc
	Z4pZc6ExgCpLQzkGoafLqarSJafJsV+0HEx2YaTMI6XUTEP9W36Arr6a/wGchNysoTH+Nu5
	44ftdl3I/YC+AIBDgZLVYHW8dTn6yainOb2VT4zby4dMBWeT8jhC4ycj+z1EGcUORC0G3fS
	1CsD26iVXndsQeuGCwMmKfXp0DChYmDOfSuH9pF+kkRt0yHUiaIwEM6iwGS2P5dPeTULwKY
	YDnSLHryOCBzWWh1vVLH0QGQMeEzUvUAtwyWKOYNF9/OpT4bimnTupVmy+oADrhUy3YGK5m
	lfXRVGJjJhcBSY5cQWzEBXeTbQLjuvlN1kpyGdM6XSTLPlp7HelBzJNdLmaO4oLyONTQPaz
	HeuqqhAQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B46=E6=9C=884=E6=97=A5 15:48=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 04, 2025 at 03:08:56AM +0000, Lidong Yan via GitGitGadget =
wrote:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>=20
>> In revision.c:prepare_show_merge(), we allocated an array in prune
>> but forget to free it. Since parse_pathspec is not responsible to
>> free prune, we should add `free(prune)` in the end of =
prepare_show_merge().
>=20
> That is a rather obvious memory leak indeed. Do you know why we never
> detected the leak in our CI? Is this code path not exercised at all by
> our tests?
>=20
> Patrick
>=20

I don=E2=80=99t know why CI test doesn=E2=80=99t cover this leak, but I =
am happy to add
a prereq test for this case.

p.s. I also like to ask that it there anyway to run test locally? How do =
you
developers normally run test without open an pull request.

Thanks,
Lidong

