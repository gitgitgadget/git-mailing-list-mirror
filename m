Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034DF171B0
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720981752; cv=none; b=Ag1NOSHWaF6xQSFu7uNFxphvawB+xRO1LKYQS9/bink2YVMww15bedBfLatZ4nZwGh8vYzkt2Rw+KhK6sQSJW0R+eWDQ6jKzGQUtUcrvEZBe1gtYomjGZIiEY77sPMAbBX0n/ISP5F/Z7WK5qCNbcOjGMA+qeWGfqKqu1nWu6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720981752; c=relaxed/simple;
	bh=KMUiyrgLZZOtFj7wTuw+ijKbw2vRzgGrm8C8ckjDK/Y=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=u4XmMXY0Q4oTfECJ931CVFmWrUl6EJDOrT+/LHy8sDG4e4XEvJ3yoxtkAqpm8NX4Vdpu5iKe4jkZNtqy0REG1USyWkv8egjYzATpYDB0jC5eE2mgD8/nJJ2FUNGESD80PGul91LdP0sRgb6nfL8j+3gjiTCdrLzG7xFT687QsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46EIT19p267674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 18:29:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com> <xmqq8qy4adl4.fsf@gitster.g> <001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com> <xmqqttgr9aeb.fsf@gitster.g> <ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net>
In-Reply-To: <ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net>
Subject: RE: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
Date: Sun, 14 Jul 2024 14:28:56 -0400
Organization: Nexbridge Inc.
Message-ID: <004501dad61b$b35b7f30$1a127d90$@nexbridge.com>
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
Thread-Index: AQLxORQfyENxav+zmXZW2AfFrMp2ygG7wSa1AglWfbcCCOoxCwFeXAgQr5BhIwA=

On Sunday, July 14, 2024 2:16 PM, brian m. carlson wrote:
>To: Junio C Hamano <gitster@pobox.com>
>Cc: rsbecker@nexbridge.com; git@vger.kernel.org
>Subject: Re: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
>
>On 2024-07-14 at 17:00:12, Junio C Hamano wrote:
>> <rsbecker@nexbridge.com> writes:
>>
>> > This looks like a different between ksh and bash. Under bash, the
>> > test works. I can live with that but will have to force bash to be
>> > used as the shebang #!/bin/sh defaults to ksh on this box.
>>
>> It turns out that the version of ksh I used in my description does =
not
>> seem to grok "local" at all. I vaguely recall that we've written off
>> various hobbist reimplementation of ksh as unusable enough, but this
>> one is ksh93 direct from AT&T Research.
>>
>> I guess when we said "as long as we limit our use to a simple 'this
>> variable has visibility limited to the function and its children'
>> and nothing else, it is portable enough across practically everybody
>> we care about", we have written off the real ksh, too.
>>
>> In the meantime, we may want to document this in a more prominent =
way.
>> Perhaps like so:
>>
>> -------- >8 --------------- >8 --------------- >8 --------
>> Subject: doc: guide to use of "local" shell language construct
>>
>> The scripted Porcelain commands do not allow use of "local" because =
it
>> is not universally supported, but we use it liberally in our test
>> scripts, which means some POSIX compliant shells (like "ksh93") can
>> not be used to run our tests.
>>
>> Document the status quo, and hint that we might want to change the
>> situation in the fiture.
>
>I don't think this is the right approach.  Every version of ksh =
_except_ AT&T ksh
>works just fine here.  pdksh, mksh, lksh, OpenBSD's ksh (which is also =
its /bin/sh)
>work fine, as do bash, dash, FreeBSD's sh (ash), Busybox's sh (also =
ash), and zsh
>(when run in sh mode with 5.9 or newer).  AT&T ksh is considering =
adding local in a
>newer version for this reason.
>
>Literally only AT&T ksh is not supported here, and so anyone can set =
SHELL_PATH to
>any suitable shell.  I don't think it's useful to get rid of local when =
there are a variety
>of acceptable and portable options.

We can add NonStop's ksh to the list of not supported. I'm using =
TEST_SHELL_PATH while running make all in the t directory. Test passes =
when I use bash. For some reason (maybe GNUMake 4.1, which is what I =
have in my POSIX environment, I don't get TEST_SHELL_PATH passed down =
from the outer Makefile, but I can work with that. t0021 is now passing =
in my current CI stream using bash 5.0.18.

--Randall

