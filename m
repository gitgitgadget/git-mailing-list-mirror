Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9E1B3F3D
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154139; cv=none; b=TVsyZNmXmeZ0Ie2ORS7XpziSq9mpf0cwg6++rCATtnsx1pxYHcNn6vrGpyegQDCuGlv4PJHB3v9R4wPkboGMdXxj4iGBBhpK7OHa0xrVV5uXO15bdAb1Gtjgos9WqPl4AYLm4iN0HB51he6e8O5GTL3NqE5SPK/E21oLUbFz+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154139; c=relaxed/simple;
	bh=vzbZSHSTOVhniVBvNUv7LDRPMfqYljtoQ5d0+vTE0JQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rn15SNNpDVO8kgMC4gBjfOD36Kd7JUNoS2eFpn19W4xhWI/13TJesO0d1P4Gkj31fvhIn1vlSG2U1B8K21P0M8KPKe4OegIZUfK46iPAtAb03tvOSBPGmSMJbJnvE1Y1t1bxxxWPv/Fl889CxZ6cVrXrWcflu3Mho2VT2PWYcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50HMlpr83831828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 22:47:52 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Usman Akinyemi'" <usmanakinyemi202@gmail.com>
Cc: <git@vger.kernel.org>, <christian.couder@gmail.com>, <ps@pks.im>,
        <johncai86@gmail.com>, <Johannes.Schindelin@gmx.de>, <me@ttaylorr.com>,
        <phillip.wood@dunelm.org.uk>, <sunshine@sunshineco.com>,
        "'Christian Couder'" <chriscool@tuxfamily.org>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>	<20250117104639.65608-1-usmanakinyemi202@gmail.com>	<20250117104639.65608-6-usmanakinyemi202@gmail.com> <xmqq4j1xjd2m.fsf@gitster.g>
In-Reply-To: <xmqq4j1xjd2m.fsf@gitster.g>
Subject: RE: [PATCH v2 5/6] connect: advertise OS version
Date: Fri, 17 Jan 2025 17:47:46 -0500
Organization: Nexbridge Inc.
Message-ID: <00bb01db6931$d7cd6dc0$87684940$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL1iKQeqDpt8guF+jE2EcHccRlcdgGGCMwEAjdRnLkCWoP1KrC2klVg
Content-Language: en-ca
X-Antivirus: Norton (VPS 250117-8, 1/17/2025), Outbound message
X-Antivirus-Status: Clean

On January 17, 2025 5:22 PM, Junio C Hamano wrote:
>Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
>> As some issues that can happen with a Git client can be operating
>> system specific, it can be useful for a server to know which OS a
>> client is using. In the same way it can be useful for a client to know
>> which OS a server is using.
>
>Hmph.  The other end may be running different version of Git, and the
version
>difference of _our_ software is probably more relevant.
>For that matter, they may even be running something entirely different from
our
>software, like Gerrit.  So I am not sure I am convinced that os-version
thing is a good
>thing to have with that paragraph.
>
>> Let's introduce a new protocol (`os-version`) allowing Git clients and
>> servers to exchange operating system information. The protocol is
>> controlled by the new `transfer.advertiseOSVersion` config option.
>
>The last sentence is redundant and can safely removed.  The next paragraph
>describes it better than "is controlled by".
>
>> Add the `transfer.advertiseOSVersion` config option to address privacy
>> concerns. It defaults to `true` and can be changed to `false`. When
>> enabled, this option makes clients and servers send each other the OS
>> name (e.g., "Linux" or "Windows"). The information is retrieved using
>> the 'sysname' field of the `uname(2)` system call.
>
>Add "or its equivalent" at the end.

>macOS may have one, but it probably is not quite correct to say that
Windows have
>uname system call (otherwise we wouldn't be emulating it on top of
GetVersion
>ourselves).
>
>> However, there are differences between `uname(1)` (command-line
>> utility) and `uname(2)` (system call) outputs on Windows. These
>> discrepancies complicate testing on Windows platforms. For example:
>>   - `uname(1)` output: MINGW64_NT-10.0-20348.3.4.10-87d57229.x86_64\
>>   .2024-02-14.20:17.UTC.x86_64
>>   - `uname(2)` output: Windows.10.0.20348
>>
>> On Windows, uname(2) is not actually system-supplied but is instead
>> already faked up by Git itself. We could have overcome the test issue
>> on Windows by implementing a new `uname` subcommand in `test-tool`
>> using uname(2), but except uname(2), which would be tested against
>> itself, there would be nothing platform specific, so it's just simpler
>> to disable the tests on Windows.
>
>OK.
>
>> +transfer.advertiseOSVersion::
>> +	When `true`, the `os-version` capability is advertised by clients
and
>> +	servers. It makes clients and servers send to each other a string
>> +	representing the operating system name, like "Linux" or "Windows".
>> +	This string is retrieved from the `sysname` field of the struct
returned
>> +	by the uname(2) system call. Defaults to true.
>
>Presumably, both ends of the connection independently choose whether they
>enable or disable this variable, so we have 2x2=4 combinations (here,
versions of
>Git before the os-version capability support is introduced behave the same
way as
>an installation with this configuration variable set to false).
>
>And among these four combinations, only one of them results in "send to
each
>other", but the description above is fuzzy.
>
>> diff --git a/connect.c b/connect.c
>> index 10fad43e98..6d5792b63c 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -492,6 +492,9 @@ static void send_capabilities(int fd_out, struct
>packet_reader *reader)
>>  	if (server_supports_v2("agent"))
>>  		packet_write_fmt(fd_out, "agent=%s",
git_user_agent_sanitized());
>>
>> +	if (server_supports_v2("os-version") &&
>advertise_os_version(the_repository))
>> +		packet_write_fmt(fd_out, "os-version=%s",
>os_version_sanitized());
>
>Not a new problem, because the new code is pretty-much a straight copy from
the
>existing "agent" code, but do we ever use unsanitized versions of
git-user-agent and
>os-version?  If not, I am wondering if we should sanitize immediately when
we
>obtain the raw string and keep it, get rid of _santized() function from the
public API,
>and make anybody calling git_user_agent() and os_version() to get sanitized
safe-
>to-use strings.
>
>I see http.c throws git_user_agent() without doing any sanitization at the
cURL
>library, but it may be a mistake that we may want to fix (outside the scope
of this
>topic).  Since the contrast between the
>os_version() vs the os_version_sanitized() is *new* in this series,
however, we
>probably would want to get it right from the beginning.
>
>So the question is again, do we ever need to use os_version() that is a raw
string
>that may require sanitizing?  I do not think of any offhand.

uname(2) is definitely not portable. uname(1) is almost always available,
but
there is no guarantee about uname(2). I am not entirely happy having my
builds break if having to write one between rc0 and rc1 when this rolls. How
is this being handled? os_version() is also not portable. What if we had
something that asked for specific elements of the string, by name or id.


