Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10C28EA
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732927149; cv=none; b=RwH5Vk7dti9mKWVmSTNQyQzWcUg4R986h8PQ0bgv0dYC5jguGCC7ojbzIVpeD0oDihAcL0XfsV1vU6NGBMM6ofUpopD4tdjolgBBpcaCF875v8HqhNn6+/WXBJePilUO26KQsPmqFX+ULHATz5J+q9CqAh2SY3fGn7SqYahHZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732927149; c=relaxed/simple;
	bh=4fuHarOAEiqQDBWrDAlAmnRuPgK1Hs3CC4Qjq1GLGWY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SaRRJZJV8r3gcKV737o1nAoS6E2+zMcW9YG08GV1D5gYwPf6kUW4ZEjoQEGFhwZTgucC0GCYf1Tey7BqBqoQLKssYOej1ypmYS0yb5zz4jmPuqGNs4RrEEFdgilbd37GUQKzytow8YfN5RJiwlQf/w0zgLY8gybtsE8IhZ1yLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4AU0ckFe2440666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Nov 2024 00:38:47 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Caleb White'" <cdwhite3@pm.me>, <git@vger.kernel.org>
Cc: "'shejialuo'" <shejialuo@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me> <00c401db42b1$99c4d5a0$cd4e80e0$@nexbridge.com> <D5Z1L479JERN.80KZ7NA9BWNJ@pm.me> <00c501db42b4$ea97e050$bfc7a0f0$@nexbridge.com> <D5Z1X36NVZ28.1FPA05CU9GFRL@pm.me> <00c801db42b8$a03539a0$e09face0$@nexbridge.com> <D5Z2R71VW1JF.1FZE1Z0V8H6Q7@pm.me>
In-Reply-To: <D5Z2R71VW1JF.1FZE1Z0V8H6Q7@pm.me>
Subject: RE: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Date: Fri, 29 Nov 2024 19:38:41 -0500
Organization: Nexbridge Inc.
Message-ID: <00c901db42c0$38f95520$aaebff60$@nexbridge.com>
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
Thread-Index: AQHZQR+UqnR1y6U5HdhCIquXTuJIeQHx0ACsAfNKDdECDlEqNwJOncQoAbA2A8gCob0ycbJuXYOw
Content-Language: en-ca

On November 29, 2024 7:09 PM, Caleb White wrote:
>To: rsbecker@nexbridge.com; git@vger.kernel.org
>Cc: 'shejialuo' <shejialuo@gmail.com>; 'Junio C Hamano' =
<gitster@pobox.com>
>Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across =
repositories
>
>On Fri Nov 29, 2024 at 5:44 PM CST, rsbecker wrote:
>> On November 29, 2024 6:29 PM, Caleb White wrote:
>>>On Fri Nov 29, 2024 at 5:17 PM CST, rsbecker wrote:
>>>> On November 29, 2024 6:14 PM, Caleb White writes:
>>>>>On Fri Nov 29, 2024 at 4:54 PM CST, rsbecker wrote:
>>>>>> General comment on this series: Is there a mechanism of =
preserving
>>>>>> existing functionality for those of us who have existing scripts
>>>>>> that depend on the existing branch and worktree naming?
>>>>>
>>>>>Existing worktrees will continue to work as they do now. The only
>>>>>change is the worktree id for new worktrees. However, there's not =
an
>>>>>option to preserve the existing behavior for new worktrees (nor do =
I
>>>>>think there
>>>should be).
>>>>
>>>> I do not agree. Companies that have existing scripts should have
>>>> some way to preserve their investment. Just saying "No more
>>>> worktrees for you" is not really considerate.
>>>
>>>How exactly are your scripts depending on the worktree id? There are
>>>very few reasons a script might need to know the worktree id, and I
>>>suspect that there's some confusion here. The worktree name is still
>>>used with the `git worktree` commands, so there no change on that =
front.
>>
>> The graphic describing this showed the id in addition to the worktree =
name.
>> During cleanup detection, the directory of the worktree is
>> significant. If that Observation is wrong, I retract all this.
>
>So here's the graphic again:
>
>    foo/
>    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-5445874156/
>    =E2=94=94=E2=94=80=E2=94=80 develop/
>
>Here, the `develop` directory is the worktree directory (this can be =
located
>anywhere), and the `develop-5445874156` is the worktree id.
>However, the worktree id can already be something like `develop1` or =
something
>else entirely if the `develop` directory was renamed in the past. =
Again, there are very
>few things a script should need to know the worktree id for.
>
>If the `develop` directory is deleted, cleanup detection is handled by =
the `git
>worktree prune` command, which will remove worktrees under =
`.git/worktrees/*`
>that are no longer valid. This happens automatically after the expiry =
time or it can be
>executed manually. Of course, executing `git worktree remove develop` =
will also
>remove the worktree and its associated worktree id.

This last bit is an assumption, and not necessarily valid. Scripts that =
use worktrees
may maintain lists or their own pointers. It is important to be able to =
emulate
cleanup functions - something I discovered early in the worktree =
functions
when released. I need to make sure that cleanup will continue to have =
enough
information - prior to git worktree cleanup - to function correctly. =
This will
need coordination with people who have such scripts in my community. It
probably will not impact you, but I would have appreciated more than one
release notice on this capability.

