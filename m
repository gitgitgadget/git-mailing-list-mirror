Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B90AD5A
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836384; cv=none; b=QrHuLKpTEh5VMeeEqmmAQqgZnno1hhd0ZFjZklfA7r/crqccdmKwyamFuW6Y3CtBRCGLqZHlxtkP3nDnTDPT3BKEqIT6SQYH4jfVI/iud++VdjVQDOCzDm7knhZuUlg4hSyX/N8HQHwf4p8qV4qcPzsOK1/kSWHDum+SaFsrFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836384; c=relaxed/simple;
	bh=mJOogfpYQR8OOmh4qTEolwb5khl6kBLNbWelBPVOMVQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=X7WepYE8g1cbvtTcTuORmxt6jqYxBxFd79Trg0kLu/jqa3jdqB6cHcDdOW2LZkM+bvD+3WzLwzXS0SmwY0pZF8I71t7MBk/j99rHoOIhBP12nPpimDfoD1ZJjTqdr8nWisqdPlO/x5HEvsWXVjBCi+FcyodKW9+stmP1MOTiyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59UExdY31971130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 14:59:39 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'D. Ben Knoble'" <ben.knoble@gmail.com>
Cc: "=?utf-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        <git@vger.kernel.org>
References: <xmqqo6psjq2n.fsf@gitster.g> <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com> <aQKVByfUdYHSEcDz@szeder.dev> <000201dc4925$2cdbc450$86934cf0$@nexbridge.com> <aQKgxfZ9WQjyrhpa@szeder.dev> <000701dc4933$9f79c670$de6d5350$@nexbridge.com> <CALnO6CAYmtDmfk36nX6TCCaV2c=8J0BXv9eN+L=j1PU=gPmJUQ@mail.gmail.com>
In-Reply-To: <CALnO6CAYmtDmfk36nX6TCCaV2c=8J0BXv9eN+L=j1PU=gPmJUQ@mail.gmail.com>
Subject: RE: [BUGS] Git v2.51.2 on NonStop
Date: Thu, 30 Oct 2025 10:59:34 -0400
Organization: Nexbridge Inc.
Message-ID: <006e01dc49ad$d12f9a80$738ecf80$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGUZTuwh66ijI7aIz2t8Y1znRjrdQMi5nLUAqYtrUMA8xKehADwUhlfAloQkUECDEo+0LUJ+hqg
Content-Language: en-ca
X-Antivirus: Norton (VPS 251030-2, 10/30/2025), Outbound message
X-Antivirus-Status: Clean

On October 30, 2025 9:53 AM, D. Ben Knoble wrote:
>On Wed, Oct 29, 2025 at 8:25=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>>
>> What appears to be happening is that the Make environment is only
>> using SHELL=3D/bin/bash for the outer processing but not the inner
>> #!/bin/sh of t7900. The system is using /bin/sh as specified, which
>> uses ksh, not bash, which is the trace above. When I run the
>> individual tests with bash, the error reported goes away. The problem
>> is, with my version of Gnu Make, 4.1.2, the SHELL variable is only
>> being replaced for the command processing of each recipe. Once the
>> system loader sees the shebang of #!/bin/sh, /bin/sh is used as
>> requested, and fails out. This means that I have to remember to =
manually run
>each test that fails with bash instead of the default. It is =
frustrating and now adds
>hours to my manual evaluation of the CI/CD results.
>>
>> The trace above is from sh, not bash because of this.
>>
>> With Frustration,
>> Randall
>
>Is this the only ksh-induced failure? And if so, what is inducing the =
failure=E2=80=94is it
>something the test library can work around, or is the system {k,}sh not =
behaving
>portably here?
>
>My preference would be towards making your setup "just work" assuming =
there's
>not a clear contradiction of portable standards somewhere.

I think there were other ksh issues, mostly the SHELL=3D setting in =
make. I will report
others on a per test case basis when they come. The SHELL_PATH=3D =
definitely is
using bash, so that fix suggested by Peff is working out nicely.

Regards,
Randall

