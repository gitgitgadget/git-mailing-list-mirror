Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C43A1C9
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783905; cv=none; b=i96LDIao4YnJ3pos1q0trugt7VozUSmGXocJtmtJU1tEDMVd40L9C/ikfGXRyyx/xfI5xwW2dbcXiS4remM77xMRP+zrWuLZXEVMh39KHqwNt3El+2A8jEl8A/53UWHvXc4QSOZHyjJY4Z3ce3yNgoARI3FxZFlgcyqTEWJV1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783905; c=relaxed/simple;
	bh=ob9er6YhyUdu/czMMZEjtE1dgKS6rJMQiANuihwdOjc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OBuYuyycn9X3tX6POFvcTFQOSqlFg45hjpHszP6+FQgZ/Vr1+3ApbZYxAllTh4pg1+KsjQYCbjPs3XfDOZ+fEy383qmLEj90/7xrU9ijxw0N4gXeqc6z1Z3B6B3MxznP25rqImjaIY/lnpUKBfLxdQuMquYZndhZupanCcuevVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59U0Ovl51848255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 00:24:58 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "=?utf-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc: <git@vger.kernel.org>
References: <xmqqo6psjq2n.fsf@gitster.g> <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com> <aQKVByfUdYHSEcDz@szeder.dev> <000201dc4925$2cdbc450$86934cf0$@nexbridge.com> <aQKgxfZ9WQjyrhpa@szeder.dev>
In-Reply-To: <aQKgxfZ9WQjyrhpa@szeder.dev>
Subject: RE: [BUGS] Git v2.51.2 on NonStop
Date: Wed, 29 Oct 2025 20:24:52 -0400
Organization: Nexbridge Inc.
Message-ID: <000701dc4933$9f79c670$de6d5350$@nexbridge.com>
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
Thread-Index: AQGUZTuwh66ijI7aIz2t8Y1znRjrdQMi5nLUAqYtrUMA8xKehADwUhlftSw2foA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 251029-2, 10/29/2025), Outbound message
X-Antivirus-Status: Clean

On October 29, 2025 7:18 PM, SZEDER G=C3=A1bor wrote:
>On Wed, Oct 29, 2025 at 06:41:27PM -0400, rsbecker@nexbridge.com wrote:
>> On October 29, 2025 6:28 PM, SZEDER G=C3=A1bor wrote:
>> >On Tue, Oct 28, 2025 at 01:40:42PM -0400, rsbecker@nexbridge.com =
wrote:
>> >> I have found new defects on 2.51.2 that were not present in 2.51.1
>> >> when building
>> >with OpenSSL 3.5 (probably unrelated).
>> >>
>> >> Many failures in t7900 resulting from the use of test_subcommand !
>> >> as seen
>> >below. This is run in bash 5.0.18:
>> >>
>> >> + test_subcommand git gc --quiet --no-detach
>> >> + --skip-foreground-tasks 0< run-no-auto.txt
>> >> =
{"event":"child_start","sid":"20251028T172435.690328Z-H36b1c598-P7b
>> >> 000
>> >> =
02d","thread":"main","time":"2025-10-28T17:24:35.879833Z","file":"/
>> >> hom
>> >> =
e/jenkinsbuild/.jenkins/workspace/Git_Pipeline/run-command.c","line
>> >> ":7
>> >> =
40,"child_id":2,"child_class":"?","use_shell":false,"argv":["git","gc"
>> >> ,"--quiet","--no-detach","--skip-foreground-tasks"]}
>> >> + test_subcommand ! git gc --auto --quiet --no-detach
>> >> + --skip-foreground-tasks 0< run-auto.txt
>> >> test_subcommand[5]: test: argument expected
>> >
>> >This is a strange trace output, as it includes file descriptor
>> >redirections, but lacks the trace of commands executed in
>> >test_subcommands.  This trace doesn't look like it's coming from =
Bash.
>>
>> The test_subcommand[5]: test: argument expect is coming from bash. I
>> cannot see how it is coming from anywhere else. The test was run with
>> -x but snipped. Reference to test_subcommand ! git... fails exactly =
the same way.
>Is there something else I can provide?
>
>The -x trace from Bash doesn't include file descriptor redirections, =
but includes the
>commands executed in test_subcommand, and the number of '+' characters =
at the
>beginning of each trace line indicates the number of subshells, so when =
the test is
>really run by Bash the trace from a test_subcommand invocation looks =
like this:
>
>  ++ test_subcommand git gc --quiet --no-detach --skip-foreground-tasks
>  ++ local negate=3D
>  ++ test git =3D '!'
>  +++ printf '"%s",' git gc --quiet --no-detach --skip-foreground-tasks
>  ++ local =
'expr=3D"git","gc","--quiet","--no-detach","--skip-foreground-tasks",'
>  ++ =
expr=3D'"git","gc","--quiet","--no-detach","--skip-foreground-tasks"'
>  ++ test -n ''
>  ++ grep =
'\["git","gc","--quiet","--no-detach","--skip-foreground-tasks"\]'
>  {"event":"child_start","sid":"20251029T230304.507599Z-H3fb05a16-
>P001a33ae","thread":"main","time":"2025-10-29T23:03:04.512913Z","file":"=
run-
>command.c","line":740,"child_id":2,"child_class":"?","use_shell":false,"=
argv":["git",
>"gc","--quiet","--no-detach","--skip-foreground-tasks"]}
>  ++ test_subcommand '!' git gc --auto --quiet --no-detach =
--skip-foreground-tasks
>  ++ local negate=3D
>
>Since the trace you showed doesn't look like this I still doubt that it =
came from Bash.

What appears to be happening is that the Make environment is only using =
SHELL=3D/bin/bash
for the outer processing but not the inner #!/bin/sh of t7900. The =
system is using /bin/sh
as specified, which uses ksh, not bash, which is the trace above. When I =
run the individual
tests with bash, the error reported goes away. The problem is, with my =
version of Gnu Make,
4.1.2, the SHELL variable is only being replaced for the command =
processing of each
recipe. Once the system loader sees the shebang of #!/bin/sh, /bin/sh is =
used as requested,
and fails out. This means that I have to remember to manually run each =
test that fails with
bash instead of the default. It is frustrating and now adds hours to my =
manual evaluation
of the CI/CD results.

The trace above is from sh, not bash because of this.

With Frustration,
Randall

