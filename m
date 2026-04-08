Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BE83D6694
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673398; cv=none; b=Hl3TNkogQ4vmIUJoiTSFUEh1b1WDNh0P/jp8HiO8LIECSjHEwXeeZpB9/gx5GLxL/uocimkMKn/BZOt+brOPbbYGayT+40UsYYGHUAnvrypprdKulJbQWlXg59RwUb6Q3mQK5KsH/WAY/9w7QfYiPq0Yvz7Nuyc4/iZRBugNdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673398; c=relaxed/simple;
	bh=P2EKbJ+3TteYOMAZm4XjWGh8HkRhZtHKv2489PYIALA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=AwI4sd4TBzYY/VAwL4B3UQRSKzi3x/FkxqM2UB5dkVSUumxTLRW+EomtuYFm9y2/BynuN0JzTNFUz4Xr9gO4sK6GI6Gy1MKXsdl7LBtrhUtiCC+v+ZbNOJNyVFFKeBtQCqFWPh0L8aYTnBjMOrdLL+w/ZwL1cLHi8QfPU677lZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 638IaXKW3338286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Apr 2026 18:36:34 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: <git@vger.kernel.org>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com> <20260408041716.GA1324339@coredump.intra.peff.net> <011701dcc767$8c2ab400$a4801c00$@nexbridge.com> <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com> <20260408173949.GB2850002@coredump.intra.peff.net>
In-Reply-To: <20260408173949.GB2850002@coredump.intra.peff.net>
Subject: RE: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Date: Wed, 8 Apr 2026 14:36:27 -0400
Organization: Nexbridge Inc.
Message-ID: <014801dcc786$9ff5bf60$dfe13e20$@nexbridge.com>
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
Thread-Index: AQIImllt8JGdGqh7Bu9hfV8wd5a54AFtvwh7AomCUMsCTyy1LAGZ2yzltT7VFiA=
X-Antivirus: Norton (VPS 260408-8, 4/8/2026), Outbound message
X-Antivirus-Status: Clean

On April 8, 2026 1:40 PM, Jeff King wrote:
>On Wed, Apr 08, 2026 at 12:25:47PM -0400, rsbecker@nexbridge.com wrote:
>
>> This is also impacting t5608 and t7700. Anywhere where writev() is
>> used, seemingly. We went through MAX_IO_SIZE issues years ago, =
instead
>> of using ssize_t as a basis of how big communication is. I think
>> writev() is not valid. It worked on Lunix, but had issues elsewhere.
>> This broke the compat layer.
>
>I wondered briefly if the problem could be that we're violating =
MAX_IO_SIZE here,
>as our use of writev() does not respect it at all. But the only spot =
that uses it is
>feeding pkt-line packets, which max out at 64k. So unless your =
MAX_IO_SIZE is
>smaller than that, I doubt that is the problem.

SSIZE_MAX on platform is 53248, so yes. We expected git-compat-util.h at =
line
696 to be honoured.

