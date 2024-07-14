Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B3513C69C
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720995304; cv=none; b=GSuOlmvl8e3Is5bY80N3IupcmorwhiLj3RxXDiRq3Gboe8sePn82NkvWtPtvLQEJDt29qpCBR0KjjEcPJSXn+hr5bbW+ksOfkW5kuwx4z7LFWir7IoNTtMDiofe1V44gFN4Ka1x9tYsqROSYZ9Xb7i1abdKkXscnzWBA9jgHfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720995304; c=relaxed/simple;
	bh=VkgZM23pjjQnl7FYfHo/V6blsuDO1yhHe2Jc5IPOMsU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=LTNPUEft6QcSwngaKii6Cm7w1BxTa0b37qk3CP83C/lK9yO0kvFtmkhM/RvtHB5N+3QiMw1iXq9XFfrdX7GJMQzCgnCZGBSeF4kr7flV8JwtGkLCJyIZWm7Ryl/6dPvfdgERKz9QoEDO/jMF+Xwoy/udfxjdjpdVNJWahZE1cVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46EMEsbi292246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 22:14:54 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com> <xmqq8qy4adl4.fsf@gitster.g> <001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com> <xmqqttgr9aeb.fsf@gitster.g> <ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net> <004501dad61b$b35b7f30$1a127d90$@nexbridge.com> <ZpRKu8Xsz70xNHFp@tapette.crustytoothpaste.net>
In-Reply-To: <ZpRKu8Xsz70xNHFp@tapette.crustytoothpaste.net>
Subject: RE: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
Date: Sun, 14 Jul 2024 18:14:49 -0400
Organization: Nexbridge Inc.
Message-ID: <006201dad63b$418c76f0$c4a564d0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLxORQfyENxav+zmXZW2AfFrMp2ygG7wSa1AglWfbcCCOoxCwFeXAgQAPqT5zMCVerbsK92GilQ

On Sunday, July 14, 2024 6:02 PM, brian m. carlson wrote:
>On 2024-07-14 at 18:28:56, rsbecker@nexbridge.com wrote:
>> On Sunday, July 14, 2024 2:16 PM, brian m. carlson wrote:
>> >I don't think this is the right approach.  Every version of ksh
>> >_except_ AT&T ksh works just fine here.  pdksh, mksh, lksh, =
OpenBSD's
>> >ksh (which is also its /bin/sh) work fine, as do bash, dash,
>> >FreeBSD's sh (ash), Busybox's sh (also ash), and zsh (when run in sh
>> >mode with 5.9 or newer).  AT&T ksh is considering adding local in a =
newer
>version for this reason.
>> >
>> >Literally only AT&T ksh is not supported here, and so anyone can set
>> >SHELL_PATH to any suitable shell.  I don't think it's useful to get
>> >rid of local when there are a variety of acceptable and portable =
options.
>>
>> We can add NonStop's ksh to the list of not supported. I'm using
>TEST_SHELL_PATH while running make all in the t directory. Test passes =
when I use
>bash. For some reason (maybe GNUMake 4.1, which is what I have in my =
POSIX
>environment, I don't get TEST_SHELL_PATH passed down from the outer =
Makefile,
>but I can work with that. t0021 is now passing in my current CI stream =
using bash
>5.0.18.
>
>I think we had discussed that you were using AT&T ksh on NonStop, which =
would
>explain the situation.  That's the most common version of ksh on =
proprietary Unix
>systems, and you can usually detect it with something like this:
>
>% ksh -c 'echo $KSH_VERSION'
>Version AJM 93u+m/1.0.8 2024-01-01
>
>Variants of pdksh look like this (this one from OpenBSD):
>
>% ksh -c 'echo $KSH_VERSION'
>@(#)PD KSH v5.2.14 99/07/13.2
>
>And mksh and lksh (which are the same shell, just compiled differently, =
look like
>this:
>
>% mksh -c 'echo $KSH_VERSION'
>@(#)MIRBSD KSH R59 2024/02/01 +Debian
>
>% lksh -c 'echo $KSH_VERSION'
>@(#)LEGACY KSH R59 2024/02/01 +Debian
>
>I think using bash as a workaround is the right choice here if all you =
have is AT&T
>ksh.

We did discuss the ksh issue on NonStop but the check for whether this =
is an AT&T ksh is non-functional (KSH_VERSION is not set). What we did =
was change SHELL=3D/usr/coreutils/bin/bash and TEST_LINT=3D to get the =
tests to execute. Unfortunately, the GNU Make we have (4.1) does not =
pass TEST_SHELL_PATH (also set) down to inner make processes, so we =
still get stuck with ksh. I changed our CI system to run the test make =
on its own, which is now working on this test.

Regards,
Randall

