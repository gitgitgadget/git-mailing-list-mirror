Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501D23741
	for <git@vger.kernel.org>; Thu, 15 May 2025 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747305961; cv=none; b=D0UDherNPKZDb2+kL/6YL/xgbmdqCJZZe7ssxToFIcysEJkE9sDl4qHsLa/yccENy0pbejBThJifzG71yLxEB0Drsnubxem/6gBZ2IKup5UOjwbAeef6qMIoVv+MgnNZAlIEX8Etg8Ul96s5Ny3m/DH1GbPISFYdorzhmnS1sK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747305961; c=relaxed/simple;
	bh=Frmw15zZ9NFLySjeTXHAR04wtr6G9t8Wofd3bYERPJY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=vCTpIEqJ7QFE/MuHjvtT+eBQydLnGZ8KbXMiyH/KYkjwxgaF45lunRQkMrMjEQhfAtQOSNnYWNRO6jJ2UuDMTggoSLyYKNOyMzr3zf2Uh+07QDECfOHRjZMwS02dB/YrHfZhzwKCPYp53KzVn9TVI0IoNLpep4oZoHtHNhb4i4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz6t1747305939t9d0c62f6
X-QQ-Originating-IP: /pIfh/+wXy83NVZTTzgII1X3dU8SEHhGmSgomFLsN3k=
Received: from smtpclient.apple ( [202.119.48.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 15 May 2025 18:45:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11537426799582955762
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] sequencer: fix memory leak if
 `todo_list_rearrange_squash()` failed
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <52e0a717-f7f0-401d-b621-f1f6e028e595@gmail.com>
Date: Thu, 15 May 2025 18:45:27 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEC15708-1EBA-45B7-BC79-980858634AE0@smail.nju.edu.cn>
References: <pull.1965.git.git.1747230808770.gitgitgadget@gmail.com>
 <52e0a717-f7f0-401d-b621-f1f6e028e595@gmail.com>
To: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OU1KiBGGGpgtnamfTNtsqJ4GDm4BO3CdjCm3Xx1HSob3PDgbOuUbcQIX
	il642eIetbEOYZ23YyE7TrAtxBkQZdfKyP5RejhALbGtAwgsT6GpCBWz+ti2O36Smeq/cye
	+DEesZP8hCfWkjtowH+UaiggY9QubpQNKVBQ1GystZ8qACI/BPpUfTzhJfehk6KywrCNgqv
	HSTPO2pys0500aO4s41YN5xbFd9BNVyk3dEC4rVL7/OlFVshiT6/oXbZdEY6L0zizQW+wIu
	CYhg95a3DNCpemsQ6uy/+GK+y244vF8eCYnJHJNvfMTftaqFWyR8VBnPqw62+kADUn0MHNR
	RVwZBiDANJD+IfZQu3rRWxxF6tyo9sO4QqxYw3sbWYUL3T5UXMcursujvTqdY1DYe+aAB6V
	X2XiuON83r3BTu+R7Rb8FlHAXUXtwvCpTvyksEPROoeCDguXFp54THhGJivZUAp1iDiTJnZ
	DB2vWZJZ76qtXZp/LFm7+HHXn5t2qqbZ1kkAXXrdoaxdPFjZk/FYRwIG1vM+XfE6nvJD5go
	p4ZPhm/v4ui7Xfa04P8mUvtq/SglxKJrjBPtaTKwJsQ2aGR0a3i30X/7qISLHpb0QUyjJbl
	5ZCZj8gcvShERgYdBGAqsKwh2LOu32kLnn2tvKJIXond4HxZ02uAmZk2NvcRBetNtXjK3De
	o9A/jYk4e5U5eFnEP6nZKlipgsVXVcIAbeTSLOxXp6A2Yb31ncBZBbsyoBnk/fplMIp8LnD
	sgUKaMMUPTJSoUKSEp0eLOkPFujpil49yrR4Ljay3jzPJxiJrZSfYK3tEB3KiWdYnOa+7ab
	f2EeLhUAVcTFuUwxEDuR5b2FGTySwfvpM+y72DwHAAxmpYYcUpH1yrUnHH++CyRAXlSw4Vh
	fjTG6VVNCFSpwkKABMoRlpVNYiWTyXGWLjqPfWY229oSwwkHSblDvGRvpiRBNIU6CN+HMcD
	IL3F9QG3Yw0hN3XGe0MfIsLSSrQIgifzffU0MUHaxNzAr244D9sGuG3Fv0ZPIAQ6zXTwN72
	KB5GUuuw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

2025/5/15 18:08=EF=BC=8CPhillip Wood <phillip.wood123@gmail.com> =
=E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 14/05/2025 14:53, Lidong Yan via GitGitGadget wrote:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>> In sequencer.c:todo_list_rearrange_squash, if it fails, memory
>> allocated in `next`, `tail`, `subjects` and `subject2item` will leak.
>> Jump to cleanup label before return could fix this leak problem.
>=20
> You could mention that you're adding the cleanup label.

Understood. I will pay attention to this in future patches.

> Out of interest how are you finding these leaks?

I am a graduate student at Nanjing University, working in=20
collaboration with Professor [Qingkai =
Shi](https://qingkaishi.github.io/).=20
We are currently developing a tool for statically analyzing
memory leaks in C programs, and I am testing this tool on Git.
To ensure the validity of our testing results, we are submitting
patches to Git and seeking confirmation from you developers.

