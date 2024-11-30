Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1771DFF7
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732987038; cv=none; b=jmlYjcGF/e68BGQJ9i3/WJTUfrkLoQyZ5tAiwjefCj8X0GtwAnIiWSMEOiQiNMw1l0AR+a6BDexCEzvoHGoQSES4RrV11v9oO3W2daFJkJM52rwE4Nx6ESpqSPBMULNRS7puA3iOjh7Zm+smTtA1kbCXppc92VGU8NU+IJ44jWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732987038; c=relaxed/simple;
	bh=vS0fqNKlQH4BJszyX71i3suvAP0GlKNPO47WGWe5kio=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=RNFy8A1k20UTCXjQfyPqgR53w+bmWHj6V/LI4jbrNFforGsi3rv5EEoE8L5hk7ReMElw1x7y1dc6HFhG1a6KN2puYdBYN3GDr8sNWGW1+SMaUFd0fhPkd27FDjrd+Ei1Kme+Mqk6NPUXSV1is+rECv0SpLEM7XZJsJHfHiN39tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4AUHH09d2558566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Nov 2024 17:17:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Caleb White'" <cdwhite3@pm.me>, <git@vger.kernel.org>
Cc: "'shejialuo'" <shejialuo@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me> <00c401db42b1$99c4d5a0$cd4e80e0$@nexbridge.com> <D5Z1L479JERN.80KZ7NA9BWNJ@pm.me> <00c501db42b4$ea97e050$bfc7a0f0$@nexbridge.com> <D5Z1X36NVZ28.1FPA05CU9GFRL@pm.me> <00c801db42b8$a03539a0$e09face0$@nexbridge.com> <D5Z2R71VW1JF.1FZE1Z0V8H6Q7@pm.me> <00c901db42c0$38f95520$aaebff60$@nexbridge.com> <D5ZN60S3JMS8.UXLUSM5IOFCX@pm.me>
In-Reply-To: <D5ZN60S3JMS8.UXLUSM5IOFCX@pm.me>
Subject: RE: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Date: Sat, 30 Nov 2024 12:16:56 -0500
Organization: Nexbridge Inc.
Message-ID: <010801db434b$ac0ec960$042c5c20$@nexbridge.com>
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
Thread-Index: AQHZQR+UqnR1y6U5HdhCIquXTuJIeQHx0ACsAfNKDdECDlEqNwJOncQoAbA2A8gCob0ycQMt5WUHAopz08yyQbCLAA==
Content-Language: en-ca

On November 30, 2024 11:08 AM, Caleb White wrote:
>On Fri Nov 29, 2024 at 6:38 PM CST, rsbecker wrote:
>> On November 29, 2024 7:09 PM, Caleb White wrote:
>>>If the `develop` directory is deleted, cleanup detection is handled =
by
>>>the `git worktree prune` command, which will remove worktrees under
>>>`.git/worktrees/*` that are no longer valid. This happens
>>>automatically after the expiry time or it can be executed manually. =
Of
>>>course, executing `git worktree remove develop` will also remove the =
worktree
>and its associated worktree id.
>>
>> This last bit is an assumption, and not necessarily valid. Scripts
>> that use worktrees may maintain lists or their own pointers. It is
>> important to be able to emulate cleanup functions - something I
>> discovered early in the worktree functions when released. I need to
>> make sure that cleanup will continue to have enough information -
>> prior to git worktree cleanup - to function correctly. This will need
>> coordination with people who have such scripts in my community. It
>> probably will not impact you, but I would have appreciated more than =
one release
>notice on this capability.
>
>I'm not sure I understand the specific use-case you're talking about.
>Could you provide an example?

Speaking as a professional product manager...

I'm not expressing "maintaining compatibility for 2 releases" or =
something like
that is a reasonable use case. There are customers who depend on things
working in a particular way. It is fine if you want to change it and =
improve it,
and I am supportive. However, when making a change that causes git to
behave differently without allowing people to plan for such a change is
impolite. People outside this list do not read each patch looking for
compatibility breaking changes - they only get told in release notes. A
statement like "this is going to change with 2.49" for a breaking
enhancement is what I would expect - unless it is a defect correction.

>However, I suppose I can add a config / env variable to be able to =
disable this new
>functionality.

That would be very helpful although an opt-in is generally better than =
an
opt-out.

I think we should have this as a general policy, not just for this =
series.

Thanks,
Randall

