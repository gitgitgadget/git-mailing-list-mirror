Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE71C27
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111018; cv=none; b=YuDV+mng+jX18hnEFwtvMNXO/PVQBL8mJ5ndpKV6DBrHjGwWD3HVYmzRdKp9iQuZewqIuvzyNJgjvaJ839t11A7GsX0WccyEyVW5zRlM969LzV0tazadAYbB9SXeatfLLdmbaNGHKmyyDpuuP0fZ1vDXovGBPQ1SE/BBbUhIcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111018; c=relaxed/simple;
	bh=HcdlDgKaR7Z9xD7ke9CRkS7KaP+kU3lRlqwelBxpRxM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=iDqyS88y6Me7Jn6Ya7UqdGiqugFAcKE72VLcLwGpdOzph2fm3CqeDbfXD3gXvdOGwcFW7k4rYZxnk6cPP3T0hMxO3mZ7yg0HitToo2+JFfJme2byEfYd3AYqfiT17gnm6KWWQydRgYAoEs3sBIzd4kh3ACchSEGY5IWUHQpO74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen ([185.122.133.20])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5558A07A619197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 08:10:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Johannes Sixt'" <j6t@kdbg.org>, "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>, "'Todd Zullinger'" <tmz@pobox.com>
References: <xmqqsekgn4gk.fsf@gitster.g> <007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com> <007d01dbd4d9$356ded70$a049c850$@nexbridge.com> <aEBPdFXpIca7lMls@teonanacatl.net> <xmqqjz5rcz90.fsf@gitster.g> <44fe8627-5680-443d-bf02-a6e85afd46b4@kdbg.org>
In-Reply-To: <44fe8627-5680-443d-bf02-a6e85afd46b4@kdbg.org>
Subject: RE: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed
Date: Thu, 5 Jun 2025 04:09:54 -0400
Organization: Nexbridge Inc.
Message-ID: <010b01dbd5f1$3c26ec20$b474c460$@nexbridge.com>
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
Thread-Index: AQE/8OENAHtdeNmfXNuu5L7gSMXaAQGPhlBYAT32OawCDCTCZQHcPefDAfT2uzS05qiI4A==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250604-12, 6/4/2025), Outbound message
X-Antivirus-Status: Clean

On June 4, 2025 3:25 PM, Johannes Sixt wrote:
>Am 04.06.25 um 17:17 schrieb Junio C Hamano:
>> So the build procedure for git-gui (but not gitk) has changed rather
>> extensively after we tagged the preview before -rc1?  Honestly, I
>> would have preferred to see a change with this impact go through the
>> regular 'seen' to 'next' to 'master' way before -rc0, but that is
>> water under the bridge.
>
>I don't think we ever had such a cycle for gitk and git-gui. I carry =
inofficial branches
>'j6t-testing' in my repositories that interested parties could track =
instead of 'master'.
>I would be happy to hear that people actually do use them.
>
>> I do not spot anything obviously wrong (and it is not expected that I
>> would---we wouldn't have this code sent to me in the first place if
>> this is something I can immediately notice).  git-gui/Makefile sets
>> ALL_LIBFILES to $(wildcard lib/*.tcl) and then does
>>
>>     $(SHELL_PATH) generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS
>> $(ALL_LIBFILES)
>>
>> So the error message in Becker's message, i.e.
>>
>>> /usr/coreutils/bin/bash generate-tclindex.sh .
>>> ./GIT-GUI-BUILD-OPTIONS
>>> usage: generate-tclindex.sh <BUILD_DIR> <BUILD_OPTIONS> <LIBFILE>
>>> [<LIBFILE>...]
>>> Makefile:200: recipe for target 'lib/tclIndex' failed
>>
>> suggests that $(wildcard lib/*tcl) expanded to *nothing*, which =
sounds
>> horribly wrong.  They are source material and should exist in an
>> unmodified checkout or a tarball extract.
>
>I don't see anything wrong, either. I can easily verify your theory =
that the
>$(wildcard) produces an empty list by modifying the pattern.
>
>Randall, would it be possible for you to find out why $(wildcard
>lib/*tcl) produces an empty list in your case?

I can verify that $(wildcard lib/*tcl) is correctly reporting an empty =
list.

There are three directories name lib in the 2.50.0-rc1 commit:
./git-gui/lib
./gitweb/static/js/lib
./perl/build/lib
None have any files ending in tcl:
$ ls git-gui/lib
git-gui.ico  meson.build  tclIndex  win32_shortcut.js
$ ls gitweb/static/js/lib
common-lib.js  cookies.js  datetime.js
$ ls perl/build/lib
FromCPAN  Git  Git.pm

If it possible that your workspace has extra stuff that does not exist =
at the time make
is run. Note that I am using gnu Make 4.2.1 with bash to perform the =
built/test cycle.


