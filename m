Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049FF208CA
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682401; cv=none; b=FSELlCLOPlPzCGqRBCI0NmIfSzjwRJ/S53f7SlwAKtpQuGXBr/sAz6KcfNRJQSLL2fX+J2hmPLqQ28isLBbGkBj7BAep/eh0uAkZh/7GnuHbagQWS8qVK1sruT/kN5NcmPVm69j5QEn6X2YOifrI3ZkuaRvS1cj45vwK8wOhRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682401; c=relaxed/simple;
	bh=E/O4XZjVuPK1G6DaultzNxWZH8WurFUK84I55xbRAU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XLeEu+RGCSYv3csjGtn8q0lENBywZMoysjUk8aB0ELQZkDzjNVkYhXEO9bk1bpR0KUPOBYAmldgYs0Os4F7z+7p2H3TIU0ttMTKiPt1ECQ4vPCL92QzvmStltg9jNzWTdQ9mH6mNig3oN4jjkazL+OY435m8Q5JuwPc5p5UrEpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vw+/JG1P; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vw+/JG1P"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA66822867;
	Mon, 22 Jul 2024 17:06:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E/O4XZjVuPK1
	G6DaultzNxWZH8WurFUK84I55xbRAU4=; b=Vw+/JG1P2PzVIFji9dwxox6T6/1/
	I+YaCZk0Czo0XIRsSojIOrB+h03Hrso4rv2mIJ2rmggppz4wfMrPe+5YiH3B2fzg
	pI+mpoIYINaYr5HWHAxrb7d/3JR9q4Z9+7An31XMd752X3grY/8PxYlV6616dCFF
	icXN5yv10Wb57Uw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E26CF22866;
	Mon, 22 Jul 2024 17:06:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55FA322865;
	Mon, 22 Jul 2024 17:06:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
    Kyle Lippincott <spectral@google.com>,
    Git List <git@vger.kernel.org>,
    Dragan Simic <dsimic@manjaro.org>,  Jeff King <peff@peff.net>
Subject: Re* [PATCH v3 4/4] add-patch: render hunks through the pager
In-Reply-To: <xmqqa5i9b51m.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	22 Jul 2024 12:27:49 -0700")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
	<1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
	<xmqqttgqyzwa.fsf@gitster.g>
	<2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
	<88f9256e-04ba-4799-8048-406863054106@gmail.com>
	<a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
	<xmqqv80xcpe5.fsf@gitster.g>
	<079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com>
	<xmqqa5i9b51m.fsf@gitster.g>
Date: Mon, 22 Jul 2024 14:06:37 -0700
Message-ID: <xmqqbk2p9lwi.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 493645A2-486E-11EF-849B-34EEED2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Rub=C3=A9n Justo <rjusto@gmail.com> writes:
>
>>> It's a very convincing theory but it does not seem to match my
>>> observation.  Is there a difference in shells used, or something?
>>
>> Have you tried your tweak in the "linux-gcc (ubuntu-20.04)" test
>> environment where the problem was detected?  In that environment, the
>> value of GIT_PAGER is not passed to Git in that test.=20
>
> So, we may have a shell that does not behave like others ;-)  Do you
> know what shell is being used?

So we have an answer:

  https://github.com/git/git/actions/runs/10047627546/job/27769808515

tells us that the problematic shell is used in the job.

It is

ii  dash           0.5.10.2-6     amd64        POSIX-compliant shell

running on Ubuntu 20.04 that is "too POSIXly correct"[*] and behaves
differently from what the tests expect.

Somebody should write this combination down somewhere in the
documentation so that we can answer (better yet, we do not have to
answer) when somebody wonders if we know of a version of shell that
refuses to do an one-shot export for shell functions as we na=C3=AFvely
expect.


[Reference]

 * https://lore.kernel.org/git/4B5027B8.2090507@viscovery.net/


----- >8 --------- >8 --------- >8 --------- >8 ----
CodingGuidelines: give an example shell that "fails" "VAR=3DVAL shell_fun=
c"

Over the years, we accumulated the community wisdom to avoid the
common "one-short export" construct for shell functions, but seem to
have lost on which exact platform it is known to fail.  Now during
an investigation on a breakage for a recent topic, let's document
one example of failing shell.

This does *not* mean that we can freely start using the construct
once Ubuntu 20.04 is retired.  But it does mean that we cannot use
the construct until Ubuntu 20.04 is fully retired from the machines
that matter.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuideli=
nes
index 1d92b2da03..a3ecb4ac5a 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -204,6 +204,29 @@ For shell scripts specifically (not exhaustive):
 	local variable=3D"$value"
 	local variable=3D"$(command args)"
=20
+ - The common construct
+
+	VAR=3DVAL command args
+
+   to temporarily set and export environment variable VAR only while
+   "command args" is running is handy, but some versions of dash (like
+   0.5.10.2-6 found on Ubuntu 20.04) makes a temporary assignment
+   without exporting the variable, when command is *not* an external
+   command.  We often have to resort to subshell with explicit export,
+   i.e.
+
+	(incorrect)
+	VAR=3DVAL func args
+
+	(correct)
+	(
+		VAR=3DVAL && export VAR &&
+		func args
+	)
+
+   but be careful that the effect "func" makes to the variables in the
+   current shell will be lost across the subshell boundary.
+
  - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
    "\xc2\xa2") in printf format strings, since hexadecimal escape
    sequences are not portable.
