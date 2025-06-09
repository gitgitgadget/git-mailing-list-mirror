Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A43A1B6
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438690; cv=none; b=bDSwsGvEksVpDnIuUK1JcRetwlx/Ubg3WtdgdNDWRFrZw2AIYrA9t9rdAgSD88mVXqdB5QrXFm3NfQomgfDr8FInCuE/t7HWkg9esPDkhYudabWEDyvJRnZLU/vE5vDKfvF7wgaOgn0kIY+QF4r6UPvqn2lOryo2aouMkuK+s4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438690; c=relaxed/simple;
	bh=1j7PhefqRLeQf2Txb6ik8k7xD846pUQZ3gIBAk2l9eE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DG2k/o1yKzKaTsXIbJOroYKdIRT3g5vvIFrc56/yKy1R4+gPz6hiBTTHA9IYUHofxs4OUNGc+Bmlnqmdmbbvbo/YxUnPBdvqEBHSsXfleWJn4muG9K8DftKGdCwffvNqfZpbVbYzImje7mHyaEAaHrHZTDAXjbmzz/XtkvAdy+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz8t1749438637t02434f33
X-QQ-Originating-IP: 3d5Rs5cx8JHYjQDC/Mx0TZhw3wlfi7VXd1+DvQ22/Es=
Received: from smtpclient.apple ( [36.152.24.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Jun 2025 11:10:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4394558900823375931
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
In-Reply-To: <xmqqikl83jhl.fsf@gitster.g>
Date: Mon, 9 Jun 2025 11:10:24 +0800
Cc: Patrick Steinhardt <ps@pks.im>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <32D22FB7-F6C4-408B-A3AE-AF780FA16C0E@smail.nju.edu.cn>
References: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
 <aD_6T0lUOsqrb5sH@pks.im> <xmqqmsal7vqx.fsf@gitster.g>
 <90FE268F-2309-49F0-9C3B-DFB207CE6F47@smail.nju.edu.cn>
 <xmqqikl83jhl.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OKKvvo6f47/b9acBJB6rP8xK9W51q5VNvmX3oAiM5zYexr7Q+lK45ERK
	DumqdNY99q5goUEwpAnUDODRav3fCUV9UsbY25Sk92eybyDv8Ghlp/UFVGjZiYkWSI9utCu
	Yi6cnB/ox81Y+YXSaBZnjZOhZx8F+07l6sh9tEX3C1anPTUbirJrsdqgVgN5moj2pZ7bZTr
	mZUSyEimIGJu0hJ/ZzUWaOPpQ8/dayXL5oKOVt3fAgzWy8O66rIO2/ZELpyvTob4vfT8EAA
	8j48lL8qRC74B8VvayGqL/UCC3vYB3VdbbPHJ45Dxy7++v3InvjNjmgNp8/2HjCG64ifiQV
	r9Dq11WEsv3NiAMPdw+a+6zVNj95hcJYEvkhm37W8+wZUd1+gQFdgJ/uYu8RXPdjaDpU5QF
	N08gQzInZmWkAwOE0K52X97MEftUXymMx2amPQYGtA9rqBt3dikr6WCzhaShwKN/JxnV509
	zqDUE9dNXxZFfjlinsbPOlFFmFXTHxnOb70sAv2Bq1b8MPPpuJR1v35wTMeALXeqM7bnAVB
	tBjlIIk1XmIXVVwudnOeT2gLOanAMPshrXbN/uGh73AmSKB++R5jZlMviwlaxStliO3L9Gw
	lmNStaxFxMeEbcc9WOYffcLhi3XQouKfmO4ntGeFKMYaNVh7mozn0qLwezTC6CnN8e/Foh9
	Xxj15ZQrTutTIn4z425CTgcTyeGyMp2LOaGJRo2s6M3J/o27Ur+64bwrsWFPtuZBzvo9+YP
	jMtrfQpPMdUL+VaL5HWlHVSnl6TFTn5btPo2J0x5nwd3RM0RcKRWyAHWLW1YI2+kPqm+LiE
	6D0YzjSBlkdzGqqV30vrl0fVscivmVQyjpb8NSGHjZ5H5AJvH4XT0zTjS5vxCKZBKpGIHTv
	jSsK5djcXpgu+YVd3iO/9tLHOEbjeTLFCocafkad03a6Y/oWseUdxpdKZsbhcSUTHYwKT1P
	m/3Jm+xnkaKE0k+GeW76VLvSV3GAZQJISbPN4izZAJxEnIwxBPqnEkm5pOl2634qeSjM6c5
	4ucoNLvg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B46=E6=9C=887=E6=97=A5 00:47=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> lidongyan <502024330056@smail.nju.edu.cn> writes:
>=20
>> I could add this test case into my patch. Though I don=E2=80=99t =
understand
>>> + git rev-parse HEAD >.git/MERGE_HEAD &&
>=20
> That was not about telling "show --merge" to work on any meaningful
> data and to produce any useful output.  I knew the step to prepare
> for "show --merge" was leaky, so I gave a very minimum that can tickle
> that codepath.  I wasn't of course proud of the direct manipulation
> of the filesystem (as recent "git update-ref MERGE_HEAD HEAD" would
> not even allow us to do this, sheesh, not very convenient).

I understand. `show =E2=80=94merge` means the codepath must go through =
prepare_show_merge()
And `update-index` with index which has stage greater than 0 let
prepare_show_merge() go through loop and add index to prune. Thus
cause a leak.

>=20
> If you came up with a sequence that produces a situation to use the
> "git show --merge" command in a more realistic way, like below, that
> is wonderful.
>=20
>> If HEAD is equal to MERGE_HEAD. Would git show =E2=80=94merge still
>> works as usual? How about something like this
>>=20
>> diff --git a/t/t7007-show.sh b/t/t7007-show.sh
>> index d6cc69e0f2..f693b6e24b 100755
>> --- a/t/t7007-show.sh
>> +++ b/t/t7007-show.sh
>> @@ -167,4 +167,28 @@ test_expect_success 'show --graph is forbidden' =
'
>>   test_must_fail git show --graph HEAD
>> '
>>=20
>> +test_expect_success 'unmerged index' '
>> +       git reset --hard &&
>> +
>> +       git switch -C base &&
>> +       echo "base" > conflicting &&
>> +       git add conflicting &&
>> +       git commit -m "base" &&
>> +
>> +       git branch hello &&
>> +       git branch goodbye &&
>> +
>> +       git switch hello &&
>> +       echo "hello" > conflicting &&
>> +       git commit -am "hello" &&
>> +
>> +       git switch goodbye &&
>> +       echo "goodbye" > conflicting &&
>> +       git commit -am "goodbye" &&
>> +
>> +       git switch hello &&
>> +       test_must_fail git merge goodbye &&
>> +       git show --merge HEAD
>> +'
>> +
>> test_done
>=20

