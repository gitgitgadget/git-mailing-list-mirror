Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB479D0
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749916290; cv=none; b=u5htCN5TCgws1MDixbIo04O68+OrPNfFvtEPcTIols2U67ANqp/8VcYs/TlGx3ngANbw9Ubfha2YTbkGNc/0UIf4haBv4urzjRz2AKnmbnvtpyRKMHn5X3/ebmHbrQkGU2YEsJTG+THena3vMhRpT2TD7yK4ce0W4OPj+KtVcAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749916290; c=relaxed/simple;
	bh=eCymgQjGwMWHXnqnf0dzD2gwtN73PSQ7OZtDs5AM5U8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CeCw0x4QpZ5E09XnD37B9y5rg9eYSYd+AzQfUQxZisob+fhXMgY86gDti9kIvngUS7iI4MOJEWIBMJWJItLkweHao4CaP6dSZYOoaWNVirg52gKi8RmryyG4gsdGZ9HgILS217Cv91JG2lmMKk/i3V85toH1l0XProCoq2Xk7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz3t1749916247taee552e6
X-QQ-Originating-IP: pzhA/k04J0X3uQEjqGw8lCvAFfLBk1lpoWTc+Nx/x+o=
Received: from smtpclient.apple ( [202.119.48.98])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 14 Jun 2025 23:50:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12192474679609041551
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] Allocate msg only after fatal checks to avoid leaks
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqcyb672mc.fsf@gitster.g>
Date: Sat, 14 Jun 2025 23:50:35 +0800
Cc: Alex via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Alex <alexguo1023@gmail.com>,
 jinyaoguo <guo846@purdue.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <089E9F89-5B21-4035-B500-8255622DA92A@smail.nju.edu.cn>
References: <pull.1998.git.git.1749843142000.gitgitgadget@gmail.com>
 <3993AF96-E03D-46AB-B18E-8E6C1108EC45@smail.nju.edu.cn>
 <xmqqcyb672mc.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M5Xz9JaOkZqzR9QSz/eZT1jzLQF8QVT+9Sc18ZV3aobMKxows3sHr7Sy
	DEoLd9q0QsszLlBXl7zLAhuK0rPAdIjLl/5V7/Fxj1PF3GAj+lwnuiYxk0gTsvWUbcF3ggw
	wNIxocWyCGtIDdzqCjSU3qRKmGEaksSlKUQBIff8YVigunRJ3cH2Jx3Em4EnLfZ67WH5Q9t
	cNy5+/SfoLJiQFNkbYGEhRq+SWdptbFVa3YBbvkEOc2C9AG7lGSGGE+UgnXg5b57wtwP7CJ
	jjouJNWRRe3CYfhrFs3JxGSEA6UXPdgoasvRqqVZNOzUAh9vp5MMCwTUredZR1AUvtAg31+
	+oNo18cA78Em2pznmA6/WUrDvV33+LP5mOlgUK4T3HEd1c92JSan7Q7H9J3Am5Ke1hPG0fk
	WPy1LvJ4YynoTeLwdH26Mj8mKJxljHf/w4ALC0+juCMrRfeHZlXdYTs5M/wC29fkeIoTJMs
	ZuhZaCNMRuWzItODVh91Nc1fGpwgV6s+ZAf1mcnEhUaHIpISNqhR94rxLMCQSn3e/A8qo01
	8GIl8qrVE8yOZN+eUOCXd3tu8OMDWvE9GTcHsmEbjXNzo31Uu8GwCS64UWT6xRFxP+LKGOD
	PBbzKFKOCbkOIb9WWPDYT6WQsFk1ZRv8SeAPMyNAUzSPxBoPxSgXmXFRAXrbfs5X4e2nniC
	be2tV73K387KNJrT24+oAjcvd1h6FVJuTpDSKRqSB6YdkrzA9O/EoLpZF0YLaYIS+TvUF0A
	ZohZlP0/UV5gEAeTYKg6dHv+KcqYA7bUzqCZ2FEV5L4lh9CB/4fW0ZCGq6bwNqhxX87loIp
	NZG46kfQ0gP7rLW6g4ILr/1RgYIdIh8qH5B5TvZRihOhrs5RhSNLiHE89fBX738KxVDZeAt
	D5CmpMmgVBPtVCZf+Sud8g72IPYn+Nuq4xbi1dRDjgPL+ocNcjzya7WeXcLaeFNb8Lvug8O
	SN1EdopvghHeBWATxQHLk8a6kg9KdcOEnQ6WdDdFmSarAw/Xk+Tm21lJ0bRo6mrsJ0Vf6Kb
	s0bNKKog==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> writes=EF=BC=9A
>=20
> lidongyan <502024330056@smail.nju.edu.cn> writes:
>=20
>> Alex via GitGitGadget <gitgitgadget@gmail.com> writes=EF=BC=9A
>>>=20
>>> From: jinyaoguo <guo846@purdue.edu>
>>>=20
>>> In parse_reuse_arg, we previously called xmalloc and strbuf_init
>>> before resolving the ref and reading the object, leading to a
>>> leaked msg on die() paths. This change moves the allocation of
>>=20
>> A memory leak on the die() path shouldn't be considered a real leak,
>> right? Since the OS will clean up all memory once the process
>> terminates, explicitly freeing msg isn't necessary in this case.
>=20
> It may not matter in practice, but I think the leak checking
> machinery like sanitizers would still complain, so I view efforts on
> plugging such leaks in the error code paths more about decluttering
> the leak checker output to help us spot the real leaks.

Makes sense. However, inserting a free-like statement in die() would be
messier than using goto, since each die() has a unique message and we
need to free stuff at each die().=
